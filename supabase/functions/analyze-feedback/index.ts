// Edge Function : analyse IA d'un feedback (sentiment + thèmes).
//
// Deux modes :
//   1. Heuristique locale (par défaut) : rapide, sans clé externe, adaptée au
//      contexte à faible connectivité. Combine la note normalisée et des
//      mots-clés FR/EN pour déduire le sentiment et les thèmes.
//   2. LLM (optionnel) : si la variable d'environnement OPENAI_API_KEY est
//      définie, on affine l'analyse via un modèle (voir callLLM ci-dessous).
//
// Déclenchement recommandé : Database Webhook sur INSERT de public.feedbacks
// (Dashboard → Database → Webhooks) pointant vers cette fonction, ou appel
// manuel POST { "id": "<uuid>", "comment": "...", "rating_normalized": 40 }.
//
// Déploiement :
//   supabase functions deploy analyze-feedback --project-ref bwkqzmdodbewhbrvkzpv
//
// La fonction écrit avec la clé service_role (contourne la RLS en toute
// sécurité côté serveur uniquement).

import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

const SUPABASE_URL = Deno.env.get("SUPABASE_URL")!;
const SERVICE_ROLE = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!;
const OPENAI_API_KEY = Deno.env.get("OPENAI_API_KEY");

const NEGATIVE = [
  "sale", "attente", "lent", "cher", "arnaque", "impoli", "mauvais", "nul",
  "panne", "casse", "corruption", "danger", "insalubre", "retard", "refus",
  "bad", "dirty", "slow", "rude", "broken", "scam",
];
const POSITIVE = [
  "propre", "rapide", "accueil", "gentil", "excellent", "parfait", "merci",
  "efficace", "souriant", "professionnel", "clean", "fast", "great", "good",
];
const THEME_MAP: Record<string, string[]> = {
  proprete: ["propre", "sale", "insalubre", "hygiene", "clean", "dirty"],
  attente: ["attente", "lent", "retard", "file", "queue", "slow", "wait"],
  accueil: ["accueil", "impoli", "gentil", "souriant", "rude", "staff"],
  prix: ["cher", "prix", "tarif", "arnaque", "cost", "price", "scam"],
  securite: ["danger", "securite", "vol", "corruption", "safety"],
  equipement: ["panne", "casse", "materiel", "broken", "equipment"],
};

function analyze(comment: string, rating: number) {
  const text = (comment || "").toLowerCase();
  let score = 0;
  for (const w of POSITIVE) if (text.includes(w)) score++;
  for (const w of NEGATIVE) if (text.includes(w)) score--;
  // La note pèse aussi (0-100).
  if (rating >= 70) score++;
  if (rating > 0 && rating <= 40) score--;

  const sentiment = score > 0 ? "positive" : score < 0 ? "negative" : "neutral";

  const themes: string[] = [];
  for (const [theme, words] of Object.entries(THEME_MAP)) {
    if (words.some((w) => text.includes(w))) themes.push(theme);
  }
  return { sentiment, themes };
}

async function callLLM(comment: string): Promise<{ sentiment: string; themes: string[] } | null> {
  if (!OPENAI_API_KEY) return null;
  try {
    const res = await fetch("https://api.openai.com/v1/chat/completions", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${OPENAI_API_KEY}`,
      },
      body: JSON.stringify({
        model: "gpt-4o-mini",
        messages: [
          {
            role: "system",
            content:
              "Analyse un feedback citoyen. Réponds en JSON strict " +
              '{"sentiment":"positive|neutral|negative","themes":["..."]}',
          },
          { role: "user", content: comment },
        ],
        temperature: 0,
      }),
    });
    const data = await res.json();
    const parsed = JSON.parse(data.choices[0].message.content);
    return parsed;
  } catch (_e) {
    return null; // repli sur l'heuristique
  }
}

Deno.serve(async (req) => {
  try {
    const payload = await req.json();
    // Compatible avec un Database Webhook ({ record }) ou un appel direct.
    const row = payload.record ?? payload;
    const id: string | undefined = row.id;
    const comment: string = row.comment ?? "";
    const rating: number = Number(row.rating_normalized ?? 0);

    if (!id) {
      return new Response(JSON.stringify({ error: "id manquant" }), {
        status: 400,
        headers: { "Content-Type": "application/json" },
      });
    }

    const result = (await callLLM(comment)) ?? analyze(comment, rating);

    const supabase = createClient(SUPABASE_URL, SERVICE_ROLE);
    const { error } = await supabase
      .from("feedbacks")
      .update({ sentiment: result.sentiment, themes: result.themes })
      .eq("id", id);

    if (error) throw error;

    return new Response(JSON.stringify({ id, ...result }), {
      headers: { "Content-Type": "application/json" },
    });
  } catch (e) {
    return new Response(JSON.stringify({ error: String(e) }), {
      status: 500,
      headers: { "Content-Type": "application/json" },
    });
  }
});

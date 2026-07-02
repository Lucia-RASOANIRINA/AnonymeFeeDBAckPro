// Edge Function : envoi de notifications push via Firebase Cloud Messaging (FCM
// HTTP v1). Utilisée pour prévenir un citoyen d'une réponse admin ou de la
// publication d'une amélioration.
//
// Prérequis (variables d'environnement de la fonction) :
//   FCM_PROJECT_ID           : id du projet Firebase
//   FCM_CLIENT_EMAIL         : service account (client_email)
//   FCM_PRIVATE_KEY          : service account (private_key, \n échappés)
//
// Corps attendu : { "token": "<fcm_device_token>", "title": "...", "body": "..." }
//
// Déploiement :
//   supabase functions deploy send-push --project-ref bwkqzmdodbewhbrvkzpv
//
// Côté mobile, l'app doit s'enregistrer (firebase_messaging) et stocker le
// token de l'appareil ; l'admin déclenche cette fonction lors d'une réponse.

import { create, getNumericDate } from "https://deno.land/x/djwt@v3.0.2/mod.ts";

const PROJECT_ID = Deno.env.get("FCM_PROJECT_ID")!;
const CLIENT_EMAIL = Deno.env.get("FCM_CLIENT_EMAIL")!;
const PRIVATE_KEY = (Deno.env.get("FCM_PRIVATE_KEY") ?? "").replace(/\\n/g, "\n");

async function getAccessToken(): Promise<string> {
  // Importe la clé privée RSA (PKCS8) du service account.
  const pem = PRIVATE_KEY
    .replace("-----BEGIN PRIVATE KEY-----", "")
    .replace("-----END PRIVATE KEY-----", "")
    .replace(/\s/g, "");
  const der = Uint8Array.from(atob(pem), (c) => c.charCodeAt(0));
  const key = await crypto.subtle.importKey(
    "pkcs8",
    der,
    { name: "RSASSA-PKCS1-v1_5", hash: "SHA-256" },
    false,
    ["sign"],
  );

  const jwt = await create(
    { alg: "RS256", typ: "JWT" },
    {
      iss: CLIENT_EMAIL,
      scope: "https://www.googleapis.com/auth/firebase.messaging",
      aud: "https://oauth2.googleapis.com/token",
      exp: getNumericDate(3600),
      iat: getNumericDate(0),
    },
    key,
  );

  const res = await fetch("https://oauth2.googleapis.com/token", {
    method: "POST",
    headers: { "Content-Type": "application/x-www-form-urlencoded" },
    body: new URLSearchParams({
      grant_type: "urn:ietf:params:oauth:grant-type:jwt-bearer",
      assertion: jwt,
    }),
  });
  const data = await res.json();
  return data.access_token;
}

Deno.serve(async (req) => {
  try {
    const { token, title, body } = await req.json();
    if (!token) {
      return new Response(JSON.stringify({ error: "token manquant" }), {
        status: 400,
      });
    }

    const accessToken = await getAccessToken();
    const res = await fetch(
      `https://fcm.googleapis.com/v1/projects/${PROJECT_ID}/messages:send`,
      {
        method: "POST",
        headers: {
          Authorization: `Bearer ${accessToken}`,
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          message: {
            token,
            notification: { title: title ?? "FeedbackPro", body: body ?? "" },
          },
        }),
      },
    );
    const result = await res.json();
    return new Response(JSON.stringify(result), {
      status: res.ok ? 200 : 502,
      headers: { "Content-Type": "application/json" },
    });
  } catch (e) {
    return new Response(JSON.stringify({ error: String(e) }), { status: 500 });
  }
});

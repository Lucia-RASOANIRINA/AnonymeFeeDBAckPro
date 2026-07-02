# Edge Functions FeedbackPro

Fonctions serverless (Deno) déployées sur Supabase.

| Fonction | Rôle | Déclenchement |
|----------|------|---------------|
| `analyze-feedback` | Analyse IA : sentiment + thèmes d'un feedback | Database Webhook `INSERT feedbacks` ou appel direct |
| `send-push` | Notification push FCM (réponse admin, amélioration) | Appelée par l'admin |

## Déploiement

```bash
supabase login
supabase link --project-ref bwkqzmdodbewhbrvkzpv
supabase functions deploy analyze-feedback
supabase functions deploy send-push
```

## Variables d'environnement (secrets)

```bash
# analyse IA (LLM optionnel — sinon heuristique locale)
supabase secrets set OPENAI_API_KEY=sk-...

# notifications push (service account Firebase)
supabase secrets set FCM_PROJECT_ID=... FCM_CLIENT_EMAIL=... FCM_PRIVATE_KEY="-----BEGIN PRIVATE KEY-----\n...\n-----END PRIVATE KEY-----\n"
```

`SUPABASE_URL` et `SUPABASE_SERVICE_ROLE_KEY` sont fournis automatiquement à
l'exécution des fonctions.

## Intégration mobile des notifications

Le mobile doit ajouter `firebase_messaging`, s'enregistrer au démarrage, et
stocker le token de l'appareil pour que l'admin puisse cibler l'envoi via
`send-push`. Étapes :

1. `flutter pub add firebase_core firebase_messaging`
2. Ajouter `google-services.json` dans `android/app/`.
3. Récupérer le token (`FirebaseMessaging.instance.getToken()`) et l'associer à
   l'`anon_code` (table dédiée `device_tokens`).

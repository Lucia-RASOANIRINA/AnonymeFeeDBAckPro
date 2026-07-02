# AnonyFeedback Pro — Web Admin (Next.js 15)

Plateforme d'administration des retours anonymes : connexion sécurisée,
tableau de bord, modération, alertes, gestion des établissements.

- **Next.js 15** (App Router) + **TypeScript** + **Tailwind CSS**
- **@supabase/ssr** pour l'auth (Email + Mot de passe) et l'accès aux données
- **recharts** pour les graphiques interactifs

## Démarrage

```bash
cd web_admin
npm install
cp .env.local.example .env.local   # renseigne URL + anon key Supabase
npm run dev                         # http://localhost:3000
```

## Identifiants admin par défaut
`admin@gmail.com` / `Lucia@1707`

À créer une seule fois :
1. Supabase → Authentication → Users → **Add user** (email + mot de passe ci-dessus).
2. Récupère son `uuid`, puis en SQL :
   ```sql
   insert into public.admins (user_id, role, display_name)
   values ('<uuid>', 'super_admin', 'Administrateur');
   ```

## Structure
```
src/
├── middleware.ts            # protège /dashboard, redirige vers /login
├── lib/supabase/
│   ├── client.ts            # client navigateur
│   └── server.ts            # client serveur (cookies)
└── app/
    ├── login/page.tsx       # connexion email/mot de passe
    ├── auth/signout/route.ts
    └── dashboard/
        ├── layout.tsx       # barre latérale + garde d'auth
        ├── page.tsx         # KPIs + graphique d'évolution
        ├── feedbacks/       # liste & modération
        ├── alerts/          # alertes intelligentes
        └── establishments/  # gestion des établissements
```

## À étendre (V2 complète)
- Éditeur visuel de templates de formulaires
- Heatmap interactive globale (carte des problèmes)
- Export CSV / Excel / PDF + rapports automatisés
- Gestion fine des rôles (Super Admin / Admin Domaine / Modérateur)
- Conversations 2-way en temps réel (Supabase Realtime)
- Comparaison entre établissements, tendances avancées

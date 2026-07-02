# AnonyFeedback Pro v2.0.0 — Planning détaillé sur 30 jours

Hypothèse : 1 développeur full-stack (mobile Flutter + web Next.js + Supabase),
journées de ~6 h effectives. Découpage en 6 sprints de 5 jours.

## Sprint 1 — Fondations & Backend (J1–J5)
| Jour | Objectif | Livrables |
|------|----------|-----------|
| J1 | Cadrage, création projet Supabase, repo Git | Projet Supabase, repos mobile + web |
| J2 | Schéma PostgreSQL (tables principales) | `0001_init.sql` exécuté |
| J3 | RLS anonymat + buckets Storage | `0002_storage.sql`, politiques testées |
| J4 | Migration V2 (statuts, priorité, FTS) | `0003_v2.sql` |
| J5 | Triggers (alertes, validation, audit) | Triggers testés en SQL |

## Sprint 2 — App Mobile : socle offline-first (J6–J10)
| Jour | Objectif | Livrables |
|------|----------|-----------|
| J6 | Architecture Flutter (Riverpod, couches) | Squelette `lib/` |
| J7 | Auth anonyme + Splash + thèmes | Auth anonyme fonctionnelle |
| J8 | Isar (modèles + service) + multilingue mg/fr/en | Base locale, i18n instantané |
| J9 | Accueil (recherche, secteurs, sync banner) | Écran d'accueil |
| J10 | Synchronisation offline-first | Worker de sync + connectivité |

## Sprint 3 — Formulaire intelligent & QR (J11–J15)
| Jour | Objectif | Livrables |
|------|----------|-----------|
| J11 | Formulaire de base (notation, commentaire) | Écran feedback |
| J12 | **Validation temps réel + logique conditionnelle** | Moteur de règles |
| J13 | Photos/vidéo compressées + upload | Médias |
| J14 | GPS + carte interactive (flutter_map) | Localisation |
| J15 | Scan & génération de QR codes | QR fonctionnel |

## Sprint 4 — Web Admin Next.js (J16–J20)
| Jour | Objectif | Livrables |
|------|----------|-----------|
| J16 | Setup Next.js 15 + Tailwind + @supabase/ssr | Projet web |
| J17 | Login email/mot de passe + middleware auth | Auth admin |
| J18 | Dashboard KPIs + graphiques (recharts) | Tableau de bord |
| J19 | Liste feedbacks + filtres + modération | Modération |
| J20 | Alertes + gestion établissements + QR | Espaces admin |

## Sprint 5 — Fonctionnalités V2 avancées (J21–J25)
| Jour | Objectif | Livrables |
|------|----------|-----------|
| J21 | Conversations 2-way temps réel (Realtime) | Chat anonyme |
| J22 | Notifications push (FCM + Edge Function) | Push |
| J23 | Suivi de statut + priorité + audit | Workflow complet |
| J24 | Heatmap globale + stats publiques | Carte + transparence |
| J25 | Export CSV/Excel/PDF + IA (sentiment/actions) | Exports + IA simple |

## Sprint 6 — Qualité, sécurité, livraison (J26–J30)
| Jour | Objectif | Livrables |
|------|----------|-----------|
| J26 | Speech-to-text + traduction auto | Saisie vocale + i18n auto |
| J27 | Accessibilité, mode express, polish UI/UX | UX finalisée |
| J28 | Tests (unitaires règles, widgets, RLS) | Suite de tests |
| J29 | Optimisation perf + taille APK + durcissement RLS | Build optimisé |
| J30 | Build APK release, déploiement web (Vercel), doc | Livraison v2.0.0 |

## Jalons clés
- **J5** : backend prêt. **J15** : app mobile MVP. **J20** : admin MVP.
- **J25** : toutes les fonctionnalités V2. **J30** : version livrable.

# FeedbackPro

Système de **retours anonymes** pour l'amélioration continue des services publics
(écoles, hôpitaux, administrations, commerces, transports…), orienté contexte
malgache et africain.

- **Frontend** : Flutter 3.44+ (Android + Web pour le dashboard admin)
- **Backend** : Supabase (Auth anonyme, PostgreSQL, Storage, Realtime, Edge Functions)
- **Base locale** : Isar (`isar_community`) — offline-first total
- **État** : Riverpod 3 (architecture en couches)
- **Multilingue** : Malgache 🇲🇬 (prioritaire), Français, Anglais — changement instantané
- **Cartes** : `flutter_map` + OpenStreetMap (libre, léger, sans clé API)

> Optimisé pour les appareils Android d'entrée de gamme et les connexions à
> faible bande passante (compression photo agressive, tuiles OSM, UI sobre).

---

## 1. Structure des dossiers

```
lib/
├── main.dart                  # Init Supabase + Isar + Riverpod
├── app.dart                   # MaterialApp (thème, langue, accessibilité)
├── core/
│   ├── config/                # supabase_config, app_config
│   ├── constants/             # app_constants, sectors (templates secteurs)
│   ├── theme/                 # app_colors, app_theme (clair/sombre/contraste)
│   ├── localization/          # app_strings (mg/fr/en, instantané)
│   ├── router/                # app_router (go_router)
│   ├── network/               # connectivity_service
│   └── utils/                 # location_helper, ...
├── data/
│   ├── models/                # FeedbackLocal, EstablishmentLocal (Isar)
│   ├── datasources/
│   │   ├── local/             # isar_service
│   │   └── remote/            # supabase_service
│   └── repositories/          # feedback_repository (offline-first + sync)
├── domain/                    # entités / interfaces (extensible)
├── features/
│   ├── splash/                # auth anonyme automatique
│   ├── auth/                  # session anonyme
│   ├── home/                  # accueil : recherche, secteurs, scan
│   ├── feedback/              # formulaire riche + GPS/carte
│   ├── qr_scanner/            # scan QR -> établissement
│   ├── improvements/          # page publique avant/après
│   ├── history/               # historique local
│   ├── settings/              # langue, thème, accessibilité
│   └── admin/                 # dashboard (stats, modération, export)
└── shared/
    ├── providers/             # settings, sync
    └── widgets/

supabase/
├── migrations/                # 0001_init.sql (schéma + RLS), 0002_storage.sql
└── functions/                 # Edge Functions (analyse IA, notifications…)
```

## 2. Configuration Supabase

1. Crée un projet sur https://supabase.com
2. Dans **SQL Editor**, exécute dans l'ordre :
   - `supabase/migrations/0001_init.sql` (tables + RLS anonymat)
   - `supabase/migrations/0002_storage.sql` (buckets photos)
3. Active **Anonymous sign-ins** : Authentication → Providers → Anonymous → ON
4. Pour te désigner admin : crée un compte, récupère son `uuid`
   (Authentication → Users), puis :
   ```sql
   insert into public.admins (user_id) values ('<ton-uuid>');
   ```
5. Récupère l'URL et la clé `anon` (Project Settings → API).

### Anonymat (RLS)
- `feedbacks` ne stocke **aucun** identifiant utilisateur ; suivi via `anon_code`.
- Insertion ouverte aux sessions anonymes ; lecture/modération réservées aux admins.
- Conversations 2-way via la RPC `get_conversation(anon_code)`.

## 3. Lancer le projet — étapes pas à pas (Android Studio + émulateur Pixel 9)

> Toutes les commandes se lancent depuis la racine du projet `D:\Lucia`
> (terminal de VS Code / Android Studio, ou PowerShell).

### Étape 0 — Vérifier l'environnement
```bash
flutter --version      # doit afficher Flutter 3.44+ / Dart 3.12+
flutter doctor         # tout doit être ✓ (Android toolchain + un device)
```

### Étape 1 — Récupérer les dépendances
```bash
cd D:\Lucia
flutter pub get
```

### Étape 2 — Générer le code Isar (obligatoire la 1ʳᵉ fois)
Crée les fichiers `*.g.dart` des modèles locaux. **Sans ça, ça ne compile pas.**
```bash
dart run build_runner build --delete-conflicting-outputs
```

### Étape 3 — Renseigner les clés Supabase
Deux options (choisis-en **une**) :

- **Option A (simple)** — éditer `lib/core/config/supabase_config.dart` et
  remplacer `url` et `anonKey` par tes valeurs (Supabase → Project Settings → API).
- **Option B (recommandée)** — passer les clés au lancement via `--dart-define`
  (voir étape 5).

> ⚠️ Tant que les clés ne sont pas valides, l'app démarre quand même (mode
> offline-first) : tu peux tester l'UI, mais l'envoi vers Supabase échouera.

### Étape 4 — Démarrer l'émulateur Pixel 9
Dans Android Studio : **Device Manager → ▶** sur le Pixel 9.
Puis vérifie qu'il est bien détecté :
```bash
flutter devices       # le Pixel 9 (emulator-5554) doit apparaître
```

### Étape 5 — Lancer l'application
```bash
flutter run -d emulator-5554 ^
  --dart-define=SUPABASE_URL=https://xxxx.supabase.co ^
  --dart-define=SUPABASE_ANON_KEY=eyJhbGci...
```
(Sous PowerShell, remplace les `^` de fin de ligne par un backtick `` ` ``,
ou mets tout sur une seule ligne. Sans `--dart-define`, garde l'Option A.)

Dans Android Studio tu peux aussi simplement choisir `lib/main.dart` comme cible,
sélectionner le Pixel 9, puis cliquer ▶ Run.

### Dashboard admin en Web
```bash
flutter run -d chrome
```

---

## 3 bis. Dépannage (Windows)

**Build Android qui échoue avec « Could not close incremental caches … .tab »**
C'est un verrou de fichiers Kotlin (antivirus / indexation du dossier `build`).
Déjà corrigé via `android/gradle.properties` (`kotlin.incremental=false`).
Si ça revient :
```bash
flutter clean
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run
```
Et, si besoin, exclure `D:\Lucia\build` de l'analyse en temps réel de Windows
Defender (Sécurité Windows → Protection contre les virus → Exclusions).

**Première build longue** : normal (téléchargement Gradle + NDK). Les suivantes
sont rapides. Ne coupe pas la connexion pendant le 1ᵉʳ `flutter run`.

**`build_runner` introuvable** : relance `flutter pub get` puis l'étape 2.

**Erreurs « integer literal … can't be represented exactly in JavaScript »**
Tu lances l'app **mobile sur le Web (Chrome/Edge)**. ❌ Isar est une base
**mobile uniquement** (Android/iOS) — l'app de feedback ne se compile pas sur le
Web. Lance-la sur l'émulateur :
```bash
flutter run -d emulator-5554
```
> Le Web est réservé au **dashboard admin** (qui lit Supabase, sans Isar). Pour
> le servir sur le Web, il faudra un point d'entrée séparé excluant Isar
> (conditional imports) — à mettre en place si besoin.

**Émulateur bloqué sur `offline` / « emulator exited with code 1 »**
Snapshot d'AVD corrompu ou instance zombie. Nettoie et redémarre en *cold boot* :
```powershell
$adb = "$env:LOCALAPPDATA\Android\Sdk\platform-tools\adb.exe"
$emu = "$env:LOCALAPPDATA\Android\Sdk\emulator\emulator.exe"
& $adb -s emulator-5554 emu kill
Get-Process | ? { $_.ProcessName -match 'qemu|emulator' } | Stop-Process -Force
& $emu -avd Pixel_9 -no-snapshot-load -gpu swiftshader_indirect -no-boot-anim
```
Puis attends `adb devices` → `emulator-5554  device` avant `flutter run`.

**Build échoue avec « Could not download kotlin-compiler-XX.jar » /
« Connection timed out » / « Got socket exception … dl.google.com »**
👉 C'est un **problème de réseau**, pas le code. Gradle n'a pas pu télécharger
un artefact depuis `dl.google.com`. Marche à suivre :
1. Vérifie que ta connexion est **stable** (le Wi‑Fi/4G doit tenir tout le 1ᵉʳ build).
2. Relance simplement :
   ```bash
   flutter run
   ```
   Gradle reprend les téléchargements déjà faits depuis son cache (`~/.gradle`),
   donc chaque essai progresse un peu plus loin.
3. Si ça coupe souvent, force les nouvelles tentatives Gradle :
   ```bash
   cd android
   gradlew assembleDebug --stacktrace
   cd ..
   ```
4. Derrière un proxy/pare‑feu d'entreprise ou une connexion filtrant le SSL,
   configure le proxy Gradle dans `%USERPROFILE%\.gradle\gradle.properties` :
   ```properties
   systemProp.https.proxyHost=ton.proxy
   systemProp.https.proxyPort=8080
   ```
> Une fois les artefacts téléchargés (une seule fois), les builds suivantes
> fonctionnent même hors ligne.

**Avertissement « plugins that apply Kotlin Gradle Plugin (KGP) … »**
👉 Simple *warning* de Flutter (compatibilité future), **non bloquant**. Tu peux
l'ignorer ; il ne fait pas échouer le build.

### Identifiants Supabase
`lib/core/config/supabase_config.dart` :
- 1ᵉʳ argument de `String.fromEnvironment(...)` = **nom** de la variable
  `--dart-define` (`SUPABASE_URL`, `SUPABASE_ANON_KEY`), **jamais** la valeur.
- La valeur va dans `defaultValue`.
- L'URL est l'URL **de base** du projet (`https://xxxx.supabase.co`),
  **sans** `/rest/v1/`.

## 4. Packages principaux (voir `pubspec.yaml`)

flutter_riverpod · supabase_flutter · isar_community (+flutter_libs/generator) ·
go_router · mobile_scanner · geolocator · flutter_map + latlong2 ·
image_picker · flutter_image_compress · connectivity_plus · cached_network_image ·
fl_chart · qr_flutter · csv · excel · intl · flutter_localizations.

## 5. Reste à brancher (stubs documentés)

- Edge Function d'**analyse IA** (sentiment, thèmes) → remplit `feedbacks.sentiment/themes`
- **Notifications push** (FCM + Edge Function) pour réponses et améliorations
- Écran de **conversation 2-way** (utilise la RPC `get_conversation`)
- **Export CSV/Excel** côté admin (packages `csv`/`excel` déjà présents)
- **Mobile Money** (MVola / Orange / Airtel) pour récompenses optionnelles
- **Heatmap** des problèmes géolocalisés (flutter_map + clustering)

# -*- coding: utf-8 -*-
"""Generateur de la documentation PDF de FeedbackPro.

Documentation technique et conceptuelle complete : toutes les fonctionnalites et
tous les diagrammes (architecture, classes, cas d'utilisation, sequence,
synchronisation Isar<->Supabase, deploiement).

Contraintes de redaction :
- le mot "version" n'est jamais employe (on parle d'edition, de palier, de socle) ;
- texte compatible latin-1 (police du coeur Helvetica, pas de guillemets typographiques).

Dependance : fpdf2 (`pip install fpdf2`).
"""
from fpdf import FPDF

BRAND = (27, 122, 67)     # #1B7A43
DARK = (14, 92, 48)       # #0E5C30
GRAY = (90, 90, 90)
LIGHT = (231, 243, 236)   # #E7F3EC
GOLD = (244, 180, 0)      # #F4B400
INK = (30, 30, 30)

TITLE = "FeedbackPro"
SUBTITLE = "Documentation technique et conceptuelle"


# ----------------------------------------------------------------------------
# Logo vectoriel (dessine directement, sans dependance image)
# ----------------------------------------------------------------------------
def draw_logo(pdf, x, y, s, on_dark=False):
    """Dessine l'icone FeedbackPro : carre de marque, bulle blanche, barres de
    satisfaction ascendantes et pastille d'evaluation. `s` = cote de l'icone."""
    # Fond carre (arrondi si supporte)
    pdf.set_fill_color(*(255, 255, 255) if on_dark else BRAND)
    try:
        pdf.rect(x, y, s, s, round_corners=True, style="F")
    except TypeError:
        pdf.rect(x, y, s, s, "F")
    icon = (BRAND if on_dark else (255, 255, 255))
    # Bulle de feedback
    pdf.set_fill_color(*icon)
    bx, by, bw, bh = x + 0.14 * s, y + 0.18 * s, 0.72 * s, 0.46 * s
    try:
        pdf.rect(bx, by, bw, bh, round_corners=True, style="F")
    except TypeError:
        pdf.rect(bx, by, bw, bh, "F")
    # Petite queue de la bulle
    pdf.set_line_width(0.1)
    pts = [(x + 0.30 * s, by + bh - 0.02 * s),
           (x + 0.30 * s, by + bh + 0.14 * s),
           (x + 0.46 * s, by + bh - 0.02 * s)]
    pdf.polygon(pts, style="F")
    # Barres de satisfaction : contraste avec la bulle
    bar = (255, 255, 255) if on_dark else BRAND
    pdf.set_fill_color(*bar)
    base = by + bh - 0.06 * s
    for i, h in enumerate((0.12, 0.20, 0.28)):
        bxx = x + 0.24 * s + i * 0.18 * s
        pdf.rect(bxx, base - h * s, 0.10 * s, h * s, "F")
    # Pastille d'evaluation (or)
    pdf.set_fill_color(*GOLD)
    pdf.ellipse(x + 0.60 * s, y + 0.14 * s, 0.10 * s, 0.10 * s, "F")


# ----------------------------------------------------------------------------
# Document
# ----------------------------------------------------------------------------
class Doc(FPDF):
    def header(self):
        if self.page_no() == 1:
            return
        draw_logo(self, self.l_margin, 9, 7)
        self.set_xy(self.l_margin + 10, 10)
        self.set_font("Helvetica", "B", 9)
        self.set_text_color(*DARK)
        self.cell(0, 6, "FeedbackPro", align="L")
        self.set_xy(self.l_margin, 10)
        self.set_font("Helvetica", "", 8)
        self.set_text_color(*GRAY)
        self.cell(0, 6, "Documentation technique", align="R",
                  new_x="LMARGIN", new_y="NEXT")
        self.set_draw_color(*BRAND)
        self.set_line_width(0.3)
        self.line(self.l_margin, 18, self.w - self.r_margin, 18)
        self.set_xy(self.l_margin, 24)

    def footer(self):
        if self.page_no() == 1:
            return
        self.set_y(-15)
        self.set_draw_color(220, 230, 222)
        self.set_line_width(0.2)
        self.line(self.l_margin, self.h - 16, self.w - self.r_margin, self.h - 16)
        self.set_font("Helvetica", "", 8)
        self.set_text_color(*GRAY)
        self.cell(0, 10, f"FeedbackPro  -  Page {self.page_no() - 1}", align="C")

    def h1(self, text):
        self.start_section(text)
        self.set_x(self.l_margin)
        self.ln(2)
        self.set_font("Helvetica", "B", 18)
        self.set_text_color(*DARK)
        self.multi_cell(0, 9, text)
        self.set_draw_color(*BRAND)
        self.set_line_width(0.5)
        y = self.get_y() + 1
        self.line(self.l_margin, y, self.l_margin + 40, y)
        self.ln(5)

    def h2(self, text):
        self.start_section(text, level=1)
        self.set_x(self.l_margin)
        self.ln(1)
        self.set_font("Helvetica", "B", 13)
        self.set_text_color(*BRAND)
        self.multi_cell(0, 7, text)
        self.ln(1)

    def body(self, text):
        self.set_x(self.l_margin)
        self.set_font("Helvetica", "", 11)
        self.set_text_color(*INK)
        self.multi_cell(0, 6, text)
        self.ln(2)

    def bullet(self, text):
        self.set_x(self.l_margin)
        self.set_font("Helvetica", "", 11)
        x = self.get_x()
        self.set_text_color(*BRAND)
        self.cell(6, 6, chr(149))
        self.set_text_color(*INK)
        self.multi_cell(0, 6, text)
        self.set_x(x)

    def kv(self, key, value):
        self.set_x(self.l_margin)
        self.set_font("Helvetica", "B", 11)
        self.set_text_color(*DARK)
        self.cell(45, 6, key, new_x="RIGHT", new_y="TOP")
        self.set_font("Helvetica", "", 11)
        self.set_text_color(*INK)
        self.multi_cell(0, 6, value)

    def note(self, text):
        """Encadre d'information (fond clair)."""
        self.set_x(self.l_margin)
        y0 = self.get_y()
        self.set_font("Helvetica", "", 10)
        self.set_text_color(*INK)
        # mesure de hauteur
        lines = self.multi_cell(self.epw - 8, 5.5, text, dry_run=True, output="LINES")
        h = 5.5 * len(lines) + 6
        self.set_fill_color(*LIGHT)
        self.set_draw_color(*BRAND)
        try:
            self.rect(self.l_margin, y0, self.epw, h, round_corners=True, style="DF")
        except TypeError:
            self.rect(self.l_margin, y0, self.epw, h, "DF")
        self.set_draw_color(*BRAND)
        self.set_line_width(1.2)
        self.line(self.l_margin, y0 + 1, self.l_margin, y0 + h - 1)
        self.set_xy(self.l_margin + 5, y0 + 3)
        self.set_text_color(*DARK)
        self.multi_cell(self.epw - 8, 5.5, text)
        self.set_y(y0 + h + 3)


def box(pdf, x, y, w, title, lines, fill=(248, 250, 248), title_bg=BRAND):
    """Boite generique titre + lignes, utilisee par les diagrammes."""
    pdf.set_draw_color(*BRAND)
    pdf.set_line_width(0.3)
    pdf.set_fill_color(*title_bg)
    pdf.rect(x, y, w, 7, "DF")
    pdf.set_xy(x, y + 0.7)
    pdf.set_font("Helvetica", "B", 8.5)
    pdf.set_text_color(255, 255, 255)
    pdf.cell(w, 6, title, align="C")
    bh = 4.6 * len(lines) + 3
    pdf.set_fill_color(*fill)
    pdf.rect(x, y + 7, w, bh, "DF")
    pdf.set_font("Helvetica", "", 7.6)
    pdf.set_text_color(*INK)
    for i, ln in enumerate(lines):
        pdf.set_xy(x + 2, y + 8.4 + i * 4.6)
        pdf.cell(w - 4, 4.6, ln)
    return 7 + bh


def arrow(pdf, x1, y1, x2, y2, color=GRAY):
    import math
    pdf.set_draw_color(*color)
    pdf.set_line_width(0.4)
    pdf.line(x1, y1, x2, y2)
    ang = math.atan2(y2 - y1, x2 - x1)
    a = 2.2
    for da in (2.6, -2.6):
        pdf.line(x2, y2,
                 x2 - a * math.cos(ang - da / 6 - 0.4) * 1.4,
                 y2 - a * math.sin(ang - da / 6 - 0.4) * 1.4)
    # fleche simple : deux petits traits
    pdf.set_fill_color(*color)
    pdf.polygon([
        (x2, y2),
        (x2 - 2.4 * math.cos(ang - 0.35), y2 - 2.4 * math.sin(ang - 0.35)),
        (x2 - 2.4 * math.cos(ang + 0.35), y2 - 2.4 * math.sin(ang + 0.35)),
    ], style="F")


def render_toc(pdf, outline):
    pdf.set_font("Helvetica", "B", 20)
    pdf.set_text_color(*DARK)
    pdf.cell(0, 12, "Table des matieres", new_x="LMARGIN", new_y="NEXT")
    pdf.ln(4)
    for s in outline:
        if s.level == 0:
            pdf.set_font("Helvetica", "B", 12)
            pdf.set_text_color(20, 20, 20)
            indent = 0
        else:
            pdf.set_font("Helvetica", "", 11)
            pdf.set_text_color(*GRAY)
            indent = 8
        label = s.name
        pdf.cell(indent)
        w = pdf.get_string_width(label) + 2
        pdf.cell(w, 8, label)
        dots_w = pdf.w - pdf.r_margin - pdf.get_x() - 12
        n = max(0, int(dots_w / pdf.get_string_width(".")))
        pdf.set_text_color(180, 180, 180)
        pdf.cell(dots_w, 8, "." * n)
        pdf.set_text_color(20, 20, 20)
        pdf.cell(12, 8, str(s.page_number), align="R", new_x="LMARGIN", new_y="NEXT")


pdf = Doc()
pdf.set_auto_page_break(auto=True, margin=20)
pdf.set_title("FeedbackPro - Documentation technique")
pdf.set_author("FeedbackPro")

# ---------------- COUVERTURE ----------------
pdf.add_page()
pdf.set_fill_color(*BRAND)
pdf.rect(0, 0, pdf.w, pdf.h, "F")
pdf.set_fill_color(*DARK)
pdf.rect(0, pdf.h - 40, pdf.w, 40, "F")


def center(txt, h, size, style="", ln=0, color=(255, 255, 255)):
    pdf.set_x(pdf.l_margin)
    pdf.set_font("Helvetica", style, size)
    pdf.set_text_color(*color)
    pdf.multi_cell(pdf.epw, h, txt, align="C")
    if ln:
        pdf.ln(ln)


# Logo centre en couverture
draw_logo(pdf, pdf.w / 2 - 17, 42, 34, on_dark=True)
pdf.set_y(84)
center(TITLE, 16, 40, "B")
center("Retours anonymes pour l'amelioration continue\ndes services publics et prives",
       8, 14, "", ln=18)
center(SUBTITLE, 7, 13)
center("Application mobile Flutter  -  Plateforme web Next.js  -  Supabase",
       7, 12, "", ln=26)
center("Espace admin identique sur mobile et web  -  Offline-first  -  Multilingue mg / fr / en",
       6, 11)
pdf.set_y(pdf.h - 32)
center("Contexte : Madagascar et Afrique", 6, 11)
center("Donner de la voix, ameliorer les services", 6, 10, "B")

# ---------------- TOC ----------------
pdf.add_page()
pdf.insert_toc_placeholder(render_toc, pages=2)

# ================= 1. INTRODUCTION =================
pdf.add_page()
pdf.h1("1. Introduction")
pdf.body(
    "FeedbackPro est une solution complete de collecte et de gestion de retours "
    "(feedbacks) totalement anonymes. Elle permet a tout citoyen de donner son "
    "avis sur n'importe quel service - ecole, hopital, clinique, boutique, "
    "restaurant, hotel, administration publique, transport - et aux responsables "
    "de suivre, analyser et agir rapidement grace a une plateforme web "
    "professionnelle et a un espace d'administration identique dans l'application "
    "mobile.")
pdf.body(
    "Ce palier apporte une evolution majeure : un formulaire intelligent avec "
    "validation en temps reel et logique conditionnelle forte selon le secteur et "
    "la note, une synchronisation locale-serveur fiable avec gestion des conflits, "
    "une recherche intelligente dont les resultats s'affichent directement dans "
    "l'accueil, un indicateur clair de la page active, un espace admin ou le "
    "responsable peut tout faire (moderation, publication, export, gestion des "
    "utilisateurs), et un logo de marque decline partout (splash, icone, en-tete, "
    "admin web).")
pdf.h2("1.1 Objectifs du document")
pdf.body(
    "Ce document presente l'analyse des besoins et des contraintes, justifie les "
    "choix technologiques et conceptuels, decrit la conception UML du systeme, "
    "detaille l'architecture et la synchronisation, catalogue l'ensemble des "
    "fonctionnalites, et conclut sur la valeur apportee et la feuille de route.")
pdf.h2("1.2 Public vise")
pdf.body(
    "Equipe de developpement, responsables d'etablissements, decideurs publics, "
    "ainsi que toute partie prenante interessee par l'amelioration continue des "
    "services par la voix citoyenne.")
pdf.h2("1.3 Identite visuelle")
pdf.body(
    "Le logo FeedbackPro combine une bulle de dialogue (le retour citoyen) et des "
    "barres ascendantes (la progression de la satisfaction), rehaussees d'une "
    "pastille doree d'evaluation. La couleur de marque est le vert (#1B7A43), "
    "symbole de confiance et de progres. Le logo est decline sur l'ecran de "
    "demarrage, l'icone d'application, les en-tetes et l'admin web.")

# ================= 2. ANALYSE DES BESOINS =================
pdf.add_page()
pdf.h1("2. Analyse des besoins")
pdf.h2("2.1 Besoins des utilisateurs (citoyens)")
for b in [
    "Soumettre un feedback totalement anonyme, sans creer de compte.",
    "Identifier l'etablissement concerne grace a une recherche intelligente.",
    "Noter un service (etoiles, echelle, smileys).",
    "Choisir un type de probleme adapte au secteur.",
    "Joindre des photos ou une courte video, et la localisation GPS si utile.",
    "Acceder rapidement a un etablissement via un QR code.",
    "Suivre l'avancement de son feedback et dialoguer de maniere anonyme.",
    "Utiliser l'application meme sans connexion (offline-first).",
    "Choisir sa langue : malgache, francais ou anglais.",
]:
    pdf.bullet(b)
pdf.ln(2)
pdf.h2("2.2 Besoins des responsables (admins)")
for b in [
    "Visualiser et filtrer tous les feedbacks par secteur, note, statut, date.",
    "Etre alerte immediatement en cas de feedback critique.",
    "Moderer, prioriser, changer le statut et publier des actions correctives.",
    "Gerer les etablissements et les ameliorations (creer, modifier, supprimer).",
    "Analyser les tendances : positifs / negatifs, evolution, comparaisons.",
    "Exporter les donnees (CSV, Excel, PDF) et garder un historique d'audit.",
    "Gerer plusieurs administrateurs avec des roles distincts.",
    "Disposer du meme espace admin sur mobile et sur le web.",
]:
    pdf.bullet(b)
pdf.ln(2)
pdf.h2("2.3 Besoins fonctionnels transverses")
pdf.body(
    "Validation et contraintes robustes en temps reel (mobile et web), gestion "
    "intelligente de la logique des formulaires, transparence via des "
    "statistiques publiques anonymisees, recherche instantanee dans l'accueil, "
    "interface totalement responsive et notifications push pertinentes.")

# ================= 3. ANALYSE DES CONTRAINTES =================
pdf.add_page()
pdf.h1("3. Analyse des contraintes")
pdf.h2("3.1 Anonymat maximal")
pdf.body(
    "Aucune donnee permettant d'identifier l'utilisateur ne doit etre stockee. "
    "La table des feedbacks ne contient aucun identifiant utilisateur : le suivi "
    "se fait via un code anonyme aleatoire connu du seul auteur. Les regles de "
    "securite au niveau des lignes (RLS) garantissent qu'un utilisateur ne peut "
    "jamais lire les feedbacks d'autrui.")
pdf.h2("3.2 Materiel modeste et faible bande passante")
pdf.body(
    "La cible inclut des telephones Android d'entree de gamme et des connexions "
    "instables. D'ou : compression agressive des images, cartes OpenStreetMap "
    "legeres, interface sobre, et surtout une architecture offline-first ou tout "
    "fonctionne hors ligne puis se synchronise automatiquement.")
pdf.h2("3.3 Fiabilite des donnees")
pdf.body(
    "Les regles metier sont appliquees a deux niveaux : cote client (validation "
    "temps reel dans le formulaire, avec logique conditionnelle selon secteur et "
    "note) et cote serveur (triggers PostgreSQL). La synchronisation est "
    "idempotente (identifiant client unique) et gere les conflits, garantissant "
    "la coherence de bout en bout.")
pdf.h2("3.4 Securite et roles")
pdf.body(
    "Authentification anonyme sur mobile, mais email / mot de passe pour les "
    "admins, avec gestion de roles (Super Admin, Admin de domaine, Moderateur) et "
    "journal d'audit de toutes les actions sensibles. Le compte administrateur de "
    "reference est luciarasoanirina8@gmail.com.")

# ================= 4. CHOIX DES TECHNOLOGIES =================
pdf.add_page()
pdf.h1("4. Arguments du choix des technologies")
pdf.kv("Flutter (mobile)",
       "Un seul code pour Android / iOS, performances natives, riche ecosysteme, "
       "ideal pour une UI moderne et fluide sur appareils modestes.")
pdf.ln(1)
pdf.kv("Supabase (backend)",
       "PostgreSQL manage + Auth + Storage + Realtime + Edge Functions. La "
       "securite par RLS est parfaite pour garantir l'anonymat. Open-source, "
       "evite le verrouillage proprietaire.")
pdf.ln(1)
pdf.kv("Isar (local)",
       "Base locale rapide et typee pour le mode offline-first ; lecture / "
       "ecriture instantanees sans connexion, synchronisation differee.")
pdf.ln(1)
pdf.kv("Riverpod",
       "Gestion d'etat moderne, testable, en couches ; rend le changement de "
       "langue et de theme instantane.")
pdf.ln(1)
pdf.kv("Next.js 15 (web)",
       "App Router + rendu serveur pour un tableau de bord rapide et securise ; "
       "TypeScript pour la fiabilite, Tailwind pour une UI soignee et responsive, "
       "recharts pour des graphiques interactifs.")
pdf.ln(1)
pdf.kv("flutter_map + OSM",
       "Cartographie libre, sans cle API ni cout, et legere en bande passante - "
       "adaptee au contexte local.")
pdf.ln(3)
pdf.body(
    "Ces choix forment une pile coherente, moderne, economique et adaptee aux "
    "contraintes de terrain (cout, connectivite, materiel).")

# ================= 5. MULTI-DOMAINES =================
pdf.add_page()
pdf.h1("5. Pourquoi couvrir tous les domaines plutot qu'un seul")
pdf.body(
    "Un choix structurant est de couvrir l'ensemble des secteurs (sante, "
    "education, commerce, administration, restauration / hotellerie, transport) "
    "plutot que de se limiter a un seul domaine. Les raisons :")
pdf.h2("5.1 Une seule application pour le citoyen")
pdf.body(
    "Le citoyen utilise une multitude de services au quotidien. Une application "
    "unique, multi-domaines, evite d'installer dix applications differentes et "
    "augmente fortement l'adoption et la frequence d'usage.")
pdf.h2("5.2 Effet de reseau et masse critique")
pdf.body(
    "Regrouper tous les secteurs cree une masse critique d'utilisateurs et de "
    "donnees. Plus il y a de retours, plus les statistiques sont fiables et plus "
    "la plateforme devient utile pour tous - un cercle vertueux qu'un produit "
    "mono-domaine atteint difficilement.")
pdf.h2("5.3 Mutualisation technique et reduction des couts")
pdf.body(
    "L'infrastructure (anonymat, offline, synchronisation, moderation, cartes, "
    "exports) est commune a tous les secteurs. La mutualiser reduit fortement le "
    "cout de developpement et de maintenance, tout en assurant une experience "
    "homogene.")
pdf.h2("5.4 Comparaison inter-secteurs et pilotage public")
pdf.body(
    "Couvrir tous les domaines permet des analyses transversales (comparer par "
    "exemple la satisfaction entre hopitaux et administrations d'une meme region) "
    "- une valeur strategique pour les decideurs publics, impossible avec une "
    "approche cloisonnee.")
pdf.h2("5.5 Adaptabilite par templates")
pdf.body(
    "La generalite ne nuit pas a la pertinence : des templates de questionnaires "
    "specifiques par secteur, et un formulaire a logique conditionnelle, adaptent "
    "l'experience a chaque domaine tout en gardant un socle commun.")

# ================= 6. ARCHITECTURE GENERALE =================
pdf.add_page()
pdf.h1("6. Architecture generale")
pdf.body(
    "FeedbackPro s'organise en trois grands blocs : le client mobile Flutter "
    "(offline-first), le backend Supabase (source de verite), et la plateforme "
    "web Next.js. L'espace admin est disponible a la fois dans le mobile et sur "
    "le web, avec le meme design et les memes fonctionnalites.")
y0 = pdf.get_y() + 2
# Bloc mobile
box(pdf, 18, y0, 58, "Mobile Flutter",
    ["UI / ecrans", "Riverpod (etat)", "Repository", "Isar (local)", "Sync service"])
# Bloc backend (centre)
box(pdf, 84, y0, 58, "Supabase",
    ["Auth (anonyme)", "PostgreSQL + RLS", "Storage (medias)", "Realtime", "Edge Functions"],
    fill=LIGHT)
# Bloc web
box(pdf, 150, y0, 44, "Web Next.js",
    ["Admin SSR", "Recherche", "Graphiques", "Exports"])
# fleches
midy = y0 + 16
arrow(pdf, 76, midy, 84, midy, BRAND)
arrow(pdf, 84, midy + 4, 76, midy + 4, GRAY)
arrow(pdf, 150, midy, 142, midy, BRAND)
arrow(pdf, 142, midy + 4, 150, midy + 4, GRAY)
pdf.set_y(y0 + 42)
pdf.set_font("Helvetica", "I", 8)
pdf.set_text_color(*GRAY)
pdf.multi_cell(0, 5, "Le mobile ecrit d'abord en local (Isar) puis synchronise "
                     "vers Supabase ; l'admin mobile et l'admin web lisent la "
                     "meme source de verite en quasi temps reel (Realtime).")
pdf.ln(2)
pdf.h2("6.1 Couches de l'application mobile")
pdf.body(
    "Presentation (ecrans + widgets), etat (Riverpod), domaine (entites et "
    "interfaces), donnees (repositories offline-first), sources (Isar local et "
    "Supabase distant). Chaque couche ne depend que de la couche inferieure, ce "
    "qui rend le code testable et maintenable.")
pdf.h2("6.2 Espace admin identique mobile et web")
pdf.body(
    "L'espace admin partage la meme charte (logo, vert de marque, indicateur de "
    "page active) et les memes capacites : moderation complete, publication "
    "d'ameliorations, gestion des etablissements et des alertes, export et "
    "gestion des utilisateurs. Sur mobile il est integre a l'application ; sur le "
    "web il s'appuie sur Next.js et reste totalement responsive.")

# ================= 7. CONCEPTION UML =================
pdf.add_page()
pdf.h1("7. Conception UML")
pdf.h2("7.1 Diagramme de cas d'utilisation")
pdf.body("Acteurs principaux et leurs interactions avec le systeme :")
top = pdf.get_y() + 2
pdf.set_draw_color(*DARK)
pdf.set_line_width(0.4)


def actor(x, y, label):
    pdf.set_fill_color(*BRAND)
    pdf.ellipse(x - 3, y, 6, 6, "F")
    pdf.line(x, y + 6, x, y + 14)
    pdf.line(x - 5, y + 9, x + 5, y + 9)
    pdf.line(x, y + 14, x - 5, y + 20)
    pdf.line(x, y + 14, x + 5, y + 20)
    pdf.set_xy(x - 15, y + 21)
    pdf.set_font("Helvetica", "B", 9)
    pdf.set_text_color(*DARK)
    pdf.cell(30, 5, label, align="C")


actor(30, top, "Citoyen")
actor(pdf.w - 30, top, "Admin")
usecases = [
    "Donner un feedback anonyme", "Rechercher un etablissement", "Suivre / dialoguer",
    "Moderer les feedbacks", "Recevoir des alertes", "Publier / exporter",
]
bx = 70
bw = pdf.w - 140
by = top
pdf.set_font("Helvetica", "", 8)
for i, uc in enumerate(usecases):
    yy = by + i * 11
    pdf.set_fill_color(*LIGHT)
    pdf.set_draw_color(*BRAND)
    pdf.ellipse(bx, yy, bw, 9, "DF")
    pdf.set_text_color(20, 20, 20)
    pdf.set_xy(bx, yy + 1.5)
    pdf.cell(bw, 6, uc, align="C")
    if i < 3:
        pdf.line(36, top + 8, bx, yy + 4)
    else:
        pdf.line(pdf.w - 36, top + 8, bx + bw, yy + 4)
pdf.set_y(by + len(usecases) * 11 + 4)
pdf.body(
    "Le citoyen donne des feedbacks, recherche des etablissements et suit / "
    "dialogue de facon anonyme. L'admin modere, recoit les alertes, publie les "
    "actions correctives et exporte les donnees.")

# ---- 7.2 Diagramme de classes ----
pdf.add_page()
pdf.h2("7.2 Diagramme de classes (modele de donnees)")


def class_box(x, y, w, title, attrs):
    h_title = 8
    h_body = 5 * len(attrs) + 4
    pdf.set_draw_color(*BRAND)
    pdf.set_fill_color(*BRAND)
    pdf.rect(x, y, w, h_title, "DF")
    pdf.set_xy(x, y + 1)
    pdf.set_font("Helvetica", "B", 9)
    pdf.set_text_color(255, 255, 255)
    pdf.cell(w, 6, title, align="C")
    pdf.set_fill_color(248, 250, 248)
    pdf.rect(x, y + h_title, w, h_body, "DF")
    pdf.set_font("Helvetica", "", 8)
    pdf.set_text_color(*INK)
    for i, a in enumerate(attrs):
        pdf.set_xy(x + 2, y + h_title + 2 + i * 5)
        pdf.cell(w - 4, 5, a)
    return h_title + h_body


y0 = pdf.get_y() + 2
class_box(20, y0, 52, "Establishment", ["id", "name", "sector_id", "qr_code", "lat / lng"])
class_box(80, y0, 56, "Feedback", ["id", "anon_code", "rating", "comment", "is_critical",
                                    "status", "priority", "client_uuid", "updated_at"])
class_box(148, y0, 44, "Improvement", ["id", "title", "before_url", "after_url"])
y1 = y0 + 62
class_box(50, y1, 52, "ConversationMessage", ["id", "feedback_id", "sender", "body"])
class_box(118, y1, 50, "Alert", ["id", "feedback_id", "level", "message"])
pdf.set_draw_color(*GRAY)
pdf.line(72, y0 + 18, 80, y0 + 18)
pdf.line(136, y0 + 18, 148, y0 + 18)
pdf.line(108, y0 + 46, 76, y1)
pdf.line(120, y0 + 46, 140, y1)
pdf.set_y(y1 + 42)
pdf.body(
    "Le feedback est l'entite centrale (sans aucun lien d'identite). Il se "
    "rattache a un etablissement, peut generer des messages de conversation, des "
    "alertes, et donner lieu a des ameliorations publiees. Les champs client_uuid "
    "et updated_at soutiennent une synchronisation idempotente et la resolution "
    "des conflits.")

# ---- 7.3 Diagramme de sequence ----
pdf.h2("7.3 Diagramme de sequence (soumission d'un feedback)")
seq = [
    "1. L'utilisateur recherche l'etablissement et remplit le formulaire "
    "(validation temps reel, logique selon secteur et note).",
    "2. A l'envoi, le feedback est ecrit immediatement dans Isar (local) avec un "
    "client_uuid unique et le statut en attente de synchronisation.",
    "3. Si en ligne : upload des medias compresses vers Supabase Storage.",
    "4. Upsert de la ligne dans PostgreSQL (RLS : insertion anonyme, idempotence "
    "par client_uuid).",
    "5. Les triggers valident, creent une alerte si critique, indexent (FTS).",
    "6. L'admin (mobile et web) voit le feedback et l'alerte en quasi temps reel "
    "(Realtime).",
]
for s in seq:
    pdf.bullet(s)

# ================= 8. SYNCHRONISATION =================
pdf.add_page()
pdf.h1("8. Synchronisation Isar <-> Supabase")
pdf.body(
    "La synchronisation est le coeur de la fiabilite offline-first. Elle est "
    "concue pour ne jamais perdre de donnee, ne jamais creer de doublon, et "
    "resoudre proprement les conflits entre l'etat local et l'etat serveur.")
pdf.h2("8.1 Flux de synchronisation")
y0 = pdf.get_y() + 2
steps = [
    ("Ecriture locale", ["Isar : statut", "= pending", "+ client_uuid"]),
    ("File d'attente", ["reprise des", "erreurs et", "blocages"]),
    ("En ligne ?", ["connectivity", "_service", "declencheur"]),
    ("Upsert serveur", ["Storage +", "Postgres", "idempotent"]),
    ("Resolution", ["conflit par", "updated_at", "le serveur gagne"]),
    ("Statut = synced", ["maj locale", "Realtime", "admin a jour"]),
]
xw = 30
gap = 2
x = 16
for i, (t, ls) in enumerate(steps):
    box(pdf, x, y0, xw, t, ls, fill=LIGHT if i % 2 else (248, 250, 248))
    if i < len(steps) - 1:
        arrow(pdf, x + xw, y0 + 11, x + xw + gap, y0 + 11, BRAND)
    x += xw + gap
pdf.set_y(y0 + 34)
pdf.h2("8.2 Idempotence et absence de doublon")
pdf.body(
    "Chaque feedback porte un identifiant client (client_uuid) genere sur "
    "l'appareil. L'ecriture serveur est un upsert sur cette cle : rejouer une "
    "synchronisation (apres coupure reseau, crash ou reprise au demarrage) "
    "n'insere jamais deux fois la meme donnee.")
pdf.h2("8.3 Gestion des conflits")
pdf.body(
    "Lorsqu'une ligne existe deja des deux cotes, la resolution s'appuie sur "
    "l'horodatage updated_at. Regle par defaut : le serveur fait autorite pour "
    "les champs de moderation (statut, priorite), tandis que le contenu d'origine "
    "du citoyen reste immuable. Les champs modifies localement mais non encore "
    "pousses sont rejoues ; en cas d'ecart, la valeur la plus recente l'emporte, "
    "et l'evenement est trace dans le journal d'audit.")
pdf.h2("8.4 Reprise et robustesse")
pdf.body(
    "Une synchronisation est declenchee au demarrage, au retour de la "
    "connectivite et apres chaque envoi. Les feedbacks en erreur ou bloques sont "
    "systematiquement repris. Aucune action utilisateur n'est requise : le "
    "systeme converge vers un etat coherent des que le reseau le permet.")
pdf.note(
    "Correctif applique : les feedbacks en erreur ou bloques sont re-synchronises "
    "automatiquement, la synchro s'execute au demarrage, et l'idempotence par "
    "client_uuid supprime tout risque de doublon.")

# ================= 9. SECURITE ET ANONYMAT =================
pdf.add_page()
pdf.h1("9. Securite, anonymat et roles")
pdf.h2("9.1 Anonymat par conception")
pdf.body(
    "La table feedbacks ne stocke aucun identifiant utilisateur. Le suivi et le "
    "dialogue passent par un code anonyme aleatoire (anon_code) connu du seul "
    "auteur. La conversation 2-way s'obtient via la fonction serveur "
    "get_conversation(anon_code).")
pdf.h2("9.2 Regles de securite au niveau des lignes (RLS)")
for b in [
    "Insertion ouverte aux sessions anonymes (le citoyen peut deposer un retour).",
    "Lecture et moderation reservees aux comptes admins declares.",
    "Un utilisateur ne peut jamais lire les feedbacks d'autrui.",
    "Les buckets de medias appliquent les memes principes d'acces.",
]:
    pdf.bullet(b)
pdf.ln(2)
pdf.h2("9.3 Roles d'administration")
pdf.body(
    "Trois roles distincts : Super Admin (pilotage global, gestion des "
    "administrateurs), Admin de domaine (perimetre sectoriel) et Moderateur "
    "(traitement des feedbacks). Chaque action sensible est enregistree dans un "
    "journal d'audit horodate.")
pdf.h2("9.4 Compte administrateur")
pdf.body(
    "Le compte de reference est luciarasoanirina8@gmail.com. Il se cree dans "
    "Supabase Auth (email + mot de passe, auto-confirme), puis on execute "
    "supabase/setup_admin.sql pour l'habiliter. Le mobile et le web pointent sur "
    "le meme projet Supabase afin de partager les memes donnees.")

# ================= 10. CATALOGUE DES FONCTIONNALITES =================
pdf.add_page()
pdf.h1("10. Catalogue des fonctionnalites")
pdf.h2("10.1 Fonctionnalites livrees")
feats = [
    ("Logo de marque partout", "splash, icone, en-tetes, admin web et mobile."),
    ("Espace admin identique", "meme design et memes fonctions sur mobile et web, responsive."),
    ("Synchronisation fiable", "Isar <-> Supabase, idempotente, avec gestion des conflits."),
    ("Formulaire intelligent", "validation temps reel et logique conditionnelle selon secteur et note."),
    ("Recherche intelligente", "resultats affiches directement dans l'accueil (etablissements + secteurs)."),
    ("Indicateur de page active", "reperage visuel clair de la page en cours, mobile et web."),
    ("Admin peut tout faire", "moderation complete, publication, export, gestion des utilisateurs."),
    ("Interface responsive", "adaptee a tous les appareils, du telephone au grand ecran."),
    ("Offline-first", "usage complet hors ligne, synchronisation automatique differee."),
    ("Multilingue instantane", "malgache, francais, anglais - changement immediat."),
    ("Statistiques et tendances", "graphiques interactifs, comparaisons, evolution."),
    ("QR code etablissement", "acces direct au bon etablissement par scan."),
]
for k, v in feats:
    pdf.kv(k, v)
    pdf.ln(0.5)

pdf.add_page()
pdf.h2("10.2 Fonctionnalites avancees et extensions")
pdf.body(
    "Ces fonctionnalites completent le socle et enrichissent progressivement la "
    "plateforme, en s'appuyant sur les Edge Functions Supabase et les services "
    "mobiles.")
adv = [
    ("Analyse IA", "Edge Function d'analyse de sentiment et de themes ; remplit les "
                   "champs sentiment et themes des feedbacks."),
    ("Notifications push", "FCM + Edge Function pour notifier reponses et ameliorations."),
    ("Conversations 2-way", "echange anonyme citoyen <-> admin via get_conversation."),
    ("Export complet", "CSV, Excel et PDF detaille de plus de dix pages."),
    ("Support vocal", "saisie et restitution vocales pour l'accessibilite."),
    ("Traduction automatique", "des retours entre malgache, francais et anglais."),
    ("Alertes intelligentes", "declenchement automatique sur feedback critique."),
    ("Suivi du statut", "recu, en cours, resolu - visible par le citoyen."),
    ("Historique d'audit", "journal horodate de toutes les actions sensibles."),
    ("Heatmap geolocalisee", "carte de chaleur des problemes (flutter_map + clustering)."),
]
for k, v in adv:
    pdf.kv(k, v)
    pdf.ln(0.5)
pdf.ln(1)
pdf.note(
    "Toutes ces fonctionnalites sont pensees pour le contexte local : faible bande "
    "passante, materiel modeste, pluralite linguistique et exigence forte "
    "d'anonymat.")

# ================= 11. DEPLOIEMENT =================
pdf.add_page()
pdf.h1("11. Deploiement et exploitation")
pdf.h2("11.1 Vue de deploiement")
y0 = pdf.get_y() + 2
box(pdf, 20, y0, 50, "Appareil Android", ["App Flutter", "Isar (local)", "Splash + icone"])
box(pdf, 82, y0, 52, "Supabase (cloud)", ["Postgres + RLS", "Auth / Storage", "Realtime / Edge"], fill=LIGHT)
box(pdf, 146, y0, 44, "Navigateur", ["Admin Next.js", "responsive"])
arrow(pdf, 70, y0 + 11, 82, y0 + 11, BRAND)
arrow(pdf, 146, y0 + 11, 134, y0 + 11, BRAND)
pdf.set_y(y0 + 34)
pdf.body(
    "L'application mobile se distribue en APK (arm32 / arm64) ou via un store. Le "
    "backend Supabase est heberge dans le cloud (projet unique partage). L'admin "
    "web se build avec Next.js puis se sert en production (Node) ou se deploie sur "
    "une plateforme statique / edge.")
pdf.h2("11.2 Mise en route de l'admin web")
for b in [
    "Renseigner web_admin/.env.local (URL et cle anon du projet Supabase).",
    "Installer les dependances : npm install.",
    "Construire : npm run build (le logo est integre a l'interface).",
    "Servir : npm start, puis se connecter avec le compte administrateur.",
]:
    pdf.bullet(b)
pdf.ln(2)
pdf.h2("11.3 Base de donnees")
pdf.body(
    "Executer les scripts SQL dans l'ordre (init du schema et RLS, buckets de "
    "stockage, evolutions), puis creer le compte admin et lancer setup_admin.sql. "
    "Des enregistrements de demonstration realistes et coherents peuvent etre "
    "charges pour illustrer l'usage.")

# ================= 12. FEUILLE DE ROUTE =================
pdf.add_page()
pdf.h1("12. Feuille de route")
pdf.body(
    "La solution est concue pour evoluer par paliers successifs, sans rupture "
    "d'usage :")
for b in [
    "Generalisation de l'analyse IA (priorisation automatique, resume des themes).",
    "Notifications push contextualisees et silencieuses hors heures utiles.",
    "Heatmap temps reel et tableaux de bord territoriaux pour les decideurs.",
    "Recompenses optionnelles via Mobile Money (MVola / Orange / Airtel).",
    "Ouverture d'API publiques anonymisees pour la transparence citoyenne.",
    "Accessibilite renforcee : support vocal complet et contrastes eleves.",
]:
    pdf.bullet(b)
pdf.ln(2)
pdf.body(
    "Chaque palier reste fidele aux principes fondateurs : anonymat par "
    "conception, offline-first, fiabilite des donnees et sobriete technique.")

# ================= 13. CONCLUSION =================
pdf.add_page()
pdf.h1("13. Conclusion")
pdf.body(
    "FeedbackPro repond a un besoin concret : donner une voix anonyme et sure aux "
    "citoyens, et des outils d'action efficaces aux responsables, dans un contexte "
    "de connectivite et de materiel contraints.")
pdf.body(
    "Les choix d'architecture - anonymat par conception, offline-first, "
    "synchronisation fiable avec gestion des conflits, regles metier appliquees a "
    "la fois cote client et serveur, pile technologique moderne et economique - "
    "garantissent fiabilite, securite et adoption. L'approche multi-domaines "
    "maximise l'impact social et la valeur des donnees.")
pdf.body(
    "Avec un espace admin identique sur mobile et web, une recherche intelligente "
    "integree a l'accueil, un formulaire a logique conditionnelle forte et un logo "
    "de marque decline partout, FeedbackPro s'affirme comme un outil de reference "
    "pour l'amelioration continue des services.")
pdf.ln(4)
draw_logo(pdf, pdf.l_margin, pdf.get_y(), 12)
pdf.set_xy(pdf.l_margin + 16, pdf.get_y() + 2)
pdf.set_font("Helvetica", "B", 12)
pdf.set_text_color(*DARK)
pdf.cell(0, 8, "FeedbackPro - Donner de la voix, ameliorer les services.")

pdf.output(r"D:\Lucia\docs\FeedbackPro_Documentation.pdf")
print("PDF genere :", pdf.page_no(), "pages physiques")

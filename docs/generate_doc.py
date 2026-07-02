# -*- coding: utf-8 -*-
"""Generateur de la documentation PDF (10 pages) d'AnonyFeedback Pro v2.0.0.
Utilise fpdf2. Texte compatible latin-1 (pas de guillemets typographiques)."""
from fpdf import FPDF

BRAND = (27, 122, 67)
DARK = (14, 92, 48)
GRAY = (90, 90, 90)
LIGHT = (231, 243, 236)


class Doc(FPDF):
    def header(self):
        if self.page_no() == 1:
            return
        self.set_xy(self.l_margin, 10)
        self.set_font("Helvetica", "", 8)
        self.set_text_color(*GRAY)
        self.cell(0, 6, "AnonyFeedback Pro v2.0.0 - Documentation technique",
                  align="L", new_x="LMARGIN", new_y="NEXT")
        self.set_draw_color(*BRAND)
        self.set_line_width(0.3)
        self.line(self.l_margin, 18, self.w - self.r_margin, 18)
        self.set_xy(self.l_margin, 22)

    def footer(self):
        if self.page_no() == 1:
            return
        self.set_y(-15)
        self.set_font("Helvetica", "", 8)
        self.set_text_color(*GRAY)
        self.cell(0, 10, f"Page {self.page_no() - 1}", align="C")

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
        self.set_text_color(30, 30, 30)
        self.multi_cell(0, 6, text)
        self.ln(2)

    def bullet(self, text):
        self.set_x(self.l_margin)
        self.set_font("Helvetica", "", 11)
        self.set_text_color(30, 30, 30)
        x = self.get_x()
        self.set_text_color(*BRAND)
        self.cell(6, 6, chr(149))
        self.set_text_color(30, 30, 30)
        self.multi_cell(0, 6, text)
        self.set_x(x)

    def kv(self, key, value):
        self.set_x(self.l_margin)
        self.set_font("Helvetica", "B", 11)
        self.set_text_color(*DARK)
        self.cell(45, 6, key, new_x="RIGHT", new_y="TOP")
        self.set_font("Helvetica", "", 11)
        self.set_text_color(30, 30, 30)
        self.multi_cell(0, 6, value)


def render_toc(pdf: Doc, outline):
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
        # points de conduite
        dots_w = pdf.w - pdf.r_margin - pdf.get_x() - 12
        n = max(0, int(dots_w / pdf.get_string_width(".")))
        pdf.set_text_color(180, 180, 180)
        pdf.cell(dots_w, 8, "." * n)
        pdf.set_text_color(20, 20, 20)
        pdf.cell(12, 8, str(s.page_number), align="R", new_x="LMARGIN", new_y="NEXT")


pdf = Doc()
pdf.set_auto_page_break(auto=True, margin=20)
pdf.set_title("AnonyFeedback Pro v2.0.0 - Documentation")

# ---------------- COUVERTURE ----------------
pdf.add_page()
pdf.set_fill_color(*BRAND)
pdf.rect(0, 0, pdf.w, pdf.h, "F")
def center(txt, h, size, style="", ln=0):
    pdf.set_x(pdf.l_margin)
    pdf.set_font("Helvetica", style, size)
    pdf.set_text_color(255, 255, 255)
    pdf.multi_cell(pdf.epw, h, txt, align="C")
    if ln:
        pdf.ln(ln)

pdf.set_y(70)
center("AnonyFeedback Pro", 16, 34, "B")
center("v2.1.0", 10, 18, "B", ln=6)
center("Systeme de retours anonymes pour l'amelioration\ncontinue des services publics et prives", 8, 14, "", ln=20)
center("Documentation technique et conceptuelle", 7, 12)
center("Application mobile Flutter + Plateforme web Next.js + Supabase", 7, 12, "", ln=30)
center("Contexte : Madagascar et Afrique", 6, 11)

# ---------------- TOC ----------------
pdf.add_page()
pdf.insert_toc_placeholder(render_toc, pages=1)

# ---------------- 1. INTRODUCTION ----------------
pdf.add_page()
pdf.h1("1. Introduction")
pdf.body(
    "AnonyFeedback Pro est une solution complete de collecte et de gestion de "
    "retours (feedbacks) totalement anonymes. Elle permet a tout citoyen de "
    "donner son avis sur n'importe quel service - ecole, hopital, clinique, "
    "boutique, restaurant, hotel, administration publique, transport - et aux "
    "responsables de suivre, analyser et agir rapidement grace a une plateforme "
    "web professionnelle.")
pdf.body(
    "La version 2.0.0 marque une evolution majeure : un formulaire intelligent "
    "avec validation en temps reel et logique conditionnelle, un suivi du statut "
    "des feedbacks (recu, en cours, resolu), des alertes intelligentes en cas de "
    "probleme grave, une plateforme d'administration web dediee (Next.js 15), "
    "ainsi que de nombreuses fonctionnalites utiles : conversations anonymes, "
    "heatmap des problemes, mode express, statistiques publiques anonymisees.")
pdf.h2("1.1 Objectifs du document")
pdf.body(
    "Ce document presente l'analyse des besoins et des contraintes, justifie les "
    "choix technologiques et conceptuels, decrit la conception UML du systeme et "
    "conclut sur la valeur apportee par la solution.")
pdf.h2("1.2 Public vise")
pdf.body(
    "Equipe de developpement, responsables d'etablissements, decideurs publics, "
    "ainsi que toute partie prenante interessee par l'amelioration continue des "
    "services par la voix citoyenne.")

# ---------------- 2. ANALYSE DES BESOINS ----------------
pdf.add_page()
pdf.h1("2. Analyse des besoins")
pdf.h2("2.1 Besoins des utilisateurs (citoyens)")
for b in [
    "Soumettre un feedback totalement anonyme, sans creer de compte.",
    "Identifier l'etablissement concerne : nom obligatoire, adresse facultative.",
    "Noter un service (etoiles, echelle, smileys) - note facultative.",
    "Choisir un type de probleme parmi des propositions, toujours disponibles.",
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
    "Analyser les tendances : positifs/negatifs, evolution, comparaisons.",
    "Exporter les donnees (CSV, Excel, PDF) et garder un historique d'audit.",
    "Gerer plusieurs administrateurs avec des roles distincts.",
]:
    pdf.bullet(b)
pdf.ln(2)
pdf.h2("2.3 Besoins fonctionnels transverses")
pdf.body(
    "Validation et contraintes robustes en temps reel (mobile et web), gestion "
    "intelligente de la logique des formulaires, transparence via des "
    "statistiques publiques anonymisees, et notifications push pertinentes.")

# ---------------- 3. ANALYSE DES CONTRAINTES ----------------
pdf.add_page()
pdf.h1("3. Analyse des contraintes")
pdf.h2("3.1 Contrainte d'anonymat maximal")
pdf.body(
    "Aucune donnee permettant d'identifier l'utilisateur ne doit etre stockee. "
    "La table des feedbacks ne contient aucun identifiant utilisateur : le suivi "
    "se fait via un code anonyme aleatoire connu du seul auteur. Les regles de "
    "securite au niveau des lignes (RLS) garantissent qu'un utilisateur ne peut "
    "jamais lire les feedbacks d'autrui.")
pdf.h2("3.2 Contrainte technique : low-end et faible bande passante")
pdf.body(
    "La cible inclut des telephones Android d'entree de gamme et des connexions "
    "instables. D'ou : compression agressive des images, cartes OpenStreetMap "
    "legeres, interface sobre, et surtout une architecture offline-first ou tout "
    "fonctionne hors ligne puis se synchronise automatiquement.")
pdf.h2("3.3 Contrainte de fiabilite des donnees")
pdf.body(
    "Les regles metier sont appliquees a deux niveaux : cote client (validation "
    "temps reel dans le formulaire) et cote serveur (triggers PostgreSQL). Dans "
    "la version 2.1, le seul champ obligatoire est le nom de l'etablissement, "
    "afin de toujours rattacher un retour a un lieu identifiable ; la note et les "
    "details restent facultatifs pour ne pas freiner la participation. Le bouton "
    "d'envoi demeure actif, et le type de probleme est toujours propose (en "
    "style neutre). La coherence est garantie de bout en bout.")
pdf.h2("3.4 Contraintes de securite et de roles")
pdf.body(
    "Authentification anonyme sur mobile, mais email/mot de passe pour les admins "
    "web, avec gestion de roles (Super Admin, Admin de domaine, Moderateur) et "
    "journal d'audit de toutes les actions sensibles.")

# ---------------- 4. CHOIX DES TECHNOLOGIES ----------------
pdf.add_page()
pdf.h1("4. Arguments du choix des technologies")
pdf.kv("Flutter (mobile)",
       "Un seul code pour Android/iOS, performances natives, riche ecosysteme, "
       "ideal pour une UI moderne et fluide sur appareils modestes.")
pdf.ln(1)
pdf.kv("Supabase (backend)",
       "PostgreSQL managé + Auth + Storage + Realtime + Edge Functions. La "
       "securite par RLS est parfaite pour garantir l'anonymat. Open-source, "
       "evite le verrouillage proprietaire.")
pdf.ln(1)
pdf.kv("Isar (local)",
       "Base locale rapide et typee pour le mode offline-first ; lecture/ecriture "
       "instantanees sans connexion, synchronisation differee.")
pdf.ln(1)
pdf.kv("Riverpod",
       "Gestion d'etat moderne, testable, en couches ; rend le changement de "
       "langue et de theme instantane.")
pdf.ln(1)
pdf.kv("Next.js 15 (web)",
       "App Router + rendu serveur pour un tableau de bord rapide et securise ; "
       "TypeScript pour la fiabilite, Tailwind pour une UI soignee, recharts pour "
       "des graphiques interactifs.")
pdf.ln(1)
pdf.kv("flutter_map + OSM",
       "Cartographie libre, sans cle API ni cout, et legere en bande passante - "
       "adaptee au contexte local.")
pdf.ln(3)
pdf.body(
    "Ces choix forment une pile coherente, moderne, economique et adaptee aux "
    "contraintes de terrain (cout, connectivite, materiel).")

# ---------------- 5. POURQUOI TOUS LES DOMAINES ----------------
pdf.add_page()
pdf.h1("5. Pourquoi couvrir tous les domaines plutot qu'un seul")
pdf.body(
    "Un choix structurant de la solution est de couvrir l'ensemble des secteurs "
    "(sante, education, commerce, administration, restauration/hotellerie, "
    "transport) plutot que de se limiter a un seul domaine. Les raisons :")
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
    "Couvrir tous les domaines permet des analyses transversales (par exemple "
    "comparer la satisfaction entre hopitaux et administrations d'une meme "
    "region) - une valeur strategique pour les decideurs publics, impossible "
    "avec une approche cloisonnee.")
pdf.h2("5.5 Adaptabilite par templates")
pdf.body(
    "La generalite ne nuit pas a la pertinence : des templates de questionnaires "
    "specifiques par secteur, et un formulaire a logique conditionnelle, "
    "adaptent l'experience a chaque domaine tout en gardant un socle commun.")

# ---------------- 6. CONCEPTION UML ----------------
pdf.add_page()
pdf.h1("6. Conception UML")
pdf.h2("6.1 Diagramme de cas d'utilisation")
pdf.body("Acteurs principaux et leurs interactions avec le systeme :")

# Dessin simple d'un diagramme de cas d'utilisation
top = pdf.get_y() + 2
# Acteur Citoyen (gauche)
pdf.set_draw_color(*DARK)
pdf.set_line_width(0.4)
def actor(x, y, label):
    pdf.set_fill_color(*BRAND)
    pdf.ellipse(x - 3, y, 6, 6, "F")            # tete
    pdf.line(x, y + 6, x, y + 14)               # corps
    pdf.line(x - 5, y + 9, x + 5, y + 9)        # bras
    pdf.line(x, y + 14, x - 5, y + 20)          # jambe g
    pdf.line(x, y + 14, x + 5, y + 20)          # jambe d
    pdf.set_xy(x - 15, y + 21)
    pdf.set_font("Helvetica", "B", 9)
    pdf.set_text_color(*DARK)
    pdf.cell(30, 5, label, align="C")

actor(30, top, "Citoyen")
actor(pdf.w - 30, top, "Admin")

usecases = [
    "Donner un feedback anonyme", "Scanner un QR code", "Suivre / dialoguer",
    "Moderer les feedbacks", "Recevoir des alertes", "Publier des actions",
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
    # liaisons vers l'acteur concerne
    if i < 3:
        pdf.line(36, top + 8, bx, yy + 4)
    else:
        pdf.line(pdf.w - 36, top + 8, bx + bw, yy + 4)
pdf.set_y(by + len(usecases) * 11 + 4)
pdf.body(
    "Le citoyen donne des feedbacks, scanne des QR codes et suit/dialogue de "
    "facon anonyme. L'admin modere, recoit les alertes et publie les actions "
    "correctives.")

# ---------------- 6.2 Diagramme de classes ----------------
pdf.add_page()
pdf.h2("6.2 Diagramme de classes (modele de donnees)")

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
    pdf.set_text_color(30, 30, 30)
    for i, a in enumerate(attrs):
        pdf.set_xy(x + 2, y + h_title + 2 + i * 5)
        pdf.cell(w - 4, 5, a)
    return h_title + h_body

y0 = pdf.get_y() + 2
class_box(20, y0, 52, "Establishment", ["id", "name", "sector_id", "qr_code", "lat / lng"])
class_box(80, y0, 56, "Feedback", ["id", "anon_code", "rating", "comment", "is_critical", "status", "priority"])
class_box(146, y0, 44, "Improvement", ["id", "title", "before_url", "after_url"])
y1 = y0 + 55
class_box(50, y1, 52, "ConversationMessage", ["id", "feedback_id", "sender", "body"])
class_box(118, y1, 50, "Alert", ["id", "feedback_id", "level", "message"])
# relations
pdf.set_draw_color(*GRAY)
pdf.line(72, y0 + 18, 80, y0 + 18)          # establishment - feedback
pdf.line(136, y0 + 18, 146, y0 + 18)        # feedback - improvement
pdf.line(108, y0 + 40, 76, y1)              # feedback - conversation
pdf.line(120, y0 + 40, 140, y1)             # feedback - alert
pdf.set_y(y1 + 40)
pdf.body(
    "Le feedback est l'entite centrale (sans aucun lien d'identite). Il se "
    "rattache a un etablissement, peut generer des messages de conversation, des "
    "alertes, et donner lieu a des ameliorations publiees.")

pdf.h2("6.3 Diagramme de sequence (soumission d'un feedback)")
seq = [
    "1. L'utilisateur saisit le nom de l'etablissement (obligatoire) et remplit "
    "le formulaire (validation temps reel, note facultative).",
    "2. A l'envoi, le feedback est ecrit immediatement dans Isar (local).",
    "3. Si en ligne : upload des medias compresses vers Supabase Storage.",
    "4. Insertion de la ligne dans PostgreSQL (RLS : insertion anonyme).",
    "5. Les triggers valident, creent une alerte si critique, indexent (FTS).",
    "6. L'admin voit le feedback et l'alerte en quasi temps reel (Realtime).",
]
for s in seq:
    pdf.bullet(s)

# ---------------- 7. CONCLUSION ----------------
pdf.add_page()
pdf.h1("7. Conclusion")
pdf.body(
    "AnonyFeedback Pro v2.0.0 repond a un besoin concret : donner une voix "
    "anonyme et sure aux citoyens, et des outils d'action efficaces aux "
    "responsables, dans un contexte de connectivite et de materiel contraints.")
pdf.body(
    "Les choix d'architecture - anonymat par conception, offline-first, regles "
    "metier appliquees a la fois cote client et serveur, pile technologique "
    "moderne et economique - garantissent fiabilite, securite et adoption. "
    "L'approche multi-domaines maximise l'impact social et la valeur des donnees.")
pdf.body(
    "La solution est concue pour evoluer : conversations temps reel, "
    "intelligence artificielle d'aide a la decision, heatmap des problemes et "
    "transparence publique constituent une feuille de route claire vers un "
    "outil de reference pour l'amelioration continue des services.")
pdf.ln(4)
pdf.set_font("Helvetica", "B", 11)
pdf.set_text_color(*DARK)
pdf.multi_cell(0, 6, "AnonyFeedback Pro v2.0.0 - Donner de la voix, ameliorer les services.")

pdf.output(r"D:\Lucia\docs\AnonyFeedback_Pro_Documentation.pdf")
print("PDF genere :", pdf.page_no(), "pages physiques")

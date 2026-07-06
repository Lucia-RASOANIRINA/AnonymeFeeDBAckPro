# -*- coding: utf-8 -*-
"""Genere le MEMOIRE complet de FeedbackPro (Licence 3 Informatique).

Respecte :
- le CANEVAS L3 (page de couverture avec logos, page de garde, CV, sommaire 3
  niveaux, glossaire, listes des figures/tableaux/abreviations, introduction 4
  paragraphes, 6 chapitres, conclusion, bibliographie, webographie, annexes,
  table des matieres, resume/abstract) ;
- les NORMES de redaction : police Garamond 12, interligne 1,5, paragraphes
  justifies, marges 3 cm a gauche / 2 cm a droite, pages numerotees (sauf la
  page de titre), titres en chiffres romains, sous-titres 1.1/1.1.1, titres de
  figures EN GRAS et CENTRES SOUS la figure, titres de tableaux AU-DESSUS.

Deux passes : la 1re collecte les numeros de page des figures/tableaux, la 2de
les inscrit dans les listes. Sortie : docs/FeedbackPro_Memoire.pdf
"""
import os
from fpdf import FPDF

FONT = "Garamond"
GARA = r"C:\Windows\Fonts\GARA.TTF"
GARABD = r"C:\Windows\Fonts\GARABD.TTF"
GARAIT = r"C:\Windows\Fonts\GARAIT.TTF"
ASSETS = os.path.join(os.path.dirname(__file__), "mem_assets")
DOCS = os.path.dirname(__file__)

BRAND = (27, 122, 67)
DARK = (14, 92, 48)
GRAY = (90, 90, 90)
LIGHT = (231, 243, 236)
GOLD = (244, 180, 0)
INK = (25, 25, 25)

LH = 6.6          # interligne 1,5 pour du 12 pt
SECTIONS = []     # (niveau, texte, page) pour la table des matieres
FIG_REC = {}      # num figure -> page
TBL_REC = {}      # num tableau -> page

# Titres fixes des figures et tableaux (pour les listes, ordre stable).
FIG_TITLES = [
    (1, "Logo de l'application FeedbackPro"),
    (2, "Chronogramme de realisation (diagramme de Gantt)"),
    (3, "Diagramme de flux de l'organisation actuelle"),
    (4, "Architecture en couches (offline-first)"),
    (5, "Diagramme de cas d'utilisation"),
    (6, "Diagramme de sequence systeme (soumission d'un feedback)"),
    (7, "Modele de domaine"),
    (8, "Diagramme de sequence de conception (synchronisation)"),
    (9, "Diagramme de classes"),
    (10, "Diagramme de paquetage"),
    (11, "Diagramme de deploiement"),
    (12, "Ecran d'accueil et recherche intelligente"),
    (13, "Formulaire de feedback intelligent"),
    (14, "Historique local et etat de synchronisation"),
    (15, "Tableau de bord de l'espace administrateur"),
]
TBL_TITLES = [
    (1, "Moyens necessaires a la realisation du projet"),
    (2, "Dictionnaire des donnees (table feedbacks)"),
    (3, "Regles de gestion"),
    (4, "Description textuelle du cas << Soumettre un feedback >>"),
    (5, "Comparaison avec des solutions existantes"),
]


class Memoire(FPDF):
    def header(self):
        if self.page_no() <= self._cover_pages:
            return
        self.set_font(FONT, "", 8)
        self.set_text_color(*GRAY)
        self.set_y(8)
        self.cell(0, 5, "FeedbackPro - Memoire de Licence 3 Informatique",
                  align="R")
        self.set_draw_color(*BRAND)
        self.set_line_width(0.2)
        self.line(self.l_margin, 14, self.w - self.r_margin, 14)
        self.set_y(self.t_margin)

    def footer(self):
        if self.page_no() <= self._cover_pages:
            return
        self.set_y(-14)
        self.set_font(FONT, "", 9)
        self.set_text_color(*GRAY)
        self.cell(0, 8, str(self.page_no() - self._cover_pages), align="C")


def new_pdf():
    pdf = Memoire(format="A4")
    pdf._cover_pages = 1  # seule la couverture couleur n'est pas numerotee
    pdf.add_font(FONT, "", GARA)
    pdf.add_font(FONT, "B", GARABD)
    pdf.add_font(FONT, "I", GARAIT)
    pdf.set_margins(left=30, top=25, right=20)
    pdf.set_auto_page_break(auto=True, margin=20)
    pdf.set_title("FeedbackPro - Memoire de Licence 3 Informatique")
    return pdf


# --------------------------------------------------------------------------
# Helpers de contenu
# --------------------------------------------------------------------------
def body(pdf, text):
    pdf.set_font(FONT, "", 12)
    pdf.set_text_color(*INK)
    pdf.set_x(pdf.l_margin)
    pdf.multi_cell(0, LH, text, align="J")
    pdf.ln(1.5)


def bullet(pdf, text):
    pdf.set_font(FONT, "", 12)
    pdf.set_text_color(*INK)
    pdf.set_x(pdf.l_margin)
    x = pdf.get_x()
    pdf.set_text_color(*BRAND)
    pdf.cell(6, LH, chr(8226))
    pdf.set_text_color(*INK)
    pdf.multi_cell(0, LH, text, align="J")
    pdf.set_x(x)


def chapter(pdf, roman, title):
    pdf.add_page()
    pdf.start_section(f"{roman}. {title}")
    SECTIONS.append((0, f"CHAPITRE {roman} : {title}", pdf.page_no()))
    pdf.set_font(FONT, "B", 16)
    pdf.set_text_color(*DARK)
    pdf.ln(2)
    pdf.multi_cell(0, 9, f"CHAPITRE {roman} : {title.upper()}")
    pdf.set_draw_color(*BRAND)
    pdf.set_line_width(0.6)
    y = pdf.get_y() + 1
    pdf.line(pdf.l_margin, y, pdf.l_margin + 55, y)
    pdf.ln(6)


def h2(pdf, num, title):
    pdf.ln(1)
    pdf.start_section(f"{num} {title}", level=1)
    SECTIONS.append((1, f"{num} {title}", pdf.page_no()))
    pdf.set_font(FONT, "B", 13)
    pdf.set_text_color(*BRAND)
    pdf.set_x(pdf.l_margin)
    pdf.multi_cell(0, 7, f"{num} {title}")
    pdf.ln(1)


def h3(pdf, num, title):
    pdf.start_section(f"{num} {title}", level=2)
    SECTIONS.append((2, f"{num} {title}", pdf.page_no()))
    pdf.set_font(FONT, "BI", 12) if False else pdf.set_font(FONT, "B", 12)
    pdf.set_text_color(*DARK)
    pdf.set_x(pdf.l_margin)
    pdf.multi_cell(0, 6.5, f"{num} {title}")
    pdf.ln(0.5)


def fig_caption(pdf, num, fig_pages):
    FIG_REC[num] = pdf.page_no()
    title = dict(FIG_TITLES)[num]
    pdf.ln(1)
    pdf.set_font(FONT, "B", 11)
    pdf.set_text_color(*INK)
    pdf.multi_cell(0, 5.5, f"Figure {num} : {title}", align="C")
    pdf.ln(3)


def tbl_caption(pdf, num):
    TBL_REC[num] = pdf.page_no()
    title = dict(TBL_TITLES)[num]
    pdf.set_font(FONT, "B", 11)
    pdf.set_text_color(*INK)
    pdf.multi_cell(0, 5.5, f"Tableau {num} : {title}", align="C")
    pdf.ln(1)


def simple_table(pdf, headers, rows, widths):
    pdf.set_x(pdf.l_margin)
    pdf.set_font(FONT, "B", 10.5)
    pdf.set_fill_color(*BRAND)
    pdf.set_text_color(255, 255, 255)
    pdf.set_draw_color(*BRAND)
    for h, w in zip(headers, widths):
        pdf.cell(w, 7, h, border=1, align="C", fill=True)
    pdf.ln()
    pdf.set_font(FONT, "", 10.5)
    pdf.set_text_color(*INK)
    fill = False
    for row in rows:
        # hauteur dynamique
        line_counts = []
        for txt, w in zip(row, widths):
            lines = pdf.multi_cell(w, 5.2, str(txt), dry_run=True, output="LINES")
            line_counts.append(len(lines))
        h = max(line_counts) * 5.2
        x0, y0 = pdf.get_x(), pdf.get_y()
        if y0 + h > pdf.h - pdf.b_margin:
            pdf.add_page()
            x0, y0 = pdf.get_x(), pdf.get_y()
        pdf.set_fill_color(*(LIGHT if fill else (255, 255, 255)))
        for txt, w in zip(row, widths):
            x, y = pdf.get_x(), pdf.get_y()
            pdf.multi_cell(w, h, "", border=1, fill=True)
            pdf.set_xy(x, y)
            pdf.multi_cell(w, 5.2, str(txt), align="L")
            pdf.set_xy(x + w, y)
        pdf.ln(h)
        fill = not fill
    pdf.ln(3)


# --------------------------------------------------------------------------
# Diagrammes vectoriels
# --------------------------------------------------------------------------
def box(pdf, x, y, w, h, title, lines=None, fill=(248, 250, 248), tbg=BRAND, fs=8):
    pdf.set_draw_color(*BRAND)
    pdf.set_line_width(0.3)
    pdf.set_fill_color(*tbg)
    pdf.rect(x, y, w, 6.5, "DF")
    pdf.set_xy(x, y + 0.6)
    pdf.set_font(FONT, "B", fs)
    pdf.set_text_color(255, 255, 255)
    pdf.cell(w, 5, title, align="C")
    bh = h - 6.5
    if bh > 0:
        pdf.set_fill_color(*fill)
        pdf.rect(x, y + 6.5, w, bh, "DF")
        if lines:
            pdf.set_font(FONT, "", fs - 0.5)
            pdf.set_text_color(*INK)
            for i, ln in enumerate(lines):
                pdf.set_xy(x + 1.5, y + 7.5 + i * 4.4)
                pdf.cell(w - 3, 4.4, ln)


def arrow(pdf, x1, y1, x2, y2, color=GRAY):
    import math
    pdf.set_draw_color(*color)
    pdf.set_line_width(0.4)
    pdf.line(x1, y1, x2, y2)
    ang = math.atan2(y2 - y1, x2 - x1)
    pdf.set_fill_color(*color)
    pdf.polygon([(x2, y2),
                 (x2 - 2.6 * math.cos(ang - 0.4), y2 - 2.6 * math.sin(ang - 0.4)),
                 (x2 - 2.6 * math.cos(ang + 0.4), y2 - 2.6 * math.sin(ang + 0.4))],
                style="F")


def actor(pdf, x, y, label):
    pdf.set_draw_color(*DARK)
    pdf.set_line_width(0.5)
    pdf.set_fill_color(*BRAND)
    pdf.ellipse(x - 2.5, y, 5, 5, "F")
    pdf.line(x, y + 5, x, y + 12)
    pdf.line(x - 5, y + 8, x + 5, y + 8)
    pdf.line(x, y + 12, x - 5, y + 18)
    pdf.line(x, y + 12, x + 5, y + 18)
    pdf.set_xy(x - 12, y + 19)
    pdf.set_font(FONT, "B", 9)
    pdf.set_text_color(*DARK)
    pdf.cell(24, 5, label, align="C")


def draw_gantt(pdf):
    tasks = [
        ("Analyse des besoins", 0, 1),
        ("Analyse prealable", 1, 1),
        ("Conception (UML)", 2, 2),
        ("Developpement mobile", 3, 3),
        ("Backend Supabase", 4, 2),
        ("Espace admin & web", 6, 2),
        ("Tests & deploiement", 8, 1),
        ("Redaction du memoire", 7, 2),
    ]
    x0, y0 = pdf.l_margin, pdf.get_y() + 2
    label_w = 55
    weeks = 9
    cell_w = (pdf.w - pdf.r_margin - x0 - label_w) / weeks
    pdf.set_font(FONT, "", 7.5)
    pdf.set_text_color(*GRAY)
    for wk in range(weeks):
        pdf.set_xy(x0 + label_w + wk * cell_w, y0)
        pdf.cell(cell_w, 4, f"S{wk + 1}", align="C")
    y = y0 + 5
    for name, start, dur in tasks:
        pdf.set_xy(x0, y)
        pdf.set_font(FONT, "", 8)
        pdf.set_text_color(*INK)
        pdf.cell(label_w, 5, name)
        pdf.set_fill_color(*BRAND)
        pdf.rect(x0 + label_w + start * cell_w, y + 0.8, dur * cell_w - 1.5, 3.5, "F")
        y += 5.6
    pdf.set_y(y + 1)


def draw_flux(pdf):
    y0 = pdf.get_y() + 2
    cx = (pdf.l_margin + pdf.w - pdf.r_margin) / 2
    steps = [
        ("Usager du service", LIGHT),
        ("Reclamation orale / cahier papier", (255, 255, 255)),
        ("Perte ou oubli de l'information", (253, 235, 235)),
        ("Aucun suivi, aucune statistique", (253, 235, 235)),
    ]
    w = 90
    y = y0
    for i, (t, c) in enumerate(steps):
        pdf.set_fill_color(*c)
        pdf.set_draw_color(*BRAND)
        pdf.rect(cx - w / 2, y, w, 9, "DF")
        pdf.set_xy(cx - w / 2, y + 1.5)
        pdf.set_font(FONT, "", 9)
        pdf.set_text_color(*INK)
        pdf.cell(w, 6, t, align="C")
        if i < len(steps) - 1:
            arrow(pdf, cx, y + 9, cx, y + 13, BRAND)
        y += 13
    pdf.set_y(y)


def draw_archi(pdf):
    y0 = pdf.get_y() + 2
    box(pdf, 22, y0, 55, 33, "Mobile Flutter",
        ["Presentation / UI", "Etat (Riverpod)", "Repository", "Isar (local)", "Service de synchro"])
    box(pdf, 82, y0, 55, 33, "Supabase",
        ["Auth (anonyme)", "PostgreSQL + RLS", "Storage (medias)", "Realtime", "Edge Functions"], fill=LIGHT)
    box(pdf, 150, y0, 40, 33, "Web Next.js",
        ["Admin SSR", "Recherche", "Exports"])
    arrow(pdf, 77, y0 + 14, 82, y0 + 14, BRAND)
    arrow(pdf, 82, y0 + 19, 77, y0 + 19, GRAY)
    arrow(pdf, 150, y0 + 14, 137, y0 + 14, BRAND)
    pdf.set_y(y0 + 36)


def draw_usecase(pdf):
    top = pdf.get_y() + 4
    actor(pdf, 30, top, "Citoyen")
    actor(pdf, pdf.w - 30, top, "Admin")
    ucs = ["Donner un feedback anonyme", "Rechercher un etablissement",
           "Suivre et dialoguer", "Moderer les feedbacks",
           "Recevoir des alertes", "Publier / exporter"]
    bx = 68
    bw = pdf.w - 136
    for i, uc in enumerate(ucs):
        yy = top + i * 10
        pdf.set_fill_color(*LIGHT)
        pdf.set_draw_color(*BRAND)
        pdf.ellipse(bx, yy, bw, 8, "DF")
        pdf.set_xy(bx, yy + 1.2)
        pdf.set_font(FONT, "", 8)
        pdf.set_text_color(*INK)
        pdf.cell(bw, 5.5, uc, align="C")
        if i < 3:
            pdf.line(36, top + 6, bx, yy + 4)
        else:
            pdf.line(pdf.w - 36, top + 6, bx + bw, yy + 4)
    pdf.set_y(top + len(ucs) * 10 + 3)


def draw_sequence(pdf, steps, actors):
    top = pdf.get_y() + 2
    n = len(actors)
    span = pdf.w - pdf.l_margin - pdf.r_margin
    xs = [pdf.l_margin + span * (i + 0.5) / n for i in range(n)]
    pdf.set_font(FONT, "B", 8)
    for x, a in zip(xs, actors):
        pdf.set_fill_color(*BRAND)
        pdf.set_draw_color(*BRAND)
        pdf.rect(x - 18, top, 36, 6.5, "DF")
        pdf.set_xy(x - 18, top + 0.8)
        pdf.set_text_color(255, 255, 255)
        pdf.cell(36, 5, a, align="C")
        pdf.set_draw_color(180, 180, 180)
        pdf.set_line_width(0.2)
        pdf.line(x, top + 6.5, x, top + 6.5 + len(steps) * 8 + 4)
    y = top + 12
    pdf.set_font(FONT, "", 8)
    for frm, to, label in steps:
        x1, x2 = xs[frm], xs[to]
        pdf.set_text_color(*INK)
        mid = (x1 + x2) / 2
        pdf.set_xy(min(x1, x2), y - 4.5)
        pdf.cell(abs(x2 - x1), 4, label, align="C")
        arrow(pdf, x1, y, x2, y, DARK)
        y += 8
    pdf.set_y(y + 2)


def draw_domain(pdf):
    y0 = pdf.get_y() + 2
    box(pdf, 25, y0, 48, 22, "Etablissement", ["nom", "secteur", "adresse", "QR"], fill=LIGHT)
    box(pdf, 95, y0, 48, 22, "Feedback", ["note", "commentaire", "statut", "critique"], fill=LIGHT)
    box(pdf, 150, y0, 42, 22, "Amelioration", ["titre", "avant/apres"], fill=LIGHT)
    box(pdf, 95, y0 + 30, 48, 20, "Message", ["expediteur", "corps"], fill=LIGHT)
    pdf.set_draw_color(*GRAY)
    pdf.line(73, y0 + 11, 95, y0 + 11)
    pdf.line(143, y0 + 11, 150, y0 + 11)
    pdf.line(119, y0 + 22, 119, y0 + 30)
    pdf.set_y(y0 + 54)


def draw_class(pdf):
    def cbox(x, y, w, title, attrs):
        ht = 7
        hb = 4.6 * len(attrs) + 3
        pdf.set_draw_color(*BRAND)
        pdf.set_fill_color(*BRAND)
        pdf.rect(x, y, w, ht, "DF")
        pdf.set_xy(x, y + 0.7)
        pdf.set_font(FONT, "B", 8)
        pdf.set_text_color(255, 255, 255)
        pdf.cell(w, 5.5, title, align="C")
        pdf.set_fill_color(248, 250, 248)
        pdf.rect(x, y + ht, w, hb, "DF")
        pdf.set_font(FONT, "", 7.5)
        pdf.set_text_color(*INK)
        for i, a in enumerate(attrs):
            pdf.set_xy(x + 1.5, y + ht + 1.5 + i * 4.6)
            pdf.cell(w - 3, 4.6, a)
        return hb + ht
    y0 = pdf.get_y() + 2
    cbox(22, y0, 50, "Establishment", ["id", "name", "sector_id", "qr_code", "lat/lng"])
    cbox(80, y0, 55, "Feedback", ["id", "anon_code", "rating", "comment", "is_critical", "status", "client_uuid"])
    cbox(146, y0, 44, "Improvement", ["id", "title", "before_url", "after_url"])
    y1 = y0 + 45
    cbox(52, y1, 52, "ConversationMessage", ["id", "feedback_id", "sender", "body"])
    cbox(120, y1, 48, "Alert", ["id", "feedback_id", "level"])
    pdf.set_draw_color(*GRAY)
    pdf.line(72, y0 + 16, 80, y0 + 16)
    pdf.line(135, y0 + 16, 146, y0 + 16)
    pdf.line(108, y0 + 40, 78, y1)
    pdf.line(118, y0 + 40, 140, y1)
    pdf.set_y(y1 + 34)


def draw_package(pdf):
    y0 = pdf.get_y() + 2
    pkgs = [
        ("core", ["config", "theme", "router", "network", "error"]),
        ("data", ["models", "datasources", "repositories"]),
        ("features", ["home", "feedback", "history", "admin", "heatmap"]),
        ("shared", ["providers", "widgets"]),
    ]
    x = pdf.l_margin
    w = (pdf.w - pdf.l_margin - pdf.r_margin - 9) / 4
    for name, subs in pkgs:
        box(pdf, x, y0, w, 30, name, subs, fill=LIGHT)
        x += w + 3
    pdf.set_y(y0 + 33)
    arrow(pdf, pdf.l_margin + w * 1.5, y0 + 32, pdf.l_margin + w * 1.5, y0 + 32, BRAND)


def draw_deploy(pdf):
    y0 = pdf.get_y() + 2
    box(pdf, 25, y0, 48, 22, "Appareil Android", ["App Flutter", "Isar (local)"])
    box(pdf, 90, y0, 52, 22, "Supabase (cloud)", ["Postgres + RLS", "Auth / Storage", "Edge Functions"], fill=LIGHT)
    box(pdf, 155, y0, 38, 22, "Navigateur", ["Admin / Web"])
    arrow(pdf, 73, y0 + 11, 90, y0 + 11, BRAND)
    arrow(pdf, 155, y0 + 11, 142, y0 + 11, BRAND)
    pdf.set_y(y0 + 26)


# --------------------------------------------------------------------------
# Construction du document (une passe)
# --------------------------------------------------------------------------
def build(fig_pages, tbl_pages):
    SECTIONS.clear(); FIG_REC.clear(); TBL_REC.clear()
    pdf = new_pdf()

    # ---- 1. PAGE DE COUVERTURE (couleur) ----
    pdf.add_page()
    pdf.set_fill_color(*BRAND); pdf.rect(0, 0, pdf.w, pdf.h, "F")
    pdf.set_fill_color(*DARK); pdf.rect(0, 0, pdf.w, 34, "F")
    pdf.set_font(FONT, "B", 12); pdf.set_text_color(255, 255, 255)
    pdf.set_xy(0, 10); pdf.cell(pdf.w, 6, "UNIVERSITE / UF   -   E.M.I.T", align="C")
    pdf.set_font(FONT, "", 10)
    pdf.set_xy(0, 18); pdf.cell(pdf.w, 5, "Licence 3 Informatique - Conception et developpement mobile", align="C")
    # Carte blanche + icone verte (bon contraste sur fond vert).
    pdf.set_fill_color(255, 255, 255)
    pdf.rect(pdf.w / 2 - 22, 58, 44, 44, "F")
    if os.path.exists(os.path.join(ASSETS, "logo_icon.png")):
        pdf.image(os.path.join(ASSETS, "logo_icon.png"), x=pdf.w / 2 - 19, y=61, w=38)
    pdf.set_xy(0, 100); pdf.set_font(FONT, "B", 26); pdf.set_text_color(255, 255, 255)
    pdf.cell(pdf.w, 12, "FeedbackPro", align="C")
    pdf.set_xy(0, 116); pdf.set_font(FONT, "", 14)
    pdf.multi_cell(pdf.w, 7,
                   "Systeme de retours anonymes pour l'amelioration continue\n"
                   "des services publics et prives", align="C")
    pdf.set_xy(0, 150); pdf.set_font(FONT, "I", 12)
    pdf.cell(pdf.w, 6, "Rapport de projet de fin d'etudes", align="C")
    pdf.set_xy(30, 210); pdf.set_font(FONT, "", 12); pdf.set_text_color(255, 255, 255)
    pdf.multi_cell(0, 6.5,
                   "Presente par : RASOANIRINA Lucia\n"
                   "Responsable de la matiere : M. Valerien\n"
                   "Encadreur et evaluateur : M. Maminiaina Emmanuel", align="L")
    pdf.set_xy(0, pdf.h - 24); pdf.set_font(FONT, "", 11)
    pdf.cell(pdf.w, 6, "Annee universitaire 2024 - 2025   -   Madagascar", align="C")

    # ---- 2. PAGE DE GARDE ----
    pdf.add_page()
    pdf.set_text_color(*INK)
    pdf.set_font(FONT, "B", 12); pdf.ln(6)
    pdf.multi_cell(0, 7, "UNIVERSITE / UF - ECOLE DE MANAGEMENT ET D'INNOVATION\nTECHNOLOGIQUE (E.M.I.T)", align="C")
    pdf.ln(4); pdf.set_font(FONT, "", 12)
    pdf.multi_cell(0, 7, "Mention Informatique - Licence 3\nParcours : Conception et developpement mobile", align="C")
    if os.path.exists(os.path.join(ASSETS, "logo_icon.png")):
        pdf.image(os.path.join(ASSETS, "logo_icon.png"), x=pdf.w / 2 - 20, y=80, w=40)
    pdf.set_y(130); pdf.set_font(FONT, "B", 22); pdf.set_text_color(*DARK)
    pdf.cell(0, 12, "FeedbackPro", align="C", new_x="LMARGIN", new_y="NEXT")
    pdf.set_font(FONT, "", 13); pdf.set_text_color(*INK)
    pdf.multi_cell(0, 7, "Systeme mobile de retours anonymes pour l'amelioration\ncontinue des services", align="C")
    pdf.set_y(190); pdf.set_font(FONT, "", 12)
    pdf.multi_cell(0, 7, "Auteur : RASOANIRINA Lucia\nResponsable : M. Valerien\nEncadreur : M. Maminiaina Emmanuel\nAnnee universitaire 2024 - 2025", align="C")

    # ---- 3. PAGE DE COUVERTURE (N&B) ----
    pdf.add_page()
    pdf.set_text_color(0, 0, 0)
    pdf.set_draw_color(0, 0, 0); pdf.set_line_width(0.5)
    pdf.rect(pdf.l_margin - 4, 20, pdf.w - pdf.l_margin - pdf.r_margin + 8, pdf.h - 45)
    pdf.set_y(40); pdf.set_font(FONT, "B", 12)
    pdf.multi_cell(0, 7, "UNIVERSITE / UF - E.M.I.T\nLICENCE 3 INFORMATIQUE", align="C")
    pdf.set_y(110); pdf.set_font(FONT, "B", 24)
    pdf.cell(0, 12, "FeedbackPro", align="C", new_x="LMARGIN", new_y="NEXT")
    pdf.set_font(FONT, "", 12)
    pdf.multi_cell(0, 7, "Systeme de retours anonymes pour l'amelioration continue des services", align="C")
    pdf.set_y(180)
    pdf.multi_cell(0, 7, "RASOANIRINA Lucia\nResponsable : M. Valerien   -   Encadreur : M. Maminiaina Emmanuel\nAnnee universitaire 2024 - 2025", align="C")

    # ---- 4. CV ----
    pdf.add_page(); pdf.start_section("Curriculum Vitae"); SECTIONS.append((0, "CURRICULUM VITAE", pdf.page_no()))
    pdf.set_font(FONT, "B", 16); pdf.set_text_color(*DARK); pdf.cell(0, 10, "CURRICULUM VITAE", new_x="LMARGIN", new_y="NEXT"); pdf.ln(3)
    body(pdf, "Nom et prenom : RASOANIRINA Lucia")
    body(pdf, "Formation : Licence 3 en Informatique, parcours Conception et developpement mobile.")
    pdf.set_font(FONT, "B", 12); pdf.set_text_color(*BRAND); pdf.cell(0, 7, "Competences techniques", new_x="LMARGIN", new_y="NEXT")
    for c in ["Developpement mobile Flutter / Dart (architecture en couches, Riverpod).",
              "Bases de donnees : PostgreSQL, Supabase, Isar (local, offline-first).",
              "Developpement web : Next.js, TypeScript, Tailwind CSS.",
              "Conception UML, gestion de projet, controle de version Git."]:
        bullet(pdf, c)
    pdf.ln(1)
    pdf.set_font(FONT, "B", 12); pdf.set_text_color(*BRAND); pdf.cell(0, 7, "Projet realise", new_x="LMARGIN", new_y="NEXT")
    body(pdf, "FeedbackPro : application mobile et plateforme web de collecte et de gestion de "
              "retours citoyens totalement anonymes, avec synchronisation hors ligne, espace "
              "d'administration et analyse des donnees.")
    pdf.set_font(FONT, "B", 12); pdf.set_text_color(*BRAND); pdf.cell(0, 7, "Langues", new_x="LMARGIN", new_y="NEXT")
    body(pdf, "Malgache (langue maternelle), Francais (courant), Anglais (technique).")

    # ---- 5. REMERCIEMENTS ----
    pdf.add_page(); pdf.start_section("Remerciements"); SECTIONS.append((0, "REMERCIEMENTS", pdf.page_no()))
    pdf.set_font(FONT, "B", 16); pdf.set_text_color(*DARK); pdf.cell(0, 10, "REMERCIEMENTS", new_x="LMARGIN", new_y="NEXT"); pdf.ln(3)
    body(pdf, "Au terme de ce travail, je tiens a exprimer ma profonde gratitude a toutes les "
              "personnes qui ont contribue, de pres ou de loin, a la reussite de ce projet.")
    body(pdf, "Je remercie tout particulierement Monsieur Valerien, responsable de la matiere, "
              "pour la qualite de son enseignement et pour les connaissances transmises tout au "
              "long de cette formation.")
    body(pdf, "Ma reconnaissance s'adresse egalement a Monsieur Maminiaina Emmanuel, mon "
              "encadreur et evaluateur, pour ses conseils avises, sa disponibilite et son suivi "
              "rigoureux qui ont oriente ce memoire.")
    body(pdf, "Je remercie enfin le corps enseignant de la mention Informatique, ma famille et "
              "mes camarades de promotion pour leur soutien constant.")

    # ---- 6. SOMMAIRE (3 niveaux) ----
    pdf.add_page(); pdf.start_section("Sommaire"); SECTIONS.append((0, "SOMMAIRE", pdf.page_no()))
    pdf.set_font(FONT, "B", 16); pdf.set_text_color(*DARK); pdf.cell(0, 10, "SOMMAIRE", new_x="LMARGIN", new_y="NEXT"); pdf.ln(2)

    def render_toc(p, outline):
        p.set_font(FONT, "", 11)
        for s in outline:
            lvl = min(s.level, 2)
            p.set_font(FONT, "B" if lvl == 0 else "", 11 if lvl == 0 else 10.5)
            p.set_text_color(*(DARK if lvl == 0 else INK))
            indent = 4 + lvl * 8
            p.set_x(p.l_margin + indent)
            label = s.name
            wlab = p.get_string_width(label) + 2
            p.cell(wlab, 6.5, label)
            dots_w = p.w - p.r_margin - p.get_x() - 14
            n = max(0, int(dots_w / max(p.get_string_width("."), 0.1)))
            p.set_text_color(160, 160, 160)
            p.cell(dots_w, 6.5, "." * n)
            p.set_text_color(*INK)
            p.cell(14, 6.5, str(s.page_number - pdf._cover_pages), align="R",
                   new_x="LMARGIN", new_y="NEXT")
    pdf.insert_toc_placeholder(render_toc, pages=2)

    # ---- 7. GLOSSAIRE ----
    pdf.add_page(); pdf.start_section("Glossaire"); SECTIONS.append((0, "GLOSSAIRE", pdf.page_no()))
    pdf.set_font(FONT, "B", 16); pdf.set_text_color(*DARK); pdf.cell(0, 10, "GLOSSAIRE", new_x="LMARGIN", new_y="NEXT"); pdf.ln(2)
    glo = [
        ("Anonymat", "Propriete garantissant qu'aucune donnee ne permet d'identifier l'auteur d'un feedback."),
        ("Offline-first", "Approche ou l'application fonctionne d'abord hors ligne puis synchronise."),
        ("Feedback", "Retour ou avis exprime par un citoyen sur un service."),
        ("Synchronisation", "Mise en coherence des donnees locales avec le serveur distant."),
        ("RLS", "Row Level Security : securite au niveau des lignes d'une base de donnees."),
        ("Heatmap", "Carte de chaleur representant la densite geographique d'un phenomene."),
    ]
    for term, d in glo:
        pdf.set_font(FONT, "B", 12); pdf.set_text_color(*BRAND); pdf.set_x(pdf.l_margin)
        pdf.cell(35, LH, term)
        pdf.set_font(FONT, "", 12); pdf.set_text_color(*INK)
        pdf.multi_cell(0, LH, d, align="J")
        pdf.ln(0.5)

    # ---- 8. LISTE DES FIGURES ----
    pdf.add_page(); pdf.start_section("Liste des figures"); SECTIONS.append((0, "LISTE DES FIGURES", pdf.page_no()))
    pdf.set_font(FONT, "B", 16); pdf.set_text_color(*DARK); pdf.cell(0, 10, "LISTE DES FIGURES", new_x="LMARGIN", new_y="NEXT"); pdf.ln(2)
    pdf.set_font(FONT, "", 11); pdf.set_text_color(*INK)
    for num, title in FIG_TITLES:
        pdf.set_x(pdf.l_margin)
        lab = f"Figure {num} : {title}"
        pdf.cell(pdf.get_string_width(lab) + 2, 6.5, lab)
        dots_w = pdf.w - pdf.r_margin - pdf.get_x() - 14
        n = max(0, int(dots_w / max(pdf.get_string_width("."), 0.1)))
        pdf.set_text_color(160, 160, 160); pdf.cell(dots_w, 6.5, "." * n); pdf.set_text_color(*INK)
        pg = fig_pages.get(num, 0)
        pdf.cell(14, 6.5, str(pg - pdf._cover_pages if pg else "-"), align="R", new_x="LMARGIN", new_y="NEXT")

    # ---- 9. LISTE DES TABLEAUX ----
    pdf.add_page(); pdf.start_section("Liste des tableaux"); SECTIONS.append((0, "LISTE DES TABLEAUX", pdf.page_no()))
    pdf.set_font(FONT, "B", 16); pdf.set_text_color(*DARK); pdf.cell(0, 10, "LISTE DES TABLEAUX", new_x="LMARGIN", new_y="NEXT"); pdf.ln(2)
    pdf.set_font(FONT, "", 11); pdf.set_text_color(*INK)
    for num, title in TBL_TITLES:
        pdf.set_x(pdf.l_margin)
        lab = f"Tableau {num} : {title}"
        pdf.cell(pdf.get_string_width(lab) + 2, 6.5, lab)
        dots_w = pdf.w - pdf.r_margin - pdf.get_x() - 14
        n = max(0, int(dots_w / max(pdf.get_string_width("."), 0.1)))
        pdf.set_text_color(160, 160, 160); pdf.cell(dots_w, 6.5, "." * n); pdf.set_text_color(*INK)
        pg = tbl_pages.get(num, 0)
        pdf.cell(14, 6.5, str(pg - pdf._cover_pages if pg else "-"), align="R", new_x="LMARGIN", new_y="NEXT")

    # ---- 10. LISTE DES ABREVIATIONS ----
    pdf.add_page(); pdf.start_section("Liste des abreviations"); SECTIONS.append((0, "LISTE DES ABREVIATIONS", pdf.page_no()))
    pdf.set_font(FONT, "B", 16); pdf.set_text_color(*DARK); pdf.cell(0, 10, "LISTE DES ABREVIATIONS", new_x="LMARGIN", new_y="NEXT"); pdf.ln(2)
    abr = [("API", "Application Programming Interface"), ("APK", "Android Package Kit"),
           ("CV", "Curriculum Vitae"), ("FCM", "Firebase Cloud Messaging"),
           ("GPS", "Global Positioning System"), ("IA", "Intelligence Artificielle"),
           ("QR", "Quick Response (code)"), ("RLS", "Row Level Security"),
           ("SGBD", "Systeme de Gestion de Base de Donnees"), ("SQL", "Structured Query Language"),
           ("UML", "Unified Modeling Language"), ("UI", "User Interface")]
    for a, d in abr:
        pdf.set_font(FONT, "B", 12); pdf.set_text_color(*BRAND); pdf.set_x(pdf.l_margin)
        pdf.cell(25, LH, a); pdf.set_font(FONT, "", 12); pdf.set_text_color(*INK)
        pdf.cell(0, LH, d, new_x="LMARGIN", new_y="NEXT")

    # ---- INTRODUCTION ----
    pdf.add_page(); pdf.start_section("Introduction"); SECTIONS.append((0, "INTRODUCTION", pdf.page_no()))
    pdf.set_font(FONT, "B", 16); pdf.set_text_color(*DARK); pdf.cell(0, 10, "INTRODUCTION", new_x="LMARGIN", new_y="NEXT"); pdf.ln(3)
    body(pdf, "Contexte du projet. A Madagascar comme dans de nombreux pays africains, la qualite "
              "des services publics et prives - ecoles, hopitaux, administrations, commerces, "
              "transports - demeure une preoccupation majeure des citoyens. Pourtant, ces derniers "
              "disposent de peu de moyens fiables pour exprimer leur avis, et les responsables "
              "manquent d'outils pour recueillir, analyser et agir sur ces retours. Le present "
              "projet, FeedbackPro, propose une application mobile et une plateforme web permettant "
              "de collecter des retours totalement anonymes et d'en assurer le suivi.")
    body(pdf, "Problematiques. Comment recueillir des avis citoyens de maniere totalement anonyme, "
              "fiable et exploitable, dans un contexte de faible connectivite et de materiel modeste ? "
              "Comment garantir la coherence des donnees entre l'appareil mobile et le serveur, tout "
              "en preservant l'anonymat des auteurs ? Comment offrir aux responsables des outils de "
              "moderation et d'analyse efficaces ?")
    body(pdf, "Hypotheses. Nous faisons l'hypothese qu'une architecture offline-first, associee a une "
              "synchronisation idempotente et a une securite au niveau des lignes (RLS), permet de "
              "concilier anonymat, fiabilite et utilisation en conditions de connectivite limitee. "
              "Nous supposons egalement qu'une approche multi-secteurs augmente l'adoption et la "
              "valeur des donnees collectees.")
    body(pdf, "Plan. Ce memoire s'articule autour de six chapitres : la presentation du projet, "
              "l'analyse des besoins, l'analyse prealable, la conception, la presentation de "
              "l'application, puis l'evaluation et les suggestions. Une conclusion synthetise les "
              "apports et ouvre des perspectives.")

    # ==================== CHAPITRE I ====================
    chapter(pdf, "I", "Presentation du projet")
    h2(pdf, "1.1", "Formulation du projet")
    body(pdf, "FeedbackPro est un systeme complet de collecte et de gestion de retours (feedbacks) "
              "totalement anonymes. Il se compose d'une application mobile Flutter destinee aux "
              "citoyens et d'une plateforme web d'administration destinee aux responsables "
              "d'etablissements. L'utilisateur peut donner son avis sur n'importe quel service sans "
              "creer de compte, joindre des photos et une position, puis suivre l'avancement de son "
              "retour grace a un code anonyme.")
    h2(pdf, "1.2", "Justification de l'importance du sujet")
    body(pdf, "La voix citoyenne est un levier essentiel d'amelioration continue. En rendant "
              "l'expression simple, anonyme et accessible hors ligne, le projet favorise la "
              "participation du plus grand nombre et fournit aux decideurs des indicateurs concrets. "
              "L'anonymat leve la crainte de represailles et augmente la sincerite des retours.")
    h2(pdf, "1.3", "Objectifs et besoins utilisateur")
    body(pdf, "L'objectif general est de donner une voix anonyme et sure aux citoyens et des outils "
              "d'action efficaces aux responsables. Les objectifs specifiques sont :")
    for b in ["permettre la soumission de feedbacks anonymes, meme hors ligne ;",
              "assurer une synchronisation fiable et sans doublon vers le serveur ;",
              "offrir un espace d'administration complet (moderation, publication, export) ;",
              "proposer une recherche intelligente et des statistiques d'aide a la decision."]:
        bullet(pdf, b)
    h2(pdf, "1.4", "Moyens necessaires a la realisation du projet")
    tbl_caption(pdf, 1)
    simple_table(pdf,
                 ["Type", "Moyens"],
                 [["Humain", "Un developpeur ; un encadreur ; un responsable de matiere."],
                  ["Materiel", "Un ordinateur de developpement ; un telephone Android ; une connexion Internet."],
                  ["Logiciel", "Flutter/Dart, Supabase (PostgreSQL), Isar, Next.js, Android Studio, VS Code, Git."]],
                 [35, pdf.w - pdf.l_margin - pdf.r_margin - 35])
    h2(pdf, "1.5", "Chronogramme de realisation (diagramme de Gantt)")
    body(pdf, "La figure suivante presente la planification du projet sur neuf semaines.")
    draw_gantt(pdf)
    fig_caption(pdf, 2, fig_pages)
    h2(pdf, "1.6", "Resultats attendus")
    body(pdf, "Le projet doit aboutir a une application mobile fonctionnelle, une plateforme web "
              "d'administration responsive, une base de donnees securisee et une documentation "
              "complete. Les feedbacks doivent etre collectes de maniere anonyme, synchronises de "
              "facon fiable, et exploitables par les responsables.")

    # ==================== CHAPITRE II ====================
    chapter(pdf, "II", "Analyse des besoins")
    h2(pdf, "2.1", "Besoins des citoyens")
    for b in ["soumettre un feedback totalement anonyme, sans compte ;",
              "identifier l'etablissement grace a une recherche intelligente ou un QR code ;",
              "noter un service et decrire un probleme selon le secteur ;",
              "joindre des photos, une courte video et la localisation ;",
              "utiliser l'application hors ligne et suivre l'avancement du retour ;",
              "choisir la langue : malgache, francais ou anglais."]:
        bullet(pdf, b)
    h2(pdf, "2.2", "Besoins des responsables (administrateurs)")
    for b in ["visualiser et filtrer les feedbacks par secteur, note, statut et date ;",
              "etre alerte immediatement en cas de feedback critique ;",
              "moderer, prioriser, publier des actions correctives ;",
              "gerer les etablissements et les ameliorations ;",
              "exporter les donnees (CSV, Excel, PDF) et consulter un journal d'audit."]:
        bullet(pdf, b)
    h2(pdf, "2.3", "Besoins non fonctionnels")
    body(pdf, "Le systeme doit garantir l'anonymat par conception, fonctionner sur des appareils "
              "modestes et des connexions instables, offrir des temps de reponse courts, une "
              "interface sobre et multilingue, et une securite robuste des donnees.")

    # ==================== CHAPITRE III ====================
    chapter(pdf, "III", "Analyse prealable")
    h2(pdf, "3.1", "Analyse de l'existant")
    h3(pdf, "3.1.1", "Organisation actuelle")
    body(pdf, "Actuellement, les retours des usagers se font oralement ou via des cahiers de "
              "doleances papier. Le diagramme de flux suivant illustre ce fonctionnement.")
    draw_flux(pdf)
    fig_caption(pdf, 3, fig_pages)
    h3(pdf, "3.1.2", "Critique de l'existant")
    body(pdf, "Ce mode de fonctionnement presente de nombreuses limites : perte d'information, "
              "absence de traçabilite et de statistiques, crainte de represailles nuisant a la "
              "sincerite, et impossibilite d'un suivi ou d'une comparaison entre etablissements.")
    h3(pdf, "3.1.3", "Moyens existants")
    body(pdf, "Les moyens existants se limitent a du personnel d'accueil et a des supports papier, "
              "sans outil informatique dedie ni base de donnees centralisee.")
    h2(pdf, "3.2", "Choix de la solution")
    body(pdf, "La solution retenue est une application mobile offline-first couplee a un backend "
              "cloud securise et a une plateforme web d'administration. Ce choix repond aux "
              "contraintes d'anonymat, de connectivite et de cout.")
    h2(pdf, "3.3", "Choix de la methode de conception")
    body(pdf, "La conception s'appuie sur le langage UML et une demarche iterative et incrementale, "
              "adaptee a un projet individuel et evolutif.")
    h2(pdf, "3.4", "Choix des outils de conception")
    body(pdf, "Les diagrammes UML ont ete realises avec des outils de modelisation standard, et le "
              "suivi du code avec Git.")
    h2(pdf, "3.5", "Choix du langage de programmation")
    body(pdf, "Le langage Dart est retenu cote mobile pour sa performance et son ecosysteme Flutter ; "
              "TypeScript est utilise cote web pour la fiabilite du typage.")
    h2(pdf, "3.6", "Choix du framework")
    body(pdf, "Flutter est choisi pour le mobile (un seul code multiplateforme, interface fluide) et "
              "Next.js 15 pour le web (rendu serveur, tableau de bord rapide et responsive).")
    h2(pdf, "3.7", "Choix de l'environnement de developpement")
    body(pdf, "Le developpement s'effectue sous Android Studio et Visual Studio Code, avec un "
              "emulateur Android pour les tests.")
    h2(pdf, "3.8", "Choix du systeme de gestion de base de donnees")
    body(pdf, "Supabase (base PostgreSQL manageee) est retenu cote serveur pour sa securite par RLS, "
              "son authentification et son stockage ; Isar assure la base locale rapide cote mobile.")
    h2(pdf, "3.9", "Choix de l'architecture et du principe de developpement")
    body(pdf, "L'architecture est en couches et offline-first : l'application ecrit d'abord en local "
              "puis synchronise vers le serveur. La figure suivante en presente les grands blocs.")
    draw_archi(pdf)
    fig_caption(pdf, 4, fig_pages)

    # ==================== CHAPITRE IV ====================
    chapter(pdf, "IV", "Conception du projet")
    h2(pdf, "4.1", "Presentation de la methode de conception")
    body(pdf, "La conception suit le processus unifie simplifie : identification des acteurs et des "
              "cas d'utilisation, modelisation du domaine, puis conception detaillee (sequences, "
              "classes, paquetage, deploiement).")
    h2(pdf, "4.2", "Dictionnaire des donnees")
    tbl_caption(pdf, 2)
    simple_table(pdf, ["Champ", "Type", "Description"],
                 [["id", "uuid", "Identifiant unique du feedback"],
                  ["anon_code", "texte", "Code anonyme de suivi (sans identite)"],
                  ["sector_id", "texte", "Secteur concerne"],
                  ["rating_normalized", "entier", "Note normalisee 0-100"],
                  ["comment", "texte", "Commentaire libre"],
                  ["is_critical", "booleen", "Probleme juge critique"],
                  ["status", "enum", "Recu / en cours / resolu"],
                  ["client_uuid", "texte", "Cle d'idempotence de la synchro"],
                  ["created_at", "date", "Date de creation"]],
                 [40, 26, pdf.w - pdf.l_margin - pdf.r_margin - 66])
    h2(pdf, "4.3", "Regles de gestion")
    tbl_caption(pdf, 3)
    simple_table(pdf, ["N°", "Regle de gestion"],
                 [["RG1", "Un feedback ne contient aucune donnee identifiant son auteur."],
                  ["RG2", "Le suivi d'un feedback se fait uniquement via son code anonyme."],
                  ["RG3", "L'insertion d'un feedback est autorisee sans authentification."],
                  ["RG4", "La lecture et la moderation sont reservees aux administrateurs."],
                  ["RG5", "Un feedback critique declenche une alerte prioritaire."],
                  ["RG6", "La synchronisation est idempotente (client_uuid unique)."]],
                 [15, pdf.w - pdf.l_margin - pdf.r_margin - 15])
    h2(pdf, "4.4", "Identification des acteurs et des cas d'utilisation")
    body(pdf, "Deux acteurs principaux interagissent avec le systeme : le Citoyen (auteur anonyme de "
              "feedbacks) et l'Administrateur (moderation et pilotage).")
    h2(pdf, "4.5", "Diagramme de cas d'utilisation")
    draw_usecase(pdf)
    fig_caption(pdf, 5, fig_pages)
    h2(pdf, "4.6", "Description textuelle d'un cas d'utilisation")
    tbl_caption(pdf, 4)
    simple_table(pdf, ["Rubrique", "Contenu"],
                 [["Cas", "Soumettre un feedback"],
                  ["Acteur", "Citoyen (anonyme)"],
                  ["Pre-condition", "L'application est installee (connexion non requise)."],
                  ["Scenario nominal", "1. Rechercher l'etablissement. 2. Remplir le formulaire. "
                                       "3. Valider. 4. Ecriture locale puis synchronisation."],
                  ["Post-condition", "Le feedback est stocke localement puis envoye au serveur."],
                  ["Alternative", "Hors ligne : le feedback reste en attente et se synchronise plus tard."]],
                 [32, pdf.w - pdf.l_margin - pdf.r_margin - 32])
    h2(pdf, "4.7", "Diagramme de sequence systeme")
    draw_sequence(pdf,
                  [(0, 1, "saisir le feedback"),
                   (1, 1, "ecrire en local (Isar)"),
                   (1, 2, "upsert du feedback"),
                   (2, 1, "confirmation (201)"),
                   (1, 0, "afficher etat synchronise")],
                  ["Citoyen", "Application", "Supabase"])
    fig_caption(pdf, 6, fig_pages)
    h2(pdf, "4.8", "Modele de domaine")
    draw_domain(pdf)
    fig_caption(pdf, 7, fig_pages)
    h2(pdf, "4.9", "Architecture de l'application")
    body(pdf, "L'application mobile est structuree en couches : presentation, etat (Riverpod), "
              "domaine, donnees (repositories offline-first) et sources (Isar local, Supabase "
              "distant). Chaque couche ne depend que de la couche inferieure.")
    h2(pdf, "4.10", "Diagramme de sequence de conception (synchronisation)")
    draw_sequence(pdf,
                  [(0, 1, "syncPending()"),
                   (1, 2, "upload medias"),
                   (1, 2, "upsert (client_uuid)"),
                   (2, 1, "id serveur"),
                   (1, 0, "statut = synchronise")],
                  ["Repository", "SyncService", "Supabase"])
    fig_caption(pdf, 8, fig_pages)
    h2(pdf, "4.11", "Diagramme de classes")
    draw_class(pdf)
    fig_caption(pdf, 9, fig_pages)
    h2(pdf, "4.12", "Diagramme de paquetage")
    draw_package(pdf)
    fig_caption(pdf, 10, fig_pages)
    h2(pdf, "4.13", "Diagramme de deploiement")
    draw_deploy(pdf)
    fig_caption(pdf, 11, fig_pages)

    # ==================== CHAPITRE V ====================
    chapter(pdf, "V", "Presentation de l'application")
    body(pdf, "Ce chapitre presente, a travers des captures d'ecran commentees, les principales "
              "fonctionnalites de l'application selon une ligne de demonstration allant de la "
              "consultation a la contribution puis a l'administration.")

    def screenshot(pdf, path, num, comment):
        if not os.path.exists(path):
            return
        # image portrait, hauteur limitee
        max_h = 95
        pdf.image(path, x=pdf.w / 2 - max_h * 1080 / 2424 / 2, y=pdf.get_y() + 2, h=max_h)
        pdf.set_y(pdf.get_y() + max_h + 3)
        fig_caption(pdf, num, fig_pages)
        body(pdf, comment)

    screenshot(pdf, os.path.join(DOCS, "screenshot_v21_home.png"), 12,
               "L'ecran d'accueil presente la barre de recherche intelligente, les acces rapides "
               "(historique, ameliorations) et la grille des secteurs. Le bandeau superieur indique "
               "l'etat de synchronisation.")
    pdf.add_page()
    screenshot(pdf, os.path.join(DOCS, "screenshot_v21_form.png"), 13,
               "Le formulaire de feedback applique une validation en temps reel et une logique "
               "conditionnelle selon le secteur et la note ; seul le nom de l'etablissement est "
               "obligatoire, ce qui favorise la participation.")
    pdf.add_page()
    screenshot(pdf, os.path.join(DOCS, "screenshot_home2.png"), 14,
               "L'historique local, disponible hors ligne, affiche chaque feedback avec son etat de "
               "synchronisation (en attente, en cours, synchronise, erreur) et son code anonyme.")
    screenshot(pdf, os.path.join(DOCS, "screenshot_home.png"), 15,
               "L'espace administrateur, identique sur mobile et sur le web, offre un tableau de bord "
               "avec indicateurs cles, repartition par secteur, moderation et export des donnees.")

    # ==================== CHAPITRE VI ====================
    chapter(pdf, "VI", "Evaluation et suggestion")
    h2(pdf, "6.1", "Evaluation de l'application")
    tbl_caption(pdf, 5)
    simple_table(pdf, ["Critere", "Solutions classiques", "FeedbackPro"],
                 [["Anonymat", "Faible", "Total (par conception)"],
                  ["Hors ligne", "Non", "Oui (offline-first)"],
                  ["Cout", "Eleve", "Faible (open-source)"],
                  ["Multi-secteurs", "Rare", "Oui"],
                  ["Suivi / statistiques", "Limite", "Complet"]],
                 [40, 55, pdf.w - pdf.l_margin - pdf.r_margin - 95])
    h2(pdf, "6.2", "Contributions academiques et professionnelles")
    body(pdf, "Sur le plan academique, ce projet met en pratique la conception UML, l'architecture "
              "en couches, la securite des donnees et la gestion de projet. Sur le plan "
              "professionnel, il produit une application reelle, deployable, repondant a un besoin "
              "social concret et reutilisable dans plusieurs secteurs.")
    h2(pdf, "6.3", "Limitations de l'etude et perspectives")
    body(pdf, "Les limites actuelles concernent la dependance a une infrastructure cloud et le "
              "besoin de tests a plus grande echelle. Les perspectives incluent l'analyse par "
              "intelligence artificielle des retours, les notifications push, la cartographie de "
              "chaleur en temps reel, la traduction automatique et l'ouverture d'API publiques "
              "anonymisees pour la transparence citoyenne.")

    # ---- CONCLUSION ----
    pdf.add_page(); pdf.start_section("Conclusion"); SECTIONS.append((0, "CONCLUSION", pdf.page_no()))
    pdf.set_font(FONT, "B", 16); pdf.set_text_color(*DARK); pdf.cell(0, 10, "CONCLUSION", new_x="LMARGIN", new_y="NEXT"); pdf.ln(3)
    body(pdf, "FeedbackPro repond a un besoin concret : donner une voix anonyme et sure aux citoyens "
              "et des outils d'action efficaces aux responsables, dans un contexte de connectivite "
              "et de materiel contraints. Les choix d'architecture - anonymat par conception, "
              "offline-first, synchronisation fiable et pile technologique moderne - garantissent "
              "fiabilite, securite et adoption.")
    body(pdf, "Au-dela de sa dimension technique, ce projet illustre comment l'informatique mobile "
              "peut renforcer la participation citoyenne et l'amelioration continue des services. "
              "Les perspectives ouvertes, notamment l'intelligence artificielle et la transparence "
              "des donnees, dessinent la voie vers un outil de reference.")

    # ---- BIBLIOGRAPHIE ----
    pdf.add_page(); pdf.start_section("Bibliographie"); SECTIONS.append((0, "BIBLIOGRAPHIE", pdf.page_no()))
    pdf.set_font(FONT, "B", 16); pdf.set_text_color(*DARK); pdf.cell(0, 10, "BIBLIOGRAPHIE", new_x="LMARGIN", new_y="NEXT"); pdf.ln(3)
    for ref in ["WINDMILL, D. (2020). Flutter in Action. Manning Publications.",
                "MARTIN, R. C. (2017). Clean Architecture. Prentice Hall.",
                "ROQUES, P. (2018). UML 2 par la pratique. Eyrolles.",
                "DATE, C. J. (2004). An Introduction to Database Systems. Addison-Wesley."]:
        pdf.set_font(FONT, "", 12); pdf.set_text_color(*INK); pdf.set_x(pdf.l_margin)
        pdf.multi_cell(0, LH, ref, align="J"); pdf.ln(0.5)

    # ---- WEBOGRAPHIE ----
    pdf.add_page(); pdf.start_section("Webographie"); SECTIONS.append((0, "WEBOGRAPHIE", pdf.page_no()))
    pdf.set_font(FONT, "B", 16); pdf.set_text_color(*DARK); pdf.cell(0, 10, "WEBOGRAPHIE", new_x="LMARGIN", new_y="NEXT"); pdf.ln(3)
    for ref in ["Documentation Flutter - https://docs.flutter.dev (consulte en 2025).",
                "Documentation Supabase - https://supabase.com/docs (consulte en 2025).",
                "Documentation Isar - https://isar.dev (consulte en 2025).",
                "Documentation Next.js - https://nextjs.org/docs (consulte en 2025)."]:
        pdf.set_font(FONT, "", 12); pdf.set_text_color(*INK); pdf.set_x(pdf.l_margin)
        pdf.multi_cell(0, LH, ref, align="J"); pdf.ln(0.5)

    # ---- ANNEXES ----
    pdf.add_page(); pdf.start_section("Annexes"); SECTIONS.append((0, "ANNEXES", pdf.page_no()))
    pdf.set_font(FONT, "B", 16); pdf.set_text_color(*DARK); pdf.cell(0, 10, "ANNEXES", new_x="LMARGIN", new_y="NEXT"); pdf.ln(3)
    body(pdf, "Annexe A - Extrait de la politique de securite (RLS) : l'insertion d'un feedback est "
              "ouverte, tandis que la lecture est reservee aux administrateurs.")
    body(pdf, "Annexe B - Extrait de la structure du projet : couches core, data, features et shared, "
              "conformement au diagramme de paquetage.")

    # ---- TABLE DES MATIERES ----
    pdf.add_page(); SECTIONS.append((0, "TABLE DES MATIERES", pdf.page_no()))
    pdf.set_font(FONT, "B", 16); pdf.set_text_color(*DARK); pdf.cell(0, 10, "TABLE DES MATIERES", new_x="LMARGIN", new_y="NEXT"); pdf.ln(2)
    for lvl, name, pg in SECTIONS:
        pdf.set_font(FONT, "B" if lvl == 0 else "", 11 if lvl == 0 else 10.5)
        pdf.set_text_color(*(DARK if lvl == 0 else INK))
        pdf.set_x(pdf.l_margin + 4 + lvl * 8)
        pdf.cell(pdf.get_string_width(name) + 2, 6.3, name)
        dots_w = pdf.w - pdf.r_margin - pdf.get_x() - 14
        n = max(0, int(dots_w / max(pdf.get_string_width("."), 0.1)))
        pdf.set_text_color(160, 160, 160); pdf.cell(dots_w, 6.3, "." * n); pdf.set_text_color(*INK)
        pdf.cell(14, 6.3, str(pg - pdf._cover_pages), align="R", new_x="LMARGIN", new_y="NEXT")

    # ---- RESUME / ABSTRACT ----
    pdf.add_page(); pdf.start_section("Resume / Abstract"); SECTIONS.append((0, "RESUME / ABSTRACT", pdf.page_no()))
    pdf.set_font(FONT, "B", 16); pdf.set_text_color(*DARK); pdf.cell(0, 10, "RESUME", new_x="LMARGIN", new_y="NEXT"); pdf.ln(2)
    body(pdf, "FeedbackPro est une application mobile et web de collecte de retours citoyens "
              "totalement anonymes, concue pour l'amelioration continue des services publics et "
              "prives. Fondee sur une architecture offline-first et une securite par conception, elle "
              "permet la soumission hors ligne, la synchronisation fiable et l'administration "
              "complete des retours. Mots-cles : feedback anonyme, Flutter, Supabase, offline-first, "
              "UML, Madagascar.")
    pdf.ln(2); pdf.set_font(FONT, "B", 16); pdf.set_text_color(*DARK); pdf.cell(0, 10, "ABSTRACT", new_x="LMARGIN", new_y="NEXT"); pdf.ln(2)
    body(pdf, "FeedbackPro is a mobile and web application for collecting fully anonymous citizen "
              "feedback, designed for the continuous improvement of public and private services. "
              "Built on an offline-first architecture with security by design, it enables offline "
              "submission, reliable synchronization and complete feedback administration. Keywords: "
              "anonymous feedback, Flutter, Supabase, offline-first, UML, Madagascar.")

    return pdf, dict(FIG_REC), dict(TBL_REC)


if __name__ == "__main__":
    # Passe 1 : collecte des pages des figures/tableaux.
    _, fp, tp = build({}, {})
    # Passe 2 : rendu final avec les listes paginees.
    pdf, _, _ = build(fp, tp)
    out = os.path.join(DOCS, "FeedbackPro_Memoire.pdf")
    pdf.output(out)
    print("Memoire genere :", pdf.page_no(), "pages ->", out)

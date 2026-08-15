#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Gerador de Relatório PDF do Portfólio Behance
==============================================
Lê os dados extraídos em output/projetos_consolidados.json
e gera um documento PDF profissional, rápido e completo usando ReportLab e Pillow.
"""

import os
import json
import io
from datetime import datetime
from PIL import Image as PILImage
from reportlab.lib.pagesizes import A4
from reportlab.lib import colors
from reportlab.lib.styles import getSampleStyleSheet, ParagraphStyle
from reportlab.platypus import (
    SimpleDocTemplate, Paragraph, Spacer, Image, Table, TableStyle, PageBreak, HRFlowable
)

BASE_DIR = os.path.dirname(os.path.abspath(__file__))
OUTPUT_DIR = os.path.join(BASE_DIR, "output")
JSON_PATH = os.path.join(OUTPUT_DIR, "projetos_consolidados.json")
PDF_PATH = os.path.join(OUTPUT_DIR, "Relatorio_Portfolio_Behance_Yorrany.pdf")


def draw_header_footer(canvas, doc):
    """Adiciona cabeçalho e rodapé em todas as páginas exceto na capa."""
    if doc.page == 1:
        return
    canvas.saveState()
    canvas.setFont("Helvetica", 8)
    canvas.setFillColor(colors.HexColor("#64748b"))

    # Cabeçalho
    canvas.drawString(36, 805, "Portfólio Behance — @yorrany")
    canvas.drawRightString(A4[0] - 36, 805, "Relatório Consolidado de Projetos")
    canvas.setStrokeColor(colors.HexColor("#e2e8f0"))
    canvas.setLineWidth(0.5)
    canvas.line(36, 798, A4[0] - 36, 798)

    # Rodapé
    canvas.drawRightString(A4[0] - 36, 25, f"Página {doc.page}")
    canvas.drawString(36, 25, f"Gerado em {datetime.now().strftime('%d/%m/%Y %H:%M')}")
    canvas.line(36, 35, A4[0] - 36, 35)
    canvas.restoreState()


def get_optimized_image_flowable(img_path: str, max_w: float, max_h: float):
    """
    Otimiza a imagem em memória (redimensionando e convertendo para RGB JPEG comprimido)
    para que o PDF seja gerado instantaneamente e com tamanho otimizado.
    """
    if not os.path.exists(img_path):
        return None
    try:
        with PILImage.open(img_path) as pil_img:
            # Converte formatos especiais para RGB
            if pil_img.mode in ("RGBA", "P", "LA"):
                bg = PILImage.new("RGB", pil_img.size, (255, 255, 255))
                if pil_img.mode == "RGBA":
                    bg.paste(pil_img, mask=pil_img.split()[3])
                else:
                    bg.paste(pil_img.convert("RGBA"))
                pil_img = bg
            elif pil_img.mode != "RGB":
                pil_img = pil_img.convert("RGB")

            w, h = pil_img.size
            if w <= 0 or h <= 0:
                return None

            ratio = min(max_w / w, max_h / h)
            target_w = max(1, int(w * ratio))
            target_h = max(1, int(h * ratio))

            # Redimensiona para resolução visual adequada (2x para DPI nítido na impressão)
            pil_thumb = pil_img.resize((target_w * 2, target_h * 2), PILImage.Resampling.LANCZOS)

            img_byte_arr = io.BytesIO()
            pil_thumb.save(img_byte_arr, format="JPEG", quality=82, optimize=True)
            img_byte_arr.seek(0)

            return Image(img_byte_arr, width=target_w, height=target_h)
    except Exception as e:
        return None


def generate_pdf():
    print(f"[+] Lendo dados consolidados de {JSON_PATH}...")
    if not os.path.exists(JSON_PATH):
        print(f"[!] Erro: Arquivo {JSON_PATH} não encontrado.")
        return

    with open(JSON_PATH, "r", encoding="utf-8") as f:
        projects = json.load(f)

    print(f"[+] Processando {len(projects)} projetos...")

    doc = SimpleDocTemplate(
        PDF_PATH,
        pagesize=A4,
        leftMargin=36,
        rightMargin=36,
        topMargin=54,
        bottomMargin=45
    )

    styles = getSampleStyleSheet()

    cover_title_style = ParagraphStyle(
        "CoverTitle",
        fontName="Helvetica-Bold",
        fontSize=28,
        leading=34,
        textColor=colors.HexColor("#0f172a"),
        alignment=1,
        spaceAfter=10
    )

    cover_sub_style = ParagraphStyle(
        "CoverSubtitle",
        fontName="Helvetica",
        fontSize=12,
        leading=16,
        textColor=colors.HexColor("#475569"),
        alignment=1,
        spaceAfter=20
    )

    proj_num_style = ParagraphStyle(
        "ProjNumber",
        fontName="Helvetica-Bold",
        fontSize=9,
        leading=11,
        textColor=colors.HexColor("#0284c7"),
        spaceAfter=2
    )

    proj_title_style = ParagraphStyle(
        "ProjTitle",
        fontName="Helvetica-Bold",
        fontSize=18,
        leading=22,
        textColor=colors.HexColor("#0f172a"),
        spaceAfter=4
    )

    proj_tagline_style = ParagraphStyle(
        "ProjTagline",
        fontName="Helvetica-Oblique",
        fontSize=10.5,
        leading=14,
        textColor=colors.HexColor("#64748b"),
        spaceAfter=8
    )

    section_heading = ParagraphStyle(
        "SectionHeading",
        fontName="Helvetica-Bold",
        fontSize=11,
        leading=14,
        textColor=colors.HexColor("#1e293b"),
        spaceBefore=8,
        spaceAfter=5
    )

    body_style = ParagraphStyle(
        "BodyDark",
        fontName="Helvetica",
        fontSize=9,
        leading=13,
        textColor=colors.HexColor("#334155")
    )

    meta_label = ParagraphStyle(
        "MetaLabel",
        fontName="Helvetica-Bold",
        fontSize=8.5,
        leading=11,
        textColor=colors.HexColor("#475569")
    )

    meta_val = ParagraphStyle(
        "MetaVal",
        fontName="Helvetica",
        fontSize=8.5,
        leading=11,
        textColor=colors.HexColor("#0f172a")
    )

    story = []

    # ==========================================
    # 1. CAPA DO RELATÓRIO
    # ==========================================
    story.append(Spacer(1, 100))
    story.append(Paragraph("PORTFÓLIO DE PROJETOS", cover_title_style))
    story.append(Paragraph("Relatório Consolidado de Extração do Behance (@yorrany)", cover_sub_style))
    story.append(HRFlowable(width="50%", thickness=2, color=colors.HexColor("#0284c7"), spaceAfter=24))

    total_images = sum(p.get("total_imagens", 0) for p in projects)
    stats_data = [
        [
            Paragraph("<b>Total de Projetos</b>", meta_label),
            Paragraph(f"<b>{len(projects)}</b>", meta_val),
            Paragraph("<b>Total de Imagens</b>", meta_label),
            Paragraph(f"<b>{total_images}</b>", meta_val),
        ],
        [
            Paragraph("<b>Perfil</b>", meta_label),
            Paragraph('<a href="https://www.behance.net/yorrany" color="#0284c7">behance.net/yorrany</a>', meta_val),
            Paragraph("<b>Data da Extração</b>", meta_label),
            Paragraph(datetime.now().strftime("%d/%m/%Y"), meta_val),
        ]
    ]

    stats_table = Table(stats_data, colWidths=[120, 140, 120, 140])
    stats_table.setStyle(TableStyle([
        ('BACKGROUND', (0, 0), (-1, -1), colors.HexColor("#f8fafc")),
        ('BOX', (0, 0), (-1, -1), 1, colors.HexColor("#cbd5e1")),
        ('INNERGRID', (0, 0), (-1, -1), 0.5, colors.HexColor("#e2e8f0")),
        ('TOPPADDING', (0, 0), (-1, -1), 6),
        ('BOTTOMPADDING', (0, 0), (-1, -1), 6),
        ('LEFTPADDING', (0, 0), (-1, -1), 8),
        ('RIGHTPADDING', (0, 0), (-1, -1), 8),
    ]))
    story.append(stats_table)

    story.append(Spacer(1, 30))
    story.append(Paragraph("ÍNDICE DE PROJETOS", section_heading))
    toc_data = []
    for i, p in enumerate(projects, 1):
        tags_str = ", ".join(p.get("tags", [])[:3])
        toc_data.append([
            Paragraph(f"<b>#{i:02d}</b>", meta_label),
            Paragraph(f"<b>{p.get('titulo', 'Sem Título')}</b>", meta_val),
            Paragraph(f"{p.get('total_imagens', 0)} imagens", meta_label),
            Paragraph(f"<font color='#64748b'>{tags_str}</font>", body_style)
        ])

    toc_table = Table(toc_data, colWidths=[30, 170, 70, 250])
    toc_table.setStyle(TableStyle([
        ('INNERGRID', (0, 0), (-1, -1), 0.3, colors.HexColor("#f1f5f9")),
        ('TOPPADDING', (0, 0), (-1, -1), 3),
        ('BOTTOMPADDING', (0, 0), (-1, -1), 3),
        ('LEFTPADDING', (0, 0), (-1, -1), 3),
    ]))
    story.append(toc_table)
    story.append(PageBreak())

    # ==========================================
    # 2. PÁGINAS DOS PROJETOS
    # ==========================================
    page_width = A4[0] - 72  # 523.27 pt

    for idx, p in enumerate(projects, 1):
        print(f"   [*] Inserindo no PDF: [{idx}/{len(projects)}] {p.get('titulo')}")

        story.append(Paragraph(f"PROJETO #{idx:02d}", proj_num_style))
        story.append(Paragraph(p.get("titulo", "Sem Título"), proj_title_style))
        if p.get("slogan_tagline"):
            story.append(Paragraph(p.get("slogan_tagline"), proj_tagline_style))

        story.append(HRFlowable(width="100%", thickness=1, color=colors.HexColor("#e2e8f0"), spaceAfter=8))

        # Metadados
        tags_str = ", ".join(p.get("tags", [])) if p.get("tags") else "Nenhuma"
        meta_info = [
            [
                Paragraph("<b>Cliente:</b>", meta_label),
                Paragraph(p.get("cliente") or "Não especificado", meta_val),
                Paragraph("<b>Publicação:</b>", meta_label),
                Paragraph(p.get("data_publicacao") or "N/A", meta_val),
            ],
            [
                Paragraph("<b>Imagens:</b>", meta_label),
                Paragraph(f"{p.get('total_imagens', 0)} arquivos", meta_val),
                Paragraph("<b>Link:</b>", meta_label),
                Paragraph(f'<a href="{p.get("url_projeto")}" color="#0284c7">Acessar no Behance</a>', meta_val),
            ],
            [
                Paragraph("<b>Tags:</b>", meta_label),
                Paragraph(tags_str, meta_val),
                Paragraph("", meta_label),
                Paragraph("", meta_val),
            ]
        ]

        proj_meta_table = Table(meta_info, colWidths=[65, 195, 75, 185])
        proj_meta_table.setStyle(TableStyle([
            ('SPAN', (1, 2), (3, 2)),
            ('BACKGROUND', (0, 0), (-1, -1), colors.HexColor("#f8fafc")),
            ('BOX', (0, 0), (-1, -1), 0.5, colors.HexColor("#cbd5e1")),
            ('INNERGRID', (0, 0), (-1, -1), 0.3, colors.HexColor("#e2e8f0")),
            ('TOPPADDING', (0, 0), (-1, -1), 4),
            ('BOTTOMPADDING', (0, 0), (-1, -1), 4),
            ('LEFTPADDING', (0, 0), (-1, -1), 6),
            ('RIGHTPADDING', (0, 0), (-1, -1), 6),
        ]))
        story.append(proj_meta_table)
        story.append(Spacer(1, 8))

        # Descrição
        desc_text = p.get("descricao", "")
        if desc_text and desc_text != "Sem descrição fornecida.":
            story.append(Paragraph("<b>Descrição:</b>", section_heading))
            clean_desc = desc_text.replace("\n", "<br/>")
            story.append(Paragraph(clean_desc[:1200] + ("..." if len(clean_desc) > 1200 else ""), body_style))
            story.append(Spacer(1, 6))

        # Capa
        cover_rel = p.get("caminho_local_capa", "")
        cover_full = os.path.join(OUTPUT_DIR, cover_rel) if cover_rel else ""
        if cover_full and os.path.exists(cover_full):
            story.append(Paragraph("<b>Capa Principal:</b>", section_heading))
            img_obj = get_optimized_image_flowable(cover_full, max_w=page_width, max_h=200)
            if img_obj:
                story.append(img_obj)
                story.append(Spacer(1, 8))

        # Galeria
        gallery_rel = p.get("caminhos_locais_galeria", [])
        valid_images = [os.path.join(OUTPUT_DIR, g) for g in gallery_rel if os.path.exists(os.path.join(OUTPUT_DIR, g))]

        if valid_images:
            story.append(Paragraph(f"<b>Galeria de Imagens ({len(valid_images)} arquivos baixados):</b>", section_heading))
            col_w = (page_width - 8) / 2
            row = []
            grid_data = []

            for g_img_path in valid_images:
                img_el = get_optimized_image_flowable(g_img_path, max_w=col_w, max_h=150)
                if img_el:
                    row.append(img_el)
                    if len(row) == 2:
                        grid_data.append(row)
                        row = []
            
            if row:
                row.append(Paragraph("", body_style))
                grid_data.append(row)

            if grid_data:
                gallery_table = Table(grid_data, colWidths=[col_w, col_w])
                gallery_table.setStyle(TableStyle([
                    ('ALIGN', (0, 0), (-1, -1), 'CENTER'),
                    ('VALIGN', (0, 0), (-1, -1), 'MIDDLE'),
                    ('TOPPADDING', (0, 0), (-1, -1), 3),
                    ('BOTTOMPADDING', (0, 0), (-1, -1), 3),
                    ('LEFTPADDING', (0, 0), (-1, -1), 2),
                    ('RIGHTPADDING', (0, 0), (-1, -1), 2),
                ]))
                story.append(gallery_table)

        story.append(PageBreak())

    print("[+] Renderizando documento final...")
    doc.build(story, onFirstPage=draw_header_footer, onLaterPages=draw_header_footer)
    pdf_size_mb = os.path.getsize(PDF_PATH) / (1024 * 1024)
    print(f"\n[✓] Relatório PDF gerado com sucesso!")
    print(f"📄 Arquivo: {PDF_PATH}")
    print(f"📦 Tamanho: {pdf_size_mb:.2f} MB")
    return PDF_PATH


if __name__ == "__main__":
    generate_pdf()

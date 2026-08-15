#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Behance Project Scraper & Data Extractor
=========================================
Autor: Engenharia de Software / Automação
Descrição: Script para extração automatizada de metadados e mídias de projetos do Behance.
Suporta paginação/scroll infinito, bypass de lazy loading, download de imagens em alta resolução,
e exportação estruturada em JSON e CSV.
"""

import os
import re
import csv
import json
import time
import urllib.parse
from typing import List, Dict, Any, Optional
import requests
from bs4 import BeautifulSoup
from playwright.sync_api import sync_playwright, Page, BrowserContext
from tqdm import tqdm


# ==========================================
# CONFIGURAÇÕES GERAIS
# ==========================================
USERNAME = "yorrany"
BASE_URL = f"https://www.behance.net/{USERNAME}"
OUTPUT_DIR = os.path.join(os.path.dirname(os.path.abspath(__file__)), "output")
HEADLESS = True  # Mude para False se desejar visualizar o navegador em execução
TIMEOUT_MS = 45000

HEADERS = {
    "User-Agent": (
        "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 "
        "(KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36"
    ),
    "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8",
    "Accept-Language": "pt-BR,pt;q=0.9,en-US;q=0.8,en;q=0.7",
}


# ==========================================
# UTILITÁRIOS & HELPERS
# ==========================================
def sanitize_filename(name: str) -> str:
    """Remove caracteres especiais e normaliza nomes para pastas e arquivos."""
    if not name:
        return "projeto_sem_nome"
    # Remove caracteres inválidos no Windows/Linux/macOS
    cleaned = re.sub(r'[\\/*?:"<>|#%&{}\\<>*?/$!\'":@+`|=]', "", name)
    cleaned = re.sub(r"\s+", "_", cleaned).strip("._-")
    return cleaned[:80] if cleaned else "projeto"


def get_high_res_image_url(url: str) -> str:
    """
    Transforma URLs de miniaturas/módulos do Behance para a versão de maior resolução disponível.
    Substitui resoluções menores por disp / max_3840 / fs / 1400.
    """
    if not url or not isinstance(url, str):
        return ""
    
    clean_url = url.split("?")[0].strip()
    
    # Se for de módulos do projeto, converte para a versão 'disp' ou 'fs'
    if "project_modules" in clean_url:
        clean_url = re.sub(r"/max_\d+/", "/disp/", clean_url)
        clean_url = re.sub(r"/hd_\d+/", "/disp/", clean_url)
        clean_url = re.sub(r"/module_cover_\d+/", "/disp/", clean_url)
    elif "mir-s3-cdn-cf.behance.net/projects/" in clean_url:
        # Imagens de capa de projeto
        clean_url = re.sub(r"/max_\d+/", "/original/", clean_url)
        clean_url = re.sub(r"/\d+/", "/original/", clean_url)

    return clean_url


def download_file(url: str, dest_path: str, session: requests.Session) -> bool:
    """Baixa um arquivo de forma segura com streaming e tratamento de exceções."""
    if not url or not url.startswith("http"):
        return False
    
    os.makedirs(os.path.dirname(dest_path), exist_ok=True)
    
    # Se já existir e não estiver vazio, pula o download para economia de banda
    if os.path.exists(dest_path) and os.path.getsize(dest_path) > 0:
        return True

    try:
        response = session.get(url, headers=HEADERS, stream=True, timeout=20)
        if response.status_code == 200:
            with open(dest_path, "wb") as f:
                for chunk in response.iter_content(chunk_size=64 * 1024):
                    if chunk:
                        f.write(chunk)
            return True
        else:
            # Fallback caso a resolução modificada retorne 404
            return False
    except Exception as e:
        print(f"   [!] Erro ao baixar imagem ({url}): {e}")
        return False


# ==========================================
# EXTRAÇÃO DE LINKS DO PERFIL
# ==========================================
def extract_project_links(page: Page, profile_url: str) -> List[Dict[str, str]]:
    """
    Navega pelo perfil público do Behance, executa rolagem infinita para carregar
    todos os projetos e retorna a lista de URLs e capas prévias.
    """
    print(f"\n[+] Acessando o perfil: {profile_url}")
    page.goto(profile_url, wait_until="domcontentloaded", timeout=TIMEOUT_MS)
    
    # Aguarda o carregamento dos elementos iniciais
    try:
        page.wait_for_selector('a[href*="/gallery/"]', timeout=15000)
    except Exception:
        print("[!] Aviso: Tempo limite para seletor inicial esgotado. Tentando continuar...")

    # Scroll automático para carregar projetos paginados via AJAX / Lazy Loading
    print("[+] Carregando todos os projetos (scroll infinito)...")
    last_height = page.evaluate("document.body.scrollHeight")
    scroll_attempts = 0
    max_idle_scrolls = 4

    while scroll_attempts < max_idle_scrolls:
        page.evaluate("window.scrollTo(0, document.body.scrollHeight)")
        time.sleep(1.8)  # Pausa para carregamento dinâmico
        new_height = page.evaluate("document.body.scrollHeight")
        
        if new_height == last_height:
            scroll_attempts += 1
        else:
            scroll_attempts = 0
            last_height = new_height

    html_content = page.content()
    soup = BeautifulSoup(html_content, "html.parser")

    projects = []
    seen_urls = set()

    # Encontra cartões de projetos
    for a in soup.find_all("a", href=True):
        href = a["href"]
        if "/gallery/" in href:
            clean_url = href.split("?")[0]
            if not clean_url.startswith("http"):
                clean_url = urllib.parse.urljoin("https://www.behance.net", clean_url)
            
            # Filtra duplicatas e links indesejados
            if clean_url not in seen_urls and "/gallery/" in clean_url:
                seen_urls.add(clean_url)
                
                # Tenta capturar a imagem de capa do card do projeto
                cover_url = ""
                img_tag = a.find("img")
                if img_tag:
                    cover_url = (
                        img_tag.get("src")
                        or img_tag.get("data-src")
                        or (img_tag.get("srcset", "").split(" ")[0] if img_tag.get("srcset") else "")
                    )
                
                projects.append({
                    "url": clean_url,
                    "card_cover": get_high_res_image_url(cover_url)
                })

    print(f"[✓] Total de {len(projects)} projetos encontrados no perfil.")
    return projects


# ==========================================
# EXTRAÇÃO DE DADOS DE UM PROJETO
# ==========================================
def extract_single_project(page: Page, project_info: Dict[str, str], session: requests.Session) -> Dict[str, Any]:
    """
    Acessa a página individual de um projeto, extrai metadados completos
    e baixa todas as imagens em alta resolução.
    """
    url = project_info["url"]
    print(f"\n────────────────────────────────────────────────────────")
    print(f"[*] Processando: {url}")

    try:
        page.goto(url, wait_until="domcontentloaded", timeout=TIMEOUT_MS)
        # Rola a página para garantir o lazy-loading das imagens internas
        page.evaluate("window.scrollTo(0, document.body.scrollHeight / 2);")
        time.sleep(1.0)
        page.evaluate("window.scrollTo(0, document.body.scrollHeight);")
        time.sleep(1.0)
    except Exception as e:
        print(f"[!] Erro ao navegar na página do projeto: {e}")

    html = page.content()
    soup = BeautifulSoup(html, "html.parser")

    # 1. Tentativa de extrair Structured Data (Schema.org / JSON-LD)
    json_ld_data = {}
    for script in soup.find_all("script", type="application/ld+json"):
        try:
            parsed = json.loads(script.string or "{}")
            if isinstance(parsed, dict) and parsed.get("@type") in ["CreativeWork", "VisualArtwork", "Article"]:
                json_ld_data = parsed
                break
            elif isinstance(parsed, list):
                for item in parsed:
                    if isinstance(item, dict) and item.get("@type") in ["CreativeWork", "VisualArtwork"]:
                        json_ld_data = item
                        break
        except Exception:
            continue

    # 2. Título do Projeto
    title = ""
    if json_ld_data.get("name"):
        title = json_ld_data["name"]
    if not title:
        og_title = soup.find("meta", property="og:title")
        if og_title and og_title.get("content"):
            title = og_title["content"].replace(" :: Behance", "").strip()
    if not title:
        h1 = soup.find("h1")
        if h1:
            title = h1.get_text(strip=True)
    if not title:
        title = url.rstrip("/").split("/")[-1].replace("-", " ").title()

    # 3. Slogan / Tagline / Subtítulo
    tagline = ""
    sub_element = (
        soup.find(class_=re.compile(r"Project-subTitle|project-sub-header|project-fields", re.I))
        or soup.find("h2", class_=re.compile(r"subtitle|tagline", re.I))
    )
    if sub_element:
        tagline = sub_element.get_text(strip=True)

    # 4. Descrição do Projeto
    description = ""
    if json_ld_data.get("description"):
        description = json_ld_data["description"]
    if not description:
        og_desc = soup.find("meta", property="og:description")
        if og_desc and og_desc.get("content"):
            description = og_desc["content"].strip()
    if not description:
        desc_div = soup.find("div", class_=re.compile(r"Project-description|project-description", re.I))
        if desc_div:
            description = desc_div.get_text(separator="\n", strip=True)

    # 5. Data de Publicação / Período
    published_date = ""
    if json_ld_data.get("datePublished"):
        published_date = str(json_ld_data["datePublished"])
    if not published_date:
        time_tag = soup.find("time") or soup.find(class_=re.compile(r"published|project-published", re.I))
        if time_tag:
            published_date = time_tag.get("datetime") or time_tag.get_text(strip=True)

    # 6. Cliente
    client = ""
    # Busca por padrões de "Client:", "Cliente:" ou blocos específicos de metadados
    client_match = soup.find(text=re.compile(r"(Cliente|Client)\s*:", re.I))
    if client_match and client_match.parent:
        client = client_match.parent.get_text(strip=True)
        client = re.sub(r"^(Cliente|Client)\s*:\s*", "", client, flags=re.I)

    # 7. Tags / Categorias / Ferramentas
    tags = []
    if json_ld_data.get("keywords"):
        raw_keywords = json_ld_data["keywords"]
        if isinstance(raw_keywords, list):
            tags = [k.strip() for k in raw_keywords if k]
        elif isinstance(raw_keywords, str):
            tags = [k.strip() for k in raw_keywords.split(",") if k.strip()]

    if not tags:
        tag_elements = soup.find_all("a", href=re.compile(r"/search/projects\?field=|/search/projects/|/search\?"))
        for te in tag_elements:
            t_text = te.get_text(strip=True)
            if t_text and t_text not in tags and len(t_text) < 40:
                tags.append(t_text)

    # 8. Imagem de Capa Principal
    cover_url = ""
    if json_ld_data.get("image"):
        img_val = json_ld_data["image"]
        if isinstance(img_val, list) and img_val:
            cover_url = img_val[0]
        elif isinstance(img_val, str):
            cover_url = img_val
        elif isinstance(img_val, dict) and img_val.get("url"):
            cover_url = img_val["url"]

    if not cover_url:
        og_img = soup.find("meta", property="og:image")
        if og_img and og_img.get("content"):
            cover_url = og_img["content"]

    if not cover_url and project_info.get("card_cover"):
        cover_url = project_info["card_cover"]

    cover_url = get_high_res_image_url(cover_url)

    # 9. Imagens da Galeria Interna
    gallery_urls = []
    seen_img_urls = set()

    for img in soup.find_all("img"):
        src = (
            img.get("src")
            or img.get("data-src")
            or (img.get("srcset", "").split(" ")[0] if img.get("srcset") else "")
        )
        if not src or not isinstance(src, str):
            continue

        # Filtra ícones, avatares e assets da interface do Behance
        if any(bad in src for bad in ["avatars", "be_logo", "profile", "user_images", "icon", "svg"]):
            continue

        # Verifica se pertence à CDN de módulos de projeto do Behance
        if "project_modules" in src or "mir-s3-cdn-cf.behance.net" in src:
            high_res = get_high_res_image_url(src)
            if high_res and high_res not in seen_img_urls:
                seen_img_urls.add(high_res)
                gallery_urls.append(high_res)

    # Se a capa principal estiver na galeria, mantém para garantir integridade ou remove duplicações
    sanitized_folder = sanitize_filename(title)
    project_dir = os.path.join(OUTPUT_DIR, sanitized_folder)
    images_dir = os.path.join(project_dir, "imagens")
    os.makedirs(images_dir, exist_ok=True)

    print(f"📁 Pasta de destino: {project_dir}")
    print(f"📌 Título: {title}")
    if client:
        print(f"🏢 Cliente: {client}")
    print(f"🏷️  Tags ({len(tags)}): {', '.join(tags[:6])}{'...' if len(tags) > 6 else ''}")

    # ==========================================
    # DOWNLOAD LOCAL DAS IMAGENS
    # ==========================================
    local_cover_path = ""
    if cover_url:
        cover_ext = cover_url.split(".")[-1].split("?")[0].lower()
        if cover_ext not in ["jpg", "jpeg", "png", "webp", "gif"]:
            cover_ext = "jpg"
        dest_cover = os.path.join(project_dir, f"capa.{cover_ext}")
        if download_file(cover_url, dest_cover, session):
            local_cover_path = os.path.relpath(dest_cover, OUTPUT_DIR)

    local_gallery_paths = []
    print(f"🖼️  Baixando {len(gallery_urls)} imagens da galeria...")
    for idx, img_url in enumerate(tqdm(gallery_urls, desc="   Imagens", leave=False), start=1):
        ext = img_url.split(".")[-1].split("?")[0].lower()
        if ext not in ["jpg", "jpeg", "png", "webp", "gif"]:
            ext = "jpg"
        img_dest = os.path.join(images_dir, f"imagem_{idx:02d}.{ext}")
        if download_file(img_url, img_dest, session):
            local_gallery_paths.append(os.path.relpath(img_dest, OUTPUT_DIR))

    # Objeto consolidado do projeto
    project_data = {
        "titulo": title,
        "slogan_tagline": tagline,
        "cliente": client,
        "data_publicacao": published_date,
        "tags": tags,
        "descricao": description,
        "url_projeto": url,
        "url_capa": cover_url,
        "caminho_local_capa": local_cover_path,
        "urls_imagens_galeria": gallery_urls,
        "caminhos_locais_galeria": local_gallery_paths,
        "total_imagens": len(gallery_urls)
    }

    # Salva JSON individual dentro da pasta do projeto
    with open(os.path.join(project_dir, "dados_projeto.json"), "w", encoding="utf-8") as f:
        json.dump(project_data, f, ensure_ascii=False, indent=2)

    return project_data


# ==========================================
# EXPORTAÇÃO CONSOLIDADA (JSON & CSV)
# ==========================================
def export_consolidated_data(all_projects: List[Dict[str, Any]], output_dir: str):
    """Exporta todos os projetos consolidados em formatos JSON e CSV prontos para CMS."""
    os.makedirs(output_dir, exist_ok=True)
    
    # 1. Exportação JSON
    json_path = os.path.join(output_dir, "projetos_consolidados.json")
    with open(json_path, "w", encoding="utf-8") as f:
        json.dump(all_projects, f, ensure_ascii=False, indent=2)
    print(f"\n[✓] Arquivo JSON consolidado salvo em: {json_path}")

    # 2. Exportação CSV
    csv_path = os.path.join(output_dir, "projetos_consolidados.csv")
    csv_headers = [
        "titulo",
        "slogan_tagline",
        "cliente",
        "data_publicacao",
        "tags",
        "descricao",
        "url_projeto",
        "url_capa",
        "caminho_local_capa",
        "total_imagens",
        "urls_imagens_galeria",
        "caminhos_locais_galeria"
    ]

    with open(csv_path, "w", encoding="utf-8-sig", newline="") as f:
        writer = csv.DictWriter(f, fieldnames=csv_headers)
        writer.writeheader()
        for p in all_projects:
            row = p.copy()
            # Converte listas para strings formatadas para o CSV
            row["tags"] = ", ".join(row.get("tags", []))
            row["urls_imagens_galeria"] = " | ".join(row.get("urls_imagens_galeria", []))
            row["caminhos_locais_galeria"] = " | ".join(row.get("caminhos_locais_galeria", []))
            writer.writerow(row)
            
    print(f"[✓] Arquivo CSV consolidado salvo em: {csv_path}")


# ==========================================
# GERAÇÃO DE RELATÓRIO PDF ELEGANTE
# ==========================================
def generate_pdf_report(all_projects: List[Dict[str, Any]], output_dir: str, page: Page) -> str:
    """Gera um documento PDF profissional e estruturado com todos os dados e imagens dos projetos."""
    pdf_path = os.path.join(output_dir, "Relatorio_Portfolio_Behance_Yorrany.pdf")
    html_report_path = os.path.join(output_dir, "relatorio_preview.html")

    print(f"\n[+] Gerando relatório PDF consolidado...")

    # Constrói o HTML com CSS moderno e responsivo para impressão/PDF
    html_sections = []
    
    for idx, p in enumerate(all_projects, start=1):
        cover_rel = p.get("caminho_local_capa", "")
        cover_full_path = os.path.join(output_dir, cover_rel) if cover_rel else ""
        cover_uri = f"file://{cover_full_path}" if cover_full_path and os.path.exists(cover_full_path) else p.get("url_capa", "")

        tags_html = "".join([f'<span class="badge">{tag}</span>' for tag in p.get("tags", [])])

        gallery_html_items = []
        for g_rel in p.get("caminhos_locais_galeria", []):
            g_full = os.path.join(output_dir, g_rel)
            if os.path.exists(g_full):
                gallery_html_items.append(f'<div class="gallery-item"><img src="file://{g_full}" alt="Imagem do Projeto" /></div>')

        desc_formatted = (p.get("descricao", "") or "Sem descrição fornecida.").replace("\n", "<br/>")

        section = f"""
        <div class="project-card">
            <div class="project-header">
                <span class="project-number">PROJETO #{idx:02d}</span>
                <h2 class="project-title">{p.get("titulo", "Sem Título")}</h2>
                {f'<p class="project-tagline">{p.get("slogan_tagline")}</p>' if p.get("slogan_tagline") else ''}
            </div>

            <div class="meta-grid">
                <div class="meta-box"><strong>Cliente:</strong> {p.get("cliente") or "Não especificado"}</div>
                <div class="meta-box"><strong>Publicação:</strong> {p.get("data_publicacao") or "N/A"}</div>
                <div class="meta-box"><strong>Total Imagens:</strong> {p.get("total_imagens", 0)}</div>
                <div class="meta-box"><strong>Link:</strong> <a href="{p.get("url_projeto")}" target="_blank">Acessar no Behance</a></div>
            </div>

            {f'<div class="tags-container">{tags_html}</div>' if tags_html else ''}

            <div class="content-body">
                <div class="cover-wrapper">
                    <h3>Capa Principal</h3>
                    {f'<img class="cover-img" src="{cover_uri}" alt="Capa" />' if cover_uri else '<p>Sem capa</p>'}
                </div>
                <div class="description-wrapper">
                    <h3>Descrição do Projeto</h3>
                    <div class="description-text">{desc_formatted}</div>
                </div>
            </div>

            {f'''
            <div class="gallery-section">
                <h3>Galeria de Mídias ({len(gallery_html_items)} imagens)</h3>
                <div class="gallery-grid">
                    {''.join(gallery_html_items)}
                </div>
            </div>
            ''' if gallery_html_items else ''}
        </div>
        """
        html_sections.append(section)

    full_html = f"""<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Portfólio Behance - {USERNAME}</title>
    <style>
        @page {{
            size: A4;
            margin: 15mm 12mm 15mm 12mm;
            @bottom-right {{
                content: counter(page);
            }}
        }}
        * {{
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }}
        body {{
            font-family: 'Segoe UI', Roboto, Helvetica, Arial, sans-serif;
            color: #1e293b;
            background-color: #ffffff;
            font-size: 13px;
            line-height: 1.5;
        }}
        .header-cover {{
            padding: 40px 20px;
            background: #0f172a;
            color: #ffffff;
            border-radius: 12px;
            margin-bottom: 30px;
            page-break-after: always;
            display: flex;
            flex-direction: column;
            justify-content: center;
            min-height: 250mm;
            text-align: center;
        }}
        .header-cover h1 {{
            font-size: 38px;
            font-weight: 800;
            letter-spacing: -0.5px;
            margin-bottom: 12px;
            color: #38bdf8;
        }}
        .header-cover p {{
            font-size: 16px;
            color: #94a3b8;
            margin-bottom: 24px;
        }}
        .header-stats {{
            display: flex;
            justify-content: center;
            gap: 20px;
            margin-top: 30px;
        }}
        .stat-badge {{
            background: #1e293b;
            border: 1px solid #334155;
            padding: 12px 24px;
            border-radius: 8px;
            font-size: 14px;
        }}
        .stat-badge strong {{
            display: block;
            font-size: 22px;
            color: #ffffff;
        }}
        .project-card {{
            page-break-after: always;
            break-inside: avoid;
            padding-top: 10px;
            margin-bottom: 30px;
        }}
        .project-header {{
            border-bottom: 2px solid #e2e8f0;
            padding-bottom: 12px;
            margin-bottom: 16px;
        }}
        .project-number {{
            font-size: 11px;
            font-weight: 700;
            letter-spacing: 1px;
            color: #0284c7;
            text-transform: uppercase;
        }}
        .project-title {{
            font-size: 24px;
            font-weight: 700;
            color: #0f172a;
            margin-top: 2px;
        }}
        .project-tagline {{
            font-size: 14px;
            color: #64748b;
            margin-top: 4px;
        }}
        .meta-grid {{
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 10px;
            margin-bottom: 16px;
        }}
        .meta-box {{
            background: #f8fafc;
            border: 1px solid #e2e8f0;
            padding: 8px 12px;
            border-radius: 6px;
            font-size: 12px;
        }}
        .meta-box a {{
            color: #0284c7;
            text-decoration: none;
            font-weight: 600;
        }}
        .tags-container {{
            display: flex;
            flex-wrap: wrap;
            gap: 6px;
            margin-bottom: 16px;
        }}
        .badge {{
            background: #e0f2fe;
            color: #0369a1;
            padding: 3px 10px;
            border-radius: 20px;
            font-size: 11px;
            font-weight: 600;
        }}
        .content-body {{
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
            margin-bottom: 20px;
        }}
        .cover-wrapper h3, .description-wrapper h3, .gallery-section h3 {{
            font-size: 14px;
            font-weight: 700;
            color: #334155;
            margin-bottom: 8px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }}
        .cover-img {{
            width: 100%;
            max-height: 320px;
            object-fit: cover;
            border-radius: 8px;
            border: 1px solid #e2e8f0;
        }}
        .description-text {{
            background: #f8fafc;
            border: 1px solid #e2e8f0;
            padding: 14px;
            border-radius: 8px;
            font-size: 12px;
            color: #334155;
            max-height: 320px;
            overflow: hidden;
            line-height: 1.6;
        }}
        .gallery-section {{
            margin-top: 15px;
        }}
        .gallery-grid {{
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 10px;
            margin-top: 10px;
        }}
        .gallery-item img {{
            width: 100%;
            height: 140px;
            object-fit: cover;
            border-radius: 6px;
            border: 1px solid #e2e8f0;
        }}
    </style>
</head>
<body>
    <div class="header-cover">
        <h1>PORTFÓLIO DE PROJETOS</h1>
        <p>Relatório Consolidado de Extração do Behance • @{USERNAME}</p>
        <div class="header-stats">
            <div class="stat-badge">
                <strong>{len(all_projects)}</strong>
                Projetos Extraídos
            </div>
            <div class="stat-badge">
                <strong>{sum(p.get('total_imagens', 0) for p in all_projects)}</strong>
                Imagens Baixadas
            </div>
            <div class="stat-badge">
                <strong>{time.strftime('%d/%m/%Y')}</strong>
                Data da Extração
            </div>
        </div>
    </div>

    {''.join(html_sections)}
</body>
</html>
"""
    # Salva preview HTML
    with open(html_report_path, "w", encoding="utf-8") as f:
        f.write(full_html)

    # Converte HTML para PDF usando o Chromium do Playwright
    page.goto(f"file://{html_report_path}", wait_until="load")
    page.pdf(
        path=pdf_path,
        format="A4",
        print_background=True,
        margin={"top": "15mm", "bottom": "15mm", "left": "12mm", "right": "12mm"}
    )

    print(f"[✓] Relatório PDF gerado com sucesso em: {pdf_path}")
    return pdf_path


# ==========================================
# FLUXO PRINCIPAL
# ==========================================
def main():
    print("=" * 60)
    print("      BEHANCE SCRAPER & AUTOMATED DATA EXTRACTOR      ")
    print(f"      Perfil Alvo: https://www.behance.net/{USERNAME} ")
    print("=" * 60)

    os.makedirs(OUTPUT_DIR, exist_ok=True)
    session = requests.Session()

    with sync_playwright() as p:
        print("[+] Inicializando Chromium automatizado via Playwright...")
        browser = p.chromium.launch(
            headless=HEADLESS,
            args=[
                "--disable-blink-features=AutomationControlled",
                "--no-sandbox",
                "--disable-setuid-sandbox",
            ]
        )
        
        context: BrowserContext = browser.new_context(
            user_agent=HEADERS["User-Agent"],
            viewport={"width": 1920, "height": 1080},
            locale="pt-BR"
        )
        page = context.new_page()

        # 1. Obtém todas as URLs de projetos do perfil
        projects_to_scrape = extract_project_links(page, BASE_URL)

        if not projects_to_scrape:
            print("[!] Nenhum projeto encontrado. Verifique se o perfil é público ou se a URL está correta.")
            browser.close()
            return

        # 2. Itera sobre cada projeto e extrai os dados
        all_extracted_data = []
        for index, proj in enumerate(projects_to_scrape, start=1):
            print(f"\n>>> [{index}/{len(projects_to_scrape)}] Extraindo dados do projeto...")
            data = extract_single_project(page, proj, session)
            all_extracted_data.append(data)
            time.sleep(1.0)  # Pequeno intervalo respeitoso entre requisições

        # 3. Consolidação e exportação final (JSON & CSV)
        export_consolidated_data(all_extracted_data, OUTPUT_DIR)

        # 4. Geração do relatório PDF consolidado
        pdf_file = generate_pdf_report(all_extracted_data, OUTPUT_DIR, page)

        browser.close()

    print("\n" + "=" * 60)
    print(f"🎉 Extração e geração de relatório concluídas com sucesso!")
    print(f"📁 Pasta dos arquivos: {OUTPUT_DIR}")
    print(f"📄 Arquivo PDF gerado: {pdf_file}")
    print("=" * 60)


if __name__ == "__main__":
    main()


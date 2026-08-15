import os
import re
import requests
from bs4 import BeautifulSoup
from playwright.sync_api import sync_playwright

USERNAME = "yorrany"
BASE_URL = f"https://www.behance.net/{USERNAME}"

HEADERS = {
    "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36",
    "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8"
}

def sanitize_folder_name(name):
    """Remove caracteres inválidos do nome de pastas/arquivos."""
    return re.sub(r'[\\/*?:"<>|]', "", name).strip()

def get_project_urls(page, username):
    """Raspa a página principal do perfil para extrair todos os links dos projetos."""
    print(f"🔍 Acessando perfil do Behance: {BASE_URL}")
    page.goto(BASE_URL, wait_until='domcontentloaded')
    
    try:
        # Espera carregar os links de projetos
        page.wait_for_selector('a[href*="/gallery/"]', timeout=10000)
    except Exception:
        pass

    html = page.content()
    soup = BeautifulSoup(html, "html.parser")
    project_links = set()

    for a in soup.find_all("a", href=True):
        href = a.get("href")
        if href and "/gallery/" in href:
            clean_url = href.split("?")[0]
            if not clean_url.startswith("http"):
                clean_url = "https://www.behance.net" + clean_url
            project_links.add(clean_url)

    print(f"✅ Encontrados {len(project_links)} projetos.")
    return list(project_links)

def download_project(page, project_url):
    """Baixa o conteúdo, descrições e mídias de um projeto específico."""
    print(f"\n📂 Processando: {project_url}")
    
    try:
        page.goto(project_url, wait_until='networkidle', timeout=30000)
    except Exception as e:
        print(f"⚠️ Não foi possível carregar a página do projeto: {e}")

    html = page.content()
    soup = BeautifulSoup(html, "html.parser")

    # Nome do projeto
    title_tag = soup.find("h1") or soup.find("title")
    title = title_tag.text.replace(" :: Behance", "").strip() if title_tag else "projeto_sem_nome"
    folder_name = sanitize_folder_name(title)

    # Cria pasta do projeto
    os.makedirs(folder_name, exist_ok=True)
    print(f"📁 Pasta criada: ./{folder_name}")

    # Extrai descrição / textos
    description_elements = soup.find_all(["p", "span", "h2", "h3"])
    texts = [elem.text.strip() for elem in description_elements if len(elem.text.strip()) > 15]

    with open(os.path.join(folder_name, "descricao.txt"), "w", encoding="utf-8") as f:
        f.write(f"Título: {title}\nURL: {project_url}\n\n---\n\n")
        f.write("\n".join(texts))

    # Extrai e baixa as imagens
    images = soup.find_all("img")
    img_urls = set()

    for img in images:
        src = img.get("src") or img.get("data-src") or img.get("srcset")
        if src:
            # Pega apenas o primeiro URL caso seja um srcset
            src = src.split(" ")[0]
            
            if "project_modules" in src or "mir-s3-cdn-cf.behance.net" in src:
                # Tenta pegar a versão em maior resolução
                high_res_src = re.sub(r'/max_\d+/', '/disp/', src)
                if not high_res_src.startswith("http"):
                    continue
                img_urls.add(high_res_src)

    print(f"🖼️ Baixando {len(img_urls)} imagens...")
    for idx, img_url in enumerate(img_urls, start=1):
        try:
            # Downloads das imagens costumam passar liso pelo requests se a URL for da CDN
            img_data = requests.get(img_url, headers=HEADERS, timeout=10).content
            ext = img_url.split(".")[-1].split("?")[0]
            if ext.lower() not in ["jpg", "jpeg", "png", "webp", "gif"]:
                ext = "jpg"

            file_path = os.path.join(folder_name, f"imagem_{idx:02d}.{ext}")
            with open(file_path, "wb") as f:
                f.write(img_data)
        except Exception as e:
            print(f"❌ Erro ao baixar imagem {img_url}: {e}")

def main():
    with sync_playwright() as p:
        print("🚀 Iniciando navegador invisível (Playwright)...")
        browser = p.chromium.launch(headless=True)
        page = browser.new_page(user_agent=HEADERS["User-Agent"])
        
        projects = get_project_urls(page, USERNAME)
        if not projects:
            print("Nenhum projeto encontrado. Verifique se a conta é pública ou se a URL está correta.")
            browser.close()
            return

        for url in projects:
            download_project(page, url)

        print("\n🎉 Download concluído para todos os projetos!")
        browser.close()

if __name__ == "__main__":
    main()

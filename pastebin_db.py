import os
import requests
from bs4 import BeautifulSoup
from googlesearch import search

BING_SEARCH_URL = "https://www.bing.com/search"
PASTEBIN_RAW_URL = "https://pastebin.com/raw/"
DOWNLOAD_DIR = "pastes"


def search_pastebin(keyword, max_results=10):
    # Utilise Google Search pour trouver des liens pastebin
    query = f"site:pastebin.com {keyword}"
    results = []
    try:
        for url in search(query, num_results=max_results, lang="fr"):
            if url.startswith("https://pastebin.com/") or url.startswith("http://pastebin.com/"):
                paste_id = url.split("pastebin.com/")[-1].split("/")[0]
                if len(paste_id) == 8 or len(paste_id) == 10:
                    if paste_id not in [r["id"] for r in results]:
                        results.append({"id": paste_id, "url": url, "title": paste_id})
            if len(results) >= max_results:
                break
    except Exception as e:
        print(f"[ERREUR] Recherche Google impossible: {e}")
    if not results:
        print("[DEBUG] Aucun résultat trouvé sur Google.")
    return results


def download_paste(paste_id):
    url = PASTEBIN_RAW_URL + paste_id
    print(f"[DEBUG] Téléchargement de {url}")
    try:
        resp = requests.get(url, timeout=10)
        print(f"[DEBUG] Statut HTTP: {resp.status_code}")
        print(f"[DEBUG] 100 premiers caractères: {resp.text[:100]}")
        if resp.status_code == 200:
            return resp.text
        else:
            print(f"[DEBUG] Erreur HTTP {resp.status_code} pour {url}")
    except Exception as e:
        print(f"[DEBUG] Exception lors du téléchargement de {url}: {e}")
    return None


def search_and_preview(keyword, max_results=10, preview_lines=10):
    """
    Recherche des pastes, retourne une liste de dicts avec id, url, title, preview (10 lignes max).
    """
    results = search_pastebin(keyword, max_results)
    previews = []
    for r in results:
        preview = download_paste(r["id"])
        if preview and not preview.lower().startswith("error"):
            lines = preview.splitlines()[:preview_lines]
            preview_text = "\n".join(lines)
        else:
            preview_text = None
        previews.append({
            "id": r["id"],
            "url": r["url"],
            "title": r["title"],
            "preview": preview_text
        })
    return previews


def download_selected(keyword, previews, selected_indexes):
    """
    Télécharge les pastes sélectionnés (par index dans la liste previews) dans le dossier du mot-clé.
    """
    folder_name = keyword.strip().replace(" ", "_")
    download_dir = os.path.join(DOWNLOAD_DIR, folder_name)
    os.makedirs(download_dir, exist_ok=True)
    for idx in selected_indexes:
        paste = previews[idx]
        print(f"[DEBUG] Téléchargement du paste {paste['id']} ({paste['url']})...")
        content = download_paste(paste["id"])
        if content and not content.lower().startswith("error"):
            filename = os.path.join(download_dir, f"{paste['id']}.txt")
            try:
                with open(filename, "w", encoding="utf-8") as f:
                    f.write(content)
                print(f"Téléchargé: {filename}")
            except Exception as e:
                print(f"[DEBUG] Erreur lors de l'écriture du fichier {filename}: {e}")
        else:
            print(f"Erreur lors du téléchargement de {paste['id']} (privé, supprimé ou inaccessible)")
    print(f"\nTerminé. Les fichiers sont dans le dossier '{download_dir}'.")


# Mode CLI inchangé
if __name__ == "__main__":
    keyword = input("Mot-clé à rechercher sur Pastebin: ")
    print(f"Recherche de pastes pour: {keyword}\n")
    previews = search_and_preview(keyword)
    for i, p in enumerate(previews):
        print(f"[{i+1}] {p['title'] or p['id']} - {p['url']}")
        if p['preview']:
            print(f"--- Aperçu des 10 premières lignes ---\n{p['preview']}\n------------------------------")
        else:
            print("[Aperçu indisponible : paste privé, supprimé ou inaccessible]")
    choices = input("Numéros des pastes à télécharger (ex: 1,3,5): ")
    selected = set()
    for part in choices.split(","):
        try:
            idx = int(part.strip()) - 1
            if 0 <= idx < len(previews):
                selected.add(idx)
        except ValueError:
            continue
    download_selected(keyword, previews, selected)

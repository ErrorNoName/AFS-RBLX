"""
Script pour créer un bundle .lua unique de SriBlox Modern
Combine tous les fichiers compilés en un seul script exécutable
"""
import os
from pathlib import Path

OUT_DIR = Path("out")
BUNDLE_FILE = Path("../SriBloxModern.lua")

# Ordre de chargement des modules
MODULE_ORDER = [
    "types.lua",
    "themes/themes.lua",
    "store/actions.lua",
    "store/reducer.lua",
    "store/store.lua",
    "services/scriptblox.service.lua",
    "components/Acrylic.lua",
    "components/SearchBar.lua",
    "components/ScriptCard.lua",
    "App.lua",
    "main.client.lua",
]

def read_lua_file(filepath: Path) -> str:
    """Lit un fichier .lua et retourne son contenu"""
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()
    return content

def create_bundle():
    """Crée le bundle .lua unique"""
    print("🔨 Création du bundle SriBloxModern.lua...")
    
    bundle_content = """--[[
	SriBlox Modern - Interface TypeScript avancée
	Compilé avec roblox-ts | Roact + Rodux + Flipper
	
	Features:
	- Recherche ScriptBlox API
	- 4 thèmes (Dark, Light, Colorful, Cyberpunk)
	- Animations Flipper physics
	- Material Design 3
	- State management Rodux
	
	Toggle: F6
]]

-- Protection GUI
local gui
repeat wait() until game:IsLoaded()

"""
    
    # Ajout de chaque module
    for module_path in MODULE_ORDER:
        full_path = OUT_DIR / module_path
        if not full_path.exists():
            print(f"⚠️  Fichier manquant: {module_path}")
            continue
            
        print(f"📦 Ajout: {module_path}")
        content = read_lua_file(full_path)
        
        # Nettoie les require() générés par roblox-ts
        # car on bundle tout ensemble
        content = content.replace('local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))', '-- Bundled module')
        
        bundle_content += f"\n-- ===== MODULE: {module_path} =====\n"
        bundle_content += content
        bundle_content += f"\n-- ===== END {module_path} =====\n\n"
    
    # Ajout du code d'initialisation
    bundle_content += """
-- Protection et initialisation
if syn and syn.protect_gui then
    syn.protect_gui(gui)
end

print("✅ SriBlox Modern loaded - Press F6 to toggle")
"""
    
    # Écriture du bundle
    with open(BUNDLE_FILE, 'w', encoding='utf-8') as f:
        f.write(bundle_content)
    
    file_size = BUNDLE_FILE.stat().st_size / 1024
    print(f"✅ Bundle créé: {BUNDLE_FILE} ({file_size:.2f} KB)")

if __name__ == "__main__":
    os.chdir(Path(__file__).parent)
    create_bundle()

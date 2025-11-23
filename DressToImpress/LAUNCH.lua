--[[
    🚀 DTI Hub - Démarrage Rapide
    
    Choisissez votre interface préférée:
    1. Rayfield UI (Moderne, coloré)
    2. Orion UI (Classique, stable)
]]

print("🎀 Dress To Impress Hub - Chargement...")

-- Détection automatique de l'interface disponible
local function loadUI()
    print("🔍 Détection de l'interface...")
    
    -- Essayer de charger Rayfield
    local success, rayfield = pcall(function()
        return loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
    end)
    
    if success and rayfield then
        print("✅ Rayfield détecté - Chargement de l'interface moderne...")
        loadstring(readfile("DTI_Hub_Ultimate.lua"))()
        return
    end
    
    -- Sinon, charger Orion
    print("✅ Chargement de l'interface Orion...")
    loadstring(readfile("DTI_Hub_Orion.lua"))()
end

-- Lancement
loadUI()

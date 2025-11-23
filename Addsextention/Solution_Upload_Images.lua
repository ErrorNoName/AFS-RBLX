--[[
    ╔═══════════════════════════════════════════════════════════╗
    ║   SOLUTION: Upload Images Roblox Assets                 ║
    ║   Génère automatiquement code avec rbxassetid://        ║
    ╚═══════════════════════════════════════════════════════════╝
    
    PROBLÈME IDENTIFIÉ:
    - Roblox bloque URLs externes (A-Ads)
    - getcustomasset() crash avec chemins relatifs
    
    SOLUTION RECOMMANDÉE:
    1. Télécharger images A-Ads
    2. Upload sur roblox.com/develop → Images
    3. Copier Asset IDs
    4. Utiliser code ci-dessous
]]

print("╔════════════════════════════════════════════════════════════╗")
print("║     PRÉPARATION IMAGES ROBLOX ASSETS                      ║")
print("╚════════════════════════════════════════════════════════════╝\n")

-- ===== TÉLÉCHARGEMENT IMAGES =====
local AD_UNIT_ID = "2417103"
local images = {}

print("📥 Téléchargement images A-Ads...\n")

local testUrls = {
    "https://static.a-ads.com/a-ads-banners/531599/970x250",
    "https://static.a-ads.com/a-ads-advert-illustrations/442/475x250",
}

for i, url in ipairs(testUrls) do
    print(string.format("🔗 Image %d: %s", i, url))
    
    local success, imageData = pcall(function()
        local request = syn and syn.request or http_request or request
        if not request then
            error("request() non disponible")
        end
        
        local response = request({
            Url = url,
            Method = "GET",
        })
        
        if response.StatusCode == 200 then
            return response.Body
        else
            error("HTTP " .. response.StatusCode)
        end
    end)
    
    if success and imageData then
        local filename = "aads_image_" .. i .. ".png"
        
        if writefile then
            writefile(filename, imageData)
            print("  ✅ Sauvegardée:", filename, "(" .. #imageData .. " bytes)")
            
            table.insert(images, {
                index = i,
                filename = filename,
                url = url,
                size = #imageData,
            })
        else
            print("  ❌ writefile() non disponible")
        end
    else
        print("  ❌ Erreur:", imageData)
    end
    
    print()
end

-- ===== INSTRUCTIONS =====
print("╔════════════════════════════════════════════════════════════╗")
print("║              ÉTAPES SUIVANTES (MANUEL)                    ║")
print("╚════════════════════════════════════════════════════════════╝\n")

if #images > 0 then
    print("✅ " .. #images .. " image(s) téléchargée(s)!\n")
    
    print("📋 ÉTAPE 1: Localiser fichiers")
    print("   Les fichiers sont dans votre dossier workspace/executor:\n")
    
    for i, img in ipairs(images) do
        print(string.format("   %d. %s (%d KB)", i, img.filename, math.floor(img.size / 1024)))
    end
    
    print("\n📋 ÉTAPE 2: Upload sur Roblox")
    print("   1. Aller sur: https://create.roblox.com/dashboard/creations")
    print("   2. Cliquer 'Development Items' → 'Images'")
    print("   3. Cliquer 'Upload Image'")
    print("   4. Sélectionner CHAQUE fichier ci-dessus")
    print("   5. Nom suggéré: 'AAds_Pub_1', 'AAds_Pub_2', etc.")
    print("   6. Attendre modération (~5 minutes)\n")
    
    print("📋 ÉTAPE 3: Copier Asset IDs")
    print("   1. Une fois approuvé, cliquer chaque image")
    print("   2. Copier l'ID dans l'URL (ex: 123456789)")
    print("   3. Garder ces IDs pour l'étape suivante\n")
    
    print("📋 ÉTAPE 4: Code Final\n")
    print("   Remplacer lignes 124-129 de Integration_Simple_AAds.lua par:\n")
    print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
    print("-- Fallback: Assets Roblox uploadés")
    print("adsList = {")
    print("    {Image = 'rbxassetid://VOTRE_ID_IMAGE_1', Width = 970, Height = 250},")
    print("    {Image = 'rbxassetid://VOTRE_ID_IMAGE_2', Width = 475, Height = 250},")
    print("}")
    print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n")
    
    print("💡 EXEMPLE COMPLET:\n")
    print("   Si vos IDs sont 987654321 et 123456789:")
    print("   adsList = {")
    print("       {Image = 'rbxassetid://987654321', Width = 970, Height = 250},")
    print("       {Image = 'rbxassetid://123456789', Width = 475, Height = 250},")
    print("   }\n")
    
    print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
    print("⚡ AVANTAGES:")
    print("   ✅ 100% compatible Roblox (pas de blocage)")
    print("   ✅ Chargement instant (CDN Roblox)")
    print("   ✅ Pas de dépendance executor")
    print("   ✅ Fonctionne sur TOUS les jeux\n")
    
    print("⚠️ INCONVÉNIENT:")
    print("   ❌ Setup manuel initial (une seule fois)")
    print("   ❌ Modération Roblox (~5 min d'attente)\n")
    
else
    print("❌ Aucune image téléchargée")
    print("💡 Vérifier que request() fonctionne dans votre executor\n")
end

print("╔════════════════════════════════════════════════════════════╗")
print("║           ALTERNATIVE: DISCORD CDN (RAPIDE)               ║")
print("╚════════════════════════════════════════════════════════════╝\n")

print("Si vous ne voulez PAS attendre modération Roblox:\n")
print("📋 ÉTAPE 1: Upload sur Discord")
print("   1. Ouvrir Discord (n'importe quel serveur/DM)")
print("   2. Glisser-déposer images téléchargées")
print("   3. Clic droit → 'Copier le lien'")
print("   4. URL sera: https://cdn.discordapp.com/attachments/...\n")

print("📋 ÉTAPE 2: Code Discord CDN\n")
print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
print("adsList = {")
print("    {Image = 'https://cdn.discordapp.com/attachments/VOTRE_LIEN_1', Width = 970, Height = 250},")
print("    {Image = 'https://cdn.discordapp.com/attachments/VOTRE_LIEN_2', Width = 475, Height = 250},")
print("}")
print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n")

print("⚡ AVANTAGES DISCORD:")
print("   ✅ Instant (pas de modération)")
print("   ✅ Fonctionne dans CERTAINS executors (Synapse, KRNL)")
print("   ❌ Peut ne pas marcher selon executor/jeu\n")

print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
print("💾 Fichiers générés dans votre dossier executor")
print("📁 Chercher: aads_image_1.png, aads_image_2.png")
print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")

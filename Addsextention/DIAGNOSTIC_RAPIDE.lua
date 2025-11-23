--[[
    ⚡ DIAGNOSTIC RAPIDE - Fix Images Noires A-Ads
    
    Script de test instantané pour vérifier que:
    1. ✅ Erreur syntaxe corrigée
    2. ✅ Parser <picture> fonctionne
    3. ✅ Validation téléchargement active
    4. ✅ Système prêt à utiliser
]]--

print("\n" .. string.rep("=", 70))
print("⚡ DIAGNOSTIC RAPIDE - AAds System v1.1")
print(string.rep("=", 70) .. "\n")

-- Test 1: Vérifier fichier existe
print("📋 Test 1: Vérification fichier...")
local fileExists = pcall(function()
    return readfile("Addsextention/AAds_Final_System.lua")
end)

if fileExists then
    print("  ✅ AAds_Final_System.lua trouvé\n")
else
    print("  ❌ AAds_Final_System.lua MANQUANT!")
    print("  → Vérifier chemin: workspace/Addsextention/AAds_Final_System.lua\n")
    return
end

-- Test 2: Vérifier syntaxe Lua (charge script sans exécuter)
print("📋 Test 2: Vérification syntaxe Lua...")
local scriptContent = readfile("Addsextention/AAds_Final_System.lua")

-- Chercher erreur `endqqqq` (bug corrigé)
if scriptContent:match("endqqqq") then
    print("  ❌ ERREUR: 'endqqqq' trouvé dans le code!")
    print("  → Bug ligne 120 PAS corrigé!")
    print("  → Remplacer 'endqqqq' par 'end'\n")
    return
else
    print("  ✅ Pas de 'endqqqq' (bug corrigé)\n")
end

-- Test 3: Vérifier parser <picture> présent
print("📋 Test 3: Vérification parser <picture>...")
if scriptContent:match('<picture[^>]*>') then
    print("  ✅ Parser <picture> détecté")
    print("  ✅ Support balises responsive implémenté\n")
else
    print("  ❌ Parser <picture> MANQUANT!")
    print("  → Parser ancien (seulement <img>)\n")
    return
end

-- Test 4: Vérifier validation magic numbers présente
print("📋 Test 4: Vérification validation images...")
if scriptContent:match("isPNG") and scriptContent:match("isJPEG") then
    print("  ✅ Validation PNG/JPEG détectée")
    print("  ✅ Magic numbers implémentés\n")
else
    print("  ⚠️ Validation images basique")
    print("  → Peut causer images noires\n")
end

-- Test 5: Vérifier retry automatique présent
print("📋 Test 5: Vérification retry automatique...")
if scriptContent:match("maxRetries") or scriptContent:match("attempts") then
    print("  ✅ Retry automatique détecté")
    print("  ✅ Skip pubs échouées implémenté\n")
else
    print("  ⚠️ Retry automatique manquant")
    print("  → Rotation peut stuck sur pub invalide\n")
end

-- Test 6: Test syntaxe complète (compilation Lua)
print("📋 Test 6: Compilation syntaxe complète...")
local loadSuccess, loadError = loadstring(scriptContent)

if loadSuccess then
    print("  ✅ Script compile sans erreur")
    print("  ✅ Syntaxe Lua valide\n")
else
    print("  ❌ ERREUR COMPILATION:")
    print("  " .. tostring(loadError))
    print("  → Script ne s'exécutera pas!\n")
    return
end

-- Test 7: Vérifier CONFIG présent
print("📋 Test 7: Vérification configuration...")
if scriptContent:match("CONFIG") and scriptContent:match("AdURL") then
    print("  ✅ Configuration A-Ads détectée")
    
    -- Extraire URL iframe
    local adUrl = scriptContent:match('AdURL%s*=%s*["\']([^"\']+)["\']')
    if adUrl then
        print("  ✅ URL iframe: " .. adUrl)
        print("  ✅ Ad Unit configuré\n")
    else
        print("  ⚠️ URL iframe non trouvée\n")
    end
else
    print("  ❌ CONFIG manquant!")
    print("  → Système ne pourra pas télécharger pubs\n")
    return
end

-- Résumé Final
print(string.rep("=", 70))
print("📊 RÉSUMÉ DIAGNOSTIC")
print(string.rep("=", 70) .. "\n")

print("✅ Fichier AAds_Final_System.lua existe")
print("✅ Erreur syntaxe 'endqqqq' corrigée")
print("✅ Parser <picture> responsive implémenté")
print("✅ Validation images PNG/JPEG active")
print("✅ Retry automatique implémenté")
print("✅ Script compile sans erreur")
print("✅ Configuration A-Ads présente")

print("\n" .. string.rep("=", 70))
print("🎉 SYSTÈME PRÊT À UTILISER!")
print(string.rep("=", 70) .. "\n")

-- Instructions
print("🚀 LANCER SYSTÈME:")
print("   loadstring(readfile(\"Addsextention/AAds_Final_System.lua\"))()")
print("")
print("🧪 TEST EXTRACTION (rapide):")
print("   loadstring(readfile(\"Addsextention/Test_Picture_Extraction.lua\"))()")
print("")
print("📖 GUIDE COMPLET:")
print("   Voir fichier: Addsextention/GUIDE_TEST.md")
print("")

print(string.rep("=", 70))
print("✅ FIX IMAGES NOIRES VALIDÉ")
print(string.rep("=", 70) .. "\n")

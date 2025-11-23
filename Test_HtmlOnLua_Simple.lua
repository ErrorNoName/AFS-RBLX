-- 🧪 TEST SIMPLE HTMLONLUA - POUR VÉRIFIER LE CHARGEMENT
-- Ce script teste le chargement et l'exécution basique de HtmlOnLua

print("🚀 === TEST SIMPLE HTMLONLUA ===")
print("📡 Chargement depuis Pastebin confirmé...")

-- Méthode de chargement confirmée par l'utilisateur
local HtmlOnLua = loadstring(game:HttpGet("https://pastebin.com/raw/nScauqfC", true))()

if HtmlOnLua then
    print("✅ Module HtmlOnLua chargé avec succès")
    
    -- Test de la fonction de diagnostic
    if HtmlOnLua.test then
        print("🔍 Exécution du test de diagnostic...")
        local testResult = HtmlOnLua.test()
        
        print("📊 Résultats du diagnostic :")
        for key, value in pairs(testResult) do
            print("   " .. key .. ": " .. tostring(value))
        end
        
        if testResult.status == "OK" then
            print("✅ Tous les composants sont fonctionnels")
            
            -- Test de création d'instance
            print("🏗️ Test de création d'instance...")
            local engine = HtmlOnLua.new()
            
            if engine and engine.render then
                print("✅ Instance créée avec succès")
                print("🎯 Méthode render disponible")
                
                -- Test de rendu simple
                print("🎨 Test de rendu simple...")
                local simpleHTML = '<div class="test">Hello World</div>'
                local simpleCSS = '.test { color: red; background-color: blue; }'
                
                local success, result = pcall(function()
                    return engine:render(simpleHTML, simpleCSS)
                end)
                
                if success then
                    print("✅ Rendu réussi !")
                    print("🌟 HtmlOnLua est pleinement fonctionnel")
                else
                    print("❌ Erreur de rendu:", result)
                end
                
            else
                print("❌ Erreur : Instance invalide ou méthode render manquante")
            end
        else
            print("❌ Problème détecté dans les composants")
        end
    else
        print("⚠️ Fonction de test non disponible, test basique...")
        
        -- Test basique sans diagnostic
        local engine = HtmlOnLua.new()
        if engine then
            print("✅ Instance créée")
        else
            print("❌ Erreur de création d'instance")
        end
    end
    
else
    print("❌ Échec du chargement du module HtmlOnLua")
    print("🔧 Vérifiez :")
    print("   • Connexion internet")
    print("   • Lien Pastebin accessible")
    print("   • Exécuteur compatible HttpGet")
end

print("\n🏁 Test terminé")

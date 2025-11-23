-- 🧪 TEST AVANCÉ HTMLONLUA - REPRODUCTION EXACTE DU PROBLÈME
-- Ce script reproduit exactement le comportement de RetroUnblock_Ultimate.lua

print("🔬 === TEST AVANCÉ HTMLONLUA ===")
print("🎯 Reproduction exacte du processus de chargement de RetroUnblock_Ultimate.lua")

local HtmlOnLua = nil
local engine = nil

-- 📡 CHARGEMENT DEPUIS PASTEBIN (méthode identique)
print("📡 Chargement de HtmlOnLua depuis Pastebin...")

local loadSuccess, loadResult = pcall(function()
    return loadstring(game:HttpGet("https://pastebin.com/raw/nScauqfC", true))()
end)

if loadSuccess and loadResult then
    HtmlOnLua = loadResult
    print("✅ HtmlOnLua chargé avec succès depuis Pastebin")
    print("📦 Type du module:", type(HtmlOnLua))
    
    -- 🔍 DIAGNOSTIC DU MODULE
    print("\n🔍 === DIAGNOSTIC DU MODULE ===")
    if type(HtmlOnLua) == "table" then
        print("✅ Module est une table")
        
        -- Vérifier les méthodes disponibles
        local methods = {}
        for key, value in pairs(HtmlOnLua) do
            if type(value) == "function" then
                table.insert(methods, key)
            end
        end
        
        print("🛠️ Méthodes disponibles:", table.concat(methods, ", "))
        
        -- Vérifier spécifiquement la méthode 'new'
        if HtmlOnLua.new then
            print("✅ Méthode 'new' disponible")
            
            -- Tenter de créer une instance
            print("\n🏗️ === CRÉATION D'INSTANCE ===")
            local engineSuccess, engineResult = pcall(function()
                return HtmlOnLua.new()
            end)
            
            if engineSuccess and engineResult then
                engine = engineResult
                print("✅ Instance créée avec succès")
                print("📦 Type de l'instance:", type(engine))
                
                -- Vérifier la méthode render sur l'instance
                if engine.render then
                    print("✅ Méthode 'render' disponible sur l'instance")
                    
                    -- 🎨 TEST DE RENDU
                    print("\n🎨 === TEST DE RENDU ===")
                    local testHTML = '<div class="test">Test HtmlOnLua</div>'
                    local testCSS = '.test { color: #ff0000; background-color: #0000ff; }'
                    
                    local renderSuccess, renderResult = pcall(function()
                        return engine:render(testHTML, testCSS)
                    end)
                    
                    if renderSuccess then
                        print("✅ Rendu exécuté avec succès !")
                        print("🎯 HtmlOnLua est pleinement opérationnel")
                    else
                        print("❌ Erreur lors du rendu:", renderResult)
                    end
                    
                else
                    print("❌ Méthode 'render' NON DISPONIBLE sur l'instance")
                    print("🔍 Méthodes disponibles sur l'instance:")
                    if type(engine) == "table" then
                        for key, value in pairs(engine) do
                            if type(value) == "function" then
                                print("   • " .. key)
                            end
                        end
                    end
                end
                
            else
                print("❌ Erreur lors de la création de l'instance:", engineResult)
            end
            
        else
            print("❌ Méthode 'new' NON DISPONIBLE")
            print("🔍 Le module ne semble pas avoir la structure attendue")
        end
        
    else
        print("❌ Le module n'est pas une table (type:", type(HtmlOnLua), ")")
    end
    
else
    print("❌ Erreur de chargement:", loadResult)
end

-- 📊 RÉSUMÉ FINAL
print("\n📊 === RÉSUMÉ FINAL ===")
if engine and engine.render then
    print("🎉 SUCCÈS COMPLET")
    print("   ✅ Module chargé")
    print("   ✅ Instance créée") 
    print("   ✅ Méthode render fonctionnelle")
    print("🚀 HtmlOnLua est prêt à l'emploi !")
elseif HtmlOnLua then
    print("⚠️ SUCCÈS PARTIEL")
    print("   ✅ Module chargé")
    print("   ❌ Problème avec l'instance ou la méthode render")
    print("🔧 Le module nécessite des corrections")
else
    print("❌ ÉCHEC COMPLET")
    print("   ❌ Impossible de charger le module")
    print("🔧 Vérifiez la connexion et le lien Pastebin")
end

print("\n🏁 Test avancé terminé")

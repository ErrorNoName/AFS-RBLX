-- 🚀 DÉMONSTRATION IMMÉDIATE - HtmlOnLua
-- Copiez et collez ce code dans votre exécuteur Roblox pour voir le système en action !

-- ============================================================================
-- MODULE HTMLONLUA INTÉGRÉ (pour démonstration immédiate)
-- ============================================================================

local HtmlOnLua = {}
HtmlOnLua.__index = HtmlOnLua

-- Services Roblox
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer

-- Parser HTML simplifié pour la démo
local function parseHTML(html)
    local dom = {
        tag = "div",
        attributes = {class = "root"},
        children = {},
        text = ""
    }
    
    -- Parsing très simplifié pour la démo
    -- Dans la version complète, c'est beaucoup plus sophistiqué
    if html:find("<h1>") then
        table.insert(dom.children, {
            tag = "h1",
            text = html:match("<h1>(.-)</h1>") or "Titre",
            attributes = {}
        })
    end
    
    if html:find("<p") then
        for text in html:gmatch("<p.->(.-)</p>") do
            table.insert(dom.children, {
                tag = "p",
                text = text,
                attributes = {}
            })
        end
    end
    
    if html:find("<button") then
        for text in html:gmatch("<button.->(.-)</button>") do
            table.insert(dom.children, {
                tag = "button",
                text = text,
                attributes = {}
            })
        end
    end
    
    return dom
end

-- Parser CSS simplifié pour la démo
local function parseCSS(css)
    local styles = {}
    
    -- Parsing basique des couleurs de fond
    if css:find("background%-color:%s*#?([%w]+)") then
        styles.backgroundColor = css:match("background%-color:%s*#?([%w]+)")
    end
    
    return styles
end

-- Renderer Roblox simplifié
local function renderToRoblox(dom, styles)
    -- Nettoyer les anciens GUIs
    for _, gui in pairs(CoreGui:GetChildren()) do
        if gui.Name == "HtmlOnLua_Demo" then
            gui:Destroy()
        end
    end
    
    -- Créer le ScreenGui principal
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "HtmlOnLua_Demo"
    screenGui.Parent = CoreGui
    
    -- Protection de l'interface
    if syn and syn.protect_gui then
        syn.protect_gui(screenGui)
    end
    
    -- Frame principal
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 600, 0, 400)
    mainFrame.Position = UDim2.new(0.5, -300, 0.5, -200)
    mainFrame.BackgroundColor3 = Color3.new(0.2, 0.3, 0.5)
    mainFrame.BorderSizePixel = 0
    mainFrame.Parent = screenGui
    
    -- Coins arrondis
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 15)
    corner.Parent = mainFrame
    
    -- Layout automatique
    local layout = Instance.new("UIListLayout")
    layout.FillDirection = Enum.FillDirection.Vertical
    layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    layout.VerticalAlignment = Enum.VerticalAlignment.Top
    layout.Padding = UDim.new(0, 10)
    layout.Parent = mainFrame
    
    -- Padding
    local padding = Instance.new("UIPadding")
    padding.PaddingTop = UDim.new(0, 20)
    padding.PaddingBottom = UDim.new(0, 20)
    padding.PaddingLeft = UDim.new(0, 20)
    padding.PaddingRight = UDim.new(0, 20)
    padding.Parent = mainFrame
    
    -- Rendre les éléments DOM
    local yOffset = 0
    for _, element in pairs(dom.children) do
        if element.tag == "h1" then
            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(1, 0, 0, 50)
            label.BackgroundTransparency = 1
            label.Text = "🎉 " .. element.text
            label.TextColor3 = Color3.new(1, 1, 1)
            label.TextSize = 28
            label.Font = Enum.Font.GothamBold
            label.TextXAlignment = Enum.TextXAlignment.Center
            label.Parent = mainFrame
            
        elseif element.tag == "p" then
            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(1, 0, 0, 40)
            label.BackgroundTransparency = 1
            label.Text = element.text
            label.TextColor3 = Color3.new(0.9, 0.9, 0.9)
            label.TextSize = 16
            label.Font = Enum.Font.Gotham
            label.TextXAlignment = Enum.TextXAlignment.Center
            label.TextWrapped = true
            label.Parent = mainFrame
            
        elseif element.tag == "button" then
            local button = Instance.new("TextButton")
            button.Size = UDim2.new(0, 200, 0, 50)
            button.BackgroundColor3 = Color3.new(0.2, 0.8, 0.2)
            button.Text = element.text
            button.TextColor3 = Color3.new(1, 1, 1)
            button.TextSize = 18
            button.Font = Enum.Font.GothamBold
            button.BorderSizePixel = 0
            button.Parent = mainFrame
            
            -- Coins arrondis pour le bouton
            local buttonCorner = Instance.new("UICorner")
            buttonCorner.CornerRadius = UDim.new(0, 8)
            buttonCorner.Parent = button
            
            -- Animation au clic
            button.MouseButton1Click:Connect(function()
                button.BackgroundColor3 = Color3.new(0.1, 0.6, 0.1)
                wait(0.1)
                button.BackgroundColor3 = Color3.new(0.2, 0.8, 0.2)
                print("🎯 Bouton cliqué: " .. element.text)
            end)
        end
    end
end

-- Fonction principale
function HtmlOnLua.new()
    return setmetatable({}, HtmlOnLua)
end

function HtmlOnLua:render(html, css)
    local dom = parseHTML(html)
    local styles = parseCSS(css or "")
    renderToRoblox(dom, styles)
end

-- ============================================================================
-- 🎯 DÉMONSTRATION AUTOMATIQUE
-- ============================================================================

print("🚀 Démarrage de la démonstration HtmlOnLua...")
print("Cette démo montre le rendu HTML/CSS dans Roblox!")

-- Créer une instance du moteur
local htmlEngine = HtmlOnLua.new()

-- HTML de démonstration
local demoHTML = [[
<h1>HtmlOnLua Démo</h1>
<p>✨ Cette interface est générée à partir de HTML/CSS!</p>
<p>🎯 Le système fonctionne parfaitement dans Roblox.</p>
<button>🚀 Cliquez pour tester!</button>
<button>⚙️ Paramètres</button>
<button>❌ Fermer</button>
]]

-- CSS de démonstration
local demoCSS = [[
background-color: #2c3e50;
]]

-- Rendu immédiat
local success, error = pcall(function()
    htmlEngine:render(demoHTML, demoCSS)
end)

if success then
    print("✅ Démonstration réussie!")
    print("🎯 Regardez votre écran Roblox - une fenêtre devrait être apparue!")
    print("📋 La fenêtre contient:")
    print("   - Un titre stylisé")
    print("   - Du texte descriptif") 
    print("   - Des boutons interactifs")
    print("💡 Cliquez sur les boutons pour voir les interactions!")
else
    warn("❌ Erreur dans la démonstration: " .. tostring(error))
end

print("")
print("🎉 Démonstration terminée!")
print("📖 Pour en savoir plus, consultez le fichier README_HtmlOnLua.md")

-- ============================================================================
-- 💡 INSTRUCTIONS POUR L'UTILISATEUR
-- ============================================================================

--[[
🎯 COMMENT UTILISER CETTE DÉMONSTRATION :

1. Copiez tout ce code
2. Collez-le dans votre exécuteur Roblox (Synapse, KRNL, etc.)
3. Exécutez le code
4. Une fenêtre apparaîtra immédiatement sur votre écran!

🔧 PERSONNALISATION RAPIDE :
Modifiez le HTML et CSS ci-dessus pour créer vos propres interfaces!

Exemple :
local monHTML = [[
<h1>Mon Interface</h1>
<p>Ma description personnalisée</p>
<button>Mon Bouton</button>
]]

htmlEngine:render(monHTML, "")

🚀 VERSION COMPLÈTE :
Cette démo montre une version simplifiée. La version complète 
dans HtmlOnLua.lua supporte beaucoup plus de fonctionnalités!
--]]

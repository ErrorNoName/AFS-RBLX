--[[
    HtmlOnLua - Système de rendu HTML/CSS en Lua pur
    
    🎯 CONCEPT : Créer un moteur de rendu HTML/CSS simplifié en Lua
    qui peut transformer du code HTML/CSS en interface Roblox
    
    📋 FONCTIONNALITÉS :
    - Parser HTML basique (div, p, h1-h6, img, button, etc.)
    - Parser CSS avec sélecteurs, propriétés, et valeurs
    - Conversion automatique vers les composants Roblox UI
    - Support des classes, IDs, et styles inline
    - Système de layout basique (flexbox simplifié)
    
    🔧 ARCHITECTURE :
    1. HTML Parser -> DOM Tree
    2. CSS Parser -> Style Rules
    3. Style Engine -> Applique CSS au DOM
    4. Renderer -> Convertit en Roblox UI
    
    ⚠️ LIMITATIONS :
    - Subset limité de HTML/CSS (pas un navigateur complet)
    - Focus sur les éléments UI essentiels
    - Performance optimisée pour Roblox
]]

local HtmlOnLua = {}
HtmlOnLua.__index = HtmlOnLua

-- Services Roblox
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer

-- =============================================================================
-- 🏗️ SYSTÈME DE PARSING HTML
-- =============================================================================

local HTMLParser = {}
HTMLParser.__index = HTMLParser

function HTMLParser.new()
    local self = setmetatable({}, HTMLParser)
    self.tokens = {}
    self.position = 1
    return self
end

function HTMLParser:tokenize(html)
    self.tokens = {}
    local i = 1
    
    while i <= #html do
        local char = html:sub(i, i)
        
        if char == '<' then
            -- Tag ouvrante ou fermante
            local tagEnd = html:find('>', i)
            if tagEnd then
                local tagContent = html:sub(i + 1, tagEnd - 1)
                table.insert(self.tokens, {
                    type = "tag",
                    content = tagContent,
                    raw = html:sub(i, tagEnd)
                })
                i = tagEnd + 1
            else
                i = i + 1
            end
        else
            -- Contenu texte
            local nextTag = html:find('<', i)
            local textContent = html:sub(i, nextTag and (nextTag - 1) or #html)
            
            if textContent:match("%S") then -- Ignorer les espaces vides
                table.insert(self.tokens, {
                    type = "text",
                    content = textContent:match("^%s*(.-)%s*$") -- Trim
                })
            end
            
            i = nextTag or (#html + 1)
        end
    end
end

function HTMLParser:parseTag(tagContent)
    local tag = {}
    
    -- Détecter si c'est une tag fermante
    if tagContent:sub(1, 1) == '/' then
        tag.closing = true
        tag.name = tagContent:sub(2):match("^%s*(%S+)")
        return tag
    end
    
    -- Détecter si c'est une tag auto-fermante
    if tagContent:sub(-1) == '/' then
        tag.selfClosing = true
        tagContent = tagContent:sub(1, -2)
    end
    
    -- Parser le nom et les attributs
    local parts = {}
    for part in tagContent:gmatch("%S+") do
        table.insert(parts, part)
    end
    
    tag.name = parts[1] or ""
    tag.attributes = {}
    
    -- Parser les attributs (class="value" id="value" etc.)
    for i = 2, #parts do
        local attr = parts[i]
        local key, value = attr:match('([^=]+)="([^"]*)"')
        if key and value then
            tag.attributes[key] = value
        elseif attr:find('=') then
            local k, v = attr:match('([^=]+)=(.+)')
            tag.attributes[k] = v
        else
            tag.attributes[attr] = true
        end
    end
    
    return tag
end

function HTMLParser:buildDOM()
    local dom = {
        type = "document",
        children = {}
    }
    
    local stack = {dom}
    
    for _, token in ipairs(self.tokens) do
        if token.type == "tag" then
            local tag = self:parseTag(token.content)
            
            if tag.closing then
                -- Tag fermante - remonter dans la pile
                if #stack > 1 then
                    table.remove(stack)
                end
            else
                -- Tag ouvrante
                local element = {
                    type = "element",
                    tagName = tag.name,
                    attributes = tag.attributes,
                    children = {},
                    parent = stack[#stack]
                }
                
                table.insert(stack[#stack].children, element)
                
                if not tag.selfClosing then
                    table.insert(stack, element)
                end
            end
        elseif token.type == "text" then
            local textNode = {
                type = "text",
                content = token.content,
                parent = stack[#stack]
            }
            table.insert(stack[#stack].children, textNode)
        end
    end
    
    return dom
end

function HTMLParser:parse(html)
    self:tokenize(html)
    return self:buildDOM()
end

-- =============================================================================
-- 🎨 SYSTÈME DE PARSING CSS
-- =============================================================================

local CSSParser = {}
CSSParser.__index = CSSParser

function CSSParser.new()
    local self = setmetatable({}, CSSParser)
    self.rules = {}
    return self
end

function CSSParser:parse(css)
    self.rules = {}
    
    -- Supprimer les commentaires
    css = css:gsub("/%*.--%*/", "")
    
    -- Parser les règles CSS
    for rule in css:gmatch("([^}]+})") do
        local selector, properties = rule:match("^%s*([^{]+)%s*{%s*([^}]*)%s*")
        
        if selector and properties then
            local cssRule = {
                selector = selector:match("^%s*(.-)%s*$"), -- Trim
                properties = {}
            }
            
            -- Parser les propriétés
            for prop in properties:gmatch("([^;]+)") do
                local key, value = prop:match("^%s*([^:]+)%s*:%s*(.-)%s*$")
                if key and value then
                    cssRule.properties[key] = value
                end
            end
            
            table.insert(self.rules, cssRule)
        end
    end
    
    return self.rules
end

function CSSParser:matchesSelector(element, selector)
    -- Sélecteur par tag
    if selector == element.tagName then
        return true
    end
    
    -- Sélecteur par classe (.class)
    if selector:sub(1, 1) == '.' then
        local className = selector:sub(2)
        local elementClass = element.attributes and element.attributes.class
        if elementClass then
            for class in elementClass:gmatch("%S+") do
                if class == className then
                    return true
                end
            end
        end
    end
    
    -- Sélecteur par ID (#id)
    if selector:sub(1, 1) == '#' then
        local id = selector:sub(2)
        return element.attributes and element.attributes.id == id
    end
    
    return false
end

-- =============================================================================
-- 🎭 MOTEUR DE STYLE
-- =============================================================================

local StyleEngine = {}
StyleEngine.__index = StyleEngine

function StyleEngine.new()
    local self = setmetatable({}, StyleEngine)
    self.computedStyles = {}
    return self
end

function StyleEngine:applyStyles(dom, cssRules)
    self:traverseAndStyle(dom, cssRules)
end

function StyleEngine:traverseAndStyle(node, cssRules)
    if node.type == "element" then
        local styles = {}
        
        -- Appliquer les styles CSS
        for _, rule in ipairs(cssRules) do
            if self:matchesSelector(node, rule.selector) then
                for prop, value in pairs(rule.properties) do
                    styles[prop] = value
                end
            end
        end
        
        -- Styles inline (attribut style)
        if node.attributes and node.attributes.style then
            for prop in node.attributes.style:gmatch("([^;]+)") do
                local key, value = prop:match("^%s*([^:]+)%s*:%s*(.-)%s*$")
                if key and value then
                    styles[key] = value
                end
            end
        end
        
        self.computedStyles[node] = styles
    end
    
    -- Parcourir les enfants
    if node.children then
        for _, child in ipairs(node.children) do
            self:traverseAndStyle(child, cssRules)
        end
    end
end

function StyleEngine:matchesSelector(element, selector)
    -- Réutiliser la logique du CSSParser
    local parser = CSSParser.new()
    return parser:matchesSelector(element, selector)
end

-- =============================================================================
-- 🖼️ RENDERER ROBLOX
-- =============================================================================

local RobloxRenderer = {}
RobloxRenderer.__index = RobloxRenderer

function RobloxRenderer.new()
    local self = setmetatable({}, RobloxRenderer)
    self.elementMap = {}
    return self
end

function RobloxRenderer:convertCSSValue(property, value)
    -- Convertir les valeurs CSS en valeurs Roblox
    
    -- Couleurs
    if property:find("color") then
        if value:match("^#%x%x%x%x%x%x$") then
            -- Hex color
            local r = tonumber(value:sub(2, 3), 16) / 255
            local g = tonumber(value:sub(4, 5), 16) / 255
            local b = tonumber(value:sub(6, 7), 16) / 255
            return Color3.new(r, g, b)
        elseif value:match("^rgb%s*%(") then
            -- RGB color
            local r, g, b = value:match("rgb%s*%(%s*(%d+)%s*,%s*(%d+)%s*,%s*(%d+)%s*%)")
            if r and g and b then
                return Color3.new(tonumber(r)/255, tonumber(g)/255, tonumber(b)/255)
            end
        end
        
        -- Couleurs nommées
        local namedColors = {
            red = Color3.new(1, 0, 0),
            green = Color3.new(0, 1, 0),
            blue = Color3.new(0, 0, 1),
            white = Color3.new(1, 1, 1),
            black = Color3.new(0, 0, 0),
            yellow = Color3.new(1, 1, 0),
            purple = Color3.new(1, 0, 1),
            cyan = Color3.new(0, 1, 1),
            orange = Color3.new(1, 0.5, 0)
        }
        return namedColors[value:lower()] or Color3.new(1, 1, 1)
    end
    
    -- Dimensions (px, %, etc.)
    if value:match("(%d+)px") then
        return tonumber(value:match("(%d+)px"))
    elseif value:match("(%d+)%%") then
        return tonumber(value:match("(%d+)%%")) / 100
    elseif tonumber(value) then
        return tonumber(value)
    end
    
    return value
end

function RobloxRenderer:createElement(node, parent)
    if node.type == "text" then
        -- Créer un TextLabel pour le texte
        local textLabel = Instance.new("TextLabel")
        textLabel.Text = node.content
        textLabel.BackgroundTransparency = 1
        textLabel.Size = UDim2.new(1, 0, 0, 20)
        textLabel.TextColor3 = Color3.new(0, 0, 0)
        textLabel.TextScaled = true
        textLabel.Font = Enum.Font.Gotham
        textLabel.TextXAlignment = Enum.TextXAlignment.Left
        textLabel.Parent = parent
        
        return textLabel
    
    elseif node.type == "element" then
        local element
        
        -- Mapper les tags HTML vers les composants Roblox
        if node.tagName == "div" or node.tagName == "section" then
            element = Instance.new("Frame")
            element.BackgroundColor3 = Color3.new(1, 1, 1)
            element.BorderSizePixel = 0
            
        elseif node.tagName == "button" then
            element = Instance.new("TextButton")
            element.BackgroundColor3 = Color3.new(0.9, 0.9, 0.9)
            element.Text = node.attributes and node.attributes.text or "Button"
            
        elseif node.tagName:match("^h[1-6]$") then
            element = Instance.new("TextLabel")
            element.BackgroundTransparency = 1
            element.TextColor3 = Color3.new(0, 0, 0)
            element.TextScaled = true
            element.Font = Enum.Font.GothamBold
            
            -- Taille selon le niveau de heading
            local level = tonumber(node.tagName:sub(2))
            local sizes = {32, 28, 24, 20, 16, 14}
            element.TextSize = sizes[level] or 16
            
        elseif node.tagName == "p" then
            element = Instance.new("TextLabel")
            element.BackgroundTransparency = 1
            element.TextColor3 = Color3.new(0, 0, 0)
            element.TextWrapped = true
            element.Font = Enum.Font.Gotham
            element.TextXAlignment = Enum.TextXAlignment.Left
            
        elseif node.tagName == "img" then
            element = Instance.new("ImageLabel")
            element.BackgroundTransparency = 1
            if node.attributes and node.attributes.src then
                element.Image = node.attributes.src
            end
            
        else
            -- Tag non reconnue -> Frame par défaut
            element = Instance.new("Frame")
            element.BackgroundTransparency = 1
        end
        
        -- Propriétés par défaut
        element.Size = UDim2.new(1, 0, 0, 100)
        element.Parent = parent
        
        self.elementMap[node] = element
        
        return element
    end
end

function RobloxRenderer:applyStyles(node, styles, element)
    if not styles or not element then return end
    
    for property, value in pairs(styles) do
        local convertedValue = self:convertCSSValue(property, value)
        
        -- Mapper les propriétés CSS vers Roblox
        if property == "background-color" then
            element.BackgroundColor3 = convertedValue
        elseif property == "color" then
            if element:IsA("TextLabel") or element:IsA("TextButton") then
                element.TextColor3 = convertedValue
            end
        elseif property == "width" then
            if type(convertedValue) == "number" then
                if convertedValue <= 1 then
                    element.Size = UDim2.new(convertedValue, 0, element.Size.Y.Scale, element.Size.Y.Offset)
                else
                    element.Size = UDim2.new(0, convertedValue, element.Size.Y.Scale, element.Size.Y.Offset)
                end
            end
        elseif property == "height" then
            if type(convertedValue) == "number" then
                if convertedValue <= 1 then
                    element.Size = UDim2.new(element.Size.X.Scale, element.Size.X.Offset, convertedValue, 0)
                else
                    element.Size = UDim2.new(element.Size.X.Scale, element.Size.X.Offset, 0, convertedValue)
                end
            end
        elseif property == "font-size" then
            if element:IsA("TextLabel") or element:IsA("TextButton") then
                element.TextSize = convertedValue
            end
        elseif property == "border-radius" then
            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, convertedValue)
            corner.Parent = element
        elseif property == "opacity" then
            if type(convertedValue) == "number" then
                element.BackgroundTransparency = 1 - convertedValue
            end
        end
    end
end

function RobloxRenderer:render(dom, styleEngine, parent)
    if not parent then
        -- Créer le container principal
        local screenGui = Instance.new("ScreenGui")
        screenGui.Name = "HtmlOnLuaRenderer"
        screenGui.Parent = game:GetService("CoreGui")
        screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        screenGui.ResetOnSpawn = false
        
        -- Protection de l'interface (si disponible)
        if syn and syn.protect_gui then
            syn.protect_gui(screenGui)
        elseif gethui then
            gethui(screenGui)
        end
        
        local mainFrame = Instance.new("ScrollingFrame")
        mainFrame.Size = UDim2.new(0, 800, 0, 600)
        mainFrame.Position = UDim2.new(0.5, -400, 0.5, -300)
        mainFrame.BackgroundColor3 = Color3.new(1, 1, 1)
        mainFrame.CanvasSize = UDim2.new(0, 0, 2, 0)
        mainFrame.Parent = screenGui
        
        -- Layout automatique
        local layout = Instance.new("UIListLayout")
        layout.SortOrder = Enum.SortOrder.LayoutOrder
        layout.FillDirection = Enum.FillDirection.Vertical
        layout.Padding = UDim.new(0, 5)
        layout.Parent = mainFrame
        
        parent = mainFrame
    end
    
    self:renderNode(dom, styleEngine, parent)
end

function RobloxRenderer:renderNode(node, styleEngine, parent)
    if node.type == "document" then
        -- Rendre les enfants du document
        if node.children then
            for _, child in ipairs(node.children) do
                self:renderNode(child, styleEngine, parent)
            end
        end
    else
        local element = self:createElement(node, parent)
        
        if element then
            -- Appliquer les styles
            local styles = styleEngine.computedStyles[node]
            self:applyStyles(node, styles, element)
            
            -- Rendre les enfants
            if node.children then
                for _, child in ipairs(node.children) do
                    self:renderNode(child, styleEngine, element)
                end
            end
        end
    end
end

-- =============================================================================
-- 🚀 API PRINCIPALE
-- =============================================================================

function HtmlOnLua.new()
    local self = setmetatable({}, HtmlOnLua)
    self.htmlParser = HTMLParser.new()
    self.cssParser = CSSParser.new()
    self.styleEngine = StyleEngine.new()
    self.renderer = RobloxRenderer.new()
    return self
end

-- 🔍 FONCTION DE VÉRIFICATION DU MODULE
function HtmlOnLua.test()
    local success, result = pcall(function()
        local engine = HtmlOnLua.new()
        return {
            status = "OK",
            htmlParser = engine.htmlParser and "OK" or "FAIL",
            cssParser = engine.cssParser and "OK" or "FAIL", 
            styleEngine = engine.styleEngine and "OK" or "FAIL",
            renderer = engine.renderer and "OK" or "FAIL",
            renderMethod = (type(engine.render) == "function") and "OK" or "FAIL"
        }
    end)
    
    if success then
        return result
    else
        return {
            status = "FAIL",
            error = tostring(result)
        }
    end
end

function HtmlOnLua:render(html, css)
    -- 1. Parser le HTML
    local dom = self.htmlParser:parse(html)
    
    -- 2. Parser le CSS
    local cssRules = {}
    if css then
        cssRules = self.cssParser:parse(css)
    end
    
    -- 3. Appliquer les styles
    self.styleEngine:applyStyles(dom, cssRules)
    
    -- 4. Rendre dans Roblox
    self.renderer:render(dom, self.styleEngine)
    
    return dom
end

-- 🔧 FONCTION UTILITAIRE POUR RENDU DIRECT
function HtmlOnLua.renderDirect(html, css)
    -- Créer automatiquement une instance et rendre
    local engine = HtmlOnLua.new()
    return engine:render(html, css)
end

-- =============================================================================
-- 🧪 EXEMPLE D'UTILISATION
-- =============================================================================

--[[
-- MÉTHODE 1: Utilisation avec instance
local htmlEngine = HtmlOnLua.new()

local html = [===[
<div class="container">
    <h1>Titre Principal</h1>
    <p class="description">Ceci est une description avec du texte.</p>
    <button>Cliquez-moi!</button>
    <div class="card">
        <h2>Sous-titre</h2>
        <p>Contenu de la carte</p>
    </div>
</div>
]===]

local css = [===[
.container {
    background-color: #f0f0f0;
    width: 100%;
    height: 500px;
}

h1 {
    color: #333;
    font-size: 24px;
}

.description {
    color: #666;
    font-size: 16px;
}

button {
    background-color: #007bff;
    color: white;
    border-radius: 5px;
    width: 200px;
    height: 40px;
}

.card {
    background-color: white;
    border-radius: 10px;
    width: 80%;
    height: 150px;
}
]===]

-- Méthode recommandée
htmlEngine:render(html, css)

-- MÉTHODE 2: Utilisation directe (pour compatibilité)
-- HtmlOnLua.renderDirect(html, css)
--]]

return HtmlOnLua

--[[
    ╔═══════════════════════════════════════════════════════════╗
    ║           AdManager - Système de Publicités              ║
    ║              Pour Scripts Roblox Exploits                ║
    ║                                                           ║
    ║  Auteur  : GhostDuckyy                                   ║
    ║  Version : 1.0.0                                         ║
    ║  Date    : Novembre 2025                                 ║
    ╚═══════════════════════════════════════════════════════════╝
    
    Fonctionnalités:
    - Support A-Ads, PropellerAds, Adsterra
    - Rotation automatique publicités
    - 4 positions (coins écran)
    - Tracking impressions/clicks
    - Cache images
    - Animations smooth
    
    Usage:
        local AdSystem = loadstring(readfile("AdManager.lua"))()
        AdSystem:Init({
            Provider = "A-Ads",
            AdUnitID = "123456",
            Position = "BOTTOM_LEFT"
        })
        AdSystem:Show()
]]

-- Services Roblox
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")

-- Modules (chargement dynamique)
local function LoadModule(moduleName)
    local scriptPath = debug.info(1, "s")
    local folderPath = scriptPath:match("(.*/)")
    
    if readfile and scriptPath:find("Addsextention") then
        -- Mode fichiers locaux
        local fullPath = folderPath .. moduleName .. ".lua"
        return loadstring(readfile(fullPath))()
    else
        -- Mode require standard
        return require(script.Parent[moduleName])
    end
end

-- Charger modules
local AdPositions = LoadModule("AdPositions")
local AdDisplay = LoadModule("AdDisplay")
local AdController = LoadModule("AdController")

-- AdManager Class
local AdManager = {}
AdManager.__index = AdManager

-- Configuration par défaut
local DEFAULT_CONFIG = {
    Provider = "Custom",      -- "A-Ads", "PropellerAds", "Adsterra", "Custom"
    AdUnitID = nil,
    APIToken = nil,
    Position = "BOTTOM_LEFT",
    AutoRotate = true,
    RotateInterval = 30,
    CPM = 1.00,              -- Estimation CPM pour stats
    AdsPool = {},
    Webhook = nil,           -- Discord webhook pour analytics
    TrackClicks = true,
    TrackImpressions = true,
}

-- URLs API providers
local PROVIDER_APIS = {
    ["A-Ads"] = "https://a-ads.com/api/v1/",
    ["PropellerAds"] = "https://api.propellerads.com/v5/",
    ["Adsterra"] = "https://api.adsterra.com/publisher/",
}

-- Créer instance AdManager
function AdManager.new()
    local self = setmetatable({}, AdManager)
    
    self.Config = table.clone(DEFAULT_CONFIG)
    self.Display = nil
    self.Controller = nil
    self.CurrentAdIndex = 1
    self.Stats = {
        Impressions = 0,
        Clicks = 0,
        Revenue = 0,
        StartTime = os.time(),
    }
    self.RotateConnection = nil
    self.IsInitialized = false
    
    return self
end

-- Initialiser le système
function AdManager:Init(config)
    if self.IsInitialized then
        warn("[AdManager] Déjà initialisé")
        return false
    end
    
    -- Merge config
    if config then
        for key, value in pairs(config) do
            if self.Config[key] ~= nil then
                self.Config[key] = value
            end
        end
    end
    
    -- Valider configuration
    if not self:ValidateConfig() then
        return false
    end
    
    -- Charger publicités selon provider
    if self.Config.Provider ~= "Custom" then
        self:LoadAdsFromProvider()
    end
    
    -- Créer Display
    local AdPosInfo = AdPositions:GetInfo(self.Config.Position)
    self.Display = AdDisplay.new(
        CoreGui,
        self:GetCurrentAd(),
        AdPosInfo.Position,
        AdPosInfo.Size
    )
    
    -- Setup callbacks
    self:SetupCallbacks()
    
    -- Créer Controller
    self.Controller = AdController.new(self)
    
    -- Setup rotation automatique
    if self.Config.AutoRotate then
        self:StartAutoRotate()
    end
    
    self.IsInitialized = true
    print("[AdManager] Initialisé avec succès - Provider:", self.Config.Provider)
    
    return true
end

-- Valider configuration
function AdManager:ValidateConfig()
    -- Vérifier position valide
    if not AdPositions:IsValid(self.Config.Position) then
        warn("[AdManager] Position invalide:", self.Config.Position)
        self.Config.Position = "BOTTOM_LEFT"
    end
    
    -- Vérifier pool publicités
    if self.Config.Provider == "Custom" and #self.Config.AdsPool == 0 then
        warn("[AdManager] AdsPool vide et provider Custom - ajout exemple")
        self.Config.AdsPool = {
            {
                Image = "rbxassetid://10723434711",
                Link = "https://discord.gg/Banh6njXwZ",
                Title = "Exemple Publicité",
            }
        }
    end
    
    -- Vérifier AdUnitID pour providers
    if self.Config.Provider ~= "Custom" and not self.Config.AdUnitID then
        warn("[AdManager] AdUnitID requis pour provider:", self.Config.Provider)
        return false
    end
    
    return true
end

-- Charger publicités depuis provider API
function AdManager:LoadAdsFromProvider()
    local provider = self.Config.Provider
    local adUnitID = self.Config.AdUnitID
    
    print("[AdManager] Chargement publicités depuis", provider)
    
    if provider == "A-Ads" then
        self:LoadFromAAds(adUnitID)
    elseif provider == "PropellerAds" then
        self:LoadFromPropellerAds(adUnitID)
    elseif provider == "Adsterra" then
        self:LoadFromAdsterra(adUnitID)
    end
end

-- Charger depuis A-Ads
function AdManager:LoadFromAAds(adUnitID)
    -- A-Ads utilise iframe embed (récupération via HttpService)
    local iframeUrl = "https://acceptable.a-ads.com/" .. adUnitID .. "/?size=Adaptive"
    
    print("[AdManager] Chargement A-Ads depuis iframe:", iframeUrl)
    
    -- Tentative 1: Récupérer contenu iframe pour extraire image
    local success, result = pcall(function()
        local request = syn and syn.request or http_request or request
        if request then
            local response = request({
                Url = iframeUrl,
                Method = "GET",
            })
            
            if response.StatusCode == 200 then
                local html = response.Body
                
                -- Extraire URL image depuis HTML (pattern A-Ads)
                local imageUrl = html:match('src="(https?://[^"]+%.(?:png|jpg|jpeg|gif))"')
                    or html:match("src='(https?://[^']+%.(?:png|jpg|jpeg|gif))'")
                    or html:match('background%-image:%s*url%(["\'](https?://[^"\']+)["\']\)')
                
                if imageUrl then
                    print("[AdManager] Image extraite:", imageUrl)
                    self.Config.AdsPool = {
                        {
                            Image = imageUrl,
                            Link = "https://a-ads.com/" .. adUnitID,
                            Title = "A-Ads Banner #" .. adUnitID,
                            Provider = "A-Ads",
                        }
                    }
                    return
                end
            end
        end
    end)
    
    -- Fallback: Utiliser URL directe A-Ads (format standard)
    if not success or #self.Config.AdsPool == 0 then
        warn("[AdManager] Extraction iframe échouée, utilisation fallback")
        
        -- A-Ads fournit aussi des URLs directes
        local imageUrl = "https://ad.a-ads.com/" .. adUnitID .. ".png"
        
        self.Config.AdsPool = {
            {
                Image = imageUrl,
                Link = "https://a-ads.com/" .. adUnitID,
                Title = "A-Ads Banner #" .. adUnitID,
                Provider = "A-Ads",
            }
        }
        
        print("[AdManager] A-Ads fallback configuré - Image:", imageUrl)
    end
end

-- Charger depuis PropellerAds (API)
function AdManager:LoadFromPropellerAds(zoneID)
    -- PropellerAds nécessite API Token
    if not self.Config.APIToken then
        warn("[AdManager] PropellerAds requiert APIToken")
        return
    end
    
    local apiUrl = PROVIDER_APIS["PropellerAds"] .. "zones/" .. zoneID .. "/ads"
    
    local success, result = pcall(function()
        local request = syn and syn.request or http_request or request
        if not request then
            warn("[AdManager] Fonction request non disponible")
            return
        end
        
        local response = request({
            Url = apiUrl,
            Method = "GET",
            Headers = {
                ["Authorization"] = "Bearer " .. self.Config.APIToken,
                ["Content-Type"] = "application/json",
            }
        })
        
        if response.StatusCode == 200 then
            local data = HttpService:JSONDecode(response.Body)
            -- Parser ads depuis response
            -- TODO: Adapter selon structure API PropellerAds
            print("[AdManager] PropellerAds publicités chargées")
        else
            warn("[AdManager] PropellerAds erreur:", response.StatusCode)
        end
    end)
    
    if not success then
        warn("[AdManager] PropellerAds erreur:", result)
    end
end

-- Charger depuis Adsterra (API)
function AdManager:LoadFromAdsterra(placementID)
    -- Adsterra API similaire à PropellerAds
    if not self.Config.APIToken then
        warn("[AdManager] Adsterra requiert APIToken")
        return
    end
    
    local apiUrl = PROVIDER_APIS["Adsterra"] .. "placements/" .. placementID
    
    -- Implémentation similaire à PropellerAds
    print("[AdManager] Adsterra API call - Placement:", placementID)
end

-- Obtenir publicité actuelle
function AdManager:GetCurrentAd()
    if #self.Config.AdsPool == 0 then
        return {
            Image = "",
            Link = "",
            Title = "Aucune publicité",
        }
    end
    
    return self.Config.AdsPool[self.CurrentAdIndex]
end

-- Afficher publicité
function AdManager:Show()
    if not self.Display then
        warn("[AdManager] Display non initialisé")
        return false
    end
    
    local ad = self:GetCurrentAd()
    self.Display:UpdateAd(ad)
    self.Display:Show()
    
    -- Track impression
    self:TrackImpression()
    
    return true
end

-- Masquer publicité
function AdManager:Hide()
    if not self.Display then return false end
    
    self.Display:Hide()
    return true
end

-- Prochaine publicité
function AdManager:ShowNextAd()
    if #self.Config.AdsPool == 0 then return false end
    
    self.CurrentAdIndex = self.CurrentAdIndex + 1
    if self.CurrentAdIndex > #self.Config.AdsPool then
        self.CurrentAdIndex = 1
    end
    
    return self:Show()
end

-- Publicité précédente
function AdManager:ShowPreviousAd()
    if #self.Config.AdsPool == 0 then return false end
    
    self.CurrentAdIndex = self.CurrentAdIndex - 1
    if self.CurrentAdIndex < 1 then
        self.CurrentAdIndex = #self.Config.AdsPool
    end
    
    return self:Show()
end

-- Changer position
function AdManager:SetPosition(positionName)
    if not AdPositions:IsValid(positionName) then
        warn("[AdManager] Position invalide:", positionName)
        return false
    end
    
    self.Config.Position = positionName
    
    if self.Display then
        local newPos = AdPositions:GetPosition(positionName)
        self.Display:SetPosition(newPos)
    end
    
    return true
end

-- Setup callbacks Display
function AdManager:SetupCallbacks()
    if not self.Display then return end
    
    local currentAd = self:GetCurrentAd()
    
    currentAd.OnShow = function()
        self:TrackImpression()
    end
    
    currentAd.OnClick = function()
        self:TrackClick()
    end
    
    currentAd.OnHide = function()
        -- Optional callback
    end
end

-- Tracking impression
function AdManager:TrackImpression()
    if not self.Config.TrackImpressions then return end
    
    self.Stats.Impressions = self.Stats.Impressions + 1
    
    -- Calcul revenue estimé (CPM)
    local cpm = self.Config.CPM
    self.Stats.Revenue = (self.Stats.Impressions / 1000) * cpm
    
    -- Envoyer webhook si configuré
    if self.Config.Webhook then
        self:SendWebhook("impression", {
            Impressions = self.Stats.Impressions,
            Ad = self:GetCurrentAd().Title,
        })
    end
end

-- Tracking click
function AdManager:TrackClick()
    if not self.Config.TrackClicks then return end
    
    self.Stats.Clicks = self.Stats.Clicks + 1
    
    -- Envoyer webhook
    if self.Config.Webhook then
        self:SendWebhook("click", {
            Clicks = self.Stats.Clicks,
            Ad = self:GetCurrentAd().Title,
            Link = self:GetCurrentAd().Link,
        })
    end
    
    print("[AdManager] Click enregistré - Total:", self.Stats.Clicks)
end

-- Envoyer analytics vers Discord Webhook
function AdManager:SendWebhook(eventType, data)
    local webhook = self.Config.Webhook
    if not webhook then return end
    
    local request = syn and syn.request or http_request or request
    if not request then return end
    
    local embed = {
        title = "📊 Ad Event: " .. eventType,
        description = "Système publicités - Event tracking",
        color = eventType == "click" and 3066993 or 15158332,
        fields = {},
        timestamp = os.date("!%Y-%m-%dT%H:%M:%S"),
    }
    
    for key, value in pairs(data) do
        table.insert(embed.fields, {
            name = key,
            value = tostring(value),
            inline = true,
        })
    end
    
    local payload = {
        embeds = {embed}
    }
    
    pcall(function()
        request({
            Url = webhook,
            Method = "POST",
            Headers = {["Content-Type"] = "application/json"},
            Body = HttpService:JSONEncode(payload),
        })
    end)
end

-- Démarrer rotation automatique
function AdManager:StartAutoRotate()
    if self.RotateConnection then
        self.RotateConnection:Disconnect()
    end
    
    local interval = self.Config.RotateInterval
    local elapsed = 0
    
    self.RotateConnection = RunService.Heartbeat:Connect(function(deltaTime)
        elapsed = elapsed + deltaTime
        
        if elapsed >= interval then
            elapsed = 0
            self:ShowNextAd()
        end
    end)
    
    print("[AdManager] Auto-rotation activée -", interval, "secondes")
end

-- Arrêter rotation automatique
function AdManager:StopAutoRotate()
    if self.RotateConnection then
        self.RotateConnection:Disconnect()
        self.RotateConnection = nil
        print("[AdManager] Auto-rotation désactivée")
    end
end

-- Obtenir statistiques
function AdManager:GetStats()
    local uptime = os.time() - self.Stats.StartTime
    local ctr = self.Stats.Impressions > 0 
        and (self.Stats.Clicks / self.Stats.Impressions * 100) 
        or 0
    
    return {
        Impressions = self.Stats.Impressions,
        Clicks = self.Stats.Clicks,
        Revenue = math.floor(self.Stats.Revenue * 100) / 100,
        CTR = math.floor(ctr * 100) / 100,
        Uptime = uptime,
        CurrentAd = self:GetCurrentAd().Title,
    }
end

-- Reset statistiques
function AdManager:ResetStats()
    self.Stats = {
        Impressions = 0,
        Clicks = 0,
        Revenue = 0,
        StartTime = os.time(),
    }
end

-- Nettoyer
function AdManager:Destroy()
    self:StopAutoRotate()
    
    if self.Display then
        self.Display:Destroy()
    end
    
    if self.Controller then
        self.Controller = nil
    end
    
    self.IsInitialized = false
    print("[AdManager] Système détruit")
end

-- Export module
return AdManager

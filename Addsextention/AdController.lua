--[[
    AdController.lua
    Contrôles utilisateur pour système publicités
    Fonctions : ChangePosition(), NextAd(), SkipAd(), ToggleAds()
]]

local AdController = {}
AdController.__index = AdController

-- Créer nouveau controller
function AdController.new(adManager)
    local self = setmetatable({}, AdController)
    
    self.AdManager = adManager
    self.Config = {
        Position = "BOTTOM_LEFT",
        AutoRotate = true,
        RotateInterval = 30,
        Enabled = true,
        ShowCloseButton = true,
    }
    
    self.ConfigFile = "Addsextention_Config.json"
    
    -- Charger config sauvegardée
    self:LoadConfig()
    
    return self
end

-- Changer position publicité
function AdController:SetPosition(positionName)
    if not self.AdManager then return false end
    
    local success = self.AdManager:SetPosition(positionName)
    if success then
        self.Config.Position = positionName
        self:SaveConfig()
        print("[AdController] Position changée:", positionName)
        return true
    end
    
    return false
end

-- Obtenir position actuelle
function AdController:GetPosition()
    return self.Config.Position
end

-- Passer à prochaine publicité
function AdController:NextAd()
    if not self.AdManager then return false end
    
    local success = self.AdManager:ShowNextAd()
    if success then
        print("[AdController] Prochaine publicité affichée")
        return true
    end
    
    return false
end

-- Publicité précédente
function AdController:PreviousAd()
    if not self.AdManager then return false end
    
    local success = self.AdManager:ShowPreviousAd()
    if success then
        print("[AdController] Publicité précédente affichée")
        return true
    end
    
    return false
end

-- Passer publicité (skip)
function AdController:SkipAd()
    if not self.AdManager then return false end
    
    -- Hide current ad et passer à prochaine
    self.AdManager:Hide()
    wait(0.5)
    return self:NextAd()
end

-- Activer/Désactiver publicités
function AdController:ToggleAds()
    self.Config.Enabled = not self.Config.Enabled
    
    if self.Config.Enabled then
        if self.AdManager then
            self.AdManager:Show()
        end
        print("[AdController] Publicités activées")
    else
        if self.AdManager then
            self.AdManager:Hide()
        end
        print("[AdController] Publicités désactivées")
    end
    
    self:SaveConfig()
    return self.Config.Enabled
end

-- Activer publicités
function AdController:Enable()
    if self.Config.Enabled then return end
    self:ToggleAds()
end

-- Désactiver publicités
function AdController:Disable()
    if not self.Config.Enabled then return end
    self:ToggleAds()
end

-- Activer/Désactiver rotation automatique
function AdController:ToggleAutoRotate()
    self.Config.AutoRotate = not self.Config.AutoRotate
    
    if self.AdManager then
        self.AdManager.Config.AutoRotate = self.Config.AutoRotate
    end
    
    self:SaveConfig()
    print("[AdController] Rotation automatique:", self.Config.AutoRotate)
    return self.Config.AutoRotate
end

-- Définir intervalle rotation (secondes)
function AdController:SetRotateInterval(seconds)
    if type(seconds) ~= "number" or seconds < 5 then
        warn("[AdController] Intervalle invalide, minimum 5 secondes")
        return false
    end
    
    self.Config.RotateInterval = seconds
    
    if self.AdManager then
        self.AdManager.Config.RotateInterval = seconds
    end
    
    self:SaveConfig()
    print("[AdController] Intervalle rotation:", seconds, "secondes")
    return true
end

-- Activer/Désactiver bouton fermeture
function AdController:ToggleCloseButton()
    self.Config.ShowCloseButton = not self.Config.ShowCloseButton
    
    if self.AdManager and self.AdManager.Display then
        local closeBtn = self.AdManager.Display.CloseButton
        if closeBtn then
            closeBtn.Visible = self.Config.ShowCloseButton
        end
    end
    
    self:SaveConfig()
    return self.Config.ShowCloseButton
end

-- Obtenir statistiques
function AdController:GetStats()
    if not self.AdManager then
        return {
            Impressions = 0,
            Clicks = 0,
            Revenue = 0,
            CurrentAd = nil,
        }
    end
    
    return self.AdManager:GetStats()
end

-- Reset statistiques
function AdController:ResetStats()
    if self.AdManager then
        self.AdManager:ResetStats()
        print("[AdController] Statistiques réinitialisées")
    end
end

-- Obtenir configuration actuelle
function AdController:GetConfig()
    return {
        Position = self.Config.Position,
        AutoRotate = self.Config.AutoRotate,
        RotateInterval = self.Config.RotateInterval,
        Enabled = self.Config.Enabled,
        ShowCloseButton = self.Config.ShowCloseButton,
    }
end

-- Appliquer configuration custom
function AdController:ApplyConfig(newConfig)
    if not newConfig then return false end
    
    if newConfig.Position then
        self:SetPosition(newConfig.Position)
    end
    
    if newConfig.AutoRotate ~= nil then
        self.Config.AutoRotate = newConfig.AutoRotate
        if self.AdManager then
            self.AdManager.Config.AutoRotate = newConfig.AutoRotate
        end
    end
    
    if newConfig.RotateInterval then
        self:SetRotateInterval(newConfig.RotateInterval)
    end
    
    if newConfig.Enabled ~= nil then
        if newConfig.Enabled and not self.Config.Enabled then
            self:Enable()
        elseif not newConfig.Enabled and self.Config.Enabled then
            self:Disable()
        end
    end
    
    if newConfig.ShowCloseButton ~= nil then
        self.Config.ShowCloseButton = newConfig.ShowCloseButton
        if self.AdManager and self.AdManager.Display then
            local closeBtn = self.AdManager.Display.CloseButton
            if closeBtn then
                closeBtn.Visible = newConfig.ShowCloseButton
            end
        end
    end
    
    self:SaveConfig()
    print("[AdController] Configuration appliquée")
    return true
end

-- Sauvegarder configuration
function AdController:SaveConfig()
    if not writefile then
        warn("[AdController] writefile non disponible, config non sauvegardée")
        return false
    end
    
    local success, result = pcall(function()
        local HttpService = game:GetService("HttpService")
        local json = HttpService:JSONEncode(self.Config)
        writefile(self.ConfigFile, json)
    end)
    
    if not success then
        warn("[AdController] Erreur sauvegarde config:", result)
        return false
    end
    
    return true
end

-- Charger configuration
function AdController:LoadConfig()
    if not readfile or not isfile then
        return false
    end
    
    local success, result = pcall(function()
        if not isfile(self.ConfigFile) then
            return false
        end
        
        local HttpService = game:GetService("HttpService")
        local json = readfile(self.ConfigFile)
        local config = HttpService:JSONDecode(json)
        
        -- Appliquer config chargée
        for key, value in pairs(config) do
            if self.Config[key] ~= nil then
                self.Config[key] = value
            end
        end
        
        print("[AdController] Configuration chargée depuis", self.ConfigFile)
        return true
    end)
    
    if not success then
        warn("[AdController] Erreur chargement config:", result)
        return false
    end
    
    return true
end

-- Créer raccourcis clavier (optionnel)
function AdController:SetupHotkeys()
    local UserInputService = game:GetService("UserInputService")
    
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        
        -- Ctrl + Alt + N : Next Ad
        if input.KeyCode == Enum.KeyCode.N and UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) and UserInputService:IsKeyDown(Enum.KeyCode.LeftAlt) then
            self:NextAd()
        end
        
        -- Ctrl + Alt + H : Hide/Show Ads
        if input.KeyCode == Enum.KeyCode.H and UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) and UserInputService:IsKeyDown(Enum.KeyCode.LeftAlt) then
            self:ToggleAds()
        end
        
        -- Ctrl + Alt + P : Change Position (cycle)
        if input.KeyCode == Enum.KeyCode.P and UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) and UserInputService:IsKeyDown(Enum.KeyCode.LeftAlt) then
            if self.AdManager then
                local AdPositions = require(script.Parent.AdPositions)
                local nextPos = AdPositions:GetNext(self.Config.Position)
                self:SetPosition(nextPos)
            end
        end
    end)
    
    print("[AdController] Raccourcis clavier activés:")
    print("  Ctrl+Alt+N : Prochaine publicité")
    print("  Ctrl+Alt+H : Afficher/Masquer pubs")
    print("  Ctrl+Alt+P : Changer position")
end

-- Debug : afficher config actuelle
function AdController:PrintConfig()
    print("=== AdController Configuration ===")
    print("Position:", self.Config.Position)
    print("Auto-Rotate:", self.Config.AutoRotate)
    print("Rotate Interval:", self.Config.RotateInterval, "s")
    print("Enabled:", self.Config.Enabled)
    print("Show Close Button:", self.Config.ShowCloseButton)
    
    local stats = self:GetStats()
    print("\n=== Statistiques ===")
    print("Impressions:", stats.Impressions)
    print("Clicks:", stats.Clicks)
    print("Revenue estimé:", "$" .. tostring(stats.Revenue))
end

return AdController

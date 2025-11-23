--[[
    AdDisplay.lua
    Renderer pour bannières publicitaires ImageLabel
    Support : URLs HTTP, rbxassetid://, cache, animations
]]

local AdDisplay = {}
AdDisplay.__index = AdDisplay

-- Services Roblox
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")

-- Configuration
local FADE_DURATION = 0.5
local CLICK_COOLDOWN = 1 -- secondes
local CACHE_DURATION = 300 -- 5 minutes

-- Cache images chargées
local ImageCache = {}

-- Créer nouveau display
function AdDisplay.new(parent, adData, position, size)
    local self = setmetatable({}, AdDisplay)
    
    self.Parent = parent or game:GetService("CoreGui")
    self.AdData = adData or {}
    self.Position = position
    self.Size = size
    self.IsVisible = false
    self.LastClickTime = 0
    self.Container = nil
    self.ImageLabel = nil
    self.CloseButton = nil
    
    self:CreateUI()
    
    return self
end

-- Créer l'interface
function AdDisplay:CreateUI()
    -- Container Frame
    self.Container = Instance.new("Frame")
    self.Container.Name = "AdDisplayContainer"
    self.Container.Size = self.Size
    self.Container.Position = self.Position
    self.Container.BackgroundTransparency = 1
    self.Container.BorderSizePixel = 0
    self.Container.ZIndex = 10
    self.Container.Visible = false
    
    -- Protection contre détection
    if syn and syn.protect_gui then
        syn.protect_gui(self.Container)
    end
    
    -- Border/Shadow effet
    local border = Instance.new("Frame")
    border.Name = "Border"
    border.Size = UDim2.new(1, 4, 1, 4)
    border.Position = UDim2.new(0, -2, 0, -2)
    border.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    border.BackgroundTransparency = 0.5
    border.BorderSizePixel = 0
    border.ZIndex = 9
    border.Parent = self.Container
    
    -- Corner arrondi border
    local borderCorner = Instance.new("UICorner")
    borderCorner.CornerRadius = UDim.new(0, 8)
    borderCorner.Parent = border
    
    -- ImageButton cliquable
    self.ImageLabel = Instance.new("ImageButton")
    self.ImageLabel.Name = "AdBanner"
    self.ImageLabel.Size = UDim2.new(1, 0, 1, 0)
    self.ImageLabel.Position = UDim2.new(0, 0, 0, 0)
    self.ImageLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    self.ImageLabel.BorderSizePixel = 0
    self.ImageLabel.ImageTransparency = 0
    self.ImageLabel.ScaleType = Enum.ScaleType.Fit
    self.ImageLabel.ZIndex = 10
    self.ImageLabel.AutoButtonColor = false
    self.ImageLabel.Parent = self.Container
    
    -- Corner arrondi
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = self.ImageLabel
    
    -- Loading indicator (pendant chargement image)
    local loadingLabel = Instance.new("TextLabel")
    loadingLabel.Name = "LoadingLabel"
    loadingLabel.Size = UDim2.new(1, 0, 1, 0)
    loadingLabel.BackgroundTransparency = 1
    loadingLabel.Text = "Chargement..."
    loadingLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    loadingLabel.TextSize = 14
    loadingLabel.Font = Enum.Font.GothamMedium
    loadingLabel.ZIndex = 11
    loadingLabel.Visible = false
    loadingLabel.Parent = self.ImageLabel
    
    -- Bouton fermeture (X)
    self.CloseButton = Instance.new("TextButton")
    self.CloseButton.Name = "CloseButton"
    self.CloseButton.Size = UDim2.new(0, 20, 0, 20)
    self.CloseButton.Position = UDim2.new(1, -25, 0, 5)
    self.CloseButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    self.CloseButton.Text = "×"
    self.CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    self.CloseButton.TextSize = 18
    self.CloseButton.Font = Enum.Font.GothamBold
    self.CloseButton.ZIndex = 12
    self.CloseButton.BorderSizePixel = 0
    self.CloseButton.Parent = self.Container
    
    -- Corner bouton fermeture
    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(1, 0)
    closeCorner.Parent = self.CloseButton
    
    -- "Ad" label (transparence publicitaire)
    local adLabel = Instance.new("TextLabel")
    adLabel.Name = "AdLabel"
    adLabel.Size = UDim2.new(0, 30, 0, 15)
    adLabel.Position = UDim2.new(0, 5, 0, 5)
    adLabel.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    adLabel.BackgroundTransparency = 0.3
    adLabel.Text = "Ad"
    adLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    adLabel.TextSize = 10
    adLabel.Font = Enum.Font.GothamBold
    adLabel.ZIndex = 12
    adLabel.BorderSizePixel = 0
    adLabel.Parent = self.Container
    
    local adCorner = Instance.new("UICorner")
    adCorner.CornerRadius = UDim.new(0, 4)
    adCorner.Parent = adLabel
    
    -- Events
    self.CloseButton.MouseButton1Click:Connect(function()
        self:Hide()
    end)
    
    self.ImageLabel.MouseButton1Click:Connect(function()
        self:HandleClick()
    end)
    
    -- Hover effet
    self.ImageLabel.MouseEnter:Connect(function()
        self:Tween(self.ImageLabel, {ImageTransparency = 0.1}, 0.2)
    end)
    
    self.ImageLabel.MouseLeave:Connect(function()
        self:Tween(self.ImageLabel, {ImageTransparency = 0}, 0.2)
    end)
    
    self.Container.Parent = self.Parent
end

-- Charger image depuis URL ou Asset ID
function AdDisplay:LoadImage(imageUrl)
    if not imageUrl or imageUrl == "" then
        warn("[AdDisplay] URL image vide")
        return false
    end
    
    -- Vérifier cache
    if ImageCache[imageUrl] and os.time() - ImageCache[imageUrl].Time < CACHE_DURATION then
        self.ImageLabel.Image = ImageCache[imageUrl].Data
        return true
    end
    
    -- Afficher loading
    local loadingLabel = self.ImageLabel:FindFirstChild("LoadingLabel")
    if loadingLabel then
        loadingLabel.Visible = true
    end
    
    -- Charger image
    local success, result = pcall(function()
        -- Support rbxassetid://
        if string.find(imageUrl, "rbxassetid://") then
            self.ImageLabel.Image = imageUrl
            ImageCache[imageUrl] = {Data = imageUrl, Time = os.time()}
            return true
        end
        
        -- Support URLs HTTP (nécessite proxy pour Roblox)
        -- Note: Roblox ne peut pas charger images HTTP directement
        -- Il faut upload sur Roblox ou utiliser service proxy
        if string.find(imageUrl, "http") then
            -- Tentative chargement direct (peut échouer)
            self.ImageLabel.Image = imageUrl
            ImageCache[imageUrl] = {Data = imageUrl, Time = os.time()}
            return true
        end
        
        return false
    end)
    
    -- Cacher loading
    if loadingLabel then
        loadingLabel.Visible = false
    end
    
    if not success then
        warn("[AdDisplay] Erreur chargement image:", result)
        return false
    end
    
    return true
end

-- Mettre à jour publicité
function AdDisplay:UpdateAd(adData)
    if not adData then return end
    
    self.AdData = adData
    
    -- Charger nouvelle image
    if adData.Image then
        self:LoadImage(adData.Image)
    end
end

-- Afficher avec animation
function AdDisplay:Show()
    if self.IsVisible then return end
    
    self.Container.Visible = true
    self.IsVisible = true
    
    -- Animation fade-in
    self.Container.BackgroundTransparency = 1
    self.ImageLabel.ImageTransparency = 1
    
    self:Tween(self.Container, {BackgroundTransparency = 1}, FADE_DURATION)
    self:Tween(self.ImageLabel, {ImageTransparency = 0}, FADE_DURATION)
    
    -- Callback show
    if self.AdData.OnShow then
        self.AdData.OnShow()
    end
end

-- Masquer avec animation
function AdDisplay:Hide()
    if not self.IsVisible then return end
    
    -- Animation fade-out
    self:Tween(self.Container, {BackgroundTransparency = 1}, FADE_DURATION)
    self:Tween(self.ImageLabel, {ImageTransparency = 1}, FADE_DURATION, function()
        self.Container.Visible = false
        self.IsVisible = false
    end)
    
    -- Callback hide
    if self.AdData.OnHide then
        self.AdData.OnHide()
    end
end

-- Gérer clic sur publicité
function AdDisplay:HandleClick()
    -- Cooldown anti-spam
    local currentTime = os.time()
    if currentTime - self.LastClickTime < CLICK_COOLDOWN then
        return
    end
    self.LastClickTime = currentTime
    
    -- Callback click
    if self.AdData.OnClick then
        self.AdData.OnClick()
    end
    
    -- Ouvrir lien si disponible
    if self.AdData.Link then
        -- Copier lien dans clipboard (syn/krnl)
        if setclipboard then
            setclipboard(self.AdData.Link)
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "Publicité",
                Text = "Lien copié dans le presse-papier !",
                Duration = 3,
            })
        end
        
        -- Message console
        print("[AdDisplay] Clic publicité:", self.AdData.Link)
    end
end

-- Changer position
function AdDisplay:SetPosition(newPosition)
    if not self.Container then return end
    
    self.Position = newPosition
    self:Tween(self.Container, {Position = newPosition}, 0.3)
end

-- Changer taille
function AdDisplay:SetSize(newSize)
    if not self.Container then return end
    
    self.Size = newSize
    self:Tween(self.Container, {Size = newSize}, 0.3)
end

-- Utilitaire Tween
function AdDisplay:Tween(instance, properties, duration, callback)
    local tweenInfo = TweenInfo.new(
        duration or 0.3,
        Enum.EasingStyle.Quad,
        Enum.EasingDirection.Out
    )
    
    local tween = TweenService:Create(instance, tweenInfo, properties)
    
    if callback then
        tween.Completed:Connect(callback)
    end
    
    tween:Play()
    return tween
end

-- Nettoyer
function AdDisplay:Destroy()
    if self.Container then
        self.Container:Destroy()
    end
    
    self.Container = nil
    self.ImageLabel = nil
    self.CloseButton = nil
end

-- Toggle visibilité
function AdDisplay:Toggle()
    if self.IsVisible then
        self:Hide()
    else
        self:Show()
    end
end

return AdDisplay

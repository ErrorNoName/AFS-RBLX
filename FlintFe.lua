-- FE Fling System 2025 - Compact Navio Edition with Selector Tool
-- By ErrorNoName - July 2025
-- Interface compacte avec tool selector et anti auto-fling optionnel

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer
local mouse = player:GetMouse()

-- Configuration
local GUI_KEY = Enum.KeyCode.RightShift
local THEME = {
    bg_primary = Color3.fromRGB(18, 18, 20),
    bg_secondary = Color3.fromRGB(25, 25, 28),
    bg_tertiary = Color3.fromRGB(32, 32, 36),
    accent_primary = Color3.fromRGB(124, 77, 255),
    accent_secondary = Color3.fromRGB(144, 97, 249),
    accent_light = Color3.fromRGB(164, 117, 243),
    text_primary = Color3.fromRGB(255, 255, 255),
    text_secondary = Color3.fromRGB(160, 160, 170),
    text_muted = Color3.fromRGB(100, 100, 110),
    success = Color3.fromRGB(34, 197, 94),
    warning = Color3.fromRGB(251, 146, 60),
    danger = Color3.fromRGB(239, 68, 68),
}

-- Variables
local selectedPlayer = nil
local flingPower = 5000
local flingConnections = {}
local selectorEnabled = false
local espBoxes = {}
local hoveredPlayer = nil
local safePosition = nil
local selectorTool = nil
local antiAutoFlingEnabled = false -- Désactivé par défaut
local antiAutoFlingConnection = nil

-- GUI Creation
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "NavioFlingSystem"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = game:GetService("CoreGui") or player:WaitForChild("PlayerGui")

-- ESP Functions
local function createESP(target)
    if espBoxes[target] then return end
    
    local box = Instance.new("BoxHandleAdornment")
    box.Size = Vector3.new(4, 6, 4)
    box.Color3 = THEME.accent_primary
    box.Transparency = 0.5
    box.AlwaysOnTop = true
    box.ZIndex = 10
    box.Adornee = target.Character and target.Character:FindFirstChild("HumanoidRootPart")
    box.Parent = target.Character
    
    espBoxes[target] = box
end

local function removeESP(target)
    if espBoxes[target] then
        espBoxes[target]:Destroy()
        espBoxes[target] = nil
    end
end

local function removeAllESP()
    for _, box in pairs(espBoxes) do
        if box then
            box:Destroy()
        end
    end
    espBoxes = {}
end

-- Selector Tool Creation
local function createSelectorTool()
    if selectorTool then selectorTool:Destroy() end
    
    selectorTool = Instance.new("Tool")
    selectorTool.Name = "Fling Selector"
    selectorTool.RequiresHandle = true
    selectorTool.CanBeDropped = false
    
    local handle = Instance.new("Part")
    handle.Name = "Handle"
    handle.Size = Vector3.new(1, 4, 1)
    handle.Material = Enum.Material.Neon
    handle.BrickColor = BrickColor.new("Royal purple")
    handle.TopSurface = Enum.SurfaceType.Smooth
    handle.BottomSurface = Enum.SurfaceType.Smooth
    handle.CanCollide = false
    handle.Parent = selectorTool
    
    -- Glow effect
    local pointLight = Instance.new("PointLight")
    pointLight.Brightness = 2
    pointLight.Color = THEME.accent_primary
    pointLight.Range = 10
    pointLight.Parent = handle
    
    -- Mesh
    local mesh = Instance.new("SpecialMesh")
    mesh.MeshType = Enum.MeshType.Cylinder
    mesh.Scale = Vector3.new(1.2, 1, 1.2)
    mesh.Parent = handle
    
    selectorTool.Parent = player.Backpack
    
    -- Tool equipped
    selectorTool.Equipped:Connect(function()
        selectorEnabled = true
        
        -- Save safe position when equipping only if anti auto-fling is enabled
        if antiAutoFlingEnabled and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            safePosition = player.Character.HumanoidRootPart.CFrame
        end
    end)
    
    selectorTool.Unequipped:Connect(function()
        selectorEnabled = false
        removeAllESP()
        hoveredPlayer = nil
    end)
    
    -- Tool activated (click) - Uses Network Fling
    selectorTool.Activated:Connect(function()
        if hoveredPlayer and hoveredPlayer.Character then
            -- Flash effect
            if espBoxes[hoveredPlayer] then
                espBoxes[hoveredPlayer].Color3 = THEME.success
                wait(0.2)
                espBoxes[hoveredPlayer].Color3 = THEME.accent_primary
            end
            
            -- Save position if anti auto-fling is enabled
            if antiAutoFlingEnabled and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                safePosition = player.Character.HumanoidRootPart.CFrame
            end
            
            -- Use Spin Fling method
            spinFling(hoveredPlayer)
        end
    end)
end

-- Anti Auto-Fling System
local function setupAntiAutoFling()
    if antiAutoFlingConnection then
        antiAutoFlingConnection:Disconnect()
    end
    
    if antiAutoFlingEnabled then
        antiAutoFlingConnection = RunService.Heartbeat:Connect(function()
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                local rootPart = player.Character.HumanoidRootPart
                
                -- Check if falling or moving too fast (only teleport if anti auto-fling is enabled)
                if antiAutoFlingEnabled and (rootPart.AssemblyLinearVelocity.Magnitude > 1000 or rootPart.Position.Y < -200) then
                    if safePosition then
                        rootPart.CFrame = safePosition
                        rootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                        rootPart.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
                    end
                end
            end
        end)
    end
end

-- SPLASH SCREEN (Sans fond gris)
local SplashContainer = Instance.new("Frame")
SplashContainer.Size = UDim2.new(0, 400, 0, 500)
SplashContainer.Position = UDim2.new(0.5, -200, 0.5, -250)
SplashContainer.BackgroundColor3 = THEME.bg_secondary
SplashContainer.BorderSizePixel = 0
SplashContainer.Parent = ScreenGui

local SplashCorner = Instance.new("UICorner")
SplashCorner.CornerRadius = UDim.new(0, 24)
SplashCorner.Parent = SplashContainer

local SplashGradient = Instance.new("UIGradient")
SplashGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, THEME.bg_secondary),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(30, 25, 40))
}
SplashGradient.Rotation = 90
SplashGradient.Parent = SplashContainer

-- Logo avec points violets
local LogoFrame = Instance.new("Frame")
LogoFrame.Size = UDim2.new(0, 200, 0, 200)
LogoFrame.Position = UDim2.new(0.5, -100, 0.2, 0)
LogoFrame.BackgroundTransparency = 1
LogoFrame.Parent = SplashContainer

for i = 1, 2 do
    local Dot = Instance.new("Frame")
    Dot.Size = UDim2.new(0, 8, 0, 8)
    Dot.Position = UDim2.new(0.5 - 0.1 + (i-1) * 0.2, -4, 0.5, -4)
    Dot.BackgroundColor3 = THEME.accent_primary
    Dot.Parent = LogoFrame
    
    local DotCorner = Instance.new("UICorner")
    DotCorner.CornerRadius = UDim.new(1, 0)
    DotCorner.Parent = Dot
end

local LogoText = Instance.new("TextLabel")
LogoText.Size = UDim2.new(1, 0, 0, 60)
LogoText.Position = UDim2.new(0, 0, 0.5, -30)
LogoText.BackgroundTransparency = 1
LogoText.Text = "Navio"
LogoText.TextColor3 = THEME.text_primary
LogoText.TextScaled = true
LogoText.Font = Enum.Font.Gotham
LogoText.Parent = LogoFrame

local Subtitle = Instance.new("TextLabel")
Subtitle.Size = UDim2.new(0.8, 0, 0, 30)
Subtitle.Position = UDim2.new(0.1, 0, 0.5, 0)
Subtitle.BackgroundTransparency = 1
Subtitle.Text = "FE Fling System 2025"
Subtitle.TextColor3 = THEME.text_secondary
Subtitle.TextScaled = true
Subtitle.Font = Enum.Font.Gotham
Subtitle.Parent = SplashContainer

local LoadingFrame = Instance.new("Frame")
LoadingFrame.Size = UDim2.new(0.6, 0, 0, 4)
LoadingFrame.Position = UDim2.new(0.2, 0, 0.7, 0)
LoadingFrame.BackgroundColor3 = THEME.bg_tertiary
LoadingFrame.Parent = SplashContainer

local LoadingCorner = Instance.new("UICorner")
LoadingCorner.CornerRadius = UDim.new(0, 2)
LoadingCorner.Parent = LoadingFrame

local LoadingBar = Instance.new("Frame")
LoadingBar.Size = UDim2.new(0, 0, 1, 0)
LoadingBar.BackgroundColor3 = THEME.accent_primary
LoadingBar.Parent = LoadingFrame

local LoadingBarCorner = Instance.new("UICorner")
LoadingBarCorner.CornerRadius = UDim.new(0, 2)
LoadingBarCorner.Parent = LoadingBar

local LoadingText = Instance.new("TextLabel")
LoadingText.Size = UDim2.new(0.8, 0, 0, 20)
LoadingText.Position = UDim2.new(0.1, 0, 0.8, 0)
LoadingText.BackgroundTransparency = 1
LoadingText.Text = "Loading..."
LoadingText.TextColor3 = THEME.text_muted
LoadingText.TextScaled = true
LoadingText.Font = Enum.Font.Gotham
LoadingText.Parent = SplashContainer

-- MAIN INTERFACE (Compact version)
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 450, 0, 650)
MainFrame.Position = UDim2.new(0.5, -225, 0.5, -325)
MainFrame.BackgroundColor3 = THEME.bg_secondary
MainFrame.BorderSizePixel = 0
MainFrame.Visible = false
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 24)
MainCorner.Parent = MainFrame

local MainGradient = Instance.new("UIGradient")
MainGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, THEME.bg_secondary),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(30, 25, 40))
}
MainGradient.Rotation = 90
MainGradient.Parent = MainFrame

-- Header
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 70)
Header.BackgroundTransparency = 1
Header.Parent = MainFrame

-- Logo dans le header
local HeaderLogo = Instance.new("Frame")
HeaderLogo.Size = UDim2.new(0, 120, 0, 40)
HeaderLogo.Position = UDim2.new(0, 20, 0.5, -20)
HeaderLogo.BackgroundTransparency = 1
HeaderLogo.Parent = Header

for i = 1, 2 do
    local Dot = Instance.new("Frame")
    Dot.Size = UDim2.new(0, 8, 0, 8)
    Dot.Position = UDim2.new(0, (i-1) * 12, 0.5, -4)
    Dot.BackgroundColor3 = THEME.accent_primary
    Dot.Parent = HeaderLogo
    
    local DotCorner = Instance.new("UICorner")
    DotCorner.CornerRadius = UDim.new(1, 0)
    DotCorner.Parent = Dot
end

local HeaderTitle = Instance.new("TextLabel")
HeaderTitle.Size = UDim2.new(0, 60, 1, 0)
HeaderTitle.Position = UDim2.new(0, 30, 0, 0)
HeaderTitle.BackgroundTransparency = 1
HeaderTitle.Text = "Navio"
HeaderTitle.TextColor3 = THEME.text_primary
HeaderTitle.TextScaled = true
HeaderTitle.TextXAlignment = Enum.TextXAlignment.Left
HeaderTitle.Font = Enum.Font.GothamBold
HeaderTitle.Parent = HeaderLogo

-- Close button
local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 35, 0, 35)
CloseButton.Position = UDim2.new(1, -50, 0.5, -17.5)
CloseButton.BackgroundColor3 = THEME.bg_tertiary
CloseButton.Text = "✕"
CloseButton.TextColor3 = THEME.text_secondary
CloseButton.TextScaled = true
CloseButton.Font = Enum.Font.Gotham
CloseButton.Parent = Header

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 10)
CloseCorner.Parent = CloseButton

-- Content Container
local Content = Instance.new("Frame")
Content.Size = UDim2.new(1, -40, 1, -90)
Content.Position = UDim2.new(0, 20, 0, 80)
Content.BackgroundTransparency = 1
Content.Parent = MainFrame

-- Selector Tool Button
local SelectorButton = Instance.new("TextButton")
SelectorButton.Size = UDim2.new(1, 0, 0, 50)
SelectorButton.BackgroundColor3 = THEME.accent_primary
SelectorButton.Text = "🎯 Get Selector Tool"
SelectorButton.TextColor3 = THEME.text_primary
SelectorButton.TextScaled = true
SelectorButton.Font = Enum.Font.GothamBold
SelectorButton.Parent = Content

local SelectorCorner = Instance.new("UICorner")
SelectorCorner.CornerRadius = UDim.new(0, 12)
SelectorCorner.Parent = SelectorButton

SelectorButton.MouseButton1Click:Connect(function()
    createSelectorTool()
    SelectorButton.Text = "✓ Tool Given"
    SelectorButton.BackgroundColor3 = THEME.success
    wait(1)
    SelectorButton.Text = "🎯 Get Selector Tool"
    SelectorButton.BackgroundColor3 = THEME.accent_primary
end)

-- Player Selection Section
local PlayerSection = Instance.new("Frame")
PlayerSection.Size = UDim2.new(1, 0, 0, 180)
PlayerSection.Position = UDim2.new(0, 0, 0, 60)
PlayerSection.BackgroundColor3 = THEME.bg_tertiary
PlayerSection.Parent = Content

local PlayerCorner = Instance.new("UICorner")
PlayerCorner.CornerRadius = UDim.new(0, 16)
PlayerCorner.Parent = PlayerSection

local PlayerTitle = Instance.new("TextLabel")
PlayerTitle.Size = UDim2.new(1, -20, 0, 35)
PlayerTitle.Position = UDim2.new(0, 10, 0, 10)
PlayerTitle.BackgroundTransparency = 1
PlayerTitle.Text = "Select Target"
PlayerTitle.TextColor3 = THEME.text_primary
PlayerTitle.TextScaled = true
PlayerTitle.TextXAlignment = Enum.TextXAlignment.Left
PlayerTitle.Font = Enum.Font.GothamMedium
PlayerTitle.Parent = PlayerSection

-- Search bar
local SearchFrame = Instance.new("Frame")
SearchFrame.Size = UDim2.new(1, -20, 0, 30)
SearchFrame.Position = UDim2.new(0, 10, 0, 45)
SearchFrame.BackgroundColor3 = THEME.bg_secondary
SearchFrame.Parent = PlayerSection

local SearchCorner = Instance.new("UICorner")
SearchCorner.CornerRadius = UDim.new(0, 10)
SearchCorner.Parent = SearchFrame

local SearchBox = Instance.new("TextBox")
SearchBox.Size = UDim2.new(1, -10, 1, 0)
SearchBox.Position = UDim2.new(0, 5, 0, 0)
SearchBox.BackgroundTransparency = 1
SearchBox.PlaceholderText = "🔍 Search players..."
SearchBox.PlaceholderColor3 = THEME.text_muted
SearchBox.Text = ""
SearchBox.TextColor3 = THEME.text_primary
SearchBox.TextScaled = true
SearchBox.TextXAlignment = Enum.TextXAlignment.Left
SearchBox.Font = Enum.Font.Gotham
SearchBox.Parent = SearchFrame

-- Players list
local PlayersList = Instance.new("ScrollingFrame")
PlayersList.Size = UDim2.new(1, -20, 1, -85)
PlayersList.Position = UDim2.new(0, 10, 0, 80)
PlayersList.BackgroundTransparency = 1
PlayersList.ScrollBarThickness = 4
PlayersList.ScrollBarImageColor3 = THEME.accent_primary
PlayersList.Parent = PlayerSection

-- Settings Section
local SettingsSection = Instance.new("Frame")
SettingsSection.Size = UDim2.new(1, 0, 0, 130)
SettingsSection.Position = UDim2.new(0, 0, 0, 250)
SettingsSection.BackgroundColor3 = THEME.bg_tertiary
SettingsSection.Parent = Content

local SettingsCorner = Instance.new("UICorner")
SettingsCorner.CornerRadius = UDim.new(0, 16)
SettingsCorner.Parent = SettingsSection

-- Power settings
local PowerLabel = Instance.new("TextLabel")
PowerLabel.Size = UDim2.new(0.5, 0, 0, 25)
PowerLabel.Position = UDim2.new(0, 15, 0, 15)
PowerLabel.BackgroundTransparency = 1
PowerLabel.Text = "Fling Power"
PowerLabel.TextColor3 = THEME.text_secondary
PowerLabel.TextScaled = true
PowerLabel.TextXAlignment = Enum.TextXAlignment.Left
PowerLabel.Font = Enum.Font.Gotham
PowerLabel.Parent = SettingsSection

local PowerValue = Instance.new("TextLabel")
PowerValue.Size = UDim2.new(0, 50, 0, 25)
PowerValue.Position = UDim2.new(1, -65, 0, 15)
PowerValue.BackgroundTransparency = 1
PowerValue.Text = "5000"
PowerValue.TextColor3 = THEME.accent_primary
PowerValue.TextScaled = true
PowerValue.Font = Enum.Font.GothamBold
PowerValue.Parent = SettingsSection

local PowerSlider = Instance.new("Frame")
PowerSlider.Size = UDim2.new(1, -30, 0, 6)
PowerSlider.Position = UDim2.new(0, 15, 0, 50)
PowerSlider.BackgroundColor3 = THEME.bg_secondary
PowerSlider.Parent = SettingsSection

local PowerSliderCorner = Instance.new("UICorner")
PowerSliderCorner.CornerRadius = UDim.new(0, 3)
PowerSliderCorner.Parent = PowerSlider

local PowerFill = Instance.new("Frame")
PowerFill.Size = UDim2.new(0.5, 0, 1, 0)
PowerFill.BackgroundColor3 = THEME.accent_primary
PowerFill.Parent = PowerSlider

local PowerFillCorner = Instance.new("UICorner")
PowerFillCorner.CornerRadius = UDim.new(0, 3)
PowerFillCorner.Parent = PowerFill

local PowerHandle = Instance.new("TextButton")
PowerHandle.Size = UDim2.new(0, 14, 0, 14)
PowerHandle.Position = UDim2.new(0.5, -7, 0.5, -7)
PowerHandle.BackgroundColor3 = THEME.text_primary
PowerHandle.Text = ""
PowerHandle.Parent = PowerSlider

local PowerHandleCorner = Instance.new("UICorner")
PowerHandleCorner.CornerRadius = UDim.new(1, 0)
PowerHandleCorner.Parent = PowerHandle

-- Anti Auto-Fling Toggle
local AntiAutoFlingFrame = Instance.new("Frame")
AntiAutoFlingFrame.Size = UDim2.new(1, -30, 0, 35)
AntiAutoFlingFrame.Position = UDim2.new(0, 15, 0, 80)
AntiAutoFlingFrame.BackgroundTransparency = 1
AntiAutoFlingFrame.Parent = SettingsSection

local AntiAutoFlingLabel = Instance.new("TextLabel")
AntiAutoFlingLabel.Size = UDim2.new(0.7, 0, 1, 0)
AntiAutoFlingLabel.BackgroundTransparency = 1
AntiAutoFlingLabel.Text = "Anti Auto-Fling"
AntiAutoFlingLabel.TextColor3 = THEME.text_secondary
AntiAutoFlingLabel.TextScaled = true
AntiAutoFlingLabel.TextXAlignment = Enum.TextXAlignment.Left
AntiAutoFlingLabel.Font = Enum.Font.Gotham
AntiAutoFlingLabel.Parent = AntiAutoFlingFrame

local AntiAutoFlingToggle = Instance.new("TextButton")
AntiAutoFlingToggle.Size = UDim2.new(0, 60, 0, 30)
AntiAutoFlingToggle.Position = UDim2.new(1, -60, 0.5, -15)
AntiAutoFlingToggle.BackgroundColor3 = THEME.bg_secondary
AntiAutoFlingToggle.Text = ""
AntiAutoFlingToggle.Parent = AntiAutoFlingFrame

local AntiAutoFlingToggleCorner = Instance.new("UICorner")
AntiAutoFlingToggleCorner.CornerRadius = UDim.new(0, 15)
AntiAutoFlingToggleCorner.Parent = AntiAutoFlingToggle

local AntiAutoFlingToggleSlider = Instance.new("Frame")
AntiAutoFlingToggleSlider.Size = UDim2.new(0, 26, 0, 26)
AntiAutoFlingToggleSlider.Position = UDim2.new(0, 2, 0.5, -13)
AntiAutoFlingToggleSlider.BackgroundColor3 = THEME.text_secondary
AntiAutoFlingToggleSlider.Parent = AntiAutoFlingToggle

local AntiAutoFlingToggleSliderCorner = Instance.new("UICorner")
AntiAutoFlingToggleSliderCorner.CornerRadius = UDim.new(1, 0)
AntiAutoFlingToggleSliderCorner.Parent = AntiAutoFlingToggleSlider

-- Toggle function
AntiAutoFlingToggle.MouseButton1Click:Connect(function()
    antiAutoFlingEnabled = not antiAutoFlingEnabled
    
    if antiAutoFlingEnabled then
        -- Save current position
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            safePosition = player.Character.HumanoidRootPart.CFrame
        end
        
        -- Animation
        TweenService:Create(AntiAutoFlingToggleSlider, TweenInfo.new(0.2), {
            Position = UDim2.new(1, -28, 0.5, -13)
        }):Play()
        TweenService:Create(AntiAutoFlingToggle, TweenInfo.new(0.2), {
            BackgroundColor3 = THEME.accent_primary
        }):Play()
        TweenService:Create(AntiAutoFlingToggleSlider, TweenInfo.new(0.2), {
            BackgroundColor3 = THEME.text_primary
        }):Play()
        
        setupAntiAutoFling()
    else
        -- Animation
        TweenService:Create(AntiAutoFlingToggleSlider, TweenInfo.new(0.2), {
            Position = UDim2.new(0, 2, 0.5, -13)
        }):Play()
        TweenService:Create(AntiAutoFlingToggle, TweenInfo.new(0.2), {
            BackgroundColor3 = THEME.bg_secondary
        }):Play()
        TweenService:Create(AntiAutoFlingToggleSlider, TweenInfo.new(0.2), {
            BackgroundColor3 = THEME.text_secondary
        }):Play()
        
        if antiAutoFlingConnection then
            antiAutoFlingConnection:Disconnect()
            antiAutoFlingConnection = nil
        end
    end
end)

-- Method Buttons
local MethodsSection = Instance.new("Frame")
MethodsSection.Size = UDim2.new(1, 0, 0, 140)
MethodsSection.Position = UDim2.new(0, 0, 0, 390)
MethodsSection.BackgroundTransparency = 1
MethodsSection.Parent = Content

local methods = {
    {name = "Network Fling", color = THEME.success, desc = "Most effective", method = "network"},
    {name = "Invisible Fling", color = THEME.warning, desc = "Stealth mode", method = "invisible"},
    {name = "Spin Fling", color = THEME.accent_primary, desc = "Classic spin", method = "spin"}
}

for i, methodData in ipairs(methods) do
    local MethodButton = Instance.new("TextButton")
    MethodButton.Size = UDim2.new(1, 0, 0, 40)
    MethodButton.Position = UDim2.new(0, 0, 0, (i-1) * 45)
    MethodButton.BackgroundColor3 = THEME.bg_tertiary
    MethodButton.Text = ""
    MethodButton.Parent = MethodsSection
    
    local MethodCorner = Instance.new("UICorner")
    MethodCorner.CornerRadius = UDim.new(0, 12)
    MethodCorner.Parent = MethodButton
    
    local MethodAccent = Instance.new("Frame")
    MethodAccent.Size = UDim2.new(0, 4, 0.6, 0)
    MethodAccent.Position = UDim2.new(0, 10, 0.2, 0)
    MethodAccent.BackgroundColor3 = methodData.color
    MethodAccent.BorderSizePixel = 0
    MethodAccent.Parent = MethodButton
    
    local AccentCorner = Instance.new("UICorner")
    AccentCorner.CornerRadius = UDim.new(0, 2)
    AccentCorner.Parent = MethodAccent
    
    local MethodName = Instance.new("TextLabel")
    MethodName.Size = UDim2.new(0.6, -30, 0.5, 0)
    MethodName.Position = UDim2.new(0, 25, 0, 0)
    MethodName.BackgroundTransparency = 1
    MethodName.Text = methodData.name
    MethodName.TextColor3 = THEME.text_primary
    MethodName.TextScaled = true
    MethodName.TextXAlignment = Enum.TextXAlignment.Left
    MethodName.Font = Enum.Font.GothamMedium
    MethodName.Parent = MethodButton
    
    local MethodDesc = Instance.new("TextLabel")
    MethodDesc.Size = UDim2.new(0.6, -30, 0.5, 0)
    MethodDesc.Position = UDim2.new(0, 25, 0.5, 0)
    MethodDesc.BackgroundTransparency = 1
    MethodDesc.Text = methodData.desc
    MethodDesc.TextColor3 = THEME.text_secondary
    MethodDesc.TextScaled = true
    MethodDesc.TextXAlignment = Enum.TextXAlignment.Left
    MethodDesc.Font = Enum.Font.Gotham
    MethodDesc.Parent = MethodButton
    
    -- Connect method
    MethodButton.MouseButton1Click:Connect(function()
        if selectedPlayer then
            -- Save position before fling ONLY if anti auto-fling is enabled
            if antiAutoFlingEnabled and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                safePosition = player.Character.HumanoidRootPart.CFrame
            end
            
            if methodData.method == "network" then
                networkFling(selectedPlayer)
            elseif methodData.method == "invisible" then
                invisibleFling(selectedPlayer)
            elseif methodData.method == "spin" then
                spinFling(selectedPlayer)
            end
            
            -- Animation feedback
            local originalColor = MethodAccent.BackgroundColor3
            MethodAccent.BackgroundColor3 = THEME.text_primary
            wait(0.2)
            MethodAccent.BackgroundColor3 = originalColor
        end
    end)
    
    -- Hover effect
    MethodButton.MouseEnter:Connect(function()
        TweenService:Create(MethodButton, TweenInfo.new(0.2), {
            BackgroundColor3 = THEME.bg_secondary
        }):Play()
    end)
    
    MethodButton.MouseLeave:Connect(function()
        TweenService:Create(MethodButton, TweenInfo.new(0.2), {
            BackgroundColor3 = THEME.bg_tertiary
        }):Play()
    end)
end

-- FLING METHODS
function networkFling(target)
    local character = player.Character
    if not character then return end
    
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    local rootPart = character:FindFirstChild("HumanoidRootPart") or character:FindFirstChild("Torso")
    
    if not humanoid or not rootPart then return end
    
    local function NoCollide()
        for _, part in pairs(character:GetDescendants()) do
            if part:IsA("BasePart") and part.CanCollide then
                part.CanCollide = false
            end
        end
    end
    
    spawn(function()
        humanoid.AutoRotate = false
        humanoid.Sit = true
        humanoid.PlatformStand = true
        
        local flingLoop = RunService.Heartbeat:Connect(function()
            if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
                NoCollide()
                rootPart.AssemblyLinearVelocity = Vector3.new(flingPower, flingPower, flingPower)
                rootPart.AssemblyAngularVelocity = Vector3.new(flingPower, flingPower, flingPower)
                rootPart.CFrame = target.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -1)
            end
        end)
        
        table.insert(flingConnections, flingLoop)
        
        wait(0.5)
        flingLoop:Disconnect()
        
        -- Reset character state but don't teleport unless anti auto-fling is enabled
        humanoid.AutoRotate = true
        humanoid.Sit = false
        humanoid.PlatformStand = false
        
        -- Only teleport back if anti auto-fling is enabled
        if antiAutoFlingEnabled and safePosition then
            rootPart.CFrame = safePosition
            rootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
            rootPart.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
        end
    end)
end

function invisibleFling(target)
    local character = player.Character
    if not character then return end
    
    local backpack = player.Backpack
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    
    if not rootPart then return end
    
    local tool = Instance.new("Tool")
    tool.RequiresHandle = false
    tool.Name = "Fling"
    tool.Parent = backpack
    
    local handle = Instance.new("Part")
    handle.Name = "Handle"
    handle.Size = Vector3.new(1, 1, 1)
    handle.Transparency = 1
    handle.CanCollide = false
    handle.Parent = tool
    
    tool.Parent = character
    
    spawn(function()
        for i = 1, 50 do
            if target and target.Character then
                rootPart.CFrame = target.Character.HumanoidRootPart.CFrame
                rootPart.AssemblyLinearVelocity = Vector3.new(
                    math.random(-flingPower, flingPower),
                    math.random(-flingPower, flingPower),
                    math.random(-flingPower, flingPower)
                )
            end
            RunService.Heartbeat:Wait()
        end
        
        tool:Destroy()
        
        -- NO automatic return unless anti auto-fling is enabled
        if antiAutoFlingEnabled and safePosition then
            rootPart.CFrame = safePosition
        end
        rootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
    end)
end

function spinFling(target)
    local character = player.Character
    if not character then return end
    
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    
    if not humanoid or not rootPart then return end
    
    local originalWalkSpeed = humanoid.WalkSpeed
    humanoid.WalkSpeed = 500
    
    local platform = Instance.new("Part")
    platform.Size = Vector3.new(10, 1, 10)
    platform.Transparency = 1
    platform.Anchored = true
    platform.Position = rootPart.Position - Vector3.new(0, 3, 0)
    platform.Parent = workspace
    
    spawn(function()
        local spinSpeed = 0
        local spinLoop = RunService.Heartbeat:Connect(function()
            spinSpeed = spinSpeed + 50
            
            if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
                rootPart.CFrame = target.Character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(spinSpeed), 0)
                rootPart.AssemblyAngularVelocity = Vector3.new(0, 1000, 0)
                
                if spinSpeed % 100 == 0 then
                    rootPart.AssemblyLinearVelocity = (target.Character.HumanoidRootPart.Position - rootPart.Position).Unit * flingPower
                end
            end
        end)
        
        table.insert(flingConnections, spinLoop)
        
        wait(3)
        spinLoop:Disconnect()
        platform:Destroy()
        humanoid.WalkSpeed = originalWalkSpeed
        
        -- NO automatic return unless anti auto-fling is enabled
        if antiAutoFlingEnabled and safePosition then
            rootPart.CFrame = safePosition
            rootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
        end
    end)
end

-- Mouse hover detection for selector
RunService.Heartbeat:Connect(function()
    if selectorEnabled then
        local target = mouse.Target
        
        if target and target.Parent then
            local humanoid = target.Parent:FindFirstChildOfClass("Humanoid")
            if humanoid then
                local targetPlayer = Players:GetPlayerFromCharacter(target.Parent)
                if targetPlayer and targetPlayer ~= player then
                    if hoveredPlayer ~= targetPlayer then
                        removeAllESP()
                        hoveredPlayer = targetPlayer
                        createESP(targetPlayer)
                    end
                else
                    if hoveredPlayer then
                        removeAllESP()
                        hoveredPlayer = nil
                    end
                end
            else
                if hoveredPlayer then
                    removeAllESP()
                    hoveredPlayer = nil
                end
            end
        else
            if hoveredPlayer then
                removeAllESP()
                hoveredPlayer = nil
            end
        end
    end
end)

-- Create player button
local function createPlayerButton(plr)
    local PlayerButton = Instance.new("TextButton")
    PlayerButton.Size = UDim2.new(1, -10, 0, 35)
    PlayerButton.BackgroundColor3 = THEME.bg_secondary
    PlayerButton.Text = plr.Name
    PlayerButton.TextColor3 = THEME.text_secondary
    PlayerButton.TextScaled = true
    PlayerButton.Font = Enum.Font.Gotham
    PlayerButton.Parent = PlayersList
    
    local ButtonCorner = Instance.new("UICorner")
    ButtonCorner.CornerRadius = UDim.new(0, 10)
    ButtonCorner.Parent = PlayerButton
    
    PlayerButton.MouseButton1Click:Connect(function()
        selectedPlayer = plr
        -- Update all buttons
        for _, btn in pairs(PlayersList:GetChildren()) do
            if btn:IsA("TextButton") then
                btn.BackgroundColor3 = THEME.bg_secondary
                btn.TextColor3 = THEME.text_secondary
            end
        end
        PlayerButton.BackgroundColor3 = THEME.accent_primary
        PlayerButton.TextColor3 = THEME.text_primary
    end)
    
    return PlayerButton
end

-- Refresh players
local function refreshPlayers()
    for _, child in pairs(PlayersList:GetChildren()) do
        if child:IsA("TextButton") then
            child:Destroy()
        end
    end
    
    local yPos = 5
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= player then
            local btn = createPlayerButton(plr)
            btn.Position = UDim2.new(0, 5, 0, yPos)
            yPos = yPos + 40
        end
    end
    
    PlayersList.CanvasSize = UDim2.new(0, 0, 0, yPos)
end

-- Power slider
local draggingPower = false
PowerHandle.MouseButton1Down:Connect(function()
    draggingPower = true
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        draggingPower = false
    end
end)

mouse.Move:Connect(function()
    if draggingPower then
        local relativeX = math.clamp((mouse.X - PowerSlider.AbsolutePosition.X) / PowerSlider.AbsoluteSize.X, 0, 1)
        PowerFill.Size = UDim2.new(relativeX, 0, 1, 0)
        PowerHandle.Position = UDim2.new(relativeX, -7, 0.5, -7)
        flingPower = math.floor(1000 + (relativeX * 9000))
        PowerValue.Text = tostring(flingPower)
    end
end)

-- Search functionality
SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
    local searchText = SearchBox.Text:lower()
    for _, btn in pairs(PlayersList:GetChildren()) do
        if btn:IsA("TextButton") then
            btn.Visible = btn.Text:lower():find(searchText) ~= nil
        end
    end
end)

-- Close button
CloseButton.MouseButton1Click:Connect(function()
    TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
        Size = UDim2.new(0, 0, 0, 0),
        Position = UDim2.new(0.5, 0, 0.5, 0)
    }):Play()
    
    wait(0.3)
    for _, conn in pairs(flingConnections) do
        conn:Disconnect()
    end
    if antiAutoFlingConnection then
        antiAutoFlingConnection:Disconnect()
    end
    removeAllESP()
    if selectorTool then selectorTool:Destroy() end
    ScreenGui:Destroy()
end)

-- Draggable
local dragging = false
local dragStart = nil
local startPos = nil

Header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

-- Toggle with key
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == GUI_KEY then
        MainFrame.Visible = not MainFrame.Visible
        if MainFrame.Visible then
            TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                Size = UDim2.new(0, 450, 0, 650)
            }):Play()
        end
    end
end)

-- Splash screen animation
spawn(function()
    local loadingSteps = {
        "Initializing...",
        "Loading assets...",
        "Preparing interface...",
        "Setting up tools...",
        "Almost ready..."
    }
    
    for i, text in ipairs(loadingSteps) do
        LoadingText.Text = text
        TweenService:Create(LoadingBar, TweenInfo.new(0.4), {
            Size = UDim2.new(i / #loadingSteps, 0, 1, 0)
        }):Play()
        wait(0.4)
    end
    
    wait(0.5)
    
    -- Fade out splash
    for _, obj in pairs(SplashContainer:GetDescendants()) do
        if obj:IsA("GuiObject") then
            TweenService:Create(obj, TweenInfo.new(0.5), {
                BackgroundTransparency = 1
            }):Play()
        elseif obj:IsA("TextLabel") or obj:IsA("TextBox") then
            TweenService:Create(obj, TweenInfo.new(0.5), {
                TextTransparency = 1
            }):Play()
        end
    end
    
    TweenService:Create(SplashContainer, TweenInfo.new(0.5), {
        BackgroundTransparency = 1
    }):Play()
    
    wait(0.5)
    SplashContainer:Destroy()
    
    -- Show main interface
    MainFrame.Visible = true
    MainFrame.Size = UDim2.new(0, 0, 0, 0)
    MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    
    TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 450, 0, 650),
        Position = UDim2.new(0.5, -225, 0.5, -325)
    }):Play()
    
    refreshPlayers()
end)

-- Auto refresh
Players.PlayerAdded:Connect(refreshPlayers)
Players.PlayerRemoving:Connect(refreshPlayers)

print("[NAVIO FLING] Loaded! Press Right Shift to toggle")
print("[NAVIO FLING] By ErrorNoName - July 2025")
print("[NAVIO FLING] Selector tool uses Spin Fling method")
-- Remote Spy Amélioré pour Roblox
-- Auteur : GitHub Copilot (adapté)
-- UI simple, log tous les RemoteEvent/RemoteFunction, copie/coller/run code, clear output

local G2L = {}
_G.Code = ""

-- UI Setup (Windows 11 style, dark, rounded, shadow, smooth)
G2L["1"] = Instance.new("ScreenGui", game.CoreGui)
G2L["1"].Name = "Remote Spy"
G2L["1"].ResetOnSpawn = false
G2L["1"].ZIndexBehavior = Enum.ZIndexBehavior.Sibling

G2L["2"] = Instance.new("Frame", G2L["1"])
G2L["2"].BorderSizePixel = 0
G2L["2"].BackgroundColor3 = Color3.fromRGB(24, 26, 32) -- Windows 11 dark
G2L["2"].Size = UDim2.new(0, 460, 0, 290)
G2L["2"].Position = UDim2.new(0.02, 0, 0.18, 0)
G2L["2"].BorderColor3 = Color3.fromRGB(0, 0, 0)
G2L["2"].BackgroundTransparency = 0.08
G2L["2"].ClipsDescendants = true
G2L["2"].Name = "MainFrame"
local UICorner = Instance.new("UICorner", G2L["2"])
UICorner.CornerRadius = UDim.new(0, 18)
local UIStroke = Instance.new("UIStroke", G2L["2"])
UIStroke.Color = Color3.fromRGB(60, 70, 90)
UIStroke.Thickness = 2
UIStroke.Transparency = 0.2
local Shadow = Instance.new("ImageLabel", G2L["2"])
Shadow.BackgroundTransparency = 1
Shadow.Image = "rbxassetid://1316045217"
Shadow.Size = UDim2.new(1, 30, 1, 30)
Shadow.Position = UDim2.new(0, -15, 0, -15)
Shadow.ImageTransparency = 0.7
Shadow.ZIndex = 0

-- Animation d'ouverture (fade + scale)
G2L["2"].BackgroundTransparency = 1
G2L["2"].Size = UDim2.new(0, 0, 0, 0)
task.spawn(function()
    local TweenService = game:GetService("TweenService")
    local t1 = TweenService:Create(G2L["2"], TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        BackgroundTransparency = 0.08,
        Size = UDim2.new(0, 460, 0, 290)
    })
    t1:Play()
end)

G2L["3"] = Instance.new("Frame", G2L["2"])
G2L["3"].BorderSizePixel = 0
G2L["3"].BackgroundColor3 = Color3.fromRGB(32, 34, 40)
G2L["3"].Size = UDim2.new(1, 0, 0, 32)
G2L["3"].Position = UDim2.new(0, 0, 0, 0)
G2L["3"].BorderColor3 = Color3.fromRGB(0, 0, 0)
G2L["3"].Name = "TopBar"
local UICornerTop = Instance.new("UICorner", G2L["3"])
UICornerTop.CornerRadius = UDim.new(0, 18)

G2L["4"] = Instance.new("TextLabel", G2L["3"])
G2L["4"].BorderSizePixel = 0
G2L["4"].BackgroundColor3 = Color3.fromRGB(32, 34, 40)
G2L["4"].TextSize = 18
G2L["4"].FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
G2L["4"].TextColor3 = Color3.fromRGB(220, 220, 230)
G2L["4"].BackgroundTransparency = 1
G2L["4"].Size = UDim2.new(0, 180, 0, 32)
G2L["4"].BorderColor3 = Color3.fromRGB(255, 255, 255)
G2L["4"].Text = "Remote Spy"
G2L["4"].Name = "Name"
G2L["4"].Position = UDim2.new(0.03, 0, 0, 0)
G2L["4"].TextXAlignment = Enum.TextXAlignment.Left

G2L["5"] = Instance.new("TextButton", G2L["3"])
G2L["5"].BorderSizePixel = 0
G2L["5"].TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
G2L["5"].TextSize = 20
G2L["5"].TextColor3 = Color3.fromRGB(180, 80, 80)
G2L["5"].BackgroundColor3 = Color3.fromRGB(32, 34, 40)
G2L["5"].FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
G2L["5"].RichText = true
G2L["5"].Size = UDim2.new(0, 32, 0, 32)
G2L["5"].Name = "X"
G2L["5"].BorderColor3 = Color3.fromRGB(0, 0, 0)
G2L["5"].Text = "✕"
G2L["5"].Position = UDim2.new(1, -38, 0, 0)
local UICornerX = Instance.new("UICorner", G2L["5"])
UICornerX.CornerRadius = UDim.new(0, 12)

G2L["6"] = Instance.new("Frame", G2L["2"])
G2L["6"].BorderSizePixel = 0
G2L["6"].BackgroundColor3 = Color3.fromRGB(75, 75, 75)
G2L["6"].Size = UDim2.new(0, 273, 0, 106)
G2L["6"].Position = UDim2.new(0.35765, 0, 0.58103, 0)
G2L["6"].BorderColor3 = Color3.fromRGB(0, 0, 0)
G2L["6"].Name = "Buttons"

G2L["7"] = Instance.new("TextButton", G2L["6"])
G2L["7"].TextSize = 14
G2L["7"].TextColor3 = Color3.fromRGB(255, 255, 255)
G2L["7"].BackgroundColor3 = Color3.fromRGB(27, 27, 29)
G2L["7"].FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
G2L["7"].Size = UDim2.new(0, 93, 0, 17)
G2L["7"].Name = "CopyR"
G2L["7"].BorderColor3 = Color3.fromRGB(139, 139, 139)
G2L["7"].Text = "Copy Remote"
G2L["7"].Position = UDim2.new(0.32967, 0, 0.08491, 0)

G2L["9"] = Instance.new("TextButton", G2L["6"])
G2L["9"].TextSize = 14
G2L["9"].TextColor3 = Color3.fromRGB(255, 255, 255)
G2L["9"].BackgroundColor3 = Color3.fromRGB(27, 27, 29)
G2L["9"].FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
G2L["9"].Size = UDim2.new(0, 83, 0, 17)
G2L["9"].Name = "CopyC"
G2L["9"].BorderColor3 = Color3.fromRGB(139, 139, 139)
G2L["9"].Text = "Copy Code"
G2L["9"].Position = UDim2.new(0, 0, 0.08491, 0)

G2L["b"] = Instance.new("TextButton", G2L["6"])
G2L["b"].TextSize = 14
G2L["b"].TextColor3 = Color3.fromRGB(255, 255, 255)
G2L["b"].BackgroundColor3 = Color3.fromRGB(27, 27, 29)
G2L["b"].FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
G2L["b"].Size = UDim2.new(0, 81, 0, 17)
G2L["b"].Name = "Run"
G2L["b"].BorderColor3 = Color3.fromRGB(139, 139, 139)
G2L["b"].Text = "Run Code"
G2L["b"].Position = UDim2.new(0.7033, 0, 0.08491, 0)

G2L["d2"] = Instance.new("TextButton", G2L["6"])
G2L["d2"].TextSize = 14
G2L["d2"].TextColor3 = Color3.fromRGB(255, 255, 255)
G2L["d2"].BackgroundColor3 = Color3.fromRGB(27, 27, 29)
G2L["d2"].FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
G2L["d2"].Size = UDim2.new(0, 83, 0, 17)
G2L["d2"].Name = "Clear"
G2L["d2"].BorderColor3 = Color3.fromRGB(139, 139, 139)
G2L["d2"].Text = "Clear Output"
G2L["d2"].Position = UDim2.new(0, 0, 0.33962, 0)

G2L["d"] = Instance.new("ScrollingFrame", G2L["2"])
G2L["d"].Active = true
G2L["d"].BorderSizePixel = 0
G2L["d"].CanvasSize = UDim2.new(9999, 9999, 9999, 9999)
G2L["d"].BackgroundColor3 = Color3.fromRGB(54, 54, 56)
G2L["d"].Name = "Remotes"
G2L["d"].ScrollBarImageTransparency = 1
G2L["d"].Size = UDim2.new(0, 152, 0, 236)
G2L["d"].ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0)
G2L["d"].Position = UDim2.new(0, 0, 0.06719, 0)
G2L["d"].BorderColor3 = Color3.fromRGB(0, 0, 0)
G2L["d"].ScrollBarThickness = 0
G2L["d"].LayoutOrder = 1

G2L["e"] = Instance.new("TextButton", G2L["d"])
G2L["e"].BorderSizePixel = 3
G2L["e"].TextSize = 14
G2L["e"].TextColor3 = Color3.fromRGB(255, 255, 255)
G2L["e"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
G2L["e"].FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)
G2L["e"].Size = UDim2.new(0, 152, 0, 22)
G2L["e"].BackgroundTransparency = 0.8
G2L["e"].Name = "RemoteExample"
G2L["e"].BorderColor3 = Color3.fromRGB(93, 96, 102)
G2L["e"].Text = "RemoteName"

G2L["10"] = Instance.new("UIListLayout", G2L["d"])
G2L["10"].Padding = UDim.new(0, 7)
G2L["10"].SortOrder = Enum.SortOrder.LayoutOrder

G2L["11"] = Instance.new("TextBox", G2L["2"])
G2L["11"].CursorPosition = -1
G2L["11"].Interactable = false
G2L["11"].TextColor3 = Color3.fromRGB(0, 0, 0)
G2L["11"].BorderSizePixel = 0
G2L["11"].TextXAlignment = Enum.TextXAlignment.Left
G2L["11"].TextWrapped = true
G2L["11"].TextSize = 15
G2L["11"].Name = "CodeSample"
G2L["11"].TextYAlignment = Enum.TextYAlignment.Top
G2L["11"].BackgroundColor3 = Color3.fromRGB(42, 45, 54)
G2L["11"].FontFace = Font.new("rbxasset://fonts/families/Balthazar.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
G2L["11"].MultiLine = true
G2L["11"].ClearTextOnFocus = false
G2L["11"].Size = UDim2.new(0, 272, 0, 130)
G2L["11"].Position = UDim2.new(0.35784, 0, 0.06719, 0)
G2L["11"].BorderColor3 = Color3.fromRGB(0, 0, 0)
G2L["11"].Text = ""

-- Amélioration de la zone de code : police mono, fond plus doux, coins arrondis, highlight
G2L["11"].FontFace = Font.new("rbxasset://fonts/families/RobotoMono.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal)
G2L["11"].BackgroundColor3 = Color3.fromRGB(30, 32, 38)
G2L["11"].TextColor3 = Color3.fromRGB(200, 220, 255)
local UICornerCode = Instance.new("UICorner", G2L["11"])
UICornerCode.CornerRadius = UDim.new(0, 10)

-- Drag & Close
local function C_12()
    local frame = G2L["2"]
    local UserInputService = game:GetService("UserInputService")
    local dragging, dragInput, dragStart, startPos
    local function update(input)
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then update(input) end
    end)
end
C_12()

local function getPathToInstance(instance)
    local path = {}
    local current = instance
    while current and current ~= game do
        local name = current.Name
        if not name:match("^[%a_][%w_]*$") then
            name = string.format("[\"%s\"]", name)
        end
        table.insert(path, 1, name)
        current = current.Parent
    end
    return "game." .. table.concat(path, ".")
end

local function formatValue(value)
    if typeof(value) == "string" then
        return string.format("%q", value)
    elseif typeof(value) == "number" then
        return tostring(value)
    elseif typeof(value) == "boolean" then
        return value and "true" or "false"
    elseif typeof(value) == "Instance" then
        return getPathToInstance(value)
    else
        return string.format("%q", tostring(value))
    end
end

local function Format(args)
    local formattedArgs = {}
    for i, arg in ipairs(args) do
        formattedArgs[i] = string.format("[%d] = %s", i, formatValue(arg))
    end
    return formattedArgs
end

-- Amélioration des boutons (arrondis, hover, effet accent, animation)
local function StyleButton(btn, accentColor)
    local UICorner = Instance.new("UICorner", btn)
    UICorner.CornerRadius = UDim.new(0, 10)
    btn.AutoButtonColor = false
    local baseColor = btn.BackgroundColor3
    local hoverColor = accentColor or Color3.fromRGB(60, 120, 255)
    btn.MouseEnter:Connect(function()
        game:GetService("TweenService"):Create(btn, TweenInfo.new(0.18), {BackgroundColor3 = hoverColor}):Play()
        game:GetService("TweenService"):Create(btn, TweenInfo.new(0.18), {TextColor3 = Color3.fromRGB(255,255,255)}):Play()
    end)
    btn.MouseLeave:Connect(function()
        game:GetService("TweenService"):Create(btn, TweenInfo.new(0.18), {BackgroundColor3 = baseColor}):Play()
        game:GetService("TweenService"):Create(btn, TweenInfo.new(0.18), {TextColor3 = Color3.fromRGB(220,220,230)}):Play()
    end)
    btn.MouseButton1Down:Connect(function()
        game:GetService("TweenService"):Create(btn, TweenInfo.new(0.08), {BackgroundTransparency = 0.2}):Play()
    end)
    btn.MouseButton1Up:Connect(function()
        game:GetService("TweenService"):Create(btn, TweenInfo.new(0.08), {BackgroundTransparency = 0}):Play()
    end)
end
StyleButton(G2L["5"], Color3.fromRGB(200, 60, 60))
StyleButton(G2L["7"])
StyleButton(G2L["9"])
StyleButton(G2L["b"], Color3.fromRGB(60, 180, 120))
StyleButton(G2L["d2"], Color3.fromRGB(120, 120, 120))

-- Amélioration de la liste des remotes : badge, highlight, animation d'apparition
local function AddRemoteButton(name, isFunction)
    local btn = G2L["e"]:Clone()
    btn.Name = name
    btn.Text = (isFunction and "[ƒ] " or "[E] ") .. name
    btn.Parent = G2L["d"]
    btn.BackgroundColor3 = isFunction and Color3.fromRGB(40, 60, 120) or Color3.fromRGB(40, 80, 60)
    btn.TextColor3 = Color3.fromRGB(220, 220, 230)
    btn.BackgroundTransparency = 1
    local UICorner = Instance.new("UICorner", btn)
    UICorner.CornerRadius = UDim.new(0, 8)
    -- Animation d'apparition
    game:GetService("TweenService"):Create(btn, TweenInfo.new(0.25), {BackgroundTransparency = 0.15}):Play()
    -- Highlight à la sélection
    btn.MouseButton1Click:Connect(function()
        for _, child in ipairs(G2L["d"]:GetChildren()) do
            if child:IsA("TextButton") then
                game:GetService("TweenService"):Create(child, TweenInfo.new(0.15), {BackgroundColor3 = child == btn and Color3.fromRGB(60, 120, 255) or (isFunction and Color3.fromRGB(40, 60, 120) or Color3.fromRGB(40, 80, 60))}):Play()
            end
        end
    end)
    return btn
end

local function handleRemote(remote)
    local fullPath = getPathToInstance(remote)
    if remote:IsA("RemoteEvent") then
        remote.OnClientEvent:Connect(function(...)
            local args = {...}
            local argsFormatted = Format(args)
            local argsString = table.concat(argsFormatted, ",\n    ")
            local btn = AddRemoteButton(remote.Name, false)
            btn.MouseButton1Click:Connect(function()
                _G.Code = string.format("local args = {\n    %s\n}\n%s:FireServer(unpack(args))", argsString, fullPath)
                G2L["11"].Text = _G.Code
            end)
        end)
    elseif remote:IsA("RemoteFunction") then
        remote.OnClientInvoke = function(...)
            local args = {...}
            local argsFormatted = Format(args)
            local argsString = table.concat(argsFormatted, ",\n    ")
            local btn = AddRemoteButton(remote.Name, true)
            btn.MouseButton1Click:Connect(function()
                _G.Code = string.format("local args = {\n    %s\n}\n%s:InvokeServer(unpack(args))", argsString, fullPath)
                G2L["11"].Text = _G.Code
            end)
            return ...
        end
    end
end

local function wrapRemotes(folder)
    for _, obj in ipairs(folder:GetDescendants()) do
        if obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction") then
            handleRemote(obj)
        end
    end
    folder.DescendantAdded:Connect(function(descendant)
        if descendant:IsA("RemoteEvent") or descendant:IsA("RemoteFunction") then
            handleRemote(descendant)
        end
    end)
end

local folders = {
    game.ReplicatedStorage,
    game.StarterGui,
    game.StarterPack,
    game.StarterPlayer
}
for _, folder in ipairs(folders) do
    wrapRemotes(folder)
end

G2L["7"].MouseButton1Click:Connect(function()
    if setclipboard then setclipboard(_G.Code) end
end)
G2L["9"].MouseButton1Click:Connect(function()
    if setclipboard then setclipboard(_G.Code) end
end)
G2L["b"].MouseButton1Click:Connect(function()
    local f = loadstring(_G.Code)
    if f then f() end
end)
G2L["d2"].MouseButton1Click:Connect(function()
    G2L["11"].Text = ""
end)

G2L["5"].MouseButton1Click:Connect(function()
    G2L["1"]:Destroy()
end)

return G2L["1"], require

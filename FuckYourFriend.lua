local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "Mover GUI",
    LoadingTitle = "Mover Script",
    LoadingSubtitle = "By Omni-Coder",
    ConfigurationSaving = { Enabled = false },
})

local MainTab   = Window:CreateTab("Main", 4483362458)
local Section   = MainTab:CreateSection("Parameters")

-- State variables
local targetName  = ""
local speedValue  = 1
local baseDist    = 10
local running     = false
local conn

local InputBox = MainTab:CreateInput({
    Name = "Target Player",
    CurrentValue = "",
    PlaceholderText = "Entrez pseudo",
    RemoveTextAfterFocusLost = true,
    Flag = "TargetInput",
    Callback = function(Text)
        targetName = Text
    end,
})

local SpeedSlider = MainTab:CreateSlider({
    Name = "Vitesse",
    Range = {0.1, 5},
    Increment = 0.1,
    Suffix = "x",
    CurrentValue = 1,
    Flag = "SpeedFlag",
    Callback = function(Value)
        speedValue = Value
    end,
})

local DistanceSlider = MainTab:CreateSlider({
    Name = "Distance",
    Range = {1, 20},
    Increment = 1,
    Suffix = "studs",
    CurrentValue = 10,
    Flag = "DistanceFlag",
    Callback = function(Value)
        baseDist = Value
    end,
})

local StartBtn = MainTab:CreateButton({
    Name = "Start",
    Callback = function()
        if running then return end
        running = true
        -- Ensure PrimaryPart is set
        local char = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()
        char.PrimaryPart = char:WaitForChild("HumanoidRootPart")
        conn = game:GetService("RunService").RenderStepped:Connect(function()
            local target = game.Players:FindFirstChild(targetName)
            if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
                local targetCF = target.Character.HumanoidRootPart.CFrame
                local t = tick() * math.pi * 2 * speedValue
                local ping = math.sin(t) * 4
                local offsetCF = CFrame.new(0, 0, baseDist + ping)
                char:SetPrimaryPartCFrame(targetCF * offsetCF)
            end
        end)
    end,
})

local StopBtn = MainTab:CreateButton({
    Name = "Stop",
    Callback = function()
        if conn then conn:Disconnect() end
        running = false
    end,
})
local CloseBtn = MainTab:CreateButton({
    Name = "Fermer",
    Callback = function()
        if conn then conn:Disconnect() end
        running = false
        Rayfield:Destroy()
    end,
})

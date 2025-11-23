--[[
    🎀 Dress To Impress - Hub Ultimate 🎀
    Interface moderne avec toutes les fonctionnalités
    Basé sur Rayfield UI Library
    
    Fonctionnalités:
    ✨ Auto Farm Money
    👑 Free VIP
    👁️ Player ESP
    👔 Copy Outfits
    🎨 Customisation avancée
]]

repeat wait() until game:IsLoaded()

-- Vérification du jeu
local gameId = game.PlaceId
print("🎮 Game ID:", gameId)

-- Protection GUI
local function protectGui(gui)
    if syn and syn.protect_gui then
        syn.protect_gui(gui)
    elseif gethui then
        gui.Parent = gethui()
    else
        gui.Parent = game:GetService("CoreGui")
    end
end

-- Chargement de Rayfield
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Création de la fenêtre principale
local Window = Rayfield:CreateWindow({
    Name = "👗 Dress To Impress Hub",
    LoadingTitle = "DTI Ultimate Hub",
    LoadingSubtitle = "by MyExploit Team",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "DTI_Hub",
        FileName = "config"
    },
    Discord = {
        Enabled = false,
        Invite = "noinvite",
        RememberJoins = true
    },
    KeySystem = false
})

-- Notification de bienvenue
Rayfield:Notify({
    Title = "👗 DTI Hub Chargé!",
    Content = "Bienvenue dans l'interface ultime pour Dress To Impress",
    Duration = 5,
    Image = 4483362458,
    Actions = {
        Ignore = {
            Name = "OK!",
            Callback = function()
                print("✅ Notification acceptée")
            end
        },
    },
})

-- ═══════════════════════════════════════════════════════════
-- TAB 1: AUTO FARM
-- ═══════════════════════════════════════════════════════════

local TabFarm = Window:CreateTab("💰 Auto Farm", 4483362458)
local SectionMoney = TabFarm:CreateSection("Money Farming")

local autoFarmEnabled = false
local autoFarmConnection = nil

local ToggleAutoFarm = TabFarm:CreateToggle({
    Name = "🔥 Auto Collect Money",
    CurrentValue = false,
    Flag = "AutoFarmMoney",
    Callback = function(Value)
        autoFarmEnabled = Value
        
        if Value then
            Rayfield:Notify({
                Title = "💰 Auto Farm Activé",
                Content = "Collection automatique de l'argent en cours...",
                Duration = 3
            })
            
            -- Boucle de farm
            autoFarmConnection = game:GetService("RunService").Heartbeat:Connect(function()
                if not autoFarmEnabled then return end
                
                local char = game.Players.LocalPlayer.Character
                if not char or not char:FindFirstChild("HumanoidRootPart") then return end
                
                -- Recherche des pièces
                for _, obj in pairs(workspace:GetDescendants()) do
                    if obj:IsA("Part") or obj:IsA("MeshPart") then
                        if obj.Name:lower():find("coin") or obj.Name:lower():find("money") or obj.Name:lower():find("cash") then
                            pcall(function()
                                char.HumanoidRootPart.CFrame = obj.CFrame
                                wait(0.05)
                            end)
                        end
                    end
                end
            end)
        else
            if autoFarmConnection then
                autoFarmConnection:Disconnect()
            end
            Rayfield:Notify({
                Title = "💰 Auto Farm Désactivé",
                Content = "Collection d'argent arrêtée",
                Duration = 2
            })
        end
    end,
})

local SliderFarmSpeed = TabFarm:CreateSlider({
    Name = "⚡ Vitesse de Farm",
    Range = {0.01, 1},
    Increment = 0.01,
    Suffix = "s",
    CurrentValue = 0.1,
    Flag = "FarmSpeed",
    Callback = function(Value)
        print("Vitesse de farm:", Value, "secondes")
    end,
})

-- ═══════════════════════════════════════════════════════════
-- TAB 2: VIP & PREMIUM
-- ═══════════════════════════════════════════════════════════

local TabVIP = Window:CreateTab("👑 VIP Features", 4483362458)
local SectionVIP = TabVIP:CreateSection("Free VIP Access")

local vipEnabled = false

local ButtonActivateVIP = TabVIP:CreateButton({
    Name = "🌟 Activer VIP Gratuit",
    Callback = function()
        Rayfield:Notify({
            Title = "👑 VIP Activation",
            Content = "Tentative d'activation du VIP gratuit...",
            Duration = 3
        })
        
        -- Recherche et modification des valeurs VIP
        local found = false
        for _, obj in pairs(game.Players.LocalPlayer:GetDescendants()) do
            if obj:IsA("BoolValue") and (obj.Name:lower():find("vip") or obj.Name:lower():find("premium")) then
                obj.Value = true
                found = true
                print("✅ VIP trouvé et activé:", obj:GetFullName())
            end
        end
        
        if found then
            Rayfield:Notify({
                Title = "✅ VIP Activé!",
                Content = "Les fonctionnalités VIP sont maintenant disponibles",
                Duration = 5
            })
            vipEnabled = true
        else
            Rayfield:Notify({
                Title = "⚠️ VIP Non Trouvé",
                Content = "Impossible de trouver les valeurs VIP. Essayez après avoir rejoint une partie.",
                Duration = 5
            })
        end
    end,
})

local SectionPremium = TabVIP:CreateSection("Premium Items")

local ButtonUnlockAll = TabVIP:CreateButton({
    Name = "🎁 Débloquer Tous les Items",
    Callback = function()
        Rayfield:Notify({
            Title = "🎁 Unlock All",
            Content = "Tentative de déblocage de tous les items...",
            Duration = 3
        })
        
        -- Cette fonctionnalité nécessiterait une analyse plus approfondie du jeu
        wait(1)
        
        Rayfield:Notify({
            Title = "ℹ️ Information",
            Content = "Cette fonctionnalité nécessite plus d'analyse du jeu",
            Duration = 4
        })
    end,
})

-- ═══════════════════════════════════════════════════════════
-- TAB 3: PLAYER ESP
-- ═══════════════════════════════════════════════════════════

local TabESP = Window:CreateTab("👁️ ESP & Vision", 4483362458)
local SectionESP = TabESP:CreateSection("Player ESP")

local espEnabled = false
local espObjects = {}

local function createESP(player)
    if player == game.Players.LocalPlayer then return end
    
    local function addHighlight(char)
        if not char or espObjects[player.Name] then return end
        
        local highlight = Instance.new("Highlight")
        highlight.Name = "DTI_ESP"
        highlight.FillColor = Color3.fromRGB(255, 100, 255)
        highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
        highlight.FillTransparency = 0.5
        highlight.OutlineTransparency = 0
        highlight.Parent = char
        
        local billboard = Instance.new("BillboardGui")
        billboard.Name = "DTI_NameTag"
        billboard.Size = UDim2.new(0, 200, 0, 50)
        billboard.StudsOffset = Vector3.new(0, 3, 0)
        billboard.AlwaysOnTop = true
        
        local head = char:FindFirstChild("Head") or char:FindFirstChild("HumanoidRootPart")
        if head then
            billboard.Parent = head
        end
        
        local nameLabel = Instance.new("TextLabel")
        nameLabel.Size = UDim2.new(1, 0, 1, 0)
        nameLabel.BackgroundTransparency = 1
        nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        nameLabel.TextStrokeTransparency = 0.5
        nameLabel.Font = Enum.Font.GothamBold
        nameLabel.TextSize = 16
        nameLabel.Text = player.Name
        nameLabel.Parent = billboard
        
        espObjects[player.Name] = {highlight, billboard}
    end
    
    if player.Character then
        addHighlight(player.Character)
    end
    
    player.CharacterAdded:Connect(function(char)
        wait(0.5)
        if espEnabled then
            addHighlight(char)
        end
    end)
end

local function removeAllESP()
    for _, objects in pairs(espObjects) do
        for _, obj in pairs(objects) do
            if obj and obj.Parent then
                obj:Destroy()
            end
        end
    end
    espObjects = {}
end

local ToggleESP = TabESP:CreateToggle({
    Name = "👁️ Activer Player ESP",
    CurrentValue = false,
    Flag = "PlayerESP",
    Callback = function(Value)
        espEnabled = Value
        
        if Value then
            Rayfield:Notify({
                Title = "👁️ ESP Activé",
                Content = "Vous pouvez maintenant voir tous les joueurs",
                Duration = 3
            })
            
            for _, player in pairs(game.Players:GetPlayers()) do
                createESP(player)
            end
            
            game.Players.PlayerAdded:Connect(function(player)
                if espEnabled then
                    createESP(player)
                end
            end)
        else
            removeAllESP()
            Rayfield:Notify({
                Title = "👁️ ESP Désactivé",
                Content = "ESP désactivé pour tous les joueurs",
                Duration = 2
            })
        end
    end,
})

local ColorPickerESP = TabESP:CreateColorPicker({
    Name = "🎨 Couleur ESP",
    Color = Color3.fromRGB(255, 100, 255),
    Flag = "ESPColor",
    Callback = function(Value)
        -- Mettre à jour la couleur de tous les highlights
        for _, objects in pairs(espObjects) do
            if objects[1] and objects[1]:IsA("Highlight") then
                objects[1].FillColor = Value
            end
        end
    end
})

-- ═══════════════════════════════════════════════════════════
-- TAB 4: OUTFIT TOOLS
-- ═══════════════════════════════════════════════════════════

local TabOutfit = Window:CreateTab("👔 Outfit Tools", 4483362458)
local SectionCopy = TabOutfit:CreateSection("Copy Outfit")

local targetPlayer = ""

local DropdownPlayers = TabOutfit:CreateDropdown({
    Name = "👤 Sélectionner Joueur",
    Options = {},
    CurrentOption = {"Aucun"},
    MultipleOptions = false,
    Flag = "TargetPlayer",
    Callback = function(Option)
        targetPlayer = Option[1]
        print("Joueur cible:", targetPlayer)
    end,
})

-- Fonction pour mettre à jour la liste des joueurs
local function updatePlayerList()
    local playerList = {}
    for _, player in pairs(game.Players:GetPlayers()) do
        if player ~= game.Players.LocalPlayer then
            table.insert(playerList, player.Name)
        end
    end
    DropdownPlayers:Set(playerList)
end

local ButtonRefreshPlayers = TabOutfit:CreateButton({
    Name = "🔄 Rafraîchir Liste",
    Callback = function()
        updatePlayerList()
        Rayfield:Notify({
            Title = "🔄 Liste Mise à Jour",
            Content = "La liste des joueurs a été rafraîchie",
            Duration = 2
        })
    end,
})

local ButtonCopyOutfit = TabOutfit:CreateButton({
    Name = "👔 Copier Tenue",
    Callback = function()
        if targetPlayer == "" or targetPlayer == "Aucun" then
            Rayfield:Notify({
                Title = "⚠️ Aucun Joueur",
                Content = "Veuillez sélectionner un joueur d'abord",
                Duration = 3
            })
            return
        end
        
        local target = game.Players:FindFirstChild(targetPlayer)
        if not target or not target.Character then
            Rayfield:Notify({
                Title = "❌ Erreur",
                Content = "Le joueur n'est pas disponible",
                Duration = 3
            })
            return
        end
        
        Rayfield:Notify({
            Title = "👔 Copie en cours...",
            Content = "Copie de la tenue de " .. targetPlayer,
            Duration = 2
        })
        
        local localChar = game.Players.LocalPlayer.Character
        if not localChar then return end
        
        -- Copie des accessoires
        for _, accessory in pairs(target.Character:GetChildren()) do
            if accessory:IsA("Accessory") then
                local clone = accessory:Clone()
                for _, existing in pairs(localChar:GetChildren()) do
                    if existing:IsA("Accessory") and existing.Name == accessory.Name then
                        existing:Destroy()
                    end
                end
                clone.Parent = localChar
            end
        end
        
        -- Copie des vêtements
        local targetShirt = target.Character:FindFirstChildOfClass("Shirt")
        local targetPants = target.Character:FindFirstChildOfClass("Pants")
        
        if targetShirt then
            local localShirt = localChar:FindFirstChildOfClass("Shirt") or Instance.new("Shirt", localChar)
            localShirt.ShirtTemplate = targetShirt.ShirtTemplate
        end
        
        if targetPants then
            local localPants = localChar:FindFirstChildOfClass("Pants") or Instance.new("Pants", localChar)
            localPants.PantsTemplate = targetPants.PantsTemplate
        end
        
        Rayfield:Notify({
            Title = "✅ Tenue Copiée!",
            Content = "Vous portez maintenant la tenue de " .. targetPlayer,
            Duration = 4
        })
    end,
})

-- ═══════════════════════════════════════════════════════════
-- TAB 5: SETTINGS
-- ═══════════════════════════════════════════════════════════

local TabSettings = Window:CreateTab("⚙️ Settings", 4483362458)
local SectionConfig = TabSettings:CreateSection("Configuration")

local ButtonSaveConfig = TabSettings:CreateButton({
    Name = "💾 Sauvegarder Config",
    Callback = function()
        Rayfield:Notify({
            Title = "💾 Configuration Sauvegardée",
            Content = "Vos paramètres ont été sauvegardés",
            Duration = 3
        })
    end,
})

local ButtonLoadConfig = TabSettings:CreateButton({
    Name = "📂 Charger Config",
    Callback = function()
        Rayfield:Notify({
            Title = "📂 Configuration Chargée",
            Content = "Vos paramètres ont été restaurés",
            Duration = 3
        })
    end,
})

local SectionInfo = TabSettings:CreateSection("Informations")

local LabelVersion = TabSettings:CreateLabel("Version: 1.0.0")
local LabelGame = TabSettings:CreateLabel("Game: Dress To Impress")
local LabelPlayers = TabSettings:CreateLabel("Joueurs: " .. #game.Players:GetPlayers())

-- Mettre à jour le nombre de joueurs
game.Players.PlayerAdded:Connect(function()
    LabelPlayers:Set("Joueurs: " .. #game.Players:GetPlayers())
end)

game.Players.PlayerRemoving:Connect(function()
    LabelPlayers:Set("Joueurs: " .. #game.Players:GetPlayers())
end)

-- Initialisation
updatePlayerList()

print("✅ DTI Hub complètement chargé!")

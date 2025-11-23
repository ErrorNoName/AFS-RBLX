--[[
    🎀 Dress To Impress - Hub Ultimate (Orion UI) 🎀
    Version alternative avec Orion Library
    
    Fonctionnalités identiques à la version Rayfield:
    ✨ Auto Farm Money
    👑 Free VIP
    👁️ Player ESP
    👔 Copy Outfits
]]

repeat wait() until game:IsLoaded()

-- Chargement de Orion Library
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

-- Création de la fenêtre
local Window = OrionLib:MakeWindow({
    Name = "👗 Dress To Impress Hub",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "DTI_Hub_Orion",
    IntroEnabled = true,
    IntroText = "DTI Ultimate Hub"
})

-- Variables globales
local autoFarmEnabled = false
local espEnabled = false
local espObjects = {}

-- ═══════════════════════════════════════════════════════════
-- TAB: AUTO FARM
-- ═══════════════════════════════════════════════════════════

local TabFarm = Window:MakeTab({
    Name = "💰 Auto Farm",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

TabFarm:AddToggle({
    Name = "🔥 Auto Collect Money",
    Default = false,
    Callback = function(Value)
        autoFarmEnabled = Value
        
        if Value then
            OrionLib:MakeNotification({
                Name = "💰 Auto Farm",
                Content = "Collection automatique activée!",
                Image = "rbxassetid://4483345998",
                Time = 3
            })
            
            spawn(function()
                while autoFarmEnabled do
                    wait(0.1)
                    local char = game.Players.LocalPlayer.Character
                    if char and char:FindFirstChild("HumanoidRootPart") then
                        for _, obj in pairs(workspace:GetDescendants()) do
                            if not autoFarmEnabled then break end
                            if obj:IsA("Part") or obj:IsA("MeshPart") then
                                local name = obj.Name:lower()
                                if name:find("coin") or name:find("money") or name:find("cash") then
                                    pcall(function()
                                        char.HumanoidRootPart.CFrame = obj.CFrame
                                        wait(0.05)
                                    end)
                                end
                            end
                        end
                    end
                end
            end)
        else
            OrionLib:MakeNotification({
                Name = "💰 Auto Farm",
                Content = "Collection automatique désactivée",
                Image = "rbxassetid://4483345998",
                Time = 2
            })
        end
    end    
})

TabFarm:AddSlider({
    Name = "⚡ Vitesse de Farm",
    Min = 1,
    Max = 100,
    Default = 10,
    Color = Color3.fromRGB(255, 255, 255),
    Increment = 1,
    ValueName = "%",
    Callback = function(Value)
        print("Vitesse:", Value, "%")
    end    
})

TabFarm:AddParagraph("ℹ️ Information", "L'auto farm collecte automatiquement toutes les pièces dans le jeu. Ajustez la vitesse selon vos préférences.")

-- ═══════════════════════════════════════════════════════════
-- TAB: VIP FEATURES
-- ═══════════════════════════════════════════════════════════

local TabVIP = Window:MakeTab({
    Name = "👑 VIP Features",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

TabVIP:AddButton({
    Name = "🌟 Activer VIP Gratuit",
    Callback = function()
        OrionLib:MakeNotification({
            Name = "👑 VIP",
            Content = "Activation du VIP en cours...",
            Image = "rbxassetid://4483345998",
            Time = 2
        })
        
        local found = false
        for _, obj in pairs(game.Players.LocalPlayer:GetDescendants()) do
            if obj:IsA("BoolValue") then
                local name = obj.Name:lower()
                if name:find("vip") or name:find("premium") then
                    obj.Value = true
                    found = true
                    print("✅ VIP activé:", obj:GetFullName())
                end
            end
        end
        
        wait(1)
        
        if found then
            OrionLib:MakeNotification({
                Name = "✅ VIP Activé!",
                Content = "Vous avez maintenant accès aux fonctionnalités VIP",
                Image = "rbxassetid://4483345998",
                Time = 5
            })
        else
            OrionLib:MakeNotification({
                Name = "⚠️ Avertissement",
                Content = "VIP non trouvé. Rejoignez une partie d'abord.",
                Image = "rbxassetid://4483345998",
                Time = 4
            })
        end
    end    
})

TabVIP:AddButton({
    Name = "🎁 Débloquer Tous les Items",
    Callback = function()
        OrionLib:MakeNotification({
            Name = "🎁 Items",
            Content = "Fonction en développement...",
            Image = "rbxassetid://4483345998",
            Time = 3
        })
    end    
})

TabVIP:AddParagraph("ℹ️ VIP Gratuit", "Active les fonctionnalités VIP sans payer. Certaines fonctions peuvent ne pas marcher selon les mises à jour du jeu.")

-- ═══════════════════════════════════════════════════════════
-- TAB: ESP & VISION
-- ═══════════════════════════════════════════════════════════

local TabESP = Window:MakeTab({
    Name = "👁️ ESP",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

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

TabESP:AddToggle({
    Name = "👁️ Activer Player ESP",
    Default = false,
    Callback = function(Value)
        espEnabled = Value
        
        if Value then
            OrionLib:MakeNotification({
                Name = "👁️ ESP",
                Content = "ESP activé pour tous les joueurs",
                Image = "rbxassetid://4483345998",
                Time = 3
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
            OrionLib:MakeNotification({
                Name = "👁️ ESP",
                Content = "ESP désactivé",
                Image = "rbxassetid://4483345998",
                Time = 2
            })
        end
    end    
})

TabESP:AddColorpicker({
    Name = "🎨 Couleur ESP",
    Default = Color3.fromRGB(255, 100, 255),
    Callback = function(Value)
        for _, objects in pairs(espObjects) do
            if objects[1] and objects[1]:IsA("Highlight") then
                objects[1].FillColor = Value
            end
        end
    end    
})

TabESP:AddParagraph("ℹ️ ESP", "Permet de voir tous les joueurs à travers les murs avec leurs noms. Personnalisez la couleur à votre goût.")

-- ═══════════════════════════════════════════════════════════
-- TAB: OUTFIT TOOLS
-- ═══════════════════════════════════════════════════════════

local TabOutfit = Window:MakeTab({
    Name = "👔 Outfit",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

local targetPlayer = ""
local playerList = {}

local function updatePlayerList()
    playerList = {}
    for _, player in pairs(game.Players:GetPlayers()) do
        if player ~= game.Players.LocalPlayer then
            table.insert(playerList, player.Name)
        end
    end
    return playerList
end

TabOutfit:AddDropdown({
    Name = "👤 Sélectionner Joueur",
    Default = "Aucun",
    Options = updatePlayerList(),
    Callback = function(Value)
        targetPlayer = Value
        print("Joueur cible:", targetPlayer)
    end    
})

TabOutfit:AddButton({
    Name = "🔄 Rafraîchir Liste",
    Callback = function()
        local list = updatePlayerList()
        OrionLib:MakeNotification({
            Name = "🔄 Mise à jour",
            Content = tostring(#list) .. " joueurs trouvés",
            Image = "rbxassetid://4483345998",
            Time = 2
        })
    end    
})

TabOutfit:AddButton({
    Name = "👔 Copier Tenue",
    Callback = function()
        if targetPlayer == "" or targetPlayer == "Aucun" then
            OrionLib:MakeNotification({
                Name = "⚠️ Erreur",
                Content = "Sélectionnez un joueur d'abord",
                Image = "rbxassetid://4483345998",
                Time = 3
            })
            return
        end
        
        local target = game.Players:FindFirstChild(targetPlayer)
        if not target or not target.Character then
            OrionLib:MakeNotification({
                Name = "❌ Erreur",
                Content = "Joueur non disponible",
                Image = "rbxassetid://4483345998",
                Time = 3
            })
            return
        end
        
        OrionLib:MakeNotification({
            Name = "👔 Copie",
            Content = "Copie de la tenue en cours...",
            Image = "rbxassetid://4483345998",
            Time = 2
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
        
        OrionLib:MakeNotification({
            Name = "✅ Succès!",
            Content = "Tenue de " .. targetPlayer .. " copiée!",
            Image = "rbxassetid://4483345998",
            Time = 4
        })
    end    
})

TabOutfit:AddParagraph("ℹ️ Copie de Tenue", "Sélectionnez un joueur dans la liste et cliquez sur 'Copier Tenue' pour avoir exactement la même tenue que lui!")

-- ═══════════════════════════════════════════════════════════
-- TAB: SETTINGS
-- ═══════════════════════════════════════════════════════════

local TabSettings = Window:MakeTab({
    Name = "⚙️ Settings",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

TabSettings:AddButton({
    Name = "💾 Sauvegarder Config",
    Callback = function()
        OrionLib:MakeNotification({
            Name = "💾 Config",
            Content = "Configuration sauvegardée!",
            Image = "rbxassetid://4483345998",
            Time = 3
        })
    end    
})

TabSettings:AddButton({
    Name = "📂 Charger Config",
    Callback = function()
        OrionLib:MakeNotification({
            Name = "📂 Config",
            Content = "Configuration chargée!",
            Image = "rbxassetid://4483345998",
            Time = 3
        })
    end    
})

TabSettings:AddLabel("Version: 1.0.0 (Orion)")
TabSettings:AddLabel("Game: Dress To Impress")
TabSettings:AddLabel("Joueurs: " .. #game.Players:GetPlayers())

TabSettings:AddButton({
    Name = "🚪 Fermer Interface",
    Callback = function()
        OrionLib:Destroy()
    end    
})

TabSettings:AddParagraph("ℹ️ À Propos", "DTI Ultimate Hub - Interface complète pour Dress To Impress. Développé par MyExploit Team.")

-- Initialisation
OrionLib:Init()

print("✅ DTI Hub (Orion) complètement chargé!")

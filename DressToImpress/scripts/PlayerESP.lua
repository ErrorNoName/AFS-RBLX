-- Player ESP - Dress To Impress
-- Source: Community Scripts
-- Fonctionnalité: Affiche les joueurs à travers les murs avec leurs tenues

local PlayerESP = {}
PlayerESP.Enabled = false
PlayerESP.ESPObjects = {}

function PlayerESP:Toggle(state)
    self.Enabled = state
    if state then
        self:CreateESP()
    else
        self:RemoveESP()
    end
end

function PlayerESP:CreateESP()
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    
    print("👁️ ESP activé pour tous les joueurs")
    
    -- Fonction pour créer l'ESP d'un joueur
    local function addESP(player)
        if player == LocalPlayer then return end
        
        local function createHighlight(char)
            if char and not self.ESPObjects[player.Name] then
                local highlight = Instance.new("Highlight")
                highlight.Name = "DTI_ESP"
                highlight.FillColor = Color3.fromRGB(255, 100, 255)
                highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                highlight.FillTransparency = 0.5
                highlight.OutlineTransparency = 0
                highlight.Parent = char
                
                -- Créer un BillboardGui pour le nom
                local billboard = Instance.new("BillboardGui")
                billboard.Name = "DTI_NameTag"
                billboard.Size = UDim2.new(0, 200, 0, 50)
                billboard.StudsOffset = Vector3.new(0, 3, 0)
                billboard.AlwaysOnTop = true
                billboard.Parent = char:FindFirstChild("Head") or char:FindFirstChild("HumanoidRootPart")
                
                local nameLabel = Instance.new("TextLabel")
                nameLabel.Size = UDim2.new(1, 0, 1, 0)
                nameLabel.BackgroundTransparency = 1
                nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                nameLabel.TextStrokeTransparency = 0.5
                nameLabel.Font = Enum.Font.GothamBold
                nameLabel.TextSize = 16
                nameLabel.Text = player.Name
                nameLabel.Parent = billboard
                
                self.ESPObjects[player.Name] = {highlight, billboard}
            end
        end
        
        if player.Character then
            createHighlight(player.Character)
        end
        
        player.CharacterAdded:Connect(function(char)
            wait(0.5)
            if self.Enabled then
                createHighlight(char)
            end
        end)
    end
    
    -- Ajouter ESP pour tous les joueurs existants
    for _, player in pairs(Players:GetPlayers()) do
        addESP(player)
    end
    
    -- Ajouter ESP pour les nouveaux joueurs
    Players.PlayerAdded:Connect(function(player)
        if self.Enabled then
            addESP(player)
        end
    end)
end

function PlayerESP:RemoveESP()
    for _, objects in pairs(self.ESPObjects) do
        for _, obj in pairs(objects) do
            if obj and obj.Parent then
                obj:Destroy()
            end
        end
    end
    self.ESPObjects = {}
    print("🚫 ESP désactivé")
end

return PlayerESP

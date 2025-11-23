-- Copy Outfit - Dress To Impress
-- Source: Community Scripts
-- Fonctionnalité: Copie les tenues des autres joueurs

local CopyOutfit = {}

function CopyOutfit:CopyFromPlayer(targetPlayerName)
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    
    -- Trouve le joueur cible
    local targetPlayer = Players:FindFirstChild(targetPlayerName)
    if not targetPlayer then
        warn("❌ Joueur non trouvé:", targetPlayerName)
        return false
    end
    
    print("👔 Copie de la tenue de:", targetPlayerName)
    
    local targetChar = targetPlayer.Character
    local localChar = LocalPlayer.Character
    
    if not targetChar or not localChar then
        warn("❌ Personnage non trouvé")
        return false
    end
    
    -- Copie les accessoires
    for _, accessory in pairs(targetChar:GetChildren()) do
        if accessory:IsA("Accessory") then
            local clone = accessory:Clone()
            
            -- Supprime l'accessoire existant s'il y en a un du même type
            for _, existing in pairs(localChar:GetChildren()) do
                if existing:IsA("Accessory") and existing.Name == accessory.Name then
                    existing:Destroy()
                end
            end
            
            clone.Parent = localChar
            print("✅ Accessoire copié:", accessory.Name)
        end
    end
    
    -- Copie les vêtements (Shirt, Pants)
    local targetShirt = targetChar:FindFirstChildOfClass("Shirt")
    local targetPants = targetChar:FindFirstChildOfClass("Pants")
    
    if targetShirt then
        local localShirt = localChar:FindFirstChildOfClass("Shirt")
        if not localShirt then
            localShirt = Instance.new("Shirt", localChar)
        end
        localShirt.ShirtTemplate = targetShirt.ShirtTemplate
        print("✅ Chemise copiée")
    end
    
    if targetPants then
        local localPants = localChar:FindFirstChildOfClass("Pants")
        if not localPants then
            localPants = Instance.new("Pants", localChar)
        end
        localPants.PantsTemplate = targetPants.PantsTemplate
        print("✅ Pantalon copié")
    end
    
    -- Copie les couleurs du corps
    local targetBodyColors = targetChar:FindFirstChildOfClass("BodyColors")
    if targetBodyColors then
        local localBodyColors = localChar:FindFirstChildOfClass("BodyColors")
        if not localBodyColors then
            localBodyColors = Instance.new("BodyColors", localChar)
        end
        
        localBodyColors.HeadColor = targetBodyColors.HeadColor
        localBodyColors.TorsoColor = targetBodyColors.TorsoColor
        localBodyColors.LeftArmColor = targetBodyColors.LeftArmColor
        localBodyColors.RightArmColor = targetBodyColors.RightArmColor
        localBodyColors.LeftLegColor = targetBodyColors.LeftLegColor
        localBodyColors.RightLegColor = targetBodyColors.RightLegColor
        print("✅ Couleurs du corps copiées")
    end
    
    print("🎉 Tenue complètement copiée de", targetPlayerName)
    return true
end

function CopyOutfit:GetPlayerList()
    local Players = game:GetService("Players")
    local playerList = {}
    
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= Players.LocalPlayer then
            table.insert(playerList, player.Name)
        end
    end
    
    return playerList
end

return CopyOutfit

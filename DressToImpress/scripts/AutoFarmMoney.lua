-- Auto Farm Money - Dress To Impress
-- Source: ScriptBlox Community
-- Fonctionnalité: Collecte automatique de l'argent dans le jeu

local AutoFarmMoney = {}
AutoFarmMoney.Enabled = false

function AutoFarmMoney:Toggle(state)
    self.Enabled = state
    if state then
        self:Start()
    else
        self:Stop()
    end
end

function AutoFarmMoney:Start()
    print("🔥 Auto Farm Money activé!")
    
    spawn(function()
        while self.Enabled do
            wait(0.5)
            
            -- Recherche des pièces dans le workspace
            for _, coin in pairs(workspace:GetDescendants()) do
                if coin:IsA("Part") and coin.Name:lower():find("coin") or coin.Name:lower():find("money") then
                    if self.Enabled then
                        local char = game.Players.LocalPlayer.Character
                        if char and char:FindFirstChild("HumanoidRootPart") then
                            -- Téléporte vers la pièce
                            char.HumanoidRootPart.CFrame = coin.CFrame
                            wait(0.1)
                        end
                    end
                end
            end
        end
    end)
end

function AutoFarmMoney:Stop()
    self.Enabled = false
    print("🛑 Auto Farm Money désactivé")
end

return AutoFarmMoney

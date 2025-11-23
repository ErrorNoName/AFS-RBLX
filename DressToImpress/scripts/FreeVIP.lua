-- Free VIP - Dress To Impress
-- Source: Community Scripts
-- Fonctionnalité: Débloque les fonctionnalités VIP gratuitement

local FreeVIP = {}
FreeVIP.Enabled = false

function FreeVIP:Activate()
    print("👑 Activation du VIP gratuit...")
    
    -- Méthode 1: Modifier les valeurs locales
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    
    -- Cherche les valeurs VIP dans le PlayerGui ou PlayerData
    local function findAndModifyVIP()
        for _, obj in pairs(LocalPlayer:GetDescendants()) do
            if obj:IsA("BoolValue") or obj:IsA("IntValue") then
                if obj.Name:lower():find("vip") or obj.Name:lower():find("premium") then
                    if obj:IsA("BoolValue") then
                        obj.Value = true
                        print("✅ VIP activé:", obj:GetFullName())
                    elseif obj:IsA("IntValue") then
                        obj.Value = 1
                        print("✅ VIP level modifié:", obj:GetFullName())
                    end
                end
            end
        end
    end
    
    findAndModifyVIP()
    
    -- Méthode 2: Bypass des vérifications VIP
    local mt = getrawmetatable(game)
    local oldNamecall = mt.__namecall
    setreadonly(mt, false)
    
    mt.__namecall = newcclosure(function(self, ...)
        local method = getnamecallmethod()
        local args = {...}
        
        -- Intercepte les vérifications VIP
        if method == "InvokeServer" or method == "FireServer" then
            if args[1] == "CheckVIP" or args[1] == "IsVIP" then
                return true
            end
        end
        
        return oldNamecall(self, ...)
    end)
    
    setreadonly(mt, true)
    self.Enabled = true
    print("💎 VIP gratuit activé avec succès!")
end

function FreeVIP:Deactivate()
    self.Enabled = false
    print("⚠️ VIP désactivé - redémarrez le jeu pour revenir à la normale")
end

return FreeVIP

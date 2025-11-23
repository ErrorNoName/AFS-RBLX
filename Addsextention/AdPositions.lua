--[[
    AdPositions.lua
    Configuration des 4 positions pour bannières publicitaires
    Taille standard : 200×100 pixels (IAB Banner format)
]]

local AdPositions = {}

-- Configuration taille bannières
AdPositions.BannerSize = {
    Width = 200,
    Height = 100,
}

-- Marges depuis les bords de l'écran
AdPositions.Margins = {
    Top = 10,
    Bottom = 10,
    Left = 10,
    Right = 10,
}

-- Positions disponibles (UDim2)
AdPositions.Positions = {
    -- Haut gauche
    TOP_LEFT = UDim2.new(
        0, AdPositions.Margins.Left,
        0, AdPositions.Margins.Top
    ),
    
    -- Haut droite
    TOP_RIGHT = UDim2.new(
        1, -(AdPositions.BannerSize.Width + AdPositions.Margins.Right),
        0, AdPositions.Margins.Top
    ),
    
    -- Bas gauche
    BOTTOM_LEFT = UDim2.new(
        0, AdPositions.Margins.Left,
        1, -(AdPositions.BannerSize.Height + AdPositions.Margins.Bottom)
    ),
    
    -- Bas droite
    BOTTOM_RIGHT = UDim2.new(
        1, -(AdPositions.BannerSize.Width + AdPositions.Margins.Right),
        1, -(AdPositions.BannerSize.Height + AdPositions.Margins.Bottom)
    ),
}

-- Noms affichables
AdPositions.DisplayNames = {
    TOP_LEFT = "Haut Gauche",
    TOP_RIGHT = "Haut Droite",
    BOTTOM_LEFT = "Bas Gauche",
    BOTTOM_RIGHT = "Bas Droite",
}

-- Liste ordonnée pour rotation
AdPositions.OrderedList = {
    "TOP_LEFT",
    "TOP_RIGHT",
    "BOTTOM_LEFT",
    "BOTTOM_RIGHT",
}

-- Vérifier si position valide
function AdPositions:IsValid(positionName)
    return self.Positions[positionName] ~= nil
end

-- Obtenir UDim2 position
function AdPositions:GetPosition(positionName)
    if not self:IsValid(positionName) then
        warn("[AdPositions] Position invalide:", positionName, "- Utilisation BOTTOM_LEFT par défaut")
        return self.Positions.BOTTOM_LEFT
    end
    return self.Positions[positionName]
end

-- Obtenir nom affichable
function AdPositions:GetDisplayName(positionName)
    return self.DisplayNames[positionName] or positionName
end

-- Obtenir prochaine position (rotation)
function AdPositions:GetNext(currentPosition)
    for i, pos in ipairs(self.OrderedList) do
        if pos == currentPosition then
            local nextIndex = (i % #self.OrderedList) + 1
            return self.OrderedList[nextIndex]
        end
    end
    return self.OrderedList[1]
end

-- Obtenir position précédente
function AdPositions:GetPrevious(currentPosition)
    for i, pos in ipairs(self.OrderedList) do
        if pos == currentPosition then
            local prevIndex = i == 1 and #self.OrderedList or i - 1
            return self.OrderedList[prevIndex]
        end
    end
    return self.OrderedList[#self.OrderedList]
end

-- Obtenir position aléatoire
function AdPositions:GetRandom()
    local randomIndex = math.random(1, #self.OrderedList)
    return self.OrderedList[randomIndex]
end

-- Calculer ZIndex recommandé pour éviter overlap
function AdPositions:GetRecommendedZIndex(positionName)
    -- Bas > Haut pour éviter conflit avec UI principale
    if positionName == "BOTTOM_LEFT" or positionName == "BOTTOM_RIGHT" then
        return 10
    else
        return 5
    end
end

-- Vérifier conflit avec une Frame existante
function AdPositions:CheckOverlap(positionName, existingFrame)
    if not existingFrame then return false end
    
    local adPos = self:GetPosition(positionName)
    local framePos = existingFrame.Position
    local frameSize = existingFrame.Size
    
    -- Calcul basique overlap (simplifié)
    -- TODO: Améliorer avec calcul précis pixels
    local adX = adPos.X.Scale * 1920 + adPos.X.Offset
    local adY = adPos.Y.Scale * 1080 + adPos.Y.Offset
    
    local frameX = framePos.X.Scale * 1920 + framePos.X.Offset
    local frameY = framePos.Y.Scale * 1080 + framePos.Y.Offset
    local frameW = frameSize.X.Scale * 1920 + frameSize.X.Offset
    local frameH = frameSize.Y.Scale * 1080 + frameSize.Y.Offset
    
    -- Détection collision rectangle
    local overlap = not (
        adX + self.BannerSize.Width < frameX or
        adX > frameX + frameW or
        adY + self.BannerSize.Height < frameY or
        adY > frameY + frameH
    )
    
    return overlap
end

-- Trouver meilleure position sans overlap
function AdPositions:FindBestPosition(existingFrames)
    existingFrames = existingFrames or {}
    
    for _, posName in ipairs(self.OrderedList) do
        local hasOverlap = false
        for _, frame in ipairs(existingFrames) do
            if self:CheckOverlap(posName, frame) then
                hasOverlap = true
                break
            end
        end
        if not hasOverlap then
            return posName
        end
    end
    
    -- Si tout overlap, retourner BOTTOM_RIGHT (moins intrusif)
    return "BOTTOM_RIGHT"
end

-- Obtenir toutes les positions disponibles
function AdPositions:GetAll()
    return self.OrderedList
end

-- Obtenir info complète position
function AdPositions:GetInfo(positionName)
    return {
        Name = positionName,
        DisplayName = self:GetDisplayName(positionName),
        Position = self:GetPosition(positionName),
        ZIndex = self:GetRecommendedZIndex(positionName),
        Size = UDim2.new(0, self.BannerSize.Width, 0, self.BannerSize.Height),
    }
end

-- Debug : afficher toutes positions
function AdPositions:PrintAll()
    print("=== AdPositions Configuration ===")
    print("Banner Size:", self.BannerSize.Width .. "×" .. self.BannerSize.Height)
    print("\nPositions disponibles:")
    for _, posName in ipairs(self.OrderedList) do
        local info = self:GetInfo(posName)
        print(string.format("  [%s] %s - ZIndex: %d", 
            posName, 
            info.DisplayName, 
            info.ZIndex
        ))
    end
end

return AdPositions

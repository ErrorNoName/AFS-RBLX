-- SolarisUi.lua
local SolarisUi = {}

-- Button
function SolarisUi.CreateButton(text, size, position, backgroundColor, textColor, font)
    local button = Instance.new("TextButton")
    button.Text = text
    button.Size = size
    button.Position = position
    button.BackgroundColor3 = backgroundColor
    button.TextColor3 = textColor
    button.Font = font

    function button:SetText(newText)
        self.Text = newText
    end

    function button:SetSize(newSize)
        self.Size = newSize
    end

    function button:SetPosition(newPosition)
        self.Position = newPosition
    end

    function button:SetBackgroundColor(newColor)
        self.BackgroundColor3 = newColor
    end

    function button:SetTextColor(newColor)
        self.TextColor3 = newColor
    end

    function button:SetFont(newFont)
        self.Font = newFont
    end

    function button:ConnectOnClick(callback)
        button.MouseButton1Click:Connect(callback)
    end

    return button
end

-- TextLabel
function SolarisUi.CreateTextLabel(text, size, position, textColor, font, backgroundTransparency)
    local label = Instance.new("TextLabel")
    label.Text = text
    label.Size = size
    label.Position = position
    label.TextColor3 = textColor
    label.Font = font
    label.BackgroundTransparency = backgroundTransparency

    function label:SetText(newText)
        self.Text = newText
    end

    function label:SetSize(newSize)
        self.Size = newSize
    end

    function label:SetPosition(newPosition)
        self.Position = newPosition
    end

    function label:SetTextColor(newColor)
        self.TextColor3 = newColor
    end

    function label:SetFont(newFont)
        self.Font = newFont
    end

    return label
end

-- TextBox
function SolarisUi.CreateTextBox(placeholderText, size, position, textColor, font, backgroundTransparency)
    local textBox = Instance.new("TextBox")
    textBox.PlaceholderText = placeholderText
    textBox.Size = size
    textBox.Position = position
    textBox.TextColor3 = textColor
    textBox.Font = font
    textBox.BackgroundTransparency = backgroundTransparency

    function textBox:SetPlaceholderText(newPlaceholder)
        self.PlaceholderText = newPlaceholder
    end

    function textBox:SetSize(newSize)
        self.Size = newSize
    end

    function textBox:SetPosition(newPosition)
        self.Position = newPosition
    end

    function textBox:SetTextColor(newColor)
        self.TextColor3 = newColor
    end

    function textBox:SetFont(newFont)
        self.Font = newFont
    end

    function textBox:GetText()
        return self.Text
    end

    return textBox
end

-- Frame
function SolarisUi.CreateFrame(size, position, backgroundColor, borderSizePixel)
    local frame = Instance.new("Frame")
    frame.Size = size
    frame.Position = position
    frame.BackgroundColor3 = backgroundColor
    frame.BorderSizePixel = borderSizePixel

    function frame:SetSize(newSize)
        self.Size = newSize
    end

    function frame:SetPosition(newPosition)
        self.Position = newPosition
    end

    function frame:SetBackgroundColor(newColor)
        self.BackgroundColor3 = newColor
    end

    function frame:SetBorderSize(newSize)
        self.BorderSizePixel = newSize
    end

    return frame
end

-- ImageLabel
function SolarisUi.CreateImageLabel(image, size, position, backgroundTransparency)
    local imageLabel = Instance.new("ImageLabel")
    imageLabel.Image = image
    imageLabel.Size = size
    imageLabel.Position = position
    imageLabel.BackgroundTransparency = backgroundTransparency

    function imageLabel:SetImage(newImage)
        self.Image = newImage
    end

    function imageLabel:SetSize(newSize)
        self.Size = newSize
    end

    function imageLabel:SetPosition(newPosition)
        self.Position = newPosition
    end

    return imageLabel
end

-- UICorner
function SolarisUi.CreateUICorner(cornerRadius)
    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = cornerRadius

    function uiCorner:SetCornerRadius(newRadius)
        self.CornerRadius = newRadius
    end

    return uiCorner
end

-- UIStroke
function SolarisUi.CreateUIStroke(color, thickness, transparency)
    local uiStroke = Instance.new("UIStroke")
    uiStroke.Color = color
    uiStroke.Thickness = thickness
    uiStroke.Transparency = transparency

    function uiStroke:SetColor(newColor)
        self.Color = newColor
    end

    function uiStroke:SetThickness(newThickness)
        self.Thickness = newThickness
    end

    function uiStroke:SetTransparency(newTransparency)
        self.Transparency = newTransparency
    end

    return uiStroke
end

-- UIPadding
function SolarisUi.CreateUIPadding(padding)
    local uiPadding = Instance.new("UIPadding")
    uiPadding.Padding = padding

    function uiPadding:SetPadding(newPadding)
        self.Padding = newPadding
    end

    return uiPadding
end

-- UIListLayout
function SolarisUi.CreateUIListLayout(fillDirection, horizontalAlignment, verticalAlignment)
    local uiListLayout = Instance.new("UIListLayout")
    uiListLayout.FillDirection = fillDirection
    uiListLayout.HorizontalAlignment = horizontalAlignment
    uiListLayout.VerticalAlignment = verticalAlignment

    function uiListLayout:SetFillDirection(newDirection)
        self.FillDirection = newDirection
    end

    function uiListLayout:SetHorizontalAlignment(newAlignment)
        self.HorizontalAlignment = newAlignment
    end

    function uiListLayout:SetVerticalAlignment(newAlignment)
        self.VerticalAlignment = newAlignment
    end

    return uiListLayout
end

-- UIGridLayout
function SolarisUi.CreateUIGridLayout(cellSize, cellPadding)
    local uiGridLayout = Instance.new("UIGridLayout")
    uiGridLayout.CellSize = cellSize
    uiGridLayout.CellPadding = cellPadding

    function uiGridLayout:SetCellSize(newSize)
        self.CellSize = newSize
    end

    function uiGridLayout:SetCellPadding(newPadding)
        self.CellPadding = newPadding
    end

    return uiGridLayout
end

return SolarisUi
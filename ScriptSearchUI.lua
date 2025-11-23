local ScriptSearch = require("ScriptSearch")
local HttpService = game:GetService("HttpService")

local ScriptSearchUI = {}
ScriptSearchUI.__index = ScriptSearchUI

function ScriptSearchUI.new(parent)
    local self = setmetatable({}, ScriptSearchUI)
    self.scriptSearch = ScriptSearch.new()
    self.parent = parent
    self.results = {}
    self.currentPage = 1
    self.resultsPerPage = 10
    self.totalPages = 1
    
    return self
end

function ScriptSearchUI:CreateUI(store)
    self.store = store
    
    -- Create main frame
    self.frame = Instance.new("Frame")
    self.frame.Name = "ScriptSearchFrame"
    self.frame.Size = UDim2.new(1, 0, 1, 0)
    self.frame.BackgroundTransparency = 0.2
    self.frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    self.frame.BorderSizePixel = 0
    self.frame.Visible = false
    self.frame.Parent = self.parent
    
    -- Create top bar
    local topBar = Instance.new("Frame")
    topBar.Name = "TopBar"
    topBar.Size = UDim2.new(1, 0, 0, 40)
    topBar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    topBar.BorderSizePixel = 0
    topBar.Parent = self.frame
    
    -- Create search bar
    self.searchBar = Instance.new("TextBox")
    self.searchBar.Name = "SearchBar"
    self.searchBar.Size = UDim2.new(0.7, 0, 0, 30)
    self.searchBar.Position = UDim2.new(0.02, 0, 0, 5)
    self.searchBar.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    self.searchBar.BorderSizePixel = 0
    self.searchBar.Text = ""
    self.searchBar.PlaceholderText = "Search for scripts..."
    self.searchBar.TextColor3 = Color3.fromRGB(255, 255, 255)
    self.searchBar.PlaceholderColor3 = Color3.fromRGB(200, 200, 200)
    self.searchBar.FontSize = Enum.FontSize.Size18
    self.searchBar.Font = Enum.Font.GothamBold
    self.searchBar.ClearTextOnFocus = false
    self.searchBar.Parent = topBar
    
    -- Create search button
    local searchButton = Instance.new("TextButton")
    searchButton.Name = "SearchButton"
    searchButton.Size = UDim2.new(0.1, 0, 0, 30)
    searchButton.Position = UDim2.new(0.73, 0, 0, 5)
    searchButton.BackgroundColor3 = Color3.fromRGB(70, 70, 180)
    searchButton.BorderSizePixel = 0
    searchButton.Text = "Search"
    searchButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    searchButton.FontSize = Enum.FontSize.Size18
    searchButton.Font = Enum.Font.GothamBold
    searchButton.Parent = topBar
    
    -- Create close button
    local closeButton = Instance.new("TextButton")
    closeButton.Name = "CloseButton"
    closeButton.Size = UDim2.new(0.1, 0, 0, 30)
    closeButton.Position = UDim2.new(0.88, 0, 0, 5)
    closeButton.BackgroundColor3 = Color3.fromRGB(180, 70, 70)
    closeButton.BorderSizePixel = 0
    closeButton.Text = "Close"
    closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeButton.FontSize = Enum.FontSize.Size18
    closeButton.Font = Enum.Font.GothamBold
    closeButton.Parent = topBar
    
    -- Create results frame
    local resultsFrame = Instance.new("ScrollingFrame")
    resultsFrame.Name = "ResultsFrame"
    resultsFrame.Size = UDim2.new(1, 0, 0.9, -40)
    resultsFrame.Position = UDim2.new(0, 0, 0.1, 0)
    resultsFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    resultsFrame.BorderSizePixel = 0
    resultsFrame.ScrollBarThickness = 6
    resultsFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    resultsFrame.Parent = self.frame
    self.resultsFrame = resultsFrame
    
    -- Create pagination frame
    local paginationFrame = Instance.new("Frame")
    paginationFrame.Name = "PaginationFrame"
    paginationFrame.Size = UDim2.new(1, 0, 0, 40)
    paginationFrame.Position = UDim2.new(0, 0, 0.98, -40)
    paginationFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    paginationFrame.BorderSizePixel = 0
    paginationFrame.Parent = self.frame
    
    -- Add pagination buttons
    local prevButton = Instance.new("TextButton")
    prevButton.Name = "PrevButton"
    prevButton.Size = UDim2.new(0.1, 0, 0, 30)
    prevButton.Position = UDim2.new(0.35, 0, 0, 5)
    prevButton.BackgroundColor3 = Color3.fromRGB(70, 70, 180)
    prevButton.BorderSizePixel = 0
    prevButton.Text = "< Prev"
    prevButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    prevButton.Parent = paginationFrame
    
    local pageLabel = Instance.new("TextLabel")
    pageLabel.Name = "PageLabel"
    pageLabel.Size = UDim2.new(0.1, 0, 0, 30)
    pageLabel.Position = UDim2.new(0.45, 0, 0, 5)
    pageLabel.BackgroundTransparency = 1
    pageLabel.Text = "Page 1"
    pageLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    pageLabel.Parent = paginationFrame
    self.pageLabel = pageLabel
    
    local nextButton = Instance.new("TextButton")
    nextButton.Name = "NextButton"
    nextButton.Size = UDim2.new(0.1, 0, 0, 30)
    nextButton.Position = UDim2.new(0.55, 0, 0, 5)
    nextButton.BackgroundColor3 = Color3.fromRGB(70, 70, 180)
    nextButton.BorderSizePixel = 0
    nextButton.Text = "Next >"
    nextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    nextButton.Parent = paginationFrame
    
    -- Connect events
    searchButton.MouseButton1Click:Connect(function()
        self:PerformSearch()
    end)
    
    closeButton.MouseButton1Click:Connect(function()
        self:Hide()
    end)
    
    self.searchBar.FocusLost:Connect(function(enterPressed)
        if enterPressed then
            self:PerformSearch()
        end
    end)
    
    prevButton.MouseButton1Click:Connect(function()
        if self.currentPage > 1 then
            self.currentPage = self.currentPage - 1
            self:PerformSearch()
        end
    end)
    
    nextButton.MouseButton1Click:Connect(function()
        if self.currentPage < self.totalPages then
            self.currentPage = self.currentPage + 1
            self:PerformSearch()
        end
    end)
    
    return self.frame
end

function ScriptSearchUI:ClearResults()
    for _, child in pairs(self.resultsFrame:GetChildren()) do
        if child:IsA("Frame") then
            child:Destroy()
        end
    end
end

function ScriptSearchUI:CreateResultItem(script, index)
    local itemHeight = 80
    local yPos = (index - 1) * (itemHeight + 10)
    
    local item = Instance.new("Frame")
    item.Name = "ResultItem_" .. index
    item.Size = UDim2.new(0.98, 0, 0, itemHeight)
    item.Position = UDim2.new(0.01, 0, 0, yPos + 10)
    item.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    item.BorderSizePixel = 0
    item.Parent = self.resultsFrame
    
    -- Title
    local title = Instance.new("TextLabel")
    title.Name = "Title"
    title.Size = UDim2.new(0.98, 0, 0, 25)
    title.Position = UDim2.new(0.01, 0, 0, 5)
    title.BackgroundTransparency = 1
    title.Text = script.title or "Unknown Title"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 16
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = item
    
    -- Description
    local description = Instance.new("TextLabel")
    description.Name = "Description"
    description.Size = UDim2.new(0.7, 0, 0, 40)
    description.Position = UDim2.new(0.01, 0, 0, 30)
    description.BackgroundTransparency = 1
    description.Text = script.game or "Unknown Game"
    description.TextColor3 = Color3.fromRGB(200, 200, 200)
    description.Font = Enum.Font.Gotham
    description.TextSize = 14
    description.TextWrapped = true
    description.TextXAlignment = Enum.TextXAlignment.Left
    description.Parent = item
    
    -- Execute button
    local executeButton = Instance.new("TextButton")
    executeButton.Name = "ExecuteButton"
    executeButton.Size = UDim2.new(0.25, 0, 0, 30)
    executeButton.Position = UDim2.new(0.73, 0, 0, 40)
    executeButton.BackgroundColor3 = Color3.fromRGB(70, 180, 70)
    executeButton.BorderSizePixel = 0
    executeButton.Text = "Execute"
    executeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    executeButton.Font = Enum.Font.GothamBold
    executeButton.TextSize = 14
    executeButton.Parent = item
    
    executeButton.MouseButton1Click:Connect(function()
        self:ExecuteScript(script)
    end)
    
    return item
end

function ScriptSearchUI:PerformSearch()
    local query = self.searchBar.Text
    if query == "" then return end
    
    self:ClearResults()
    
    -- Show loading indicator
    local loadingLabel = Instance.new("TextLabel")
    loadingLabel.Name = "LoadingLabel"
    loadingLabel.Size = UDim2.new(1, 0, 0, 40)
    loadingLabel.Position = UDim2.new(0, 0, 0, 10)
    loadingLabel.BackgroundTransparency = 1
    loadingLabel.Text = "Searching..."
    loadingLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    loadingLabel.Font = Enum.Font.GothamBold
    loadingLabel.TextSize = 18
    loadingLabel.Parent = self.resultsFrame
    
    -- Perform the search
    spawn(function()
        local response = self.scriptSearch:Search(query, self.currentPage, self.resultsPerPage)
        
        self:ClearResults()
        
        if response and response.scripts and #response.scripts > 0 then
            self.results = response.scripts
            self.totalPages = math.ceil(response.count / self.resultsPerPage)
            self.pageLabel.Text = "Page " .. self.currentPage .. " / " .. self.totalPages
            
            -- Update canvas size based on results
            self.resultsFrame.CanvasSize = UDim2.new(0, 0, 0, #self.results * 90)
            
            for i, script in ipairs(self.results) do
                self:CreateResultItem(script, i)
            end
        else
            -- Show no results message
            local noResultsLabel = Instance.new("TextLabel")
            noResultsLabel.Name = "NoResultsLabel"
            noResultsLabel.Size = UDim2.new(1, 0, 0, 40)
            noResultsLabel.Position = UDim2.new(0, 0, 0, 10)
            noResultsLabel.BackgroundTransparency = 1
            noResultsLabel.Text = "No results found"
            noResultsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            noResultsLabel.Font = Enum.Font.GothamBold
            noResultsLabel.TextSize = 18
            noResultsLabel.Parent = self.resultsFrame
        end
    end)
end

function ScriptSearchUI:ExecuteScript(scriptData)
    -- Show loading indicator
    local loadingFrame = Instance.new("Frame")
    loadingFrame.Name = "LoadingFrame"
    loadingFrame.Size = UDim2.new(0.3, 0, 0, 40)
    loadingFrame.Position = UDim2.new(0.35, 0, 0.4, 0)
    loadingFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    loadingFrame.BackgroundTransparency = 0.2
    loadingFrame.BorderSizePixel = 0
    loadingFrame.Parent = self.frame
    
    local loadingText = Instance.new("TextLabel")
    loadingText.Size = UDim2.new(1, 0, 1, 0)
    loadingText.BackgroundTransparency = 1
    loadingText.Text = "Loading script..."
    loadingText.TextColor3 = Color3.fromRGB(255, 255, 255)
    loadingText.Font = Enum.Font.GothamBold
    loadingText.TextSize = 16
    loadingText.Parent = loadingFrame
    
    spawn(function()
        local scriptText = self.scriptSearch:GetScript(scriptData.slug)
        loadingFrame:Destroy()
        
        if scriptText then
            -- Execute the script
            local success, err = pcall(function()
                loadstring(scriptText)()
            end)
            
            if not success then
                warn("Failed to execute script:", err)
                self:ShowNotification("Script execution failed: " .. tostring(err))
            else
                self:ShowNotification("Script executed successfully!")
            end
        else
            self:ShowNotification("Failed to load script!")
        end
    end)
end

function ScriptSearchUI:ShowNotification(message)
    local notification = Instance.new("Frame")
    notification.Name = "Notification"
    notification.Size = UDim2.new(0.4, 0, 0, 40)
    notification.Position = UDim2.new(0.3, 0, 0.1, 0)
    notification.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    notification.BackgroundTransparency = 0.2
    notification.BorderSizePixel = 0
    notification.Parent = self.frame
    
    local notificationText = Instance.new("TextLabel")
    notificationText.Size = UDim2.new(1, 0, 1, 0)
    notificationText.BackgroundTransparency = 1
    notificationText.Text = message
    notificationText.TextColor3 = Color3.fromRGB(255, 255, 255)
    notificationText.Font = Enum.Font.GothamBold
    notificationText.TextSize = 16
    notificationText.Parent = notification
    
    -- Auto remove after 3 seconds
    spawn(function()
        wait(3)
        notification:Destroy()
    end)
end

function ScriptSearchUI:Show()
    self.frame.Visible = true
    self.searchBar:CaptureFocus()
end

function ScriptSearchUI:Hide()
    self.frame.Visible = false
end

function ScriptSearchUI:Toggle()
    self.frame.Visible = not self.frame.Visible
    if self.frame.Visible then
        self.searchBar:CaptureFocus()
    end
end

return ScriptSearchUI

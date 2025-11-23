local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")

local ScriptSearch = {}
ScriptSearch.__index = ScriptSearch

function ScriptSearch.new()
    local self = setmetatable({}, ScriptSearch)
    self.apiUrl = "https://www.scriptblox.com/api/script/search"
    self.scriptUrl = "https://www.scriptblox.com/api/script/"
    return self
end

function ScriptSearch:Search(query, page, limit)
    page = page or 1
    limit = limit or 10
    
    local success, response = pcall(function()
        local url = string.format("%s?q=%s&page=%d&limit=%d", 
            self.apiUrl, 
            HttpService:UrlEncode(query), 
            page,
            limit)
            
        local response = HttpService:GetAsync(url)
        return HttpService:JSONDecode(response)
    end)
    
    if success then
        return response
    else
        warn("Failed to search scripts:", response)
        return {scripts = {}}
    end
end

function ScriptSearch:GetScript(scriptId)
    local success, response = pcall(function()
        local url = self.scriptUrl .. scriptId
        local response = HttpService:GetAsync(url)
        return HttpService:JSONDecode(response)
    end)
    
    if success and response.script and response.script.script then
        return response.script.script
    else
        warn("Failed to get script:", scriptId)
        return nil
    end
end

return ScriptSearch

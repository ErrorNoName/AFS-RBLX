local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local DataStoreService = game:GetService("DataStoreService")

local function getGameName()
    return game.Name
end

local function scanElements()
    local elements = {}
    for _, instance in ipairs(workspace:GetDescendants()) do
        table.insert(elements, {
            Name = instance.Name,
            Class = instance.ClassName,
            Parent = instance.Parent.Name,
            Properties = {}
        })
        
        for property, value in pairs(instance:GetAttributes()) do
            table.insert(elements[#elements].Properties, {property = property, value = value})
        end
    end
    return elements
end

local function formatData(elements)
    local formattedData = "Scanned Elements from " .. getGameName() .. ":\n\n"
    for _, element in ipairs(elements) do
        formattedData = formattedData .. "Name: " .. element.Name .. "\n"
        formattedData = formattedData .. "Class: " .. element.Class .. "\n"
        formattedData = formattedData .. "Parent: " .. element.Parent .. "\n"
        formattedData = formattedData .. "Properties:\n"
        
        for _, property in ipairs(element.Properties) do
            formattedData = formattedData .. "  " .. property.property .. ": " .. tostring(property.value) .. "\n"
        end
        
        formattedData = formattedData .. "\n"
    end
    return formattedData
end

local function writeToFile(data)
    local fileName = getGameName() .. "_elements.txt"
    local file = Instance.new("File", game)
    file.Name = fileName
    file.Source = data
    file:Save()
end

local function main()
    local elements = scanElements()
    local formattedData = formatData(elements)
    writeToFile(formattedData)
end

main()
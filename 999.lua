local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerCharacter = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HumanoidRootPart = PlayerCharacter:WaitForChild("HumanoidRootPart")
local Config = {
    AutoBringFood = true,
    AutoBringFuel = true,
    ESP_Enabled = true,
}
local function IsItemType(item, itemType)
    local name = item.Name:lower()
    if itemType == "food" then 
        return name:find("morsel") or name:find("steak")
    elseif itemType == "fuel" then 
        return name:find("fuel")
    elseif itemType == "chest" then 
        return name:find("chest")
    end
    return false
end
local function GetDistance(pos1, pos2)
    return (pos1 - pos2).Magnitude
end
local function AutoBringItems()
    if not (Config.AutoBringFood or Config.AutoBringFuel) then return end
    while true do
        local allItems = workspace:GetDescendants()
        for _, item in ipairs(allItems) do
            if not item:IsA("Model") then goto continue end
            if Config.AutoBringFood and IsItemType(item, "food") then
                local foodPos = item:GetPivot().Position
                local playerPos = HumanoidRootPart.Position
                if GetDistance(foodPos, playerPos) < 10 then
                    print("[自动搬运] 找到食物: "..item.Name.." (距离: "..GetDistance(foodPos, playerPos)..")")
                end
            end
            if Config.AutoBringFuel and IsItemType(item, "fuel") then
                local fuelPos = item:GetPivot().Position
                local playerPos = HumanoidRootPart.Position
                if GetDistance(fuelPos, playerPos) < 10 then
                    print("[自动搬运] 找到燃料: "..item.Name.." (距离: "..GetDistance(fuelPos, playerPos)..")")
                end
            end
            if Config.AutoBringFuel and IsItemType(item, "chest") then
                local chestPos = item:GetPivot().Position
                local playerPos = HumanoidRootPart.Position
                if GetDistance(chestPos, playerPos) < 10 then
                    print("[自动搬运] 找到箱子: "..item.Name.." (距离: "..GetDistance(chestPos, playerPos)..")")
                end
            end
            ::continue::
        end
        wait(1)
    end
end
local function CreateESPMarker(item)
    if not Config.ESP_Enabled then return end
    local espFrame = Instance.new("Frame")
    espFrame.Size = UDim2.new(0, 150, 0, 30)
    espFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    espFrame.BackgroundTransparency = 0.5
    espFrame.BorderSizePixel = 0
    local textColor = Color3.fromRGB(255, 255, 255)
    local text = "未知物品"
    if IsItemType(item, "food") then
        textColor = Color3.fromRGB(255, 165, 0)
        text = "食物: "..item.Name
    elseif IsItemType(item, "fuel") then
        textColor = Color3.fromRGB(0, 255, 0)
        text = "燃料: "..item.Name
    elseif IsItemType(item, "chest") then
        textColor = Color3.fromRGB(128, 128, 128)
        text = "箱子: "..item.Name
    end
    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.Text = text
    textLabel.TextColor3 = textColor
    textLabel.TextSize = 14
    textLabel.BackgroundTransparency = 1
    textLabel.Parent = espFrame
    espFrame.Adornee = item
    espFrame.Parent = workspace
    print("[ESP] 创建标记: "..text)
end
local function SetupESPMonitoring()
    game:GetService("RunService").Heartbeat:Connect(function()
        for _, item in ipairs(workspace:GetDescendants()) do
            if item:IsA("Model") and not item:FindFirstChild("ESP_Marked") then
                item:SetAttribute("ESP_Marked", true)
                if IsItemType(item, "food") or IsItemType(item, "fuel") or IsItemType(item, "chest") then
                    CreateESPMarker(item)
                end
            end
        end
    end)
end
local function Main()
    print("[脚本启动] 开始运行简化版物品管理逻辑")
    task.spawn(AutoBringItems)
    SetupESPMonitoring()
end
Main()

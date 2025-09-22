local module = {}

getgenv().globalcolour = {
    "Celestial v66",
    "Celestial Script",
    "Celestial Information",
    "Menu",
    "Configuration",
    "Server Info",
    "Reminder for you :3",
    "Dangerous Area",
    "Alert! Not safe",
    "How to use it?",
    "Information Script",
    "Webhook Celestial",
    "CELESTIAL NOTIFICATION",
}

getgenv().colour = getgenv().colour or {}

local function makeGradient()
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0.00, Color3.fromRGB(0, 42, 255)),
        ColorSequenceKeypoint.new(0.20, Color3.fromRGB(174, 0, 255)),
        ColorSequenceKeypoint.new(0.40, Color3.fromRGB(0, 191, 255)),
        ColorSequenceKeypoint.new(0.60, Color3.fromRGB(174, 0, 255)),
        ColorSequenceKeypoint.new(0.80, Color3.fromRGB(0, 42, 255)),
        ColorSequenceKeypoint.new(1.00, Color3.fromRGB(0, 42, 255)),
    })
    gradient.Rotation = 0
    return gradient
end

local function getKeywords()
    local merged = {}
    for _, v in ipairs(getgenv().globalcolour or {}) do
        table.insert(merged, v:lower())
    end
    for _, v in ipairs(getgenv().colour or {}) do
        table.insert(merged, v:lower())
    end
    return merged
end

function module.ApplyTo()
    local hui = (gethui and gethui()) or game:GetService("CoreGui")
    local root = hui:FindFirstChild("Chloeee uwuuu :3")
    if not root then return end
    local hub = root:FindFirstChild("Hub")
    if not hub then return end
    local components = hub:FindFirstChild("Components")
    if not components then return end

    local keywords = getKeywords()
    for _, obj in ipairs(components:GetDescendants()) do
        if obj:IsA("TextLabel") and obj.Text ~= "" then
            local textLower = obj.Text:lower()
            local shouldColor = false

            for _, keyword in ipairs(keywords) do
                if textLower == keyword then
                    shouldColor = true
                    break
                end
            end

            if textLower == "feature" then
                shouldColor = true
            end

            if shouldColor then
                obj.TextColor3 = Color3.fromRGB(255, 255, 255)
                if not obj:FindFirstChildOfClass("UIGradient") then
                    makeGradient().Parent = obj
                end
            end
        end
    end
end

return module

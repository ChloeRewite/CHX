local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

local NotifHolder = CoreGui:FindFirstChild("ChloeNotifs")
if not NotifHolder then
    NotifHolder = Instance.new("Folder")
    NotifHolder.Name = "ChloeNotifs"
    NotifHolder.Parent = CoreGui
end

local Chloe = {}

function Chloe:Notify(Notification)
    task.spawn(function()
        local NotifData = {
            Title = Notification.Title or "CELESTIAL NOTIFICATION",
            Content = Notification.Content or "",
            Duration = Notification.Duration or 5,
        }

        local index = #NotifHolder:GetChildren()

        local Notif = Instance.new("Frame")
        Notif.Size = UDim2.fromOffset(260, 75)
        Notif.AnchorPoint = Vector2.new(1, 0)
        Notif.Position = UDim2.new(1, 280, 0, 20 + (index * 80))
        Notif.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        Notif.BackgroundTransparency = 0.15
        Notif.ZIndex = 10
        Notif.Parent = NotifHolder
        Instance.new("UICorner", Notif).CornerRadius = UDim.new(0, 6)

        local Header = Instance.new("Frame", Notif)
        Header.Size = UDim2.new(1, 0, 0, 22)
        Header.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        Header.ZIndex = 11
        Instance.new("UICorner", Header).CornerRadius = UDim.new(0, 6)

        local Title = Instance.new("TextLabel", Header)
        Title.Size = UDim2.new(1, -10, 1, 0)
        Title.Position = UDim2.new(0, 6, 0, 0)
        Title.BackgroundTransparency = 1
        Title.Text = NotifData.Title
        Title.Font = Enum.Font.GothamBold
        Title.TextSize = 14
        Title.TextColor3 = Color3.fromRGB(255, 255, 255)
        Title.TextXAlignment = Enum.TextXAlignment.Left
        Title.ZIndex = 12

        local Separator = Instance.new("Frame", Notif)
        Separator.Size = UDim2.new(1, -12, 0, 1)
        Separator.Position = UDim2.new(0, 6, 0, 23)
        Separator.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        Separator.BorderSizePixel = 0
        Separator.ZIndex = 11

        local Content = Instance.new("TextLabel", Notif)
        Content.Size = UDim2.new(1, -14, 1, -28)
        Content.Position = UDim2.new(0, 7, 0, 26)
        Content.BackgroundTransparency = 1
        Content.Text = NotifData.Content
        Content.Font = Enum.Font.GothamSemibold
        Content.TextSize = 15
        Content.TextColor3 = Color3.fromRGB(245, 245, 245)
        Content.TextWrapped = true
        Content.TextXAlignment = Enum.TextXAlignment.Left
        Content.TextYAlignment = Enum.TextYAlignment.Top
        Content.ZIndex = 11
        Content.TextStrokeTransparency = 0.7
        Content.TextStrokeColor3 = Color3.fromRGB(15, 15, 15)

        local Progress = Instance.new("Frame", Notif)
        Progress.Size = UDim2.new(1, -12, 0, 3)
        Progress.Position = UDim2.new(1, -6, 1, -6)
        Progress.AnchorPoint = Vector2.new(1, 0)
        Progress.BackgroundColor3 = Color3.fromRGB(0, 50, 200)
        Progress.BorderSizePixel = 0
        Progress.ZIndex = 12
        Instance.new("UICorner", Progress).CornerRadius = UDim.new(1, 0)

        TweenService:Create(
            Progress,
            TweenInfo.new(NotifData.Duration, Enum.EasingStyle.Linear),
            {Size = UDim2.new(0, 0, 0, 3)}
        ):Play()

        TweenService:Create(
            Notif,
            TweenInfo.new(0.35, Enum.EasingStyle.Quint),
            {Position = UDim2.new(1, -20, 0, 20 + (index * 80))}
        ):Play()

        task.delay(NotifData.Duration, function()
            if Notif and Notif.Parent then
                TweenService:Create(
                    Notif,
                    TweenInfo.new(0.25),
                    {Position = Notif.Position + UDim2.new(0, 280, 0, 0)}
                ):Play()
                task.wait(0.3)
                Notif:Destroy()
            end
        end)
    end)
end

setmetatable(Chloe, {
    __call = function(self, msg)
        self:Notify({Content = msg, Duration = 4})
    end
})

return Chloe

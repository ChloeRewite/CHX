-- Ch.lua
return function(Window, Tabs)

    local Players = game:GetService("Players")
    local TeleportService = game:GetService("TeleportService")
    local RunService = game:GetService("RunService")
    local Lighting = game:GetService("Lighting")
    local LocalPlayer = Players.LocalPlayer
    local UserInputService = game:GetService("UserInputService")

    --== Info Section
    local InfoSection = Tabs.Info:AddSection("Information")

    InfoSection:AddParagraph({
        Title = "Welcome To Chloe X!",
        Content = [[
<font color='rgb(255,200,0)'>This game is still under development.</font>

If you found any <font color='rgb(255,0,0)'>bug / error / patched features</font>,  
please report to the <font color='rgb(0,191,255)'>official Discord server</font> in the report channel.  
They will fix it as soon as possible!

For information and updates, check <font color='rgb(174,0,255)'>Discord</font> :3  

<font color='rgb(135,206,250)'>Thank you for using Chloe X!</font>
        ]]
    })

    InfoSection:AddButton({
        Title = "Copy Discord Link",
        Content = "Click for copy link discord official Chloe X",
        Callback = function()
            if setclipboard then
                setclipboard("https://discord.gg/PaPvGUE8UC")
                chloex("Discord link has been copied to clipboard!") 
            end
        end
    })

    local ServerSection = Tabs.Info:AddSection("Server Information")

    local serverParagraph = ServerSection:AddParagraph({
        Title = "Server Info",
        Content = "Loading..."
    })

    task.spawn(function()
        local start = os.clock()
        while task.wait(1) do
            local elapsed = os.clock() - start
            local h = math.floor(elapsed / 3600)
            local m = math.floor((elapsed % 3600) / 60)
            local s = math.floor(elapsed % 60)

            serverParagraph:SetContent(string.format(
                "Current Player : %d/%d\nJob Id : %s\nTime Play : %02d:%02d:%02d",
                #Players:GetPlayers(),
                Players.MaxPlayers,
                game.JobId,
                h, m, s
            ))
        end
    end)

    ServerSection:AddButton({
        Title = "Copy Job Id",
        Content = "Click to copy this server JobId",
        Callback = function()
            if setclipboard then
                setclipboard(game.JobId)
                chloex("Job Id has been copied to clipboard!")
            end
        end
    })

    local jobId = ""
    ServerSection:AddInput({
        Title = "Target Job Id",
        Content = "Enter Job Id here",
        Default = "",
        Callback = function(value)
            jobId = value
        end
    })

    ServerSection:AddButton({
        Title = "Join Job Id",
        Content = "Teleport to the given Job Id",
        Callback = function()
            if jobId ~= "" then
                TeleportService:TeleportToPlaceInstance(game.PlaceId, jobId, LocalPlayer)
                chloex("Attempting to join Job Id: " .. jobId)
            else
                chloex("Please enter a Job Id first!")
            end
        end
    })

    --== State
    local NoclipEnabled = false
    local WalkspeedEnabled = false
    local WalkspeedValue = 16
    local XrayEnabled = false
    local FullBrightEnabled = false
    local InfJumpEnabled = false

    local function applyFullbright()
        Lighting.Ambient = Color3.new(1, 1, 1)
        Lighting.Brightness = 2
        Lighting.FogEnd = 100000
        Lighting.GlobalShadows = false
    end

    --== Misc
    local MiscSection = Tabs.Misc:AddSection("Booster FPS")

    MiscSection:AddToggle({
        Title = "Disable 3D Render",
        Content = "No Render Map",
        Default = false,
        Callback = function(state)
            if typeof(RunService.Set3dRenderingEnabled) == "function" then
                RunService:Set3dRenderingEnabled(not state)
            end
        end
    })

    MiscSection:AddToggle({
        Title = "Reduce Map",
        Content = "Fps Booster!",
        Default = false,
        Callback = function(value)
            for _, obj in ipairs(workspace:GetDescendants()) do
                if obj:IsA("BasePart") then
                    if value then
                        obj.Material = Enum.Material.Plastic
                        obj.Color = Color3.new(1, 1, 1)
                    end
                elseif obj:IsA("ParticleEmitter") or obj:IsA("Trail") then
                    obj.Enabled = not value
                elseif obj:IsA("Shirt") or obj:IsA("Pants") or obj:IsA("ShirtGraphic") or obj:IsA("Accessory") then
                    if value then obj:Destroy() end
                end
            end
            if workspace:FindFirstChild("Terrain") then
                workspace.Terrain.WaterWaveSize = value and 0 or 0.15
                workspace.Terrain.WaterWaveSpeed = value and 0 or 10
                workspace.Terrain.WaterReflectance = value and 0 or 1
                workspace.Terrain.WaterTransparency = value and 0 or 0.3
            end
        end
    })

    MiscSection:AddToggle({
        Title = "Black Screen",
        Content = "Create your screen fully black",
        Default = false,
        Callback = function(value)
            if value then
                if not game.CoreGui:FindFirstChild("BlackScreen") then
                    local frame = Instance.new("ScreenGui")
                    frame.Name = "BlackScreen"
                    frame.IgnoreGuiInset = true
                    frame.ResetOnSpawn = false
                    frame.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
                    frame.Parent = game.CoreGui
                    local bg = Instance.new("Frame", frame)
                    bg.Size = UDim2.new(1, 0, 1, 0)
                    bg.BackgroundColor3 = Color3.new(0, 0, 0)
                end
                RunService:Set3dRenderingEnabled(false)
            else
                local bs = game.CoreGui:FindFirstChild("BlackScreen")
                if bs then bs:Destroy() end
                RunService:Set3dRenderingEnabled(true)
            end
        end
    })

    --== Utility
    local UtilitySection = Tabs.Misc:AddSection("Utility")

    UtilitySection:AddToggle({
        Title = "Noclip",
        Content = "Make cant touch any",
        Default = false,
        Callback = function(value)
            NoclipEnabled = value
        end
    })

    RunService.Stepped:Connect(function()
        if NoclipEnabled and LocalPlayer.Character then
            for _, v in pairs(LocalPlayer.Character:GetDescendants()) do
                if v:IsA("BasePart") and v.CanCollide then
                    v.CanCollide = false
                end
            end
        end
    end)

    UtilitySection:AddSlider({
        Title = "Walkspeed",
        Min = 16,
        Max = 200,
        Default = 16,
        Callback = function(value)
            WalkspeedValue = value
            if WalkspeedEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                LocalPlayer.Character.Humanoid.WalkSpeed = WalkspeedValue
            end
        end
    })

    UtilitySection:AddToggle({
        Title = "Enable Walkspeed",
        Content = "Added more speed!",
        Default = false,
        Callback = function(value)
            WalkspeedEnabled = value
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                LocalPlayer.Character.Humanoid.WalkSpeed = value and WalkspeedValue or 16
            end
        end
    })

    UtilitySection:AddToggle({
        Title = "Xray",
        Default = false,
        Callback = function(value)
            XrayEnabled = value
            for _, obj in ipairs(workspace:GetDescendants()) do
                if obj:IsA("BasePart") then
                    obj.LocalTransparencyModifier = value and 0.5 or 0
                end
            end
        end
    })

    UtilitySection:AddToggle({
        Title = "Fullbright",
        Default = false,
        Callback = function(value)
            FullBrightEnabled = value
            if value then
                applyFullbright()
            else
                Lighting.Ambient = Color3.new(0, 0, 0)
                Lighting.Brightness = 1
                Lighting.FogEnd = 1000
                Lighting.GlobalShadows = true
            end
        end
    })

    UtilitySection:AddToggle({
        Title = "Infinite Jump",
        Content = "Make You Inf Jump",
        Default = false,
        Callback = function(value)
            InfJumpEnabled = value
        end
    })

    UserInputService.JumpRequest:Connect(function()
        if InfJumpEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end)

end

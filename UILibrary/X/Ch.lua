local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local LocalPlayer = Players.LocalPlayer

InfoSection = Tabs.Info:AddSection("Information")

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

ServerSection = Tabs.Info:AddSection("Server Information")

serverParagraph = ServerSection:AddParagraph({
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

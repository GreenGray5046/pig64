--[[ 
    Gynixius Pig 64 Script Fixed Version
    Cleaned, debugged, and improved for stability.
    Credits: YT-Ginxys | Script Fixes by ChatGPT
--]]

-- 🟨 Startup Notifications
local StarterGui = game:GetService("StarterGui")

StarterGui:SetCore("SendNotification", {
    Title = "Gynixius NOTIFY!";
    Text = "Loading Script";
    Icon = "http://www.roblox.com/asset/?id=13829414882";
    Duration = 5
})
wait(5)

StarterGui:SetCore("SendNotification", {
    Title = "Gynixius NOTIFY!";
    Text = "Script Loaded MADE BY GINXYS!!!";
    Icon = "http://www.roblox.com/asset/?id=13829412863";
    Duration = 10
})

-- 🟨 Setup
local player = game.Players.LocalPlayer
local RunService = game:GetService("RunService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local ownerUserId = 5450713868

-- 🟨 Notifications UI Lib
local NotificationHolder = loadstring(game:HttpGet("https://raw.githubusercontent.com/BocusLuke/UI/main/STX/Module.Lua"))()
local Notification = loadstring(game:HttpGet("https://raw.githubusercontent.com/BocusLuke/UI/main/STX/Client.Lua"))()

Notification:Notify(
    {Title = "Pig 64 Script", Description = "Successfully Script is loaded! Enjoy"},
    {OutlineColor = Color3.fromRGB(255, 255, 255), Time = 3, Type = "default"}
)

Notification:Notify(
    {Title = "Pig 64 Script", Description = "SCRIPT IS FIXING, DON'T SPAM THAT IT DOESN'T WORK"},
    {OutlineColor = Color3.fromRGB(255, 255, 255), Time = 3, Type = "default"}
)

-- 🟨 Custom ESP Functions
function esp()
    getgenv().enabled = true
    getgenv().filluseteamcolor = false
    getgenv().outlineuseteamcolor = false
    getgenv().fillcolor = Color3.fromRGB(255, 0, 0)
    getgenv().outlinecolor = Color3.fromRGB(255, 255, 255)
    getgenv().filltrans = 0.7
    getgenv().outlinetrans = 0

    loadstring(game:HttpGet("https://gist.githubusercontent.com/Ginxys/a2d26247ddcd1670ad9be672dfd94914/raw/b4f5acf1667f24916a6af7440e0444c0a15f5051/customesp"))()
end

function unesp()
    getgenv().enabled = false
    esp() -- Reapply to disable
end

-- 🟨 Sound Effect
local siu = Instance.new("Sound")
siu.Name = "Soundwha"
siu.SoundId = "http://www.roblox.com/asset/?id=3320590485"
siu.Volume = 10
siu.Looped = false
siu.Archivable = true
siu.PlayOnRemove = false
siu.Parent = player
siu:Play()

-- 🟨 NoClip Functionality
local noclipEnabled = false

local function toggleNoclip(state)
    noclipEnabled = state or not noclipEnabled
    for _, part in pairs(player.Character:GetDescendants()) do
        if part:IsA("BasePart") then
            part.CanCollide = not noclipEnabled
        end
    end
end

RunService.Stepped:Connect(function()
    if noclipEnabled and player.Character then
        for _, part in pairs(player.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end)

-- 🟨 Owner Welcome Message
if player.UserId == ownerUserId then
    StarterGui:SetCore("SendNotification", {
        Title = "Welcome Owner",
        Text = "Welcome " .. player.Name,
        Duration = 5
    })
end

-- 🟨 Tora UI Library
local success, library = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/liebertsx/Tora-Library/main/src/librarynew", true))()
end)

if not success or not library then
    Notification:Notify(
        {Title = "Error", Description = "Failed to load UI Library"},
        {OutlineColor = Color3.fromRGB(255, 0, 255), Time = 5, Type = "default"}
    )
    return
end

local window = library:CreateWindow("Pig 64 Script")
local window2 = library:CreateWindow("Pig 64 Extra")

-- 🟨 Anti Report Button
window:AddButton({
    text = "Anti Report",
    callback = function()
        player.Character.Humanoid.DisplayDistanceType = "None"
        setfflag("AbuseReportScreenshot", "False")
        setfflag("AbuseReportScreenshotPercentage", "0")
    end
})

window:AddButton({
    text = "Fly WORKS",
    callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Zynox-Dev/Zynox-Fly/refs/heads/main/Fly.lua"))()
    end
})

-- 🟨 ESP Toggle
window:AddButton({
    text = "ESP (PLAYERS)",
    callback = function()
        esp()
    end
})

-- 🟨 Noclip Toggle
window:AddButton({
    text = "Toggle NoClip",
    callback = function()
        player.CameraMode = Enum.CameraMode.Classic
        toggleNoclip()

        Notification:Notify(
            {
                Title = "Notification",
                Description = noclipEnabled and "Noclip is Enabled" or "Noclip is Disabled"
            },
            {
                OutlineColor = Color3.fromRGB(255, 255, 0),
                Time = 5,
                Type = "default"
            }
        )
    end
})

-- 🟨 SUS Tree ESP (Fixed BillboardGui Parenting)
window2:AddButton({
    text = "ESP Suspicious Trees",
    callback = function()
        for _, g in pairs(workspace:GetDescendants()) do
            if g.Name == "SuspiciousTree" then
                local highlight = Instance.new("Highlight", g)
                local UI = Instance.new("BillboardGui")
                UI.Size = UDim2.new(0, 1000, 0, 30)
                UI.AlwaysOnTop = true
                UI.Parent = g

                local Label = Instance.new("TextLabel")
                Label.Size = UDim2.new(1, 0, 1, 0)
                Label.BackgroundTransparency = 1
                Label.TextScaled = true
                Label.Text = "SusTree"
                Label.TextColor3 = Color3.fromRGB(255, 0, 0)
                Label.FontFace = Font.new("rbxasset://fonts/families/Oswald.json")
                Label.TextStrokeTransparency = 0
                Label.Parent = UI
            end
        end
    end
})

-- 🟨 Auto Collectables
window:AddToggle({
    text = "Auto Collect (SUPER OP)",
    flag = "AutoCollect",
    callback = function(state)
        _G.autoCollect = state
        if state then
            task.spawn(function()
                while _G.autoCollect do
                    for _, g in pairs(workspace.Collectables:GetDescendants()) do
                        if g.Name == "Hitbox" then
                            firetouchinterest(player.Character.HumanoidRootPart, g, 0)
                            firetouchinterest(player.Character.HumanoidRootPart, g, 1)
                        end
                    end
                    task.wait(1)
                end
            end)
        end
    end
})

-- 🟨 Auto Kill (Bossfight)
window2:AddToggle({
    text = "Auto Kill (Bossfight)",
    flag = "AutoKill",
    callback = function(state)
        _G.autoKill = state
        if state then
            task.spawn(function()
                while _G.autoKill do
                    for _, g in pairs(game:GetService("ReplicatedStorage")
                        .Source.Puzzles.Networking.__NETWORKINGOBJECTS:GetDescendants()) do
                        if g.Name == "DamageBoss" then
                            pcall(function()
                                g:FireServer()
                            end)
                            task.wait(0.5)
                        end
                    end
                end
            end)
        end
    end
})

-- 🟨 Auto Open Doors/Keys (Normal Level)
window2:AddToggle({
    text = "Auto Keys/Open (Normal Level)",
    flag = "AutoKeys",
    callback = function(state)
        _G.autoKeys = state
        if state then
            task.spawn(function()
                while _G.autoKeys do
                    for _, g in pairs(workspace.Maps.WarehouseChase.MapSetup:GetDescendants()) do
                        if g:IsA("ProximityPrompt") then
                            g.HoldDuration = 0
                            task.wait(0.8)
                            pcall(function()
                                fireproximityprompt(g)
                            end)
                        end
                    end
                    task.wait(1)
                end
            end)
        end
    end
})

-- 🟨 Auto Dance (OP)
window2:AddToggle({
    text = "Auto Dance (OP)",
    flag = "AutoDance",
    callback = function(state)
        _G.autoDance = state
        if state then
            task.spawn(function()
                while _G.autoDance do
                    for i = 1, 5 do
                        local args = { i, "Dance" .. tostring(i + 5) }
                        pcall(function()
                            game:GetService("ReplicatedStorage")
                                .Source.Puzzles.Part7.Darcy.Remotes.RegisterDance:InvokeServer(unpack(args))
                        end)
                        wait(0.2)
                    end
                end
            end)
        end
    end
})

-- 🟨 Fix Lighting (Loop)
window:AddButton({
    text = "Loop Full Bright",
    callback = function()
        local Lighting = game:GetService("Lighting")
        local brightLoop
        if brightLoop then brightLoop:Disconnect() end

        brightLoop = RunService.RenderStepped:Connect(function()
            Lighting.Brightness = 2
            Lighting.ClockTime = 14
            Lighting.FogEnd = 100000
            Lighting.GlobalShadows = false
            Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
        end)
    end
})

-- 🟨 No Prompt Cooldown
window:AddButton({
    text = "No Prompt Cooldown",
    callback = function()
        game:GetService("ProximityPromptService").PromptButtonHoldBegan:Connect(function(prompt)
            fireproximityprompt(prompt)
        end)
        for _, v in ipairs(workspace:GetDescendants()) do
            if v:IsA("ProximityPrompt") then
                v.HoldDuration = 0
            end
        end
    end
})

-- 🟨 FOV Slider
window:AddSlider({
    text = "FOV",
    min = 70,
    max = 120,
    dual = false,
    type = "sliderfov",
    callback = function(val)
        workspace.CurrentCamera.FieldOfView = val
    end
})

-- 🟨 Credit Labels
window:AddLabel({ text = "Credits: YT-Ginxys", type = "label" })
window2:AddLabel({ text = "Script Fixes: ChatGPT", type = "label" })

-- 🟨 Finalize UI
library:Init()

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/heinftw/xanax-ui-lib/main/uilib"))()
local Players = game:GetService("Players")
local RS = game:GetService("RunService")
local LP = Players.LocalPlayer

local lib = Library.new({Title = "xanax hub"})
local Window = lib:Window({Title = "xanax hub", Width = 340, Height = 460})

local Main = Window:Tab("main")
local Misc = Window:Tab("misc")

-- main tab
Main:Section("player")

local walkSpeed = Main:Slider("walk speed", 16, 200, 16, function(v)
    local chr = LP.Character
    if chr then
        local hum = chr:FindFirstChildOfClass("Humanoid")
        if hum then hum.WalkSpeed = v end
    end
end)

local jumpPower = Main:Slider("jump power", 50, 200, 50, function(v)
    local chr = LP.Character
    if chr then
        local hum = chr:FindFirstChildOfClass("Humanoid")
        if hum then hum.JumpPower = v end
    end
end)

Main:Section("combat")

local espEnabled = Main:Toggle("esp", false, function(state)
    print("esp:", state)
end)

local aimbotEnabled = Main:Toggle("aimbot", false, function(state)
    print("aimbot:", state)
end)

local teamCheck = Main:Toggle("team check", true, function(state)
    print("team check:", state)
end)

local fov = Main:Slider("fov", 30, 300, 120, function(v)
    print("fov:", v)
end)

Main:Section("visuals")

local noFog = Main:Toggle("no fog", false, function(state)
    if state then
        game:GetService("Lighting").FogEnd = 99999
    else
        game:GetService("Lighting").FogEnd = 100000
    end
end)

local fullbright = Main:Toggle("fullbright", false, function(state)
    local l = game:GetService("Lighting")
    if state then
        l.Brightness = 2
        l.ClockTime = 14
    else
        l.Brightness = 1
    end
end)

-- misc tab
Misc:Section("teleport")

Misc:Button("teleport to spawn", function()
    local chr = LP.Character
    if chr then
        local hrp = chr:FindFirstChild("HumanoidRootPart")
        if hrp then hrp.CFrame = CFrame.new(0, 50, 0) end
    end
end)

Misc:Button("rejoin server", function()
    game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, LP)
end)

Misc:Section("info")

Misc:Label("executor: " .. (identifyexecutor and identifyexecutor() or "unknown"))
Misc:Label("players: " .. #Players:GetPlayers())
Misc:Paragraph("right shift to toggle this ui. configs are saved in the settings tab.")

-- keybind
lib:Popup({Title = "xanax", Sub = "welcome", Body = "this is xanax ui lib. check out the settings tab to save configs.", Buttons = {{"ok shhh"}}})

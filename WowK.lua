-- WowK Da Hood Script
-- Features: Spoofable Silent Aim, Sticky Cam Lock/Mouse Lock, ESP (2D Boxes, Names, Health), Fly, Speed, Noclip
-- UI: Auto-opens on load, togglable with Insert key, red theme with cyan details/text

local WowK = {}
WowK.Settings = {
    Aimbot = {
        Enabled = false,
        SilentAim = false,
        CamLock = false,
        MouseLock = false,
        StickyAim = true, -- Sticky aim for Cam Lock and Mouse Lock
        ToggleKey = Enum.KeyCode.F,},    Visuals = {
        ESPEnabled = false,
        BoxColor = Color3.fromRGB(255, 0, 0),
        NameColor = Color3.fromRGB(255, 255, 255),
        HealthColor = Color3.fromRGB(0, 255, 0),
        ShowOutlines = true,
        ToggleKey = Enum.KeyCode.G,},    Misc = {
        FlyEnabled = false,
        FlySpeed = 50,
        SpeedEnabled = false,
        WalkSpeed = 50,
        NoclipEnabled = false,
        FlyKey = Enum.KeyCode.H,
        SpeedKey = Enum.KeyCode.J,
        NoclipKey = Enum.KeyCode.K,},    UI = {
        Enabled = true, -- UI visible by default
        ToggleKey = Enum.KeyCode.Insert,},}

-- Services
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local GuiService = game:GetService("GuiService")

-- Local Player
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- UI Library (Customized with red theme and cyan details/text)
local function CreateUI()
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Parent = game.CoreGui
    ScreenGui.Name ="WowKGui"
    ScreenGui.Enabled = WowK.Settings.UI.Enabled

    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(0, 300, 0, 400)
    Frame.Position = UDim2.new(0.5, -150, 0.5, -200)
    Frame.BackgroundColor3 = Color3.fromRGB(200, 0, 0) -- Red theme
    Frame.BorderColor3 = Color3.fromRGB(0, 255, 255) -- Cyan border
    Frame.BorderSizePixel = 2
    Frame.Parent = ScreenGui
    Frame.Active = true
    Frame.Draggable = true

    -- Aimbot Tab
    local AimbotLabel = Instance.new("TextLabel")
    AimbotLabel.Size = UDim2.new(0, 100, 0, 30)
    AimbotLabel.Position = UDim2.new(0, 10, 0, 10)
    AimbotLabel.Text ="Aimbot Settings"
    AimbotLabel.TextColor3 = Color3.fromRGB(0, 255, 255) -- Cyan text
    AimbotLabel.BackgroundTransparency = 1
    AimbotLabel.Parent = Frame

    local SilentAimToggle = Instance.new("TextButton")
    SilentAimToggle.Size = UDim2.new(0, 80, 0, 30)
    SilentAimToggle.Position = UDim2.new(0, 10, 0, 50)
    SilentAimToggle.Text ="Silent Aim: OFF"
    SilentAimToggle.TextColor3 = Color3.fromRGB(0, 255, 255) -- Cyan text
    SilentAimToggle.BackgroundColor3 = Color3.fromRGB(150, 0, 0) -- Darker red
    SilentAimToggle.BorderColor3 = Color3.fromRGB(0, 255, 255) -- Cyan border
    SilentAimToggle.Parent = Frame
    SilentAimToggle.MouseButton1Click:Connect(function()
        WowK.Settings.Aimbot.SilentAim = not WowK.Settings.Aimbot.SilentAim
        SilentAimToggle.Text ="Silent Aim:" .. (WowK.Settings.Aimbot.SilentAim and"ON" or"OFF")
    end)

    local CamLockToggle = Instance.new("TextButton")
    CamLockToggle.Size = UDim2.new(0, 80, 0, 30)
    CamLockToggle.Position = UDim2.new(0, 100, 0, 50)
    CamLockToggle.Text ="Cam Lock: OFF"
    CamLockToggle.TextColor3 = Color3.fromRGB(0, 255, 255)
    CamLockToggle.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
    CamLockToggle.BorderColor3 = Color3.fromRGB(0, 255, 255)
    CamLockToggle.Parent = Frame
    CamLockToggle.MouseButton1Click:Connect(function()
        WowK.Settings.Aimbot.CamLock = not WowK.Settings.Aimbot.CamLock
        CamLockToggle.Text ="Cam Lock:" .. (WowK.Settings.Aimbot.CamLock and"ON" or"OFF")
    end)

    local MouseLockToggle = Instance.new("TextButton")
    MouseLockToggle.Size = UDim2.new(0, 80, 0, 30)
    MouseLockToggle.Position = UDim2.new(0, 190, 0, 50)
    MouseLockToggle.Text ="Mouse Lock: OFF"
    MouseLockToggle.TextColor3 = Color3.fromRGB(0, 255, 255)
    MouseLockToggle.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
    MouseLockToggle.BorderColor3 = Color3.fromRGB(0, 255, 255)
    MouseLockToggle.Parent = Frame
    MouseLockToggle.MouseButton1Click:Connect(function()
        WowK.Settings.Aimbot.MouseLock = not WowK.Settings.Aimbot.MouseLock
        MouseLockToggle.Text ="Mouse Lock:" .. (WowK.Settings.Aimbot.MouseLock and"ON" or"OFF")
    end)

    local StickyAimToggle = Instance.new("TextButton")
    StickyAimToggle.Size = UDim2.new(0, 80, 0, 30)
    StickyAimToggle.Position = UDim2.new(0, 10, 0, 90)
    StickyAimToggle.Text ="Sticky Aim: ON"
    StickyAimToggle.TextColor3 = Color3.fromRGB(0, 255, 255)
    StickyAimToggle.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
    StickyAimToggle.BorderColor3 = Color3.fromRGB(0, 255, 255)
    StickyAimToggle.Parent = Frame
    StickyAimToggle.MouseButton1Click:Connect(function()
        WowK.Settings.Aimbot.StickyAim = not WowK.Settings.Aimbot.StickyAim
        StickyAimToggle.Text ="Sticky Aim:" .. (WowK.Settings.Aimbot.StickyAim and"ON" or"OFF")
    end)

    local AimbotKeybind = Instance.new("TextButton")
    AimbotKeybind.Size = UDim2.new(0, 100, 0, 30)
    AimbotKeybind.Position = UDim2.new(0, 100, 0, 90)
    AimbotKeybind.Text ="Aimbot Key:" .. tostring(WowK.Settings.Aimbot.ToggleKey)
    AimbotKeybind.TextColor3 = Color3.fromRGB(0, 255, 255)
    AimbotKeybind.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
    AimbotKeybind.BorderColor3 = Color3.fromRGB(0, 255, 255)
    AimbotKeybind.Parent = Frame
    AimbotKeybind.MouseButton1Click:Connect(function()
        AimbotKeybind.Text ="Press a key..."
        local input = UserInputService.InputBegan:Wait()
        if input.UserInputType == Enum.UserInputType.Keyboard then
            WowK.Settings.Aimbot.ToggleKey = input.KeyCode
            AimbotKeybind.Text ="Aimbot Key:" .. tostring(input.KeyCode)
        end
    end)

    -- Visuals Tab
    local VisualsLabel = Instance.new("TextLabel")
    VisualsLabel.Size = UDim2.new(0, 100, 0, 30)
    VisualsLabel.Position = UDim2.new(0, 10, 0, 130)
    VisualsLabel.Text ="Visuals Settings"
    VisualsLabel.TextColor3 = Color3.fromRGB(0, 255, 255)
    VisualsLabel.BackgroundTransparency = 1
    VisualsLabel.Parent = Frame

    local ESPToggle = Instance.new("TextButton")
    ESPToggle.Size = UDim2.new(0, 80, 0, 30)
    ESPToggle.Position = UDim2.new(0, 10, 0, 170)
    ESPToggle.Text ="ESP: OFF"
    ESPToggle.TextColor3 = Color3.fromRGB(0, 255, 255)
    ESPToggle.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
    ESPToggle.BorderColor3 = Color3.fromRGB(0, 255, 255)
    ESPToggle.Parent = Frame
    ESPToggle.MouseButton1Click:Connect(function()
        WowK.Settings.Visuals.ESPEnabled = not WowK.Settings.Visuals.ESPEnabled
        ESPToggle.Text ="ESP:" .. (WowK.Settings.Visuals.ESPEnabled and"ON" or"OFF")
    end)

    local OutlineToggle = Instance.new("TextButton")
    OutlineToggle.Size = UDim2.new(0, 80, 0, 30)
    OutlineToggle.Position = UDim2.new(0, 100, 0, 170)
    OutlineToggle.Text ="Outlines: ON"
    OutlineToggle.TextColor3 = Color3.fromRGB(0, 255, 255)
    OutlineToggle.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
    OutlineToggle.BorderColor3 = Color3.fromRGB(0, 255, 255)
    OutlineToggle.Parent = Frame
    OutlineToggle.MouseButton1Click:Connect(function()
        WowK.Settings.Visuals.ShowOutlines = not WowK.Settings.Visuals.ShowOutlines
        OutlineToggle.Text ="Outlines:" .. (WowK.Settings.Visuals.ShowOutlines and"ON" or"OFF")
    end)

    local ESPKeybind = Instance.new("TextButton")
    ESPKeybind.Size = UDim2.new(0, 100, 0, 30)
    ESPKeybind.Position = UDim2.new(0, 10, 0, 210)
    ESPKeybind.Text ="ESP Key:" .. tostring(WowK.Settings.Visuals.ToggleKey)
    ESPKeybind.TextColor3 = Color3.fromRGB(0, 255, 255)
    ESPKeybind.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
    ESPKeybind.BorderColor3 = Color3.fromRGB(0, 255, 255)
    ESPKeybind.Parent = Frame
    ESPKeybind.MouseButton1Click:Connect(function()
        ESPKeybind.Text ="Press a key..."
        local input = UserInputService.InputBegan:Wait()
        if input.UserInputType == Enum.UserInputType.Keyboard then
            WowK.Settings.Visuals.ToggleKey = input.KeyCode
            ESPKeybind.Text ="ESP Key:" .. tostring(input.KeyCode)
        end
    end)

    -- Misc Tab
    local MiscLabel = Instance.new("TextLabel")
    MiscLabel.Size = UDim2.new(0, 100, 0, 30)
    MiscLabel.Position = UDim2.new(0, 10, 0, 250)
    MiscLabel.Text ="Misc Settings"
    MiscLabel.TextColor3 = Color3.fromRGB(0, 255, 255)
    MiscLabel.BackgroundTransparency = 1
    MiscLabel.Parent = Frame

    local FlyToggle = Instance.new("TextButton")
    FlyToggle.Size = UDim2.new(0, 80, 0, 30)
    FlyToggle.Position = UDim2.new(0, 10, 0, 290)
    FlyToggle.Text ="Fly: OFF"
    FlyToggle.TextColor3 = Color3.fromRGB(0, 255, 255)
    FlyToggle.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
    FlyToggle BestColor3 = Color3.fromRGB(0, 255, 255)
    FlyToggle.Parent = Frame
    FlyToggle.MouseButton1Click:Connect(function()
        WowK.Settings.Misc.FlyEnabled = not WowK.Settings.Misc.FlyEnabled
        FlyToggle.Text ="Fly:" .. (WowK.Settings.Misc.FlyEnabled and"ON" or"OFF")
    end)

    local SpeedToggle = Instance.new("TextButton")
    SpeedToggle.Size = UDim2.new(0, 80, 0, 30)
    SpeedToggle.Position = UDim2.

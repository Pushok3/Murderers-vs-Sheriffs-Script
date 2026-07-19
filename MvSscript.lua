-- MvS Script | Integrated Hitbox, ESP, Tracers & FOV

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MvS_GUI"
ScreenGui.DisplayOrder = 999999
ScreenGui.ResetOnSpawn = false 
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 300, 0, 450)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -225)
MainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui


local UIStroke = Instance.new("UIStroke")
UIStroke.Thickness = 3
UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke.Parent = MainFrame

task.spawn(function()
    while true do
        for i = 0, 1, 0.01 do
            UIStroke.Color = Color3.fromHSV(i, 1, 1)
            task.wait(0.05)
        end
    end
end)


local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundTransparency = 1
Title.Text = "MvS Script"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.Code
Title.TextSize = 24
Title.Parent = MainFrame


local Footer = Instance.new("TextLabel")
Footer.Size = UDim2.new(1, 0, 0, 30)
Footer.Position = UDim2.new(0, 0, 1, -30)
Footer.BackgroundTransparency = 1
Footer.Text = "YT:icanshowtoyou"
Footer.TextColor3 = Color3.fromRGB(150, 150, 150)
Footer.Font = Enum.Font.Code
Footer.TextSize = 14
Footer.Parent = MainFrame


_G.HeadSize = 10
_G.Disabled = false
_G.ESPEnabled = false
_G.TracersEnabled = false
_G.HitboxColor = BrickColor.new("Really blue")
_G.FOVEnabled = true
workspace.CurrentCamera.FieldOfView = 120


local HitboxButton = Instance.new("TextButton")
HitboxButton.Size = UDim2.new(0.8, 0, 0, 50)
HitboxButton.Position = UDim2.new(0.1, 0, 0.15, 0)
HitboxButton.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
HitboxButton.BorderSizePixel = 0
HitboxButton.Text = "Hitbox Expander: OFF"
HitboxButton.TextColor3 = Color3.fromRGB(255, 255, 255)
HitboxButton.Font = Enum.Font.Code
HitboxButton.TextSize = 20
HitboxButton.Parent = MainFrame


local ESPButton = Instance.new("TextButton")
ESPButton.Size = UDim2.new(0.8, 0, 0, 50)
ESPButton.Position = UDim2.new(0.1, 0, 0.35, 0)
ESPButton.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
ESPButton.BorderSizePixel = 0
ESPButton.Text = "ESP: OFF"
ESPButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ESPButton.Font = Enum.Font.Code
ESPButton.TextSize = 20
ESPButton.Parent = MainFrame

local TracerButton = Instance.new("TextButton")
TracerButton.Size = UDim2.new(0.8, 0, 0, 50)
TracerButton.Position = UDim2.new(0.1, 0, 0.55, 0)
TracerButton.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
TracerButton.BorderSizePixel = 0
TracerButton.Text = "ESP Tracers: OFF"
TracerButton.TextColor3 = Color3.fromRGB(255, 255, 255)
TracerButton.Font = Enum.Font.Code
TracerButton.TextSize = 20
TracerButton.Parent = MainFrame


HitboxButton.MouseButton1Click:Connect(function()
    _G.Disabled = not _G.Disabled
    HitboxButton.Text = _G.Disabled and "Hitbox Expander: ON" or "Hitbox Expander: OFF"
end)


local colors = {BrickColor.new("Really red"), BrickColor.new("Lime green"), BrickColor.new("Really blue"), BrickColor.new("New Yeller")}
local colorIdx = 1
HitboxButton.MouseButton2Click:Connect(function()
    colorIdx = (colorIdx % #colors) + 1
    _G.HitboxColor = colors[colorIdx]
    HitboxButton.Text = "Color Changed!"
    task.wait(0.5)
    HitboxButton.Text = _G.Disabled and "Hitbox Expander: ON" or "Hitbox Expander: OFF"
end)

ESPButton.MouseButton1Click:Connect(function()
    _G.ESPEnabled = not _G.ESPEnabled
    ESPButton.Text = _G.ESPEnabled and "ESP: ON" or "ESP: OFF"
end)

TracerButton.MouseButton1Click:Connect(function()
    _G.TracersEnabled = not _G.TracersEnabled
    TracerButton.Text = _G.TracersEnabled and "ESP Tracers: ON" or "ESP Tracers: OFF"
end)


local tracers = {}
game:GetService('RunService').RenderStepped:Connect(function()

    if _G.Disabled then
        for i,v in next, Players:GetPlayers() do
            if v.Name ~= LocalPlayer.Name then
                pcall(function()
                    v.Character.HumanoidRootPart.Size = Vector3.new(_G.HeadSize, _G.HeadSize, _G.HeadSize)
                    v.Character.HumanoidRootPart.Transparency = 0.7
                    v.Character.HumanoidRootPart.BrickColor = _G.HitboxColor
                    v.Character.HumanoidRootPart.Material = "Neon"
                    v.Character.HumanoidRootPart.CanCollide = false
                end)
            end
        end
    else
        for i,v in next, Players:GetPlayers() do
            if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                pcall(function()
                    v.Character.HumanoidRootPart.Size = Vector3.new(2, 2, 1)
                    v.Character.HumanoidRootPart.Transparency = 1
                end)
            end
        end
    end
    

    for _, v in next, Players:GetPlayers() do
        if v ~= LocalPlayer and v.Character then
            local humanoid = v.Character:FindFirstChild("Humanoid")
            local hl = v.Character:FindFirstChild("EspHighlight") or Instance.new("Highlight", v.Character)
            hl.Name = "EspHighlight"
            hl.FillColor = Color3.fromRGB(255, 255, 255)
            hl.Enabled = _G.ESPEnabled and humanoid and humanoid.Health > 0
        end
    end
    

    for _, v in pairs(Players:GetPlayers()) do
        if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
            local humanoid = v.Character:FindFirstChild("Humanoid")
            
            if _G.TracersEnabled and humanoid and humanoid.Health > 0 then
                if not tracers[v.Name] then
                    tracers[v.Name] = Drawing.new("Line")
                    tracers[v.Name].Color = Color3.fromRGB(255, 255, 255)
                    tracers[v.Name].Thickness = 1
                end
                local pos, vis = workspace.CurrentCamera:WorldToViewportPoint(v.Character.HumanoidRootPart.Position)
                if vis then
                    tracers[v.Name].Visible = true
                    tracers[v.Name].From = Vector2.new(workspace.CurrentCamera.ViewportSize.X/2, workspace.CurrentCamera.ViewportSize.Y)
                    tracers[v.Name].To = Vector2.new(pos.X, pos.Y)
                else
                    tracers[v.Name].Visible = false
                end
            elseif tracers[v.Name] then
                tracers[v.Name]:Remove()
                tracers[v.Name] = nil
            end
        elseif tracers[v.Name] then
            tracers[v.Name]:Remove()
            tracers[v.Name] = nil
        end
    end
end)

local UserInputService = game:GetService("UserInputService")
local dragging, dragStart, startPos

MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
end)

UserInputService.InputBegan:Connect(function(input, gpe)
    if not gpe then
        if input.KeyCode == Enum.KeyCode.RightControl then
            ScreenGui.Enabled = not ScreenGui.Enabled
        elseif input.KeyCode == Enum.KeyCode.Z then
            _G.FOVEnabled = not _G.FOVEnabled
            workspace.CurrentCamera.FieldOfView = _G.FOVEnabled and 120 or 70
        end
    end
end)
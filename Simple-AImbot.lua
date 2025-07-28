local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

local FOV = 120
local AimbotEnabled = false
local TargetPlayer = nil

local circle = Drawing.new("Circle")
circle.Visible = false
circle.Radius = FOV
circle.Color = Color3.fromRGB(0, 255, 0)
circle.Thickness = 2
circle.NumSides = 100
circle.Filled = false
circle.Transparency = 0.8

local function isPlayerValid(player)
    local char = player.Character
    if char and char:FindFirstChild("Head") and char:FindFirstChild("Humanoid") then
        local humanoid = char.Humanoid
        if humanoid.Health > 0 and char.Head.Transparency < 1 then
            return true
        end
    end
    return false
end

local function getClosestPlayer()
    local closestPlayer = nil
    local shortestDistance = math.huge

    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and isPlayerValid(player) then
            local headPos, onScreen = workspace.CurrentCamera:WorldToScreenPoint(player.Character.Head.Position)
            if onScreen then
                local mousePos = Vector2.new(Mouse.X, Mouse.Y)
                local playerPos = Vector2.new(headPos.X, headPos.Y)
                local distance = (playerPos - mousePos).Magnitude

                if distance < FOV and distance < shortestDistance then
                    shortestDistance = distance
                    closestPlayer = player
                end
            end
        end
    end

    return closestPlayer
end

-- Notification à l'exécution
StarterGui:SetCore("SendNotification", {
    Title = "Aimbot | by @elh_rblx",
    Text = 'Appuie sur "Insert" pour activer / désactiver le aimbot. Grosse merde de fils de pute',
    Duration = 5
})

RunService.RenderStepped:Connect(function()
    circle.Position = Vector2.new(Mouse.X, Mouse.Y)
    circle.Visible = AimbotEnabled

    if AimbotEnabled then
        if not TargetPlayer or not isPlayerValid(TargetPlayer) then
            TargetPlayer = getClosestPlayer()
        end

        if TargetPlayer and TargetPlayer.Character then
            local head = TargetPlayer.Character:FindFirstChild("Head")
            if head then
                local camera = workspace.CurrentCamera
                local screenPos, onScreen = camera:WorldToScreenPoint(head.Position)

                if onScreen then
                    local deltaX = screenPos.X - Mouse.X
                    local deltaY = screenPos.Y - Mouse.Y
                    mousemoverel(deltaX, deltaY)
                else
                    TargetPlayer = nil
                end
            else
                TargetPlayer = nil
            end
        end
    else
        TargetPlayer = nil
        circle.Visible = false
    end
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.Insert then
        AimbotEnabled = not AimbotEnabled
        if not AimbotEnabled then
            TargetPlayer = nil
            circle.Visible = false
        end
    end
end)

-- 🔔 Système de Notifications Élégantes
-- Notifications modernes avec animations fluides

local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local SoundService = game:GetService("SoundService")

local Notifications = {}
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- 📦 Variables globales
local notificationGui = nil
local activeNotifications = {}
local maxNotifications = 5
local notificationCount = 0

-- 🎨 Types de notifications
local NotificationTypes = {
    Success = {
        color = Color3.fromRGB(46, 204, 113),
        icon = "✅",
        sound = "rbxasset://sounds/electronicpingshort.wav"
    },
    Error = {
        color = Color3.fromRGB(231, 76, 60),
        icon = "❌",
        sound = "rbxasset://sounds/Metal Click.mp3"
    },
    Warning = {
        color = Color3.fromRGB(241, 196, 15),
        icon = "⚠️",
        sound = "rbxasset://sounds/button_click.wav"
    },
    Info = {
        color = Color3.fromRGB(52, 152, 219),
        icon = "ℹ️",
        sound = "rbxasset://sounds/pop_hi.mp3"
    },
    Premium = {
        color = Color3.fromRGB(155, 89, 182),
        icon = "⭐",
        sound = "rbxasset://sounds/Collectible.mp3"
    }
}

-- 🏗️ Initialisation du système
function Notifications:Initialize()
    -- Créer le GUI principal pour les notifications
    notificationGui = Instance.new("ScreenGui")
    notificationGui.Name = "NotificationSystem"
    notificationGui.ResetOnSpawn = false
    notificationGui.Parent = playerGui
    
    -- Container pour les notifications
    local container = Instance.new("Frame")
    container.Name = "NotificationContainer"
    container.Size = UDim2.new(0, 350, 1, 0)
    container.Position = UDim2.new(1, -360, 0, 10)
    container.BackgroundTransparency = 1
    container.Parent = notificationGui
    
    -- Layout pour organiser les notifications
    local layout = Instance.new("UIListLayout")
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 10)
    layout.VerticalAlignment = Enum.VerticalAlignment.Top
    layout.Parent = container
    
    print("🔔 Système de notifications initialisé")
end

-- 📨 Créer une notification
function Notifications:Create(config)
    if notificationCount >= maxNotifications then
        self:RemoveOldest()
    end
    
    local notificationType = config.type or "Info"
    local typeData = NotificationTypes[notificationType] or NotificationTypes.Info
    
    notificationCount = notificationCount + 1
    local notificationId = "notification_" .. notificationCount
    
    -- Frame principale de la notification
    local notification = Instance.new("Frame")
    notification.Name = notificationId
    notification.Size = UDim2.new(1, 0, 0, 80)
    notification.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    notification.BorderSizePixel = 0
    notification.ClipsDescendants = true
    notification.Parent = notificationGui.NotificationContainer
    
    -- Coins arrondis
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = notification
    
    -- Barre colorée sur le côté
    local colorBar = Instance.new("Frame")
    colorBar.Name = "ColorBar"
    colorBar.Size = UDim2.new(0, 4, 1, 0)
    colorBar.Position = UDim2.new(0, 0, 0, 0)
    colorBar.BackgroundColor3 = typeData.color
    colorBar.BorderSizePixel = 0
    colorBar.Parent = notification
    
    local colorBarCorner = Instance.new("UICorner")
    colorBarCorner.CornerRadius = UDim.new(0, 2)
    colorBarCorner.Parent = colorBar
    
    -- Icône de la notification
    local icon = Instance.new("TextLabel")
    icon.Name = "Icon"
    icon.Size = UDim2.new(0, 30, 0, 30)
    icon.Position = UDim2.new(0, 15, 0, 10)
    icon.BackgroundTransparency = 1
    icon.Text = typeData.icon
    icon.TextColor3 = typeData.color
    icon.TextScaled = true
    icon.Font = Enum.Font.GothamBold
    icon.Parent = notification
    
    -- Titre de la notification
    local title = Instance.new("TextLabel")
    title.Name = "Title"
    title.Size = UDim2.new(1, -90, 0, 25)
    title.Position = UDim2.new(0, 55, 0, 8)
    title.BackgroundTransparency = 1
    title.Text = config.title or "Notification"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextScaled = true
    title.Font = Enum.Font.GothamBold
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = notification
    
    -- Message de la notification
    local message = Instance.new("TextLabel")
    message.Name = "Message"
    message.Size = UDim2.new(1, -90, 0, 40)
    message.Position = UDim2.new(0, 55, 0, 32)
    message.BackgroundTransparency = 1
    message.Text = config.message or "Message de notification"
    message.TextColor3 = Color3.fromRGB(200, 200, 200)
    message.TextScaled = true
    message.Font = Enum.Font.Gotham
    message.TextXAlignment = Enum.TextXAlignment.Left
    message.TextWrapped = true
    message.Parent = notification
    
    -- Bouton de fermeture
    local closeBtn = Instance.new("TextButton")
    closeBtn.Name = "CloseButton"
    closeBtn.Size = UDim2.new(0, 20, 0, 20)
    closeBtn.Position = UDim2.new(1, -25, 0, 5)
    closeBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
    closeBtn.BorderSizePixel = 0
    closeBtn.Text = "✕"
    closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeBtn.TextScaled = true
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.Parent = notification
    
    local closeBtnCorner = Instance.new("UICorner")
    closeBtnCorner.CornerRadius = UDim.new(0, 10)
    closeBtnCorner.Parent = closeBtn
    
    -- Barre de progression (temps restant)
    local progressBar = Instance.new("Frame")
    progressBar.Name = "ProgressBar"
    progressBar.Size = UDim2.new(1, 0, 0, 2)
    progressBar.Position = UDim2.new(0, 0, 1, -2)
    progressBar.BackgroundColor3 = typeData.color
    progressBar.BorderSizePixel = 0
    progressBar.Parent = notification
    
    -- Animation d'entrée
    self:AnimateIn(notification)
    
    -- Jouer le son
    if config.sound ~= false then
        self:PlayNotificationSound(typeData.sound)
    end
    
    -- Gestion de la fermeture automatique
    local duration = config.duration or 5
    local startTime = tick()
    
    -- Animation de la barre de progression
    local progressTween = TweenService:Create(
        progressBar,
        TweenInfo.new(duration, Enum.EasingStyle.Linear),
        {Size = UDim2.new(0, 0, 0, 2)}
    )
    progressTween:Play()
    
    -- Fermeture automatique
    spawn(function()
        wait(duration)
        if notification.Parent then
            self:Remove(notificationId)
        end
    end)
    
    -- Événement du bouton de fermeture
    closeBtn.MouseButton1Click:Connect(function()
        self:Remove(notificationId)
    end)
    
    -- Effets hover pour le bouton de fermeture
    closeBtn.MouseEnter:Connect(function()
        TweenService:Create(closeBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(80, 80, 90)}):Play()
    end)
    
    closeBtn.MouseLeave:Connect(function()
        TweenService:Create(closeBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60, 60, 70)}):Play()
    end)
    
    -- Ajouter à la liste des notifications actives
    activeNotifications[notificationId] = notification
    
    return notificationId
end

-- ✨ Animation d'entrée
function Notifications:AnimateIn(notification)
    -- Position initiale (hors écran)
    local originalPosition = notification.Position
    notification.Position = UDim2.new(originalPosition.X.Scale + 1, originalPosition.X.Offset, originalPosition.Y.Scale, originalPosition.Y.Offset)
    notification.Transparency = 1
    
    -- Animation de glissement
    local slideTween = TweenService:Create(
        notification,
        TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
        {Position = originalPosition}
    )
    
    -- Animation de fondu
    local fadeTween = TweenService:Create(
        notification,
        TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {Transparency = 0}
    )
    
    slideTween:Play()
    fadeTween:Play()
    
    -- Animation des enfants
    for _, child in ipairs(notification:GetChildren()) do
        if child:IsA("GuiObject") then
            child.Transparency = 1
            TweenService:Create(
                child,
                TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {Transparency = 0}
            ):Play()
        end
    end
end

-- 🌙 Animation de sortie
function Notifications:AnimateOut(notification, callback)
    local slideTween = TweenService:Create(
        notification,
        TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In),
        {Position = UDim2.new(1.5, 0, notification.Position.Y.Scale, notification.Position.Y.Offset)}
    )
    
    local fadeTween = TweenService:Create(
        notification,
        TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {Transparency = 1}
    )
    
    slideTween:Play()
    fadeTween:Play()
    
    slideTween.Completed:Connect(function()
        if callback then callback() end
    end)
end

-- 🗑️ Supprimer une notification
function Notifications:Remove(notificationId)
    local notification = activeNotifications[notificationId]
    if not notification then return end
    
    self:AnimateOut(notification, function()
        notification:Destroy()
        activeNotifications[notificationId] = nil
    end)
end

-- 🧹 Supprimer la plus ancienne notification
function Notifications:RemoveOldest()
    for id, notification in pairs(activeNotifications) do
        self:Remove(id)
        break
    end
end

-- 🔊 Jouer un son de notification
function Notifications:PlayNotificationSound(soundId)
    local sound = Instance.new("Sound")
    sound.SoundId = soundId
    sound.Volume = 0.5
    sound.Parent = SoundService
    sound:Play()
    
    sound.Ended:Connect(function()
        sound:Destroy()
    end)
end

-- 📢 Fonctions rapides pour chaque type
function Notifications:Success(title, message, duration)
    return self:Create({
        type = "Success",
        title = title,
        message = message,
        duration = duration
    })
end

function Notifications:Error(title, message, duration)
    return self:Create({
        type = "Error",
        title = title,
        message = message,
        duration = duration
    })
end

function Notifications:Warning(title, message, duration)
    return self:Create({
        type = "Warning",
        title = title,
        message = message,
        duration = duration
    })
end

function Notifications:Info(title, message, duration)
    return self:Create({
        type = "Info",
        title = title,
        message = message,
        duration = duration
    })
end

function Notifications:Premium(title, message, duration)
    return self:Create({
        type = "Premium",
        title = title,
        message = message,
        duration = duration
    })
end

-- 🧽 Nettoyer toutes les notifications
function Notifications:Clear()
    for id, _ in pairs(activeNotifications) do
        self:Remove(id)
    end
end

return Notifications

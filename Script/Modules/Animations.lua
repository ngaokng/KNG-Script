-- 🎬 Système d'animations pour l'interface Roblox
-- Animations fluides et transitions élégantes

local TweenService = game:GetService("TweenService")
local Animations = {}

-- 📐 Informations par défaut pour les animations
local DefaultTweenInfo = TweenInfo.new(
    0.3,                           -- Durée
    Enum.EasingStyle.Quad,         -- Style d'animation
    Enum.EasingDirection.Out,      -- Direction
    0,                             -- Répétitions
    false,                         -- Reverse
    0                              -- Délai
)

-- ✨ Animation d'apparition (Fade In)
function Animations:FadeIn(object, duration)
    duration = duration or 0.3
    object.Transparency = 1
    
    local tween = TweenService:Create(
        object,
        TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {Transparency = 0}
    )
    
    tween:Play()
    return tween
end

-- 🌙 Animation de disparition (Fade Out)
function Animations:FadeOut(object, duration)
    duration = duration or 0.3
    
    local tween = TweenService:Create(
        object,
        TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {Transparency = 1}
    )
    
    tween:Play()
    return tween
end

-- 📈 Animation de glissement depuis le haut
function Animations:SlideFromTop(object, distance, duration)
    distance = distance or 50
    duration = duration or 0.4
    
    local originalPosition = object.Position
    object.Position = UDim2.new(
        originalPosition.X.Scale,
        originalPosition.X.Offset,
        originalPosition.Y.Scale,
        originalPosition.Y.Offset - distance
    )
    
    local tween = TweenService:Create(
        object,
        TweenInfo.new(duration, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
        {Position = originalPosition}
    )
    
    tween:Play()
    return tween
end

-- 🎯 Animation de scale (agrandissement/rétrécissement)
function Animations:ScaleBounce(object, scale, duration)
    scale = scale or 1.1
    duration = duration or 0.2
    
    local originalSize = object.Size
    
    local scaleUp = TweenService:Create(
        object,
        TweenInfo.new(duration/2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {Size = UDim2.new(originalSize.X.Scale * scale, 0, originalSize.Y.Scale * scale, 0)}
    )
    
    local scaleDown = TweenService:Create(
        object,
        TweenInfo.new(duration/2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {Size = originalSize}
    )
    
    scaleUp:Play()
    scaleUp.Completed:Connect(function()
        scaleDown:Play()
    end)
    
    return {scaleUp, scaleDown}
end

-- 🌈 Animation de changement de couleur
function Animations:ColorTransition(object, targetColor, duration)
    duration = duration or 0.3
    
    local tween = TweenService:Create(
        object,
        TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {BackgroundColor3 = targetColor}
    )
    
    tween:Play()
    return tween
end

-- 🔄 Animation de rotation
function Animations:Rotate(object, rotation, duration)
    rotation = rotation or 360
    duration = duration or 1
    
    local tween = TweenService:Create(
        object,
        TweenInfo.new(duration, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut),
        {Rotation = object.Rotation + rotation}
    )
    
    tween:Play()
    return tween
end

-- 💫 Animation de pulsation
function Animations:Pulse(object, intensity, duration)
    intensity = intensity or 0.1
    duration = duration or 1
    
    local originalTransparency = object.Transparency
    
    local pulseIn = TweenService:Create(
        object,
        TweenInfo.new(duration/2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
        {Transparency = originalTransparency + intensity}
    )
    
    local pulseOut = TweenService:Create(
        object,
        TweenInfo.new(duration/2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
        {Transparency = originalTransparency}
    )
    
    pulseIn:Play()
    pulseIn.Completed:Connect(function()
        pulseOut:Play()
    end)
    
    return {pulseIn, pulseOut}
end

-- 🎪 Animation de rebond élastique
function Animations:ElasticBounce(object, targetPosition, duration)
    duration = duration or 0.6
    
    local tween = TweenService:Create(
        object,
        TweenInfo.new(duration, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out),
        {Position = targetPosition}
    )
    
    tween:Play()
    return tween
end

-- 🌊 Animation de vague (pour les effets de texte)
function Animations:TextWave(textLabel, duration)
    duration = duration or 2
    
    local originalText = textLabel.Text
    local chars = {}
    
    for i = 1, #originalText do
        chars[i] = originalText:sub(i, i)
    end
    
    spawn(function()
        for cycle = 1, 3 do -- 3 cycles de vague
            for i = 1, #chars do
                textLabel.Text = originalText:sub(1, i-1) .. chars[i]:upper() .. originalText:sub(i+1)
                wait(duration / #chars / 3)
                textLabel.Text = originalText
                wait(0.05)
            end
        end
    end)
end

-- 🎬 Animation combinée pour l'ouverture de menu
function Animations:MenuOpen(menuFrame)
    menuFrame.Transparency = 1
    menuFrame.Size = UDim2.new(0, 0, 0, 0)
    
    -- Animation de taille
    local sizeTween = TweenService:Create(
        menuFrame,
        TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
        {Size = UDim2.new(0, 400, 0, 500)}
    )
    
    -- Animation de transparence
    local fadeTween = TweenService:Create(
        menuFrame,
        TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {Transparency = 0}
    )
    
    sizeTween:Play()
    fadeTween:Play()
    
    return {sizeTween, fadeTween}
end

-- 🎭 Animation pour fermeture de menu
function Animations:MenuClose(menuFrame, callback)
    local sizeTween = TweenService:Create(
        menuFrame,
        TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In),
        {Size = UDim2.new(0, 0, 0, 0)}
    )
    
    local fadeTween = TweenService:Create(
        menuFrame,
        TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {Transparency = 1}
    )
    
    sizeTween:Play()
    fadeTween:Play()
    
    if callback then
        sizeTween.Completed:Connect(callback)
    end
    
    return {sizeTween, fadeTween}
end

return Animations

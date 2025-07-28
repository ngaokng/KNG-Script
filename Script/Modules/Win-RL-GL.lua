-- 🏆 Win-RL-GL Module
-- Module avancé pour fonctionnalités spéciales

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local WinRLGL = {}
local player = Players.LocalPlayer

-- 🎯 Variables globales
local isActive = false
local connections = {}

-- 🎨 Configuration du module
local Config = {
    EnableEffects = true,
    EffectIntensity = 1.0,
    VisualTheme = "Modern",
    SoundEnabled = true
}

-- ✨ Système d'effets visuels
function WinRLGL:CreateParticleEffect(parent, config)
    config = config or {}
    
    local particleFrame = Instance.new("Frame")
    particleFrame.Name = "ParticleEffect"
    particleFrame.Size = UDim2.new(1, 0, 1, 0)
    particleFrame.Position = UDim2.new(0, 0, 0, 0)
    particleFrame.BackgroundTransparency = 1
    particleFrame.Parent = parent
    
    -- Créer des particules animées
    for i = 1, (config.count or 20) do
        local particle = Instance.new("Frame")
        particle.Size = UDim2.new(0, math.random(2, 6), 0, math.random(2, 6))
        particle.Position = UDim2.new(math.random(), 0, math.random(), 0)
        particle.BackgroundColor3 = config.color or Color3.fromRGB(0, 162, 255)
        particle.BorderSizePixel = 0
        particle.Parent = particleFrame
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(1, 0)
        corner.Parent = particle
        
        -- Animation flottante
        spawn(function()
            while particle.Parent do
                local randomX = math.random(-50, 50) / 1000
                local randomY = math.random(-50, 50) / 1000
                
                TweenService:Create(
                    particle,
                    TweenInfo.new(
                        math.random(20, 40) / 10,
                        Enum.EasingStyle.Sine,
                        Enum.EasingDirection.InOut,
                        -1,
                        true
                    ),
                    {
                        Position = UDim2.new(
                            particle.Position.X.Scale + randomX,
                            0,
                            particle.Position.Y.Scale + randomY,
                            0
                        ),
                        Transparency = math.random(30, 70) / 100
                    }
                ):Play()
                
                wait(math.random(10, 30) / 10)
            end
        end)
    end
    
    return particleFrame
end

-- 🌟 Système de gradient animé
function WinRLGL:CreateAnimatedGradient(object, colors, duration)
    colors = colors or {
        Color3.fromRGB(0, 162, 255),
        Color3.fromRGB(155, 89, 182),
        Color3.fromRGB(46, 204, 113)
    }
    duration = duration or 3
    
    local gradient = Instance.new("UIGradient")
    gradient.Parent = object
    
    spawn(function()
        local colorIndex = 1
        while gradient.Parent do
            local nextIndex = colorIndex % #colors + 1
            
            TweenService:Create(
                gradient,
                TweenInfo.new(duration, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
                {
                    Color = ColorSequence.new{
                        ColorSequenceKeypoint.new(0, colors[colorIndex]),
                        ColorSequenceKeypoint.new(0.5, colors[nextIndex]),
                        ColorSequenceKeypoint.new(1, colors[(nextIndex % #colors) + 1])
                    }
                }
            ):Play()
            
            colorIndex = nextIndex
            wait(duration)
        end
    end)
    
    return gradient
end

-- 🎭 Système de thèmes dynamiques
function WinRLGL:ApplyTheme(container, themeName)
    local themes = {
        Neon = {
            primary = Color3.fromRGB(0, 255, 255),
            secondary = Color3.fromRGB(255, 0, 255),
            background = Color3.fromRGB(10, 10, 15),
            accent = Color3.fromRGB(255, 255, 0),
            glowEnabled = true
        },
        
        Dark = {
            primary = Color3.fromRGB(45, 45, 55),
            secondary = Color3.fromRGB(35, 35, 45),
            background = Color3.fromRGB(20, 20, 25),
            accent = Color3.fromRGB(0, 162, 255),
            glowEnabled = false
        },
        
        Ocean = {
            primary = Color3.fromRGB(52, 152, 219),
            secondary = Color3.fromRGB(26, 188, 156),
            background = Color3.fromRGB(15, 32, 39),
            accent = Color3.fromRGB(46, 204, 113),
            glowEnabled = true
        },
        
        Sunset = {
            primary = Color3.fromRGB(255, 94, 77),
            secondary = Color3.fromRGB(255, 154, 0),
            background = Color3.fromRGB(40, 20, 10),
            accent = Color3.fromRGB(255, 206, 84),
            glowEnabled = true
        }
    }
    
    local theme = themes[themeName] or themes.Dark
    
    -- Appliquer le thème récursivement
    local function applyToObject(obj)
        if obj:IsA("Frame") then
            TweenService:Create(
                obj,
                TweenInfo.new(0.5, Enum.EasingStyle.Quad),
                {BackgroundColor3 = theme.background}
            ):Play()
            
            if theme.glowEnabled then
                self:AddGlowEffect(obj, theme.accent)
            end
        elseif obj:IsA("TextButton") then
            TweenService:Create(
                obj,
                TweenInfo.new(0.5, Enum.EasingStyle.Quad),
                {BackgroundColor3 = theme.primary}
            ):Play()
        elseif obj:IsA("TextLabel") then
            TweenService:Create(
                obj,
                TweenInfo.new(0.5, Enum.EasingStyle.Quad),
                {TextColor3 = Color3.fromRGB(255, 255, 255)}
            ):Play()
        end
        
        for _, child in ipairs(obj:GetChildren()) do
            applyToObject(child)
        end
    end
    
    applyToObject(container)
    print("🎨 Thème appliqué: " .. themeName)
end

-- 💡 Effet de lueur (glow)
function WinRLGL:AddGlowEffect(object, color)
    color = color or Color3.fromRGB(0, 162, 255)
    
    local glow = Instance.new("ImageLabel")
    glow.Name = "GlowEffect"
    glow.Size = UDim2.new(1, 20, 1, 20)
    glow.Position = UDim2.new(0, -10, 0, -10)
    glow.BackgroundTransparency = 1
    glow.Image = "rbxasset://textures/ui/Glow.png"
    glow.ImageColor3 = color
    glow.ImageTransparency = 0.5
    glow.ZIndex = object.ZIndex - 1
    glow.Parent = object.Parent
    
    -- Animation de pulsation
    spawn(function()
        while glow.Parent do
            TweenService:Create(
                glow,
                TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true),
                {ImageTransparency = 0.8}
            ):Play()
            wait(2)
        end
    end)
    
    return glow
end

-- 🎪 Effet de typing animation pour le texte
function WinRLGL:TypeWriter(textLabel, fullText, speed)
    speed = speed or 0.05
    textLabel.Text = ""
    
    spawn(function()
        for i = 1, #fullText do
            textLabel.Text = fullText:sub(1, i)
            wait(speed)
        end
    end)
end

-- 🌊 Effet de vague sur les boutons
function WinRLGL:CreateWaveEffect(button)
    button.ClipsDescendants = true
    
    button.MouseButton1Click:Connect(function()
        local wave = Instance.new("Frame")
        wave.Size = UDim2.new(0, 0, 0, 0)
        wave.Position = UDim2.new(0.5, 0, 0.5, 0)
        wave.AnchorPoint = Vector2.new(0.5, 0.5)
        wave.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        wave.BackgroundTransparency = 0.5
        wave.BorderSizePixel = 0
        wave.Parent = button
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(1, 0)
        corner.Parent = wave
        
        -- Animation de la vague
        TweenService:Create(
            wave,
            TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {
                Size = UDim2.new(2, 0, 2, 0),
                BackgroundTransparency = 1
            }
        ):Play()
        
        -- Nettoyer après l'animation
        spawn(function()
            wait(0.6)
            wave:Destroy()
        end)
    end)
end

-- 🎯 Système de focus avec highlight
function WinRLGL:CreateFocusHighlight(object, color)
    color = color or Color3.fromRGB(0, 162, 255)
    
    local highlight = Instance.new("UIStroke")
    highlight.Color = color
    highlight.Thickness = 0
    highlight.Transparency = 1
    highlight.Parent = object
    
    -- Événements de focus
    if object:IsA("TextButton") or object:IsA("TextBox") then
        object.MouseEnter:Connect(function()
            TweenService:Create(
                highlight,
                TweenInfo.new(0.3, Enum.EasingStyle.Quad),
                {Thickness = 2, Transparency = 0}
            ):Play()
        end)
        
        object.MouseLeave:Connect(function()
            TweenService:Create(
                highlight,
                TweenInfo.new(0.3, Enum.EasingStyle.Quad),
                {Thickness = 0, Transparency = 1}
            ):Play()
        end)
    end
    
    return highlight
end

-- 🔄 Loader avec animation circulaire
function WinRLGL:CreateLoader(parent, size)
    size = size or UDim2.new(0, 50, 0, 50)
    
    local loader = Instance.new("Frame")
    loader.Name = "Loader"
    loader.Size = size
    loader.AnchorPoint = Vector2.new(0.5, 0.5)
    loader.Position = UDim2.new(0.5, 0, 0.5, 0)
    loader.BackgroundTransparency = 1
    loader.Parent = parent
    
    -- Cercle de chargement
    local circle = Instance.new("ImageLabel")
    circle.Size = UDim2.new(1, 0, 1, 0)
    circle.BackgroundTransparency = 1
    circle.Image = "rbxasset://textures/ui/CircularProgressBar.png"
    circle.ImageColor3 = Color3.fromRGB(0, 162, 255)
    circle.Parent = loader
    
    -- Animation de rotation
    spawn(function()
        while loader.Parent do
            TweenService:Create(
                circle,
                TweenInfo.new(1, Enum.EasingStyle.Linear),
                {Rotation = circle.Rotation + 360}
            ):Play()
            wait(1)
        end
    end)
    
    return loader
end

-- 🎵 Système de feedback sonore
function WinRLGL:PlayUISound(soundType)
    if not Config.SoundEnabled then return end
    
    local sounds = {
        click = "rbxasset://sounds/button_click.wav",
        hover = "rbxasset://sounds/button_hover.wav",
        success = "rbxasset://sounds/electronicpingshort.wav",
        error = "rbxasset://sounds/Metal Click.mp3"
    }
    
    local soundId = sounds[soundType]
    if soundId then
        local sound = Instance.new("Sound")
        sound.SoundId = soundId
        sound.Volume = 0.3
        sound.Parent = game:GetService("SoundService")
        sound:Play()
        
        sound.Ended:Connect(function()
            sound:Destroy()
        end)
    end
end

-- 🎮 Initialisation du module
function WinRLGL:Initialize()
    isActive = true
    print("🏆 Module Win-RL-GL initialisé")
    
    -- Configuration des raccourcis
    connections[#connections + 1] = UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        
        if input.KeyCode == Enum.KeyCode.F1 then
            self:ToggleEffects()
        elseif input.KeyCode == Enum.KeyCode.F2 then
            self:CycleTheme()
        end
    end)
end

-- 🔧 Basculer les effets
function WinRLGL:ToggleEffects()
    Config.EnableEffects = not Config.EnableEffects
    print("✨ Effets " .. (Config.EnableEffects and "activés" or "désactivés"))
end

-- 🎨 Changer de thème
function WinRLGL:CycleTheme()
    local themes = {"Dark", "Neon", "Ocean", "Sunset"}
    local currentIndex = 1
    
    for i, theme in ipairs(themes) do
        if Config.VisualTheme == theme then
            currentIndex = i
            break
        end
    end
    
    local nextIndex = (currentIndex % #themes) + 1
    Config.VisualTheme = themes[nextIndex]
    
    print("🎭 Thème changé vers: " .. Config.VisualTheme)
end

-- 🧹 Nettoyage du module
function WinRLGL:Cleanup()
    isActive = false
    
    for _, connection in ipairs(connections) do
        connection:Disconnect()
    end
    connections = {}
    
    print("🧹 Module Win-RL-GL nettoyé")
end

return WinRLGL

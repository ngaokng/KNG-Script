-- 🚀 LOADER PRINCIPAL - Interface Moderne Roblox
-- Script principal qui charge tous les modules automatiquement
-- Usage: loadstring(game:HttpGet("URL_DU_SCRIPT"))()

local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

-- 📦 Variables globales
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local isLoaded = false

-- 🎨 Configuration du loader
local LoaderConfig = {
    Version = "1.0.0",
    Author = "Script Creator",
    LoadingMessages = {
        "🔄 Initialisation des modules...",
        "🎨 Chargement des thèmes...",
        "🔔 Configuration des notifications...",
        "✨ Application des animations...",
        "🎯 Finalisation de l'interface...",
        "🚀 Interface prête!"
    }
}

-- 📁 URLs des modules (à remplacer par vos URLs GitHub)
local ModuleURLs = {
    Settings = "https://raw.githubusercontent.com/username/repo/main/Config/Settings.lua",
    Animations = "https://raw.githubusercontent.com/username/repo/main/Script/Modules/Animations.lua",
    Menu = "https://raw.githubusercontent.com/username/repo/main/Script/Modules/Menu.lua",
    Notifications = "https://raw.githubusercontent.com/username/repo/main/Script/Modules/Notifications.lua",
    WinRLGL = "https://raw.githubusercontent.com/username/repo/main/Script/Modules/Win-RL-GL.lua"
}

-- 🎬 Création de l'écran de chargement
local function createLoadingScreen()
    local loadingGui = Instance.new("ScreenGui")
    loadingGui.Name = "LoadingScreen"
    loadingGui.ResetOnSpawn = false
    loadingGui.Parent = playerGui
    
    -- Arrière-plan sombre
    local background = Instance.new("Frame")
    background.Name = "Background"
    background.Size = UDim2.new(1, 0, 1, 0)
    background.Position = UDim2.new(0, 0, 0, 0)
    background.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
    background.BorderSizePixel = 0
    background.Parent = loadingGui
    
    -- Container principal du loader
    local container = Instance.new("Frame")
    container.Name = "LoaderContainer"
    container.Size = UDim2.new(0, 400, 0, 200)
    container.Position = UDim2.new(0.5, -200, 0.5, -100)
    container.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    container.BorderSizePixel = 0
    container.Parent = background
    
    local containerCorner = Instance.new("UICorner")
    containerCorner.CornerRadius = UDim.new(0, 15)
    containerCorner.Parent = container
    
    -- Logo/Titre
    local logo = Instance.new("TextLabel")
    logo.Name = "Logo"
    logo.Size = UDim2.new(1, -40, 0, 50)
    logo.Position = UDim2.new(0, 20, 0, 20)
    logo.BackgroundTransparency = 1
    logo.Text = "🚀 MODERN GUI LOADER"
    logo.TextColor3 = Color3.fromRGB(0, 162, 255)
    logo.TextScaled = true
    logo.Font = Enum.Font.GothamBold
    logo.Parent = container
    
    -- Message de chargement
    local loadingMessage = Instance.new("TextLabel")
    loadingMessage.Name = "LoadingMessage"
    loadingMessage.Size = UDim2.new(1, -40, 0, 30)
    loadingMessage.Position = UDim2.new(0, 20, 0, 80)
    loadingMessage.BackgroundTransparency = 1
    loadingMessage.Text = "🔄 Initialisation..."
    loadingMessage.TextColor3 = Color3.fromRGB(255, 255, 255)
    loadingMessage.TextScaled = true
    loadingMessage.Font = Enum.Font.Gotham
    loadingMessage.Parent = container
    
    -- Barre de progression
    local progressContainer = Instance.new("Frame")
    progressContainer.Name = "ProgressContainer"
    progressContainer.Size = UDim2.new(1, -40, 0, 20)
    progressContainer.Position = UDim2.new(0, 20, 0, 130)
    progressContainer.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    progressContainer.BorderSizePixel = 0
    progressContainer.Parent = container
    
    local progressCorner = Instance.new("UICorner")
    progressCorner.CornerRadius = UDim.new(0, 10)
    progressCorner.Parent = progressContainer
    
    local progressBar = Instance.new("Frame")
    progressBar.Name = "ProgressBar"
    progressBar.Size = UDim2.new(0, 0, 1, 0)
    progressBar.Position = UDim2.new(0, 0, 0, 0)
    progressBar.BackgroundColor3 = Color3.fromRGB(0, 162, 255)
    progressBar.BorderSizePixel = 0
    progressBar.Parent = progressContainer
    
    local progressBarCorner = Instance.new("UICorner")
    progressBarCorner.CornerRadius = UDim.new(0, 10)
    progressBarCorner.Parent = progressBar
    
    -- Pourcentage
    local percentage = Instance.new("TextLabel")
    percentage.Name = "Percentage"
    percentage.Size = UDim2.new(1, -40, 0, 25)
    percentage.Position = UDim2.new(0, 20, 0, 160)
    percentage.BackgroundTransparency = 1
    percentage.Text = "0%"
    percentage.TextColor3 = Color3.fromRGB(180, 180, 180)
    percentage.TextScaled = true
    percentage.Font = Enum.Font.Gotham
    percentage.Parent = container
    
    -- Animation d'entrée
    container.Transparency = 1
    TweenService:Create(
        container,
        TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
        {Transparency = 0}
    ):Play()
    
    return loadingGui, loadingMessage, progressBar, percentage
end

-- 📥 Fonction de chargement des modules
local function loadModule(url, moduleName)
    local success, result = pcall(function()
        if url:match("^https://") then
            -- Chargement depuis une URL
            return loadstring(game:HttpGet(url))()
        else
            -- Chargement local (pour les tests)
            return loadstring(url)()
        end
    end)
    
    if success then
        print("✅ Module " .. moduleName .. " chargé avec succès")
        return result
    else
        warn("❌ Erreur lors du chargement de " .. moduleName .. ": " .. tostring(result))
        return nil
    end
end

-- 🎯 Fonction principale de chargement
local function loadInterface()
    if isLoaded then
        print("⚠️ Interface déjà chargée!")
        return
    end
    
    -- Créer l'écran de chargement
    local loadingGui, loadingMessage, progressBar, percentage = createLoadingScreen()
    
    -- Variables pour les modules
    local Settings, Animations, Menu, Notifications, WinRLGL
    local loadedModules = 0
    local totalModules = 5
    
    -- Fonction de mise à jour du progress
    local function updateProgress(step, message)
        loadedModules = step
        local progress = loadedModules / totalModules
        
        -- Mettre à jour le message
        loadingMessage.Text = message or LoaderConfig.LoadingMessages[step] or "Chargement..."
        
        -- Animer la barre de progression
        TweenService:Create(
            progressBar,
            TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {Size = UDim2.new(progress, 0, 1, 0)}
        ):Play()
        
        -- Mettre à jour le pourcentage
        percentage.Text = math.floor(progress * 100) .. "%"
        
        wait(0.3) -- Délai pour l'animation
    end
    
    -- 1. Charger les paramètres
    updateProgress(1, LoaderConfig.LoadingMessages[1])
    Settings = loadModule([[
        -- Code du module Settings.lua ici (version locale pour test)
        local Settings = {}
        Settings.Theme = {
            Primary = Color3.fromRGB(45, 45, 55),
            Accent = Color3.fromRGB(0, 162, 255)
        }
        return Settings
    ]], "Settings")
    
    -- 2. Charger les animations
    updateProgress(2, LoaderConfig.LoadingMessages[2])
    Animations = loadModule(ModuleURLs.Animations, "Animations")
    
    -- 3. Charger le menu
    updateProgress(3, LoaderConfig.LoadingMessages[3])
    Menu = loadModule(ModuleURLs.Menu, "Menu")
    
    -- 4. Charger les notifications
    updateProgress(4, LoaderConfig.LoadingMessages[4])
    Notifications = loadModule(ModuleURLs.Notifications, "Notifications")
    
    -- 5. Charger Win-RL-GL
    updateProgress(5, LoaderConfig.LoadingMessages[5])
    WinRLGL = loadModule(ModuleURLs.WinRLGL, "Win-RL-GL")
    
    -- Finalisation
    updateProgress(6, LoaderConfig.LoadingMessages[6])
    
    -- Initialiser tous les modules
    spawn(function()
        wait(1) -- Attendre que le chargement soit terminé
        
        -- Fermer l'écran de chargement
        TweenService:Create(
            loadingGui,
            TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {BackgroundTransparency = 1}
        ):Play()
        
        wait(0.5)
        loadingGui:Destroy()
        
        -- Initialiser les modules si ils ont été chargés
        if Notifications then
            Notifications:Initialize()
            
            -- Notification de bienvenue
            Notifications:Success(
                "🎉 Interface Chargée!",
                "Tous les modules ont été chargés avec succès. Appuyez sur INSERT pour ouvrir le menu.",
                5
            )
        end
        
        if Menu then
            Menu:Initialize()
        end
        
        if WinRLGL then
            WinRLGL:Initialize()
        end
        
        -- Raccourci pour ouvrir le menu
        UserInputService.InputBegan:Connect(function(input, gameProcessed)
            if gameProcessed then return end
            
            if input.KeyCode == Enum.KeyCode.Insert and Menu then
                Menu:Toggle()
            end
        end)
        
        isLoaded = true
        print("🎉 Interface complètement chargée et prête à l'utilisation!")
        print("📋 Commandes:")
        print("   INSERT - Ouvrir/Fermer le menu")
        print("   F1 - Basculer les effets")
        print("   F2 - Changer de thème")
    end)
end

-- 🔒 Protection contre les rechargements multiples
if playerGui:FindFirstChild("LoadingScreen") or playerGui:FindFirstChild("ModernMenuGUI") then
    -- Interface déjà présente, nettoyer d'abord
    local existingScreens = {
        playerGui:FindFirstChild("LoadingScreen"),
        playerGui:FindFirstChild("ModernMenuGUI"),
        playerGui:FindFirstChild("NotificationSystem")
    }
    
    for _, screen in ipairs(existingScreens) do
        if screen then
            screen:Destroy()
        end
    end
    
    wait(0.5) -- Attendre le nettoyage
end

-- 🚀 Lancement automatique
print("🔥 Démarrage du Modern GUI Loader v" .. LoaderConfig.Version)
print("👤 Créé par: " .. LoaderConfig.Author)
print("⏳ Chargement en cours...")

loadInterface()

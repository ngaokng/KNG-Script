-- 🍔 Menu Principal avec Navigation
-- Interface moderne et intuitive

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")

local Menu = {}
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- 📦 Variables globales
local mainFrame = nil
local isMenuOpen = false
local currentTab = "Home"

-- 🎨 Configuration du style
local function createMenuFrame()
    -- Création du GUI principal
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "ModernMenuGUI"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = playerGui
    
    -- Frame principale du menu
    mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainMenu"
    mainFrame.Size = UDim2.new(0, 450, 0, 550)
    mainFrame.Position = UDim2.new(0.5, -225, 0.5, -275)
    mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    mainFrame.BorderSizePixel = 0
    mainFrame.Active = true
    mainFrame.Draggable = true
    mainFrame.Parent = screenGui
    
    -- Coins arrondis
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = mainFrame
    
    -- Ombre portée
    local shadow = Instance.new("ImageLabel")
    shadow.Name = "Shadow"
    shadow.Size = UDim2.new(1, 20, 1, 20)
    shadow.Position = UDim2.new(0, -10, 0, -10)
    shadow.BackgroundTransparency = 1
    shadow.Image = "rbxasset://textures/ui/ShadowDropdown.png"
    shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    shadow.ImageTransparency = 0.5
    shadow.ScaleType = Enum.ScaleType.Slice
    shadow.SliceCenter = Rect.new(10, 10, 10, 10)
    shadow.ZIndex = mainFrame.ZIndex - 1
    shadow.Parent = mainFrame
    
    return screenGui
end

-- 🎯 Création de la barre de titre
local function createTitleBar()
    local titleBar = Instance.new("Frame")
    titleBar.Name = "TitleBar"
    titleBar.Size = UDim2.new(1, 0, 0, 50)
    titleBar.Position = UDim2.new(0, 0, 0, 0)
    titleBar.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    titleBar.BorderSizePixel = 0
    titleBar.Parent = mainFrame
    
    -- Coins arrondis pour la barre de titre
    local titleCorner = Instance.new("UICorner")
    titleCorner.CornerRadius = UDim.new(0, 12)
    titleCorner.Parent = titleBar
    
    -- Masquer les coins du bas
    local bottomCover = Instance.new("Frame")
    bottomCover.Size = UDim2.new(1, 0, 0, 12)
    bottomCover.Position = UDim2.new(0, 0, 1, -12)
    bottomCover.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    bottomCover.BorderSizePixel = 0
    bottomCover.Parent = titleBar
    
    -- Titre
    local title = Instance.new("TextLabel")
    title.Name = "Title"
    title.Size = UDim2.new(1, -100, 1, 0)
    title.Position = UDim2.new(0, 15, 0, 0)
    title.BackgroundTransparency = 1
    title.Text = "🚀 Modern GUI"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextScaled = true
    title.Font = Enum.Font.GothamBold
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = titleBar
    
    -- Bouton de fermeture
    local closeBtn = Instance.new("TextButton")
    closeBtn.Name = "CloseButton"
    closeBtn.Size = UDim2.new(0, 40, 0, 40)
    closeBtn.Position = UDim2.new(1, -45, 0, 5)
    closeBtn.BackgroundColor3 = Color3.fromRGB(231, 76, 60)
    closeBtn.BorderSizePixel = 0
    closeBtn.Text = "✕"
    closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeBtn.TextScaled = true
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.Parent = titleBar
    
    local closeBtnCorner = Instance.new("UICorner")
    closeBtnCorner.CornerRadius = UDim.new(0, 8)
    closeBtnCorner.Parent = closeBtn
    
    -- Événement de fermeture
    closeBtn.MouseButton1Click:Connect(function()
        Menu:Close()
    end)
    
    -- Effet hover pour le bouton de fermeture
    closeBtn.MouseEnter:Connect(function()
        TweenService:Create(closeBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(255, 100, 100)}):Play()
    end)
    
    closeBtn.MouseLeave:Connect(function()
        TweenService:Create(closeBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(231, 76, 60)}):Play()
    end)
end

-- 🗂️ Création de la navigation par onglets
local function createNavigation()
    local navFrame = Instance.new("Frame")
    navFrame.Name = "Navigation"
    navFrame.Size = UDim2.new(0, 120, 1, -60)
    navFrame.Position = UDim2.new(0, 10, 0, 60)
    navFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    navFrame.BorderSizePixel = 0
    navFrame.Parent = mainFrame
    
    local navCorner = Instance.new("UICorner")
    navCorner.CornerRadius = UDim.new(0, 8)
    navCorner.Parent = navFrame
    
    -- Layout pour les boutons
    local layout = Instance.new("UIListLayout")
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 5)
    layout.Parent = navFrame
    
    local padding = Instance.new("UIPadding")
    padding.PaddingTop = UDim.new(0, 10)
    padding.PaddingLeft = UDim.new(0, 10)
    padding.PaddingRight = UDim.new(0, 10)
    padding.Parent = navFrame
    
    -- Onglets de navigation
    local tabs = {
        {name = "🏠 Home", id = "Home"},
        {name = "⚙️ Settings", id = "Settings"},
        {name = "🎨 Themes", id = "Themes"},
        {name = "🔧 Tools", id = "Tools"},
        {name = "📊 Stats", id = "Stats"},
        {name = "ℹ️ About", id = "About"}
    }
    
    for i, tab in ipairs(tabs) do
        local tabBtn = Instance.new("TextButton")
        tabBtn.Name = tab.id .. "Tab"
        tabBtn.Size = UDim2.new(1, 0, 0, 35)
        tabBtn.BackgroundColor3 = tab.id == "Home" and Color3.fromRGB(0, 162, 255) or Color3.fromRGB(40, 40, 50)
        tabBtn.BorderSizePixel = 0
        tabBtn.Text = tab.name
        tabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        tabBtn.TextScaled = true
        tabBtn.Font = Enum.Font.Gotham
        tabBtn.Parent = navFrame
        
        local tabCorner = Instance.new("UICorner")
        tabCorner.CornerRadius = UDim.new(0, 6)
        tabCorner.Parent = tabBtn
        
        -- Événement de clic sur l'onglet
        tabBtn.MouseButton1Click:Connect(function()
            Menu:SwitchTab(tab.id)
        end)
        
        -- Effets hover
        tabBtn.MouseEnter:Connect(function()
            if currentTab ~= tab.id then
                TweenService:Create(tabBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50, 50, 60)}):Play()
            end
        end)
        
        tabBtn.MouseLeave:Connect(function()
            if currentTab ~= tab.id then
                TweenService:Create(tabBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 40, 50)}):Play()
            end
        end)
    end
end

-- 📄 Création du contenu principal
local function createContentArea()
    local contentFrame = Instance.new("Frame")
    contentFrame.Name = "ContentArea"
    contentFrame.Size = UDim2.new(0, 300, 1, -60)
    contentFrame.Position = UDim2.new(0, 140, 0, 60)
    contentFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    contentFrame.BorderSizePixel = 0
    contentFrame.Parent = mainFrame
    
    local contentCorner = Instance.new("UICorner")
    contentCorner.CornerRadius = UDim.new(0, 8)
    contentCorner.Parent = contentFrame
    
    -- Zone de scroll
    local scrollFrame = Instance.new("ScrollingFrame")
    scrollFrame.Name = "ScrollContent"
    scrollFrame.Size = UDim2.new(1, -20, 1, -20)
    scrollFrame.Position = UDim2.new(0, 10, 0, 10)
    scrollFrame.BackgroundTransparency = 1
    scrollFrame.BorderSizePixel = 0
    scrollFrame.ScrollBarThickness = 6
    scrollFrame.ScrollBarImageColor3 = Color3.fromRGB(0, 162, 255)
    scrollFrame.Parent = contentFrame
    
    local contentLayout = Instance.new("UIListLayout")
    contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
    contentLayout.Padding = UDim.new(0, 10)
    contentLayout.Parent = scrollFrame
    
    return scrollFrame
end

-- 🎮 Fonctions principales du menu
function Menu:Initialize()
    createMenuFrame()
    createTitleBar()
    createNavigation()
    local contentArea = createContentArea()
    
    -- Charger le contenu par défaut
    self:SwitchTab("Home")
    
    -- Configuration initiale
    mainFrame.Transparency = 1
    mainFrame.Size = UDim2.new(0, 0, 0, 0)
    
    print("🚀 Menu initialisé avec succès!")
end

function Menu:Open()
    if isMenuOpen then return end
    isMenuOpen = true
    
    -- Animation d'ouverture
    mainFrame.Transparency = 1
    mainFrame.Size = UDim2.new(0, 0, 0, 0)
    
    local sizeTween = TweenService:Create(
        mainFrame,
        TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
        {Size = UDim2.new(0, 450, 0, 550)}
    )
    
    local fadeTween = TweenService:Create(
        mainFrame,
        TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {Transparency = 0}
    )
    
    sizeTween:Play()
    fadeTween:Play()
    
    print("📂 Menu ouvert")
end

function Menu:Close()
    if not isMenuOpen then return end
    isMenuOpen = false
    
    local sizeTween = TweenService:Create(
        mainFrame,
        TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In),
        {Size = UDim2.new(0, 0, 0, 0)}
    )
    
    local fadeTween = TweenService:Create(
        mainFrame,
        TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {Transparency = 1}
    )
    
    sizeTween:Play()
    fadeTween:Play()
    
    print("📁 Menu fermé")
end

function Menu:Toggle()
    if isMenuOpen then
        self:Close()
    else
        self:Open()
    end
end

function Menu:SwitchTab(tabName)
    currentTab = tabName
    
    -- Mettre à jour l'apparence des onglets
    local navFrame = mainFrame:FindFirstChild("Navigation")
    if navFrame then
        for _, child in ipairs(navFrame:GetChildren()) do
            if child:IsA("TextButton") and child.Name:match("Tab$") then
                local isActive = child.Name:match("^" .. tabName)
                local targetColor = isActive and Color3.fromRGB(0, 162, 255) or Color3.fromRGB(40, 40, 50)
                TweenService:Create(child, TweenInfo.new(0.3), {BackgroundColor3 = targetColor}):Play()
            end
        end
    end
    
    -- Charger le contenu de l'onglet
    self:LoadTabContent(tabName)
    
    print("🗂️ Onglet changé vers: " .. tabName)
end

function Menu:LoadTabContent(tabName)
    local contentArea = mainFrame:FindFirstChild("ContentArea"):FindFirstChild("ScrollContent")
    
    -- Nettoyer le contenu existant
    for _, child in ipairs(contentArea:GetChildren()) do
        if child:IsA("GuiObject") then
            child:Destroy()
        end
    end
    
    -- Charger le contenu selon l'onglet
    if tabName == "Home" then
        self:CreateHomeContent(contentArea)
    elseif tabName == "Settings" then
        self:CreateSettingsContent(contentArea)
    elseif tabName == "Themes" then
        self:CreateThemesContent(contentArea)
    elseif tabName == "Tools" then
        self:CreateToolsContent(contentArea)
    elseif tabName == "Stats" then
        self:CreateStatsContent(contentArea)
    elseif tabName == "About" then
        self:CreateAboutContent(contentArea)
    end
end

-- 🏠 Contenu de l'onglet Home
function Menu:CreateHomeContent(parent)
    local welcomeLabel = Instance.new("TextLabel")
    welcomeLabel.Size = UDim2.new(1, 0, 0, 50)
    welcomeLabel.BackgroundTransparency = 1
    welcomeLabel.Text = "🏠 Bienvenue dans le Menu Moderne!"
    welcomeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    welcomeLabel.TextScaled = true
    welcomeLabel.Font = Enum.Font.GothamBold
    welcomeLabel.Parent = parent
    
    local infoLabel = Instance.new("TextLabel")
    infoLabel.Size = UDim2.new(1, 0, 0, 100)
    infoLabel.BackgroundTransparency = 1
    infoLabel.Text = "Cette interface moderne offre une navigation intuitive et des animations fluides. Explorez les différents onglets pour découvrir toutes les fonctionnalités disponibles."
    infoLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
    infoLabel.TextScaled = true
    infoLabel.Font = Enum.Font.Gotham
    infoLabel.TextWrapped = true
    infoLabel.Parent = parent
end

-- ⚙️ Contenu de l'onglet Settings
function Menu:CreateSettingsContent(parent)
    local settingsTitle = Instance.new("TextLabel")
    settingsTitle.Size = UDim2.new(1, 0, 0, 40)
    settingsTitle.BackgroundTransparency = 1
    settingsTitle.Text = "⚙️ Paramètres"
    settingsTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    settingsTitle.TextScaled = true
    settingsTitle.Font = Enum.Font.GothamBold
    settingsTitle.Parent = parent
    
    -- Exemple de paramètre
    local settingFrame = Instance.new("Frame")
    settingFrame.Size = UDim2.new(1, 0, 0, 60)
    settingFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    settingFrame.BorderSizePixel = 0
    settingFrame.Parent = parent
    
    local settingCorner = Instance.new("UICorner")
    settingCorner.CornerRadius = UDim.new(0, 6)
    settingCorner.Parent = settingFrame
    
    local settingLabel = Instance.new("TextLabel")
    settingLabel.Size = UDim2.new(0.7, 0, 1, 0)
    settingLabel.Position = UDim2.new(0, 10, 0, 0)
    settingLabel.BackgroundTransparency = 1
    settingLabel.Text = "Activer les animations"
    settingLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    settingLabel.TextScaled = true
    settingLabel.Font = Enum.Font.Gotham
    settingLabel.TextXAlignment = Enum.TextXAlignment.Left
    settingLabel.Parent = settingFrame
    
    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Size = UDim2.new(0, 50, 0, 25)
    toggleBtn.Position = UDim2.new(1, -60, 0.5, -12.5)
    toggleBtn.BackgroundColor3 = Color3.fromRGB(46, 204, 113)
    toggleBtn.BorderSizePixel = 0
    toggleBtn.Text = "ON"
    toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggleBtn.TextScaled = true
    toggleBtn.Font = Enum.Font.GothamBold
    toggleBtn.Parent = settingFrame
    
    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(0, 12)
    toggleCorner.Parent = toggleBtn
end

return Menu

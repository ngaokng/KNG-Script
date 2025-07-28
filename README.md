# 🚀 Modern GUI - Interface Roblox Élégante

Une interface utilisateur moderne et élégante pour Roblox avec des animations fluides, des notifications stylées et un système de navigation intuitif.

## ✨ Fonctionnalités

### 🎨 **Interface Moderne**
- Design dark avec accents colorés
- Coins arrondis et ombres portées
- Animations fluides et transitions élégantes
- Interface responsive et déplaçable

### 🔔 **Système de Notifications**
- 5 types de notifications (Success, Error, Warning, Info, Premium)
- Animations d'entrée et de sortie
- Gestion automatique de l'affichage
- Sons et effets visuels

### 🗂️ **Menu de Navigation**
- Navigation par onglets intuitive
- Contenu dynamique selon l'onglet
- Effets hover et animations de transition
- Zone de contenu avec scroll

### 🎭 **Effets Visuels Avancés**
- Système de particules animées
- Gradients animés et changements de couleur
- Effets de lueur (glow) configurables
- Thèmes multiples (Dark, Neon, Ocean, Sunset)

## 📁 Structure du Projet

```
Script/
├── 🚀 Loader.lua              # Script principal à exécuter
├── 📂 Config/
│   └── Settings.lua           # Configuration et paramètres
├── 📂 Modules/
│   ├── Menu.lua              # Menu principal avec navigation
│   ├── Notifications.lua     # Système de notifications
│   ├── Animations.lua        # Gestion des animations
│   └── Win-RL-GL.lua        # Module d'effets avancés
└── 📖 README.md             # Ce fichier
```

## 🎮 Utilisation

### 🔧 **Installation Locale**
1. Copiez le contenu de `Loader.lua` dans Roblox Studio
2. Exécutez le script
3. L'interface se charge automatiquement avec tous les modules

### 🌐 **Installation via URL (GitHub)**
```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/username/repo/main/Script/Loader.lua"))()
```

### ⌨️ **Commandes et Raccourcis**
- **INSERT** - Ouvrir/Fermer le menu principal
- **F1** - Activer/Désactiver les effets visuels
- **F2** - Changer de thème
- **END** - Fermer toutes les interfaces
- **HOME** - Réduire l'interface

## 🎯 Fonctions Principales

### 📋 **Menu Principal**
```lua
Menu:Initialize()    -- Initialiser le menu
Menu:Open()         -- Ouvrir le menu
Menu:Close()        -- Fermer le menu
Menu:Toggle()       -- Basculer ouvert/fermé
Menu:SwitchTab()    -- Changer d'onglet
```

### 🔔 **Notifications**
```lua
Notifications:Success("Titre", "Message", 5)   -- Notification de succès
Notifications:Error("Titre", "Message", 5)     -- Notification d'erreur
Notifications:Warning("Titre", "Message", 5)   -- Notification d'avertissement
Notifications:Info("Titre", "Message", 5)      -- Notification d'information
Notifications:Premium("Titre", "Message", 5)   -- Notification premium
```

### ✨ **Animations**
```lua
Animations:FadeIn(object, 0.3)                 -- Animation d'apparition
Animations:FadeOut(object, 0.3)                -- Animation de disparition
Animations:SlideFromTop(object, 50, 0.4)       -- Glissement depuis le haut
Animations:ScaleBounce(object, 1.1, 0.2)       -- Effet de rebond
Animations:MenuOpen(menuFrame)                  -- Animation d'ouverture de menu
```

### 🎨 **Effets Visuels (Win-RL-GL)**
```lua
WinRLGL:CreateParticleEffect(parent, config)   -- Particules animées
WinRLGL:CreateAnimatedGradient(object, colors) -- Gradient animé
WinRLGL:ApplyTheme(container, "Neon")          -- Appliquer un thème
WinRLGL:AddGlowEffect(object, color)           -- Ajouter effet de lueur
WinRLGL:CreateLoader(parent, size)             -- Loader circulaire
```

## 🎨 Thèmes Disponibles

### 🌙 **Dark** (Par défaut)
- Couleurs sombres élégantes
- Accents bleus
- Interface sobre et professionnelle

### 💡 **Neon**
- Couleurs vives et fluorescentes
- Effets de lueur activés
- Style cyberpunk moderne

### 🌊 **Ocean**
- Tons bleus et verts
- Inspiré par l'océan
- Ambiance rafraîchissante

### 🌅 **Sunset**
- Couleurs chaudes orange/rouge
- Effet coucher de soleil
- Ambiance chaleureuse

## ⚙️ Configuration

### 🎛️ **Paramètres Principaux** (Settings.lua)
```lua
Settings.Theme.Primary = Color3.fromRGB(45, 45, 55)     -- Couleur principale
Settings.Theme.Accent = Color3.fromRGB(0, 162, 255)     -- Couleur d'accent
Settings.UI.AnimationSpeed = 0.3                        -- Vitesse d'animation
Settings.Features.EnableAnimations = true               -- Activer animations
Settings.Notifications.Duration = 5                     -- Durée des notifications
```

### 🔧 **Personnalisation**
- Modifiez les couleurs dans `Settings.lua`
- Ajustez la vitesse des animations
- Configurez les raccourcis clavier
- Personnalisez les sons et effets

## 🎪 Exemples d'Utilisation

### 📱 **Créer une notification personnalisée**
```lua
Notifications:Create({
    type = "Success",
    title = "🎉 Mission Accomplie!",
    message = "Vous avez terminé la quête principale.",
    duration = 7,
    sound = true
})
```

### 🎭 **Appliquer un thème avec effets**
```lua
-- Appliquer le thème Neon avec particules
WinRLGL:ApplyTheme(menuFrame, "Neon")
WinRLGL:CreateParticleEffect(menuFrame, {
    count = 30,
    color = Color3.fromRGB(0, 255, 255)
})
```

### ✨ **Animation personnalisée**
```lua
-- Combiner plusieurs animations
Animations:FadeIn(myFrame, 0.5)
wait(0.2)
Animations:SlideFromTop(myFrame, 100, 0.6)
WinRLGL:AddGlowEffect(myFrame, Color3.fromRGB(0, 162, 255))
```

## 🚀 Développement

### 📝 **Ajouter un Nouveau Module**
1. Créez votre module dans `/Modules/`
2. Ajoutez l'URL dans `ModuleURLs` du Loader
3. Ajoutez l'initialisation dans la fonction `loadInterface()`

### 🎨 **Créer un Nouveau Thème**
1. Ajoutez votre thème dans `WinRLGL.ApplyTheme()`
2. Définissez les couleurs et propriétés
3. Testez avec `WinRLGL:ApplyTheme(container, "VotreTheme")`

## 📋 Notes Importantes

- ⚠️ Compatible avec Roblox uniquement
- 🔄 Mise à jour automatique via GitHub (si hébergé)
- 🎯 Optimisé pour les performances
- 🛡️ Protection contre les rechargements multiples
- 📱 Interface responsive et adaptative

## 🎉 Crédits

**Interface Modern GUI** - Système complet d'interface utilisateur pour Roblox
- Design moderne et animations fluides
- Système de notifications avancé
- Effets visuels et thèmes multiples
- Architecture modulaire et extensible

---

*Profitez de votre nouvelle interface moderne! 🚀✨*

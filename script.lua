--[[
🥚 RIDE A PET - EGG TRACKER GUI v15 + Splash
|~Wild°Sasha~|
]]

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")
local Debris = game:GetService("Debris")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- ═══════ СИСТЕМА ЛОКАЛИЗАЦИИ ═══════

local currentLang = "ru" -- По умолчанию русский

local L = {
    ru = {
        splashSub = "Egg Tracker для Ride a Pet",
        splashBtn = "Начать",
        title = "RIDE A PET",
        tabHome = "Главная",
        tabBinds = "Бинды",
        tabLang = "Язык",
        tpHome = "TP Дом",
        selected = "Выбрано",
        all = "Все",
        none = "Снять",
        bindsTitle = "Настройка биндов (ПК)",
        bindsDesc = "Нажми кнопку ниже, затем нажми любую\nклавишу. ESC — сбросить бинд.",
        tpHomeBind = "Телепорт на базу",
        currentBind = "Текущий бинд",
        setBind = "Назначить бинд",
        pressKey = "Нажми клавишу...",
        resetBind = "Сбросить бинд",
        bindReset = "Бинд сброшен!",
        bindSet = "Бинд установлен",
        online = "Онлайн",
        baseFound = "База найдена",
        baseNotFound = "База не найдена",
        loaded = "Загружено!",
        closed = "Закрыто",
        found = "найден!",
        langTitle = "Выбор языка / Language",
        langRu = "Русский",
        langEn = "English",
        langCurrent = "Текущий язык",
        noChar = "Персонаж не найден",
        noHrp = "HRP не найден",
        tpSpawn = "TP на Spawn!",
        tpBase = "TP на базу!",
        noBase = "База не найдена!",
    },
    en = {
        splashSub = "Egg Tracker for Ride a Pet",
        splashBtn = "Start",
        title = "RIDE A PET",
        tabHome = "Home",
        tabBinds = "Binds",
        tabLang = "Language",
        tpHome = "TP Home",
        selected = "Selected",
        all = "All",
        none = "None",
        bindsTitle = "Keybinds (PC only)",
        bindsDesc = "Click button then press any key.\nESC = reset bind.",
        tpHomeBind = "Teleport to base",
        currentBind = "Current bind",
        setBind = "Set Bind",
        pressKey = "Press any key...",
        resetBind = "Reset Bind",
        bindReset = "Bind reset!",
        bindSet = "Bind set",
        online = "Online",
        baseFound = "Base found",
        baseNotFound = "Base not found",
        loaded = "Loaded!",
        closed = "Closed",
        found = "found!",
        langTitle = "Select language",
        langRu = "Russian",
        langEn = "English",
        langCurrent = "Current language",
        noChar = "Character not found",
        noHrp = "HRP not found",
        tpSpawn = "TP to Spawn!",
        tpBase = "TP to Base!",
        noBase = "Base not found!",
    }
}

local function t(key)
    return L[currentLang][key] or key
end

-- ═══════ SPLASH SCREEN ═══════

local function showSplash()
    local sg = Instance.new("ScreenGui")
    sg.Name = "SplashV15"
    sg.IgnoreGuiInset = true
    sg.DisplayOrder = 999
    sg.Parent = playerGui

    local bg = Instance.new("Frame")
    bg.Size = UDim2.new(1, 0, 1, 0)
    bg.BackgroundColor3 = Color3.fromRGB(8, 8, 18)
    bg.Parent = sg

    local gr = Instance.new("UIGradient")
    gr.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(12, 10, 28)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(18, 12, 35)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(8, 8, 20))
    })
    gr.Rotation = 45
    gr.Parent = bg

    for i = 1, 60 do
        local star = Instance.new("Frame")
        local sz = math.random(2, 5)
        star.Size = UDim2.new(0, sz, 0, sz)
        star.Position = UDim2.new(math.random(), 0, math.random(), 0)
        star.BackgroundColor3 = Color3.fromRGB(180, 130, 255)
        star.BackgroundTransparency = math.random(30, 70) / 100
        star.BorderSizePixel = 0
        star.Parent = bg
        task.spawn(function()
            while star.Parent do
                local t = math.random(10, 25) / 10
                TweenService:Create(star, TweenInfo.new(t, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
                    BackgroundTransparency = math.random(20, 80) / 100
                }):Play()
                task.wait(t)
            end
        end)
    end

    local center = Instance.new("Frame")
    center.Size = UDim2.new(0, 500, 0, 350)
    center.Position = UDim2.new(0.5, -250, 0.5, -250)
    center.BackgroundTransparency = 1
    center.Parent = sg

    TweenService:Create(center, TweenInfo.new(1, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Position = UDim2.new(0.5, -250, 0.5, -175)
    }):Play()

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 70)
    title.Position = UDim2.new(0, 0, 0, 30)
    title.BackgroundTransparency = 1
    title.Text = '|~Wild°Sasha~|'
    title.TextColor3 = Color3.fromRGB(168, 85, 247)
    title.TextSize = 44
    title.Font = Enum.Font.GothamBold
    title.Parent = center

    local glow = Instance.new("TextLabel")
    glow.Size = UDim2.new(1, 0, 0, 70)
    glow.Position = UDim2.new(0, 0, 0, 30)
    glow.BackgroundTransparency = 1
    glow.Text = '|~Wild°Sasha~|'
    glow.TextColor3 = Color3.fromRGB(200, 150, 255)
    glow.TextSize = 44
    glow.Font = Enum.Font.GothamBold
    glow.TextTransparency = 0.7
    glow.Parent = center

    task.spawn(function()
        while glow.Parent do
            TweenService:Create(glow, TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {TextTransparency = 0.3}):Play()
            task.wait(1.5)
            TweenService:Create(glow, TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {TextTransparency = 0.7}):Play()
            task.wait(1.5)
        end
    end)

    local sub = Instance.new("TextLabel")
    sub.Size = UDim2.new(1, 0, 0, 30)
    sub.Position = UDim2.new(0, 0, 0, 110)
    sub.BackgroundTransparency = 1
    sub.Text = t("splashSub")
    sub.TextColor3 = Color3.fromRGB(168, 85, 247)
    sub.TextSize = 16
    sub.Font = Enum.Font.Gotham
    sub.Parent = center

    local clock = Instance.new("TextLabel")
    clock.Size = UDim2.new(1, 0, 0, 40)
    clock.Position = UDim2.new(0, 0, 1, -130)
    clock.BackgroundTransparency = 1
    clock.Text = ''
    clock.TextColor3 = Color3.fromRGB(168, 85, 247)
    clock.TextSize = 22
    clock.Font = Enum.Font.GothamBold
    clock.Parent = center

    task.spawn(function()
        while clock.Parent do
            local msk = os.time() + 3 * 3600
            local h = math.floor((msk % 86400) / 3600)
            local m = math.floor((msk % 3600) / 60)
            local s = msk % 60
            clock.Text = string.format('%02d:%02d:%02d MSK', h, m, s)
            task.wait(1)
        end
    end)

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 220, 0, 55)
    btn.Position = UDim2.new(0.5, -110, 1, -75)
    btn.BackgroundColor3 = Color3.fromRGB(100, 50, 180)
    btn.Text = t("splashBtn")
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 20
    btn.Font = Enum.Font.GothamBold
    btn.AutoButtonColor = true
    btn.Parent = center

    local bc = Instance.new("UICorner")
    bc.CornerRadius = UDim.new(0, 12)
    bc.Parent = btn

    local bs = Instance.new("UIStroke")
    bs.Color = Color3.fromRGB(168, 85, 247)
    bs.Thickness = 2
    bs.Transparency = 0.3
    bs.Parent = btn

    task.spawn(function()
        while btn.Parent do
            TweenService:Create(bs, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Transparency = 0}):Play()
            task.wait(1)
            TweenService:Create(bs, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Transparency = 0.5}):Play()
            task.wait(1)
        end
    end)

    local done = false
    btn.MouseButton1Click:Connect(function()
        done = true
        local s = Instance.new("Sound")
        s.SoundId = "rbxassetid://550207128"
        s.Volume = 0.3
        s.PlaybackSpeed = 1.2
        s.Parent = SoundService
        s:Play()
        TweenService:Create(bg, TweenInfo.new(0.6), {BackgroundTransparency = 1}):Play()
        TweenService:Create(center, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Position = UDim2.new(0.5, -250, 0.5, -250)
        }):Play()
        task.wait(0.6)
        sg:Destroy()
    end)

    task.delay(30, function()
        if not done and sg.Parent then done = true sg:Destroy() end
    end)

    while not done do task.wait(0.1) end
end

showSplash()

-- ═══════ НАСТРОЙКИ ═══════

local Settings = {
    ShowESP = true,
    ShowNotifications = true,
    PlaySound = true,
    ShowDistance = true,
    ShowHighlight = true,
    UpdateInterval = 0.3,
    ESPColor = Color3.fromRGB(168, 85, 247),
    TextSize = 13,
    TPHeight = 10,
    MinWidth = 300,
    MaxWidth = 550,
    MinHeight = 450,
    MaxHeight = 800,
    ClickSoundEnabled = true,
    HomeBind = nil,
}

-- Таблица переводов названий яиц
local EggNames = {
    ru = {
        ["White Egg"] = "Белое Яйцо",
        ["Brown Egg"] = "Коричневое Яйцо",
        ["Cracked Egg"] = "Треснувшее Яйцо",
        ["Easter Egg"] = "Пасхальное Яйцо",
        ["Stone Egg"] = "Каменное Яйцо",
        ["Leaf Egg"] = "Яйцо Листа",
        ["Mushroom Egg"] = "Яйцо Гриба",
        ["Flower Egg"] = "Яйцо Цветка",
        ["Slime Egg"] = "Яйцо Слизня",
        ["Ice Egg"] = "Ледяное Яйцо",
        ["Glass Egg"] = "Стеклянное Яйцо",
        ["Golden Egg"] = "Золотое Яйцо",
        ["Crystal Egg"] = "Кристальное Яйцо",
        ["Skull Egg"] = "Яйцо Черепа",
        ["Dominus Egg"] = "Яйцо Доминуса",
        ["Flaming Egg"] = "Огненное Яйцо",
        ["Sinister Egg"] = "Зловещее Яйцо",
        ["Soul Egg"] = "Яйцо Души",
        ["Aurora Egg"] = "Яйцо Авроры",
        ["Galaxy Egg"] = "Галактическое Яйцо",
        ["Black Hole Egg"] = "Яйцо Чёрной Дыры",
        ["Solaris Egg"] = "Яйцо Соляриса",
        ["Cherub Egg"] = "Яйцо Херувима",
    },
    en = {} -- Пустая таблица — используем оригинальные английские имена
}

-- Функция получения отображаемого имени яйца
local function getEggDisplayName(eggName)
    if currentLang == "ru" and EggNames.ru[eggName] then
        return EggNames.ru[eggName]
    end
    return eggName -- Для английского или если перевода нет
end

local AllEggs = {
    {name = "White Egg", luck = 1, color = Color3.fromRGB(200, 200, 200), enabled = true},
    {name = "Brown Egg", luck = 5, color = Color3.fromRGB(139, 90, 43), enabled = true},
    {name = "Cracked Egg", luck = 30, color = Color3.fromRGB(96, 165, 250), enabled = true},
    {name = "Easter Egg", luck = 50, color = Color3.fromRGB(167, 139, 250), enabled = true},
    {name = "Stone Egg", luck = 100, color = Color3.fromRGB(107, 114, 128), enabled = true},
    {name = "Leaf Egg", luck = 200, color = Color3.fromRGB(74, 222, 128), enabled = true},
    {name = "Mushroom Egg", luck = 500, color = Color3.fromRGB(239, 68, 68), enabled = true},
    {name = "Flower Egg", luck = 750, color = Color3.fromRGB(244, 114, 182), enabled = true},
    {name = "Slime Egg", luck = 1000, color = Color3.fromRGB(34, 197, 94), enabled = true},
    {name = "Ice Egg", luck = 3000, color = Color3.fromRGB(103, 232, 249), enabled = true},
    {name = "Glass Egg", luck = 10000, color = Color3.fromRGB(251, 191, 36), enabled = true},
    {name = "Golden Egg", luck = 30000, color = Color3.fromRGB(252, 211, 77), enabled = true},
    {name = "Crystal Egg", luck = 150000, color = Color3.fromRGB(192, 132, 252), enabled = true},
    {name = "Skull Egg", luck = 250000, color = Color3.fromRGB(229, 231, 235), enabled = true},
    {name = "Dominus Egg", luck = 700000, color = Color3.fromRGB(252, 211, 77), enabled = true},
    {name = "Flaming Egg", luck = 1000000, color = Color3.fromRGB(249, 115, 22), enabled = true},
    {name = "Sinister Egg", luck = 3000000, color = Color3.fromRGB(124, 58, 237), enabled = true},
    {name = "Soul Egg", luck = 7000000, color = Color3.fromRGB(6, 182, 212), enabled = true},
    {name = "Aurora Egg", luck = 300000000, color = Color3.fromRGB(52, 211, 153), enabled = true},
    {name = "Galaxy Egg", luck = 1500000000, color = Color3.fromRGB(129, 140, 248), enabled = true},
    {name = "Black Hole Egg", luck = 100000000000, color = Color3.fromRGB(88, 28, 135), enabled = true},
    {name = "Solaris Egg", luck = 300000000000, color = Color3.fromRGB(245, 158, 11), enabled = true},
    {name = "Cherub Egg", luck = 1000000000000, color = Color3.fromRGB(253, 164, 175), enabled = true},
}

local RenderedEggs = workspace:WaitForChild("RenderedEggs", 30)
if not RenderedEggs then
    warn("[EggTracker] workspace.RenderedEggs не найден!")
    return
end

-- ═══════ ЗВУКИ ═══════

local function playClickSound()
    if not Settings.ClickSoundEnabled then return end
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://6895079853"
    sound.Volume = 0.3
    sound.PlaybackSpeed = 1.2
    sound.Parent = SoundService
    sound:Play()
    Debris:AddItem(sound, 1)
end

local function playToggleOnSound()
    if not Settings.ClickSoundEnabled then return end
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://550207128"
    sound.Volume = 0.2
    sound.PlaybackSpeed = 1.5
    sound.Parent = SoundService
    sound:Play()
    Debris:AddItem(sound, 1)
end

local function playToggleOffSound()
    if not Settings.ClickSoundEnabled then return end
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://130792900"
    sound.Volume = 0.2
    sound.PlaybackSpeed = 0.8
    sound.Parent = SoundService
    sound:Play()
    Debris:AddItem(sound, 1)
end

local function playBindSound()
    if not Settings.ClickSoundEnabled then return end
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://3932505084"
    sound.Volume = 0.3
    sound.PlaybackSpeed = 1.0
    sound.Parent = SoundService
    sound:Play()
    Debris:AddItem(sound, 1)
end

-- ═══════ ТЕЛЕПОРТ НА БАЗУ ═══════

local Plots = workspace:FindFirstChild("Plots")
local cachedMyPlot = nil
local cachedBaseplate = nil

local function findMyPlot()
    if cachedMyPlot and cachedMyPlot.Parent then
        local data = cachedMyPlot:FindFirstChild("Data")
        if data then
            local owner = data:FindFirstChild("Owner")
            if owner and owner:IsA("ObjectValue") and owner.Value == player then
                return cachedMyPlot
            end
        end
    end
    if not Plots then return nil end
    for _, plot in ipairs(Plots:GetChildren()) do
        local data = plot:FindFirstChild("Data")
        if data then
            local owner = data:FindFirstChild("Owner")
            if owner and owner:IsA("ObjectValue") and owner.Value == player then
                cachedMyPlot = plot
                local baseplate = plot:FindFirstChild("Baseplate")
                if not baseplate then baseplate = plot:FindFirstChild("Baseplate", true) end
                if baseplate and baseplate:IsA("BasePart") then cachedBaseplate = baseplate end
                return plot
            end
        end
    end
    return nil
end

local function getBaseplate()
    local plot = findMyPlot()
    if not plot then return nil end
    if cachedBaseplate and cachedBaseplate.Parent and cachedBaseplate:IsDescendantOf(plot) then
        return cachedBaseplate
    end
    local baseplate = plot:FindFirstChild("Baseplate")
    if not baseplate then baseplate = plot:FindFirstChild("Baseplate", true) end
    if baseplate and baseplate:IsA("BasePart") then
        cachedBaseplate = baseplate
        return baseplate
    end
    return nil
end

local function teleportToBase()
    local char = player.Character
    if not char then showStatus(t("noChar")) return end
    local rootPart = char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("UpperTorso") or char:FindFirstChild("Torso")
    if not rootPart then showStatus(t("noHrp")) return end
    local baseplate = getBaseplate()
    if not baseplate then
        local spawnLoc = workspace:FindFirstChild("SpawnLocation", true) or workspace:FindFirstChild("Home", true) or workspace:FindFirstChild("Spawn", true)
        if spawnLoc and spawnLoc:IsA("BasePart") then
            rootPart.AssemblyLinearVelocity = Vector3.zero
            rootPart.AssemblyAngularVelocity = Vector3.zero
            char:PivotTo(CFrame.new(spawnLoc.Position + Vector3.new(0, Settings.TPHeight, 0)))
            showStatus(t("tpSpawn"))
            return
        end
        showStatus(t("noBase"))
        return
    end
    local topPos = baseplate.CFrame.Position + Vector3.new(0, (baseplate.Size.Y / 2) + Settings.TPHeight, 0)
    rootPart.AssemblyLinearVelocity = Vector3.zero
    rootPart.AssemblyAngularVelocity = Vector3.zero
    char:PivotTo(CFrame.new(topPos))
    rootPart.AssemblyLinearVelocity = Vector3.zero
    rootPart.AssemblyAngularVelocity = Vector3.zero
    showStatus(t("tpBase"))
end

-- ═══════ БИНДЫ ═══════

local waitingForBind = false
local bindButton = nil
local bindLabel = nil

local function getKeyName(keyCode)
    if not keyCode then return "None" end
    local name = keyCode.Name
    if name == "LeftShift" then return "L.Shift"
    elseif name == "RightShift" then return "R.Shift"
    elseif name == "LeftControl" then return "L.Ctrl"
    elseif name == "RightControl" then return "R.Ctrl"
    elseif name == "LeftAlt" then return "L.Alt"
    elseif name == "RightAlt" then return "R.Alt"
    elseif name:sub(1, 7) == "Keypad" then return "Num " .. name:sub(8)
    elseif name == "Return" then return "Enter"
    elseif name == "Space" then return "Space"
    elseif name == "Backquote" then return "~"
    elseif name == "Slash" then return "/"
    elseif name == "BackSlash" then return "\\"
    elseif name == "Period" then return "."
    elseif name == "Comma" then return ","
    elseif name == "Semicolon" then return ";"
    elseif name == "Quote" then return "'"
    elseif name == "Minus" then return "-"
    elseif name == "Equals" then return "="
    elseif name == "LeftBracket" then return "["
    elseif name == "RightBracket" then return "]"
    end
    return name
end

local function updateBindDisplay()
    if not bindLabel then return end
    if Settings.HomeBind then
        bindLabel.Text = t("currentBind") .. ": " .. getKeyName(Settings.HomeBind)
        bindLabel.TextColor3 = Color3.fromRGB(100, 255, 120)
    else
        bindLabel.Text = t("currentBind") .. ": None"
        bindLabel.TextColor3 = Color3.fromRGB(120, 120, 140)
    end
end

local function startBindWaiting()
    waitingForBind = true
    bindButton.Text = t("pressKey")
    bindButton.BackgroundColor3 = Color3.fromRGB(100, 60, 150)
    showStatus(t("pressKey") .. " (ESC = " .. t("resetBind") .. ")")
end

local function stopBindWaiting()
    waitingForBind = false
    if Settings.HomeBind then
        bindButton.Text = getKeyName(Settings.HomeBind)
    else
        bindButton.Text = t("setBind")
    end
    bindButton.BackgroundColor3 = Color3.fromRGB(50, 50, 75)
end

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not waitingForBind then
        if Settings.HomeBind and input.KeyCode == Settings.HomeBind and not gameProcessed then
            teleportToBase()
        end
        return
    end
    if input.KeyCode == Enum.KeyCode.Escape then
        Settings.HomeBind = nil
        playBindSound()
        showStatus(t("bindReset"))
    else
        Settings.HomeBind = input.KeyCode
        playBindSound()
        showStatus(t("bindSet") .. ": " .. getKeyName(input.KeyCode))
    end
    updateBindDisplay()
    stopBindWaiting()
end)

-- ═══════ GUI ═══════

local oldGui = playerGui:FindFirstChild("EggTrackerGUI_v15")
if oldGui then oldGui:Destroy() end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "EggTrackerGUI_v15"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = playerGui

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 380, 0, 600)
MainFrame.Position = UDim2.new(0.5, -190, 0.5, -300)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Active = true
MainFrame.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 10)
mainCorner.Parent = MainFrame

local mainStroke = Instance.new("UIStroke")
mainStroke.Color = Color3.fromRGB(100, 100, 150)
mainStroke.Thickness = 1.5
mainStroke.Transparency = 0.2
mainStroke.Parent = MainFrame

local TitleBar = Instance.new("TextButton")
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0, 40)
TitleBar.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
TitleBar.BorderSizePixel = 0
TitleBar.Text = ""
TitleBar.AutoButtonColor = false
TitleBar.Parent = MainFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 10)
titleCorner.Parent = TitleBar

local titleFix = Instance.new("Frame")
titleFix.Size = UDim2.new(1, 0, 0, 10)
titleFix.Position = UDim2.new(0, 0, 1, -10)
titleFix.BackgroundColor3 = Color3.fromRGB(20, 20, 35)
titleFix.BorderSizePixel = 0
titleFix.Parent = TitleBar

local accent = Instance.new("Frame")
accent.Size = UDim2.new(0, 4, 1, -16)
accent.Position = UDim2.new(0, 10, 0, 8)
accent.BackgroundColor3 = Settings.ESPColor
accent.BorderSizePixel = 0
accent.Parent = TitleBar

local accentCorner = Instance.new("UICorner")
accentCorner.CornerRadius = UDim.new(1, 0)
accentCorner.Parent = accent

local titleText = Instance.new("TextLabel")
titleText.Size = UDim2.new(1, -120, 1, 0)
titleText.Position = UDim2.new(0, 22, 0, 0)
titleText.BackgroundTransparency = 1
titleText.Text = t("title")
titleText.TextColor3 = Color3.fromRGB(255, 255, 255)
titleText.TextSize = 15
titleText.Font = Enum.Font.GothamBold
titleText.TextXAlignment = Enum.TextXAlignment.Left
titleText.Parent = TitleBar

local function createButton(text, color, position)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 30, 0, 30)
    btn.Position = position
    btn.BackgroundColor3 = color
    btn.Text = text
    btn.TextSize = 14
    btn.AutoButtonColor = true
    btn.Parent = TitleBar
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = btn
    return btn
end

local MinimizeBtn = createButton("_", Color3.fromRGB(60, 60, 90), UDim2.new(1, -68, 0, 5))
MinimizeBtn.TextColor3 = Color3.fromRGB(200, 200, 220)
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.TextSize = 16
local CloseBtn = createButton("X", Color3.fromRGB(180, 50, 60), UDim2.new(1, -33, 0, 5))
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 12

local TabBar = Instance.new("Frame")
TabBar.Name = "TabBar"
TabBar.Size = UDim2.new(1, 0, 0, 35)
TabBar.Position = UDim2.new(0, 0, 0, 40)
TabBar.BackgroundColor3 = Color3.fromRGB(20, 20, 32)
TabBar.BorderSizePixel = 0
TabBar.Parent = MainFrame

local function createTab(text, position)
    local tab = Instance.new("TextButton")
    tab.Size = UDim2.new(0.333, -2, 1, 0)
    tab.Position = position
    tab.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
    tab.Text = text
    tab.TextColor3 = Color3.fromRGB(150, 150, 170)
    tab.Font = Enum.Font.GothamBold
    tab.TextSize = 12
    tab.AutoButtonColor = false
    tab.Parent = TabBar
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = tab
    return tab
end

local HomeTab = createTab(t("tabHome"), UDim2.new(0, 1, 0, 0))
local BindTab = createTab(t("tabBinds"), UDim2.new(0.333, 1, 0, 0))
local LangTab = createTab(t("tabLang"), UDim2.new(0.666, 1, 0, 0))

local ContentFrame = Instance.new("Frame")
ContentFrame.Name = "Content"
ContentFrame.Size = UDim2.new(1, 0, 1, -75)
ContentFrame.Position = UDim2.new(0, 0, 0, 75)
ContentFrame.BackgroundTransparency = 1
ContentFrame.ClipsDescendants = true
ContentFrame.Parent = MainFrame

local HomePage = Instance.new("Frame")
HomePage.Name = "HomePage"
HomePage.Size = UDim2.new(1, 0, 1, 0)
HomePage.BackgroundTransparency = 1
HomePage.Parent = ContentFrame

local BindPage = Instance.new("Frame")
BindPage.Name = "BindPage"
BindPage.Size = UDim2.new(1, 0, 1, 0)
BindPage.BackgroundTransparency = 1
BindPage.Visible = false
BindPage.Parent = ContentFrame

local LangPage = Instance.new("Frame")
LangPage.Name = "LangPage"
LangPage.Size = UDim2.new(1, 0, 1, 0)
LangPage.BackgroundTransparency = 1
LangPage.Visible = false
LangPage.Parent = ContentFrame

local currentTab = "home"

local function switchTab(tab)
    if currentTab == tab then return end
    playClickSound()
    
    -- Сброс всех вкладок
    HomePage.Visible = false
    BindPage.Visible = false
    LangPage.Visible = false
    HomeTab.BackgroundColor3 = Color3.fromRGB(20, 20, 32)
    HomeTab.TextColor3 = Color3.fromRGB(100, 100, 120)
    BindTab.BackgroundColor3 = Color3.fromRGB(20, 20, 32)
    BindTab.TextColor3 = Color3.fromRGB(100, 100, 120)
    LangTab.BackgroundColor3 = Color3.fromRGB(20, 20, 32)
    LangTab.TextColor3 = Color3.fromRGB(100, 100, 120)
    
    -- Активация выбранной
    if tab == "home" then
        HomePage.Visible = true
        HomeTab.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
        HomeTab.TextColor3 = Color3.fromRGB(150, 150, 170)
    elseif tab == "bind" then
        BindPage.Visible = true
        BindTab.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
        BindTab.TextColor3 = Color3.fromRGB(150, 150, 170)
    elseif tab == "lang" then
        LangPage.Visible = true
        LangTab.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
        LangTab.TextColor3 = Color3.fromRGB(150, 150, 170)
    end
    currentTab = tab
end

HomeTab.MouseButton1Click:Connect(function() switchTab("home") end)
BindTab.MouseButton1Click:Connect(function() switchTab("bind") end)
LangTab.MouseButton1Click:Connect(function() switchTab("lang") end)

HomeTab.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
HomeTab.TextColor3 = Color3.fromRGB(150, 150, 170)

-- Главная страница
local TeleportBar = Instance.new("Frame")
TeleportBar.Size = UDim2.new(1, -20, 0, 35)
TeleportBar.Position = UDim2.new(0, 10, 0, 5)
TeleportBar.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
TeleportBar.BorderSizePixel = 0
TeleportBar.Parent = HomePage

local teleportCorner = Instance.new("UICorner")
teleportCorner.CornerRadius = UDim.new(0, 6)
teleportCorner.Parent = TeleportBar

local HomeBtn = Instance.new("TextButton")
HomeBtn.Size = UDim2.new(1, -16, 0, 28)
HomeBtn.Position = UDim2.new(0, 8, 0, 3)
HomeBtn.BackgroundColor3 = Color3.fromRGB(60, 100, 180)
HomeBtn.Text = t("tpHome")
HomeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
HomeBtn.Font = Enum.Font.GothamBold
HomeBtn.TextSize = 13
HomeBtn.AutoButtonColor = true
HomeBtn.Parent = TeleportBar

local homeBtnCorner = Instance.new("UICorner")
homeBtnCorner.CornerRadius = UDim.new(0, 5)
homeBtnCorner.Parent = HomeBtn

local CountBar = Instance.new("Frame")
CountBar.Size = UDim2.new(1, -20, 0, 30)
CountBar.Position = UDim2.new(0, 10, 0, 45)
CountBar.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
CountBar.BorderSizePixel = 0
CountBar.Parent = HomePage

local countCorner = Instance.new("UICorner")
countCorner.CornerRadius = UDim.new(0, 6)
countCorner.Parent = CountBar

local countText = Instance.new("TextLabel")
countText.Size = UDim2.new(0.5, 0, 1, 0)
countText.Position = UDim2.new(0, 10, 0, 0)
countText.BackgroundTransparency = 1
countText.Text = t("selected") .. ": " .. #AllEggs .. "/" .. #AllEggs
countText.TextColor3 = Color3.fromRGB(180, 180, 200)
countText.TextSize = 12
countText.Font = Enum.Font.GothamBold
countText.TextXAlignment = Enum.TextXAlignment.Left
countText.Parent = CountBar

local function createSmallButton(text, color, position)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 55, 0, 24)
    btn.Position = position
    btn.BackgroundColor3 = color
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 11
    btn.AutoButtonColor = true
    btn.Parent = CountBar
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 5)
    corner.Parent = btn
    return btn
end

local SelectAllBtn = createSmallButton(t("all"), Color3.fromRGB(40, 120, 70), UDim2.new(1, -120, 0, 3))
local DeselectAllBtn = createSmallButton(t("none"), Color3.fromRGB(140, 50, 60), UDim2.new(1, -60, 0, 3))

local ScrollFrame = Instance.new("ScrollingFrame")
ScrollFrame.Size = UDim2.new(1, -20, 1, -80)
ScrollFrame.Position = UDim2.new(0, 10, 0, 80)
ScrollFrame.BackgroundTransparency = 1
ScrollFrame.BorderSizePixel = 0
ScrollFrame.ScrollBarThickness = 4
ScrollFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 150)
ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ScrollFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
ScrollFrame.Parent = HomePage

local listLayout = Instance.new("UIListLayout")
listLayout.Padding = UDim.new(0, 2)
listLayout.Parent = ScrollFrame

local eggButtons = {}

local function formatLuck(luck)
    if luck >= 1000000000000 then return string.format("%.1fT", luck / 1000000000000)
    elseif luck >= 1000000000 then return string.format("%.1fB", luck / 1000000000)
    elseif luck >= 1000000 then return string.format("%.1fM", luck / 1000000)
    elseif luck >= 1000 then return string.format("%.1fK", luck / 1000)
    else return tostring(luck)
    end
end

local function updateCount()
    local count = 0
    for _, egg in ipairs(AllEggs) do
        if egg.enabled then count = count + 1 end
    end
    countText.Text = t("selected") .. ": " .. count .. "/" .. #AllEggs
end

local function createEggRow(eggData, index)
    local row = Instance.new("TextButton")
    row.Size = UDim2.new(1, 0, 0, 28)
    row.BackgroundColor3 = eggData.enabled and Color3.fromRGB(30, 45, 35) or Color3.fromRGB(30, 30, 42)
    row.Text = ""
    row.BorderSizePixel = 0
    row.AutoButtonColor = false
    row.Parent = ScrollFrame
    local rowCorner = Instance.new("UICorner")
    rowCorner.CornerRadius = UDim.new(0, 6)
    rowCorner.Parent = row
    local rowStroke = Instance.new("UIStroke")
    rowStroke.Color = eggData.enabled and Color3.fromRGB(60, 150, 80) or Color3.fromRGB(50, 50, 70)
    rowStroke.Thickness = 1
    rowStroke.Transparency = 0.4
    rowStroke.Parent = row
    local colorBar = Instance.new("Frame")
    colorBar.Size = UDim2.new(0, 3, 1, -8)
    colorBar.Position = UDim2.new(0, 5, 0, 4)
    colorBar.BackgroundColor3 = eggData.color
    colorBar.BorderSizePixel = 0
    colorBar.Parent = row
    local cbCorner = Instance.new("UICorner")
    cbCorner.CornerRadius = UDim.new(1, 0)
    cbCorner.Parent = colorBar
    local nameText = Instance.new("TextLabel")
    nameText.Size = UDim2.new(0.6, -35, 1, 0)
    nameText.Position = UDim2.new(0, 14, 0, 0)
    nameText.BackgroundTransparency = 1
    nameText.Text = getEggDisplayName(eggData.name)
    nameText.TextColor3 = eggData.enabled and Color3.fromRGB(240, 240, 255) or Color3.fromRGB(120, 120, 140)
    nameText.TextSize = 11
    nameText.Font = Enum.Font.Gotham
    nameText.TextXAlignment = Enum.TextXAlignment.Left
    nameText.Parent = row
    local luckText = Instance.new("TextLabel")
    luckText.Size = UDim2.new(0, 65, 1, 0)
    luckText.Position = UDim2.new(0.6, -15, 0, 0)
    luckText.BackgroundTransparency = 1
    luckText.Text = "1/" .. formatLuck(eggData.luck)
    luckText.TextColor3 = eggData.enabled and Color3.fromRGB(180, 180, 200) or Color3.fromRGB(80, 80, 100)
    luckText.TextSize = 10
    luckText.Font = Enum.Font.Gotham
    luckText.TextXAlignment = Enum.TextXAlignment.Right
    luckText.Parent = row
    local checkbox = Instance.new("Frame")
    checkbox.Size = UDim2.new(0, 18, 0, 18)
    checkbox.Position = UDim2.new(1, -24, 0.5, -9)
    checkbox.BackgroundColor3 = eggData.enabled and Color3.fromRGB(60, 180, 90) or Color3.fromRGB(50, 50, 65)
    checkbox.BorderSizePixel = 0
    checkbox.Parent = row
    local checkCorner = Instance.new("UICorner")
    checkCorner.CornerRadius = UDim.new(0, 4)
    checkCorner.Parent = checkbox
    local checkMark = Instance.new("TextLabel")
    checkMark.Size = UDim2.new(1, 0, 1, 0)
    checkMark.BackgroundTransparency = 1
    checkMark.Text = eggData.enabled and "V" or ""
    checkMark.TextColor3 = Color3.fromRGB(255, 255, 255)
    checkMark.TextSize = 12
    checkMark.Font = Enum.Font.GothamBold
    checkMark.Parent = checkbox
    row.MouseButton1Click:Connect(function()
        eggData.enabled = not eggData.enabled
        if eggData.enabled then
            row.BackgroundColor3 = Color3.fromRGB(30, 45, 35)
            rowStroke.Color = Color3.fromRGB(60, 150, 80)
            nameText.TextColor3 = Color3.fromRGB(240, 240, 255)
            luckText.TextColor3 = Color3.fromRGB(180, 180, 200)
            checkbox.BackgroundColor3 = Color3.fromRGB(60, 180, 90)
            checkMark.Text = "V"
            playToggleOnSound()
        else
            row.BackgroundColor3 = Color3.fromRGB(30, 30, 42)
            rowStroke.Color = Color3.fromRGB(50, 50, 70)
            nameText.TextColor3 = Color3.fromRGB(120, 120, 140)
            luckText.TextColor3 = Color3.fromRGB(80, 80, 100)
            checkbox.BackgroundColor3 = Color3.fromRGB(50, 50, 65)
            checkMark.Text = ""
            playToggleOffSound()
        end
        updateCount()
        refreshESP()
    end)
    eggButtons[index] = {row = row, checkbox = checkbox, checkMark = checkMark, nameText = nameText, luckText = luckText, rowStroke = rowStroke}
end

for i, egg in ipairs(AllEggs) do
    createEggRow(egg, i)
end

SelectAllBtn.MouseButton1Click:Connect(function()
    playClickSound()
    for i, egg in ipairs(AllEggs) do
        egg.enabled = true
        local btn = eggButtons[i]
        if btn then
            btn.row.BackgroundColor3 = Color3.fromRGB(30, 45, 35)
            btn.rowStroke.Color = Color3.fromRGB(60, 150, 80)
            btn.nameText.TextColor3 = Color3.fromRGB(240, 240, 255)
            btn.luckText.TextColor3 = Color3.fromRGB(180, 180, 200)
            btn.checkbox.BackgroundColor3 = Color3.fromRGB(60, 180, 90)
            btn.checkMark.Text = "V"
        end
    end
    updateCount()
    refreshESP()
end)

DeselectAllBtn.MouseButton1Click:Connect(function()
    playClickSound()
    for i, egg in ipairs(AllEggs) do
        egg.enabled = false
        local btn = eggButtons[i]
        if btn then
            btn.row.BackgroundColor3 = Color3.fromRGB(30, 30, 42)
            btn.rowStroke.Color = Color3.fromRGB(50, 50, 70)
            btn.nameText.TextColor3 = Color3.fromRGB(120, 120, 140)
            btn.luckText.TextColor3 = Color3.fromRGB(80, 80, 100)
            btn.checkbox.BackgroundColor3 = Color3.fromRGB(50, 50, 65)
            btn.checkMark.Text = ""
        end
    end
    updateCount()
    refreshESP()
end)

-- Страница биндов
local BindContent = Instance.new("Frame")
BindContent.Size = UDim2.new(1, -20, 1, -10)
BindContent.Position = UDim2.new(0, 10, 0, 5)
BindContent.BackgroundTransparency = 1
BindContent.Parent = BindPage

local BindTitle = Instance.new("TextLabel")
BindTitle.Size = UDim2.new(1, 0, 0, 30)
BindTitle.BackgroundTransparency = 1
BindTitle.Text = t("bindsTitle")
BindTitle.TextColor3 = Color3.fromRGB(200, 200, 220)
BindTitle.TextSize = 14
BindTitle.Font = Enum.Font.GothamBold
BindTitle.TextXAlignment = Enum.TextXAlignment.Left
BindTitle.Parent = BindContent

local BindDesc = Instance.new("TextLabel")
BindDesc.Size = UDim2.new(1, 0, 0, 45)
BindDesc.Position = UDim2.new(0, 0, 0, 30)
BindDesc.BackgroundTransparency = 1
BindDesc.Text = t("bindsDesc")
BindDesc.TextColor3 = Color3.fromRGB(120, 120, 150)
BindDesc.TextSize = 11
BindDesc.Font = Enum.Font.Gotham
BindDesc.TextXAlignment = Enum.TextXAlignment.Left
BindDesc.TextWrapped = true
BindDesc.Parent = BindContent

local HomeBindBox = Instance.new("Frame")
HomeBindBox.Size = UDim2.new(1, 0, 0, 90)
HomeBindBox.Position = UDim2.new(0, 0, 0, 85)
HomeBindBox.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
HomeBindBox.BorderSizePixel = 0
HomeBindBox.Parent = BindContent

local homeBindCorner = Instance.new("UICorner")
homeBindCorner.CornerRadius = UDim.new(0, 8)
homeBindCorner.Parent = HomeBindBox

local homeBindTitle = Instance.new("TextLabel")
homeBindTitle.Size = UDim2.new(1, -16, 0, 22)
homeBindTitle.Position = UDim2.new(0, 12, 0, 8)
homeBindTitle.BackgroundTransparency = 1
homeBindTitle.Text = t("tpHomeBind")
homeBindTitle.TextColor3 = Color3.fromRGB(220, 220, 240)
homeBindTitle.TextSize = 13
homeBindTitle.Font = Enum.Font.GothamBold
homeBindTitle.TextXAlignment = Enum.TextXAlignment.Left
homeBindTitle.Parent = HomeBindBox

bindLabel = Instance.new("TextLabel")
bindLabel.Size = UDim2.new(1, -16, 0, 18)
bindLabel.Position = UDim2.new(0, 12, 0, 32)
bindLabel.BackgroundTransparency = 1
bindLabel.Text = t("currentBind") .. ": None"
bindLabel.TextColor3 = Color3.fromRGB(120, 120, 140)
bindLabel.TextSize = 11
bindLabel.Font = Enum.Font.Gotham
bindLabel.TextXAlignment = Enum.TextXAlignment.Left
bindLabel.Parent = HomeBindBox

bindButton = Instance.new("TextButton")
bindButton.Size = UDim2.new(1, -24, 0, 28)
bindButton.Position = UDim2.new(0, 12, 0, 54)
bindButton.BackgroundColor3 = Color3.fromRGB(50, 50, 75)
bindButton.Text = t("setBind")
bindButton.TextColor3 = Color3.fromRGB(200, 200, 220)
bindButton.Font = Enum.Font.GothamBold
bindButton.TextSize = 12
bindButton.AutoButtonColor = true
bindButton.Parent = HomeBindBox

local bindBtnCorner = Instance.new("UICorner")
bindBtnCorner.CornerRadius = UDim.new(0, 6)
bindBtnCorner.Parent = bindButton

bindButton.MouseButton1Click:Connect(function()
    playClickSound()
    startBindWaiting()
end)

local ResetBindBtn = Instance.new("TextButton")
ResetBindBtn.Size = UDim2.new(1, -24, 0, 28)
ResetBindBtn.Position = UDim2.new(0, 12, 0, 185)
ResetBindBtn.BackgroundColor3 = Color3.fromRGB(120, 40, 50)
ResetBindBtn.Text = t("resetBind")
ResetBindBtn.TextColor3 = Color3.fromRGB(255, 200, 200)
ResetBindBtn.Font = Enum.Font.GothamBold
ResetBindBtn.TextSize = 12
ResetBindBtn.AutoButtonColor = true
ResetBindBtn.Parent = BindContent

local resetBindCorner = Instance.new("UICorner")
resetBindCorner.CornerRadius = UDim.new(0, 6)
resetBindCorner.Parent = ResetBindBtn

ResetBindBtn.MouseButton1Click:Connect(function()
    playClickSound()
    Settings.HomeBind = nil
    updateBindDisplay()
    stopBindWaiting()
    showStatus(t("bindReset"))
end)

-- ═══════ СТРАНИЦА ЯЗЫКА ═══════

local LangContent = Instance.new("Frame")
LangContent.Size = UDim2.new(1, -20, 1, -10)
LangContent.Position = UDim2.new(0, 10, 0, 5)
LangContent.BackgroundTransparency = 1
LangContent.Parent = LangPage

local LangTitle = Instance.new("TextLabel")
LangTitle.Size = UDim2.new(1, 0, 0, 30)
LangTitle.BackgroundTransparency = 1
LangTitle.Text = t("langTitle")
LangTitle.TextColor3 = Color3.fromRGB(200, 200, 220)
LangTitle.TextSize = 14
LangTitle.Font = Enum.Font.GothamBold
LangTitle.TextXAlignment = Enum.TextXAlignment.Left
LangTitle.Parent = LangContent

local LangCurrentLabel = Instance.new("TextLabel")
LangCurrentLabel.Size = UDim2.new(1, 0, 0, 25)
LangCurrentLabel.Position = UDim2.new(0, 0, 0, 35)
LangCurrentLabel.BackgroundTransparency = 1
LangCurrentLabel.Text = t("langCurrent") .. ": " .. (currentLang == "ru" and "Русский" or "English")
LangCurrentLabel.TextColor3 = Color3.fromRGB(168, 85, 247)
LangCurrentLabel.TextSize = 13
LangCurrentLabel.Font = Enum.Font.GothamBold
LangCurrentLabel.TextXAlignment = Enum.TextXAlignment.Left
LangCurrentLabel.Parent = LangContent

-- Кнопка Русский
local RuBtn = Instance.new("TextButton")
RuBtn.Size = UDim2.new(1, 0, 0, 40)
RuBtn.Position = UDim2.new(0, 0, 0, 70)
RuBtn.BackgroundColor3 = currentLang == "ru" and Color3.fromRGB(100, 50, 180) or Color3.fromRGB(40, 40, 60)
RuBtn.Text = "🇷🇺 " .. t("langRu")
RuBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
RuBtn.TextSize = 14
RuBtn.Font = Enum.Font.GothamBold
RuBtn.AutoButtonColor = true
RuBtn.Parent = LangContent

local ruCorner = Instance.new("UICorner")
ruCorner.CornerRadius = UDim.new(0, 8)
ruCorner.Parent = RuBtn

local ruStroke = Instance.new("UIStroke")
ruStroke.Color = Color3.fromRGB(168, 85, 247)
ruStroke.Thickness = 2
ruStroke.Transparency = currentLang == "ru" and 0 or 0.5
ruStroke.Parent = RuBtn

-- Кнопка English
local EnBtn = Instance.new("TextButton")
EnBtn.Size = UDim2.new(1, 0, 0, 40)
EnBtn.Position = UDim2.new(0, 0, 0, 120)
EnBtn.BackgroundColor3 = currentLang == "en" and Color3.fromRGB(100, 50, 180) or Color3.fromRGB(40, 40, 60)
EnBtn.Text = "🇬🇧 " .. t("langEn")
EnBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
EnBtn.TextSize = 14
EnBtn.Font = Enum.Font.GothamBold
EnBtn.AutoButtonColor = true
EnBtn.Parent = LangContent

local enCorner = Instance.new("UICorner")
enCorner.CornerRadius = UDim.new(0, 8)
enCorner.Parent = EnBtn

local enStroke = Instance.new("UIStroke")
enStroke.Color = Color3.fromRGB(168, 85, 247)
enStroke.Thickness = 2
enStroke.Transparency = currentLang == "en" and 0 or 0.5
enStroke.Parent = EnBtn

-- Функция обновления UI при смене языка
local function updateUILanguage()
    -- Обновляем заголовок
    titleText.Text = t("title")
    
    -- Обновляем вкладки
    HomeTab.Text = t("tabHome")
    BindTab.Text = t("tabBinds")
    LangTab.Text = t("tabLang")
    
    -- Обновляем главную страницу
    HomeBtn.Text = t("tpHome")
    countText.Text = t("selected") .. ": " .. #AllEggs .. "/" .. #AllEggs
    SelectAllBtn.Text = t("all")
    DeselectAllBtn.Text = t("none")
    
    -- Обновляем страницу биндов
    BindTitle.Text = t("bindsTitle")
    BindDesc.Text = t("bindsDesc")
    homeBindTitle.Text = t("tpHomeBind")
    bindLabel.Text = t("currentBind") .. ": " .. (Settings.HomeBind and getKeyName(Settings.HomeBind) or "None")
    bindButton.Text = Settings.HomeBind and getKeyName(Settings.HomeBind) or t("setBind")
    ResetBindBtn.Text = t("resetBind")
    
    -- Обновляем страницу языка
    LangTitle.Text = t("langTitle")
    LangCurrentLabel.Text = t("langCurrent") .. ": " .. (currentLang == "ru" and "Русский" or "English")
    RuBtn.Text = "🇷🇺 " .. t("langRu")
    EnBtn.Text = "🇬🇧 " .. t("langEn")
    
    -- Обновляем кнопки языка
    RuBtn.BackgroundColor3 = currentLang == "ru" and Color3.fromRGB(100, 50, 180) or Color3.fromRGB(40, 40, 60)
    ruStroke.Transparency = currentLang == "ru" and 0 or 0.5
    EnBtn.BackgroundColor3 = currentLang == "en" and Color3.fromRGB(100, 50, 180) or Color3.fromRGB(40, 40, 60)
    enStroke.Transparency = currentLang == "en" and 0 or 0.5
    
    -- Обновляем статус
    statusText.Text = t("online")
    
    -- Обновляем названия яиц в списке
    for i, egg in ipairs(AllEggs) do
        local btn = eggButtons[i]
        if btn then
            btn.nameText.Text = getEggDisplayName(egg.name)
        end
    end
    
    -- Обновляем ESP метки
    for model, data in pairs(espData) do
        if data.billboard then
            local bg = data.billboard:FindFirstChild("Frame")
            if bg then
                local nameLabel = bg:FindFirstChildWhichIsA("TextLabel")
                if nameLabel then
                    nameLabel.Text = getEggDisplayName(model.Name)
                end
            end
        end
    end
end

RuBtn.MouseButton1Click:Connect(function()
    playClickSound()
    currentLang = "ru"
    updateUILanguage()
    showStatus(t("langCurrent") .. ": Русский")
end)

EnBtn.MouseButton1Click:Connect(function()
    playClickSound()
    currentLang = "en"
    updateUILanguage()
    showStatus(t("langCurrent") .. ": English")
end)

-- Перетаскивание
local dragging = false
local dragInput, dragStart, startPos

TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

TitleBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- Изменение размера
local resizing = false
local resizeStart, sizeStart

local ResizeHandle = Instance.new("TextButton")
ResizeHandle.Size = UDim2.new(0, 20, 0, 20)
ResizeHandle.Position = UDim2.new(1, -20, 1, -20)
ResizeHandle.BackgroundColor3 = Color3.fromRGB(100, 100, 150)
ResizeHandle.BackgroundTransparency = 0.5
ResizeHandle.Text = ">"
ResizeHandle.TextColor3 = Color3.fromRGB(200, 200, 220)
ResizeHandle.Font = Enum.Font.GothamBold
ResizeHandle.TextSize = 12
ResizeHandle.AutoButtonColor = true
ResizeHandle.Parent = MainFrame

local resizeCorner = Instance.new("UICorner")
resizeCorner.CornerRadius = UDim.new(0, 4)
resizeCorner.Parent = ResizeHandle

ResizeHandle.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        resizing = true
        resizeStart = input.Position
        sizeStart = MainFrame.Size
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                resizing = false
            end
        end)
    end
end)

ResizeHandle.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and resizing then
        local delta = input.Position - resizeStart
        local newWidth = math.clamp(sizeStart.X.Offset + delta.X, Settings.MinWidth, Settings.MaxWidth)
        local newHeight = math.clamp(sizeStart.Y.Offset + delta.Y, Settings.MinHeight, Settings.MaxHeight)
        MainFrame.Size = UDim2.new(0, newWidth, 0, newHeight)
    end
end)

-- Статус-бар
local StatusBar = Instance.new("Frame")
StatusBar.Size = UDim2.new(1, -20, 0, 24)
StatusBar.Position = UDim2.new(0, 10, 1, -28)
StatusBar.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
StatusBar.BorderSizePixel = 0
StatusBar.Parent = MainFrame
local statusCorner = Instance.new("UICorner")
statusCorner.CornerRadius = UDim.new(0, 5)
statusCorner.Parent = StatusBar
local statusText = Instance.new("TextLabel")
statusText.Size = UDim2.new(1, -10, 1, 0)
statusText.Position = UDim2.new(0, 10, 0, 0)
statusText.BackgroundTransparency = 1
statusText.Text = t("online")
statusText.TextColor3 = Color3.fromRGB(100, 200, 120)
statusText.TextSize = 11
statusText.Font = Enum.Font.GothamBold
statusText.TextXAlignment = Enum.TextXAlignment.Left
statusText.Parent = StatusBar

local statusExpiresAt = 0

function showStatus(msg, duration)
    duration = duration or 3
    statusText.Text = msg
    statusExpiresAt = os.clock() + duration
end

-- Свернуть
local isMinimized = false
local normalSize = UDim2.new(0, 380, 0, 600)
local minimizedSize = UDim2.new(0, 380, 0, 40)

MinimizeBtn.MouseButton1Click:Connect(function()
    playClickSound()
    isMinimized = not isMinimized
    if isMinimized then
        TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = minimizedSize}):Play()
        task.wait(0.3)
        ContentFrame.Visible = false
        StatusBar.Visible = false
        ResizeHandle.Visible = false
        TabBar.Visible = false
        MinimizeBtn.Text = "+"
    else
        ContentFrame.Visible = true
        StatusBar.Visible = true
        ResizeHandle.Visible = true
        TabBar.Visible = true
        TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = normalSize}):Play()
        MinimizeBtn.Text = "_"
    end
end)

-- Закрытие
local Running = true

local function shutdown()
    playClickSound()
    Running = false
    for model, data in pairs(espData) do
        if data.billboard then data.billboard:Destroy() end
        if data.highlight then data.highlight:Destroy() end
    end
    espData = {}
    if screenGui then screenGui:Destroy() end
    print("[EggTracker] " .. t("closed"))
end

CloseBtn.MouseButton1Click:Connect(shutdown)

HomeBtn.MouseButton1Click:Connect(function()
    playClickSound()
    if not Running then return end
    teleportToBase()
end)

-- Уведомления
local notifFrame = Instance.new("Frame")
notifFrame.Size = UDim2.new(0, 240, 0, 250)
notifFrame.Position = UDim2.new(1, -250, 0, 10)
notifFrame.BackgroundTransparency = 1
notifFrame.Parent = screenGui

local notifLayout = Instance.new("UIListLayout")
notifLayout.Padding = UDim.new(0, 3)
notifLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
notifLayout.Parent = notifFrame

local function showNotification(eggName)
    if not Settings.ShowNotifications then return end
    local notif = Instance.new("Frame")
    notif.Size = UDim2.new(1, 0, 0, 35)
    notif.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
    notif.BackgroundTransparency = 0.15
    notif.BorderSizePixel = 0
    notif.Parent = notifFrame
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = notif
    local stroke = Instance.new("UIStroke")
    stroke.Color = Settings.ESPColor
    stroke.Thickness = 1.5
    stroke.Transparency = 0.3
    stroke.Parent = notif
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -10, 1, 0)
    title.Position = UDim2.new(0, 8, 0, 0)
    title.BackgroundTransparency = 1
    title.Text = getEggDisplayName(eggName) .. " " .. t("found")
    title.TextColor3 = Settings.ESPColor
    title.TextSize = 12
    title.Font = Enum.Font.GothamBold
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = notif
    TweenService:Create(notif, TweenInfo.new(0.3), {BackgroundTransparency = 0.15}):Play()
    if Settings.PlaySound then
        local sound = Instance.new("Sound")
        sound.SoundId = "rbxassetid://1841083655"
        sound.Volume = 0.3
        sound.Parent = SoundService
        sound:Play()
        Debris:AddItem(sound, 2)
    end
    task.delay(3, function()
        if notif and notif.Parent then
            local fade = TweenService:Create(notif, TweenInfo.new(0.5), {BackgroundTransparency = 1})
            fade:Play()
            fade.Completed:Connect(function()
                if notif then notif:Destroy() end
            end)
        end
    end)
end

-- ESP
espData = {}
local notifiedEggs = {}

local function getRootPart(model)
    if not model or not model:IsA("Model") then return nil end
    if model.PrimaryPart and model.PrimaryPart:IsA("BasePart") then return model.PrimaryPart end
    return model:FindFirstChild("HumanoidRootPart") or model:FindFirstChild("RootPart") or model:FindFirstChild("Handle") or model:FindFirstChildWhichIsA("BasePart", true)
end

local function isTracked(eggName)
    for _, egg in ipairs(AllEggs) do
        if egg.name == eggName and egg.enabled then return true end
    end
    return false
end

local function createESP(model)
    if not model or not model:IsA("Model") then return end
    if espData[model] then return end
    local root = getRootPart(model)
    if not root then return end
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "EggTrackerESP"
    billboard.Size = UDim2.new(0, 180, 0, 45)
    billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.AlwaysOnTop = true
    billboard.Adornee = root
    billboard.Enabled = Settings.ShowESP
    billboard.Parent = root
    local bg = Instance.new("Frame")
    bg.Size = UDim2.new(1, 0, 1, 0)
    bg.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
    bg.BackgroundTransparency = 0.25
    bg.Parent = billboard
    local bgCorner = Instance.new("UICorner")
    bgCorner.CornerRadius = UDim.new(0, 6)
    bgCorner.Parent = bg
    local bgStroke = Instance.new("UIStroke")
    bgStroke.Color = Settings.ESPColor
    bgStroke.Thickness = 1.5
    bgStroke.Parent = bg
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, 0, 0.5, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = getEggDisplayName(model.Name)
    nameLabel.TextColor3 = Settings.ESPColor
    nameLabel.TextSize = Settings.TextSize
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.Parent = bg
    local distLabel = Instance.new("TextLabel")
    distLabel.Size = UDim2.new(1, 0, 0.5, 0)
    distLabel.Position = UDim2.new(0, 0, 0.5, 0)
    distLabel.BackgroundTransparency = 1
    distLabel.TextColor3 = Color3.fromRGB(180, 180, 190)
    distLabel.TextSize = Settings.TextSize - 2
    distLabel.Font = Enum.Font.Gotham
    distLabel.Text = ""
    distLabel.Parent = bg
    local highlight = nil
    if Settings.ShowHighlight then
        highlight = Instance.new("Highlight")
        highlight.Name = "EggTrackerHighlight"
        highlight.FillColor = Settings.ESPColor
        highlight.FillTransparency = 0.7
        highlight.OutlineColor = Settings.ESPColor
        highlight.OutlineTransparency = 0
        highlight.Adornee = model
        highlight.Enabled = Settings.ShowESP
        highlight.Parent = model
    end
    espData[model] = {billboard = billboard, distLabel = distLabel, highlight = highlight, root = root}
end

local function removeESP(model)
    local data = espData[model]
    if not data then return end
    if data.billboard then data.billboard:Destroy() end
    if data.highlight then data.highlight:Destroy() end
    espData[model] = nil
end

local function processEgg(model)
    if not Running then return end
    if not model or not model:IsA("Model") then return end
    if not model.Parent then return end
    if not model:IsDescendantOf(RenderedEggs) then return end
    local eggName = model.Name
    if not isTracked(eggName) then return end
    local root = getRootPart(model)
    if not root then
        task.wait(0.5)
        root = getRootPart(model)
        if not root then return end
    end
    createESP(model)
    if not notifiedEggs[model] then
        notifiedEggs[model] = true
        showNotification(eggName)
        print("[EggTracker] " .. getEggDisplayName(eggName) .. " " .. t("found"))
    end
end

local function scanAll()
    if not Running then return end
    for _, obj in ipairs(RenderedEggs:GetDescendants()) do
        if obj:IsA("Model") then processEgg(obj) end
    end
end

function refreshESP()
    for model, data in pairs(espData) do
        if not isTracked(model.Name) then
            removeESP(model)
            notifiedEggs[model] = nil
        end
    end
    scanAll()
end

RenderedEggs.DescendantAdded:Connect(function(obj)
    if obj:IsA("Model") then
        task.wait(0.3)
        processEgg(obj)
    end
end)

RenderedEggs.DescendantRemoving:Connect(function(obj)
    if obj:IsA("Model") and espData[obj] then
        removeESP(obj)
        notifiedEggs[obj] = nil
    end
end)

task.spawn(function()
    task.wait(2)
    scanAll()
    findMyPlot()
    showStatus(t("online") .. " | " .. (cachedMyPlot and t("baseFound") or t("baseNotFound")), 4)
    print("[EggTracker] GUI v15 " .. t("loaded"))
    while Running do
        local char = player.Character
        local rootPart = char and (char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("UpperTorso"))
        for model, data in pairs(espData) do
            if not model.Parent or not model:IsDescendantOf(RenderedEggs) then
                removeESP(model)
            end
        end
        if rootPart then
            for model, data in pairs(espData) do
                if data.root and data.root.Parent then
                    local dist = (rootPart.Position - data.root.Position).Magnitude
                    if Settings.ShowDistance then
                        data.distLabel.Text = string.format("%d studs", math.floor(dist))
                    end
                end
            end
        end
        if os.clock() >= statusExpiresAt then
            local bindInfo = ""
            if Settings.HomeBind then
                bindInfo = " | " .. t("currentBind") .. ": " .. getKeyName(Settings.HomeBind)
            end
            statusText.Text = t("online") .. " | " .. #espData .. bindInfo
            statusText.TextColor3 = Color3.fromRGB(100, 200, 120)
        end
        task.wait(Settings.UpdateInterval)
    end
end)

print("[EggTracker] v15 Ready!")

-- KIMQETRAS HC v2.1 - SINGLE CLEAN BUILD
-- Stable backend + one v2.1 interface pass.
-- Matcha + pink + white interface. No mascot/paw decorations and no stitching.
-- Legacy visual/theme layers are removed so clicks do not trigger stacked recolor handlers.


-- v2.1 decal assets (Roblox Open Use assets)
local KIMQ_V26_ASSETS = {
    Paw = "rbxassetid://138088505213748",
    Title = "rbxassetid://99152748483206",
    Subtitle = "rbxassetid://94248590271491",
    Minus = "rbxassetid://121030051960124",
    Close = "rbxassetid://129350478207195",
    ToggleOn = "rbxassetid://95234565377817",
    ToggleOff = "rbxassetid://97764595221865",
    Reset = "rbxassetid://104585185562435",
}

-- Working safe backend + completely reorganized feature pages.

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local lp = Players.LocalPlayer
local playerGui = lp:WaitForChild("PlayerGui")

pcall(function()
    for _, root in ipairs({CoreGui, playerGui}) do
        local old = root:FindFirstChild("KimpetrasHC")
        if old then old:Destroy() end
        local oldBoot = root:FindFirstChild("KimpetrasHC_Boot")
        if oldBoot then oldBoot:Destroy() end
    end
end)

local LIME = Color3.fromRGB(217, 255, 232) -- #D9FFE8 matcha
local LIME2 = Color3.fromRGB(236, 255, 243) -- soft matcha
local PINK = Color3.fromRGB(243, 161, 211) -- readable candy-pink accent
local PINK2 = Color3.fromRGB(255, 212, 243) -- #FFD4F3 light pink
local INK = Color3.fromRGB(82, 116, 94)
local SOFT = Color3.fromRGB(122, 153, 133)
local WHITE = Color3.fromRGB(255, 255, 255)

local BootGui = Instance.new("ScreenGui")
BootGui.Name = "KimpetrasHC_Boot"
BootGui.ResetOnSpawn = false
BootGui.IgnoreGuiInset = true
BootGui.DisplayOrder = 999999
pcall(function() BootGui.Parent = CoreGui end)
if not BootGui.Parent then BootGui.Parent = playerGui end

local Shade = Instance.new("Frame", BootGui)
Shade.Size = UDim2.fromScale(1, 1)
Shade.BackgroundColor3 = LIME
Shade.BorderSizePixel = 0
local ShadeGradient = Instance.new("UIGradient", Shade)
ShadeGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(250,255,252)),
    ColorSequenceKeypoint.new(.55, LIME),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255,242,251)),
})
ShadeGradient.Rotation = 22

local Panel = Instance.new("Frame", Shade)
Panel.AnchorPoint = Vector2.new(0.5, 0.5)
Panel.Position = UDim2.fromScale(0.5, 0.5)
Panel.Size = UDim2.fromOffset(470, 230)
Panel.BackgroundColor3 = WHITE
Panel.BorderSizePixel = 0
Instance.new("UICorner", Panel).CornerRadius = UDim.new(0, 26)
local BootStroke = Instance.new("UIStroke", Panel)
BootStroke.Color = PINK
BootStroke.Thickness = 2
BootStroke.Transparency = 0.18

-- simple loader: no floating decorations

local Avatar = Instance.new("ImageLabel", Panel)
Avatar.Size = UDim2.fromOffset(58, 58)
Avatar.Position = UDim2.fromOffset(28, 28)
Avatar.BackgroundColor3 = LIME
Avatar.BorderSizePixel = 0
Instance.new("UICorner", Avatar).CornerRadius = UDim.new(1, 0)
local AvatarStroke = Instance.new("UIStroke", Avatar)
AvatarStroke.Color = PINK2
AvatarStroke.Transparency = 0.18
AvatarStroke.Thickness = 2
pcall(function()
    Avatar.Image = Players:GetUserThumbnailAsync(lp.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size180x180)
end)

local Heart = Instance.new("TextLabel", Panel)
Heart.Size = UDim2.fromOffset(34, 34)
Heart.Position = UDim2.new(1, -58, 0, 28)
Heart.BackgroundTransparency = 1
Heart.Text = "♡"
Heart.TextColor3 = PINK
Heart.Font = Enum.Font.FredokaOne
Heart.TextSize = 29

local Title = Instance.new("TextLabel", Panel)
Title.Size = UDim2.new(1, -150, 0, 38)
Title.Position = UDim2.fromOffset(96, 26)
Title.BackgroundTransparency = 1
Title.Text = "Kimqetras HC"
Title.TextColor3 = PINK
Title.Font = Enum.Font.FredokaOne
Title.TextSize = 28
Title.TextXAlignment = Enum.TextXAlignment.Left

local Hello = Instance.new("TextLabel", Panel)
Hello.Size = UDim2.new(1, -150, 0, 20)
Hello.Position = UDim2.fromOffset(98, 61)
Hello.BackgroundTransparency = 1
Hello.Text = "v2.1  •  cute + simple ♡"
Hello.TextColor3 = Color3.fromRGB(116, 145, 86)
Hello.Font = Enum.Font.GothamSemibold
Hello.TextSize = 11
Hello.TextXAlignment = Enum.TextXAlignment.Left

local Status = Instance.new("TextLabel", Panel)
Status.Size = UDim2.new(1, -48, 0, 42)
Status.Position = UDim2.fromOffset(24, 112)
Status.BackgroundTransparency = 1
Status.Text = "loading..."
Status.TextColor3 = INK
Status.Font = Enum.Font.GothamSemibold
Status.TextSize = 13
Status.TextWrapped = true
Status.TextXAlignment = Enum.TextXAlignment.Center
Status.TextYAlignment = Enum.TextYAlignment.Center

local BarBack = Instance.new("Frame", Panel)
BarBack.Size = UDim2.new(1, -72, 0, 12)
BarBack.Position = UDim2.new(0, 36, 1, -42)
BarBack.BackgroundColor3 = PINK2
BarBack.BorderSizePixel = 0
Instance.new("UICorner", BarBack).CornerRadius = UDim.new(1, 0)

local Bar = Instance.new("Frame", BarBack)
Bar.Size = UDim2.new(0.03, 0, 1, 0)
Bar.BackgroundColor3 = PINK
Bar.BorderSizePixel = 0
Instance.new("UICorner", Bar).CornerRadius = UDim.new(1, 0)


local failures = {}
local completed = 0
local total = 6

local function setProgress(name)
    completed += 1
    local amount = math.clamp(completed / total, 0, 1)
    TweenService:Create(Bar, TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Size = UDim2.new(amount, 0, 1, 0)
    }):Play()
    Status.Text = "loading " .. name .. "..."
end

local function runChunk(name, source, required)
    setProgress(name)
    task.wait(0.03)
    local fn, compileErr = loadstring(source)
    if not fn then
        local msg = name .. " COMPILE: " .. tostring(compileErr)
        table.insert(failures, msg)
        Status.Text = msg
        if required then
            Status.Text = Status.Text .. "\ncore could not compile"
            return false
        end
        task.wait(0.2)
        return true
    end

    local ok, runtimeErr = pcall(fn)
    if not ok then
        local msg = name .. " RUNTIME: " .. tostring(runtimeErr)
        table.insert(failures, msg)
        Status.Text = msg
        if required then
            Status.Text = Status.Text .. "\ncore could not start"
            return false
        end
        task.wait(0.2)
    end
    return true
end

task.wait(0.08)

if not runChunk("core", [=====[
local UIS = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local lp = Players.LocalPlayer
local cam = workspace.CurrentCamera

-- Shared whitelist used by targeting + ESP
_G.KHWhitelist = _G.KHWhitelist or {}
local mouse = lp:GetMouse()

local cfg = {
    silentAim = true,
    useKeybind = true,
    silentAimKey = Enum.KeyCode.V,
    uiToggleKey = Enum.KeyCode.RightControl,
    silentAimHitChance = 100,
    silentAimFOV = 150,
    silentAimFOVShow = false,
    silentAimFOVFilled = false,
    silentAimFOVOpacity = 0.2,
    silentAimFOVColor = Color3.fromRGB(255, 20, 147),
    
    silentAimPart = "Head",
    silentAimClosestPart = false,
    
    silentAimTeamCheck = false,
    silentAimWallCheck = false,
    silentAimMaxDist = 1000,
    
    silentAimPredX = 0,
    silentAimPredY = 0,
    
    bypassRevolver = false,
}

local bodyPartsList = {
    "Head", "UpperTorso", "HumanoidRootPart", "LowerTorso",
    "LeftUpperArm", "RightUpperArm", "LeftLowerArm", "RightLowerArm",
    "LeftHand", "RightHand", "LeftUpperLeg", "RightUpperLeg",
    "LeftLowerLeg", "RightLowerLeg", "LeftFoot", "RightFoot"
}


local fovCircle = {
    Thickness = 1.5,
    NumSides = 64,
    Radius = cfg.silentAimFOV,
    Color = cfg.silentAimFOVColor,
    Filled = cfg.silentAimFOVFilled,
    Visible = false,
    Transparency = 1 - cfg.silentAimFOVOpacity,
    Position = Vector2.new(0, 0),
}
if type(Drawing) == "table" and type(Drawing.new) == "function" then
    pcall(function()
        local realCircle = Drawing.new("Circle")
        realCircle.Thickness = 1.5
        realCircle.NumSides = 64
        realCircle.Radius = cfg.silentAimFOV
        realCircle.Color = cfg.silentAimFOVColor
        realCircle.Filled = cfg.silentAimFOVFilled
        realCircle.Visible = cfg.silentAimFOVShow
        realCircle.Transparency = 1 - cfg.silentAimFOVOpacity
        fovCircle = realCircle
    end)
end

local silentAimCachedPart = nil

local function isHoldingRevolver()
    if not cfg.bypassRevolver then return false end
    local char = lp.Character
    if not char then return false end
    
    local tool = char:FindFirstChildOfClass("Tool")
    if tool then
        local toolName = string.lower(tool.Name)
        if string.find(toolName, "revolver") or string.find(toolName, "rev") then
            return true
        end
    end
    return false
end

local function getHum(p)
    local c = p and p.Character
    return c and c:FindFirstChildOfClass("Humanoid")
end

local function getHRP(p)
    local c = p and p.Character
    return c and c:FindFirstChild("HumanoidRootPart")
end

local function isAlive(p)
    local h = getHum(p)
    return h and h.Health > 0
end

local function sameTeam(p)
    return lp.Team and p.Team and lp.Team == p.Team
end

local function wallBetween(pos)
    if not cfg.silentAimWallCheck then return false end
    local ro = cam.CFrame.Position
    local rd = pos - ro
    local params = RaycastParams.new()
    params.FilterDescendantsInstances = {lp.Character}
    params.FilterType = Enum.RaycastFilterType.Exclude
    local hit = workspace:Raycast(ro, rd, params)
    if not hit then return false end
    for _, p in pairs(Players:GetPlayers()) do
        if p.Character and hit.Instance:IsDescendantOf(p.Character) then return false end
    end
    return true
end

local function safeWorldToViewportPoint(pos)
    local sp, on = Vector3.new(), false
    pcall(function()
        sp, on = cam:WorldToViewportPoint(pos)
    end)
    return sp, on
end

local function getClosestBodyPart(char)
    local closestPart, shortestDist = nil, math.huge
    local mousePos = UIS:GetMouseLocation()
    for _, pName in ipairs(bodyPartsList) do
        local part = char:FindFirstChild(pName)
        if part then
            local screenPos, onScreen = safeWorldToViewportPoint(part.Position)
            local dist = onScreen and (Vector2.new(screenPos.X, screenPos.Y) - mousePos).Magnitude or math.huge
            if dist < shortestDist then
                shortestDist = dist
                closestPart = part
            end
        end
    end
    return closestPart or char:FindFirstChild("Head") or char:FindFirstChild("HumanoidRootPart")
end

local function getTargetPart(char)
    if not char then return nil end
    if cfg.silentAimClosestPart then
        return getClosestBodyPart(char)
    end
    return char:FindFirstChild(cfg.silentAimPart) or char:FindFirstChild("Head") or char:FindFirstChild("HumanoidRootPart")
end

local function getClosestPlayerToCursor()
    if isHoldingRevolver() then return nil end
    
    local closestPlayer = nil
    local shortestDist = cfg.silentAimFOV
    local mousePos = UIS:GetMouseLocation()

    for _, p in pairs(Players:GetPlayers()) do
        if p ~= lp and not _G.KHWhitelist[p.UserId] and isAlive(p) then
            if cfg.silentAimTeamCheck and sameTeam(p) then continue end
            local hrp = getHRP(p)
            if hrp then
                local dist3D = (hrp.Position - cam.CFrame.Position).Magnitude
                if dist3D <= cfg.silentAimMaxDist then
                    local sp, onScreen = safeWorldToViewportPoint(hrp.Position)
                    if onScreen then
                        local dist2D = (Vector2.new(sp.X, sp.Y) - mousePos).Magnitude
                        if dist2D < shortestDist then
                            local part = getTargetPart(p.Character)
                            if part and not wallBetween(part.Position) then
                                shortestDist = dist2D
                                closestPlayer = part
                            end
                        end
                    end
                end
            end
        end
    end
    return closestPlayer
end

-- HOOK METAMETHOD (safe: unsupported executor APIs no longer stop the GUI)
pcall(function()
    if type(getrawmetatable) ~= "function" or type(setreadonly) ~= "function" or type(checkcaller) ~= "function" then
        return
    end
    local _grm = getrawmetatable(game)
    local _oldIndex = _grm.__index
    setreadonly(_grm, false)

    _grm.__index = function(self, key)
        if not checkcaller() and self == mouse and cfg.silentAim and not isHoldingRevolver() then
            if (key == "Hit" or key == "Target" or key == "UnitRay") and silentAimCachedPart then
                if math.random(1, 100) <= cfg.silentAimHitChance then
                    local origin = cam.CFrame.Position
                    local hitPos = silentAimCachedPart.Position + Vector3.new(
                        silentAimCachedPart.AssemblyLinearVelocity.X * cfg.silentAimPredX,
                        silentAimCachedPart.AssemblyLinearVelocity.Y * cfg.silentAimPredY,
                        silentAimCachedPart.AssemblyLinearVelocity.Z * cfg.silentAimPredX
                    )
                    if key == "UnitRay" then
                        return Ray.new(origin, (hitPos - origin).Unit)
                    elseif key == "Hit" then
                        return CFrame.new(hitPos)
                    elseif key == "Target" then
                        return silentAimCachedPart
                    end
                end
            end
        end
        return _oldIndex(self, key)
    end
    setreadonly(_grm, true)
end)

RunService.RenderStepped:Connect(function()
    local mousePos = UIS:GetMouseLocation()
    fovCircle.Position = mousePos
    fovCircle.Radius = cfg.silentAimFOV
    fovCircle.Color = cfg.silentAimFOVColor
    fovCircle.Visible = cfg.silentAim and cfg.silentAimFOVShow and not isHoldingRevolver()

    if cfg.silentAim then
        silentAimCachedPart = getClosestPlayerToCursor()
    else
        silentAimCachedPart = nil
    end
end)


local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KimpetrasHC"
ScreenGui.ResetOnSpawn = false
-- Keep the unfinished legacy/base interface completely hidden while all redesign passes build.
ScreenGui.Enabled = false
pcall(function() ScreenGui.Parent = CoreGui end)
if not ScreenGui.Parent then ScreenGui.Parent = lp:WaitForChild("PlayerGui") end

local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Size = UDim2.new(0, 980, 0, 620)
Main.Position = UDim2.new(0.5, -490, 0.5, -310)
Main.BackgroundColor3 = Color3.fromRGB(255, 214, 232)
Main.BorderSizePixel = 0
Main.Active = true
Main.Parent = ScreenGui


-- Drag only from the small bottom-right corner handle.
local dragging, dragInput, dragStart, startPos

local DragCorner = Instance.new("TextButton", Main)
DragCorner.Name = "DragCorner"
DragCorner.Size = UDim2.fromOffset(34,34)
DragCorner.Position = UDim2.new(1,-40,1,-40)
DragCorner.BackgroundTransparency = 1
DragCorner.Text = ""
DragCorner.AutoButtonColor = false
DragCorner.ZIndex = 20

-- tiny cute corner grip
for i=0,2 do
    local dot = Instance.new("Frame", DragCorner)
    dot.Size = UDim2.fromOffset(4,4)
    dot.Position = UDim2.new(1,-8-i*7,1,-8)
    dot.BackgroundColor3 = Color3.fromRGB(255, 20, 147)
    dot.BorderSizePixel = 0
    dot.ZIndex = 21
    Instance.new("UICorner", dot).CornerRadius = UDim.new(1,0)
end

local function updateDrag(input)
    local delta = input.Position - dragStart
    local newX = startPos.X.Offset + delta.X
    local newY = startPos.Y.Offset + delta.Y
    local viewport = cam.ViewportSize
    newX = math.clamp(newX, 0, math.max(0, viewport.X - Main.AbsoluteSize.X))
    newY = math.clamp(newY, 0, math.max(0, viewport.Y - Main.AbsoluteSize.Y))
    Main.Position = UDim2.new(0, newX, 0, newY)
end

DragCorner.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = Main.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

DragCorner.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UIS.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        updateDrag(input)
    end
end)

local UICorner = Instance.new("UICorner", Main)
UICorner.CornerRadius = UDim.new(0, 14)

local UIStroke = Instance.new("UIStroke", Main)
UIStroke.Color = Color3.fromRGB(255, 20, 147)
UIStroke.Thickness = 2

local Header = Instance.new("Frame", Main)
Header.Name = "Header"
Header.Size = UDim2.new(1, 0, 0, 48)
Header.BackgroundTransparency = 1

-- No logo/image in the header: branding is text-only.
for _, child in ipairs(Header:GetChildren()) do
    if child:IsA("ImageLabel") or child:IsA("ImageButton") then
        child:Destroy()
    end
end

local Title = Instance.new("TextLabel", Header)
Title.Size = UDim2.new(1, -70, 1, 0)
Title.Position = UDim2.new(0, 16, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "Kimpetras HC"
Title.TextColor3 = Color3.fromRGB(230, 40, 135)
Title.TextSize = 18
Title.Font = Enum.Font.FredokaOne
Title.TextXAlignment = Enum.TextXAlignment.Left


local MinimizeBtn = Instance.new("TextButton", Header)
MinimizeBtn.Size = UDim2.new(0, 26, 0, 26)
MinimizeBtn.Position = UDim2.new(1, -36, 0.5, -13)
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(255, 175, 215)
MinimizeBtn.Text = "-"
MinimizeBtn.TextColor3 = Color3.fromRGB(230, 40, 135)
MinimizeBtn.Font = Enum.Font.FredokaOne
MinimizeBtn.TextSize = 20
MinimizeBtn.AutoButtonColor = false

local MiniCorner = Instance.new("UICorner", MinimizeBtn)
MiniCorner.CornerRadius = UDim.new(0, 8)


local MiniBubble = Instance.new("TextButton", ScreenGui)
MiniBubble.Name = "MiniBubble"
MiniBubble.Size = UDim2.new(0, 48, 0, 48)
MiniBubble.Position = UDim2.new(0.5, -24, 0.5, -24)
MiniBubble.BackgroundColor3 = Color3.fromRGB(255, 211, 230)
MiniBubble.Text = "𝑲"
MiniBubble.TextSize = 25
MiniBubble.TextColor3 = Color3.fromRGB(230, 40, 135)
MiniBubble.Font = Enum.Font.GothamBold
MiniBubble.Visible = false
MiniBubble.Active = true

local bDragging, bDragStart, bStartPos
MiniBubble.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        bDragging = true
        bDragStart = input.Position
        bStartPos = MiniBubble.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                bDragging = false
            end
        end)
    end
end)

UIS.InputChanged:Connect(function(input)
    if bDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - bDragStart
        local newX = math.clamp(bStartPos.X.Offset + delta.X, 0, cam.ViewportSize.X - 48)
        local newY = math.clamp(bStartPos.Y.Offset + delta.Y, 0, cam.ViewportSize.Y - 48)
        MiniBubble.Position = UDim2.new(0, newX, 0, newY)
    end
end)

local BubbleCorner = Instance.new("UICorner", MiniBubble)
BubbleCorner.CornerRadius = UDim.new(1, 0)

local BubbleStroke = Instance.new("UIStroke", MiniBubble)
BubbleStroke.Color = Color3.fromRGB(255, 20, 147)
BubbleStroke.Thickness = 2

local Scroll = Instance.new("ScrollingFrame", Main)
Scroll.Size = UDim2.new(0, 360, 1, -50)
Scroll.Position = UDim2.new(0, 10, 0, 40)
Scroll.BackgroundTransparency = 1
Scroll.BorderSizePixel = 0
Scroll.ScrollBarThickness = 4
Scroll.ScrollBarImageColor3 = Color3.fromRGB(231, 92, 154)

local UIList = Instance.new("UIListLayout", Scroll)
UIList.SortOrder = Enum.SortOrder.LayoutOrder
UIList.Padding = UDim.new(0, 8)

UIList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    Scroll.CanvasSize = UDim2.new(0, 0, 0, UIList.AbsoluteContentSize.Y + 10)
end)


local function minimizeUI()
    local x = math.clamp(Main.AbsolutePosition.X + (Main.AbsoluteSize.X / 2) - 24, 0, cam.ViewportSize.X - 48)
    local y = math.clamp(Main.AbsolutePosition.Y + (Main.AbsoluteSize.Y / 2) - 24, 0, cam.ViewportSize.Y - 48)
    MiniBubble.Position = UDim2.new(0, x, 0, y)
    Main.Visible = false
    MiniBubble.Visible = true
end

local function restoreUI()
    local x = math.clamp(MiniBubble.AbsolutePosition.X - (Main.AbsoluteSize.X / 2) + 24, 0, cam.ViewportSize.X - Main.AbsoluteSize.X)
    local y = math.clamp(MiniBubble.AbsolutePosition.Y - (Main.AbsoluteSize.Y / 2) + 24, 0, cam.ViewportSize.Y - Main.AbsoluteSize.Y)
    Main.Position = UDim2.new(0, x, 0, y)
    MiniBubble.Visible = false
    Main.Visible = true
end

MinimizeBtn.MouseButton1Click:Connect(minimizeUI)
MiniBubble.MouseButton1Click:Connect(restoreUI)

local function createCard(height)
    local card = Instance.new("Frame")
    card.Size = UDim2.new(1, -6, 0, height or 40)
    card.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    card.BorderSizePixel = 0
    card.Parent = Scroll
    
    local c = Instance.new("UICorner", card)
    c.CornerRadius = UDim.new(0, 8)
    
    local s = Instance.new("UIStroke", card)
    s.Color = Color3.fromRGB(255, 212, 243)
    s.Thickness = 1
    return card
end

local function addToggle(text, default, callback)
    local card = createCard(40)
    local lbl = Instance.new("TextLabel", card)
    lbl.Size = UDim2.new(0.7, 0, 1, 0)
    lbl.Position = UDim2.new(0, 10, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.TextColor3 = Color3.fromRGB(82, 116, 94)
    lbl.Font = Enum.Font.SourceSansBold
    lbl.TextSize = 15
    lbl.TextXAlignment = Enum.TextXAlignment.Left

    local btn = Instance.new("TextButton", card)
    btn.Size = UDim2.new(0, 44, 0, 22)
    btn.Position = UDim2.new(1, -54, 0.5, -11)
    btn.BackgroundColor3 = default and Color3.fromRGB(243, 161, 211) or Color3.fromRGB(236, 255, 243)
    btn.Text = ""
    btn.AutoButtonColor = false

    local bc = Instance.new("UICorner", btn)
    bc.CornerRadius = UDim.new(1, 0)

    local circle = Instance.new("Frame", btn)
    circle.Size = UDim2.new(0, 18, 0, 18)
    circle.Position = default and UDim2.new(1, -20, 0.5, -9) or UDim2.new(0, 2, 0.5, -9)
    circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    
    local cc = Instance.new("UICorner", circle)
    cc.CornerRadius = UDim.new(1, 0)

    local state = default
    btn.MouseButton1Click:Connect(function()
        state = not state
        btn.BackgroundColor3 = state and Color3.fromRGB(243, 161, 211) or Color3.fromRGB(236, 255, 243)
        circle:TweenPosition(state and UDim2.new(1, -20, 0.5, -9) or UDim2.new(0, 2, 0.5, -9), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.15, true)
        callback(state)
    end)
end

local function addSlider(text, min, max, default, callback)
    local card = createCard(50)
    
    local lbl = Instance.new("TextLabel", card)
    lbl.Size = UDim2.new(0.6, 0, 0, 20)
    lbl.Position = UDim2.new(0, 10, 0, 4)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.TextColor3 = Color3.fromRGB(82, 116, 94)
    lbl.Font = Enum.Font.SourceSansBold
    lbl.TextSize = 15
    lbl.TextXAlignment = Enum.TextXAlignment.Left

    local valLbl = Instance.new("TextLabel", card)
    valLbl.Size = UDim2.new(0.3, 0, 0, 20)
    valLbl.Position = UDim2.new(0.7, -10, 0, 4)
    valLbl.BackgroundTransparency = 1
    valLbl.Text = tostring(default)
    valLbl.TextColor3 = Color3.fromRGB(212, 105, 169)
    valLbl.Font = Enum.Font.SourceSans
    valLbl.TextSize = 14
    valLbl.TextXAlignment = Enum.TextXAlignment.Right

    local bg = Instance.new("Frame", card)
    bg.Size = UDim2.new(1, -20, 0, 8)
    bg.Position = UDim2.new(0, 10, 0, 30)
    bg.BackgroundColor3 = Color3.fromRGB(255, 212, 243)
    Instance.new("UICorner", bg).CornerRadius = UDim.new(1, 0)

    local fill = Instance.new("Frame", bg)
    fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    fill.BackgroundColor3 = Color3.fromRGB(243, 161, 211)
    Instance.new("UICorner", fill).CornerRadius = UDim.new(1, 0)

    local sDragging = false
    local function update(input)
        local pos = math.clamp((input.Position.X - bg.AbsolutePosition.X) / bg.AbsoluteSize.X, 0, 1)
        local val = math.floor(min + (max - min) * pos)
        fill.Size = UDim2.new(pos, 0, 1, 0)
        valLbl.Text = tostring(val)
        callback(val)
    end

    bg.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            sDragging = true
            update(input)
        end
    end)

    UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            sDragging = false
        end
    end)

    UIS.InputChanged:Connect(function(input)
        if sDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            update(input)
        end
    end)
end

local function addDecimalSlider(text, min, max, default, decimals, callback)
    decimals = decimals or 3
    local card = createCard(50)
    local lbl = Instance.new("TextLabel", card)
    lbl.Size = UDim2.new(0.6, 0, 0, 20)
    lbl.Position = UDim2.new(0, 10, 0, 4)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.TextColor3 = Color3.fromRGB(82, 116, 94)
    lbl.Font = Enum.Font.SourceSansBold
    lbl.TextSize = 15
    lbl.TextXAlignment = Enum.TextXAlignment.Left

    local valLbl = Instance.new("TextLabel", card)
    valLbl.Size = UDim2.new(0.3, 0, 0, 20)
    valLbl.Position = UDim2.new(0.7, -10, 0, 4)
    valLbl.BackgroundTransparency = 1
    valLbl.Text = string.format("%." .. decimals .. "f", default)
    valLbl.TextColor3 = Color3.fromRGB(212, 105, 169)
    valLbl.Font = Enum.Font.SourceSans
    valLbl.TextSize = 14
    valLbl.TextXAlignment = Enum.TextXAlignment.Right

    local bg = Instance.new("Frame", card)
    bg.Size = UDim2.new(1, -20, 0, 8)
    bg.Position = UDim2.new(0, 10, 0, 30)
    bg.BackgroundColor3 = Color3.fromRGB(255, 212, 243)
    Instance.new("UICorner", bg).CornerRadius = UDim.new(1, 0)

    local fill = Instance.new("Frame", bg)
    fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    fill.BackgroundColor3 = Color3.fromRGB(243, 161, 211)
    Instance.new("UICorner", fill).CornerRadius = UDim.new(1, 0)

    local dragging = false
    local scale = 10 ^ decimals
    local function update(input)
        local pos = math.clamp((input.Position.X - bg.AbsolutePosition.X) / bg.AbsoluteSize.X, 0, 1)
        local raw = min + (max - min) * pos
        local val = math.floor(raw * scale + 0.5) / scale
        fill.Size = UDim2.new(pos, 0, 1, 0)
        valLbl.Text = string.format("%." .. decimals .. "f", val)
        callback(val)
    end

    bg.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = true update(input) end
    end)
    UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
    end)
    UIS.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then update(input) end
    end)
end

local function addButton(text, callback)
    local card = createCard(38)
    local btn = Instance.new("TextButton", card)
    btn.Size = UDim2.new(1, -16, 1, -10)
    btn.Position = UDim2.fromOffset(8, 5)
    btn.BackgroundColor3 = Color3.fromRGB(255, 190, 220)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(225, 55, 135)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 14
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    btn.MouseButton1Click:Connect(callback)
    return card, btn
end

local function addDropdown(text, list, default, callback)
    local card = createCard(40)
    
    local lbl = Instance.new("TextLabel", card)
    lbl.Size = UDim2.new(0.4, 0, 1, 0)
    lbl.Position = UDim2.new(0, 10, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.TextColor3 = Color3.fromRGB(82, 116, 94)
    lbl.Font = Enum.Font.SourceSansBold
    lbl.TextSize = 15
    lbl.TextXAlignment = Enum.TextXAlignment.Left

    local btn = Instance.new("TextButton", card)
    btn.Size = UDim2.new(0.55, 0, 0, 26)
    btn.Position = UDim2.new(0.43, 0, 0.5, -13)
    btn.BackgroundColor3 = Color3.fromRGB(255, 190, 220)
    btn.Text = default
    btn.TextColor3 = Color3.fromRGB(230, 40, 135)
    btn.Font = Enum.Font.SourceSans
    btn.TextSize = 14
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    
    local s = Instance.new("UIStroke", btn)
    s.Color = Color3.fromRGB(255, 105, 180)

    local dropFrame = Instance.new("ScrollingFrame", Scroll)
    dropFrame.Size = UDim2.new(1, -6, 0, 120)
    dropFrame.BackgroundColor3 = Color3.fromRGB(255, 225, 238)
    dropFrame.Visible = false
    dropFrame.BorderSizePixel = 0
    dropFrame.ScrollBarThickness = 3
    Instance.new("UICorner", dropFrame).CornerRadius = UDim.new(0, 8)
    
    local dList = Instance.new("UIListLayout", dropFrame)
    dList.SortOrder = Enum.SortOrder.LayoutOrder

    dList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        dropFrame.CanvasSize = UDim2.new(0, 0, 0, dList.AbsoluteContentSize.Y)
    end)

    for _, v in ipairs(list) do
        local item = Instance.new("TextButton", dropFrame)
        item.Size = UDim2.new(1, 0, 0, 24)
        item.BackgroundTransparency = 1
        item.Text = v
        item.TextColor3 = Color3.fromRGB(166, 55, 105)
        item.Font = Enum.Font.SourceSans
        item.TextSize = 13
        
        item.MouseButton1Click:Connect(function()
            btn.Text = v
            dropFrame.Visible = false
            callback(v)
        end)
    end

    btn.MouseButton1Click:Connect(function()
        dropFrame.Visible = not dropFrame.Visible
    end)
end

local function addKeybind(text, defaultKey, callback)
    local card = createCard(40)
    local lbl = Instance.new("TextLabel", card)
    lbl.Size = UDim2.new(0.6, 0, 1, 0)
    lbl.Position = UDim2.new(0, 10, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.TextColor3 = Color3.fromRGB(82, 116, 94)
    lbl.Font = Enum.Font.SourceSansBold
    lbl.TextSize = 15
    lbl.TextXAlignment = Enum.TextXAlignment.Left

    local btn = Instance.new("TextButton", card)
    btn.Size = UDim2.new(0, 80, 0, 24)
    btn.Position = UDim2.new(1, -90, 0.5, -12)
    btn.BackgroundColor3 = Color3.fromRGB(255, 190, 220)
    btn.Text = defaultKey.Name
    btn.TextColor3 = Color3.fromRGB(230, 40, 135)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 12
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    
    local s = Instance.new("UIStroke", btn)
    s.Color = Color3.fromRGB(255, 105, 180)

    local listening = false
    btn.MouseButton1Click:Connect(function()
        listening = true
        btn.Text = "..."
    end)

    UIS.InputBegan:Connect(function(input, gpe)
        if listening and not gpe and input.UserInputType == Enum.UserInputType.Keyboard then
            listening = false
            btn.Text = input.KeyCode.Name
            callback(input.KeyCode)
        end
    end)
end


local SilentHeader = Instance.new("TextLabel", Scroll)
SilentHeader.Size = UDim2.new(1,-6,0,34)
SilentHeader.BackgroundTransparency = 1
SilentHeader.Text = "♥  Silent Aim"
SilentHeader.TextColor3 = Color3.fromRGB(225, 73, 140)
SilentHeader.Font = Enum.Font.GothamBold
SilentHeader.TextSize = 18
SilentHeader.TextXAlignment = Enum.TextXAlignment.Left

addToggle("Silent Aim", cfg.silentAim, function(v) cfg.silentAim = v end)
addToggle("Show FOV Circle", cfg.silentAimFOVShow, function(v) cfg.silentAimFOVShow = v end)
addSlider("FOV Size", 10, 500, cfg.silentAimFOV, function(v) cfg.silentAimFOV = v end)
addToggle("Bypass Revolver", cfg.bypassRevolver, function(v) cfg.bypassRevolver = v end)
addToggle("Wall Check", cfg.silentAimWallCheck, function(v) cfg.silentAimWallCheck = v end)
addToggle("Target Closest Part", cfg.silentAimClosestPart, function(v) cfg.silentAimClosestPart = v end)
addDropdown("HitPart (16 Parts)", bodyPartsList, cfg.silentAimPart, function(v) cfg.silentAimPart = v end)
addToggle("Enable Keybind", cfg.useKeybind, function(v) cfg.useKeybind = v end)
addKeybind("Toggle Aim Key", cfg.silentAimKey, function(v) cfg.silentAimKey = v end)
addKeybind("Hide/Show UI Key", cfg.uiToggleKey, function(v) cfg.uiToggleKey = v end)


_G.KimpetrasCtx = {
    UIS = UIS,
    Players = Players,
    RunService = RunService,
    CoreGui = CoreGui,
    lp = lp,
    cam = cam,
    mouse = mouse,
    cfg = cfg,
    ScreenGui = ScreenGui,
    Main = Main,
    Scroll = Scroll,
    createCard = createCard,
    addToggle = addToggle,
    addSlider = addSlider,
    addDecimalSlider = addDecimalSlider,
    addButton = addButton,
    addDropdown = addDropdown,
    addKeybind = addKeybind,
}

]=====], true) then return end

if not runChunk("macro", [=====[
local C = _G.KimpetrasCtx
if not C then error("Kimpetras core context missing") end
local UIS, RunService, lp, Scroll = C.UIS, C.RunService, C.lp, C.Scroll
local createCard, addToggle, addSlider, addKeybind = C.createCard, C.addToggle, C.addSlider, C.addKeybind
-- ========================================================
-- MACRO / SPEED - MERGED FROM PWD.MAIN MISC > SPEED
-- ========================================================

local MacroMaster = false
local MacroActive = false
local MacroSpeed = 50
local MacroKey = Enum.KeyCode.X

local MacroHeader = Instance.new("TextLabel", Scroll)
MacroHeader.Size = UDim2.new(1,-6,0,34)
MacroHeader.BackgroundTransparency = 1
MacroHeader.Text = "♥  Macro"
MacroHeader.TextColor3 = Color3.fromRGB(225, 73, 140)
MacroHeader.Font = Enum.Font.GothamBold
MacroHeader.TextSize = 18
MacroHeader.TextXAlignment = Enum.TextXAlignment.Left

addToggle("Macro / Speed Master", MacroMaster, function(v)
    MacroMaster = v
    if not MacroMaster then
        MacroActive = false
    end
end)

addKeybind("Macro Key", MacroKey, function(v)
    MacroKey = v
end)

addSlider("Macro Speed", 16, 1000, MacroSpeed, function(v)
    MacroSpeed = v
end)

local MacroHintCard = createCard(34)
local MacroHint = Instance.new("TextLabel", MacroHintCard)
MacroHint.Size = UDim2.new(1,-20,1,0)
MacroHint.Position = UDim2.fromOffset(10,0)
MacroHint.BackgroundTransparency = 1
MacroHint.Text = "Turn Master on, then press the Macro Key"
MacroHint.TextColor3 = Color3.fromRGB(197, 112, 145)
MacroHint.Font = Enum.Font.Gotham
MacroHint.TextSize = 12
MacroHint.TextXAlignment = Enum.TextXAlignment.Left

UIS.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == MacroKey then
        if MacroMaster then
            MacroActive = not MacroActive
        end
    end
end)

RunService.Heartbeat:Connect(function()
    if MacroMaster and MacroActive and lp.Character then
        local hum = lp.Character:FindFirstChildOfClass("Humanoid")
        if hum and hum.WalkSpeed ~= MacroSpeed then
            hum.WalkSpeed = MacroSpeed
        end
    end
end)


]=====], false) then return end

if not runChunk("extras", [=====[
local C = _G.KimpetrasCtx
if not C then error("Kimpetras core context missing") end
local Players, RunService, lp, cam, Scroll = C.Players, C.RunService, C.lp, C.cam, C.Scroll
local createCard, addToggle, addDecimalSlider, addButton = C.createCard, C.addToggle, C.addDecimalSlider, C.addButton
-- ========================================================
-- PWD.CHAR / AVATAR - MERGED INTO KIMQETRAS
-- ========================================================

local AvatarEnabled = false
local AvatarHeadless = false
local AvatarTarget = ""

-- ========================================================
-- EXTRA FEATURES FROM DOCUMENT (3)
-- Whitelist / Protection / Anti Fall / Delay Changer / ESP
-- ========================================================

local ExtraAntiAimView = true
local ExtraAntiFall = true
local ExtraDelayChanger = false
local ExtraDelayRevolver = 0.03
local ExtraDelayDoubleBarrel = 0.3
local ExtraDelayTactical = 0.0
local ExtraDelayOthers = 0.095

local ExtraESPEnabled = false
local ExtraESPBoxes = false
local ExtraESPNames = false
local ExtraESPDistance = false
local ExtraESPHealth = false
local ExtraESPTracer = false
local ExtraESPSkeleton = false
local ExtraESPColor = _G.KimqESPColor or Color3.fromRGB(243, 161, 211)
_G.KimqESPColor = ExtraESPColor
_G.KimqSetESPColor = function(color)
    if typeof(color) == "Color3" then
        ExtraESPColor = color
        _G.KimqESPColor = color
    end
end

-- Anti Aim View logic adapted from document (3)
local extraAntiAimConnections = {}
local function setExtraAntiAimView(enable)
    ExtraAntiAimView = enable
    for _, conn in ipairs(extraAntiAimConnections) do
        pcall(function() conn:Disconnect() end)
    end
    extraAntiAimConnections = {}
    if not enable then return end

    local dataFolder = lp:FindFirstChild("DataFolder") or lp:WaitForChild("DataFolder", 5)
    if not dataFolder then return end

    local shotLand = dataFolder:FindFirstChild("ShotLand")
    local shotTotal = dataFolder:FindFirstChild("ShotTotal")
    local warning = dataFolder:FindFirstChild("Warning")
    local lockFlagged = dataFolder:FindFirstChild("LockFlagged")

    local function safeConnect(obj, callback)
        if obj then
            local c = obj:GetPropertyChangedSignal("Value"):Connect(callback)
            table.insert(extraAntiAimConnections, c)
        end
    end

    safeConnect(shotTotal, function()
        if shotTotal and shotLand and shotTotal.Value > 0 then
            shotLand.Value = 0
        end
    end)
    safeConnect(warning, function() if warning then warning.Value = 0 end end)
    safeConnect(lockFlagged, function() if lockFlagged then lockFlagged.Value = 0 end end)

    local function hookCharacter(char)
        local bodyEffects = char:FindFirstChild("BodyEffects")
        if not bodyEffects then return end
        local gunFiring = bodyEffects:FindFirstChild("GunFiring")
        local gunShotChanges = bodyEffects:FindFirstChild("GunShotChanges")
        safeConnect(gunFiring, function() if gunFiring then gunFiring.Value = false end end)
        safeConnect(gunShotChanges, function() if gunShotChanges then gunShotChanges.Value = 0 end end)
    end

    if lp.Character then hookCharacter(lp.Character) end
    table.insert(extraAntiAimConnections, lp.CharacterAdded:Connect(function(char)
        task.wait(0.25)
        hookCharacter(char)
    end))
end

-- Anti Fall logic from document (3)
RunService.Heartbeat:Connect(function()
    if ExtraAntiFall and lp.Character then
        local hum = lp.Character:FindFirstChildOfClass("Humanoid")
        if hum and hum.Health > 1 and hum:GetState() == Enum.HumanoidStateType.FallingDown then
            hum:ChangeState(Enum.HumanoidStateType.GettingUp)
        end
    end
end)

-- Delay Changer logic adapted from document (3)
local extraDelayConnections = setmetatable({}, {__mode = "k"})
local function getExtraDelayForValue(v)
    local tool = v:FindFirstAncestorOfClass("Tool")
    if tool then
        if tool.Name == "[Revolver]" then return ExtraDelayRevolver end
        if tool.Name == "[Double-Barrel SG]" then return ExtraDelayDoubleBarrel end
        if tool.Name == "[TacticalShotgun]" then return ExtraDelayTactical end
    end
    return ExtraDelayOthers
end

local function applyExtraDelay(v)
    if not ExtraDelayChanger then return end
    if not ((v.Name == "ShootingCooldown" or v.Name == "ToleranceCooldown") and v:IsA("ValueBase")) then return end
    local function enforce()
        if ExtraDelayChanger and v.Parent then
            local wanted = getExtraDelayForValue(v)
            if v.Value ~= wanted then v.Value = wanted end
        end
    end
    enforce()
    if not extraDelayConnections[v] then
        extraDelayConnections[v] = v:GetPropertyChangedSignal("Value"):Connect(enforce)
    end
end

local function applyAllExtraDelays()
    if not ExtraDelayChanger then return end
    for _, v in ipairs(game:GetDescendants()) do applyExtraDelay(v) end
end

game.DescendantAdded:Connect(function(v)
    if ExtraDelayChanger then applyExtraDelay(v) end
end)

-- ESP logic adapted from document (3)
local extraESPObjects = {}
local extraBoneConnections = {
    {"Head", "UpperTorso"}, {"UpperTorso", "LowerTorso"},
    {"UpperTorso", "LeftUpperArm"}, {"LeftUpperArm", "LeftLowerArm"}, {"LeftLowerArm", "LeftHand"},
    {"UpperTorso", "RightUpperArm"}, {"RightUpperArm", "RightLowerArm"}, {"RightLowerArm", "RightHand"},
    {"LowerTorso", "LeftUpperLeg"}, {"LeftUpperLeg", "LeftLowerLeg"}, {"LeftLowerLeg", "LeftFoot"},
    {"LowerTorso", "RightUpperLeg"}, {"RightUpperLeg", "RightLowerLeg"}, {"RightLowerLeg", "RightFoot"}
}

local function hideExtraESP(objs)
    if not objs then return end
    objs.Box.Visible = false
    objs.Name.Visible = false
    objs.Health.Visible = false
    objs.Distance.Visible = false
    objs.Tracer.Visible = false
    for _, line in pairs(objs.Skeleton) do line.Visible = false end
end

local function createExtraESP(plr)
    if extraESPObjects[plr] or not Drawing or not Drawing.new then return end
    local box = Drawing.new("Square") box.Thickness = 1 box.Filled = false box.Color = ExtraESPColor box.Visible = false
    local name = Drawing.new("Text") name.Size = 13 name.Center = true name.Outline = true name.Color = ExtraESPColor name.Visible = false
    local health = Drawing.new("Text") health.Size = 13 health.Center = false health.Outline = true health.Color = Color3.fromRGB(50,255,50) health.Visible = false
    local distance = Drawing.new("Text") distance.Size = 12 distance.Center = true distance.Outline = true distance.Color = ExtraESPColor distance.Visible = false
    local tracer = Drawing.new("Line") tracer.Thickness = 1 tracer.Color = ExtraESPColor tracer.Visible = false
    extraESPObjects[plr] = {Box=box, Name=name, Health=health, Distance=distance, Tracer=tracer, Skeleton={}}
end

for _, p in ipairs(Players:GetPlayers()) do if p ~= lp then createExtraESP(p) end end
Players.PlayerAdded:Connect(function(p) if p ~= lp then createExtraESP(p) end end)
Players.PlayerRemoving:Connect(function(p)
    local objs = extraESPObjects[p]
    if objs then
        pcall(function() objs.Box:Remove() end) pcall(function() objs.Name:Remove() end)
        pcall(function() objs.Health:Remove() end) pcall(function() objs.Distance:Remove() end)
        pcall(function() objs.Tracer:Remove() end)
        for _, line in pairs(objs.Skeleton) do pcall(function() line:Remove() end) end
        extraESPObjects[p] = nil
    end
end)

RunService.RenderStepped:Connect(function()
    for plr, objs in pairs(extraESPObjects) do
        local char = plr.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if ExtraESPEnabled and not _G.KHWhitelist[plr.UserId] and hrp and hum and hum.Health > 0 then
            local rootPos, onScreen = cam:WorldToViewportPoint(hrp.Position)
            if onScreen then
                local head = char:FindFirstChild("Head") or hrp
                local headPos = cam:WorldToViewportPoint(head.Position + Vector3.new(0,0.5,0))
                local legPos = cam:WorldToViewportPoint(hrp.Position - Vector3.new(0,3,0))
                local boxHeight = math.abs(headPos.Y - legPos.Y)
                local topLeft = Vector2.new(rootPos.X - (boxHeight / 4), rootPos.Y - boxHeight / 2)

                if ExtraESPBoxes then
                    objs.Box.Size = Vector2.new(boxHeight / 2, boxHeight)
                    objs.Box.Position = topLeft objs.Box.Color = ExtraESPColor objs.Box.Visible = true
                else objs.Box.Visible = false end

                if ExtraESPNames then
                    objs.Name.Position = Vector2.new(rootPos.X, topLeft.Y - 16)
                    objs.Name.Text = plr.Name objs.Name.Color = ExtraESPColor objs.Name.Visible = true
                else objs.Name.Visible = false end

                if ExtraESPHealth then
                    local hp = hum.Health / math.max(hum.MaxHealth, 1)
                    objs.Health.Position = Vector2.new(topLeft.X - 26, topLeft.Y)
                    objs.Health.Text = tostring(math.floor(hp * 100)) .. "%"
                    objs.Health.Color = hp > 0.5 and Color3.fromRGB(50,255,50) or (hp > 0.25 and Color3.fromRGB(255,255,0) or Color3.fromRGB(255,50,50))
                    objs.Health.Visible = true
                else objs.Health.Visible = false end

                if ExtraESPDistance then
                    local myRoot = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
                    local dist = myRoot and math.floor((myRoot.Position - hrp.Position).Magnitude) or 0
                    objs.Distance.Position = Vector2.new(rootPos.X, topLeft.Y + boxHeight + 4)
                    objs.Distance.Text = tostring(dist) .. "m" objs.Distance.Color = ExtraESPColor objs.Distance.Visible = true
                else objs.Distance.Visible = false end

                if ExtraESPTracer then
                    objs.Tracer.From = Vector2.new(cam.ViewportSize.X / 2, cam.ViewportSize.Y)
                    objs.Tracer.To = Vector2.new(rootPos.X, rootPos.Y)
                    objs.Tracer.Color = ExtraESPColor objs.Tracer.Visible = true
                else objs.Tracer.Visible = false end

                if ExtraESPSkeleton then
                    for _, pair in ipairs(extraBoneConnections) do
                        local a, b = char:FindFirstChild(pair[1]), char:FindFirstChild(pair[2])
                        if a and b then
                            local p1, on1 = cam:WorldToViewportPoint(a.Position)
                            local p2, on2 = cam:WorldToViewportPoint(b.Position)
                            local key = pair[1] .. pair[2]
                            if on1 and on2 then
                                if not objs.Skeleton[key] then
                                    local line = Drawing.new("Line") line.Thickness = 1.5 line.Transparency = 0.6
                                    objs.Skeleton[key] = line
                                end
                                local line = objs.Skeleton[key]
                                line.From = Vector2.new(p1.X,p1.Y) line.To = Vector2.new(p2.X,p2.Y)
                                line.Color = ExtraESPColor line.Visible = true
                            elseif objs.Skeleton[key] then objs.Skeleton[key].Visible = false end
                        end
                    end
                else
                    for _, line in pairs(objs.Skeleton) do line.Visible = false end
                end
            else hideExtraESP(objs) end
        else hideExtraESP(objs) end
    end
end)

-- Whitelist section
local WhitelistHeader = Instance.new("TextLabel", Scroll)
WhitelistHeader.Size = UDim2.new(1,-6,0,34)
WhitelistHeader.BackgroundTransparency = 1
WhitelistHeader.Text = "♥  Whitelist"
WhitelistHeader.TextColor3 = Color3.fromRGB(225,73,140)
WhitelistHeader.Font = Enum.Font.GothamBold
WhitelistHeader.TextSize = 18
WhitelistHeader.TextXAlignment = Enum.TextXAlignment.Left

local whitelistCards = {}
local function addWhitelistPlayer(plr)
    if plr == lp or whitelistCards[plr] then return end
    local card = createCard(38)
    whitelistCards[plr] = card
    local lbl = Instance.new("TextLabel", card)
    lbl.Size = UDim2.new(1,-70,1,0) lbl.Position = UDim2.fromOffset(10,0)
    lbl.BackgroundTransparency = 1 lbl.Text = plr.Name
    lbl.TextColor3 = Color3.fromRGB(166,55,105) lbl.Font = Enum.Font.SourceSansBold lbl.TextSize = 14
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    local btn = Instance.new("TextButton", card)
    btn.Size = UDim2.fromOffset(48,22) btn.Position = UDim2.new(1,-58,0.5,-11)
    btn.AutoButtonColor = false btn.Font = Enum.Font.SourceSansBold btn.TextSize = 12
    Instance.new("UICorner", btn).CornerRadius = UDim.new(1,0)
    local function refresh()
        local on = _G.KHWhitelist[plr.UserId] == true
        btn.Text = on and "ON" or "OFF"
        btn.BackgroundColor3 = on and Color3.fromRGB(255,20,147) or Color3.fromRGB(255,206,226)
        btn.TextColor3 = on and Color3.new(1,1,1) or Color3.fromRGB(190,80,125)
    end
    btn.MouseButton1Click:Connect(function()
        _G.KHWhitelist[plr.UserId] = not _G.KHWhitelist[plr.UserId]
        refresh()
    end)
    refresh()
end
for _, p in ipairs(Players:GetPlayers()) do addWhitelistPlayer(p) end
Players.PlayerAdded:Connect(addWhitelistPlayer)
Players.PlayerRemoving:Connect(function(p)
    if whitelistCards[p] then whitelistCards[p]:Destroy() whitelistCards[p] = nil end
end)
addButton("Clear Whitelist", function()
    table.clear(_G.KHWhitelist)
    for p, card in pairs(whitelistCards) do
        if card and card.Parent then
            local btn = card:FindFirstChildOfClass("TextButton")
            if btn then btn.Text = "OFF" btn.BackgroundColor3 = Color3.fromRGB(255,206,226) btn.TextColor3 = Color3.fromRGB(190,80,125) end
        end
    end
end)

-- Protection section
local ProtectionHeader = Instance.new("TextLabel", Scroll)
ProtectionHeader.Size = UDim2.new(1,-6,0,34)
ProtectionHeader.BackgroundTransparency = 1
ProtectionHeader.Text = "♥  Protection"
ProtectionHeader.TextColor3 = Color3.fromRGB(225,73,140)
ProtectionHeader.Font = Enum.Font.GothamBold
ProtectionHeader.TextSize = 18
ProtectionHeader.TextXAlignment = Enum.TextXAlignment.Left
addToggle("Anti Aim View", ExtraAntiAimView, function(v) setExtraAntiAimView(v) end)
addToggle("0% Aim Accuracy", true, function() end)

-- Anti Fall section
local AntiFallHeader = Instance.new("TextLabel", Scroll)
AntiFallHeader.Size = UDim2.new(1,-6,0,34)
AntiFallHeader.BackgroundTransparency = 1
AntiFallHeader.Text = "♥  Anti Fall"
AntiFallHeader.TextColor3 = Color3.fromRGB(225,73,140)
AntiFallHeader.Font = Enum.Font.GothamBold
AntiFallHeader.TextSize = 18
AntiFallHeader.TextXAlignment = Enum.TextXAlignment.Left
addToggle("Anti Fall", ExtraAntiFall, function(v) ExtraAntiFall = v end)

-- Delay Changer section
local DelayHeader = Instance.new("TextLabel", Scroll)
DelayHeader.Size = UDim2.new(1,-6,0,34)
DelayHeader.BackgroundTransparency = 1
DelayHeader.Text = "♥  Delay Changer"
DelayHeader.TextColor3 = Color3.fromRGB(225,73,140)
DelayHeader.Font = Enum.Font.GothamBold
DelayHeader.TextSize = 18
DelayHeader.TextXAlignment = Enum.TextXAlignment.Left
addToggle("Delay Changer", ExtraDelayChanger, function(v)
    ExtraDelayChanger = v
    if v then applyAllExtraDelays() end
end)
addDecimalSlider("[Revolver] Delay", 0, 0.5, ExtraDelayRevolver, 3, function(v) ExtraDelayRevolver = v if ExtraDelayChanger then applyAllExtraDelays() end end)
addDecimalSlider("[Double-Barrel SG] Delay", 0, 0.5, ExtraDelayDoubleBarrel, 3, function(v) ExtraDelayDoubleBarrel = v if ExtraDelayChanger then applyAllExtraDelays() end end)
addDecimalSlider("[TacticalShotgun] Delay", 0, 0.5, ExtraDelayTactical, 3, function(v) ExtraDelayTactical = v if ExtraDelayChanger then applyAllExtraDelays() end end)
addDecimalSlider("Others Delay", 0, 0.5, ExtraDelayOthers, 3, function(v) ExtraDelayOthers = v if ExtraDelayChanger then applyAllExtraDelays() end end)

-- ESP section
local ESPHeader = Instance.new("TextLabel", Scroll)
ESPHeader.Size = UDim2.new(1,-6,0,34)
ESPHeader.BackgroundTransparency = 1
ESPHeader.Text = "♥  ESP"
ESPHeader.TextColor3 = Color3.fromRGB(225,73,140)
ESPHeader.Font = Enum.Font.GothamBold
ESPHeader.TextSize = 18
ESPHeader.TextXAlignment = Enum.TextXAlignment.Left
addToggle("ESP", ExtraESPEnabled, function(v) ExtraESPEnabled = v end)
addToggle("Box", ExtraESPBoxes, function(v) ExtraESPBoxes = v end)
addToggle("Name", ExtraESPNames, function(v) ExtraESPNames = v end)
addToggle("Distance", ExtraESPDistance, function(v) ExtraESPDistance = v end)
addToggle("Health", ExtraESPHealth, function(v) ExtraESPHealth = v end)
addToggle("Snapline", ExtraESPTracer, function(v) ExtraESPTracer = v end)
addToggle("Skeleton", ExtraESPSkeleton, function(v) ExtraESPSkeleton = v end)

-- document (3) starts Anti Aim View enabled
setExtraAntiAimView(ExtraAntiAimView)

local AvatarHeader = Instance.new("TextLabel", Scroll)
AvatarHeader.Size = UDim2.new(1,-6,0,34)
AvatarHeader.BackgroundTransparency = 1
AvatarHeader.Text = "♥  Avatar"
AvatarHeader.TextColor3 = Color3.fromRGB(225, 73, 140)
AvatarHeader.Font = Enum.Font.GothamBold
AvatarHeader.TextSize = 18
AvatarHeader.TextXAlignment = Enum.TextXAlignment.Left

local AvatarTargetCard = createCard(68)
local AvatarTargetLabel = Instance.new("TextLabel", AvatarTargetCard)
AvatarTargetLabel.Size = UDim2.new(1,-20,0,20)
AvatarTargetLabel.Position = UDim2.fromOffset(10,5)
AvatarTargetLabel.BackgroundTransparency = 1
AvatarTargetLabel.Text = "User ID / Username"
AvatarTargetLabel.TextColor3 = Color3.fromRGB(230, 40, 135)
AvatarTargetLabel.Font = Enum.Font.GothamBold
AvatarTargetLabel.TextSize = 14
AvatarTargetLabel.TextXAlignment = Enum.TextXAlignment.Left

local AvatarTargetBox = Instance.new("TextBox", AvatarTargetCard)
AvatarTargetBox.Size = UDim2.new(1,-20,0,29)
AvatarTargetBox.Position = UDim2.fromOffset(10,31)
AvatarTargetBox.BackgroundColor3 = Color3.fromRGB(255, 225, 238)
AvatarTargetBox.BorderSizePixel = 0
AvatarTargetBox.Text = ""
AvatarTargetBox.PlaceholderText = "username or user id"
AvatarTargetBox.PlaceholderColor3 = Color3.fromRGB(197, 112, 145)
AvatarTargetBox.TextColor3 = Color3.fromRGB(230, 40, 135)
AvatarTargetBox.Font = Enum.Font.Gotham
AvatarTargetBox.TextSize = 13
AvatarTargetBox.TextXAlignment = Enum.TextXAlignment.Left
Instance.new("UICorner", AvatarTargetBox).CornerRadius = UDim.new(0,7)
local AvatarPad = Instance.new("UIPadding", AvatarTargetBox)
AvatarPad.PaddingLeft = UDim.new(0,8)

addToggle("Enable Avatar", false, function(v) AvatarEnabled = v end)
addToggle("Visual Headless", false, function(v) AvatarHeadless = v end)

local ApplyAvatarCard = createCard(42)
local ApplyAvatarBtn = Instance.new("TextButton", ApplyAvatarCard)
ApplyAvatarBtn.Size = UDim2.new(1,-20,0,28)
ApplyAvatarBtn.Position = UDim2.fromOffset(10,7)
ApplyAvatarBtn.BackgroundColor3 = Color3.fromRGB(255, 20, 147)
ApplyAvatarBtn.Text = "♥  Apply Avatar"
ApplyAvatarBtn.TextColor3 = Color3.fromRGB(255, 240, 247)
ApplyAvatarBtn.Font = Enum.Font.GothamBold
ApplyAvatarBtn.TextSize = 14
ApplyAvatarBtn.AutoButtonColor = false
Instance.new("UICorner", ApplyAvatarBtn).CornerRadius = UDim.new(0,8)

local ResetAvatarCard = createCard(42)
local ResetAvatarBtn = Instance.new("TextButton", ResetAvatarCard)
ResetAvatarBtn.Size = UDim2.new(1,-20,0,28)
ResetAvatarBtn.Position = UDim2.fromOffset(10,7)
ResetAvatarBtn.BackgroundColor3 = Color3.fromRGB(255, 205, 228)
ResetAvatarBtn.Text = "Reset Character"
ResetAvatarBtn.TextColor3 = Color3.fromRGB(230, 40, 135)
ResetAvatarBtn.Font = Enum.Font.GothamBold
ResetAvatarBtn.TextSize = 14
Instance.new("UICorner", ResetAvatarBtn).CornerRadius = UDim.new(0,8)

local function resolveAvatarUserId(value)
    value = tostring(value or ""):gsub("%s+", ""):gsub("^@", "")
    if value == "" then return nil end
    local n = tonumber(value)
    if n then return n end
    local ok, id = pcall(function()
        return Players:GetUserIdFromNameAsync(value)
    end)
    return ok and id or nil
end

local function copyAnimationsFromDummy(char, dummy)
    local myAnimate = char:FindFirstChild("Animate")
    local dummyAnimate = dummy:FindFirstChild("Animate")
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    if not myAnimate or not dummyAnimate or not humanoid then return end

    local animator = humanoid:FindFirstChildOfClass("Animator")
    if animator then
        for _, track in ipairs(animator:GetPlayingAnimationTracks()) do
            pcall(function() track:Stop(0) end)
        end
    end

    for _, folder in ipairs(dummyAnimate:GetChildren()) do
        local mine = myAnimate:FindFirstChild(folder.Name)
        if mine then
            for _, anim in ipairs(folder:GetChildren()) do
                if anim:IsA("Animation") then
                    local existing = mine:FindFirstChild(anim.Name)
                    if existing and existing:IsA("Animation") then
                        existing.AnimationId = anim.AnimationId
                    else
                        pcall(function() anim:Clone().Parent = mine end)
                    end
                end
            end
        end
    end
end

local function applyFullOutfit(char)
    AvatarTarget = AvatarTargetBox.Text
    if not AvatarEnabled or AvatarTarget == "" then
        ApplyAvatarBtn.Text = "Enable Avatar first"
        task.delay(1.2, function()
            if ApplyAvatarBtn.Parent then ApplyAvatarBtn.Text = "♥  Apply Avatar" end
        end)
        return
    end

    local userId = resolveAvatarUserId(AvatarTarget)
    if not userId then
        ApplyAvatarBtn.Text = "User not found"
        task.delay(1.2, function()
            if ApplyAvatarBtn.Parent then ApplyAvatarBtn.Text = "♥  Apply Avatar" end
        end)
        return
    end

    task.spawn(function()
        ApplyAvatarBtn.Text = "Applying..."

        local humanoid = char and char:FindFirstChildOfClass("Humanoid")
        if not humanoid then
            ApplyAvatarBtn.Text = "No Humanoid"
            return
        end

        local ok, dummy = pcall(function()
            return Players:CreateHumanoidModelFromUserId(userId)
        end)

        if not ok or not dummy then
            ApplyAvatarBtn.Text = "Avatar unavailable"
            task.delay(1.5, function()
                if ApplyAvatarBtn.Parent then ApplyAvatarBtn.Text = "♥  Apply Avatar" end
            end)
            return
        end

        -- Remove the local outfit/accessories first.
        for _, obj in ipairs(char:GetChildren()) do
            if obj:IsA("Accessory") or obj:IsA("Shirt") or obj:IsA("Pants")
                or obj:IsA("ShirtGraphic") or obj:IsA("BodyColors")
                or obj:IsA("CharacterMesh") then
                pcall(function() obj:Destroy() end)
            end
        end

        local dummyHum = dummy:FindFirstChildOfClass("Humanoid")
        if dummyHum then
            pcall(function()
                local desc = dummyHum:GetAppliedDescription()
                if desc then humanoid:ApplyDescription(desc) end
            end)
        end

        -- Copy classic clothing/body colors.
        for _, item in ipairs(dummy:GetChildren()) do
            if item:IsA("Shirt") or item:IsA("Pants")
                or item:IsA("ShirtGraphic") or item:IsA("CharacterMesh")
                or item:IsA("BodyColors") then
                pcall(function() item:Clone().Parent = char end)
            end
        end

        -- Copy mesh body parts when possible.
        for _, dPart in ipairs(dummy:GetChildren()) do
            if dPart:IsA("MeshPart") and dPart.Name ~= "Head" then
                local myPart = char:FindFirstChild(dPart.Name)
                if myPart and myPart:IsA("MeshPart") then
                    pcall(function()
                        myPart.MeshId = dPart.MeshId
                        myPart.TextureID = dPart.TextureID
                    end)
                end
            end
        end

        -- Copy head appearance.
        local targetHead = dummy:FindFirstChild("Head")
        local myHead = char:FindFirstChild("Head")

        if targetHead and myHead then
            for _, child in ipairs(myHead:GetChildren()) do
                if child:IsA("SpecialMesh") or child:IsA("CharacterMesh")
                    or child:IsA("Decal") or child:IsA("Texture")
                    or child:IsA("SurfaceAppearance") or child:IsA("WrapTarget") then
                    pcall(function() child:Destroy() end)
                end
            end

            pcall(function() myHead.Color = targetHead.Color end)

            if targetHead:IsA("MeshPart") and myHead:IsA("MeshPart") then
                pcall(function()
                    myHead.MeshId = targetHead.MeshId
                    myHead.TextureID = targetHead.TextureID
                end)
            end

            for _, child in ipairs(targetHead:GetChildren()) do
                if child:IsA("SpecialMesh") or child:IsA("Decal")
                    or child:IsA("SurfaceAppearance") then
                    pcall(function() child:Clone().Parent = myHead end)
                end
            end
        end

        -- Copy accessories with their attachments.
        for _, item in ipairs(dummy:GetChildren()) do
            if item:IsA("Accessory") then
                local acc = item:Clone()
                local handle = acc:FindFirstChild("Handle")
                if handle then
                    handle.CanCollide = false
                    acc.Parent = char
                end
            end
        end

        copyAnimationsFromDummy(char, dummy)

        -- Optional visual headless.
        if myHead then
            if AvatarHeadless then
                myHead.Transparency = 1
                local face = myHead:FindFirstChildOfClass("Decal")
                if face then face.Transparency = 1 end
            else
                myHead.Transparency = 0
                local face = myHead:FindFirstChildOfClass("Decal")
                if face then face.Transparency = 0 end
            end
        end

        pcall(function() dummy:Destroy() end)

        ApplyAvatarBtn.Text = "Applied!"
        task.delay(1.2, function()
            if ApplyAvatarBtn.Parent then ApplyAvatarBtn.Text = "♥  Apply Avatar" end
        end)
    end)
end

ApplyAvatarBtn.MouseButton1Click:Connect(function()
    applyFullOutfit(lp.Character)
end)

ResetAvatarBtn.MouseButton1Click:Connect(function()
    local char = lp.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if hum then
        hum.Health = 0
    elseif char then
        pcall(function() char:BreakJoints() end)
    end
end)

lp.CharacterAdded:Connect(function(char)
    if AvatarEnabled and AvatarTargetBox.Text ~= "" then
        task.wait(0.6)
        applyFullOutfit(char)
    end
end)

]=====], false) then return end

if not runChunk("fog", [=====[
local C = _G.KimpetrasCtx
if not C then error("Kimpetras core context missing") end
local UIS, Main = C.UIS, C.Main
-- ========================================================
-- UNIFIED FOG COLOR PANEL - FIXED
-- ========================================================

local FogLighting = game:GetService("Lighting")

local FogH, FogS, FogV = 335, 65, 82
local FogAmount = 55 -- 0 = almost no fog, 100 = very strong fog
local FogSelected = Color3.fromRGB(255, 170, 205)

-- Use our own Atmosphere so another Atmosphere does not prevent
-- the selected color from being visible.
local FogAtmosphere = FogLighting:FindFirstChild("SilentHCFogAtmosphere")
if not FogAtmosphere then
    FogAtmosphere = Instance.new("Atmosphere")
    FogAtmosphere.Name = "SilentHCFogAtmosphere"
    FogAtmosphere.Parent = FogLighting
end

-- Save existing atmosphere settings so Reset/cleanup can restore them.
local OriginalAtmospheres = {}
for _, obj in ipairs(FogLighting:GetChildren()) do
    if obj:IsA("Atmosphere") and obj ~= FogAtmosphere then
        OriginalAtmospheres[obj] = {
            Color = obj.Color,
            Density = obj.Density,
            Haze = obj.Haze,
            Glare = obj.Glare,
            Offset = obj.Offset
        }
    end
end

local function fogHSV(h,s,v)
    return Color3.fromHSV((h % 360)/360, math.clamp(s,0,100)/100, math.clamp(v,0,100)/100)
end

local function applyUnifiedFog()
    FogSelected = fogHSV(FogH,FogS,FogV)

    -- Legacy Roblox fog.
    pcall(function()
        FogLighting.FogColor = FogSelected
        FogLighting.FogStart = 0
        FogLighting.FogEnd = 900 - (FogAmount * 8.2)
    end)

    -- Dedicated Atmosphere. This is the part that makes the
    -- selected color visible in games that already use Atmosphere.
    pcall(function()
        FogAtmosphere.Color = FogSelected
        FogAtmosphere.Density = 0.02 + (FogAmount / 100) * 0.68
        FogAtmosphere.Haze = (FogAmount / 100) * 3.5
        FogAtmosphere.Glare = 0
        FogAtmosphere.Offset = 0
    end)

    -- Reduce competing Atmospheres while the picker is active.
    for _, obj in ipairs(FogLighting:GetChildren()) do
        if obj:IsA("Atmosphere") and obj ~= FogAtmosphere then
            pcall(function()
                obj.Density = 0
            end)
        end
    end
end

-- UI
local FogPanel = Instance.new("Frame", Main)
FogPanel.Name = "FogPanel"
FogPanel.Size = UDim2.new(0, 570, 1, -50)
FogPanel.Position = UDim2.new(0, 390, 0, 40)
FogPanel.BackgroundColor3 = Color3.fromRGB(255, 225, 238)
FogPanel.BorderSizePixel = 0

Instance.new("UICorner", FogPanel).CornerRadius = UDim.new(0, 12)

local FogPanelStroke = Instance.new("UIStroke", FogPanel)
FogPanelStroke.Color = Color3.fromRGB(255, 20, 147)

local FogHeader = Instance.new("TextLabel", FogPanel)
FogHeader.Size = UDim2.new(1, -30, 0, 40)
FogHeader.Position = UDim2.fromOffset(15, 5)
FogHeader.BackgroundTransparency = 1
FogHeader.Text = "♥  Fog Color Picker"
FogHeader.TextColor3 = Color3.fromRGB(230, 40, 135)
FogHeader.TextSize = 18
FogHeader.Font = Enum.Font.GothamBold
FogHeader.TextXAlignment = Enum.TextXAlignment.Left

local FogDivider = Instance.new("Frame", FogPanel)
FogDivider.Size = UDim2.new(1, -30, 0, 1)
FogDivider.Position = UDim2.fromOffset(15, 45)
FogDivider.BackgroundColor3 = Color3.fromRGB(255, 175, 215)
FogDivider.BorderSizePixel = 0

-- Color square
local FogSquare = Instance.new("Frame", FogPanel)
FogSquare.Size = UDim2.fromOffset(300, 300)
FogSquare.Position = UDim2.fromOffset(18, 65)
FogSquare.BackgroundColor3 = Color3.fromHSV(FogH/360,1,1)
FogSquare.BorderSizePixel = 0
FogSquare.ClipsDescendants = true
Instance.new("UICorner", FogSquare).CornerRadius = UDim.new(0, 14)

local FogWhite = Instance.new("Frame", FogSquare)
FogWhite.Size = UDim2.fromScale(1,1)
FogWhite.BackgroundColor3 = Color3.new(1,1,1)
FogWhite.BorderSizePixel = 0
local FogWhiteGrad = Instance.new("UIGradient", FogWhite)
FogWhiteGrad.Transparency = NumberSequence.new({
    NumberSequenceKeypoint.new(0,0),
    NumberSequenceKeypoint.new(1,1)
})

local FogBlack = Instance.new("Frame", FogSquare)
FogBlack.Size = UDim2.fromScale(1,1)
FogBlack.BackgroundColor3 = Color3.new(0,0,0)
FogBlack.BorderSizePixel = 0
local FogBlackGrad = Instance.new("UIGradient", FogBlack)
FogBlackGrad.Rotation = 90
FogBlackGrad.Transparency = NumberSequence.new({
    NumberSequenceKeypoint.new(0,1),
    NumberSequenceKeypoint.new(1,0)
})

local FogSelector = Instance.new("Frame", FogSquare)
FogSelector.Size = UDim2.fromOffset(17,17)
FogSelector.AnchorPoint = Vector2.new(.5,.5)
FogSelector.Position = UDim2.new(FogS/100,0,1-FogV/100,0)
FogSelector.BackgroundTransparency = 1
FogSelector.ZIndex = 5
Instance.new("UICorner", FogSelector).CornerRadius = UDim.new(1,0)

local FogSelectorStroke = Instance.new("UIStroke", FogSelector)
FogSelectorStroke.Color = Color3.new(1,1,1)
FogSelectorStroke.Thickness = 2

-- Hue bar
local FogHueBar = Instance.new("Frame", FogPanel)
FogHueBar.Size = UDim2.fromOffset(24,300)
FogHueBar.Position = UDim2.fromOffset(328,65)
FogHueBar.BorderSizePixel = 0
Instance.new("UICorner", FogHueBar).CornerRadius = UDim.new(0,12)

local FogHueGrad = Instance.new("UIGradient", FogHueBar)
FogHueGrad.Rotation = 90
-- Full rainbow hue strip. The square below controls saturation/brightness.
FogHueGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 0)),
    ColorSequenceKeypoint.new(1/6,  Color3.fromRGB(255, 255, 0)),
    ColorSequenceKeypoint.new(2/6,  Color3.fromRGB(0, 255, 0)),
    ColorSequenceKeypoint.new(3/6,  Color3.fromRGB(0, 255, 255)),
    ColorSequenceKeypoint.new(4/6,  Color3.fromRGB(0, 0, 255)),
    ColorSequenceKeypoint.new(5/6,  Color3.fromRGB(255, 0, 255)),
    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 0, 0))
})

local FogHueKnob = Instance.new("Frame", FogHueBar)
FogHueKnob.Size = UDim2.fromOffset(34,13)
FogHueKnob.AnchorPoint = Vector2.new(.5,.5)
FogHueKnob.Position = UDim2.new(.5,0,1-FogH/360,0)
FogHueKnob.BackgroundColor3 = Color3.fromHSV(FogH/360, 1, 1)
FogHueKnob.ZIndex = 5
Instance.new("UICorner", FogHueKnob).CornerRadius = UDim.new(1,0)

local FogHueStroke = Instance.new("UIStroke", FogHueKnob)
FogHueStroke.Color = Color3.new(1,1,1)
FogHueStroke.Thickness = 2

local FogCurrent = Instance.new("TextLabel", FogPanel)
FogCurrent.Size = UDim2.fromOffset(190,25)
FogCurrent.Position = UDim2.fromOffset(365,65)
FogCurrent.BackgroundTransparency = 1
FogCurrent.Text = "Current Color"
FogCurrent.TextColor3 = Color3.fromRGB(230, 40, 135)
FogCurrent.TextSize = 14
FogCurrent.Font = Enum.Font.GothamMedium
FogCurrent.TextXAlignment = Enum.TextXAlignment.Left

local FogPreview = Instance.new("Frame", FogPanel)
FogPreview.Size = UDim2.fromOffset(185,58)
FogPreview.Position = UDim2.fromOffset(365,92)
FogPreview.BackgroundColor3 = FogSelected
FogPreview.BorderSizePixel = 0
Instance.new("UICorner", FogPreview).CornerRadius = UDim.new(0,14)

local FogHexLabel = Instance.new("TextLabel", FogPanel)
FogHexLabel.Size = UDim2.fromOffset(50,20)
FogHexLabel.Position = UDim2.fromOffset(365,160)
FogHexLabel.BackgroundTransparency = 1
FogHexLabel.Text = "HEX"
FogHexLabel.TextColor3 = Color3.fromRGB(230, 40, 135)
FogHexLabel.TextSize = 13
FogHexLabel.Font = Enum.Font.GothamBold
FogHexLabel.TextXAlignment = Enum.TextXAlignment.Left

local FogHex = Instance.new("TextBox", FogPanel)
FogHex.Size = UDim2.fromOffset(185,35)
FogHex.Position = UDim2.fromOffset(365,183)
FogHex.BackgroundColor3 = Color3.fromRGB(255, 231, 241)
FogHex.Text = "#FF6BB5"
FogHex.TextColor3 = Color3.fromRGB(230, 40, 135)
FogHex.TextSize = 13
FogHex.Font = Enum.Font.Gotham
FogHex.ClearTextOnFocus = false
FogHex.TextXAlignment = Enum.TextXAlignment.Left
Instance.new("UICorner", FogHex).CornerRadius = UDim.new(0,10)
local FogHexPad = Instance.new("UIPadding", FogHex)
FogHexPad.PaddingLeft = UDim.new(0,10)
local FogHexStroke = Instance.new("UIStroke", FogHex)
FogHexStroke.Color = Color3.fromRGB(248,190,205)

local function fogValueBox(y, letter, value)
    local label = Instance.new("TextLabel", FogPanel)
    label.Size = UDim2.fromOffset(20,25)
    label.Position = UDim2.fromOffset(365,y)
    label.BackgroundTransparency = 1
    label.Text = letter
    label.TextColor3 = Color3.fromRGB(230, 40, 135)
    label.TextSize = 13
    label.Font = Enum.Font.GothamBold

    local box = Instance.new("TextBox", FogPanel)
    box.Size = UDim2.fromOffset(130,32)
    box.Position = UDim2.fromOffset(390,y-4)
    box.BackgroundColor3 = Color3.fromRGB(255, 231, 241)
    box.Text = tostring(math.floor(value))
    box.TextColor3 = Color3.fromRGB(230, 40, 135)
    box.TextSize = 13
    box.Font = Enum.Font.Gotham
    box.ClearTextOnFocus = false
    box.TextXAlignment = Enum.TextXAlignment.Center
    Instance.new("UICorner", box).CornerRadius = UDim.new(0,10)
    local stroke = Instance.new("UIStroke", box)
    stroke.Color = Color3.fromRGB(248,190,205)
    return box
end

local FogHBox = fogValueBox(230,"H",FogH)
local FogSBox = fogValueBox(272,"S",FogS)
local FogVBox = fogValueBox(314,"V",FogV)

-- Fog amount slider
local FogAmountLabel = Instance.new("TextLabel", FogPanel)
FogAmountLabel.Size = UDim2.fromOffset(200,25)
FogAmountLabel.Position = UDim2.fromOffset(18,375)
FogAmountLabel.BackgroundTransparency = 1
FogAmountLabel.Text = "Fog Amount"
FogAmountLabel.TextColor3 = Color3.fromRGB(230, 40, 135)
FogAmountLabel.TextSize = 14
FogAmountLabel.Font = Enum.Font.GothamBold
FogAmountLabel.TextXAlignment = Enum.TextXAlignment.Left

local FogAmountValue = Instance.new("TextLabel", FogPanel)
FogAmountValue.Size = UDim2.fromOffset(60,25)
FogAmountValue.Position = UDim2.fromOffset(285,375)
FogAmountValue.BackgroundTransparency = 1
FogAmountValue.Text = tostring(FogAmount).."%"
FogAmountValue.TextColor3 = Color3.fromRGB(210, 65, 135)
FogAmountValue.TextSize = 13
FogAmountValue.Font = Enum.Font.GothamMedium
FogAmountValue.TextXAlignment = Enum.TextXAlignment.Right

local FogAmountTrack = Instance.new("Frame", FogPanel)
FogAmountTrack.Size = UDim2.fromOffset(327,8)
FogAmountTrack.Position = UDim2.fromOffset(18,405)
FogAmountTrack.BackgroundColor3 = Color3.fromRGB(255, 175, 215)
FogAmountTrack.BorderSizePixel = 0
Instance.new("UICorner", FogAmountTrack).CornerRadius = UDim.new(1,0)

local FogAmountFill = Instance.new("Frame", FogAmountTrack)
FogAmountFill.Size = UDim2.new(FogAmount/100,0,1,0)
FogAmountFill.BackgroundColor3 = Color3.fromRGB(255, 20, 147)
FogAmountFill.BorderSizePixel = 0
Instance.new("UICorner", FogAmountFill).CornerRadius = UDim.new(1,0)

local FogAmountKnob = Instance.new("Frame", FogAmountTrack)
FogAmountKnob.Size = UDim2.fromOffset(16,16)
FogAmountKnob.AnchorPoint = Vector2.new(.5,.5)
FogAmountKnob.Position = UDim2.new(FogAmount/100,0,.5,0)
FogAmountKnob.BackgroundColor3 = Color3.fromRGB(255, 20, 147)
FogAmountKnob.BorderSizePixel = 0
Instance.new("UICorner", FogAmountKnob).CornerRadius = UDim.new(1,0)
local FogAmountKnobStroke=Instance.new("UIStroke",FogAmountKnob)
FogAmountKnobStroke.Color=Color3.fromRGB(255, 240, 247)
FogAmountKnobStroke.Thickness=2

local FogAmountDown=false
local function updateFogAmount(input)
    local x=math.clamp((input.Position.X-FogAmountTrack.AbsolutePosition.X)/FogAmountTrack.AbsoluteSize.X,0,1)
    FogAmount=math.floor(x*100+0.5)
    FogAmountFill.Size=UDim2.new(x,0,1,0)
    FogAmountKnob.Position=UDim2.new(x,0,.5,0)
    FogAmountValue.Text=tostring(FogAmount).."%"
    applyUnifiedFog()
end
FogAmountTrack.InputBegan:Connect(function(input)
    if input.UserInputType==Enum.UserInputType.MouseButton1 then
        FogAmountDown=true
        updateFogAmount(input)
    end
end)
UIS.InputEnded:Connect(function(input)
    if input.UserInputType==Enum.UserInputType.MouseButton1 then FogAmountDown=false end
end)
UIS.InputChanged:Connect(function(input)
    if FogAmountDown and input.UserInputType==Enum.UserInputType.MouseMovement then
        updateFogAmount(input)
    end
end)

local FogAmountHint = Instance.new("TextLabel", FogPanel)
FogAmountHint.Size = UDim2.fromOffset(330,22)
FogAmountHint.Position = UDim2.fromOffset(18,418)
FogAmountHint.BackgroundTransparency = 1
FogAmountHint.Text = "less fog  ·  ·  ·  ·  ·  ·  more fog"
FogAmountHint.TextColor3 = Color3.fromRGB(210, 65, 135)
FogAmountHint.TextSize = 11
FogAmountHint.Font = Enum.Font.Gotham
FogAmountHint.TextXAlignment = Enum.TextXAlignment.Center

local FogStatus = Instance.new("TextLabel", FogPanel)
FogStatus.Size = UDim2.fromOffset(520,28)
FogStatus.Position = UDim2.fromOffset(18,525)
FogStatus.BackgroundTransparency = 1
FogStatus.Text = "♥ Fog lock enabled    ♥ Legacy Fog    ♥ Dedicated Atmosphere"
FogStatus.TextColor3 = Color3.fromRGB(230, 40, 135)
FogStatus.TextSize = 12
FogStatus.Font = Enum.Font.Gotham
FogStatus.TextXAlignment = Enum.TextXAlignment.Left

local FogReset = Instance.new("TextButton", FogPanel)
FogReset.Size = UDim2.fromOffset(90,34)
FogReset.Position = UDim2.fromOffset(455,520)
FogReset.BackgroundColor3 = Color3.fromRGB(255, 231, 241)
FogReset.Text = "Reset"
FogReset.TextColor3 = Color3.fromRGB(230, 40, 135)
FogReset.TextSize = 13
FogReset.Font = Enum.Font.GothamBold
Instance.new("UICorner", FogReset).CornerRadius = UDim.new(0,7)

local FogSquareDown=false
local FogHueDown=false

local function refreshFogUI()
    FogPreview.BackgroundColor3=FogSelected
    FogHex.Text=string.format("#%02X%02X%02X",
        math.floor(FogSelected.R*255),
        math.floor(FogSelected.G*255),
        math.floor(FogSelected.B*255))

    FogHBox.Text=tostring(math.floor(FogH))
    FogSBox.Text=tostring(math.floor(FogS))
    FogVBox.Text=tostring(math.floor(FogV))

    FogSquare.BackgroundColor3=Color3.fromHSV(FogH/360,1,1)
    FogSelector.Position=UDim2.new(FogS/100,0,1-FogV/100,0)
    FogHueKnob.Position=UDim2.new(.5,0,1-FogH/360,0)
    FogHueKnob.BackgroundColor3=Color3.fromHSV(FogH/360,1,1)
    FogAmountValue.Text=tostring(FogAmount).."%"
    FogAmountFill.Size=UDim2.new(FogAmount/100,0,1,0)
    FogAmountKnob.Position=UDim2.new(FogAmount/100,0,.5,0)
end

FogSquare.InputBegan:Connect(function(input)
    if input.UserInputType==Enum.UserInputType.MouseButton1 then
        FogSquareDown=true
    end
end)

FogHueBar.InputBegan:Connect(function(input)
    if input.UserInputType==Enum.UserInputType.MouseButton1 then
        FogHueDown=true
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType==Enum.UserInputType.MouseButton1 then
        FogSquareDown=false
        FogHueDown=false
    end
end)

UIS.InputChanged:Connect(function(input)
    if input.UserInputType~=Enum.UserInputType.MouseMovement then return end

    if FogSquareDown then
        local x=math.clamp(
            (input.Position.X-FogSquare.AbsolutePosition.X)/
            FogSquare.AbsoluteSize.X,0,1
        )
        local y=math.clamp(
            (input.Position.Y-FogSquare.AbsolutePosition.Y)/
            FogSquare.AbsoluteSize.Y,0,1
        )

        FogS=x*100
        FogV=(1-y)*100

        applyUnifiedFog()
        refreshFogUI()
    end

    if FogHueDown then
        local y=math.clamp(
            (input.Position.Y-FogHueBar.AbsolutePosition.Y)/
            FogHueBar.AbsoluteSize.Y,0,1
        )

        FogH=(1-y)*360

        applyUnifiedFog()
        refreshFogUI()
    end
end)

local function connectFogBox(box,kind,max)
    box.FocusLost:Connect(function()
        local n=tonumber(box.Text)

        if n then
            n=math.clamp(n,0,max)
            if kind=="H" then FogH=n end
            if kind=="S" then FogS=n end
            if kind=="V" then FogV=n end
        end

        applyUnifiedFog()
        refreshFogUI()
    end)
end

connectFogBox(FogHBox,"H",360)
connectFogBox(FogSBox,"S",100)
connectFogBox(FogVBox,"V",100)

FogHex.FocusLost:Connect(function()
    local t=FogHex.Text:gsub("#","")

    if #t==6 then
        local r=tonumber(t:sub(1,2),16)
        local g=tonumber(t:sub(3,4),16)
        local b=tonumber(t:sub(5,6),16)

        if r and g and b then
            local c = Color3.fromRGB(r,g,b)
            local h, ss, vv = c:ToHSV()
            FogH=h*360
            FogS=ss*100
            FogV=vv*100

            applyUnifiedFog()
            refreshFogUI()
        end
    end
end)

FogReset.MouseButton1Click:Connect(function()
    FogH=335
    FogS=65
    FogV=82
    FogAmount=55
    applyUnifiedFog()
    refreshFogUI()
end)

]=====], false) then return end

if not runChunk("backend", [=====[
(function()
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local UIS = game:GetService('UserInputService')
local cam = workspace.CurrentCamera
local mouse = LocalPlayer:GetMouse()
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local CAS = game:GetService("ContextActionService")

local function SafeDrawing(kind)
    if type(Drawing) == "table" and type(Drawing.new) == "function" then
        local ok, obj = pcall(Drawing.new, kind)
        if ok and obj then return obj end
    end
    local dummy = {Visible = false}
    function dummy:Remove() end
    return dummy
end

local Developers = {
    [122721454] = {name = "prettywilddoll", role = "Developer"},
    [10134143025] = {name = "zoe", role = "Developer"},
    [10842954950] = {name = "t5inted", role = "Developer"},
    [1021814695] = {name = "rui", role = "Moderator"},
    [1398544878] = {name = "asturova", role = "Moderator"},
}

pcall(function()
    game:GetService("StarterGui"):SetCore("SendNotification", { Title = "Kimpetras HC", Text = "Backend loaded", Duration = 2 })
end)

local function checkForDevelopers()
    for _, player in ipairs(Players:GetPlayers()) do
        local dev = Developers[player.UserId]
        if dev then
            local roleIcon = dev.role == "Developer" and "👑" or "🛡️"
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = roleIcon .. " " .. dev.role .. " Joined " .. roleIcon,
                Text = dev.name .. " is already in the server!",
                Duration = 10
            })
        end
    end
end

checkForDevelopers()

Players.PlayerAdded:Connect(function(player)
    local dev = Developers[player.UserId]
    if dev then
        task.wait(0.5)
        local roleIcon = dev.role == "Developer" and "👑" or "🛡️"
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = roleIcon .. " " .. dev.role .. " Joined " .. roleIcon,
            Text = dev.name .. " joined the server!",
            Duration = 10
        })
    end
end)

local function scanForUsers()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            local char = player.Character
            if char and char:FindFirstChild("Head") then
                local tag = char.Head:FindFirstChild("pwd_user")
                if tag and tag:IsA("BoolValue") then
                    if Developers[LocalPlayer.UserId] then
                        game:GetService("StarterGui"):SetCore("SendNotification", {
                            Title = "User Detected",
                            Text = player.Name .. " is using pwd.MAIN",
                            Duration = 5
                        })
                    end
                end
            end
        end
    end
end

_G.FOV_RADIUS = 100
_G.ShowFOV = false
_G.RevolverBypass = false
_G.WallCheck = false
_G.SilentAimEnabled = true
_G.KnockCheck = false
_G.DeathPositions = {}
_G.ESP_Boxes = false
_G.ESP_Names = false
_G.ESP_Health = false
_G.ESP_Distance = false
_G.ESP_Tracer = false
_G.ESP_Skeleton = false
_G.ESP_Color = Color3.fromRGB(255, 255, 255)
_G.SpeedMaster = false
_G.SpeedActive = false
_G.SpeedValue = 50
_G.SpeedKey = Enum.KeyCode.X
_G.FlamelockEnabled = false
_G.FlameMode = "Hold"
_G.FlameKey = Enum.KeyCode.Z
_G.FlameRightClick = false
_G.FlameSmoothness = 0
_G.FlamePrediction = 0
_G.FlameLeftOffset = 0
_G.FlameUpOffset = 0
_G.FlameHitPart = "HumanoidRootPart"
_G.FlameActive = false
_G.FPSUnlocker = true
_G.FPSTarget = 240
_G.UIToggleKey = Enum.KeyCode.Unknown
_G.UIVisible = true
_G.ESP_Enabled = false
_G.Whitelist = _G.Whitelist or {}
_G.BulletSpreadAmount = 100

_G.ForceHitEnabled = false
_G.ForceHitMode = "Fov"
_G.ForceHitFOV = 100
_G.ForceHitTracerEnabled = true
_G.ForceHitFullAutoEnabled = false
_G.ForceHitFireRate = 0.067

_G.HCSilentAimEnabled = false
_G.HCRevolverBypass = false
_G.HCWallCheck = false
_G.HCKnockCheck = false
_G.HCPrediction = false
_G.HCPredictionAmount = 0.165
_G.HCFOVRadius = 100
_G.HCHitPart = "Head"

_G.HCGodmodeEnabled = false

_G.ColorCorrectionEnabled = false
_G.CurrentTheme = "Cinnamoroll"

_G.CamlockEnabled = false
_G.CamlockToggleKey = "C"
_G.CamlockMode = "Toggle"
_G.CamlockAutoToggle = false
_G.CamlockHitPart = "HumanoidRootPart"
_G.CamlockEasingStyle = "Quad"
_G.CamlockEasingDirection = "Out"
_G.CamlockFOVRadius = 0
_G.CamlockClosestPointMode = "Default"
_G.CamlockClosestPointScale = 0
_G.CamlockSmoothness = 0
_G.CamlockPullStrengthEnabled = false
_G.CamlockPullStrengthBaseValue = 0
_G.CamlockPullStrengthMoveValue = 0
_G.CamlockPredictionEnabled = false
_G.CamlockPredictionX = 0
_G.CamlockPredictionY = 0
_G.CamlockPredictionZ = 0
_G.CamlockMaxDistance = 0
_G.CamlockConditionsForceField = false
_G.CamlockConditionsVisible = false
_G.CamlockConditionsCarried = false
_G.CamlockConditionsKnocked = false
_G.CamlockConditionsSelfKnocked = false

_G.AntiAimViewEnabled = true
_G.AntiModNotification = true
_G.AntiModKick = true
_G.AntiModKickDelay = 3
_G.AntiFallEnabled = true

_G.DelayChangerEnabled = false
_G.DelayChangerRevolver = 0.03
_G.DelayChangerDoubleBarrel = 0.3
_G.DelayChangerTacticalShotgun = 0.0
_G.DelayChangerOthers = 0.095

_G.HitboxEnabled = false
_G.HitboxSize = 2
_G.HitboxTransparency = 0
_G.HitboxColor = Color3.fromRGB(145, 210, 240)

local HCGodmode_Active = false
local HCGodmode_Track = nil
local HCGodmode_Heartbeat = nil
local HCGodmode_AnimConn = nil
local HCGodmode_EmoteID = "rbxassetid://70883871260184"
local HCGodmode_FreezeTime = 0.1265

local function HCGodmode_Cleanup()
    if HCGodmode_Track then HCGodmode_Track:Stop() HCGodmode_Track:Destroy() HCGodmode_Track = nil end
    if HCGodmode_Heartbeat then HCGodmode_Heartbeat:Disconnect() HCGodmode_Heartbeat = nil end
    if HCGodmode_AnimConn then HCGodmode_AnimConn:Disconnect() HCGodmode_AnimConn = nil end
end

local function HCGodmode_GetHumanoid()
    local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    return char:WaitForChild("Humanoid")
end

local function HCGodmode_Animate()
    if not HCGodmode_Active then return end
    local hum = HCGodmode_GetHumanoid()
    if not hum then return end
    HCGodmode_Cleanup()
    local anim = Instance.new("Animation")
    anim.AnimationId = HCGodmode_EmoteID
    HCGodmode_Track = hum:LoadAnimation(anim)
    HCGodmode_Track:Play(0, 1, 1)
    HCGodmode_Heartbeat = RunService.Heartbeat:Connect(function()
        if HCGodmode_Track and HCGodmode_Active then
            HCGodmode_Track.TimePosition = HCGodmode_FreezeTime
            HCGodmode_Track:AdjustSpeed(0)
        end
    end)
    HCGodmode_AnimConn = hum.AnimationPlayed:Connect(function(newtrack)
        if HCGodmode_Active and HCGodmode_Track and newtrack ~= HCGodmode_Track then
            task.delay(0.02 + math.random() * 0.03, HCGodmode_Animate)
        end
    end)
end

local function HCGodmode_Stop()
    HCGodmode_Cleanup()
end

LocalPlayer.CharacterAdded:Connect(function()
    task.wait(0.25)
    if HCGodmode_Active then HCGodmode_Animate() end
end)

local ColorPresets = {
    ["Cinnamoroll"] = {
        AccentColor = Color3.fromRGB(145, 210, 240),
        DimColor = Color3.fromRGB(180, 215, 235),
        HighlightColor = Color3.fromRGB(255, 255, 255),
        BgColor = Color3.fromRGB(255, 255, 255),
        SectionBg = Color3.fromRGB(245, 250, 252),
        TrayColor = Color3.fromRGB(200, 225, 240),
        TextColor = Color3.fromRGB(100, 160, 200),
        DimTextColor = Color3.fromRGB(180, 205, 220),
        BorderColor = Color3.fromRGB(210, 230, 240),
        DarkBg = Color3.fromRGB(240, 248, 252),
        HeaderBg = Color3.fromRGB(220, 238, 248)
    },
    ["Default"] = {
        AccentColor = Color3.fromRGB(230, 180, 255),
        DimColor = Color3.fromRGB(200, 200, 210),
        HighlightColor = Color3.fromRGB(255, 255, 255),
        BgColor = Color3.fromRGB(25, 22, 28),
        SectionBg = Color3.fromRGB(32, 28, 36),
        TrayColor = Color3.fromRGB(55, 50, 60),
        TextColor = Color3.fromRGB(229, 229, 229),
        DimTextColor = Color3.fromRGB(74, 74, 74),
        BorderColor = Color3.fromRGB(31, 31, 31),
        DarkBg = Color3.fromRGB(11, 11, 11),
        HeaderBg = Color3.fromRGB(19, 19, 19)
    },
    ["Rose Gold"] = {
        AccentColor = Color3.fromRGB(255, 179, 186),
        DimColor = Color3.fromRGB(200, 195, 195),
        HighlightColor = Color3.fromRGB(255, 240, 245),
        BgColor = Color3.fromRGB(30, 22, 24),
        SectionBg = Color3.fromRGB(38, 28, 30),
        TrayColor = Color3.fromRGB(60, 50, 52),
        TextColor = Color3.fromRGB(235, 225, 225),
        DimTextColor = Color3.fromRGB(85, 70, 75),
        BorderColor = Color3.fromRGB(50, 35, 40),
        DarkBg = Color3.fromRGB(18, 12, 14),
        HeaderBg = Color3.fromRGB(25, 18, 20)
    },
    ["Ocean Blue"] = {
        AccentColor = Color3.fromRGB(130, 200, 255),
        DimColor = Color3.fromRGB(180, 190, 200),
        HighlightColor = Color3.fromRGB(220, 240, 255),
        BgColor = Color3.fromRGB(18, 22, 28),
        SectionBg = Color3.fromRGB(24, 28, 36),
        TrayColor = Color3.fromRGB(45, 50, 60),
        TextColor = Color3.fromRGB(220, 230, 240),
        DimTextColor = Color3.fromRGB(65, 75, 85),
        BorderColor = Color3.fromRGB(30, 35, 45),
        DarkBg = Color3.fromRGB(10, 12, 18),
        HeaderBg = Color3.fromRGB(15, 18, 24)
    },
    ["Mint Green"] = {
        AccentColor = Color3.fromRGB(150, 255, 200),
        DimColor = Color3.fromRGB(180, 200, 190),
        HighlightColor = Color3.fromRGB(220, 255, 235),
        BgColor = Color3.fromRGB(20, 28, 24),
        SectionBg = Color3.fromRGB(26, 36, 30),
        TrayColor = Color3.fromRGB(48, 60, 52),
        TextColor = Color3.fromRGB(220, 235, 225),
        DimTextColor = Color3.fromRGB(65, 80, 70),
        BorderColor = Color3.fromRGB(30, 42, 36),
        DarkBg = Color3.fromRGB(10, 16, 14),
        HeaderBg = Color3.fromRGB(16, 22, 20)
    },
    ["Neon Pink"] = {
        AccentColor = Color3.fromRGB(255, 100, 180),
        DimColor = Color3.fromRGB(210, 180, 195),
        HighlightColor = Color3.fromRGB(255, 200, 230),
        BgColor = Color3.fromRGB(28, 18, 24),
        SectionBg = Color3.fromRGB(36, 24, 30),
        TrayColor = Color3.fromRGB(58, 45, 50),
        TextColor = Color3.fromRGB(240, 215, 225),
        DimTextColor = Color3.fromRGB(90, 65, 75),
        BorderColor = Color3.fromRGB(48, 30, 40),
        DarkBg = Color3.fromRGB(18, 10, 14),
        HeaderBg = Color3.fromRGB(24, 15, 20)
    },
    ["Sunset Orange"] = {
        AccentColor = Color3.fromRGB(255, 160, 100),
        DimColor = Color3.fromRGB(210, 190, 180),
        HighlightColor = Color3.fromRGB(255, 230, 210),
        BgColor = Color3.fromRGB(28, 22, 18),
        SectionBg = Color3.fromRGB(36, 28, 24),
        TrayColor = Color3.fromRGB(58, 50, 45),
        TextColor = Color3.fromRGB(235, 225, 215),
        DimTextColor = Color3.fromRGB(85, 70, 60),
        BorderColor = Color3.fromRGB(46, 36, 30),
        DarkBg = Color3.fromRGB(16, 12, 10),
        HeaderBg = Color3.fromRGB(24, 18, 15)
    },
    ["Amethyst"] = {
        AccentColor = Color3.fromRGB(200, 140, 255),
        DimColor = Color3.fromRGB(190, 180, 205),
        HighlightColor = Color3.fromRGB(235, 220, 255),
        BgColor = Color3.fromRGB(24, 20, 30),
        SectionBg = Color3.fromRGB(30, 26, 38),
        TrayColor = Color3.fromRGB(52, 48, 62),
        TextColor = Color3.fromRGB(225, 220, 235),
        DimTextColor = Color3.fromRGB(75, 70, 85),
        BorderColor = Color3.fromRGB(38, 34, 48),
        DarkBg = Color3.fromRGB(14, 12, 20),
        HeaderBg = Color3.fromRGB(20, 17, 26)
    },
    ["Blood Red"] = {
        AccentColor = Color3.fromRGB(255, 80, 80),
        DimColor = Color3.fromRGB(200, 170, 170),
        HighlightColor = Color3.fromRGB(255, 200, 200),
        BgColor = Color3.fromRGB(28, 18, 18),
        SectionBg = Color3.fromRGB(36, 22, 22),
        TrayColor = Color3.fromRGB(58, 40, 40),
        TextColor = Color3.fromRGB(235, 210, 210),
        DimTextColor = Color3.fromRGB(90, 60, 60),
        BorderColor = Color3.fromRGB(48, 28, 28),
        DarkBg = Color3.fromRGB(18, 10, 10),
        HeaderBg = Color3.fromRGB(24, 14, 14)
    },
    ["Cyber Yellow"] = {
        AccentColor = Color3.fromRGB(255, 230, 50),
        DimColor = Color3.fromRGB(200, 195, 150),
        HighlightColor = Color3.fromRGB(255, 250, 200),
        BgColor = Color3.fromRGB(25, 24, 15),
        SectionBg = Color3.fromRGB(32, 30, 20),
        TrayColor = Color3.fromRGB(55, 52, 38),
        TextColor = Color3.fromRGB(235, 230, 200),
        DimTextColor = Color3.fromRGB(80, 75, 50),
        BorderColor = Color3.fromRGB(42, 40, 26),
        DarkBg = Color3.fromRGB(15, 14, 8),
        HeaderBg = Color3.fromRGB(22, 20, 12)
    },
    ["Monochrome"] = {
        AccentColor = Color3.fromRGB(200, 200, 200),
        DimColor = Color3.fromRGB(150, 150, 155),
        HighlightColor = Color3.fromRGB(240, 240, 240),
        BgColor = Color3.fromRGB(20, 20, 22),
        SectionBg = Color3.fromRGB(28, 28, 30),
        TrayColor = Color3.fromRGB(50, 50, 52),
        TextColor = Color3.fromRGB(220, 220, 220),
        DimTextColor = Color3.fromRGB(70, 70, 72),
        BorderColor = Color3.fromRGB(36, 36, 38),
        DarkBg = Color3.fromRGB(10, 10, 12),
        HeaderBg = Color3.fromRGB(16, 16, 18)
    }
}

local BulletSpreadSettings = { Enabled = true }
local headlessActive = false
local espObjects = {}
local aimPart = "Head"

local AllHitPartOptions = {
    "Head", "UpperTorso", "LowerTorso", "HumanoidRootPart",
    "LeftUpperArm", "RightUpperArm", "LeftLowerArm", "RightLowerArm",
    "LeftUpperLeg", "RightUpperLeg", "LeftLowerLeg", "RightLowerLeg",
    "LeftFoot", "RightFoot", "LeftHand", "RightHand", "Closest Point"
}

local HCForceHitParts = {
    "Head", "UpperTorso", "LowerTorso",
    "LeftUpperArm", "LeftLowerArm", "LeftHand",
    "RightUpperArm", "RightLowerArm", "RightHand",
    "LeftUpperLeg", "LeftLowerLeg", "LeftFoot",
    "RightUpperLeg", "RightLowerLeg", "RightFoot",
    "HumanoidRootPart"
}

local FogPresets = {
    ["Red"] = {Color = Color3.fromRGB(255, 60, 60), Density = 0.45},
    ["Light Red"] = {Color = Color3.fromRGB(255, 120, 120), Density = 0.44},
    ["Dark Red"] = {Color = Color3.fromRGB(180, 20, 20), Density = 0.48},
    ["Orange"] = {Color = Color3.fromRGB(255, 140, 0), Density = 0.43},
    ["Light Orange"] = {Color = Color3.fromRGB(255, 190, 80), Density = 0.42},
    ["Dark Orange"] = {Color = Color3.fromRGB(200, 90, 0), Density = 0.46},
    ["Yellow"] = {Color = Color3.fromRGB(255, 240, 60), Density = 0.41},
    ["Lime"] = {Color = Color3.fromRGB(140, 255, 60), Density = 0.45},
    ["Green"] = {Color = Color3.fromRGB(50, 255, 50), Density = 0.49},
    ["Cyan"] = {Color = Color3.fromRGB(60, 255, 220), Density = 0.47},
    ["Electric Blue"] = {Color = Color3.fromRGB(0, 255, 255), Density = 0.51},
    ["Blue"] = {Color = Color3.fromRGB(60, 140, 255), Density = 0.50},
    ["Purple"] = {Color = Color3.fromRGB(180, 60, 255), Density = 0.52},
    ["Violet"] = {Color = Color3.fromRGB(138, 43, 226), Density = 0.56},
    ["Pink"] = {Color = Color3.fromRGB(255, 100, 200), Density = 0.48},
    ["Hot Pink"] = {Color = Color3.fromRGB(255, 20, 147), Density = 0.49}
}

local OrigLighting = {
    FogStart = game:GetService("Lighting").FogStart,
    FogEnd = game:GetService("Lighting").FogEnd,
    FogColor = game:GetService("Lighting").FogColor
}

local boneConnections = {
    {"Head", "UpperTorso"}, {"UpperTorso", "LowerTorso"},
    {"UpperTorso", "LeftUpperArm"}, {"LeftUpperArm", "LeftLowerArm"},
    {"UpperTorso", "RightUpperArm"}, {"RightUpperArm", "RightLowerArm"},
    {"LowerTorso", "LeftUpperLeg"}, {"LeftUpperLeg", "LeftLowerLeg"},
    {"LowerTorso", "RightUpperLeg"}, {"RightUpperLeg", "RightLowerLeg"}
}

local function IsKnocked(character)
    if not character then return false end
    local bodyEffects = character:FindFirstChild('BodyEffects')
    if bodyEffects then
        local ko = bodyEffects:FindFirstChild('K.O')
        return ko and ko.Value == true
    end
    return false
end

local function isKnocked(character)
    local bodyEffects = character:FindFirstChild("BodyEffects")
    if bodyEffects and bodyEffects:FindFirstChild("K.O") then return bodyEffects["K.O"].Value end
    return false
end

local function IsGrabbed(player)
    return player and player.Character and player.Character:FindFirstChild('GRABBING_CONSTRAINT') ~= nil
end

local function getClosestPartToMouse(char)
    local m = UIS:GetMouseLocation()
    local nearestPart, nearestDist = nil, math.huge
    local parts = {
        "Head", "UpperTorso", "LowerTorso",
        "LeftUpperArm", "LeftLowerArm", "LeftHand",
        "RightUpperArm", "RightLowerArm", "RightHand",
        "LeftUpperLeg", "LeftLowerLeg", "LeftFoot",
        "RightUpperLeg", "RightLowerLeg", "RightFoot",
        "HumanoidRootPart"
    }
    for _, name in ipairs(parts) do
        local part = char:FindFirstChild(name)
        if part then
            local screenPos, onScreen = cam:WorldToViewportPoint(part.Position)
            if onScreen then
                local dist = (Vector2.new(screenPos.X, screenPos.Y) - Vector2.new(m.X, m.Y)).Magnitude
                if dist < nearestDist then nearestDist = dist nearestPart = part end
            end
        end
    end
    return nearestPart
end

local function getTargetPosition(player, character)
    if not character then return nil end
    if _G.KnockCheck and isKnocked(character) then return nil end
    if aimPart == "Closest Point" then
        local part = getClosestPartToMouse(character)
        if part then return part.Position end
    else
        local part = character:FindFirstChild(aimPart) or character:FindFirstChild("HumanoidRootPart")
        if part then return part.Position end
    end
    return nil
end

local function setupKnockTracking(player)
    local function onKnockChanged()
        local character = player.Character
        if not character then return end
        local bodyEffects = character:FindFirstChild("BodyEffects")
        if not bodyEffects then return end
        local KO = bodyEffects:FindFirstChild("K.O")
        if not KO then return end
        if KO.Value then
            local part = character:FindFirstChild("HumanoidRootPart") or character:FindFirstChild("Head")
            if part then _G.DeathPositions[player] = part.Position end
        else
            _G.DeathPositions[player] = nil
        end
    end
    player.CharacterAdded:Connect(function(char)
        local bodyEffects = char:WaitForChild("BodyEffects", 5)
        if bodyEffects then
            local KO = bodyEffects:WaitForChild("K.O", 5)
            if KO then
                KO:GetPropertyChangedSignal("Value"):Connect(onKnockChanged)
                if KO.Value then
                    local part = char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Head")
                    if part then _G.DeathPositions[player] = part.Position end
                end
            end
        end
    end)
end

for _, plr in pairs(Players:GetPlayers()) do if plr ~= LocalPlayer then setupKnockTracking(plr) end end
Players.PlayerAdded:Connect(function(plr) if plr ~= LocalPlayer then setupKnockTracking(plr) end end)
Players.PlayerRemoving:Connect(function(plr) _G.DeathPositions[plr] = nil end)

local function getClosest()
    local mousePos = Vector2.new(mouse.X, mouse.Y)
    local best, bestDist = nil, _G.FOV_RADIUS
    for _, v in pairs(Players:GetPlayers()) do
        if v == LocalPlayer or (_G.Whitelist and _G.Whitelist[v.UserId]) then continue end
        local char = v.Character; if not char then continue end
        local targetPos = getTargetPosition(v, char); if not targetPos then continue end
        local screenPos, onScreen = cam:WorldToScreenPoint(targetPos)
        if onScreen then
            local dist = (Vector2.new(screenPos.X, screenPos.Y) - mousePos).Magnitude
            if dist < bestDist then
                if _G.WallCheck then
                    local ray = Ray.new(cam.CFrame.Position, (targetPos - cam.CFrame.Position).Unit * 500)
                    local hit, _ = workspace:FindPartOnRayWithIgnoreList(ray, {LocalPlayer.Character, cam})
                    if hit and hit:IsDescendantOf(char) then bestDist = dist; best = targetPos end
                else
                    bestDist = dist; best = targetPos
                end
            end
        end
    end
    return best
end

local handler, oldFunc = nil, nil
pcall(function()
    local modules = ReplicatedStorage:FindFirstChild("Modules")
    if modules then
        local gunHandler = modules:FindFirstChild("GunHandler")
        if gunHandler then
            handler = require(gunHandler)
            if handler and handler.getAim then oldFunc = handler.getAim end
        end
    end
end)

if handler and oldFunc then
    handler.getAim = function(origin, maxDist)
        if not _G.SilentAimEnabled then return oldFunc(origin, maxDist) end
        if _G.RevolverBypass then
            local tool = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Tool")
            if tool and (tool.Name == "[Revolver]" or tool.Name == "Revolver") then return oldFunc(origin, maxDist) end
        end
        local targetPos = getClosest()
        if targetPos then return (targetPos - origin).Unit, math.min((targetPos - origin).Magnitude, maxDist or 200) end
        return oldFunc(origin, maxDist)
    end
end

local function getKeyCode(keyName)
    local keyMap = {
        A = Enum.KeyCode.A, B = Enum.KeyCode.B, C = Enum.KeyCode.C,
        D = Enum.KeyCode.D, E = Enum.KeyCode.E, F = Enum.KeyCode.F,
        G = Enum.KeyCode.G, H = Enum.KeyCode.H, I = Enum.KeyCode.I,
        J = Enum.KeyCode.J, K = Enum.KeyCode.K, L = Enum.KeyCode.L,
        M = Enum.KeyCode.M, N = Enum.KeyCode.N, O = Enum.KeyCode.O,
        P = Enum.KeyCode.P, Q = Enum.KeyCode.Q, R = Enum.KeyCode.R,
        S = Enum.KeyCode.S, T = Enum.KeyCode.T, U = Enum.KeyCode.U,
        V = Enum.KeyCode.V, W = Enum.KeyCode.W, X = Enum.KeyCode.X,
        Y = Enum.KeyCode.Y, Z = Enum.KeyCode.Z,
    }
    return keyMap[keyName] or Enum.KeyCode[keyName] or Enum.KeyCode.V
end

local raycastParams = RaycastParams.new()
raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
raycastParams.IgnoreWater = true

local function isPartVisible(origin, targetPart, ignoreList)
    if not origin or not targetPart then return false end
    local direction = (targetPart.Position - origin).Unit
    local distance = (targetPart.Position - origin).Magnitude
    local filter = {LocalPlayer.Character}
    if ignoreList then for _, v in ipairs(ignoreList) do table.insert(filter, v) end end
    raycastParams.FilterDescendantsInstances = filter
    local result = workspace:Raycast(origin, direction * distance, raycastParams)
    if not result then return true end
    return result.Instance == targetPart or result.Instance:IsDescendantOf(targetPart.Parent)
end

local function GetClosestPointOnPart(Part, Scale)
    local PartCFrame = Part.CFrame
    local PartSize = Part.Size
    local PartSizeTransformed = PartSize * (Scale / 2)
    local MousePosition = UIS:GetMouseLocation()
    local CurrentCamera = Workspace.CurrentCamera
    local MouseRay = CurrentCamera:ViewportPointToRay(MousePosition.X, MousePosition.Y)
    local Transformed = PartCFrame:PointToObjectSpace(MouseRay.Origin + (MouseRay.Direction * MouseRay.Direction:Dot(PartCFrame.Position - MouseRay.Origin)))
    if mouse.Target == Part then return Vector3.new(mouse.Hit.X, mouse.Hit.Y, mouse.Hit.Z) end
    return PartCFrame * Vector3.new(
        math.clamp(Transformed.X, -PartSizeTransformed.X, PartSizeTransformed.X),
        math.clamp(Transformed.Y, -PartSizeTransformed.Y, PartSizeTransformed.Y),
        math.clamp(Transformed.Z, -PartSizeTransformed.Z, PartSizeTransformed.Z)
    )
end

local function GetClosestPointOnPartBasic(Part)
    if Part then
        local MouseRay = mouse.UnitRay
        MouseRay = MouseRay.Origin + (MouseRay.Direction * (Part.Position - MouseRay.Origin).Magnitude)
        local Point = (MouseRay.Y >= (Part.Position - Part.Size / 2).Y and MouseRay.Y <= (Part.Position + Part.Size / 2).Y) and (Part.Position + Vector3.new(0, -Part.Position.Y + MouseRay.Y, 0)) or Part.Position
        local Check = RaycastParams.new()
        Check.FilterType = Enum.RaycastFilterType.Whitelist
        Check.FilterDescendantsInstances = {Part}
        local Ray = Workspace:Raycast(MouseRay, (Point - MouseRay), Check)
        if mouse.Target == Part then return mouse.Hit.Position end
        if Ray then return Ray.Position else return mouse.Hit.Position end
    end
end

local function GetCamlockHitPosition(Target)
    if not Target or not Target.Character then return nil end
    local Character = Target.Character
    local Humanoid = Character:FindFirstChild("Humanoid")
    if not Humanoid then return nil end
    local NearestPart = getClosestPartToMouse(Character)
    if not NearestPart then return nil end
    local HitPosition
    if _G.CamlockHitPart == "Closest Point" then
        if _G.CamlockClosestPointMode == "Default" then
            HitPosition = GetClosestPointOnPart(NearestPart, _G.CamlockClosestPointScale)
        else
            HitPosition = GetClosestPointOnPartBasic(NearestPart)
        end
    elseif _G.CamlockHitPart == "Closest Part" then
        HitPosition = NearestPart.Position
    else
        local part = Character:FindFirstChild(_G.CamlockHitPart)
        HitPosition = part and part.Position
    end
    if not HitPosition then return nil end
    if _G.CamlockPredictionEnabled then
        local RootPart = Character:FindFirstChild("HumanoidRootPart")
        if RootPart then
            local Velocity = RootPart.Velocity
            local PredictionVector = Vector3.new(_G.CamlockPredictionX, _G.CamlockPredictionY, _G.CamlockPredictionZ)
            HitPosition = HitPosition + Velocity * PredictionVector
        end
    end
    return HitPosition
end

local function GetBestCamlockTarget()
    local Closest = nil
    local Distance = _G.CamlockFOVRadius > 0 and _G.CamlockFOVRadius or math.huge
    local MousePosition = UIS:GetMouseLocation()
    for _, Player in ipairs(Players:GetPlayers()) do
        if Player == LocalPlayer then continue end
        if not Player.Character then continue end
        local Character = Player.Character
        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
        if not HumanoidRootPart then continue end
        local Position, OnScreen = cam:WorldToViewportPoint(HumanoidRootPart.Position)
        if not OnScreen then continue end
        if _G.CamlockConditionsForceField and Character:FindFirstChild("Forcefield") then continue end
        if _G.CamlockConditionsVisible then
            local localHead = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Head")
            if localHead and not isPartVisible(localHead.Position, HumanoidRootPart, {Character}) then continue end
        end
        if _G.CamlockConditionsCarried and IsGrabbed(Player) then continue end
        if _G.CamlockConditionsKnocked and IsKnocked(Character) then continue end
        if _G.CamlockConditionsSelfKnocked and IsKnocked(LocalPlayer.Character) then continue end
        local Magnitude = (Vector2.new(Position.X, Position.Y) - MousePosition).Magnitude
        if Magnitude < Distance then Closest = Player Distance = Magnitude end
    end
    return Closest
end

local Camlock = { Target = nil, Active = false, Connection = nil }

local function IsHoldingGun()
    local char = LocalPlayer.Character
    if not char then return false end
    local tool = char:FindFirstChildOfClass("Tool")
    if not tool then return false end
    if tool:FindFirstChild("Ammo") then return true end
    if tool:FindFirstChild("Magazine") then return true end
    local gunModule = ReplicatedStorage:FindFirstChild("Modules")
    if gunModule then
        local gunHandler = gunModule:FindFirstChild("GunHandler")
        if gunHandler then
            local success, module = pcall(function() return require(gunHandler) end)
            if success and module and module.getGun then
                local success2, gun = pcall(function() return module.getGun(tool) end)
                if success2 and gun then return true end
            end
        end
    end
    return false
end

local function UpdateCamlock()
    if not _G.CamlockEnabled then
        Camlock.Active = false
        Camlock.Target = nil
        return
    end
    if _G.CamlockAutoToggle then
        if not IsHoldingGun() then
            Camlock.Active = false
            Camlock.Target = nil
            return
        end
        if not Camlock.Active or not Camlock.Target or not Camlock.Target.Character then
            local target = GetBestCamlockTarget()
            if target then
                Camlock.Target = target
                Camlock.Active = true
            else
                Camlock.Active = false
                Camlock.Target = nil
            end
            return
        end
    else
        if not Camlock.Active then return end
    end
    if not Camlock.Active then return end
    if not Camlock.Target or not Camlock.Target.Character then Camlock.Active = false return end
    local Character = Camlock.Target.Character
    if not Character:FindFirstChild("HumanoidRootPart") then Camlock.Active = false return end
    if _G.CamlockConditionsForceField and Character:FindFirstChild("Forcefield") then return end
    if _G.CamlockConditionsKnocked and IsKnocked(Character) then return end
    if _G.CamlockConditionsSelfKnocked and IsKnocked(LocalPlayer.Character) then return end
    if _G.CamlockConditionsCarried and IsGrabbed(Camlock.Target) then return end
    local HitPosition = GetCamlockHitPosition(Camlock.Target)
    if not HitPosition then return end
    local Smoothing = _G.CamlockSmoothness
    if _G.CamlockPullStrengthEnabled then
        local RootPart = Character:FindFirstChild("HumanoidRootPart")
        if RootPart then
            local VelocityMagnitude = RootPart.Velocity.Magnitude
            if VelocityMagnitude > 15 then Smoothing = _G.CamlockPullStrengthMoveValue
            else Smoothing = _G.CamlockPullStrengthBaseValue end
        end
    end
    local EasedSmoothing = TweenService:GetValue(Smoothing, Enum.EasingStyle[_G.CamlockEasingStyle], Enum.EasingDirection[_G.CamlockEasingDirection])
    cam.CFrame = cam.CFrame:Lerp(CFrame.new(cam.CFrame.Position, HitPosition), EasedSmoothing)
end

local function EnableCamlock()
    if not _G.CamlockEnabled then return end
    local target = GetBestCamlockTarget()
    if target then
        Camlock.Target = target
        Camlock.Active = true
        if not Camlock.Connection then Camlock.Connection = RunService.RenderStepped:Connect(UpdateCamlock) end
    end
end

local function DisableCamlock()
    Camlock.Active = false
    Camlock.Target = nil
end

if not Camlock.Connection then Camlock.Connection = RunService.RenderStepped:Connect(UpdateCamlock) end

local oldMouseIndex_HC = nil
local function enableHCSilentAim(enable)
    if type(hookmetamethod) ~= "function" or type(checkcaller) ~= "function" then
        _G.HCSilentAimEnabled = false
        return
    end
    if enable then
        if oldMouseIndex_HC then return end
        oldMouseIndex_HC = hookmetamethod(game, "__index", function(self, idx)
            if not checkcaller() and _G.HCSilentAimEnabled and self == mouse and (idx == "Hit" or idx == "Target") then
                local mousePos = Vector2.new(mouse.X, mouse.Y)
                local targetPart = nil
                local targetChar = nil
                local bestDist = _G.HCFOVRadius
                local HC_HIT_PARTS = {
                    "Head", "HumanoidRootPart", "UpperTorso", "LowerTorso",
                    "LeftUpperArm", "LeftLowerArm", "LeftHand",
                    "RightUpperArm", "RightLowerArm", "RightHand",
                    "LeftUpperLeg", "LeftLowerLeg", "LeftFoot",
                    "RightUpperLeg", "RightLowerLeg", "RightFoot",
                }
                for _, v in pairs(Players:GetPlayers()) do
                    if v == LocalPlayer then continue end
                    local char = v.Character
                    if not char then continue end
                    local hum = char:FindFirstChild("Humanoid")
                    if hum and hum.Health <= 0 then continue end
                    if _G.HCKnockCheck then
                        local bodyEffects = char:FindFirstChild("BodyEffects")
                        if bodyEffects and bodyEffects:FindFirstChild("K.O") and bodyEffects["K.O"].Value then continue end
                    end
                    if _G.Whitelist and _G.Whitelist[v.UserId] then continue end
                    for _, partName in ipairs(HC_HIT_PARTS) do
                        local part = char:FindFirstChild(partName)
                        if part then
                            local screenPos, onScreen = cam:WorldToScreenPoint(part.Position)
                            if onScreen then
                                local dist = (Vector2.new(screenPos.X, screenPos.Y) - mousePos).Magnitude
                                if dist < bestDist then
                                    bestDist = dist
                                    targetPart = part
                                    targetChar = char
                                end
                            end
                        end
                    end
                end
                if targetPart and targetChar then
                    return (idx == "Hit" and CFrame.new(targetPart.Position) or targetChar:FindFirstChild("HumanoidRootPart"))
                end
            end
            return oldMouseIndex_HC(self, idx)
        end)
    else
        if oldMouseIndex_HC then
            hookmetamethod(game, "__index", oldMouseIndex_HC)
            oldMouseIndex_HC = nil
        end
    end
end

local ForceHitHighlightTarget = nil
local ForceHitHighlightLine = SafeDrawing("Line")
ForceHitHighlightLine.Thickness = 1.5
ForceHitHighlightLine.Color = Color3.fromRGB(165, 201, 255)
ForceHitHighlightLine.Transparency = 0.3
ForceHitHighlightLine.Visible = false

local ForceHitFullAutoActive = false
local ForceHitIsHoldingMouse = false
local ForceHitLastFireTime = 0

local ForceHitAllowedTools = {
    "[DoubleBarrel]", "[Revolver]", "[Shotgun]",
    "[SMG]", "[Silencer]", "[TacticalShotgun]"
}

local function ForceHit_IsValidTarget(pl)
    if not pl or pl == LocalPlayer then return false end
    if not pl.Character then return false end
    local hum = pl.Character:FindFirstChild("Humanoid")
    if not hum or hum.Health <= 0 then return false end
    if _G.KnockCheck and isKnocked(pl) then return false end
    return true
end

local function ForceHit_GetClosestPartToMouse(pl)
    local m = UIS:GetMouseLocation()
    local nearestPart, nearestDist = nil, math.huge
    for _, name in ipairs(HCForceHitParts) do
        local part = pl.Character and pl.Character:FindFirstChild(name)
        if part then
            local screenPos, onScreen = cam:WorldToViewportPoint(part.Position)
            if onScreen then
                local dist = (Vector2.new(screenPos.X, screenPos.Y) - Vector2.new(m.X, m.Y)).Magnitude
                if dist < nearestDist then nearestDist = dist nearestPart = part end
            end
        end
    end
    return nearestPart
end

local function ForceHit_GetFovTarget()
    local m = UIS:GetMouseLocation()
    local bestPart, bestDist = nil, _G.ForceHitFOV
    for _, pl in ipairs(Players:GetPlayers()) do
        if ForceHit_IsValidTarget(pl) then
            local part = ForceHit_GetClosestPartToMouse(pl)
            if part then
                local screenPos, onScreen = cam:WorldToViewportPoint(part.Position)
                if onScreen then
                    local dist = (Vector2.new(screenPos.X, screenPos.Y) - Vector2.new(m.X, m.Y)).Magnitude
                    if dist < bestDist then bestDist = dist bestPart = part end
                end
            end
        end
    end
    return bestPart
end

local function ForceHit_GetBarrelPosition()
    local char = LocalPlayer.Character
    if not char then return nil end
    local tool = char:FindFirstChildOfClass("Tool")
    if tool then
        local h = tool:FindFirstChild("Handle") or tool:FindFirstChild("Barrel") or tool:FindFirstChild("Muzzle")
        if h and h:IsA("BasePart") then return h.Position end
    end
    local arm = char:FindFirstChild("Right Arm") or char:FindFirstChild("RightUpperArm")
    if arm and arm:IsA("BasePart") then return arm.Position end
    return char:GetPivot().Position
end

local function ForceHit_SpawnTracer(startPos, endPos)
    if (endPos - startPos).Magnitude < 0.1 then return end
    local beam = Instance.new("Beam")
    local attach0 = Instance.new("Attachment")
    local attach1 = Instance.new("Attachment")
    beam.Segments = 1
    beam.Width0 = 0.1
    beam.Width1 = 0.1
    beam.Color = ColorSequence.new(Color3.fromRGB(255, 200, 0))
    beam.Transparency = NumberSequence.new(0.4)
    beam.FaceCamera = true
    attach0.Position = startPos
    attach1.Position = endPos
    attach0.Parent = workspace.Terrain
    attach1.Parent = workspace.Terrain
    beam.Attachment0 = attach0
    beam.Attachment1 = attach1
    beam.Parent = workspace.Terrain
    task.delay(0.08, function()
        beam:Destroy() attach0:Destroy() attach1:Destroy()
    end)
end

local function ForceHit_Fire(targetPart)
    if not targetPart then return end
    local impactPos = targetPart.Position
    local hrpPos = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character.HumanoidRootPart.Position or Vector3.zero
    ReplicatedStorage.MainEvent:FireServer(unpack({
        "Shoot",
        {
            {{ Normal = impactPos, Instance = targetPart, Position = impactPos }, { Normal = impactPos, Instance = targetPart, Position = impactPos }, { Normal = impactPos, Instance = targetPart, Position = impactPos }, { Normal = impactPos, Instance = targetPart, Position = impactPos }, { Normal = impactPos, Instance = targetPart, Position = impactPos }},
            {{ thePart = targetPart, theOffset = Vector3.new(0, 0, 0) }, { thePart = targetPart, theOffset = Vector3.new(0, 0, 0) }, { thePart = targetPart, theOffset = Vector3.new(0, 0, 0) }, { thePart = targetPart, theOffset = Vector3.new(0, 0, 0) }, { thePart = targetPart, theOffset = Vector3.new(0, 0, 0) }},
            hrpPos, hrpPos, workspace:GetServerTimeNow()
        }
    }))
    if _G.ForceHitTracerEnabled then
        local barrelPos = ForceHit_GetBarrelPosition()
        if barrelPos then ForceHit_SpawnTracer(barrelPos, impactPos) end
    end
end

local function ForceHit_MouseClick(action, state, input)
    if state ~= Enum.UserInputState.Begin then return Enum.ContextActionResult.Pass end
    if not _G.ForceHitEnabled then return Enum.ContextActionResult.Pass end
    local char = LocalPlayer.Character
    if not char then return Enum.ContextActionResult.Pass end
    local tool = char:FindFirstChildOfClass("Tool")
    if not tool or not table.find(ForceHitAllowedTools, tool.Name) then return Enum.ContextActionResult.Pass end
    if _G.ForceHitMode == "Fov" then
        local part = ForceHit_GetFovTarget()
        if part then ForceHit_Fire(part) end
    elseif _G.ForceHitMode == "Manual" then
        if ForceHitHighlightTarget and ForceHitHighlightTarget.Character then
            local part = ForceHit_GetClosestPartToMouse(ForceHitHighlightTarget)
            if part then ForceHit_Fire(part) end
        end
    end
    return Enum.ContextActionResult.Sink
end

CAS:BindAction("NHForceHit", ForceHit_MouseClick, false, Enum.UserInputType.MouseButton1)

local function getFlameTarget()
    local mousePos = Vector2.new(mouse.X, mouse.Y)
    local closestPart = nil
    local closestDist = math.huge
    
    for _, v in pairs(Players:GetPlayers()) do
        if v == LocalPlayer then continue end
        if _G.Whitelist and _G.Whitelist[v.UserId] then continue end
        local char = v.Character
        if not char then continue end
        
        local part = char:FindFirstChild(_G.FlameHitPart) or char:FindFirstChild("HumanoidRootPart")
        if not part then continue end
        
        local screenPos, onScreen = cam:WorldToScreenPoint(part.Position)
        if onScreen then
            local dist = (Vector2.new(screenPos.X, screenPos.Y) - mousePos).Magnitude
            if dist < closestDist then
                closestDist = dist
                closestPart = part
            end
        end
    end
    
    return closestPart
end

local flameTargetPart = nil

UIS.InputBegan:Connect(function(input, gameProcessed)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then ForceHitIsHoldingMouse = true end
    if gameProcessed then return end
    if _G.CamlockEnabled and not _G.CamlockAutoToggle then
        local camlockKey = getKeyCode(_G.CamlockToggleKey)
        if input.KeyCode == camlockKey then
            if _G.CamlockMode == "Toggle" then
                if Camlock.Active then DisableCamlock() else EnableCamlock() end
            elseif _G.CamlockMode == "Hold" then EnableCamlock() end
        end
    end
    if input.KeyCode == _G.UIToggleKey then
        _G.UIVisible = not _G.UIVisible
        -- old PWD window removed in Kimpetras merge
    end
    if _G.FlamelockEnabled then
        local isTriggered = (_G.FlameRightClick and input.UserInputType == Enum.UserInputType.MouseButton2) or (not _G.FlameRightClick and input.KeyCode == _G.FlameKey)
        if isTriggered then
            if _G.FlameMode == "Hold" then
                _G.FlameActive = true
            else
                _G.FlameActive = not _G.FlameActive
            end
            if _G.FlameActive then
                local target = getFlameTarget()
                if target then
                    flameTargetPart = target
                else
                    _G.FlameActive = false
                    flameTargetPart = nil
                end
            else
                flameTargetPart = nil
            end
        end
    end
    if input.KeyCode == _G.SpeedKey then
        if _G.SpeedMaster then _G.SpeedActive = not _G.SpeedActive end
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then ForceHitIsHoldingMouse = false end
    if _G.CamlockEnabled and not _G.CamlockAutoToggle then
        local camlockKey = getKeyCode(_G.CamlockToggleKey)
        if input.KeyCode == camlockKey and _G.CamlockMode == "Hold" then DisableCamlock() end
    end
    if _G.FlamelockEnabled and _G.FlameMode == "Hold" then
        local isTriggered = (_G.FlameRightClick and input.UserInputType == Enum.UserInputType.MouseButton2) or (not _G.FlameRightClick and input.KeyCode == _G.FlameKey)
        if isTriggered then
            _G.FlameActive = false
            flameTargetPart = nil
        end
    end
end)

Players.PlayerRemoving:Connect(function(player)
    if Camlock.Target == player then DisableCamlock() end
end)

LocalPlayer.CharacterAdded:Connect(function()
    DisableCamlock()
    if headlessActive then
        local char = LocalPlayer.Character
        if char then
            local head = char:WaitForChild("Head", 5)
            if head then head.Transparency = 1 end
        end
    end
end)

RunService.Heartbeat:Connect(function()
    if _G.SpeedMaster and _G.SpeedActive and LocalPlayer.Character then
        local hum = LocalPlayer.Character:FindFirstChild("Humanoid")
        if hum and hum.WalkSpeed ~= _G.SpeedValue then hum.WalkSpeed = _G.SpeedValue end
    end
    if _G.AntiFallEnabled and LocalPlayer.Character then
        local hum = LocalPlayer.Character:FindFirstChild("Humanoid")
        if hum and hum.Health > 1 and hum:GetState() == Enum.HumanoidStateType.FallingDown then hum:ChangeState("GettingUp") end
    end
    if _G.ForceHitFullAutoEnabled and ForceHitIsHoldingMouse and _G.ForceHitEnabled then
        local now = tick()
        if now - ForceHitLastFireTime < _G.ForceHitFireRate then return end
        ForceHitLastFireTime = now
        local char = LocalPlayer.Character
        if not char then return end
        local tool = char:FindFirstChildOfClass("Tool")
        if not tool or not table.find(ForceHitAllowedTools, tool.Name) then return end
        if _G.ForceHitMode == "Fov" then
            local part = ForceHit_GetFovTarget()
            if part then ForceHit_Fire(part) end
        elseif _G.ForceHitMode == "Manual" then
            if ForceHitHighlightTarget and ForceHitHighlightTarget.Character then
                local part = ForceHit_GetClosestPartToMouse(ForceHitHighlightTarget)
                if part then ForceHit_Fire(part) end
            end
        end
    end
end)

RunService.RenderStepped:Connect(function()
    if _G.ForceHitEnabled and _G.ForceHitMode == "Manual" then
        if ForceHitHighlightTarget and ForceHitHighlightTarget.Character then
            local part = ForceHit_GetClosestPartToMouse(ForceHitHighlightTarget)
            if part then
                local screenPos, onScreen = cam:WorldToViewportPoint(part.Position)
                if onScreen then
                    ForceHitHighlightLine.From = UIS:GetMouseLocation()
                    ForceHitHighlightLine.To = Vector2.new(screenPos.X, screenPos.Y)
                    ForceHitHighlightLine.Visible = true
                else ForceHitHighlightLine.Visible = false end
            else ForceHitHighlightLine.Visible = false end
        else ForceHitHighlightLine.Visible = false end
    else ForceHitHighlightLine.Visible = false end
end)

local _0x9ba38e
if type(hookfunction) == "function" and type(checkcaller) == "function" then
    pcall(function()
        _0x9ba38e = hookfunction(math.random, function(...)
            local args = {...}
            if checkcaller() then return _0x9ba38e(...) end
            if (#args == 0) or (args[1] == -0.05 and args[2] == 0.05) or (args[1] == -0.1) or (args[1] == -0.05) then
                if BulletSpreadSettings.Enabled then return _0x9ba38e(...) * (_G.BulletSpreadAmount / 100) end
            end
            return _0x9ba38e(...)
        end)
    end)
end

local function createESP(plr)
    if espObjects[plr] then return end
    local box = SafeDrawing("Square") box.Thickness = 1 box.Filled = false box.Color = _G.ESP_Color box.Visible = false
    local name = SafeDrawing("Text") name.Size = 13 name.Center = true name.Outline = true name.Color = _G.ESP_Color name.Visible = false
    local health = SafeDrawing("Text") health.Size = 13 health.Center = false health.Outline = true health.Color = Color3.fromRGB(50, 255, 50) health.Visible = false
    local distance = SafeDrawing("Text") distance.Size = 12 distance.Center = true distance.Outline = true distance.Color = Color3.fromRGB(200, 200, 200) distance.Visible = false
    local tracer = SafeDrawing("Line") tracer.Thickness = 1 tracer.Color = _G.ESP_Color tracer.Visible = false
    local skeleton = {}
    espObjects[plr] = {Box = box, Name = name, Health = health, Distance = distance, Tracer = tracer, Skeleton = skeleton}
end

for _, p in ipairs(Players:GetPlayers()) do if p ~= LocalPlayer then createESP(p) end end
Players.PlayerAdded:Connect(function(p) if p ~= LocalPlayer then createESP(p) end end)
Players.PlayerRemoving:Connect(function(p)
    if espObjects[p] then
        espObjects[p].Box:Remove() espObjects[p].Name:Remove() espObjects[p].Health:Remove() espObjects[p].Distance:Remove() espObjects[p].Tracer:Remove()
        for _, v in pairs(espObjects[p].Skeleton) do v:Remove() end
        espObjects[p] = nil
    end
end)

local fovCircle = SafeDrawing("Circle")
fovCircle.Thickness = 1
fovCircle.NumSides = 60
fovCircle.Radius = _G.FOV_RADIUS
fovCircle.Filled = false
fovCircle.Color = ColorPresets[_G.CurrentTheme].AccentColor
fovCircle.Visible = false

RunService.RenderStepped:Connect(function()
    if _G.FPSUnlocker then setfpscap(_G.FPSTarget) end
    fovCircle.Radius = _G.FOV_RADIUS
    local currentTheme = ColorPresets[_G.CurrentTheme] or ColorPresets["Cinnamoroll"]
    fovCircle.Color = currentTheme.AccentColor
    fovCircle.Position = Vector2.new(cam.ViewportSize.X / 2, cam.ViewportSize.Y / 2)
    fovCircle.Visible = _G.ShowFOV

    if _G.FlamelockEnabled and _G.FlameActive then
        if not flameTargetPart or not flameTargetPart.Parent then
            local target = getFlameTarget()
            if target then
                flameTargetPart = target
            else
                _G.FlameActive = false
            end
        end
        if flameTargetPart and flameTargetPart.Parent then
            local targetPlayer = Players:GetPlayerFromCharacter(flameTargetPart.Parent)
            if targetPlayer and not (_G.Whitelist and _G.Whitelist[targetPlayer.UserId]) then
                local predPos = flameTargetPart.Position + (flameTargetPart.Velocity * _G.FlamePrediction)
                local offsetPos = predPos + (cam.CFrame.RightVector * _G.FlameLeftOffset) + Vector3.new(0, _G.FlameUpOffset, 0)
                local sp, on = cam:WorldToViewportPoint(offsetPos)
                if on then
                    local deltaX = (sp.X - mouse.X) * _G.FlameSmoothness
                    local deltaY = (sp.Y - mouse.Y) * _G.FlameSmoothness
                    mousemoverel(deltaX, deltaY)
                end
            else
                flameTargetPart = nil
                _G.FlameActive = false
            end
        end
    end

    for plr, objs in pairs(espObjects) do
        local isWhitelisted = _G.Whitelist and _G.Whitelist[plr.UserId] or false
        if _G.ESP_Enabled and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") and not isWhitelisted then
            local char = plr.Character local hrp = char.HumanoidRootPart local hum = char:FindFirstChild("Humanoid")
            local rootPos, onScreen = cam:WorldToViewportPoint(hrp.Position)
            if onScreen and hum and hum.Health > 0 then
                local head = char:FindFirstChild("Head") or hrp
                local headPos = cam:WorldToViewportPoint(head.Position + Vector3.new(0, 0.5, 0))
                local legPos = cam:WorldToViewportPoint(hrp.Position - Vector3.new(0, 3, 0))
                local boxHeight = math.abs(headPos.Y - legPos.Y)
                local topLeft = Vector2.new(rootPos.X - (boxHeight / 2) / 2, rootPos.Y - boxHeight / 2)
                if _G.ESP_Boxes then
                    objs.Box.Size = Vector2.new(boxHeight / 2, boxHeight) objs.Box.Position = topLeft objs.Box.Color = _G.ESP_Color objs.Box.Visible = true
                else objs.Box.Visible = false end
                if _G.ESP_Names then
                    objs.Name.Position = Vector2.new(rootPos.X, topLeft.Y - 16) objs.Name.Text = plr.Name objs.Name.Color = _G.ESP_Color objs.Name.Visible = true
                else objs.Name.Visible = false end
                if _G.ESP_Health then
                    local healthPercent = hum.Health / hum.MaxHealth
                    objs.Health.Position = Vector2.new(topLeft.X - 24, topLeft.Y) 
                    objs.Health.Text = tostring(math.floor(healthPercent * 100)) .. "%" 
                    objs.Health.Color = healthPercent > 0.5 and Color3.fromRGB(50, 255, 50) or (healthPercent > 0.25 and Color3.fromRGB(255, 255, 0) or Color3.fromRGB(255, 50, 50))
                    objs.Health.Visible = true
                else objs.Health.Visible = false end
                if _G.ESP_Distance then
                    local dist = math.floor((LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and (LocalPlayer.Character.HumanoidRootPart.Position - hrp.Position).Magnitude) or 0)
                    objs.Distance.Position = Vector2.new(rootPos.X, topLeft.Y + boxHeight + 4) 
                    objs.Distance.Text = tostring(dist) .. "m" 
                    objs.Distance.Color = _G.ESP_Color
                    objs.Distance.Visible = true
                else objs.Distance.Visible = false end
                if _G.ESP_Tracer then
                    objs.Tracer.From = Vector2.new(cam.ViewportSize.X / 2, cam.ViewportSize.Y) 
                    objs.Tracer.To = Vector2.new(rootPos.X, rootPos.Y) 
                    objs.Tracer.Color = _G.ESP_Color 
                    objs.Tracer.Visible = true
                else objs.Tracer.Visible = false end
                if _G.ESP_Skeleton then
                    for _, conn in ipairs(boneConnections) do
                        local part1 = char:FindFirstChild(conn[1]) local part2 = char:FindFirstChild(conn[2])
                        if part1 and part2 then
                            local p1, on1 = cam:WorldToViewportPoint(part1.Position)
                            local p2, on2 = cam:WorldToViewportPoint(part2.Position)
                            if on1 and on2 then
                                if not objs.Skeleton[conn[1] .. conn[2]] then
                                    objs.Skeleton[conn[1] .. conn[2]] = SafeDrawing("Line")
                                    objs.Skeleton[conn[1] .. conn[2]].Thickness = 1.5
                                    objs.Skeleton[conn[1] .. conn[2]].Transparency = 0.6
                                end
                                local line = objs.Skeleton[conn[1] .. conn[2]]
                                line.From = Vector2.new(p1.X, p1.Y) line.To = Vector2.new(p2.X, p2.Y) line.Color = _G.ESP_Color line.Visible = true
                            end
                        end
                    end
                else
                    for _, line in pairs(objs.Skeleton) do line.Visible = false end
                end
            else
                objs.Box.Visible = false objs.Name.Visible = false objs.Health.Visible = false objs.Distance.Visible = false objs.Tracer.Visible = false
                for _, line in pairs(objs.Skeleton) do line.Visible = false end
            end
        else
            if espObjects[plr] then
                espObjects[plr].Box.Visible = false espObjects[plr].Name.Visible = false espObjects[plr].Health.Visible = false espObjects[plr].Distance.Visible = false espObjects[plr].Tracer.Visible = false
                for _, line in pairs(espObjects[plr].Skeleton) do line.Visible = false end
            end
        end
    end
end)

local function SaveConfig(configName)
    if not isfolder("pwd_configs") then makefolder("pwd_configs") end
    local configData = {}
    for k, v in pairs(_G) do
        if type(k) == "string" and k ~= "Whitelist" and type(v) ~= "function" and type(v) ~= "table" and type(v) ~= "userdata" then
            configData[k] = v
        end
    end
    configData.Whitelist = _G.Whitelist
    local json = game:GetService("HttpService"):JSONEncode(configData)
    writefile("pwd_configs/" .. configName .. ".json", json)
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", { Title = "pwd.MAIN", Text = "Config saved: " .. configName, Duration = 3 })
    end)
end

local function LoadConfig(configName)
    local path = "pwd_configs/" .. configName .. ".json"
    if not isfile(path) then return false end
    local json = readfile(path)
    local configData = game:GetService("HttpService"):JSONDecode(json)
    for k, v in pairs(configData) do
        if k ~= "Whitelist" then
            _G[k] = v
        else
            for uid, val in pairs(v) do _G.Whitelist[uid] = val end
        end
    end
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", { Title = "pwd.MAIN", Text = "Config loaded: " .. configName, Duration = 3 })
    end)
    return true
end

local function DeleteConfig(configName)
    local path = "pwd_configs/" .. configName .. ".json"
    if isfile(path) then delfile(path) return true end
    return false
end

local function GetConfigs()
    if not isfolder("pwd_configs") then makefolder("pwd_configs") return {} end
    local files = listfiles("pwd_configs")
    local configs = {}
    for _, filePath in ipairs(files) do
        local name = filePath:match("pwd_configs[/\\](.+)%.json$")
        if name then table.insert(configs, name) end
    end
    return configs
end

local function UpdateHitboxes()
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and not _G.Whitelist[plr.UserId] and plr.Character then
            local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                if _G.HitboxEnabled then
                    hrp.Size = Vector3.new(_G.HitboxSize, _G.HitboxSize, _G.HitboxSize)
                    hrp.Transparency = 1 - _G.HitboxTransparency
                    hrp.Color = Color3.fromRGB(145, 210, 240)
                    hrp.Material = Enum.Material.Neon
                    hrp.CanCollide = false
                else
                    hrp.Size = Vector3.new(2, 2, 1)
                    hrp.Transparency = 1
                end
            end
        end
    end
end

Players.PlayerAdded:Connect(function(plr)
    if plr ~= LocalPlayer then
        plr.CharacterAdded:Connect(function()
            task.wait(0.5)
            UpdateHitboxes()
        end)
    end
end)

task.spawn(function()
    while task.wait(0.5) do
        if _G.HitboxEnabled then
            UpdateHitboxes()
        end
    end
end)

local DelayChanger = { 
    Enabled = true, 
    ["[Revolver]"] = 0.03, 
    ["[Double-Barrel SG]"] = 0.3, 
    ["[TacticalShotgun]"] = 0.0, 
    ["Others"] = 0.095 
}

local function applyCustomDelay(v)
    if not _G.DelayChangerEnabled then return end
    if (v.Name == "ShootingCooldown" or v.Name == "ToleranceCooldown") and v:IsA("ValueBase") then
        local tool = v:FindFirstAncestorOfClass("Tool")
        local delayValue = _G.DelayChangerOthers
        if tool then
            if tool.Name == "[Revolver]" then delayValue = _G.DelayChangerRevolver
            elseif tool.Name == "[Double-Barrel SG]" then delayValue = _G.DelayChangerDoubleBarrel
            elseif tool.Name == "[TacticalShotgun]" then delayValue = _G.DelayChangerTacticalShotgun end
        end
        v.Value = delayValue
        v:GetPropertyChangedSignal("Value"):Connect(function()
            if v.Value ~= delayValue then v.Value = delayValue end
        end)
    end
end

local function scanOwnDelayValues()
    local backpack = LocalPlayer:FindFirstChildOfClass("Backpack")
    if backpack then
        for _, v in ipairs(backpack:GetDescendants()) do applyCustomDelay(v) end
    end
    local char = LocalPlayer.Character
    if char then
        for _, v in ipairs(char:GetDescendants()) do applyCustomDelay(v) end
    end
end

-- Do not scan every instance in the entire game on startup.
-- Delay values only matter on the local player's tools.
if _G.DelayChangerEnabled then scanOwnDelayValues() end
local backpack = LocalPlayer:FindFirstChildOfClass("Backpack")
if backpack then backpack.DescendantAdded:Connect(applyCustomDelay) end
LocalPlayer.CharacterAdded:Connect(function(char)
    char.DescendantAdded:Connect(applyCustomDelay)
    if _G.DelayChangerEnabled then task.defer(scanOwnDelayValues) end
end)

task.spawn(function()
    task.wait(2)
    local antiStaffGroupId = 10604500
    local function antiStaffNotify(message)
        if _G.AntiModNotification then
            pcall(function()
                game:GetService("StarterGui"):SetCore("SendNotification", { Title = "Anti-Mod", Text = message, Duration = 5 })
            end)
        end
    end

    local function isStaff(player)
        if not player or not player:IsInGroup(antiStaffGroupId) then return false end
        local success, role = pcall(function() return player:GetRoleInGroup(antiStaffGroupId) end)
        return success and role ~= "" and role ~= "Guest"
    end

    local function handleStaffDetected(player)
        local staffName = player.Name
        antiStaffNotify(string.format("STAFF DETECTED: %s has joined!", staffName))
        if _G.AntiModKick then
            task.wait(_G.AntiModKickDelay)
            if isStaff(player) and player.Parent then
                LocalPlayer:Kick(string.format("Anti-Mod: Staff member %s detected. Protection activated.", staffName))
            end
        end
    end

    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and isStaff(player) then
            antiStaffNotify(string.format("STAFF ALREADY IN GAME: %s", player.Name))
            if _G.AntiModKick then
                task.wait(_G.AntiModKickDelay)
                LocalPlayer:Kick(string.format("Anti-Mod: Staff member %s is already in game.", player.Name))
            end
            break
        end
    end

    Players.PlayerAdded:Connect(function(player)
        task.wait(0.5)
        if isStaff(player) then handleStaffDetected(player) end
        player:GetPropertyChangedSignal("GroupRank"):Connect(function()
            task.wait(0.5)
            if isStaff(player) then antiStaffNotify(string.format("STAFF DETECTED: %s was promoted!", player.Name)) handleStaffDetected(player) end
        end)
    end)
end)

local AntiAimViewEnabled = false
local AccuracyTarget = 0

local antiAimConnections = {}

local function toggleAntiAimView(enable)
    for _, conn in ipairs(antiAimConnections) do
        pcall(function()
            conn:Disconnect()
        end)
    end
    antiAimConnections = {}

    if not enable then
        return
    end

    local dataFolder = LocalPlayer:FindFirstChild("DataFolder")
    if not dataFolder then
        dataFolder = LocalPlayer:WaitForChild("DataFolder", 5)
    end
    if not dataFolder then
        return
    end

    local shotland = dataFolder:FindFirstChild("ShotLand")
    local shottotal = dataFolder:FindFirstChild("ShotTotal")
    local warning = dataFolder:FindFirstChild("Warning")
    local lockflagged = dataFolder:FindFirstChild("LockFlagged")

    local function safeConnect(obj, callback)
        if obj then
            local conn = obj:GetPropertyChangedSignal("Value"):Connect(callback)
            table.insert(antiAimConnections, conn)
        end
    end

    safeConnect(shottotal, function()
        if shottotal and shotland then
            local total = shottotal.Value
            if total > 0 then
                local targetLand = math.floor(total * (AccuracyTarget / 100))
                shotland.Value = targetLand
            end
        end
    end)

    safeConnect(warning, function()
        if warning then
            warning.Value = 0
        end
    end)

    safeConnect(lockflagged, function()
        if lockflagged then
            lockflagged.Value = 0
        end
    end)

    local function onCharacterAdded(char)
        local bodyEffects = char:FindFirstChild("BodyEffects")
        if bodyEffects then
            local gf = bodyEffects:FindFirstChild("GunFiring")
            local gsc = bodyEffects:FindFirstChild("GunShotChanges")
            if gf then
                local conn = gf:GetPropertyChangedSignal("Value"):Connect(function()
                    if gf then
                        gf.Value = false
                    end
                end)
                table.insert(antiAimConnections, conn)
            end
            if gsc then
                local conn = gsc:GetPropertyChangedSignal("Value"):Connect(function()
                    if gsc then
                        gsc.Value = 0
                    end
                end)
                table.insert(antiAimConnections, conn)
            end
        end
    end

    if LocalPlayer.Character then
        onCharacterAdded(LocalPlayer.Character)
    end

    local playerAddedConn = LocalPlayer.CharacterAdded:Connect(onCharacterAdded)
    table.insert(antiAimConnections, playerAddedConn)
end

local antiModConnections = {}

local function setupAntiMod()
    for _, conn in ipairs(antiModConnections) do
        pcall(function()
            conn:Disconnect()
        end)
    end
    antiModConnections = {}

    local function adjustAccuracy()
        local dataFolder = LocalPlayer:FindFirstChild("DataFolder")
        if not dataFolder then
            return
        end

        local shotland = dataFolder:FindFirstChild("ShotLand")
        local shottotal = dataFolder:FindFirstChild("ShotTotal")
        local warning = dataFolder:FindFirstChild("Warning")
        local lockflagged = dataFolder:FindFirstChild("LockFlagged")

        pcall(function()
            if shottotal and shotland then
                local total = shottotal.Value
                if total > 0 then
                    local targetLand = math.floor(total * (AccuracyTarget / 100))
                    shotland.Value = targetLand
                end
            end
        end)
        pcall(function()
            if warning then warning.Value = 0 end
        end)
        pcall(function()
            if lockflagged then lockflagged.Value = 0 end
        end)

        local ReportersFolder = dataFolder:FindFirstChild("Reporters")
        if ReportersFolder then
            for _, reporter in ipairs(ReportersFolder:GetChildren()) do
                pcall(function()
                    reporter:Destroy()
                end)
            end
        end
    end

    local function onCharacterAdded(char)
        task.wait(0.5)
        adjustAccuracy()

        local bodyEffects = char:FindFirstChild("BodyEffects")
        if bodyEffects then
            local gf = bodyEffects:FindFirstChild("GunFiring")
            local gsc = bodyEffects:FindFirstChild("GunShotChanges")

            if gf then
                local conn = gf:GetPropertyChangedSignal("Value"):Connect(function()
                    if gf then
                        gf.Value = false
                    end
                end)
                table.insert(antiModConnections, conn)
            end
            if gsc then
                local conn = gsc:GetPropertyChangedSignal("Value"):Connect(function()
                    if gsc then
                        gsc.Value = 0
                    end
                end)
                table.insert(antiModConnections, conn)
            end
        end
    end

    adjustAccuracy()

    if LocalPlayer.Character then
        onCharacterAdded(LocalPlayer.Character)
    end

    local conn = LocalPlayer.CharacterAdded:Connect(onCharacterAdded)
    table.insert(antiModConnections, conn)
end

LocalPlayer.CharacterAdded:Connect(function(newChar)
    if AntiAimViewEnabled then
        toggleAntiAimView(true)
    end
    setupAntiMod()
end)

task.spawn(function()
    task.wait(1)
    if AntiAimViewEnabled then
        toggleAntiAimView(true)
    end
    setupAntiMod()
end)

-- Export selected document (3) backend helpers to the pink Kimpetras interface.
_G.KimpetrasPWDBackend = {
    enableHCSilentAim = enableHCSilentAim,
    DisableCamlock = DisableCamlock,
    UpdateHitboxes = UpdateHitboxes,
    toggleAntiAimView = toggleAntiAimView,
    SaveConfig = SaveConfig,
    LoadConfig = LoadConfig,
    DeleteConfig = DeleteConfig,
    GetConfigs = GetConfigs,
    HCGodmodeStart = function()
        HCGodmode_Active = true
        HCGodmode_Animate()
    end,
    HCGodmodeStop = function()
        HCGodmode_Active = false
        HCGodmode_Stop()
    end,
}

end)()

_G.AntiModNotification = false
_G.AntiModKick = false


]=====], false) then return end

if not runChunk("controls", [=====[
local C = _G.KimpetrasCtx
if not C then error("Kimpetras core context missing") end
local UIS, lp, cfg = C.UIS, C.lp, C.cfg
local createCard, addToggle, addSlider, addDecimalSlider, addButton, addDropdown, addKeybind =
    C.createCard, C.addToggle, C.addSlider, C.addDecimalSlider, C.addButton, C.addDropdown, C.addKeybind
-- ========================================================
-- CLEAN PWD FEATURE SECTIONS
-- Remaining document (3) controls, styled for Kimpetras HC.
-- ========================================================

local function addCleanSection(title, subtitle)
    local card = createCard(subtitle and 54 or 42)
    card.BackgroundColor3 = Color3.fromRGB(255, 236, 190)
    local stroke = card:FindFirstChildOfClass("UIStroke")
    if stroke then stroke.Color = Color3.fromRGB(255, 166, 200) end

    local titleLbl = Instance.new("TextLabel", card)
    titleLbl.Size = UDim2.new(1, -20, 0, 24)
    titleLbl.Position = UDim2.fromOffset(10, 5)
    titleLbl.BackgroundTransparency = 1
    titleLbl.Text = "♥  " .. title
    titleLbl.TextColor3 = Color3.fromRGB(220, 45, 125)
    titleLbl.Font = Enum.Font.GothamBold
    titleLbl.TextSize = 17
    titleLbl.TextXAlignment = Enum.TextXAlignment.Left

    if subtitle then
        local sub = Instance.new("TextLabel", card)
        sub.Size = UDim2.new(1, -20, 0, 18)
        sub.Position = UDim2.fromOffset(10, 29)
        sub.BackgroundTransparency = 1
        sub.Text = subtitle
        sub.TextColor3 = Color3.fromRGB(184, 100, 125)
        sub.Font = Enum.Font.Gotham
        sub.TextSize = 11
        sub.TextXAlignment = Enum.TextXAlignment.Left
    end
    return card
end

local function addSmallNote(text)
    local card = createCard(32)
    card.BackgroundColor3 = Color3.fromRGB(255, 242, 206)
    local lbl = Instance.new("TextLabel", card)
    lbl.Size = UDim2.new(1,-18,1,0)
    lbl.Position = UDim2.fromOffset(9,0)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.TextWrapped = true
    lbl.TextColor3 = Color3.fromRGB(176, 99, 122)
    lbl.Font = Enum.Font.Gotham
    lbl.TextSize = 11
    lbl.TextXAlignment = Enum.TextXAlignment.Left
end

local function addTextInput(labelText, placeholder, callback)
    local card = createCard(66)
    local lbl = Instance.new("TextLabel", card)
    lbl.Size = UDim2.new(1,-20,0,20)
    lbl.Position = UDim2.fromOffset(10,4)
    lbl.BackgroundTransparency = 1
    lbl.Text = labelText
    lbl.TextColor3 = Color3.fromRGB(166,55,105)
    lbl.Font = Enum.Font.SourceSansBold
    lbl.TextSize = 15
    lbl.TextXAlignment = Enum.TextXAlignment.Left

    local box = Instance.new("TextBox", card)
    box.Size = UDim2.new(1,-20,0,28)
    box.Position = UDim2.fromOffset(10,30)
    box.BackgroundColor3 = Color3.fromRGB(255,225,238)
    box.BorderSizePixel = 0
    box.PlaceholderText = placeholder or ""
    box.PlaceholderColor3 = Color3.fromRGB(197,112,145)
    box.TextColor3 = Color3.fromRGB(225,55,135)
    box.Font = Enum.Font.Gotham
    box.TextSize = 13
    box.ClearTextOnFocus = false
    Instance.new("UICorner", box).CornerRadius = UDim.new(0,7)
    box.FocusLost:Connect(function() callback(box.Text) end)
    return box
end

local PWD = _G.KimpetrasPWDBackend or {}
local allParts = {
    "Head", "UpperTorso", "LowerTorso", "HumanoidRootPart",
    "LeftUpperArm", "RightUpperArm", "LeftLowerArm", "RightLowerArm",
    "LeftUpperLeg", "RightUpperLeg", "LeftLowerLeg", "RightLowerLeg",
    "LeftFoot", "RightFoot", "LeftHand", "RightHand", "Closest Point"
}

-- COMBAT -------------------------------------------------
addCleanSection("Combat", "Hood Customs • Force Hit • Hitbox • Flamelock")

addToggle("HC Silent Aim", _G.HCSilentAimEnabled, function(v)
    _G.HCSilentAimEnabled = v
    if PWD.enableHCSilentAim then PWD.enableHCSilentAim(v) end
end)
addToggle("HC Revolver Bypass", _G.HCRevolverBypass, function(v) _G.HCRevolverBypass = v end)
addToggle("HC Wall Check", _G.HCWallCheck, function(v) _G.HCWallCheck = v end)
addToggle("HC Knock Check", _G.HCKnockCheck, function(v) _G.HCKnockCheck = v end)
addSlider("HC FOV Radius", 10, 1000, _G.HCFOVRadius, function(v) _G.HCFOVRadius = v end)
addDropdown("HC Hit Part", allParts, _G.HCHitPart, function(v) _G.HCHitPart = v end)
addToggle("HC Prediction", _G.HCPrediction, function(v) _G.HCPrediction = v end)
addDecimalSlider("HC Prediction Amount", 0, 0.5, _G.HCPredictionAmount, 3, function(v) _G.HCPredictionAmount = v end)
addToggle("HC Godmode", _G.HCGodmodeEnabled, function(v)
    _G.HCGodmodeEnabled = v
    if v then
        if PWD.HCGodmodeStart then PWD.HCGodmodeStart() end
    else
        if PWD.HCGodmodeStop then PWD.HCGodmodeStop() end
    end
end)

addCleanSection("Force Hit", "Hood Customs force-hit controls")
addToggle("Force Hit", _G.ForceHitEnabled, function(v) _G.ForceHitEnabled = v end)
addDropdown("Force Hit Mode", {"Fov", "Manual"}, _G.ForceHitMode, function(v) _G.ForceHitMode = v end)
addSlider("Force Hit FOV", 10, 1000, _G.ForceHitFOV, function(v) _G.ForceHitFOV = v end)
addToggle("Force Hit Tracer", _G.ForceHitTracerEnabled, function(v) _G.ForceHitTracerEnabled = v end)
addToggle("Force Hit Full Auto", _G.ForceHitFullAutoEnabled, function(v) _G.ForceHitFullAutoEnabled = v end)
addDecimalSlider("Force Hit Fire Rate", 0.01, 0.5, _G.ForceHitFireRate, 3, function(v) _G.ForceHitFireRate = v end)

addCleanSection("Hitbox Expander", "Size + visibility controls")
addToggle("Hitbox Expander", _G.HitboxEnabled, function(v)
    _G.HitboxEnabled = v
    if PWD.UpdateHitboxes then PWD.UpdateHitboxes() end
end)
addSlider("Hitbox Size", 1, 20, _G.HitboxSize, function(v) _G.HitboxSize = v end)
addDecimalSlider("Hitbox Visibility", 0, 1, _G.HitboxTransparency, 2, function(v) _G.HitboxTransparency = v end)

addCleanSection("Flamelock", "Lock key, prediction, smoothness + offsets")
addToggle("Flamelock", _G.FlamelockEnabled, function(v)
    _G.FlamelockEnabled = v
    if not v then _G.FlameActive = false end
end)
addToggle("Right Click Lock", _G.FlameRightClick, function(v) _G.FlameRightClick = v end)
addDropdown("Activation Mode", {"Hold", "Toggle"}, _G.FlameMode, function(v) _G.FlameMode = v end)
addKeybind("Flamelock Key", _G.FlameKey, function(v) _G.FlameKey = v end)
addDropdown("Flame Hit Part", {"HumanoidRootPart","Head","UpperTorso","LowerTorso"}, _G.FlameHitPart, function(v) _G.FlameHitPart = v end)
addDecimalSlider("Flame Smoothness", 0, 1, _G.FlameSmoothness, 2, function(v) _G.FlameSmoothness = v end)
addDecimalSlider("Flame Prediction", 0, 0.5, _G.FlamePrediction, 3, function(v) _G.FlamePrediction = v end)
addDecimalSlider("Flame Left Offset", -5, 5, _G.FlameLeftOffset, 2, function(v) _G.FlameLeftOffset = v end)
addDecimalSlider("Flame Up Offset", -20, 5, _G.FlameUpOffset, 2, function(v) _G.FlameUpOffset = v end)

-- CAMLOCK ------------------------------------------------
addCleanSection("Camlock", "Targeting, smoothing, prediction + checks")
addToggle("Camlock Enabled", _G.CamlockEnabled, function(v)
    _G.CamlockEnabled = v
    if not v and PWD.DisableCamlock then PWD.DisableCamlock() end
end)
addToggle("Auto Toggle (Gun)", _G.CamlockAutoToggle, function(v) _G.CamlockAutoToggle = v end)
addKeybind("Camlock Key", Enum.KeyCode[_G.CamlockToggleKey] or Enum.KeyCode.C, function(v) _G.CamlockToggleKey = v.Name end)
addDropdown("Camlock Mode", {"Hold","Toggle"}, _G.CamlockMode, function(v)
    _G.CamlockMode = v
    if PWD.DisableCamlock then PWD.DisableCamlock() end
end)
addDropdown("Camlock Hit Part", allParts, _G.CamlockHitPart, function(v) _G.CamlockHitPart = v end)
addDropdown("Closest Point Mode", {"Default","Basic"}, _G.CamlockClosestPointMode, function(v) _G.CamlockClosestPointMode = v end)
addDecimalSlider("Closest Point Scale", 0, 1, _G.CamlockClosestPointScale, 2, function(v) _G.CamlockClosestPointScale = v end)
addSlider("Camlock FOV", 0, 1000, _G.CamlockFOVRadius, function(v) _G.CamlockFOVRadius = v end)
addSlider("Max Distance", 0, 100000, _G.CamlockMaxDistance, function(v) _G.CamlockMaxDistance = v end)
addDropdown("Easing Style", {"Linear","Quad","Sine","Back","Elastic","Bounce"}, _G.CamlockEasingStyle, function(v) _G.CamlockEasingStyle = v end)
addDropdown("Easing Direction", {"In","Out","InOut"}, _G.CamlockEasingDirection, function(v) _G.CamlockEasingDirection = v end)
addDecimalSlider("Camlock Smoothness", 0, 1, _G.CamlockSmoothness, 3, function(v) _G.CamlockSmoothness = v end)
addToggle("Pull Strength", _G.CamlockPullStrengthEnabled, function(v) _G.CamlockPullStrengthEnabled = v end)
addDecimalSlider("Pull Base Value", 0.001, 0.2, _G.CamlockPullStrengthBaseValue, 3, function(v) _G.CamlockPullStrengthBaseValue = v end)
addDecimalSlider("Pull Move Value", 0.001, 0.2, _G.CamlockPullStrengthMoveValue, 3, function(v) _G.CamlockPullStrengthMoveValue = v end)
addToggle("Camlock Prediction", _G.CamlockPredictionEnabled, function(v) _G.CamlockPredictionEnabled = v end)
addDecimalSlider("Prediction X", 0.001, 0.1, math.max(_G.CamlockPredictionX,0.001), 3, function(v) _G.CamlockPredictionX = v end)
addDecimalSlider("Prediction Y", 0.001, 0.1, math.max(_G.CamlockPredictionY,0.001), 3, function(v) _G.CamlockPredictionY = v end)
addDecimalSlider("Prediction Z", 0.001, 0.1, math.max(_G.CamlockPredictionZ,0.001), 3, function(v) _G.CamlockPredictionZ = v end)
addToggle("Force Field Check", _G.CamlockConditionsForceField, function(v) _G.CamlockConditionsForceField = v end)
addToggle("Visible Check", _G.CamlockConditionsVisible, function(v) _G.CamlockConditionsVisible = v end)
addToggle("Carried Check", _G.CamlockConditionsCarried, function(v) _G.CamlockConditionsCarried = v end)
addToggle("Knocked Check", _G.CamlockConditionsKnocked, function(v) _G.CamlockConditionsKnocked = v end)
addToggle("Self Knocked Check", _G.CamlockConditionsSelfKnocked, function(v) _G.CamlockConditionsSelfKnocked = v end)

-- VISUALS ------------------------------------------------
addCleanSection("Visuals", "Atmosphere presets + color correction")
local Lighting = game:GetService("Lighting")
local originalFogStart, originalFogEnd, originalFogColor = Lighting.FogStart, Lighting.FogEnd, Lighting.FogColor
local atmospherePresets = {
    ["Pink"] = {Color3.fromRGB(255,100,200),0.48},
    ["Hot Pink"] = {Color3.fromRGB(255,20,147),0.49},
    ["Yellow"] = {Color3.fromRGB(255,240,60),0.41},
    ["Blue"] = {Color3.fromRGB(60,140,255),0.50},
    ["Purple"] = {Color3.fromRGB(180,60,255),0.52},
    ["Red"] = {Color3.fromRGB(255,60,60),0.45},
    ["Green"] = {Color3.fromRGB(50,255,50),0.49},
    ["Cyan"] = {Color3.fromRGB(60,255,220),0.47},
}
addDropdown("Atmosphere Preset", {"Pink","Hot Pink","Yellow","Blue","Purple","Red","Green","Cyan"}, "Pink", function(name)
    for _,v in ipairs(Lighting:GetChildren()) do if v:IsA("Atmosphere") then v:Destroy() end end
    local cfgp = atmospherePresets[name]
    local atm = Instance.new("Atmosphere", Lighting)
    atm.Color = cfgp[1]
    atm.Density = cfgp[2]
    atm.Haze = 4
    Lighting.FogStart = 30
    Lighting.FogEnd = 200
end)
addButton("Reset Atmosphere", function()
    for _,v in ipairs(Lighting:GetChildren()) do if v:IsA("Atmosphere") then v:Destroy() end end
    Lighting.FogStart, Lighting.FogEnd, Lighting.FogColor = originalFogStart, originalFogEnd, originalFogColor
end)
addToggle("Color Correction", _G.ColorCorrectionEnabled, function(v)
    _G.ColorCorrectionEnabled = v
    local effect = Lighting:FindFirstChild("ValColorEffect")
    if v then
        if not effect then effect = Instance.new("ColorCorrectionEffect", Lighting) end
        effect.Name = "ValColorEffect"
        effect.Enabled = true
        effect.Saturation = 0.5
    elseif effect then effect.Enabled = false end
end)
addDecimalSlider("Saturation", 0, 2, 0.5, 2, function(v)
    local effect = Lighting:FindFirstChild("ValColorEffect") or Instance.new("ColorCorrectionEffect", Lighting)
    effect.Name = "ValColorEffect"
    effect.Enabled = true
    effect.Saturation = v
end)

-- AVATAR -------------------------------------------------
addCleanSection("Headless", "Simple visual headless from document (3)")
local PWDHeadless = false
addToggle("Headless Mode", PWDHeadless, function(v)
    PWDHeadless = v
    if lp.Character and lp.Character:FindFirstChild("Head") then
        lp.Character.Head.Transparency = v and 1 or 0
    end
end)
lp.CharacterAdded:Connect(function(char)
    if PWDHeadless then
        local head = char:WaitForChild("Head",5)
        if head then head.Transparency = 1 end
    end
end)

-- PROTECTION ---------------------------------------------
addCleanSection("Protection + Anti Mod", "Anti Aim View plus document (3) anti-mod options")
addToggle("PWD Anti Aim View", _G.AntiAimViewEnabled, function(v)
    _G.AntiAimViewEnabled = v
    if PWD.toggleAntiAimView then PWD.toggleAntiAimView(v) end
end)
addToggle("Anti Mod Notify", false, function(v) _G.AntiModNotification = v end)
addToggle("Anti Mod Kick", false, function(v) _G.AntiModKick = v end)
addSlider("Anti Mod Kick Delay", 1, 10, _G.AntiModKickDelay, function(v) _G.AntiModKickDelay = v end)
addSmallNote("Anti Mod controls are OFF here by default so the script does not kick you unless you choose to enable it.")

-- SETTINGS -----------------------------------------------
addCleanSection("Settings", "FPS + local config controls")
addToggle("FPS Unlocker", _G.FPSUnlocker, function(v) _G.FPSUnlocker = v end)
addSlider("Target FPS", 240, 1000, _G.FPSTarget, function(v)
    _G.FPSTarget = v
    if setfpscap then pcall(setfpscap, v) end
end)

local configName = "Kimpetras"
local configBox = addTextInput("Config Name", "Kimpetras", function(v)
    if v ~= "" then configName = v end
end)
addButton("Save PWD Config", function()
    if PWD.SaveConfig then PWD.SaveConfig(configName) end
end)
addButton("Load PWD Config", function()
    if PWD.LoadConfig then PWD.LoadConfig(configName) end
end)
addButton("Delete PWD Config", function()
    if PWD.DeleteConfig then PWD.DeleteConfig(configName) end
end)

addCleanSection("Credits", "Original document (3) backend")
addSmallNote("pwd.MAIN feature backend • merged into the Kimpetras HC pink/yellow interface")
]=====], false) then return end

if #failures == 0 then
    Status.Text = "ready ♡"
    Bar.Size = UDim2.new(1, 0, 1, 0)
    Status.Text = "finishing up... ♡"
    task.wait(0.05)
    -- Kimqetras redesign patch closes the loader after the new UI is ready.
else
    local first = failures[1] or "unknown issue"
    Status.Text = "Kimpetras HC is open.\n" .. tostring(#failures) .. " optional module issue(s) were skipped.\n\nFirst issue:\n" .. first
    Bar.Size = UDim2.new(1, 0, 1, 0)

    local Close = Instance.new("TextButton", Panel)
    Close.Size = UDim2.fromOffset(28, 28)
    Close.Position = UDim2.new(1, -38, 0, 12)
    Close.BackgroundColor3 = PINK2
    Close.Text = "×"
    Close.TextColor3 = Color3.fromRGB(120, 65, 92)
    Close.Font = Enum.Font.GothamBold
    Close.TextSize = 18
    Instance.new("UICorner", Close).CornerRadius = UDim.new(0, 8)
    Close.MouseButton1Click:Connect(function()
        BootGui:Destroy()
    end)
end


-- ========================================================
-- KIMQETRAS HC CUTE BLUE PAGE REDESIGN
-- Every major feature receives its own page.
-- ========================================================
task.spawn(function()
    local Players = game:GetService("Players")
    local UIS = game:GetService("UserInputService")
    local RunService = game:GetService("RunService")
    local CoreGui = game:GetService("CoreGui")
    local TweenService = game:GetService("TweenService")
    local lp = Players.LocalPlayer
    local playerGui = lp:WaitForChild("PlayerGui")

    local gui = CoreGui:FindFirstChild("KimpetrasHC") or playerGui:FindFirstChild("KimpetrasHC")
    if not gui then return end
    local main = gui:FindFirstChild("Main")
    if not main or main:FindFirstChild("KimqetrasCuteBlueReady") then return end

    local readyMark = Instance.new("BoolValue")
    readyMark.Name = "KimqetrasCuteBlueReady"
    readyMark.Parent = main

    local C = rawget(_G, "KimpetrasCtx")
    local oldScroll = C and C.Scroll or main:FindFirstChildWhichIsA("ScrollingFrame")
    local oldHeader = main:FindFirstChild("Header")
    local oldFog = main:FindFirstChild("FogPanel")
    local oldDrag = main:FindFirstChild("DragCorner")
    local oldBubble = gui:FindFirstChild("MiniBubble")

    if not oldScroll then return end

    -- Let the original UIListLayout finish positioning the controls before sorting them.
    for _ = 1, 3 do RunService.Heartbeat:Wait() end

    local T = {
        bg = Color3.fromRGB(217, 255, 232),
        bg2 = Color3.fromRGB(236, 255, 243),
        panel = Color3.fromRGB(255, 255, 255),
        card = Color3.fromRGB(255, 255, 255),
        card2 = Color3.fromRGB(246, 255, 250),
        hot = Color3.fromRGB(243, 161, 211),
        hot2 = Color3.fromRGB(255, 212, 243),
        text = Color3.fromRGB(82, 116, 94),
        sub = Color3.fromRGB(122, 153, 133),
        stroke = Color3.fromRGB(255, 212, 243),
        white = Color3.fromRGB(255, 255, 255),
    }

    local function corner(obj, r)
        local c = obj:FindFirstChildOfClass("UICorner") or Instance.new("UICorner")
        c.CornerRadius = UDim.new(0, r or 14)
        c.Parent = obj
        return c
    end

    local function stroke(obj, color, tr, thickness)
        local s = obj:FindFirstChildOfClass("UIStroke") or Instance.new("UIStroke")
        s.Color = color or T.stroke
        s.Transparency = tr or 0
        s.Thickness = thickness or 1
        s.Parent = obj
        return s
    end

    local function textLabel(parent, text, size, pos, font, textSize, color, align)
        local lbl = Instance.new("TextLabel")
        lbl.Parent = parent
        lbl.Size = size
        lbl.Position = pos
        lbl.BackgroundTransparency = 1
        lbl.Text = text
        lbl.Font = font or Enum.Font.Gotham
        lbl.TextSize = textSize or 13
        lbl.TextColor3 = color or T.text
        lbl.TextXAlignment = align or Enum.TextXAlignment.Left
        return lbl
    end

    local function assetFromWorkspace()
        local names = {
            "KimqetrasBanner.png", "KimqetrasBanner.webp", "KimqetrasBanner.gif",
            "kimqetras_banner.png", "kimqetras_banner.webp", "kimqetras_banner.gif",
            "banner.png", "banner.webp", "banner.gif"
        }
        for _, name in ipairs(names) do
            if type(getcustomasset) == "function" then
                local ok, asset = pcall(getcustomasset, name)
                if ok and asset then return asset end
            end
            if type(getsynasset) == "function" then
                local ok, asset = pcall(getsynasset, name)
                if ok and asset then return asset end
            end
        end
        return nil
    end

    if oldHeader then oldHeader.Visible = false end
    if oldBubble then pcall(function() oldBubble:Destroy() end) end
    if oldDrag then oldDrag.Visible = false end

    main.Size = UDim2.fromOffset(1040, 650)
    main.Position = UDim2.new(0.5, -520, 0.5, -325)
    main.BackgroundColor3 = T.bg
    main.BorderSizePixel = 0
    corner(main, 24)
    stroke(main, T.hot, 0.22, 2)

    -- Drag from the custom top area.
    local shell = Instance.new("Frame")
    shell.Name = "CuteBlueShell"
    shell.Parent = main
    shell.Size = UDim2.fromScale(1, 1)
    shell.BackgroundTransparency = 1

    local top = Instance.new("Frame")
    top.Parent = shell
    top.Size = UDim2.new(1, -28, 0, 70)
    top.Position = UDim2.fromOffset(14, 10)
    top.BackgroundTransparency = 1
    top.Active = true

    local title = textLabel(top, "♥  Kimqetras HC", UDim2.new(0, 360, 0, 36), UDim2.fromOffset(12, 3), Enum.Font.FredokaOne, 29, T.hot)
    local subtitle = textLabel(top, "cute controls, clean pages, zero clutter ♡", UDim2.new(0, 420, 0, 20), UDim2.fromOffset(14, 38), Enum.Font.Gotham, 12, T.sub)

    local topProfile = Instance.new("Frame")
    topProfile.Parent = top
    topProfile.Size = UDim2.fromOffset(220, 46)
    topProfile.Position = UDim2.new(1, -232, 0.5, -23)
    topProfile.BackgroundColor3 = T.panel
    topProfile.BorderSizePixel = 0
    corner(topProfile, 15)
    stroke(topProfile, T.stroke, 0.28, 1)

    local topAvatar = Instance.new("ImageLabel")
    topAvatar.Parent = topProfile
    topAvatar.Size = UDim2.fromOffset(32, 32)
    topAvatar.Position = UDim2.new(0, 8, 0.5, -16)
    topAvatar.BackgroundColor3 = T.card2
    topAvatar.BorderSizePixel = 0
    corner(topAvatar, 999)
    pcall(function()
        topAvatar.Image = Players:GetUserThumbnailAsync(lp.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100)
    end)

    local topName = textLabel(topProfile, lp.DisplayName, UDim2.new(1, -52, 0, 18), UDim2.fromOffset(48, 7), Enum.Font.FredokaOne, 14, T.text)
    local topUser = textLabel(topProfile, "@" .. lp.Name, UDim2.new(1, -52, 0, 16), UDim2.fromOffset(48, 24), Enum.Font.Gotham, 10, T.sub)

    local dashTop = textLabel(shell, "-   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -", UDim2.new(1, -36, 0, 18), UDim2.fromOffset(18, 72), Enum.Font.GothamBold, 11, T.stroke, Enum.TextXAlignment.Center)

    local side = Instance.new("Frame")
    side.Parent = shell
    side.Size = UDim2.new(0, 205, 1, -104)
    side.Position = UDim2.fromOffset(14, 94)
    side.BackgroundColor3 = T.bg2
    side.BorderSizePixel = 0
    corner(side, 20)
    stroke(side, T.stroke, 0.18, 1)

    local sideHeart = textLabel(side, "♡  pages  ♡", UDim2.new(1, -20, 0, 28), UDim2.fromOffset(10, 12), Enum.Font.FredokaOne, 18, T.text, Enum.TextXAlignment.Center)
    local sideDash = textLabel(side, "-  -  -  -  -  -  -", UDim2.new(1, -20, 0, 18), UDim2.fromOffset(10, 38), Enum.Font.GothamBold, 10, T.stroke, Enum.TextXAlignment.Center)

    local nav = Instance.new("ScrollingFrame")
    nav.Parent = side
    nav.Size = UDim2.new(1, -14, 1, -98)
    nav.Position = UDim2.fromOffset(7, 60)
    nav.BackgroundTransparency = 1
    nav.BorderSizePixel = 0
    nav.ScrollBarThickness = 2
    nav.ScrollBarImageColor3 = T.hot
    local navLayout = Instance.new("UIListLayout", nav)
    navLayout.SortOrder = Enum.SortOrder.LayoutOrder
    navLayout.Padding = UDim.new(0, 6)
    navLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        nav.CanvasSize = UDim2.new(0, 0, 0, navLayout.AbsoluteContentSize.Y + 8)
    end)

    local rightShiftHint = Instance.new("Frame")
    rightShiftHint.Parent = side
    rightShiftHint.Size = UDim2.new(1, -16, 0, 34)
    rightShiftHint.Position = UDim2.new(0, 8, 1, -42)
    rightShiftHint.BackgroundColor3 = T.panel
    rightShiftHint.BorderSizePixel = 0
    corner(rightShiftHint, 12)
    stroke(rightShiftHint, T.stroke, 0.3, 1)
    local hint = textLabel(rightShiftHint, "♥  F1 = hide / show", UDim2.new(1, -12, 1, 0), UDim2.fromOffset(6, 0), Enum.Font.GothamSemibold, 10, T.hot, Enum.TextXAlignment.Center)

    local content = Instance.new("Frame")
    content.Parent = shell
    content.Size = UDim2.new(1, -247, 1, -104)
    content.Position = UDim2.fromOffset(233, 94)
    content.BackgroundTransparency = 1

    local pageHead = Instance.new("Frame")
    pageHead.Parent = content
    pageHead.Size = UDim2.new(1, 0, 0, 76)
    pageHead.BackgroundColor3 = T.panel
    pageHead.BorderSizePixel = 0
    corner(pageHead, 18)
    stroke(pageHead, T.stroke, 0.22, 1)

    local pageHeart = textLabel(pageHead, "♥", UDim2.fromOffset(30, 30), UDim2.fromOffset(14, 10), Enum.Font.FredokaOne, 24, T.hot, Enum.TextXAlignment.Center)
    local pageTitle = textLabel(pageHead, "overview", UDim2.new(1, -60, 0, 28), UDim2.fromOffset(46, 10), Enum.Font.FredokaOne, 23, T.text)
    local pageDesc = textLabel(pageHead, "your account, quick notes, and a little welcome page", UDim2.new(1, -40, 0, 18), UDim2.fromOffset(18, 42), Enum.Font.Gotham, 11, T.sub)
    local dashHead = textLabel(pageHead, "-  -  -  -  -  -  -  -  -  -  -  -", UDim2.new(0, 250, 0, 16), UDim2.new(1, -270, 0, 44), Enum.Font.GothamBold, 9, T.stroke, Enum.TextXAlignment.Right)

    local pageHost = Instance.new("Frame")
    pageHost.Parent = content
    pageHost.Size = UDim2.new(1, 0, 1, -88)
    pageHost.Position = UDim2.fromOffset(0, 88)
    pageHost.BackgroundTransparency = 1

    local pageDefs = {
        {"overview", "overview", "your account, quick notes, and a little welcome page"},
        {"silent", "silent aim", "cursor targeting, FOV, hit part, and your aim key"},
        {"macro", "macro", "speed controls and your macro activation key"},
        {"whitelist", "whitelist", "choose players that targeting and ESP should ignore"},
        {"protection", "protection", "anti-aim-view protection and accuracy safeguards"},
        {"antifall", "anti fall", "keep your character from staying in a falling-down state"},
        {"delay", "delay changer", "weapon cooldown values organized in one place"},
        {"esp", "esp", "boxes, names, distance, health, tracers, and skeletons"},
        {"avatar", "avatar", "copy an avatar look and manage character visuals"},
        {"fog", "fog / atmosphere", "color picker, atmosphere presets, and saturation"},
        {"hcsilent", "HC silent aim", "Hood Customs targeting, prediction, FOV, and checks"},
        {"forcehit", "force hit", "force-hit mode, tracer, FOV, full auto, and fire rate"},
        {"hitbox", "hitbox expander", "hitbox size and visibility controls"},
        {"flamelock", "flamelock", "lock key, hit part, smoothness, prediction, and offsets"},
        {"camlock", "camlock", "lock behavior, smoothing, prediction, FOV, and conditions"},
        {"headless", "headless", "a simple visual headless option"},
        {"antimod", "anti mod", "notification, kick, and anti-mod delay options"},
        {"settings", "settings", "FPS controls and local configuration tools"},
        {"theme", "theme", "change the light and hot color pair for the whole interface"},
        {"info", "information", "credits and details about this build"},
    }

    local pages, pageMeta = {}, {}
    for _, d in ipairs(pageDefs) do
        pageMeta[d[1]] = {label = d[2], desc = d[3]}
        local p = Instance.new("ScrollingFrame")
        p.Name = d[1] .. "Page"
        p.Parent = pageHost
        p.Size = UDim2.fromScale(1, 1)
        p.BackgroundTransparency = 1
        p.BorderSizePixel = 0
        p.Visible = false
        p.ScrollBarThickness = 3
        p.ScrollBarImageColor3 = T.hot
        local pad = Instance.new("UIPadding", p)
        pad.PaddingRight = UDim.new(0, 4)
        local list = Instance.new("UIListLayout", p)
        list.SortOrder = Enum.SortOrder.LayoutOrder
        list.Padding = UDim.new(0, 10)
        list:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            p.CanvasSize = UDim2.new(0, 0, 0, list.AbsoluteContentSize.Y + 12)
        end)
        pages[d[1]] = p
    end

    local function sectionNameFromObject(obj)
        local function cleanText(txt)
            txt = tostring(txt or "")
            if txt:sub(1, 1) ~= "♥" then return nil end
            return (txt:gsub("^♥%s*", "")):lower():gsub("%s+", " ")
        end
        if obj:IsA("TextLabel") then
            return cleanText(obj.Text), obj
        elseif obj:IsA("Frame") then
            for _, ch in ipairs(obj:GetChildren()) do
                if ch:IsA("TextLabel") then
                    local name = cleanText(ch.Text)
                    if name then return name, ch end
                end
            end
        end
        return nil, nil
    end

    local map = {
        ["silent aim"] = "silent",
        ["macro"] = "macro",
        ["whitelist"] = "whitelist",
        ["protection"] = "protection",
        ["anti fall"] = "antifall",
        ["delay changer"] = "delay",
        ["esp"] = "esp",
        ["avatar"] = "avatar",
        ["combat"] = "hcsilent",
        ["force hit"] = "forcehit",
        ["hitbox expander"] = "hitbox",
        ["flamelock"] = "flamelock",
        ["camlock"] = "camlock",
        ["visuals"] = "fog",
        ["headless"] = "headless",
        ["protection + anti mod"] = "antimod",
        ["settings"] = "settings",
        ["credits"] = "info",
    }

    local rename = {
        ["combat"] = "♥  HC Silent Aim",
        ["visuals"] = "♥  Atmosphere Presets",
        ["protection + anti mod"] = "♥  Anti Mod",
        ["credits"] = "♥  Information",
    }

    -- Gather in the exact visual order produced by the original UIListLayout.
    local ordered = {}
    for _, child in ipairs(oldScroll:GetChildren()) do
        if not child:IsA("UIListLayout") and not child:IsA("UIPadding") then
            table.insert(ordered, child)
        end
    end
    table.sort(ordered, function(a, b)
        local ay, by = a.AbsolutePosition.Y, b.AbsolutePosition.Y
        if ay == by then
            local ax, bx = a.AbsolutePosition.X, b.AbsolutePosition.X
            if ax == bx then return a.Name < b.Name end
            return ax < bx
        end
        return ay < by
    end)

    local function isOldPink(c)
        return c.R > 0.72 and c.B > 0.45 and c.R > c.G + 0.1
    end

    local function styleToggleButton(btn)
        local knob=btn:FindFirstChildWhichIsA("Frame")
        if knob then
            local on=(knob.Position.X.Scale>.45) or (knob.Position.X.Offset>8)
            btn.BackgroundColor3=on and T.hot or T.bg2
            knob.BackgroundColor3=T.white
        elseif isOldPink(btn.BackgroundColor3) then
            btn.BackgroundColor3=T.hot
        end
    end

    local function styleObject(root)
        local all = {root}
        for _, d in ipairs(root:GetDescendants()) do table.insert(all, d) end
        for _, obj in ipairs(all) do
            if obj:IsA("Frame") then
                if obj:FindFirstChildOfClass("UIGradient") then
                    -- keep actual color-pickers / hue gradients functional
                elseif obj.Size.Y.Offset > 12 or obj.Size.Y.Scale > 0 then
                    if obj.Name ~= "FogPreview" and obj.Name ~= "FogSquare" and obj.Name ~= "FogHueBar" then
                        obj.BackgroundColor3 = T.card
                    end
                    obj.BorderSizePixel = 0
                    corner(obj, math.min(14, math.max(7, obj.Size.Y.Offset > 70 and 14 or 10)))
                elseif isOldPink(obj.BackgroundColor3) then
                    obj.BackgroundColor3 = T.hot
                end
            elseif obj:IsA("TextLabel") then
                local isHeader = obj.Text and obj.Text:sub(1, 1) == "♥"
                if isHeader then
                    obj.TextColor3 = T.hot
                    obj.Font = Enum.Font.FredokaOne
                    obj.TextSize = math.max(obj.TextSize, 18)
                else
                    if obj.TextSize >= 14 then
                        obj.TextColor3 = T.text
                    else
                        obj.TextColor3 = T.sub
                    end
                    if obj.Font == Enum.Font.SourceSansBold then obj.Font = Enum.Font.GothamSemibold end
                    if obj.Font == Enum.Font.SourceSans then obj.Font = Enum.Font.Gotham end
                end
            elseif obj:IsA("TextButton") then
                if obj.Text == "" then
                    styleToggleButton(obj)
                else
                    obj.BackgroundColor3 = T.bg2
                    obj.TextColor3 = T.hot
                    if obj.Font == Enum.Font.SourceSansBold then obj.Font = Enum.Font.GothamSemibold end
                    if obj.Font == Enum.Font.SourceSans then obj.Font = Enum.Font.Gotham end
                    corner(obj, 10)
                end
            elseif obj:IsA("TextBox") then
                obj.BackgroundColor3 = T.bg2
                obj.TextColor3 = T.hot
                obj.PlaceholderColor3 = T.sub
                obj.BorderSizePixel = 0
                obj.Font = Enum.Font.Gotham
                corner(obj, 10)
            elseif obj:IsA("UIStroke") then
                if isOldPink(obj.Color) then obj.Color = T.stroke end
            elseif obj:IsA("ScrollingFrame") then
                obj.ScrollBarImageColor3 = T.hot
            end
        end
    end

    local current = "silent"
    local orderCount = {}
    for _, child in ipairs(ordered) do
        local sec, headerLbl = sectionNameFromObject(child)
        if sec and map[sec] then
            current = map[sec]
            if rename[sec] and headerLbl then headerLbl.Text = rename[sec] end
        end
        local page = pages[current]
        if page then
            orderCount[current] = (orderCount[current] or 0) + 1
            child.LayoutOrder = orderCount[current]
            child.Parent = page
            styleObject(child)
        end
    end

    -- Remove the obsolete hide/show keybind card; Right Shift is fixed globally now.
    for _, obj in ipairs(pages.silent:GetDescendants()) do
        if obj:IsA("TextLabel") and obj.Text == "Hide/Show UI Key" then
            local card = obj.Parent
            if card and card:IsA("Frame") then card:Destroy() end
            break
        end
    end

    -- Fog picker is a direct child of Main in the original build.
    if oldFog then
        oldFog.Parent = pages.fog
        oldFog.LayoutOrder = 1
        oldFog.Position = UDim2.fromOffset(0, 0)
        oldFog.Size = UDim2.new(1, -6, 0, 560)
        oldFog.BackgroundColor3 = T.card
        oldFog.BorderSizePixel = 0
        corner(oldFog, 16)
        stroke(oldFog, T.stroke, 0.18, 1)
        styleObject(oldFog)
        -- Restore color-picker pieces that should show colors rather than theme blue.
        local square = oldFog:FindFirstChild("FogSquare")
        local hue = oldFog:FindFirstChild("FogHueBar")
        local prev = oldFog:FindFirstChild("FogPreview")
        if square then square.BackgroundColor3 = Color3.fromHSV(335/360, 1, 1) end
        if prev then prev.BackgroundColor3 = Color3.fromRGB(255,170,205) end
        if hue then hue.BackgroundColor3 = Color3.new(1,1,1) end
    end

    oldScroll.Visible = false
    oldScroll.Parent = gui

    -- Overview ------------------------------------------------------------
    local function card(parent, h)
        local f = Instance.new("Frame")
        f.Parent = parent
        f.Size = UDim2.new(1, -6, 0, h)
        f.BackgroundColor3 = T.panel
        f.BorderSizePixel = 0
        corner(f, 18)
        stroke(f, T.stroke, 0.18, 1)
        return f
    end

    local welcomeCard = card(pages.overview, 250)

    local banner = Instance.new("ImageLabel")
    banner.Parent = welcomeCard
    banner.Size = UDim2.new(1, -24, 0, 96)
    banner.Position = UDim2.fromOffset(12, 12)
    banner.BackgroundColor3 = T.bg2
    banner.BorderSizePixel = 0
    banner.ScaleType = Enum.ScaleType.Crop
    corner(banner, 16)
    local asset = assetFromWorkspace()
    if asset then
        banner.Image = asset
    else
        banner.Image = ""
        local grad = Instance.new("UIGradient", banner)
        grad.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(236, 255, 243)),
            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 212, 243)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(243, 161, 211)),
        })
        for i, x in ipairs({0.12, 0.34, 0.62, 0.84}) do
            local h = textLabel(banner, i % 2 == 0 and "♡" or "♥", UDim2.fromOffset(42,42), UDim2.new(x, -21, 0.5, -21), Enum.Font.FredokaOne, 29, Color3.fromRGB(232, 244, 255), Enum.TextXAlignment.Center)
            h.TextTransparency = 0.15
        end
    end

    local ovAvatar = Instance.new("ImageLabel")
    ovAvatar.Parent = welcomeCard
    ovAvatar.Size = UDim2.fromOffset(70, 70)
    ovAvatar.Position = UDim2.fromOffset(20, 128)
    ovAvatar.BackgroundColor3 = T.bg2
    ovAvatar.BorderSizePixel = 0
    corner(ovAvatar, 999)
    pcall(function()
        ovAvatar.Image = Players:GetUserThumbnailAsync(lp.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size180x180)
    end)
    stroke(ovAvatar, T.hot2, 0.3, 1)

    local ovTiny = textLabel(welcomeCard, "Kimqetras HC  ♥", UDim2.new(1, -120, 0, 18), UDim2.fromOffset(104, 127), Enum.Font.GothamSemibold, 11, T.sub)
    local ovWelcome = textLabel(welcomeCard, "welcome, " .. lp.DisplayName:lower() .. " ♡", UDim2.new(1, -120, 0, 34), UDim2.fromOffset(104, 145), Enum.Font.FredokaOne, 27, T.text)
    local ovUser = textLabel(welcomeCard, "@" .. lp.Name .. "   •   account age: " .. tostring(lp.AccountAge) .. " days", UDim2.new(1, -120, 0, 18), UDim2.fromOffset(104, 179), Enum.Font.Gotham, 11, T.sub)
    local ovDesc = textLabel(welcomeCard, "Everything has its own page now, so you can find a feature without digging through a giant list. Use the blue buttons on the left, and press F1 whenever you want the interface out of the way.", UDim2.new(1, -126, 0, 42), UDim2.fromOffset(104, 202), Enum.Font.Gotham, 11, T.sub)
    ovDesc.TextWrapped = true
    ovDesc.TextYAlignment = Enum.TextYAlignment.Top

    local statusCard = card(pages.overview, 128)
    local sTitle = textLabel(statusCard, "♡  little overview", UDim2.new(1, -24, 0, 24), UDim2.fromOffset(12, 10), Enum.Font.FredokaOne, 18, T.hot)
    local sDash = textLabel(statusCard, "-  -  -  -  -  -  -  -  -  -  -", UDim2.new(1, -24, 0, 14), UDim2.fromOffset(12, 33), Enum.Font.GothamBold, 9, T.stroke, Enum.TextXAlignment.Left)
    local sBody = textLabel(statusCard, "Silent Aim has its own page. Macro has its own page. Whitelist, ESP, Avatar, Fog / Atmosphere, Camlock, Flamelock, Force Hit, Hitbox, and the rest are separated too. Nothing is intentionally hidden inside a generic Combat page anymore.", UDim2.new(1, -24, 0, 68), UDim2.fromOffset(12, 50), Enum.Font.Gotham, 11, T.sub)
    sBody.TextWrapped = true
    sBody.TextYAlignment = Enum.TextYAlignment.Top

    local tipsCard = card(pages.overview, 112)
    local tTitle = textLabel(tipsCard, "♥  quick notes", UDim2.new(1, -24, 0, 24), UDim2.fromOffset(12, 11), Enum.Font.FredokaOne, 18, T.hot)
    local tBody = textLabel(tipsCard, "• The selected page turns hot blue so you always know where you are.\n• The banner uses KimqetrasBanner.png from your workspace when it is available.\n• There is no reopen bubble; F1 is the only hide/show shortcut.", UDim2.new(1, -24, 0, 66), UDim2.fromOffset(12, 39), Enum.Font.Gotham, 11, T.sub)
    tBody.TextWrapped = true
    tBody.TextYAlignment = Enum.TextYAlignment.Top

    -- Navigation ----------------------------------------------------------
    local navButtons = {}
    local function showPage(key)
        for k, p in pairs(pages) do p.Visible = (k == key) end
        local meta = pageMeta[key]
        pageTitle.Text = meta and meta.label or key
        pageDesc.Text = meta and meta.desc or ""
        for _, entry in ipairs(navButtons) do
            local active = entry.key == key
            entry.button.BackgroundColor3 = active and T.hot or T.panel
            entry.button.TextColor3 = active and T.white or T.text
            local heart = entry.button:FindFirstChild("Heart")
            if heart then heart.TextColor3 = active and T.white or T.hot end
            local st = entry.button:FindFirstChildOfClass("UIStroke")
            if st then st.Color = active and T.hot or T.stroke end
        end
    end

    for i, d in ipairs(pageDefs) do
        local btn = Instance.new("TextButton")
        btn.Parent = nav
        btn.LayoutOrder = i
        btn.Size = UDim2.new(1, -4, 0, 38)
        btn.BackgroundColor3 = T.panel
        btn.BorderSizePixel = 0
        btn.Text = "      " .. d[2]
        btn.TextColor3 = T.text
        btn.Font = Enum.Font.FredokaOne
        btn.TextSize = 13
        btn.TextXAlignment = Enum.TextXAlignment.Left
        btn.AutoButtonColor = false
        corner(btn, 12)
        stroke(btn, T.stroke, 0.28, 1)

        local h = textLabel(btn, "♡", UDim2.fromOffset(28, 38), UDim2.fromOffset(7, 0), Enum.Font.FredokaOne, 17, T.hot, Enum.TextXAlignment.Center)
        h.Name = "Heart"

        btn.MouseButton1Click:Connect(function() showPage(d[1]) end)
        table.insert(navButtons, {button = btn, key = d[1]})
    end

    -- v2.1 canonical GUI hide/show: F1 ONLY.
    -- Do not rely on a separate uiShown boolean, because later visual passes can
    -- change Main.Visible and leave that boolean out of sync.
    UIS.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Keyboard
            and input.KeyCode == Enum.KeyCode.F1 then
            if main and main.Parent then
                main.Visible = not main.Visible
            end
        end
    end)

    -- Custom drag from the top bar.
    local dragging = false
    local dragStart, startPos, dragInput
    top.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = main.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    top.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then dragInput = input end
    end)
    UIS.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)

    showPage("overview")

    -- Close the cute loader only after the pages are completely ready.
    local boot = CoreGui:FindFirstChild("KimpetrasHC_Boot") or playerGui:FindFirstChild("KimpetrasHC_Boot")
    if boot then
        local panel = boot:FindFirstChildWhichIsA("Frame", true)
        task.wait(0.12)
        pcall(function() boot:Destroy() end)
    end
end)


-- v2.1: legacy BlueFix2 visual pass removed for performance.

-- KIMQETRAS HC V3: FORCE PAGE SEPARATION + OVERVIEW POLISH
-- Runs after the earlier GUI build and sorts every control by its own label,
-- instead of relying on the old vertical positions.
task.spawn(function()
    task.wait(0.35)

    local Players = game:GetService("Players")
    local CoreGui = game:GetService("CoreGui")
    local lp = Players.LocalPlayer
    local playerGui = lp:WaitForChild("PlayerGui")

    local gui = CoreGui:FindFirstChild("KimpetrasHC") or playerGui:FindFirstChild("KimpetrasHC")
    local main = gui and gui:FindFirstChild("Main")
    if not main then return end
    if main:FindFirstChild("KimqV3ForcePages") then return end
    local marker = Instance.new("BoolValue")
    marker.Name = "KimqV3ForcePages"
    marker.Parent = main

    local T = {
        hot = Color3.fromRGB(243, 161, 211),
        hot2 = Color3.fromRGB(255, 212, 243),
        panel = Color3.fromRGB(255, 255, 255),
        bg2 = Color3.fromRGB(236, 255, 243),
        text = Color3.fromRGB(82, 116, 94),
        sub = Color3.fromRGB(122, 153, 133),
        stroke = Color3.fromRGB(255, 212, 243),
        white = Color3.fromRGB(255, 255, 255),
    }

    local function corner(obj, r)
        local c = obj:FindFirstChildOfClass("UICorner") or Instance.new("UICorner")
        c.CornerRadius = UDim.new(0, r or 12)
        c.Parent = obj
        return c
    end
    local function stroke(obj, color, tr, th)
        local s = obj:FindFirstChildOfClass("UIStroke") or Instance.new("UIStroke")
        s.Color = color or T.stroke
        s.Transparency = tr or 0
        s.Thickness = th or 1
        s.Parent = obj
        return s
    end
    local function label(parent, text, size, pos, font, textSize, color, align)
        local l = Instance.new("TextLabel")
        l.Parent = parent
        l.BackgroundTransparency = 1
        l.Size = size
        l.Position = pos
        l.Text = text
        l.Font = font or Enum.Font.Gotham
        l.TextSize = textSize or 14
        l.TextColor3 = color or T.text
        l.TextXAlignment = align or Enum.TextXAlignment.Left
        l.TextYAlignment = Enum.TextYAlignment.Center
        return l
    end

    -- Find all already-created page frames.
    local pages = {}
    for _, obj in ipairs(main:GetDescendants()) do
        if obj:IsA("ScrollingFrame") and obj.Name:match("Page$") then
            pages[obj.Name:gsub("Page$", ""):lower()] = obj
        end
    end
    if not pages.overview or not pages.silent or not pages.macro then return end

    -- Every visible control gets assigned by its OWN label, not by a previous header.
    local exact = {
        ["Silent Aim"] = "silent",
        ["Show FOV Circle"] = "silent",
        ["FOV Size"] = "silent",
        ["Bypass Revolver"] = "silent",
        ["Wall Check"] = "silent",
        ["Target Closest Part"] = "silent",
        ["HitPart (16 Parts)"] = "silent",
        ["Enable Keybind"] = "silent",
        ["Toggle Aim Key"] = "silent",
        ["Hide/Show UI Key"] = "silent",

        ["Macro / Speed Master"] = "macro",
        ["Macro Key"] = "macro",
        ["Macro Speed"] = "macro",
        ["Turn Master on, then press the Macro Key"] = "macro",

        ["Clear Whitelist"] = "whitelist",

        ["Anti Aim View"] = "protection",
        ["0% Aim Accuracy"] = "protection",

        ["Anti Fall"] = "antifall",

        ["Delay Changer"] = "delay",
        ["[Revolver] Delay"] = "delay",
        ["[Double-Barrel SG] Delay"] = "delay",
        ["[TacticalShotgun] Delay"] = "delay",
        ["Others Delay"] = "delay",

        ["ESP"] = "esp",
        ["Box"] = "esp",
        ["Name"] = "esp",
        ["Distance"] = "esp",
        ["Health"] = "esp",
        ["Snapline"] = "esp",
        ["Skeleton"] = "esp",

        ["User ID / Username"] = "avatar",
        ["Enable Avatar"] = "avatar",
        ["Visual Headless"] = "avatar",
        ["♥  Apply Avatar"] = "avatar",
        ["Apply Avatar"] = "avatar",
        ["Reset Character"] = "avatar",

        ["HC Silent Aim"] = "hcsilent",
        ["HC Revolver Bypass"] = "hcsilent",
        ["HC Wall Check"] = "hcsilent",
        ["HC Knock Check"] = "hcsilent",
        ["HC FOV Radius"] = "hcsilent",
        ["HC Hit Part"] = "hcsilent",
        ["HC Prediction"] = "hcsilent",
        ["HC Prediction Amount"] = "hcsilent",
        ["HC Godmode"] = "hcsilent",

        ["Force Hit"] = "forcehit",
        ["Force Hit Mode"] = "forcehit",
        ["Force Hit FOV"] = "forcehit",
        ["Force Hit Tracer"] = "forcehit",
        ["Force Hit Full Auto"] = "forcehit",
        ["Force Hit Fire Rate"] = "forcehit",

        ["Hitbox Expander"] = "hitbox",
        ["Hitbox Size"] = "hitbox",
        ["Hitbox Visibility"] = "hitbox",

        ["Flamelock"] = "flamelock",
        ["Right Click Lock"] = "flamelock",
        ["Activation Mode"] = "flamelock",
        ["Flamelock Key"] = "flamelock",
        ["Flame Hit Part"] = "flamelock",
        ["Flame Smoothness"] = "flamelock",
        ["Flame Prediction"] = "flamelock",
        ["Flame Left Offset"] = "flamelock",
        ["Flame Up Offset"] = "flamelock",

        ["Camlock Enabled"] = "camlock",
        ["Auto Toggle (Gun)"] = "camlock",
        ["Camlock Key"] = "camlock",
        ["Camlock Mode"] = "camlock",
        ["Camlock Hit Part"] = "camlock",
        ["Closest Point Mode"] = "camlock",
        ["Closest Point Scale"] = "camlock",
        ["Camlock FOV"] = "camlock",
        ["Max Distance"] = "camlock",
        ["Easing Style"] = "camlock",
        ["Easing Direction"] = "camlock",
        ["Camlock Smoothness"] = "camlock",
        ["Pull Strength"] = "camlock",
        ["Pull Base Value"] = "camlock",
        ["Pull Move Value"] = "camlock",
        ["Camlock Prediction"] = "camlock",
        ["Prediction X"] = "camlock",
        ["Prediction Y"] = "camlock",
        ["Prediction Z"] = "camlock",
        ["Force Field Check"] = "camlock",
        ["Visible Check"] = "camlock",
        ["Carried Check"] = "camlock",
        ["Knocked Check"] = "camlock",
        ["Self Knocked Check"] = "camlock",

        ["Atmosphere Preset"] = "fog",
        ["Reset Atmosphere"] = "fog",
        ["Color Correction"] = "fog",
        ["Saturation"] = "fog",

        ["Headless Mode"] = "headless",

        ["PWD Anti Aim View"] = "antimod",
        ["Anti Mod Notify"] = "antimod",
        ["Anti Mod Kick"] = "antimod",
        ["Anti Mod Kick Delay"] = "antimod",
        ["Anti Mod controls are OFF here by default so the script does not kick you unless you choose to enable it."] = "antimod",

        ["FPS Unlocker"] = "settings",
        ["Target FPS"] = "settings",
        ["Config Name"] = "settings",
        ["Save PWD Config"] = "settings",
        ["Load PWD Config"] = "settings",
        ["Delete PWD Config"] = "settings",
    }

    local sectionHeaderNames = {
        ["Silent Aim"] = true, ["Macro"] = true, ["Whitelist"] = true,
        ["Protection"] = true, ["Anti Fall"] = true, ["Delay Changer"] = true,
        ["ESP"] = true, ["Avatar"] = true, ["HC Silent Aim"] = true,
        ["Combat"] = true, ["Force Hit"] = true, ["Hitbox Expander"] = true,
        ["Flamelock"] = true, ["Camlock"] = true, ["Visuals"] = true,
        ["Headless"] = true, ["Protection + Anti Mod"] = true,
        ["Settings"] = true, ["Credits"] = true, ["Information"] = true,
        ["Atmosphere Presets"] = true,
    }

    local function cleanText(t)
        t = tostring(t or "")
        t = t:gsub("^%s*[♡♥]%s*", "")
        t = t:gsub("%s+", " ")
        t = t:gsub("^%s+", ""):gsub("%s+$", "")
        return t
    end

    local function controlLabel(container)
        -- Prefer direct labels/buttons so nested toggle knob text does not confuse the mapper.
        for _, ch in ipairs(container:GetChildren()) do
            if ch:IsA("TextLabel") or ch:IsA("TextButton") then
                local t = cleanText(ch.Text)
                if exact[t] then return t end
            end
        end
        for _, ch in ipairs(container:GetDescendants()) do
            if ch:IsA("TextLabel") or ch:IsA("TextButton") then
                local t = cleanText(ch.Text)
                if exact[t] then return t end
            end
        end
        return nil
    end

    local function isSectionHeader(obj)
        if not obj:IsA("TextLabel") then return false end
        return sectionHeaderNames[cleanText(obj.Text)] == true
    end

    -- Gather every control/card currently living in any page.
    local all = {}
    for key, page in pairs(pages) do
        if key ~= "overview" then
            for _, ch in ipairs(page:GetChildren()) do
                if not ch:IsA("UIListLayout") and not ch:IsA("UIPadding") then
                    table.insert(all, ch)
                end
            end
        end
    end

    -- Delete the old section-heading objects. The page header already says which page you're on.
    for _, obj in ipairs(all) do
        if isSectionHeader(obj) then
            pcall(function() obj:Destroy() end)
        end
    end

    -- Move cards by exact label.
    for _, obj in ipairs(all) do
        if obj.Parent and not isSectionHeader(obj) then
            local t = controlLabel(obj)
            local key = t and exact[t]
            if key and pages[key] then
                obj.Parent = pages[key]
            end
        end
    end

    -- Dynamic whitelist player cards do not have fixed names. Move any small card with ON/OFF button.
    for _, page in pairs(pages) do
        if page ~= pages.overview and page ~= pages.whitelist then
            local moving = {}
            for _, obj in ipairs(page:GetChildren()) do
                if obj:IsA("Frame") then
                    local button = obj:FindFirstChildOfClass("TextButton")
                    local lbl = obj:FindFirstChildOfClass("TextLabel")
                    if button and lbl and (button.Text == "ON" or button.Text == "OFF") then
                        table.insert(moving, obj)
                    end
                end
            end
            for _, obj in ipairs(moving) do obj.Parent = pages.whitelist end
        end
    end

    -- Move avatar custom button cards by their text if they were missed.
    for _, page in pairs(pages) do
        if page ~= pages.avatar and page ~= pages.overview then
            local moving = {}
            for _, obj in ipairs(page:GetChildren()) do
                if obj:IsA("Frame") then
                    for _, d in ipairs(obj:GetDescendants()) do
                        if d:IsA("TextButton") then
                            local t = cleanText(d.Text)
                            if t == "Apply Avatar" or t == "Reset Character" then
                                table.insert(moving, obj)
                                break
                            end
                        end
                    end
                end
            end
            for _, obj in ipairs(moving) do obj.Parent = pages.avatar end
        end
    end

    -- Keep the large fog picker on Fog / Atmosphere.
    local fogPanel = main:FindFirstChild("FogPanel", true)
    if fogPanel and pages.fog then
        fogPanel.Parent = pages.fog
        fogPanel.LayoutOrder = 1
    end

    -- Re-number visual order on each page.
    for _, page in pairs(pages) do
        local objs = {}
        for _, ch in ipairs(page:GetChildren()) do
            if not ch:IsA("UIListLayout") and not ch:IsA("UIPadding") then table.insert(objs, ch) end
        end
        table.sort(objs, function(a,b)
            if a.LayoutOrder ~= b.LayoutOrder then return a.LayoutOrder < b.LayoutOrder end
            return a.Name < b.Name
        end)
        for i, ch in ipairs(objs) do ch.LayoutOrder = i end
    end

    -- Fix sidebar hearts permanently: one heart inside the button text, no separate overlay label.
    for _, btn in ipairs(main:GetDescendants()) do
        if btn:IsA("TextButton") then
            local heart = btn:FindFirstChild("Heart")
            if heart then
                local txt = tostring(btn.Text or "")
                txt = txt:gsub("^%s+", "")
                txt = txt:gsub("^[♡♥]%s*", "")
                btn.Text = "♡   " .. txt
                btn.TextXAlignment = Enum.TextXAlignment.Left
                btn.TextSize = 13
                pcall(function() heart:Destroy() end)
            end
        end
    end

    -- Rebuild overview again so V3 is visibly different and more complete.
    local overview = pages.overview
    for _, ch in ipairs(overview:GetChildren()) do
        if not ch:IsA("UIListLayout") and not ch:IsA("UIPadding") then ch:Destroy() end
    end

    local function card(parent, h)
        local f = Instance.new("Frame")
        f.Parent = parent
        f.Size = UDim2.new(1, -6, 0, h)
        f.BackgroundColor3 = T.panel
        f.BorderSizePixel = 0
        corner(f, 18)
        stroke(f, T.stroke, 0.2, 1)
        return f
    end

    local hero = card(overview, 296)
    local banner = Instance.new("Frame")
    banner.Parent = hero
    banner.Size = UDim2.new(1, -24, 0, 118)
    banner.Position = UDim2.fromOffset(12, 12)
    banner.BackgroundColor3 = T.bg2
    banner.BorderSizePixel = 0
    corner(banner, 16)
    local grad = Instance.new("UIGradient", banner)
    grad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(236, 255, 243)),
        ColorSequenceKeypoint.new(0.45, Color3.fromRGB(255, 212, 243)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(243, 161, 211)),
    })
    grad.Rotation = 8

    local hearts = {
        {"♡", .08, .25, 26}, {"♥", .18, .68, 20}, {"♡", .32, .34, 40},
        {"♥", .47, .70, 25}, {"♡", .62, .28, 32}, {"♥", .76, .58, 38}, {"♡", .90, .30, 24}
    }
    for _, h in ipairs(hearts) do
        local x = label(banner, h[1], UDim2.fromOffset(44,44), UDim2.new(h[2],-22,h[3],-22), Enum.Font.FredokaOne, h[4], T.white, Enum.TextXAlignment.Center)
        x.TextTransparency = 0.08
    end
    local brand = label(banner, "Kimqetras HC", UDim2.new(0, 310, 0, 44), UDim2.new(0.5, -155, 0.5, -22), Enum.Font.FredokaOne, 32, T.white, Enum.TextXAlignment.Center)
    local tiny = label(banner, "♡  cute tools • clean pages • blue hearts  ♡", UDim2.new(0, 420, 0, 18), UDim2.new(0.5,-210,0.5,20), Enum.Font.GothamSemibold, 11, T.white, Enum.TextXAlignment.Center)

    local avatar = Instance.new("ImageLabel")
    avatar.Parent = hero
    avatar.Size = UDim2.fromOffset(78,78)
    avatar.Position = UDim2.fromOffset(18, 152)
    avatar.BackgroundColor3 = T.bg2
    avatar.BorderSizePixel = 0
    corner(avatar, 999)
    stroke(avatar, T.hot2, 0.25, 1)
    pcall(function()
        avatar.Image = Players:GetUserThumbnailAsync(lp.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size180x180)
    end)

    label(hero, "Kimqetras HC  ♡", UDim2.new(1,-120,0,18), UDim2.fromOffset(108,150), Enum.Font.GothamSemibold, 12, T.sub)
    label(hero, "welcome, " .. lp.DisplayName:lower() .. " ♡", UDim2.new(1,-120,0,40), UDim2.fromOffset(108,169), Enum.Font.FredokaOne, 31, T.text)
    label(hero, "@" .. lp.Name .. "   •   account age: " .. tostring(lp.AccountAge) .. " days", UDim2.new(1,-120,0,20), UDim2.fromOffset(108,208), Enum.Font.Gotham, 12, T.sub)
    local desc = label(hero, "Kimqetras HC is a page-based control hub that keeps each feature separate so you can find what you need quickly. Use the sidebar to switch tools, and press F1 whenever you want to hide or reopen the interface.", UDim2.new(1,-126,0,58), UDim2.fromOffset(108,232), Enum.Font.Gotham, 13, T.sub)
    desc.TextWrapped = true
    desc.TextYAlignment = Enum.TextYAlignment.Top

    local what = card(overview, 202)
    label(what, "♡  what the script includes", UDim2.new(1,-24,0,28), UDim2.fromOffset(12,11), Enum.Font.FredokaOne, 22, T.hot)
    label(what, "-  -  -  -  -  -  -  -  -  -  -  -  -", UDim2.new(1,-24,0,16), UDim2.fromOffset(12,40), Enum.Font.GothamBold, 10, T.stroke)
    local whatText = label(what,
        "Silent Aim — targeting, FOV, hit-part and keybind controls.\nMacro — movement speed and activation key.\nWhitelist — players that targeting and ESP should ignore.\nVisuals — ESP, fog, atmosphere and saturation controls.\nCombat tools — HC Silent Aim, Force Hit, Hitbox Expander, Flamelock and Camlock.\nUtilities — protection, anti-fall, delay changer, avatar tools, settings and configs.",
        UDim2.new(1,-24,0,138), UDim2.fromOffset(12,58), Enum.Font.Gotham, 13, T.sub)
    whatText.TextWrapped = true
    whatText.TextYAlignment = Enum.TextYAlignment.Top

    local notes = card(overview, 172)
    label(notes, "♥  quick notes", UDim2.new(1,-24,0,28), UDim2.fromOffset(12,11), Enum.Font.FredokaOne, 22, T.hot)
    label(notes, "-  -  -  -  -  -  -  -  -  -  -  -  -", UDim2.new(1,-24,0,16), UDim2.fromOffset(12,40), Enum.Font.GothamBold, 10, T.stroke)
    local notesText = label(notes,
        "• The selected page turns hot blue so you always know where you are.\n• Every major feature now has its own page instead of being piled into Silent Aim.\n• The banner is generated inside the script, so it does not depend on a workspace image.\n• F1 is the only hide/show shortcut — there is no floating reopen bubble.",
        UDim2.new(1,-24,0,108), UDim2.fromOffset(12,58), Enum.Font.Gotham, 13, T.sub)
    notesText.TextWrapped = true
    notesText.TextYAlignment = Enum.TextYAlignment.Top

    local dev = card(overview, 126)
    label(dev, "♡  build information", UDim2.new(1,-24,0,28), UDim2.fromOffset(12,11), Enum.Font.FredokaOne, 22, T.hot)
    label(dev, "-  -  -  -  -  -  -  -  -  -  -  -  -", UDim2.new(1,-24,0,16), UDim2.fromOffset(12,40), Enum.Font.GothamBold, 10, T.stroke)
    local devText = label(dev, "Interface: Kimqetras HC\nOriginal developer / scripter: famesgun\nRoblox profile: https://www.roblox.com/users/4246488996/profile\nLayout build: cute blue V3", UDim2.new(1,-24,0,68), UDim2.fromOffset(12,56), Enum.Font.Gotham, 12, T.sub)
    devText.TextWrapped = true
    devText.TextYAlignment = Enum.TextYAlignment.Top

    -- Put a clean developer card at the top of Information too.
    local info = pages.info
    if info then
        for _, ch in ipairs(info:GetChildren()) do
            if not ch:IsA("UIListLayout") and not ch:IsA("UIPadding") and ch.Name == "V3DeveloperCard" then ch:Destroy() end
        end
        local cardInfo = Instance.new("Frame")
        cardInfo.Name = "V3DeveloperCard"
        cardInfo.Parent = info
        cardInfo.Size = UDim2.new(1,-6,0,178)
        cardInfo.LayoutOrder = -100
        cardInfo.BackgroundColor3 = T.panel
        cardInfo.BorderSizePixel = 0
        corner(cardInfo,18)
        stroke(cardInfo,T.stroke,0.2,1)
        label(cardInfo,"♥  developer / credits",UDim2.new(1,-24,0,28),UDim2.fromOffset(12,11),Enum.Font.FredokaOne,22,T.hot)
        label(cardInfo,"-  -  -  -  -  -  -  -  -  -  -  -  -",UDim2.new(1,-24,0,16),UDim2.fromOffset(12,40),Enum.Font.GothamBold,10,T.stroke)
        local txt = label(cardInfo,"famesgun is the original developer / scripter behind the script.\n\nRoblox profile:\nhttps://www.roblox.com/users/4246488996/profile\n\nKimqetras HC is the custom interface and organization layer used for this build.",UDim2.new(1,-24,0,112),UDim2.fromOffset(12,58),Enum.Font.Gotham,13,T.sub)
        txt.TextWrapped = true
        txt.TextYAlignment = Enum.TextYAlignment.Top
    end

    -- Add a visible V3 badge so the user can immediately tell this file loaded.
    local badge = Instance.new("TextLabel")
    badge.Name = "V3Badge"
    badge.Parent = main
    badge.Size = UDim2.fromOffset(54,22)
    badge.Position = UDim2.new(1,-68,0,76)
    badge.BackgroundColor3 = T.hot
    badge.BorderSizePixel = 0
    badge.Text = "v2.1 ♡"
    badge.TextColor3 = T.white
    badge.Font = Enum.Font.FredokaOne
    badge.TextSize = 12
    badge.ZIndex = 60
    corner(badge,999)
end)

-- ========================================================
-- v2.1 CLEAN BUILD: legacy V5/V6/V7/V8 visual/theme layers removed.
-- The page/backend layer remains intact; a single lightweight v2.1 theme pass runs at the end.

-- V26 module: local accessory try-on (proven manual-weld implementation).
task.spawn(function()
    local Players = game:GetService("Players")
    local CoreGui = game:GetService("CoreGui")
    local TweenService = game:GetService("TweenService")
    local MarketplaceService = game:GetService("MarketplaceService")
    local InsertService = game:GetService("InsertService")

    local lp = Players.LocalPlayer
    local playerGui = lp:WaitForChild("PlayerGui")
    _G.KimqLocalVisualAccessoriesV15 = _G.KimqLocalVisualAccessoriesV15 or {}

    local function waitForMain(timeout)
        local t0 = tick()
        while tick() - t0 < (timeout or 20) do
            local root = CoreGui:FindFirstChild("KimpetrasHC") or playerGui:FindFirstChild("KimpetrasHC")
            local main = root and root:FindFirstChild("Main")
            if main then return root, main end
            task.wait(0.08)
        end
    end

    task.wait(1.00)
    local rootGui, main = waitForMain(10)
    if not rootGui or not main then return end
    if main:FindFirstChild("KimqV15AccessoryApplied") then return end

    local marker = Instance.new("BoolValue")
    marker.Name = "KimqV15AccessoryApplied"
    marker.Parent = main

    local avatarPage
    for _, obj in ipairs(main:GetDescendants()) do
        if obj:IsA("ScrollingFrame") and obj.Name:lower() == "avatarpage" then
            avatarPage = obj
            break
        end
    end
    if not avatarPage then return end

    local function corner(obj, radius)
        local c = obj:FindFirstChildOfClass("UICorner") or Instance.new("UICorner")
        c.CornerRadius = UDim.new(0, radius or 12)
        c.Parent = obj
        return c
    end
    local function stroke(obj, color, transparency, thickness)
        local s = obj:FindFirstChildOfClass("UIStroke") or Instance.new("UIStroke")
        s.Color = color
        s.Transparency = transparency or 0.22
        s.Thickness = thickness or 1
        s.Parent = obj
        return s
    end

    local function findCardContaining(text)
        local needle = string.lower(text)
        for _, child in ipairs(avatarPage:GetChildren()) do
            if child:IsA("Frame") then
                for _, d in ipairs(child:GetDescendants()) do
                    if (d:IsA("TextLabel") or d:IsA("TextButton")) and string.find(string.lower(tostring(d.Text or "")), needle, 1, true) then
                        return child
                    end
                end
            end
        end
    end

    local applyCard = findCardContaining("apply avatar")
    local referenceCard = applyCard or findCardContaining("reset character")
    local badge
    for _, d in ipairs(main:GetDescendants()) do
        if d:IsA("TextLabel") and tostring(d.Text or ""):match("^[Vv]%d") then
            badge = d
            break
        end
    end

    local function sampleTheme()
        local panel = referenceCard and referenceCard.BackgroundColor3 or Color3.fromRGB(242,247,255)
        local line = Color3.fromRGB(255,212,243)
        local hot = badge and badge.BackgroundColor3 or Color3.fromRGB(243,161,211)
        local light = panel:Lerp(hot, 0.12)
        local text = Color3.fromRGB(82,116,94)
        local sub = Color3.fromRGB(122,153,133)
        if referenceCard then
            local rs = referenceCard:FindFirstChildOfClass("UIStroke")
            if rs then line = rs.Color end
            for _, d in ipairs(referenceCard:GetDescendants()) do
                if d:IsA("TextLabel") and d.TextSize >= 13 and d.TextColor3 ~= sub then
                    text = d.TextColor3
                    break
                end
            end
        end
        return panel, line, hot, light, text, sub
    end

    local panelColor, lineColor, hotColor, lightColor, textColor, subColor = sampleTheme()
    local ROW_H = referenceCard and math.clamp(referenceCard.Size.Y.Offset, 52, 56) or 54

    -- remove older accessory UI rows
    for _, child in ipairs(avatarPage:GetChildren()) do
        if child.Name:find("Accessory") or child.Name == "LocalAccessoryTryOn" then
            pcall(function() child:Destroy() end)
        end
    end

    local function makeRow(name)
        local row = Instance.new("Frame")
        row.Name = name
        row.Parent = avatarPage
        row.Size = UDim2.new(1, -6, 0, ROW_H)
        row.BackgroundColor3 = panelColor
        row.BorderSizePixel = 0
        corner(row, 12)
        stroke(row, lineColor, 0.2, 1)
        return row
    end

    -- consistent row layout matching the rest of the page
    local titleRow = makeRow("V15AccessoryTitle")
    local titleLbl = Instance.new("TextLabel")
    titleLbl.Parent = titleRow
    titleLbl.Size = UDim2.new(0.38, -12, 1, 0)
    titleLbl.Position = UDim2.fromOffset(12, 0)
    titleLbl.BackgroundTransparency = 1
    titleLbl.Text = "Local Accessory"
    titleLbl.TextColor3 = textColor
    titleLbl.Font = Enum.Font.GothamBold
    titleLbl.TextSize = 14
    titleLbl.TextXAlignment = Enum.TextXAlignment.Left

    local titleSub = Instance.new("TextLabel")
    titleSub.Parent = titleRow
    titleSub.Size = UDim2.new(0.62, -20, 1, 0)
    titleSub.Position = UDim2.new(0.38, 8, 0, 0)
    titleSub.BackgroundTransparency = 1
    titleSub.Text = "hat / hair / face accessory • local only"
    titleSub.TextColor3 = subColor
    titleSub.Font = Enum.Font.Gotham
    titleSub.TextSize = 12
    titleSub.TextXAlignment = Enum.TextXAlignment.Right

    local inputRow = makeRow("V15AccessoryInput")
    local inputLbl = Instance.new("TextLabel")
    inputLbl.Parent = inputRow
    inputLbl.Size = UDim2.new(0, 145, 1, 0)
    inputLbl.Position = UDim2.fromOffset(12, 0)
    inputLbl.BackgroundTransparency = 1
    inputLbl.Text = "Accessory ID"
    inputLbl.TextColor3 = textColor
    inputLbl.Font = Enum.Font.GothamBold
    inputLbl.TextSize = 14
    inputLbl.TextXAlignment = Enum.TextXAlignment.Left

    local input = Instance.new("TextBox")
    input.Parent = inputRow
    input.Size = UDim2.new(1, -172, 0, 34)
    input.Position = UDim2.new(0, 160, 0.5, -17)
    input.BackgroundColor3 = lightColor
    input.BorderSizePixel = 0
    input.PlaceholderText = "paste accessory id..."
    input.PlaceholderColor3 = subColor
    input.Text = ""
    input.TextColor3 = textColor
    input.Font = Enum.Font.Gotham
    input.TextSize = 13
    input.ClearTextOnFocus = false
    input.TextXAlignment = Enum.TextXAlignment.Left
    corner(input, 10)
    local inputStroke = stroke(input, lineColor, 0.3, 1)
    local inputPad = Instance.new("UIPadding", input)
    inputPad.PaddingLeft = UDim.new(0, 10)
    inputPad.PaddingRight = UDim.new(0, 10)

    local actionRow = makeRow("V15AccessoryActions")
    local equip = Instance.new("TextButton")
    equip.Parent = actionRow
    equip.Size = UDim2.new(0.5, -14, 0, 34)
    equip.Position = UDim2.new(0, 10, 0.5, -17)
    equip.BackgroundColor3 = hotColor
    equip.BorderSizePixel = 0
    equip.Text = "♥  Equip Accessory"
    equip.TextColor3 = Color3.fromRGB(250,252,255)
    equip.Font = Enum.Font.GothamBold
    equip.TextSize = 13
    equip.AutoButtonColor = false
    corner(equip, 10)

    local remove = Instance.new("TextButton")
    remove.Parent = actionRow
    remove.Size = UDim2.new(0.5, -14, 0, 34)
    remove.Position = UDim2.new(0.5, 4, 0.5, -17)
    remove.BackgroundColor3 = lightColor
    remove.BorderSizePixel = 0
    remove.Text = "Remove All"
    remove.TextColor3 = textColor
    remove.Font = Enum.Font.GothamBold
    remove.TextSize = 13
    remove.AutoButtonColor = false
    corner(remove, 10)
    local removeStroke = stroke(remove, lineColor, 0.3, 1)

    local statusRow = makeRow("V15AccessoryStatus")
    local statusLbl = Instance.new("TextLabel")
    statusLbl.Parent = statusRow
    statusLbl.Size = UDim2.new(0, 92, 1, 0)
    statusLbl.Position = UDim2.fromOffset(12, 0)
    statusLbl.BackgroundTransparency = 1
    statusLbl.Text = "Status"
    statusLbl.TextColor3 = textColor
    statusLbl.Font = Enum.Font.GothamBold
    statusLbl.TextSize = 14
    statusLbl.TextXAlignment = Enum.TextXAlignment.Left

    local status = Instance.new("TextLabel")
    status.Parent = statusRow
    status.Size = UDim2.new(1, -124, 1, 0)
    status.Position = UDim2.fromOffset(110, 0)
    status.BackgroundTransparency = 1
    status.Text = "Ready"
    status.TextColor3 = subColor
    status.Font = Enum.Font.Gotham
    status.TextSize = 12
    status.TextXAlignment = Enum.TextXAlignment.Left

    local rows = {titleRow, inputRow, actionRow, statusRow}
    local baseOrder = applyCard and applyCard.LayoutOrder or 100
    for _, child in ipairs(avatarPage:GetChildren()) do
        if not table.find(rows, child)
            and not child:IsA("UIListLayout")
            and not child:IsA("UIPadding")
            and child.LayoutOrder > baseOrder then
            child.LayoutOrder += #rows
        end
    end
    for i, row in ipairs(rows) do
        row.LayoutOrder = baseOrder + i
    end

    local function setStatus(text, ok)
        status.Text = text
        status.TextColor3 = ok and hotColor or subColor
    end

    local function clearAccessoryPhysics(acc)
        for _, d in ipairs(acc:GetDescendants()) do
            if d:IsA("Script") or d:IsA("LocalScript") or d:IsA("ModuleScript") then
                pcall(function() d:Destroy() end)
            elseif d:IsA("BasePart") then
                d.CanCollide = false
                d.CanTouch = false
                d.CanQuery = false
                d.Massless = true
                d.Anchored = false
                pcall(function()
                    d.AssemblyLinearVelocity = Vector3.zero
                    d.AssemblyAngularVelocity = Vector3.zero
                end)
            elseif d:IsA("Weld") or d:IsA("WeldConstraint") or d:IsA("Motor6D") then
                pcall(function() d:Destroy() end)
            end
        end
    end

    local function findAccessory(root)
        if not root then return nil end
        if root:IsA("Accessory") then return root end
        return root:FindFirstChildWhichIsA("Accessory", true)
    end

    local function loadAccessory(assetId)
        local loaders = {
            function()
                local objs = game:GetObjects("rbxassetid://" .. tostring(assetId))
                for _, root in ipairs(objs or {}) do
                    local acc = findAccessory(root)
                    if acc then
                        local clone = acc:Clone()
                        for _, o in ipairs(objs) do pcall(function() o:Destroy() end) end
                        return clone, "getobjects"
                    end
                end
                for _, o in ipairs(objs or {}) do pcall(function() o:Destroy() end) end
            end,
            function()
                local model = InsertService:LoadAsset(assetId)
                if model then
                    local acc = findAccessory(model)
                    if acc then
                        local clone = acc:Clone()
                        pcall(function() model:Destroy() end)
                        return clone, "insertservice"
                    end
                    pcall(function() model:Destroy() end)
                end
            end,
        }
        for _, loader in ipairs(loaders) do
            local ok, acc, method = pcall(loader)
            if ok and acc then return acc, method end
        end
        return nil, nil
    end

    local ATTACHMENT_NAMES = {
        HatAttachment = true,
        HairAttachment = true,
        FaceFrontAttachment = true,
        FaceCenterAttachment = true,
    }

    local function findHeadAttachPair(character, handle)
        local head = character:FindFirstChild("Head")
        if not head then return nil end
        for _, att in ipairs(handle:GetChildren()) do
            if att:IsA("Attachment") and ATTACHMENT_NAMES[att.Name] then
                local headAtt = head:FindFirstChild(att.Name)
                if headAtt and headAtt:IsA("Attachment") then
                    return head, headAtt, att
                end
            end
        end
        local fallback = handle:FindFirstChild("HatAttachment")
        local headHat = head:FindFirstChild("HatAttachment")
        if fallback and headHat then return head, headHat, fallback end
        return nil
    end

    local function removeExistingOnChar(char, assetId)
        for _, child in ipairs(char:GetChildren()) do
            if child:IsA("Accessory") and child:GetAttribute("KimqLocalV15") and child:GetAttribute("KimqAssetId") == assetId then
                pcall(function() child:Destroy() end)
            end
        end
    end

    local function attachAccessory(assetId, character, quiet)
        local char = character or lp.Character
        if not char then
            if not quiet then setStatus("Character not ready", false) end
            return false
        end
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        local head = char:FindFirstChild("Head") or char:WaitForChild("Head", 6)
        if not humanoid or not head then
            if not quiet then setStatus("Character not ready", false) end
            return false
        end

        removeExistingOnChar(char, assetId)

        local info
        pcall(function()
            info = MarketplaceService:GetProductInfo(assetId, Enum.InfoType.Asset)
        end)

        local acc, method = loadAccessory(assetId)
        if not acc then
            if not quiet then setStatus("Could not load that accessory", false) end
            return false
        end

        local handle = acc:FindFirstChild("Handle")
        if not handle or not handle:IsA("BasePart") then
            pcall(function() acc:Destroy() end)
            if not quiet then setStatus("That item is not a wearable accessory", false) end
            return false
        end

        local bodyPart, bodyAtt, handleAtt = findHeadAttachPair(char, handle)
        if not bodyPart or not bodyAtt or not handleAtt then
            pcall(function() acc:Destroy() end)
            if not quiet then setStatus("Use a hat, hair, or face accessory ID", false) end
            return false
        end

        clearAccessoryPhysics(acc)
        acc.Name = "KimqLocal_" .. tostring(assetId)
        acc:SetAttribute("KimqLocalV15", true)
        acc:SetAttribute("KimqAssetId", assetId)
        acc.Parent = char

        handle.CFrame = bodyPart.CFrame * bodyAtt.CFrame * handleAtt.CFrame:Inverse()
        local weld = Instance.new("Weld")
        weld.Name = "KimqLocalWeldV15"
        weld.Part0 = bodyPart
        weld.Part1 = handle
        weld.C0 = bodyAtt.CFrame
        weld.C1 = handleAtt.CFrame
        weld.Parent = handle

        local displayName = (info and info.Name) or "Accessory"
        if not quiet then
            setStatus("Wearing " .. displayName .. " locally", true)
        end
        return true
    end

    local function saveId(assetId)
        for _, id in ipairs(_G.KimqLocalVisualAccessoriesV15) do
            if id == assetId then return end
        end
        table.insert(_G.KimqLocalVisualAccessoriesV15, assetId)
    end

    local function removeAll(character)
        local char = character or lp.Character
        if not char then return end
        for _, child in ipairs(char:GetChildren()) do
            if child:IsA("Accessory") and child:GetAttribute("KimqLocalV15") then
                pcall(function() child:Destroy() end)
            end
        end
    end

    equip.MouseButton1Click:Connect(function()
        local assetId = tonumber((tostring(input.Text or ""):match("%d+")))
        if not assetId then
            setStatus("Enter an accessory ID", false)
            return
        end
        equip.Text = "Loading..."
        setStatus("Loading accessory...", false)
        task.spawn(function()
            local ok = attachAccessory(assetId, nil, false)
            if ok then
                saveId(assetId)
                equip.Text = "Equipped ♥"
            else
                equip.Text = "Try Again"
            end
            task.wait(1.0)
            if equip.Parent then equip.Text = "♥  Equip Accessory" end
        end)
    end)

    remove.MouseButton1Click:Connect(function()
        removeAll()
        table.clear(_G.KimqLocalVisualAccessoriesV15)
        setStatus("Removed all local accessories", true)
    end)

    lp.CharacterAdded:Connect(function(char)
        task.spawn(function()
            char:WaitForChild("Head", 8)
            task.wait(0.9)
            for _, assetId in ipairs(_G.KimqLocalVisualAccessoriesV15) do
                attachAccessory(assetId, char, true)
                task.wait(0.08)
            end
        end)
    end)

    local function syncTheme()
        panelColor, lineColor, hotColor, lightColor, textColor, subColor = sampleTheme()
        for _, row in ipairs(rows) do
            row.BackgroundColor3 = panelColor
            local rs = row:FindFirstChildOfClass("UIStroke")
            if rs then rs.Color = lineColor end
        end
        titleLbl.TextColor3 = textColor
        titleSub.TextColor3 = subColor
        inputLbl.TextColor3 = textColor
        input.BackgroundColor3 = lightColor
        input.TextColor3 = textColor
        input.PlaceholderColor3 = subColor
        inputStroke.Color = lineColor
        equip.BackgroundColor3 = hotColor
        remove.BackgroundColor3 = lightColor
        remove.TextColor3 = textColor
        removeStroke.Color = lineColor
        statusLbl.TextColor3 = textColor
        local isPositive = status.Text ~= "Ready" and status.TextColor3 ~= subColor
        status.TextColor3 = isPositive and hotColor or subColor
    end

    if badge then
        badge.Text = "v2.1 ♡"
        if badge:IsA("TextLabel") then
            badge:GetPropertyChangedSignal("BackgroundColor3"):Connect(function()
                task.defer(syncTheme)
            end)
        end
    end

    for _, button in ipairs({equip, remove}) do
        local scale = Instance.new("UIScale")
        scale.Parent = button
        button.MouseEnter:Connect(function()
            TweenService:Create(scale, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Scale = 1.02}):Play()
        end)
        button.MouseLeave:Connect(function()
            TweenService:Create(scale, TweenInfo.new(0.14, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Scale = 1}):Play()
        end)
    end

    syncTheme()
end)


-- ========================================================


-- V26 module: Environment + Weapon Skins (single final implementation).
task.spawn(function()
    local Players = game:GetService("Players")
    local CoreGui = game:GetService("CoreGui")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local Lighting = game:GetService("Lighting")
    local RunService = game:GetService("RunService")
    local TweenService = game:GetService("TweenService")
    local lp = Players.LocalPlayer
    local pg = lp:WaitForChild("PlayerGui")
    local terrain = workspace:FindFirstChildOfClass("Terrain")
    local loader = nil -- legacy cover loader removed in V26 Lite

    local function setProgress(text, n)
        if loader and loader.Status and loader.Status.Parent then loader.Status.Text = text end
        if loader and loader.Bar and loader.Bar.Parent then TweenService:Create(loader.Bar,TweenInfo.new(.32,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{Size=UDim2.new(n,0,1,0)}):Play() end
        if loader and loader.Tip and loader.Tip.Parent then TweenService:Create(loader.Tip,TweenInfo.new(.32,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{Position=UDim2.new(n,0,.5,0)}):Play() end
    end

    task.wait(1.20)
    setProgress("fixing the final pages...", .91)

    local root = CoreGui:FindFirstChild("KimpetrasHC") or pg:FindFirstChild("KimpetrasHC")
    local main = root and root:FindFirstChild("Main")
    if not main then
        _G.KimqV26FeaturesReady=true
        if loader and loader.Gui then loader.Gui:Destroy() end
        return
    end

    local function norm(s)
        s=tostring(s or ""):lower():gsub("[♥♡❤]","")
        s=s:gsub("^%s+",""):gsub("%s+$",""):gsub("%s+"," ")
        return s
    end
    local function corner(o,r)
        local c=o:FindFirstChildOfClass("UICorner") or Instance.new("UICorner")
        c.CornerRadius=UDim.new(0,r or 12); c.Parent=o; return c
    end
    local function stroke(o,color,tr,th)
        local s=o:FindFirstChildOfClass("UIStroke") or Instance.new("UIStroke")
        s.Color=color; s.Transparency=tr or .22; s.Thickness=th or 1; s.Parent=o; return s
    end
    local function txt(parent,text,size,pos,font,ts,color,align)
        local l=Instance.new("TextLabel",parent)
        l.Size=size; l.Position=pos; l.BackgroundTransparency=1; l.Text=text; l.Font=font; l.TextSize=ts; l.TextColor3=color; l.TextXAlignment=align or Enum.TextXAlignment.Left; l.TextYAlignment=Enum.TextYAlignment.Center
        return l
    end

    local pages, pageHost = {}, nil
    for _,d in ipairs(main:GetDescendants()) do
        if d:IsA("ScrollingFrame") and d.Name:match("Page$") then pages[d.Name:gsub("Page$",""):lower()] = d; pageHost=d.Parent end
    end
    if not pageHost then
        _G.KimqV26FeaturesReady=true; main.Visible=true; if loader and loader.Gui then loader.Gui:Destroy() end; return
    end

    local nav
    for _,d in ipairs(main:GetDescendants()) do
        if d:IsA("ScrollingFrame") and not d.Name:match("Page$") then
            for _,b in ipairs(d:GetChildren()) do
                if b:IsA("TextButton") and norm(b.Text)=="overview" then nav=d break end
            end
        end
        if nav then break end
    end
    if not nav then
        _G.KimqV26FeaturesReady=true; main.Visible=true; if loader and loader.Gui then loader.Gui:Destroy() end; return
    end

    local badge
    for _,d in ipairs(main:GetDescendants()) do
        if d:IsA("TextLabel") and tostring(d.Text or ""):match("^[Vv]%d") then
            d.Text="v2.1 ♡"
            if not badge or d.Visible then badge=d end
        end
    end

    local pageTitle,pageDesc
    for _,d in ipairs(main:GetDescendants()) do
        if d:IsA("TextLabel") then
            if norm(d.Text)=="overview" and d.TextSize>=18 then pageTitle=d end
            if tostring(d.Text or ""):lower():find("your account",1,true) then pageDesc=d end
        end
    end

    -- Find normal sidebar buttons before deleting the V21 specials.
    local normalButtons={}
    for _,b in ipairs(nav:GetChildren()) do
        if b:IsA("TextButton") and norm(b.Text)~="environment" and norm(b.Text)~="weapon skins" then
            table.insert(normalButtons,b)
        end
    end
    local function chooseInactiveTemplate()
        local hot = badge and badge.BackgroundColor3
        for _,b in ipairs(normalButtons) do
            if norm(b.Text)~="overview" and (not hot or math.sqrt((b.BackgroundColor3.R-hot.R)^2 + (b.BackgroundColor3.G-hot.G)^2 + (b.BackgroundColor3.B-hot.B)^2) > .08) then return b end
        end
        return normalButtons[2] or normalButtons[1]
    end
    local function chooseActiveTemplate()
        local hot = badge and badge.BackgroundColor3
        if hot then
            for _,b in ipairs(normalButtons) do if math.sqrt((b.BackgroundColor3.R-hot.R)^2 + (b.BackgroundColor3.G-hot.G)^2 + (b.BackgroundColor3.B-hot.B)^2) < .08 then return b end end
        end
        for _,b in ipairs(normalButtons) do if norm(b.Text)=="overview" then return b end end
        return normalButtons[1]
    end
    local inactiveTemplate=chooseInactiveTemplate()
    local activeTemplate=chooseActiveTemplate()
    if not inactiveTemplate then _G.KimqV26FeaturesReady=true; main.Visible=true; if loader and loader.Gui then loader.Gui:Destroy() end; return end

    local function copyVisual(dst,src)
        if not dst or not src then return end
        dst.BackgroundColor3=src.BackgroundColor3; dst.BackgroundTransparency=src.BackgroundTransparency
        dst.TextColor3=src.TextColor3; dst.TextStrokeColor3=src.TextStrokeColor3; dst.TextStrokeTransparency=src.TextStrokeTransparency
        dst.Font=src.Font; dst.TextSize=src.TextSize
        local ss=src:FindFirstChildOfClass("UIStroke"); local ds=dst:FindFirstChildOfClass("UIStroke")
        if ss then ds=ds or Instance.new("UIStroke",dst); ds.Color=ss.Color; ds.Transparency=ss.Transparency; ds.Thickness=ss.Thickness end
    end

    local function sampleTheme()
        inactiveTemplate=chooseInactiveTemplate() or inactiveTemplate
        activeTemplate=chooseActiveTemplate() or activeTemplate
        local hot=(badge and badge.BackgroundColor3) or (activeTemplate and activeTemplate.BackgroundColor3) or Color3.fromRGB(243,161,211)
        local panel=inactiveTemplate.BackgroundColor3
        local line=(inactiveTemplate:FindFirstChildOfClass("UIStroke") and inactiveTemplate:FindFirstChildOfClass("UIStroke").Color) or hot:Lerp(Color3.new(1,1,1),.55)
        local text=inactiveTemplate.TextColor3
        local sub=text:Lerp(panel,.42)
        local light=panel:Lerp(hot,.12)
        return panel,line,hot,light,text,sub
    end
    local panelColor,lineColor,hotColor,lightColor,textColor,subColor=sampleTheme()

    -- Kill V21 pages and nav buttons. Their old callbacks disappear with them.
    for _,b in ipairs(nav:GetChildren()) do
        if b:IsA("TextButton") and (norm(b.Text)=="environment" or norm(b.Text)=="weapon skins") then pcall(function() b:Destroy() end) end
    end
    for _,pname in ipairs({"environmentPage","weaponskinsPage"}) do
        local p=pageHost:FindFirstChild(pname); if p then p:Destroy() end
    end
    pages.environment=nil; pages.weaponskins=nil

    local function newPage(name)
        local p=Instance.new("ScrollingFrame")
        p.Name=name.."Page"; p.Parent=pageHost; p.Size=UDim2.fromScale(1,1); p.BackgroundTransparency=1; p.BorderSizePixel=0; p.Visible=false; p.ScrollBarThickness=3; p.ScrollBarImageColor3=hotColor
        local pad=Instance.new("UIPadding",p); pad.PaddingRight=UDim.new(0,4)
        local list=Instance.new("UIListLayout",p); list.SortOrder=Enum.SortOrder.LayoutOrder; list.Padding=UDim.new(0,10)
        list:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() p.CanvasSize=UDim2.new(0,0,0,list.AbsoluteContentSize.Y+12) end)
        pages[name]=p; return p
    end
    local function card(page,h)
        local f=Instance.new("Frame",page); f.Size=UDim2.new(1,-6,0,h or 56); f.BackgroundColor3=panelColor; f.BorderSizePixel=0; corner(f,14); stroke(f,lineColor,.2,1); return f
    end

    local fogOrder=10
    for _,b in ipairs(nav:GetChildren()) do if b:IsA("TextButton") and norm(b.Text)=="fog / atmosphere" then fogOrder=b.LayoutOrder end end
    for _,b in ipairs(nav:GetChildren()) do if b:IsA("TextButton") and b.LayoutOrder>fogOrder then b.LayoutOrder+=2 end end

    local envPage=newPage("environment")
    local skinsPage=newPage("weaponskins")

    local function makeNav(text,order)
        local b=inactiveTemplate:Clone(); b.Name=text:gsub("%s+","").."NavV26"; b.Text="♥  "..text; b.LayoutOrder=order; b.Parent=nav; copyVisual(b,inactiveTemplate); return b
    end
    local envBtn=makeNav("environment",fogOrder+1)
    local skinsBtn=makeNav("weapon skins",fogOrder+2)

    local specialActive=nil
    local function styleSpecial(btn,on)
        copyVisual(btn,on and (chooseActiveTemplate() or activeTemplate) or (chooseInactiveTemplate() or inactiveTemplate))
        btn.Text="♥  "..(btn==envBtn and "environment" or "weapon skins")
    end
    styleSpecial(envBtn,false); styleSpecial(skinsBtn,false)

    -- Environment ----------------------------------------------------------
    pcall(function() if _G.KimqEnvironmentController and _G.KimqEnvironmentController.Restore then _G.KimqEnvironmentController.Restore() end end)
    for _,n in ipairs({"KimqV20Environment","KimqV21Environment","KimqV26Environment"}) do local x=workspace:FindFirstChild(n); if x then x:Destroy() end end
    local oldCC=Lighting:FindFirstChild("KimqV21SeasonColor"); if oldCC then oldCC:Destroy() end

    local ei=card(envPage,78)
    local eiTitle=txt(ei,"♥  environment",UDim2.new(1,-24,0,28),UDim2.fromOffset(12,9),Enum.Font.FredokaOne,21,hotColor)
    local eiSub=txt(ei,"Cute seasonal map styles. Your Fog / Atmosphere page stays completely editable.",UDim2.new(1,-24,0,30),UDim2.fromOffset(12,40),Enum.Font.Gotham,12,subColor); eiSub.TextWrapped=true

    local original={Ambient=Lighting.Ambient,OutdoorAmbient=Lighting.OutdoorAmbient,Brightness=Lighting.Brightness,ClockTime=Lighting.ClockTime,Exposure=Lighting.ExposureCompensation,Grass=terrain and terrain:GetMaterialColor(Enum.Material.Grass),Ground=terrain and terrain:GetMaterialColor(Enum.Material.Ground)}
    local changedParts={}; local seasonFolder=Instance.new("Folder",workspace); seasonFolder.Name="KimqV26Environment"; local followConn; local activePreset="Normal"

    local function grassLike(p)
        if not p:IsA("BasePart") or p:IsDescendantOf(seasonFolder) then return false end
        local n=p.Name:lower()
        if p.Material==Enum.Material.Grass or n:find("grass",1,true) or n:find("lawn",1,true) or n:find("turf",1,true) then return true end
        local c=p.Color; local flat=p.Size.Y<=5 and (p.Size.X>=6 or p.Size.Z>=6); local green=c.G>c.R*1.12 and c.G>c.B*1.08 and c.G>.22
        return flat and green
    end
    local function savePart(p)
        if changedParts[p] then return end
        local rec={Color=p.Color,Material=p.Material,Children={}}
        for _,d in ipairs(p:GetDescendants()) do
            if d:IsA("Texture") or d:IsA("Decal") then table.insert(rec.Children,{Obj=d,Transparency=d.Transparency}) end
        end
        changedParts[p]=rec
    end
    local function recolorGrass(color,material,hideTextures)
        local count=0
        for _,p in ipairs(workspace:GetDescendants()) do
            if grassLike(p) then
                savePart(p); p.Color=color; if material then p.Material=material end
                if hideTextures then for _,r in ipairs(changedParts[p].Children) do if r.Obj and r.Obj.Parent then r.Obj.Transparency=1 end end end
                count+=1; if count>4500 then break end
            end
        end
    end
    local function clearSeasonFX()
        if followConn then pcall(function() followConn:Disconnect() end); followConn=nil end
        seasonFolder:ClearAllChildren()
        for _,n in ipairs({"KimqV21SeasonColor","KimqV26SeasonColor"}) do local cc=Lighting:FindFirstChild(n); if cc then cc:Destroy() end end
    end
    local function restoreEnv()
        clearSeasonFX()
        for p,rec in pairs(changedParts) do
            if p and p.Parent then
                pcall(function() p.Color=rec.Color; p.Material=rec.Material end)
                for _,r in ipairs(rec.Children or {}) do if r.Obj and r.Obj.Parent then pcall(function() r.Obj.Transparency=r.Transparency end) end end
            end
        end
        table.clear(changedParts)
        Lighting.Ambient=original.Ambient; Lighting.OutdoorAmbient=original.OutdoorAmbient; Lighting.Brightness=original.Brightness; Lighting.ClockTime=original.ClockTime; Lighting.ExposureCompensation=original.Exposure
        if terrain then pcall(function() terrain:SetMaterialColor(Enum.Material.Grass,original.Grass) end); pcall(function() terrain:SetMaterialColor(Enum.Material.Ground,original.Ground) end) end
        activePreset="Normal"
    end
    local function addSnow()
        local holder=Instance.new("Part",seasonFolder); holder.Name="CuteSnowCloud"; holder.Size=Vector3.new(150,1,150); holder.Transparency=1; holder.Anchored=true; holder.CanCollide=false; holder.CanTouch=false; holder.CanQuery=false
        local function emit(rate,sizeA,sizeB,speedA,speedB,spread,alpha)
            local e=Instance.new("ParticleEmitter",holder)
            e.Texture="rbxasset://textures/particles/sparkles_main.dds"; e.Rate=rate; e.Lifetime=NumberRange.new(7,10); e.Speed=NumberRange.new(speedA,speedB); e.Acceleration=Vector3.new(.3,-1.25,.15); e.Drag=.4; e.LightInfluence=0; e.EmissionDirection=Enum.NormalId.Bottom; e.SpreadAngle=Vector2.new(spread,spread); e.Rotation=NumberRange.new(0,360); e.RotSpeed=NumberRange.new(-9,9); e.Color=ColorSequence.new(Color3.new(1,1,1),Color3.fromRGB(225,241,255)); e.Size=NumberSequence.new({NumberSequenceKeypoint.new(0,sizeA),NumberSequenceKeypoint.new(.55,sizeB),NumberSequenceKeypoint.new(1,sizeA*.55)}); e.Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,alpha),NumberSequenceKeypoint.new(.88,alpha+.1),NumberSequenceKeypoint.new(1,1)})
        end
        emit(185,.06,.11,1.7,3.0,22,.05); emit(72,.12,.20,1.15,2.3,30,.16); emit(24,.21,.31,.8,1.6,36,.30)
        local function follow() local hrp=lp.Character and lp.Character:FindFirstChild("HumanoidRootPart"); if hrp and holder.Parent then holder.CFrame=CFrame.new(hrp.Position+Vector3.new(0,48,0)) end end
        follow(); followConn=RunService.RenderStepped:Connect(follow)
    end

    local presetRows={}
    local descs={Normal="restore the original map look",Christmas="soft snowy ground + layered falling snow",Halloween="warm autumn colors — cute and cozy"}
    local envStatusValue
    local function refreshPreset()
        for name,p in pairs(presetRows) do
            local on=name==activePreset; p.Button.Text=on and "selected ♥" or "choose"; p.Button.BackgroundColor3=on and hotColor or lightColor; p.Button.TextColor3=on and Color3.fromRGB(250,252,255) or textColor
        end
        if envStatusValue then envStatusValue.Text=activePreset; envStatusValue.TextColor3=activePreset=="Normal" and subColor or hotColor end
    end
    local function applyEnv(name)
        restoreEnv(); activePreset=name
        if name=="Christmas" then
            if terrain then pcall(function() terrain:SetMaterialColor(Enum.Material.Grass,Color3.fromRGB(239,246,252)) end); pcall(function() terrain:SetMaterialColor(Enum.Material.Ground,Color3.fromRGB(229,238,247)) end) end
            recolorGrass(Color3.fromRGB(241,247,252),Enum.Material.Snow,true)
            Lighting.Ambient=original.Ambient:Lerp(Color3.fromRGB(222,234,247),.18); Lighting.OutdoorAmbient=original.OutdoorAmbient:Lerp(Color3.fromRGB(235,244,252),.22); Lighting.Brightness=math.max(original.Brightness,1.85); Lighting.ExposureCompensation=original.Exposure+.02
            addSnow()
        elseif name=="Halloween" then
            if terrain then pcall(function() terrain:SetMaterialColor(Enum.Material.Grass,Color3.fromRGB(191,132,78)) end) end
            recolorGrass(Color3.fromRGB(196,129,70),nil,false)
            Lighting.Ambient=original.Ambient:Lerp(Color3.fromRGB(190,135,132),.12); Lighting.OutdoorAmbient=original.OutdoorAmbient:Lerp(Color3.fromRGB(218,158,121),.13); Lighting.Brightness=math.max(original.Brightness*.98,1.8); Lighting.ClockTime=16.6; Lighting.ExposureCompensation=original.Exposure
        end
        -- No fog, Atmosphere, or color-correction properties are touched here.
        refreshPreset()
    end
    for _,name in ipairs({"Normal","Christmas","Halloween"}) do
        local r=card(envPage,62)
        txt(r,name,UDim2.new(.35,-12,0,22),UDim2.fromOffset(12,7),Enum.Font.GothamBold,15,textColor)
        txt(r,descs[name],UDim2.new(1,-164,0,22),UDim2.fromOffset(12,31),Enum.Font.Gotham,11,subColor)
        local b=Instance.new("TextButton",r); b.Size=UDim2.fromOffset(116,34); b.Position=UDim2.new(1,-128,.5,-17); b.BackgroundColor3=lightColor; b.BorderSizePixel=0; b.Text="choose"; b.TextColor3=textColor; b.Font=Enum.Font.GothamBold; b.TextSize=12; b.AutoButtonColor=false; corner(b,10); stroke(b,lineColor,.3,1)
        presetRows[name]={Row=r,Button=b}; b.MouseButton1Click:Connect(function() applyEnv(name) end)
    end
    local es=card(envPage,52)
    txt(es,"Environment",UDim2.fromOffset(120,52),UDim2.fromOffset(12,0),Enum.Font.GothamBold,14,textColor)
    envStatusValue=txt(es,"Normal",UDim2.new(1,-150,1,0),UDim2.fromOffset(140,0),Enum.Font.Gotham,13,subColor)
    refreshPreset()
    _G.KimqEnvironmentController={Apply=applyEnv,Restore=restoreEnv,GetPreset=function() return activePreset end}

    setProgress("finding all of the weapon skins...", .95)

    -- Weapon skins --------------------------------------------------------
    local wi=card(skinsPage,76)
    local wiTitle=txt(wi,"♥  weapon skins",UDim2.new(1,-24,0,28),UDim2.fromOffset(12,9),Enum.Font.FredokaOne,21,hotColor)
    local wiSub=txt(wi,"Select a weapon first. Its matching skins will appear underneath.",UDim2.new(1,-24,0,28),UDim2.fromOffset(12,40),Enum.Font.Gotham,12,subColor)

    local weaponCard=card(skinsPage,154)
    txt(weaponCard,"Weapon",UDim2.new(0,150,0,22),UDim2.fromOffset(12,8),Enum.Font.GothamBold,14,textColor)
    local refresh=Instance.new("TextButton",weaponCard); refresh.Size=UDim2.fromOffset(90,28); refresh.Position=UDim2.new(1,-102,0,6); refresh.BackgroundColor3=lightColor; refresh.BorderSizePixel=0; refresh.Text="refresh"; refresh.TextColor3=textColor; refresh.Font=Enum.Font.GothamBold; refresh.TextSize=11; corner(refresh,9); stroke(refresh,lineColor,.32,1)
    local weaponList=Instance.new("ScrollingFrame",weaponCard); weaponList.Size=UDim2.new(1,-20,0,103); weaponList.Position=UDim2.fromOffset(10,42); weaponList.BackgroundTransparency=1; weaponList.BorderSizePixel=0; weaponList.ScrollBarThickness=3; weaponList.ScrollBarImageColor3=hotColor
    local wgrid=Instance.new("UIGridLayout",weaponList); wgrid.CellPadding=UDim2.fromOffset(7,7); wgrid.CellSize=UDim2.new(.32,-5,0,38); wgrid.SortOrder=Enum.SortOrder.LayoutOrder
    wgrid:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() weaponList.CanvasSize=UDim2.new(0,0,0,wgrid.AbsoluteContentSize.Y+8) end)

    local skinCard=card(skinsPage,292)
    local skinsHeader=txt(skinCard,"Skins",UDim2.new(1,-24,0,22),UDim2.fromOffset(12,8),Enum.Font.GothamBold,14,textColor)
    local skinList=Instance.new("ScrollingFrame",skinCard); skinList.Size=UDim2.new(1,-20,1,-46); skinList.Position=UDim2.fromOffset(10,38); skinList.BackgroundTransparency=1; skinList.BorderSizePixel=0; skinList.ScrollBarThickness=3; skinList.ScrollBarImageColor3=hotColor
    local sgrid=Instance.new("UIGridLayout",skinList); sgrid.CellPadding=UDim2.fromOffset(7,7); sgrid.CellSize=UDim2.new(.32,-5,0,38); sgrid.SortOrder=Enum.SortOrder.LayoutOrder
    sgrid:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() skinList.CanvasSize=UDim2.new(0,0,0,sgrid.AbsoluteContentSize.Y+8) end)

    local actions=card(skinsPage,54)
    local apply=Instance.new("TextButton",actions); apply.Size=UDim2.new(.68,-14,0,34); apply.Position=UDim2.new(0,10,.5,-17); apply.BackgroundColor3=hotColor; apply.BorderSizePixel=0; apply.Text="♥  Apply Skin"; apply.TextColor3=Color3.fromRGB(250,252,255); apply.Font=Enum.Font.GothamBold; apply.TextSize=13; corner(apply,10)
    local reset=Instance.new("TextButton",actions); reset.Size=UDim2.new(.32,-14,0,34); reset.Position=UDim2.new(.68,4,.5,-17); reset.BackgroundColor3=lightColor; reset.BorderSizePixel=0; reset.Text="Reset"; reset.TextColor3=textColor; reset.Font=Enum.Font.GothamBold; reset.TextSize=12; corner(reset,10); stroke(reset,lineColor,.3,1)
    local statusCard=card(skinsPage,48)
    local skinStatus=txt(statusCard,"Searching for weapon folders...",UDim2.new(1,-24,1,0),UDim2.fromOffset(12,0),Enum.Font.Gotham,12,subColor)

    _G.KimqV26WeaponSkins=_G.KimqV26WeaponSkins or {Selected={}}
    local selectedByWeapon=_G.KimqV26WeaponSkins.Selected
    local wrapRoot=nil; local currentWeapon=nil; local selectedSkin=nil; local weaponFolders={}; local folderByName={}; local weaponButtons={}; local skinButtons={}

    local function setStatus(s,good) skinStatus.Text=s; skinStatus.TextColor3=good and hotColor or subColor end
    local function displayWeapon(n) return tostring(n or ""):gsub("%[",""):gsub("%]","") end
    local function locateWraps()
        local direct=workspace:FindFirstChild("Wraps")
        if direct then return direct end
        local recursive=workspace:FindFirstChild("Wraps",true)
        if recursive then return recursive end
        return ReplicatedStorage:FindFirstChild("Wraps",true)
    end
    local function findHandle(obj)
        if not obj then return nil end
        local h=obj:FindFirstChild("Handle")
        if h and h:IsA("BasePart") then return h end
        for _,d in ipairs(obj:GetDescendants()) do if d.Name=="Handle" and d:IsA("BasePart") then return d end end
        return nil
    end
    local function findTool(name)
        local char=lp.Character; local bp=lp:FindFirstChildOfClass("Backpack")
        return (char and char:FindFirstChild(name)) or (bp and bp:FindFirstChild(name))
    end
    local function clearVisual(tool)
        if not tool then return end
        local h=tool:FindFirstChild("Handle"); if h and h:IsA("BasePart") then pcall(function() h.LocalTransparencyModifier=0 end) end
        for _,d in ipairs(tool:GetDescendants()) do if d.Name=="KimqV26SkinVisual" then pcall(function() d:Destroy() end) end end
    end
    local function sourceHandle(w,s)
        local wf=folderByName[w]; local sf=wf and wf:FindFirstChild(s); return findHandle(sf)
    end
    local function applySkin(w,s,tool,quiet)
        local gun=tool or findTool(w)
        if not gun then if not quiet then setStatus(displayWeapon(w).." is not in your Backpack / Character",false) end return false end
        local target=gun:FindFirstChild("Handle"); local source=sourceHandle(w,s)
        if not target or not target:IsA("BasePart") or not source then if not quiet then setStatus("That skin does not have a usable Handle",false) end return false end
        clearVisual(gun)
        local visual=source:Clone(); visual.Name="KimqV26SkinVisual"; visual.Anchored=false; visual.CanCollide=false; visual.CanTouch=false; visual.CanQuery=false; visual.Massless=true
        for _,d in ipairs(visual:GetDescendants()) do
            if d:IsA("Script") or d:IsA("LocalScript") or d:IsA("ModuleScript") then d:Destroy() elseif d:IsA("BasePart") then d.Anchored=false; d.CanCollide=false; d.CanTouch=false; d.CanQuery=false; d.Massless=true end
        end
        visual.CFrame=target.CFrame; visual.Parent=gun
        local weld=Instance.new("WeldConstraint",visual); weld.Name="KimqV26SkinWeld"; weld.Part0=visual; weld.Part1=target
        pcall(function() target.LocalTransparencyModifier=1 end)
        selectedByWeapon[w]=s
        if not quiet then setStatus(displayWeapon(w).." • "..s.." applied locally",true) end
        return true
    end
    local function refreshWeaponStyle()
        for name,b in pairs(weaponButtons) do local on=name==currentWeapon; b.BackgroundColor3=on and hotColor or lightColor; b.TextColor3=on and Color3.fromRGB(250,252,255) or textColor end
    end
    local function refreshSkinStyle()
        for name,b in pairs(skinButtons) do local on=name==selectedSkin; b.BackgroundColor3=on and hotColor or lightColor; b.TextColor3=on and Color3.fromRGB(250,252,255) or textColor end
    end
    local function buildSkins()
        for _,ch in ipairs(skinList:GetChildren()) do if ch:IsA("TextButton") then ch:Destroy() end end
        table.clear(skinButtons)
        if not currentWeapon or not folderByName[currentWeapon] then skinsHeader.Text="Skins"; setStatus("Choose a weapon first",false); return end
        skinsHeader.Text="Skins • "..displayWeapon(currentWeapon)
        local skins={}
        for _,sf in ipairs(folderByName[currentWeapon]:GetChildren()) do if findHandle(sf) then table.insert(skins,sf) end end
        table.sort(skins,function(a,b) return a.Name:lower()<b.Name:lower() end)
        selectedSkin=selectedByWeapon[currentWeapon]
        for i,sf in ipairs(skins) do
            local b=Instance.new("TextButton",skinList); b.LayoutOrder=i; b.BackgroundColor3=lightColor; b.BorderSizePixel=0; b.Text=sf.Name; b.TextColor3=textColor; b.Font=Enum.Font.GothamBold; b.TextSize=11; b.AutoButtonColor=false; corner(b,10); stroke(b,lineColor,.35,1)
            b.MouseButton1Click:Connect(function() selectedSkin=sf.Name; refreshSkinStyle(); setStatus("Selected "..sf.Name.." • press Apply Skin",true) end)
            skinButtons[sf.Name]=b
        end
        refreshSkinStyle()
        if #skins==0 then setStatus("No matching skins were found inside "..currentWeapon,false) else setStatus("Found "..#skins.." skins • choose one",true) end
    end
    local function scanWeapons()
        for _,ch in ipairs(weaponList:GetChildren()) do if ch:IsA("TextButton") then ch:Destroy() end end
        table.clear(weaponButtons); table.clear(weaponFolders); table.clear(folderByName)
        wrapRoot=locateWraps()
        if not wrapRoot then setStatus("Could not find a Wraps folder • press refresh",false); return end
        for _,wf in ipairs(wrapRoot:GetChildren()) do
            if wf:IsA("Folder") or wf:IsA("Model") then table.insert(weaponFolders,wf); folderByName[wf.Name]=wf end
        end
        table.sort(weaponFolders,function(a,b) return a.Name:lower()<b.Name:lower() end)
        for i,wf in ipairs(weaponFolders) do
            local b=Instance.new("TextButton",weaponList); b.LayoutOrder=i; b.BackgroundColor3=lightColor; b.BorderSizePixel=0; b.Text=displayWeapon(wf.Name); b.TextColor3=textColor; b.Font=Enum.Font.GothamBold; b.TextSize=11; b.AutoButtonColor=false; corner(b,10); stroke(b,lineColor,.35,1)
            b.MouseButton1Click:Connect(function() currentWeapon=wf.Name; selectedSkin=selectedByWeapon[currentWeapon]; refreshWeaponStyle(); buildSkins() end)
            weaponButtons[wf.Name]=b
        end
        if #weaponFolders==0 then setStatus("Wraps was found, but it has no weapon folders",false); return end
        if not currentWeapon or not folderByName[currentWeapon] then currentWeapon=weaponFolders[1].Name end
        refreshWeaponStyle(); buildSkins()
    end
    refresh.MouseButton1Click:Connect(scanWeapons)
    apply.MouseButton1Click:Connect(function()
        if not currentWeapon then setStatus("Choose a weapon first",false) elseif not selectedSkin then setStatus("Choose a skin first",false) else applySkin(currentWeapon,selectedSkin,nil,false) end
    end)
    reset.MouseButton1Click:Connect(function()
        if currentWeapon then selectedByWeapon[currentWeapon]=nil; clearVisual(findTool(currentWeapon)); selectedSkin=nil; refreshSkinStyle(); setStatus(displayWeapon(currentWeapon).." reset",true) end
    end)

    local function hookContainer(container)
        if not container or container:GetAttribute("KimqV26SkinHook") then return end
        container:SetAttribute("KimqV26SkinHook",true)
        container.ChildAdded:Connect(function(ch)
            local s=selectedByWeapon[ch.Name]
            if s then task.delay(.12,function() applySkin(ch.Name,s,ch,true) end) end
        end)
    end
    hookContainer(lp:FindFirstChildOfClass("Backpack")); if lp.Character then hookContainer(lp.Character) end
    lp.CharacterAdded:Connect(function(char)
        hookContainer(char)
        task.delay(1,function()
            hookContainer(lp:FindFirstChildOfClass("Backpack"))
            for w,s in pairs(selectedByWeapon) do local tool=findTool(w); if tool then applySkin(w,s,tool,true) end end
        end)
    end)

    -- Page switching. Only the selected special nav changes style.
    local function resetNormalActive()
        local inactive=chooseInactiveTemplate() or inactiveTemplate
        local active=chooseActiveTemplate()
        if active and active~=envBtn and active~=skinsBtn then copyVisual(active,inactive) end
    end
    local function showSpecial(page,btn,title,desc)
        for _,p in pairs(pages) do p.Visible=(p==page) end
        specialActive=btn; resetNormalActive(); styleSpecial(envBtn,btn==envBtn); styleSpecial(skinsBtn,btn==skinsBtn)
        if pageTitle then pageTitle.Text=title end; if pageDesc then pageDesc.Text=desc end
        if page==skinsPage then scanWeapons() end
    end
    envBtn.MouseButton1Click:Connect(function() showSpecial(envPage,envBtn,"environment","seasonal map styles that keep your fog controls editable") end)
    skinsBtn.MouseButton1Click:Connect(function() showSpecial(skinsPage,skinsBtn,"weapon skins","select a weapon, choose one of its skins, then apply it locally") end)
    for _,b in ipairs(normalButtons) do
        if b and b.Parent then
            b.MouseButton1Click:Connect(function()
                envPage.Visible=false; skinsPage.Visible=false; specialActive=nil
                task.defer(function() styleSpecial(envBtn,false); styleSpecial(skinsBtn,false) end)
            end)
        end
    end

    local function syncTheme()
        panelColor,lineColor,hotColor,lightColor,textColor,subColor=sampleTheme()
        envPage.ScrollBarImageColor3=hotColor; skinsPage.ScrollBarImageColor3=hotColor; weaponList.ScrollBarImageColor3=hotColor; skinList.ScrollBarImageColor3=hotColor
        eiTitle.TextColor3=hotColor; eiSub.TextColor3=subColor; wiTitle.TextColor3=hotColor; wiSub.TextColor3=subColor
        for _,p in pairs(presetRows) do p.Row.BackgroundColor3=panelColor; local s=p.Row:FindFirstChildOfClass("UIStroke"); if s then s.Color=lineColor end end
        for _,f in ipairs({ei,es,wi,weaponCard,skinCard,actions,statusCard}) do f.BackgroundColor3=panelColor; local s=f:FindFirstChildOfClass("UIStroke"); if s then s.Color=lineColor end end
        refresh.BackgroundColor3=lightColor; refresh.TextColor3=textColor; apply.BackgroundColor3=hotColor; reset.BackgroundColor3=lightColor; reset.TextColor3=textColor
        styleSpecial(envBtn,specialActive==envBtn); styleSpecial(skinsBtn,specialActive==skinsBtn); refreshPreset(); refreshWeaponStyle(); refreshSkinStyle()
    end
    if badge then badge:GetPropertyChangedSignal("BackgroundColor3"):Connect(function() task.defer(syncTheme) end) end
    syncTheme()

    -- Do not recursively scan the game at startup. Weapon folders are scanned when the page is opened or Refresh is pressed.
    setStatus("Open Weapon Skins to scan your Wraps folder", true)

    setProgress("ready ♡",1)
    task.wait(.55)
    _G.KimqV26FeaturesReady=true
    main.Visible=true
    if loader and loader.Gui and loader.Gui.Parent then
        local bg=loader.Background
        local sticker=loader.Sticker
        if sticker then TweenService:Create(sticker,TweenInfo.new(.28,Enum.EasingStyle.Quart,Enum.EasingDirection.In),{Position=UDim2.new(.5,0,.5,8)}):Play() end
        if bg then TweenService:Create(bg,TweenInfo.new(.30,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{BackgroundTransparency=1}):Play() end
        task.wait(.31); pcall(function() loader.Gui:Destroy() end)
    end
end)




-- v2.1 final GUI: matcha + light pink + white, hearts only, no stitching.
task.spawn(function()
    local Players=game:GetService("Players")
    local CoreGui=game:GetService("CoreGui")
    local TweenService=game:GetService("TweenService")
    local lp=Players.LocalPlayer
    local pg=lp:WaitForChild("PlayerGui")

    local t0=tick()
    while not _G.KimqV26FeaturesReady and tick()-t0<45 do task.wait(.12) end
    local root=CoreGui:FindFirstChild("KimpetrasHC") or pg:FindFirstChild("KimpetrasHC")
    local main=root and root:FindFirstChild("Main")
    local loader=_G.KimqV26Loader
    if not root or not main then
        _G.KimqV26Ready=true
        if loader and loader.Gui then pcall(function() loader.Gui:Destroy() end) end
        return
    end
    root.Enabled=true
    main.Visible=false

    if main:FindFirstChild("KimqV21SingleMarker") then
        _G.KimqV26Ready=true; main.Visible=true
        if loader and loader.Gui then pcall(function() loader.Gui:Destroy() end) end
        return
    end
    local marker=Instance.new("BoolValue",main); marker.Name="KimqV21SingleMarker"

    local function norm(s)
        s=tostring(s or ""):lower()
        s=s:gsub("[♥♡✦✧◇◆♢⌂⌖⚡♧☁❄◉◎○□⚙✕♨↓◷]","")
        s=s:gsub("%s+"," ")
        return (s:gsub("^%s+",""):gsub("%s+$",""))
    end
    local function corner(o,r)
        local c=o:FindFirstChildOfClass("UICorner") or Instance.new("UICorner",o); c.CornerRadius=UDim.new(0,r or 10); return c
    end
    local function stroke(o,color,transparency,thickness)
        local s=o:FindFirstChildOfClass("UIStroke") or Instance.new("UIStroke",o); s.Color=color; s.Transparency=transparency or .3; s.Thickness=thickness or 1; return s
    end
    local function role(o,r)
        if o then o:SetAttribute("KimqV26Role",r) end
        return o
    end
    local function label(parent,text,size,pos,font,sz,color,align)
        local l=Instance.new("TextLabel",parent); l.Size=size; l.Position=pos; l.BackgroundTransparency=1; l.Text=text; l.Font=font; l.TextSize=sz; l.TextColor3=color; l.TextWrapped=true; l.TextXAlignment=align or Enum.TextXAlignment.Left; l.TextYAlignment=Enum.TextYAlignment.Center; return l
    end
    local function paw(parent,pos,size,color,rotation,z)
        -- Kept under the old helper name so legacy layout calls stay intact,
        -- but the visual motif is now a simple heart instead of a paw decal.
        local h=Instance.new("TextLabel",parent)
        h.Name="V26Heart"
        h.AnchorPoint=Vector2.new(.5,.5)
        h.Position=pos
        h.Size=UDim2.fromOffset(size,size)
        h.BackgroundTransparency=1
        h.Text="♥"
        h.TextColor3=color
        h.Font=Enum.Font.FredokaOne
        h.TextSize=math.max(12,math.floor(size*.72))
        h.Rotation=rotation or 0
        h.ZIndex=z or parent.ZIndex+2
        role(h,"hotText")
        return h
    end
    local function stitches(parent,inset,P,name)
        -- V26 single build intentionally has no stitched-border overlay.
        local old=parent:FindFirstChild(name or "V26Stitches")
        if old then old:Destroy() end
        return nil
    end

    local badge
    for _,d in ipairs(main:GetDescendants()) do if d:IsA("TextLabel") and tostring(d.Text or ""):match("^[Vv]%d") then badge=d break end end
    local function forceBadge()
        for _,d in ipairs(main:GetDescendants()) do if d:IsA("TextLabel") and tostring(d.Text or ""):match("^[Vv]%d") then d.Text="v2.1 ♡" end end
    end
    forceBadge()

    local function palette()
        local hot=badge and badge.BackgroundColor3 or Color3.fromRGB(243,161,211)
        -- Default is Matcha + Light Pink. Other themes can still drive the badge color.
        local defaultHot=Color3.fromRGB(243,161,211)
        local isDefault=math.abs(hot.R-defaultHot.R)<.04 and math.abs(hot.G-defaultHot.G)<.04 and math.abs(hot.B-defaultHot.B)<.04
        return {
            hot=hot,
            hot2=isDefault and Color3.fromRGB(255,212,243) or hot:Lerp(Color3.new(1,1,1),.42),
            light=isDefault and Color3.fromRGB(246,255,250) or hot:Lerp(Color3.new(1,1,1),.90),
            line=isDefault and Color3.fromRGB(255,212,243) or hot:Lerp(Color3.new(1,1,1),.66),
            cream=isDefault and Color3.fromRGB(217,255,232) or hot:Lerp(Color3.new(1,1,1),.93),
            cream2=isDefault and Color3.fromRGB(236,255,243) or hot:Lerp(Color3.new(1,1,1),.96),
            panel=Color3.fromRGB(255,255,255),
            text=isDefault and Color3.fromRGB(82,116,94) or hot:Lerp(Color3.fromRGB(48,48,48),.28),
            sub=isDefault and Color3.fromRGB(122,153,133) or hot:Lerp(Color3.fromRGB(88,88,88),.42),
            white=Color3.fromRGB(255,255,255),
            defaultLime=isDefault,
        }
    end
    local P=palette()

    main.BackgroundColor3=P.cream
    corner(main,24); stroke(main,P.hot,.18,2.2); role(main,"cream")
    stitches(main,12,P,"V26MainStitches")

    local shell=main:FindFirstChild("CuteBlueShell")
    if not shell then
        for _,d in ipairs(main:GetChildren()) do
            if d:IsA("Frame") and d.Size.X.Scale==1 and d.Size.Y.Scale==1 then shell=d break end
        end
    end
    if not shell then _G.KimqV26Ready=true; main.Visible=true; if loader and loader.Gui then loader.Gui:Destroy() end; return end

    -- Remove only redesign decorations from V25 if the file was accidentally layered over it.
    for _,n in ipairs({"V25TopDecor"}) do local x=shell:FindFirstChild(n,true); if x then x:Destroy() end end

    -- Find sidebar, header, profile and pages.
    local nav,pageTitle,pageDesc,pageHead,topProfile
    local pages={}
    for _,d in ipairs(shell:GetDescendants()) do
        if d:IsA("ScrollingFrame") then
            if d:FindFirstChildOfClass("UIListLayout") and d.AbsoluteSize.X<260 and d.AbsoluteSize.Y>240 then nav=d end
            if tostring(d.Name):lower():find("page",1,true) then table.insert(pages,d) end
        end
        if d:IsA("TextLabel") then
            if norm(d.Text)=="overview" and d.TextSize>=18 then pageTitle=d end
            if tostring(d.Text or ""):lower():find("your account",1,true) then pageDesc=d end
        end
        if d:IsA("Frame") and d.AbsoluteSize.X>=180 and d.AbsoluteSize.X<=290 and d.AbsoluteSize.Y>=40 and d.AbsoluteSize.Y<=70 then
            local hasImage=false; for _,c in ipairs(d:GetChildren()) do if c:IsA("ImageLabel") then hasImage=true break end end
            if hasImage and d.AbsolutePosition.Y<main.AbsolutePosition.Y+120 then topProfile=d end
        end
    end
    if pageTitle and pageTitle.Parent and pageTitle.Parent:IsA("Frame") then pageHead=pageTitle.Parent end

    -- v2.1 branding: no mascots, just clean lime/pink/white text.
    local oldMascot=shell:FindFirstChild("V26TopMascot"); if oldMascot then oldMascot:Destroy() end
    for _,d in ipairs(shell:GetDescendants()) do
        if d:IsA("TextLabel") then
            local n=norm(d.Text)
            if n=="kimqetras hc" and d.AbsolutePosition.Y<main.AbsolutePosition.Y+105 then d.Visible=false
            elseif tostring(d.Text or ""):lower():find("cute controls, clean pages",1,true) then d.Visible=false end
        elseif d:IsA("ImageLabel") and (d.Name=="V26TitleDecal" or d.Name=="V26SubtitleDecal" or d.Name=="V26Mascot") then
            d:Destroy()
        end
    end
    local brandTitle=label(shell,"Kimqetras HC",UDim2.fromOffset(280,38),UDim2.fromOffset(24,8),Enum.Font.FredokaOne,29,P.hot); brandTitle.ZIndex=24; role(brandTitle,"hotText")
    local brandSub=label(shell,"silent hc  ♡",UDim2.fromOffset(200,24),UDim2.fromOffset(28,45),Enum.Font.FredokaOne,16,Color3.fromRGB(82,116,94)); brandSub.ZIndex=24; role(brandSub,"limeText")

    if topProfile then
        topProfile.BackgroundColor3=P.panel; topProfile.BackgroundTransparency=0; corner(topProfile,15); stroke(topProfile,P.line,.35,1); role(topProfile,"panel")
    end

    -- Sidebar becomes a stitched cream section.
    local navButtons={}
    if nav then
        nav.BackgroundColor3=P.cream2; nav.BackgroundTransparency=0; nav.BorderSizePixel=0; nav.ScrollBarImageColor3=P.hot; corner(nav,18); stroke(nav,P.line,.32,1); role(nav,"cream2")
        local parent=nav.Parent
        if parent and parent:IsA("Frame") then parent.BackgroundColor3=P.cream2; parent.BorderSizePixel=0; corner(parent,18); stroke(parent,P.line,.30,1); role(parent,"cream2"); stitches(parent,8,P,"V26SidebarStitches") end
        for _,d in ipairs(nav:GetChildren()) do
            if d:IsA("TextButton") then table.insert(navButtons,d) end
        end
    end
    -- Sidebar heading and paw header.
    if shell then
        for _,d in ipairs(shell:GetDescendants()) do
            if d:IsA("TextLabel") and norm(d.Text)=="features" then
                d.Text="FEATURES"; d.Font=Enum.Font.FredokaOne; d.TextSize=16; role(d,"hotText")
                if not d.Parent:FindFirstChild("V26FeaturePawL") then
                    local p1=paw(d.Parent,UDim2.new(0,24,.5,0),21,P.hot,-10,d.ZIndex+1); p1.Name="V26FeaturePawL"
                end
            end
        end
    end

    local function colorDistance(a,b)
        return math.abs(a.R-b.R)+math.abs(a.G-b.G)+math.abs(a.B-b.B)
    end
    local function styleNav()
        for _,b in ipairs(navButtons) do
            local selected=(colorDistance(b.BackgroundColor3,P.hot)<.28) or (b.TextColor3.R>.83 and b.TextColor3.G>.83 and b.TextColor3.B>.83)
            b.BackgroundColor3=selected and P.hot or P.panel
            b.TextColor3=selected and P.white or P.text
            b.Font=Enum.Font.FredokaOne; b.TextSize=13; b.TextXAlignment=Enum.TextXAlignment.Left; b.AutoButtonColor=false; corner(b,11); stroke(b,selected and P.hot or P.line,selected and .05 or .45,1)
            local pad=b:FindFirstChildOfClass("UIPadding") or Instance.new("UIPadding",b); pad.PaddingLeft=UDim.new(0,28); pad.PaddingRight=UDim.new(0,8)
        end
    end
    styleNav()
    for _,b in ipairs(navButtons) do
        b.MouseButton1Click:Connect(function() task.delay(.03,styleNav) end)
    end

    -- Page header: paw print + stitched divider, like the reference section headers.
    if pageHead then
        pageHead.BackgroundColor3=P.panel; pageHead.BorderSizePixel=0; corner(pageHead,15); stroke(pageHead,P.line,.35,1); role(pageHead,"panel")
        if not pageHead:FindFirstChild("V26HeaderPaw") then local p=paw(pageHead,UDim2.new(0,24,.35,0),24,P.hot,-9,pageHead.ZIndex+3); p.Name="V26HeaderPaw" end
        if pageTitle then pageTitle.Font=Enum.Font.FredokaOne; pageTitle.TextSize=22; pageTitle.Position=UDim2.new(pageTitle.Position.X.Scale,pageTitle.Position.X.Offset+24,pageTitle.Position.Y.Scale,pageTitle.Position.Y.Offset); role(pageTitle,"hotText") end
        if pageDesc then pageDesc.Font=Enum.Font.GothamSemibold; pageDesc.TextSize=12; role(pageDesc,"subText") end
    end

    -- Style direct card/row content across every feature page, while leaving actual rainbow picker visuals untouched.
    local function stylePage(page)
        page.BackgroundColor3=P.cream; page.BackgroundTransparency=0; page.BorderSizePixel=0; page.ScrollBarImageColor3=P.hot; role(page,"cream")
        local list=page:FindFirstChildOfClass("UIListLayout"); if list then list.Padding=UDim.new(0,9) end
        for _,ch in ipairs(page:GetChildren()) do
            if ch:IsA("Frame") then
                ch.BackgroundColor3=P.panel; ch.BackgroundTransparency=0; ch.BorderSizePixel=0; corner(ch,11); stroke(ch,P.line,.40,1); role(ch,"panel")
                for _,d in ipairs(ch:GetDescendants()) do
                    if d:IsA("TextLabel") then
                        d.TextColor3=P.text
                        if d.TextSize<=11 then d.TextSize=12 end
                        if d.TextSize>=18 then d.Font=Enum.Font.FredokaOne; d.TextColor3=P.hot else d.Font=Enum.Font.GothamSemibold end
                        d.TextWrapped=true
                    elseif d:IsA("TextButton") then
                        d.Font=Enum.Font.FredokaOne; if d.TextSize<12 then d.TextSize=12 end; d.AutoButtonColor=false
                        -- preserve selected/highlighted buttons; otherwise use cream panel look.
                        local on=colorDistance(d.BackgroundColor3,P.hot)<.32 or (d.TextColor3.R>.85 and d.TextColor3.G>.85 and d.TextColor3.B>.85 and d.BackgroundTransparency<.5)
                        d.BackgroundColor3=on and P.hot or P.light; d.TextColor3=on and P.white or P.text; corner(d,9); stroke(d,on and P.hot or P.line,on and .05 or .48,1)
                    elseif d:IsA("TextBox") then
                        d.Font=Enum.Font.GothamSemibold; if d.TextSize<12 then d.TextSize=12 end; d.BackgroundColor3=P.light; d.TextColor3=P.text; d.PlaceholderColor3=P.sub; corner(d,8); stroke(d,P.line,.45,1)
                    elseif d:IsA("ScrollingFrame") then
                        d.ScrollBarImageColor3=P.hot
                    end
                end
            end
        end
    end
    for _,p in ipairs(pages) do pcall(function() stylePage(p) end) end

    -- Rebuild Overview cleanly with the banner the user liked, now using the stitched/paw style.
    local overview=shell:FindFirstChild("overviewPage",true)
    if overview and overview:IsA("ScrollingFrame") then
        for _,ch in ipairs(overview:GetChildren()) do if not ch:IsA("UIListLayout") and not ch:IsA("UIPadding") then ch:Destroy() end end
        local list=overview:FindFirstChildOfClass("UIListLayout") or Instance.new("UIListLayout",overview); list.Padding=UDim.new(0,10); list.SortOrder=Enum.SortOrder.LayoutOrder
        local pad=overview:FindFirstChildOfClass("UIPadding") or Instance.new("UIPadding",overview); pad.PaddingTop=UDim.new(0,8); pad.PaddingBottom=UDim.new(0,8); pad.PaddingLeft=UDim.new(0,4); pad.PaddingRight=UDim.new(0,4)
        list:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() overview.CanvasSize=UDim2.new(0,0,0,list.AbsoluteContentSize.Y+18) end)

        local function card(h,name)
            local f=Instance.new("Frame",overview); f.Name=name; f.Size=UDim2.new(1,-8,0,h); f.BackgroundColor3=P.panel; f.BorderSizePixel=0; corner(f,12); stroke(f,P.line,.35,1); role(f,"panel"); return f
        end
        local hero=card(138,"V26BannerCard")
        local banner=Instance.new("Frame",hero); banner.Size=UDim2.new(1,-18,1,-18); banner.Position=UDim2.fromOffset(9,9); banner.BackgroundColor3=P.hot; banner.BorderSizePixel=0; corner(banner,12); role(banner,"hotBg")
        local grad=Instance.new("UIGradient",banner); grad.Name="V26BannerGradient"; grad.Color=ColorSequence.new({ColorSequenceKeypoint.new(0,P.hot2),ColorSequenceKeypoint.new(.52,P.hot),ColorSequenceKeypoint.new(1,P.hot:Lerp(Color3.new(1,1,1),.16))}); grad.Rotation=8
        for _,d in ipairs({{.03,.80,94,.10},{.11,.70,70,.16},{.91,.80,98,.10},{.82,.68,72,.16}}) do local c=Instance.new("Frame",banner); c.AnchorPoint=Vector2.new(.5,.5); c.Position=UDim2.new(d[1],0,d[2],0); c.Size=UDim2.fromOffset(d[3],d[3]); c.BackgroundColor3=P.white; c.BackgroundTransparency=d[4]; c.BorderSizePixel=0; corner(c,999); role(c,"whiteBg") end
        local bt=label(banner,"Kimqetras HC",UDim2.new(1,-30,0,48),UDim2.new(0,15,.5,-33),Enum.Font.FredokaOne,35,P.white,Enum.TextXAlignment.Center); role(bt,"whiteText")
        local bs=label(banner,"made with love for you ♡",UDim2.new(1,-30,0,22),UDim2.new(0,15,.5,15),Enum.Font.GothamBold,12,P.white,Enum.TextXAlignment.Center); role(bs,"whiteText")

        local welcome=card(144,"V26Welcome")
        local av=Instance.new("ImageLabel",welcome); av.Size=UDim2.fromOffset(78,78); av.Position=UDim2.fromOffset(18,38); av.BackgroundColor3=P.light; av.BorderSizePixel=0; corner(av,999); stroke(av,P.line,.35,1); role(av,"lightBg"); pcall(function() av.Image=Players:GetUserThumbnailAsync(lp.UserId,Enum.ThumbnailType.HeadShot,Enum.ThumbnailSize.Size180x180) end)
        local wt=label(welcome,"welcome, "..lp.DisplayName:lower().." ♡",UDim2.new(1,-215,0,34),UDim2.fromOffset(112,24),Enum.Font.FredokaOne,25,P.hot); role(wt,"hotText")
        local wu=label(welcome,"@"..lp.Name.."  •  Kimqetras HC",UDim2.new(1,-215,0,20),UDim2.fromOffset(112,57),Enum.Font.GothamSemibold,11,P.sub); role(wu,"subText")
        local l1=label(welcome,"Everything is separated into its own feature page.",UDim2.new(1,-215,0,20),UDim2.fromOffset(112,82),Enum.Font.GothamSemibold,12,P.text); role(l1,"textText")
        local l2=label(welcome,"Pick a tool on the left, or press F1 to hide / reopen the GUI.",UDim2.new(1,-215,0,20),UDim2.fromOffset(112,104),Enum.Font.GothamSemibold,12,P.text); role(l2,"textText")
        local wh=label(welcome,"♡",UDim2.fromOffset(48,48),UDim2.new(1,-64,.5,-24),Enum.Font.FredokaOne,34,P.hot,Enum.TextXAlignment.Center); role(wh,"hotText")

        local about=card(126,"V26About")
        local at=label(about,"about",UDim2.new(1,-100,0,28),UDim2.fromOffset(18,8),Enum.Font.FredokaOne,21,P.hot); role(at,"hotText")
        local div=label(about,"",UDim2.new(1,-110,0,16),UDim2.fromOffset(18,34),Enum.Font.GothamBold,11,P.line); role(div,"lineText")
        local a1=label(about,"Every feature has its own clean page.",UDim2.new(1,-110,0,18),UDim2.fromOffset(18,57),Enum.Font.GothamSemibold,12,P.text); role(a1,"textText")
        local a2=label(about,"Switch between aiming, movement, visuals, avatar tools, and utilities.",UDim2.new(1,-110,0,18),UDim2.fromOffset(18,78),Enum.Font.GothamSemibold,12,P.text); role(a2,"textText")
        local a3=label(about,"Pick a theme whenever you want the interface to match your style.",UDim2.new(1,-110,0,18),UDim2.fromOffset(18,99),Enum.Font.GothamSemibold,12,P.text); role(a3,"textText")

        local controls=card(82,"V26Controls")
        local ct=label(controls,"controls",UDim2.new(0,160,0,28),UDim2.fromOffset(18,9),Enum.Font.FredokaOne,20,P.hot); role(ct,"hotText")
        local cd=label(controls,"F1 = hide / show the GUI",UDim2.new(1,-80,0,24),UDim2.fromOffset(18,43),Enum.Font.GothamSemibold,12,P.text); role(cd,"textText")
    end


    -- Remove all V26 stitch decorations; keep the rounded borders/cards from the original V26.
    for _,d in ipairs(main:GetDescendants()) do
        if tostring(d.Name):find("Stitch",1,true) then
            pcall(function() d:Destroy() end)
        end
    end

    local syncing=false
    local function sync()
        -- The final v2.1 theme pass owns colors after startup. Without this guard,
        -- this legacy badge listener repaints parts of the GUI and leaves old colors behind.
        if _G.KimqV21FullThemeActive then return end
        if syncing then return end; syncing=true
        P=palette(); forceBadge()
        main.BackgroundColor3=P.cream; local ms=main:FindFirstChildOfClass("UIStroke"); if ms then ms.Color=P.hot end
        for _,d in ipairs(main:GetDescendants()) do
            local r=d:GetAttribute("KimqV26Role")
            if r then
                if d:IsA("Frame") or d:IsA("TextButton") or d:IsA("TextBox") or d:IsA("ImageLabel") then
                    if r=="cream" then d.BackgroundColor3=P.cream elseif r=="cream2" then d.BackgroundColor3=P.cream2 elseif r=="panel" then d.BackgroundColor3=P.panel elseif r=="lightBg" then d.BackgroundColor3=P.light elseif r=="hotBg" then d.BackgroundColor3=P.hot elseif r=="whiteBg" then d.BackgroundColor3=P.white end
                end
                if d:IsA("TextLabel") or d:IsA("TextButton") or d:IsA("TextBox") then
                    if r=="hotText" then d.TextColor3=P.hot elseif r=="subText" then d.TextColor3=P.sub elseif r=="textText" then d.TextColor3=P.text elseif r=="lineText" then d.TextColor3=P.line elseif r=="whiteText" then d.TextColor3=P.white elseif r=="limeText" then d.TextColor3=(P.defaultLime and Color3.fromRGB(82,116,94) or P.hot2) end
                end
                if r=="stitch" and d:IsA("Frame") then d.Visible=false end
                if (r=="pawImage") and d:IsA("ImageLabel") then
                    local isBlueTheme=(P.hot.B>P.hot.R and P.hot.B>P.hot.G)
                    d.ImageColor3=isBlueTheme and Color3.new(1,1,1) or P.hot:Lerp(Color3.new(1,1,1),.18)
                end
                local s=d:FindFirstChildOfClass("UIStroke"); if s and r~="hotBg" then s.Color=P.line end
            end
            if d:IsA("UIGradient") and d.Name=="V26BannerGradient" then d.Color=ColorSequence.new({ColorSequenceKeypoint.new(0,P.hot2),ColorSequenceKeypoint.new(.52,P.hot),ColorSequenceKeypoint.new(1,P.hot:Lerp(Color3.new(1,1,1),.16))}) end
        end
        for _,p in ipairs(main:GetDescendants()) do
            if p.Name=="V26Paw" and p:IsA("ImageLabel") then
                local isBlueTheme=(P.hot.B>P.hot.R and P.hot.B>P.hot.G)
                p.ImageColor3=isBlueTheme and Color3.new(1,1,1) or P.hot:Lerp(Color3.new(1,1,1),.18)
            end
        end
        if nav then nav.ScrollBarImageColor3=P.hot end
        for _,p in ipairs(pages) do p.ScrollBarImageColor3=P.hot end
        styleNav()
        syncing=false
    end
    if badge then badge:GetPropertyChangedSignal("BackgroundColor3"):Connect(function() task.delay(.05,sync) end) end
    sync(); task.delay(.35,sync); task.delay(.9,sync)

    _G.KimqV26Ready=true
    main.Visible=true; root.Enabled=true; forceBadge()
    if loader and loader.Gui and loader.Gui.Parent then
        if loader.Status then loader.Status.Text="ready ♡" end
        if loader.Percent then loader.Percent.Text="100%" end
        if loader.Bar then TweenService:Create(loader.Bar,TweenInfo.new(.30,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{Size=UDim2.new(1,0,1,0)}):Play() end
        task.wait(.42)
        local c=loader.Card; local b=loader.Background
        if c then TweenService:Create(c,TweenInfo.new(.28,Enum.EasingStyle.Quart,Enum.EasingDirection.In),{Position=UDim2.new(.5,0,.5,8),BackgroundTransparency=1}):Play() end
        if b then TweenService:Create(b,TweenInfo.new(.31,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{BackgroundTransparency=1}):Play() end
        task.wait(.33); pcall(function() loader.Gui:Destroy() end)
    end
end)


-- ========================================================
-- v2.1 MATCHA + PINK FINAL THEME PASS (single lightweight pass)
-- Matcha #D9FFE8 + Light Pink #FFD4F3 + White
-- No paw decals, no stacked property listeners, no repeated rebuilds.
-- ========================================================
task.spawn(function()
    local Players=game:GetService("Players")
    local CoreGui=game:GetService("CoreGui")
    local lp=Players.LocalPlayer
    local pg=lp:WaitForChild("PlayerGui")

    local t0=tick()
    while not _G.KimqV26Ready and tick()-t0<25 do task.wait(.08) end
    local root=CoreGui:FindFirstChild("KimpetrasHC") or pg:FindFirstChild("KimpetrasHC")
    local main=root and root:FindFirstChild("Main")
    if not main then return end
    local shell=main:FindFirstChild("CuteBlueShell") or main:FindFirstChildWhichIsA("Frame")
    if not shell then return end

    local THEMES={
        ["Matcha Pink"]={hot=Color3.fromRGB(243,161,211),hot2=Color3.fromRGB(255,212,243),bg=Color3.fromRGB(217,255,232),bg2=Color3.fromRGB(236,255,243),panel=Color3.fromRGB(255,255,255),soft=Color3.fromRGB(246,255,250),text=Color3.fromRGB(82,116,94),sub=Color3.fromRGB(122,153,133),line=Color3.fromRGB(255,212,243),white=Color3.new(1,1,1)},
        ["Lavender Blue"]={hot=Color3.fromRGB(132,151,239),hot2=Color3.fromRGB(220,225,255),bg=Color3.fromRGB(244,241,255),bg2=Color3.fromRGB(249,247,255),panel=Color3.new(1,1,1),soft=Color3.fromRGB(252,250,255),text=Color3.fromRGB(91,91,133),sub=Color3.fromRGB(132,130,169),line=Color3.fromRGB(216,211,244),white=Color3.new(1,1,1)},
        ["Baby Blue"]={hot=Color3.fromRGB(111,181,241),hot2=Color3.fromRGB(215,237,255),bg=Color3.fromRGB(238,248,255),bg2=Color3.fromRGB(247,252,255),panel=Color3.new(1,1,1),soft=Color3.fromRGB(250,253,255),text=Color3.fromRGB(72,112,146),sub=Color3.fromRGB(114,150,180),line=Color3.fromRGB(202,228,248),white=Color3.new(1,1,1)},
        ["Sky Lilac"]={hot=Color3.fromRGB(150,139,235),hot2=Color3.fromRGB(219,223,255),bg=Color3.fromRGB(239,247,255),bg2=Color3.fromRGB(248,250,255),panel=Color3.new(1,1,1),soft=Color3.fromRGB(251,252,255),text=Color3.fromRGB(91,91,137),sub=Color3.fromRGB(131,131,174),line=Color3.fromRGB(211,217,246),white=Color3.new(1,1,1)},
        ["Lilac Pink"]={hot=Color3.fromRGB(205,137,224),hot2=Color3.fromRGB(243,214,248),bg=Color3.fromRGB(252,241,255),bg2=Color3.fromRGB(255,248,255),panel=Color3.new(1,1,1),soft=Color3.fromRGB(255,251,255),text=Color3.fromRGB(126,84,137),sub=Color3.fromRGB(164,125,173),line=Color3.fromRGB(238,208,242),white=Color3.new(1,1,1)},
        ["Rose Cream"]={hot=Color3.fromRGB(225,142,166),hot2=Color3.fromRGB(251,217,227),bg=Color3.fromRGB(255,246,243),bg2=Color3.fromRGB(255,251,249),panel=Color3.new(1,1,1),soft=Color3.fromRGB(255,252,251),text=Color3.fromRGB(132,91,96),sub=Color3.fromRGB(171,128,133),line=Color3.fromRGB(244,211,216),white=Color3.new(1,1,1)},
        ["Peach Cream"]={hot=Color3.fromRGB(238,164,133),hot2=Color3.fromRGB(255,224,207),bg=Color3.fromRGB(255,245,235),bg2=Color3.fromRGB(255,250,245),panel=Color3.new(1,1,1),soft=Color3.fromRGB(255,252,248),text=Color3.fromRGB(132,96,80),sub=Color3.fromRGB(174,135,117),line=Color3.fromRGB(247,216,201),white=Color3.new(1,1,1)},
        ["Butter Pink"]={hot=Color3.fromRGB(238,153,192),hot2=Color3.fromRGB(255,219,235),bg=Color3.fromRGB(255,251,221),bg2=Color3.fromRGB(255,253,239),panel=Color3.new(1,1,1),soft=Color3.fromRGB(255,254,247),text=Color3.fromRGB(125,112,78),sub=Color3.fromRGB(166,149,111),line=Color3.fromRGB(246,221,224),white=Color3.new(1,1,1)},
        ["Mint Aqua"]={hot=Color3.fromRGB(96,193,183),hot2=Color3.fromRGB(205,242,236),bg=Color3.fromRGB(232,252,245),bg2=Color3.fromRGB(246,255,251),panel=Color3.new(1,1,1),soft=Color3.fromRGB(250,255,253),text=Color3.fromRGB(68,123,117),sub=Color3.fromRGB(109,159,153),line=Color3.fromRGB(194,233,226),white=Color3.new(1,1,1)},
        ["Grey Pink"]={hot=Color3.fromRGB(232,145,188),hot2=Color3.fromRGB(255,218,238),bg=Color3.fromRGB(244,245,249),bg2=Color3.fromRGB(249,250,252),panel=Color3.new(1,1,1),soft=Color3.fromRGB(252,252,254),text=Color3.fromRGB(92,92,105),sub=Color3.fromRGB(136,135,149),line=Color3.fromRGB(228,214,226),white=Color3.new(1,1,1)},
        ["Black Pink"]={hot=Color3.fromRGB(242,151,197),hot2=Color3.fromRGB(255,205,230),bg=Color3.fromRGB(28,29,34),bg2=Color3.fromRGB(37,38,45),panel=Color3.fromRGB(47,48,57),soft=Color3.fromRGB(56,57,67),text=Color3.fromRGB(255,221,238),sub=Color3.fromRGB(218,185,202),line=Color3.fromRGB(233,150,192),white=Color3.fromRGB(255,248,252)},
        Purple={hot=Color3.fromRGB(169,116,235),hot2=Color3.fromRGB(229,210,251),bg=Color3.fromRGB(246,239,255),bg2=Color3.fromRGB(251,247,255),panel=Color3.new(1,1,1),soft=Color3.fromRGB(252,249,255),text=Color3.fromRGB(102,77,126),sub=Color3.fromRGB(143,119,164),line=Color3.fromRGB(226,208,244),white=Color3.new(1,1,1)},
        Red={hot=Color3.fromRGB(236,111,132),hot2=Color3.fromRGB(255,205,215),bg=Color3.fromRGB(255,239,243),bg2=Color3.fromRGB(255,248,250),panel=Color3.new(1,1,1),soft=Color3.fromRGB(255,250,251),text=Color3.fromRGB(139,77,87),sub=Color3.fromRGB(174,116,126),line=Color3.fromRGB(247,202,210),white=Color3.new(1,1,1)},
        Pink={hot=Color3.fromRGB(238,131,190),hot2=Color3.fromRGB(255,212,243),bg=Color3.fromRGB(255,241,250),bg2=Color3.fromRGB(255,248,253),panel=Color3.new(1,1,1),soft=Color3.fromRGB(255,251,254),text=Color3.fromRGB(146,84,116),sub=Color3.fromRGB(181,125,153),line=Color3.fromRGB(248,208,232),white=Color3.new(1,1,1)},
        Aqua={hot=Color3.fromRGB(84,190,211),hot2=Color3.fromRGB(199,239,247),bg=Color3.fromRGB(233,251,254),bg2=Color3.fromRGB(245,254,255),panel=Color3.new(1,1,1),soft=Color3.fromRGB(249,254,255),text=Color3.fromRGB(67,120,131),sub=Color3.fromRGB(110,155,165),line=Color3.fromRGB(191,229,237),white=Color3.new(1,1,1)},
        Green={hot=Color3.fromRGB(100,185,135),hot2=Color3.fromRGB(205,240,219),bg=Color3.fromRGB(235,252,242),bg2=Color3.fromRGB(246,254,249),panel=Color3.new(1,1,1),soft=Color3.fromRGB(250,255,252),text=Color3.fromRGB(72,122,91),sub=Color3.fromRGB(112,158,129),line=Color3.fromRGB(198,232,211),white=Color3.new(1,1,1)},
    }
    local currentName="Matcha Pink"
    local current=THEMES[currentName]
    _G.KimqCuteTheme=currentName

    local function corner(o,r)
        local c=o:FindFirstChildOfClass("UICorner") or Instance.new("UICorner",o); c.CornerRadius=UDim.new(0,r or 11); return c
    end
    local function outline(o,c,tr,th)
        local s=o:FindFirstChildOfClass("UIStroke") or Instance.new("UIStroke",o); s.Color=c; s.Transparency=tr or .35; s.Thickness=th or 1; return s
    end
    local function clean(s)
        s=tostring(s or ""):lower():gsub("[♥♡❤]",""):gsub("%s+"," ")
        return (s:gsub("^%s+",""):gsub("%s+$",""))
    end
    local function isColorSurface(o)
        local p=o
        while p and p~=main do
            local n=tostring(p.Name):lower()
            if n:find("picker",1,true) or n:find("rainbow",1,true) or n:find("saturation",1,true) or n:find("hue",1,true) or n:find("espcolor",1,true) then return true end
            p=p.Parent
        end
        return false
    end

    -- Remove all residual paws/decor images and old stitches once, not on every click.
    -- Also remove Roblox's default 1px GuiObject borders. Those default borders were the
    -- thin black rectangle showing around several feature pages. UIStroke handles the cute borders.
    main.BorderSizePixel=0
    for _,d in ipairs(main:GetDescendants()) do
        local n=tostring(d.Name):lower()
        if d:IsA("GuiObject") then d.BorderSizePixel=0 end
        if (d:IsA("ImageLabel") or d:IsA("ImageButton")) and n:find("paw",1,true) then pcall(function() d:Destroy() end) end
        if n:find("stitch",1,true) then pcall(function() d:Destroy() end) end
    end

    local nav,themePage,badge,pageHead
    for _,d in ipairs(shell:GetDescendants()) do
        if d:IsA("ScrollingFrame") then
            if d.Name=="themePage" then themePage=d end
            if d:FindFirstChildOfClass("UIListLayout") and d.AbsoluteSize.X<270 and d.AbsoluteSize.Y>230 then nav=d end
        elseif d:IsA("TextLabel") and tostring(d.Text):lower():match("^v2%.1") then badge=d end
    end
    themePage=themePage or shell:FindFirstChild("themePage",true)

    -- Lightweight registry: use existing v2.1 role attributes only. No property-change listeners.
    local roleObjects={}
    for _,d in ipairs(main:GetDescendants()) do
        local r=d:GetAttribute("KimqV26Role")
        if r then table.insert(roleObjects,{d=d,r=r}) end
    end

    local function styleToggle(btn,p)
        if not btn:IsA("TextButton") or btn.Text~="" then return end
        local knob=btn:FindFirstChildWhichIsA("Frame")
        if not knob then return end
        local w=btn.AbsoluteSize.X; local h=btn.AbsoluteSize.Y
        if w<30 or w>80 or h<15 or h>35 then return end
        local on=(knob.Position.X.Scale>.45) or (knob.Position.X.Offset>8)
        btn.BackgroundColor3=on and p.hot or p.hot2
        knob.BackgroundColor3=p.white
        corner(btn,999); corner(knob,999)
    end

    local function styleNav(p)
        if not nav then return end
        nav.BackgroundColor3=p.bg2; nav.BackgroundTransparency=0; nav.ScrollBarImageColor3=p.hot
        if nav.Parent and nav.Parent:IsA("Frame") then nav.Parent.BackgroundColor3=p.bg2; outline(nav.Parent,p.line,.28,1) end
        for _,b in ipairs(nav:GetChildren()) do
            if b:IsA("TextButton") then
                local selected=b:GetAttribute("KimqSelected") == true or (b.TextColor3.R>.85 and b.TextColor3.G>.85 and b.TextColor3.B>.85 and b.BackgroundTransparency<.5)
                b.BackgroundColor3=selected and p.hot or p.panel
                b.TextColor3=selected and p.white or p.text
                b.Font=Enum.Font.FredokaOne; b.TextSize=13; b.AutoButtonColor=false
                corner(b,11); outline(b,selected and p.hot or p.line,selected and .05 or .58,1)
                if not b:GetAttribute("KimqThemeNavHook") then
                    b:SetAttribute("KimqThemeNavHook",true)
                    b.MouseButton1Click:Connect(function()
                        for _,x in ipairs(nav:GetChildren()) do if x:IsA("TextButton") then x:SetAttribute("KimqSelected",x==b) end end
                        task.defer(function() styleNav(current) end)
                    end)
                end
            end
        end
        for _,d in ipairs(nav.Parent and nav.Parent:GetChildren() or {}) do
            if d:IsA("TextLabel") and clean(d.Text)=="features" then d.Text="♥  FEATURES  ♥"; d.TextColor3=p.hot; d.Font=Enum.Font.FredokaOne; d.TextSize=18 end
        end
    end

    local function colorDistance(a,b)
        local dr=a.R-b.R; local dg=a.G-b.G; local db=a.B-b.B
        return math.sqrt(dr*dr+dg*dg+db*db)
    end

    local paletteRoles={"bg","bg2","panel","soft","hot","hot2","line","text","sub","white"}
    local function nearestThemeRole(c)
        local bestRole,bestDist=nil,0.105
        for _,tp in pairs(THEMES) do
            for _,r in ipairs(paletteRoles) do
                local v=tp[r]
                if v then
                    local dd=colorDistance(c,v)
                    if dd<bestDist then bestDist=dd; bestRole=r end
                end
            end
        end
        return bestRole
    end

    local function inThemePreview(o)
        local x=o
        while x and x~=themePage do
            if x.Name=="ThemeChoiceClean" then return true end
            x=x.Parent
        end
        return x and x.Name=="ThemeChoiceClean" or false
    end

    local function mapSurfaceColor(obj,p)
        if not obj or isColorSurface(obj) or obj:GetAttribute("KimqPreserveColor") then return end
        local role=nearestThemeRole(obj.BackgroundColor3)
        if role=="bg" then obj.BackgroundColor3=p.bg
        elseif role=="bg2" then obj.BackgroundColor3=p.bg2
        elseif role=="panel" or role=="white" then obj.BackgroundColor3=p.panel
        elseif role=="soft" then obj.BackgroundColor3=p.soft
        elseif role=="hot" then obj.BackgroundColor3=p.hot
        elseif role=="hot2" or role=="line" then obj.BackgroundColor3=p.hot2 end
    end

    local function applyVisuals(p)
        local previous=current
        current=p
        _G.KimqV21FullThemeActive=true

        -- Main shell and every page background are always repainted explicitly.
        -- This fixes the Matcha/green strips that used to remain behind Aqua/Purple/etc.
        main.BackgroundColor3=p.bg
        local ms=main:FindFirstChildOfClass("UIStroke"); if ms then ms.Color=p.line end
        local pageHost=themePage and themePage.Parent
        if pageHost and pageHost:IsA("Frame") then
            pageHost.BackgroundColor3=p.bg
            pageHost.BackgroundTransparency=0
        end

        for _,d in ipairs(shell:GetDescendants()) do
            if d:IsA("GuiObject") then d.BorderSizePixel=0 end
            if d:IsA("ScrollingFrame") and d.Name:match("Page$") then
                d.BackgroundColor3=p.bg
                d.BackgroundTransparency=0
                d.ScrollBarImageColor3=p.hot
            end
        end
        if themePage then
            themePage.BackgroundColor3=p.bg
            themePage.BackgroundTransparency=0
            themePage.ScrollBarImageColor3=p.hot
        end

        -- First repaint all objects that were deliberately tagged by the v2.1 shell.
        for _,entry in ipairs(roleObjects) do
            local d,r=entry.d,entry.r
            if d and d.Parent then
                if d:IsA("Frame") or d:IsA("ScrollingFrame") or d:IsA("TextButton") or d:IsA("TextBox") then
                    if r=="cream" then d.BackgroundColor3=p.bg
                    elseif r=="cream2" then d.BackgroundColor3=p.bg2
                    elseif r=="panel" then d.BackgroundColor3=p.panel
                    elseif r=="lightBg" then d.BackgroundColor3=p.soft
                    elseif r=="hotBg" then d.BackgroundColor3=p.hot
                    elseif r=="whiteBg" then d.BackgroundColor3=p.white end
                end
                if d:IsA("TextLabel") or d:IsA("TextButton") or d:IsA("TextBox") then
                    if r=="hotText" then d.TextColor3=p.hot
                    elseif r=="subText" then d.TextColor3=p.sub
                    elseif r=="textText" or r=="limeText" then d.TextColor3=p.text
                    elseif r=="lineText" then d.TextColor3=p.line
                    elseif r=="whiteText" then d.TextColor3=p.white end
                end
                local st=d:FindFirstChildOfClass("UIStroke"); if st and r~="hotBg" then st.Color=p.line end
            end
        end

        -- Then catch legacy surfaces that were created before role tagging. We map them by
        -- whichever theme color they currently resemble, so switching repeatedly still works.
        for _,d in ipairs(main:GetDescendants()) do
            if not isColorSurface(d) and not inThemePreview(d) then
                if d:IsA("ScrollingFrame") then
                    d.ScrollBarImageColor3=p.hot
                    if d~=nav and d.BackgroundTransparency<.98 then mapSurfaceColor(d,p) end
                elseif d:IsA("Frame") then
                    if d.BackgroundTransparency<.98 then mapSurfaceColor(d,p) end
                elseif d:IsA("TextButton") then
                    local knob=d:FindFirstChildWhichIsA("Frame")
                    if knob and d.Text=="" then
                        styleToggle(d,p)
                    elseif d.BackgroundTransparency<.98 then
                        mapSurfaceColor(d,p)
                    end
                    local rr=nearestThemeRole(d.TextColor3)
                    if rr=="hot" or rr=="hot2" then d.TextColor3=p.hot
                    elseif rr=="text" then d.TextColor3=p.text
                    elseif rr=="sub" then d.TextColor3=p.sub
                    elseif rr=="white" then d.TextColor3=p.white end
                elseif d:IsA("TextBox") then
                    d.BackgroundColor3=p.soft
                    d.TextColor3=p.text
                    d.PlaceholderColor3=p.sub
                    local st=d:FindFirstChildOfClass("UIStroke"); if st then st.Color=p.line end
                elseif d:IsA("TextLabel") then
                    local rr=nearestThemeRole(d.TextColor3)
                    if rr=="hot" or rr=="hot2" then d.TextColor3=p.hot
                    elseif rr=="text" then d.TextColor3=p.text
                    elseif rr=="sub" then d.TextColor3=p.sub
                    elseif rr=="line" then d.TextColor3=p.line
                    elseif rr=="white" then d.TextColor3=p.white end
                elseif d:IsA("UIStroke") then
                    local rr=nearestThemeRole(d.Color)
                    if rr=="hot" then d.Color=p.hot
                    elseif rr=="hot2" or rr=="line" then d.Color=p.line
                    elseif rr=="text" then d.Color=p.text
                    elseif rr=="sub" then d.Color=p.sub end
                elseif d:IsA("UIGradient") then
                    local par=d.Parent
                    if par and not isColorSurface(par) and par:GetAttribute("KimqV26Role")=="hotBg" then
                        d.Color=ColorSequence.new({
                            ColorSequenceKeypoint.new(0,p.hot2),
                            ColorSequenceKeypoint.new(.52,p.hot),
                            ColorSequenceKeypoint.new(1,p.hot:Lerp(p.white,.18))
                        })
                    end
                end
            end
        end

        -- Explicit shell pieces that are intentionally transparent/large and therefore cannot
        -- be reliably detected by size/color heuristics.
        if nav then
            nav.BackgroundColor3=p.bg2
            nav.BackgroundTransparency=0
            nav.ScrollBarImageColor3=p.hot
            if nav.Parent and nav.Parent:IsA("Frame") then
                nav.Parent.BackgroundColor3=p.bg2
                nav.Parent.BackgroundTransparency=0
                outline(nav.Parent,p.line,.28,1)
            end
        end

        if badge then badge.BackgroundColor3=p.hot; badge.TextColor3=p.white end
        styleNav(p)

        -- Final accent lock. A few older v2.1 modules can still repaint the active
        -- sidebar button/version pill after a theme change. Repaint every visible
        -- copy here so no color from the previous theme survives outside previews.
        local pageNames={
            ["overview"]=true,["silent aim"]=true,["macro"]=true,["whitelist"]=true,
            ["protection"]=true,["anti fall"]=true,["delay changer"]=true,["esp"]=true,
            ["avatar"]=true,["fog / atmosphere"]=true,["environment"]=true,["weapon skins"]=true,
            ["hc silent aim"]=true,["force hit"]=true,["hitbox expander"]=true,["flamelock"]=true,
            ["camlock"]=true,["headless"]=true,["anti mod"]=true,["settings"]=true,
            ["theme"]=true,["information"]=true
        }
        for _,d in ipairs(main:GetDescendants()) do
            if d:IsA("TextLabel") or d:IsA("TextButton") then
                local raw=tostring(d.Text or "")
                local nt=clean(raw)
                if raw:lower():match("^v2%.1") then
                    d.BackgroundColor3=p.hot
                    d.TextColor3=p.white
                    d.BackgroundTransparency=0
                elseif nt=="pages" or nt=="features" then
                    d.TextColor3=p.text
                elseif raw:lower():find("right shift",1,true) then
                    d.TextColor3=p.hot
                elseif d:IsA("TextButton") and pageNames[nt] then
                    local selected=d:GetAttribute("KimqSelected")==true
                    if not selected then
                        local c=d.BackgroundColor3
                        selected=(colorDistance(c,p.hot)<0.09) or (previous and colorDistance(c,previous.hot)<0.09)
                    end
                    d.BackgroundColor3=selected and p.hot or p.panel
                    d.TextColor3=selected and p.white or p.text
                    local st=d:FindFirstChildOfClass("UIStroke")
                    if st then st.Color=selected and p.hot or p.line; st.Transparency=selected and .05 or .58 end
                end
            end
        end
    end

    local themeButtons={}
    local function buildThemePage()
        if not themePage then return end
        for _,ch in ipairs(themePage:GetChildren()) do if not ch:IsA("UIListLayout") and not ch:IsA("UIPadding") then ch:Destroy() end end
        local list=themePage:FindFirstChildOfClass("UIListLayout") or Instance.new("UIListLayout",themePage); list.SortOrder=Enum.SortOrder.LayoutOrder; list.Padding=UDim.new(0,9)
        local pad=themePage:FindFirstChildOfClass("UIPadding") or Instance.new("UIPadding",themePage); pad.PaddingTop=UDim.new(0,4); pad.PaddingBottom=UDim.new(0,8); pad.PaddingLeft=UDim.new(0,2); pad.PaddingRight=UDim.new(0,4)
        list:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() if themePage.Parent then themePage.CanvasSize=UDim2.new(0,0,0,list.AbsoluteContentSize.Y+16) end end)
        local order={"Matcha Pink","Lavender Blue","Baby Blue","Sky Lilac","Lilac Pink","Rose Cream","Peach Cream","Butter Pink","Mint Aqua","Grey Pink","Black Pink","Purple","Red","Pink","Aqua","Green"}
        for _,name in ipairs(order) do
            local p=THEMES[name]
            local row=Instance.new("Frame",themePage); row.Name="ThemeChoiceClean"; row.Size=UDim2.new(1,-8,0,58); row.BackgroundColor3=p.panel; row.BorderSizePixel=0; corner(row,13); outline(row,p.line,.22,1)
            local txt=Instance.new("TextLabel",row); txt.BackgroundTransparency=1; txt.Size=UDim2.new(1,-205,1,0); txt.Position=UDim2.fromOffset(14,0); txt.Text=(name=="Matcha Pink" and "Matcha + Pink" or name.." Theme"); txt.Font=Enum.Font.GothamSemibold; txt.TextSize=14; txt.TextColor3=p.text; txt.TextXAlignment=Enum.TextXAlignment.Left
            local sw1=Instance.new("Frame",row); sw1.Size=UDim2.fromOffset(30,30); sw1.Position=UDim2.new(1,-148,.5,-15); sw1.BackgroundColor3=p.bg; sw1.BorderSizePixel=0; corner(sw1,9); outline(sw1,p.line,.2,1)
            local sw2=Instance.new("Frame",row); sw2.Size=UDim2.fromOffset(30,30); sw2.Position=UDim2.new(1,-109,.5,-15); sw2.BackgroundColor3=p.hot2; sw2.BorderSizePixel=0; corner(sw2,9); outline(sw2,p.hot,.28,1)
            local choose=Instance.new("TextButton",row); choose.Size=UDim2.fromOffset(54,32); choose.Position=UDim2.new(1,-66,.5,-16); choose.BackgroundColor3=p.hot; choose.BorderSizePixel=0; choose.Text="♥"; choose.TextColor3=p.white; choose.Font=Enum.Font.FredokaOne; choose.TextSize=18; choose.AutoButtonColor=false; corner(choose,10); outline(choose,p.hot,.05,1)
            themeButtons[name]={row=row,button=choose}
            choose.MouseButton1Click:Connect(function()
                currentName=name; _G.KimqCuteTheme=name; applyVisuals(THEMES[name])
                task.defer(function() applyVisuals(THEMES[name]) end)
                task.delay(.08,function() if _G.KimqCuteTheme==name then applyVisuals(THEMES[name]) end end)
                for n,ref in pairs(themeButtons) do local pp=THEMES[n]; local st=ref.row:FindFirstChildOfClass("UIStroke"); if st then st.Thickness=(n==name) and 2 or 1; st.Transparency=(n==name) and .02 or .22; st.Color=pp.line end end
            end)
        end
    end

    -- Replace any visible paw-like text accents with hearts once.
    for _,d in ipairs(main:GetDescendants()) do
        if d:IsA("TextLabel") or d:IsA("TextButton") then
            d.Text=tostring(d.Text or ""):gsub("🐾","♥")
        end
    end

    buildThemePage()
    _G.KimqV21FullThemeActive=true
    applyVisuals(THEMES["Matcha Pink"])
    if themeButtons["Matcha Pink"] then local st=themeButtons["Matcha Pink"].row:FindFirstChildOfClass("UIStroke"); if st then st.Thickness=2; st.Transparency=.02 end end
end)


-- ========================================================
-- v2.1 RIGHT SHIFT REPAIR GUARD
-- Keeps Right Shift tied to the final visible Main after all theme passes finish.
-- The original page-level handler above remains the only keybind handler; this
-- guard only exposes the final Main reference for diagnostics and does not add
-- another InputBegan connection.
-- ========================================================
task.defer(function()
    local Players = game:GetService("Players")
    local CoreGui = game:GetService("CoreGui")
    local lp = Players.LocalPlayer
    local pg = lp and lp:FindFirstChildOfClass("PlayerGui")
    local root = CoreGui:FindFirstChild("KimpetrasHC") or (pg and pg:FindFirstChild("KimpetrasHC"))
    local finalMain = root and root:FindFirstChild("Main")
    if finalMain then
        _G.KimqetrasFinalMain = finalMain
    end
end)

-- ========================================================
-- v2.1 FINAL POLISH: full-theme lock + A-Z pages
-- Keeps the working feature callbacks intact. This pass only
-- fixes lingering old palette colors and sidebar organization.
-- F1 is handled by the canonical input listener above.
-- ========================================================
task.defer(function()
    local Players = game:GetService("Players")
    local CoreGui = game:GetService("CoreGui")
    local lp = Players.LocalPlayer
    local pg = lp and lp:FindFirstChildOfClass("PlayerGui")

    local t0 = tick()
    local root, main
    repeat
        root = CoreGui:FindFirstChild("KimpetrasHC") or (pg and pg:FindFirstChild("KimpetrasHC"))
        main = root and root:FindFirstChild("Main")
        if main then break end
        task.wait(.05)
    until tick() - t0 > 15
    if not main then return end

    local THEMES = {
        ["Matcha Pink"]={hot=Color3.fromRGB(243,161,211),hot2=Color3.fromRGB(255,212,243),bg=Color3.fromRGB(217,255,232),bg2=Color3.fromRGB(236,255,243),panel=Color3.fromRGB(255,255,255),soft=Color3.fromRGB(246,255,250),text=Color3.fromRGB(82,116,94),sub=Color3.fromRGB(122,153,133),line=Color3.fromRGB(255,212,243),white=Color3.new(1,1,1)},
        ["Lavender Blue"]={hot=Color3.fromRGB(132,151,239),hot2=Color3.fromRGB(220,225,255),bg=Color3.fromRGB(244,241,255),bg2=Color3.fromRGB(249,247,255),panel=Color3.new(1,1,1),soft=Color3.fromRGB(252,250,255),text=Color3.fromRGB(91,91,133),sub=Color3.fromRGB(132,130,169),line=Color3.fromRGB(216,211,244),white=Color3.new(1,1,1)},
        ["Baby Blue"]={hot=Color3.fromRGB(111,181,241),hot2=Color3.fromRGB(215,237,255),bg=Color3.fromRGB(238,248,255),bg2=Color3.fromRGB(247,252,255),panel=Color3.new(1,1,1),soft=Color3.fromRGB(250,253,255),text=Color3.fromRGB(72,112,146),sub=Color3.fromRGB(114,150,180),line=Color3.fromRGB(202,228,248),white=Color3.new(1,1,1)},
        ["Sky Lilac"]={hot=Color3.fromRGB(150,139,235),hot2=Color3.fromRGB(219,223,255),bg=Color3.fromRGB(239,247,255),bg2=Color3.fromRGB(248,250,255),panel=Color3.new(1,1,1),soft=Color3.fromRGB(251,252,255),text=Color3.fromRGB(91,91,137),sub=Color3.fromRGB(131,131,174),line=Color3.fromRGB(211,217,246),white=Color3.new(1,1,1)},
        ["Lilac Pink"]={hot=Color3.fromRGB(205,137,224),hot2=Color3.fromRGB(243,214,248),bg=Color3.fromRGB(252,241,255),bg2=Color3.fromRGB(255,248,255),panel=Color3.new(1,1,1),soft=Color3.fromRGB(255,251,255),text=Color3.fromRGB(126,84,137),sub=Color3.fromRGB(164,125,173),line=Color3.fromRGB(238,208,242),white=Color3.new(1,1,1)},
        ["Rose Cream"]={hot=Color3.fromRGB(225,142,166),hot2=Color3.fromRGB(251,217,227),bg=Color3.fromRGB(255,246,243),bg2=Color3.fromRGB(255,251,249),panel=Color3.new(1,1,1),soft=Color3.fromRGB(255,252,251),text=Color3.fromRGB(132,91,96),sub=Color3.fromRGB(171,128,133),line=Color3.fromRGB(244,211,216),white=Color3.new(1,1,1)},
        ["Peach Cream"]={hot=Color3.fromRGB(238,164,133),hot2=Color3.fromRGB(255,224,207),bg=Color3.fromRGB(255,245,235),bg2=Color3.fromRGB(255,250,245),panel=Color3.new(1,1,1),soft=Color3.fromRGB(255,252,248),text=Color3.fromRGB(132,96,80),sub=Color3.fromRGB(174,135,117),line=Color3.fromRGB(247,216,201),white=Color3.new(1,1,1)},
        ["Butter Pink"]={hot=Color3.fromRGB(238,153,192),hot2=Color3.fromRGB(255,219,235),bg=Color3.fromRGB(255,251,221),bg2=Color3.fromRGB(255,253,239),panel=Color3.new(1,1,1),soft=Color3.fromRGB(255,254,247),text=Color3.fromRGB(125,112,78),sub=Color3.fromRGB(166,149,111),line=Color3.fromRGB(246,221,224),white=Color3.new(1,1,1)},
        ["Mint Aqua"]={hot=Color3.fromRGB(96,193,183),hot2=Color3.fromRGB(205,242,236),bg=Color3.fromRGB(232,252,245),bg2=Color3.fromRGB(246,255,251),panel=Color3.new(1,1,1),soft=Color3.fromRGB(250,255,253),text=Color3.fromRGB(68,123,117),sub=Color3.fromRGB(109,159,153),line=Color3.fromRGB(194,233,226),white=Color3.new(1,1,1)},
        ["Grey Pink"]={hot=Color3.fromRGB(232,145,188),hot2=Color3.fromRGB(255,218,238),bg=Color3.fromRGB(244,245,249),bg2=Color3.fromRGB(249,250,252),panel=Color3.new(1,1,1),soft=Color3.fromRGB(252,252,254),text=Color3.fromRGB(92,92,105),sub=Color3.fromRGB(136,135,149),line=Color3.fromRGB(228,214,226),white=Color3.new(1,1,1)},
        ["Black Pink"]={hot=Color3.fromRGB(242,151,197),hot2=Color3.fromRGB(255,205,230),bg=Color3.fromRGB(28,29,34),bg2=Color3.fromRGB(37,38,45),panel=Color3.fromRGB(47,48,57),soft=Color3.fromRGB(56,57,67),text=Color3.fromRGB(255,221,238),sub=Color3.fromRGB(218,185,202),line=Color3.fromRGB(233,150,192),white=Color3.fromRGB(255,248,252)},
        Purple={hot=Color3.fromRGB(169,116,235),hot2=Color3.fromRGB(229,210,251),bg=Color3.fromRGB(246,239,255),bg2=Color3.fromRGB(251,247,255),panel=Color3.new(1,1,1),soft=Color3.fromRGB(252,249,255),text=Color3.fromRGB(102,77,126),sub=Color3.fromRGB(143,119,164),line=Color3.fromRGB(226,208,244),white=Color3.new(1,1,1)},
        Red={hot=Color3.fromRGB(236,111,132),hot2=Color3.fromRGB(255,205,215),bg=Color3.fromRGB(255,239,243),bg2=Color3.fromRGB(255,248,250),panel=Color3.new(1,1,1),soft=Color3.fromRGB(255,250,251),text=Color3.fromRGB(139,77,87),sub=Color3.fromRGB(174,116,126),line=Color3.fromRGB(247,202,210),white=Color3.new(1,1,1)},
        Pink={hot=Color3.fromRGB(238,131,190),hot2=Color3.fromRGB(255,212,243),bg=Color3.fromRGB(255,241,250),bg2=Color3.fromRGB(255,248,253),panel=Color3.new(1,1,1),soft=Color3.fromRGB(255,251,254),text=Color3.fromRGB(146,84,116),sub=Color3.fromRGB(181,125,153),line=Color3.fromRGB(248,208,232),white=Color3.new(1,1,1)},
        Aqua={hot=Color3.fromRGB(84,190,211),hot2=Color3.fromRGB(199,239,247),bg=Color3.fromRGB(233,251,254),bg2=Color3.fromRGB(245,254,255),panel=Color3.new(1,1,1),soft=Color3.fromRGB(249,254,255),text=Color3.fromRGB(67,120,131),sub=Color3.fromRGB(110,155,165),line=Color3.fromRGB(191,229,237),white=Color3.new(1,1,1)},
        Green={hot=Color3.fromRGB(100,185,135),hot2=Color3.fromRGB(205,240,219),bg=Color3.fromRGB(235,252,242),bg2=Color3.fromRGB(246,254,249),panel=Color3.new(1,1,1),soft=Color3.fromRGB(250,255,252),text=Color3.fromRGB(72,122,91),sub=Color3.fromRGB(112,158,129),line=Color3.fromRGB(198,232,211),white=Color3.new(1,1,1)},
    }

    local pageLabels = {
        ["anti fall"]=true,["anti mod"]=true,["avatar"]=true,["camlock"]=true,
        ["delay changer"]=true,["environment"]=true,["esp"]=true,["flamelock"]=true,
        ["fog / atmosphere"]=true,["force hit"]=true,["hc silent aim"]=true,["headless"]=true,
        ["hitbox expander"]=true,["information"]=true,["macro"]=true,["overview"]=true,
        ["protection"]=true,["settings"]=true,["silent aim"]=true,["theme"]=true,
        ["weapon skins"]=true,["whitelist"]=true,
    }

    local function clean(s)
        s=tostring(s or ""):lower():gsub("[♥♡❤]",""):gsub("%s+"," ")
        return (s:gsub("^%s+",""):gsub("%s+$",""))
    end
    local function dist(a,b)
        local r=a.R-b.R; local g=a.G-b.G; local z=a.B-b.B
        return math.sqrt(r*r+g*g+z*z)
    end
    local roleNames={"bg","bg2","panel","soft","hot","hot2","line","text","sub","white"}
    local function nearestRole(c)
        local role,best=nil,.11
        for _,tp in pairs(THEMES) do
            for _,r in ipairs(roleNames) do
                local v=tp[r]
                if v then local d=dist(c,v); if d<best then best=d; role=r end end
            end
        end
        return role
    end
    local function isThemePreview(o)
        local x=o
        while x and x~=main do
            if x.Name=="ThemeChoiceClean" then return true end
            x=x.Parent
        end
        return false
    end
    local function isColorPicker(o)
        local x=o
        while x and x~=main do
            local n=tostring(x.Name):lower()
            if n:find("picker",1,true) or n:find("rainbow",1,true) or n:find("hue",1,true) or n:find("saturation",1,true) or n:find("fogpreview",1,true) or n:find("fogsquare",1,true) or n:find("espcolor",1,true) then return true end
            x=x.Parent
        end
        return false
    end

    local function findNav()
        local best,bestScore=nil,0
        for _,d in ipairs(main:GetDescendants()) do
            if d:IsA("ScrollingFrame") then
                local score=0
                for _,b in ipairs(d:GetChildren()) do
                    if b:IsA("TextButton") and pageLabels[clean(b.Text)] then score+=1 end
                end
                if score>bestScore then best,bestScore=d,score end
            end
        end
        return best
    end

    local nav=findNav()
    local function alphabetizeNav()
        nav=findNav() or nav
        if not nav then return end
        local layout=nav:FindFirstChildOfClass("UIListLayout")
        if layout then layout.SortOrder=Enum.SortOrder.LayoutOrder end
        local arr={}
        for _,b in ipairs(nav:GetChildren()) do
            if b:IsA("TextButton") and pageLabels[clean(b.Text)] then table.insert(arr,b) end
        end
        table.sort(arr,function(a,b) return clean(a.Text)<clean(b.Text) end)
        for i,b in ipairs(arr) do b.LayoutOrder=i end
        nav.CanvasPosition=Vector2.zero
    end

    local function activePageLabel()
        for _,d in ipairs(main:GetDescendants()) do
            if d:IsA("ScrollingFrame") and d.Visible and d.Name:lower():match("page$") then
                local n=d.Name:lower():gsub("page$","")
                local map={antifall="anti fall",antimod="anti mod",delay="delay changer",fog="fog / atmosphere",forcehit="force hit",hcsilent="hc silent aim",hitbox="hitbox expander",info="information",weaponskins="weapon skins",silent="silent aim"}
                return map[n] or n
            end
        end
        return nil
    end

    local function repaint(p)
        if not p then return end
        local active=activePageLabel()
        main.BackgroundColor3=p.bg
        local mst=main:FindFirstChildOfClass("UIStroke"); if mst then mst.Color=p.line end

        for _,d in ipairs(main:GetDescendants()) do
            if not isThemePreview(d) and not isColorPicker(d) then
                if d:IsA("ScrollingFrame") then
                    d.ScrollBarImageColor3=p.hot
                    if d.BackgroundTransparency<.98 then
                        local r=nearestRole(d.BackgroundColor3)
                        if r=="bg" then d.BackgroundColor3=p.bg elseif r=="bg2" then d.BackgroundColor3=p.bg2 elseif r=="panel" or r=="white" then d.BackgroundColor3=p.panel elseif r=="soft" then d.BackgroundColor3=p.soft elseif r=="hot" then d.BackgroundColor3=p.hot elseif r=="hot2" or r=="line" then d.BackgroundColor3=p.hot2 end
                    end
                elseif d:IsA("Frame") or d:IsA("TextButton") or d:IsA("TextBox") then
                    if d.BackgroundTransparency<.98 then
                        local r=nearestRole(d.BackgroundColor3)
                        if r=="bg" then d.BackgroundColor3=p.bg elseif r=="bg2" then d.BackgroundColor3=p.bg2 elseif r=="panel" or r=="white" then d.BackgroundColor3=p.panel elseif r=="soft" then d.BackgroundColor3=p.soft elseif r=="hot" then d.BackgroundColor3=p.hot elseif r=="hot2" or r=="line" then d.BackgroundColor3=p.hot2 end
                    end
                elseif d:IsA("UIStroke") then
                    local r=nearestRole(d.Color)
                    if r=="hot" then d.Color=p.hot elseif r=="hot2" or r=="line" then d.Color=p.line elseif r=="text" then d.Color=p.text elseif r=="sub" then d.Color=p.sub end
                elseif d:IsA("UIGradient") then
                    local par=d.Parent
                    if par and not isColorPicker(par) and not isThemePreview(par) then
                        local role=nearestRole(par.BackgroundColor3)
                        if role=="hot" or role=="hot2" then
                            d.Color=ColorSequence.new({ColorSequenceKeypoint.new(0,p.hot2),ColorSequenceKeypoint.new(.55,p.hot),ColorSequenceKeypoint.new(1,p.hot:Lerp(p.white,.12))})
                        end
                    end
                end
            end
        end

        nav=findNav() or nav
        if nav then
            nav.ScrollBarImageColor3=p.hot
            if nav.Parent and nav.Parent:IsA("Frame") then nav.Parent.BackgroundColor3=p.bg2; local s=nav.Parent:FindFirstChildOfClass("UIStroke"); if s then s.Color=p.line end end
            for _,b in ipairs(nav:GetChildren()) do
                if b:IsA("TextButton") and pageLabels[clean(b.Text)] then
                    local label=clean(b.Text)
                    local selected=(label==active) or b:GetAttribute("KimqSelected")==true
                    b.BackgroundColor3=selected and p.hot or p.panel
                    b.TextColor3=selected and p.white or p.text
                    local st=b:FindFirstChildOfClass("UIStroke"); if st then st.Color=selected and p.hot or p.line; st.Transparency=selected and .05 or .58 end
                    for _,c in ipairs(b:GetDescendants()) do if c:IsA("TextLabel") and (c.Text=="♡" or c.Text=="♥") then c.TextColor3=selected and p.white or p.hot end end
                end
            end
        end

        -- Explicitly recolor every version badge and top title/subtitle, even when they sit
        -- outside the inner CuteBlueShell. This is what removes the last old-theme color.
        for _,d in ipairs(main:GetDescendants()) do
            if d:IsA("TextLabel") or d:IsA("TextButton") then
                local raw=tostring(d.Text or "")
                local low=raw:lower()
                if low:match("^v2%.1") then
                    d.BackgroundColor3=p.hot; d.BackgroundTransparency=0; d.TextColor3=p.white
                    local st=d:FindFirstChildOfClass("UIStroke"); if st then st.Color=p.hot end
                elseif low:find("kimqetras hc",1,true) or clean(raw)=="silent hc" then
                    if d.BackgroundTransparency>.8 then d.TextColor3=p.hot end
                elseif clean(raw)=="pages" or clean(raw)=="features" then
                    d.TextColor3=p.text
                elseif low:find("f1",1,true) and low:find("hide",1,true) then
                    d.TextColor3=p.hot
                end
            end
        end
    end

    alphabetizeNav()
    task.delay(.15,alphabetizeNav)
    task.delay(.6,alphabetizeNav)

    local function hookThemeButtons()
        for _,d in ipairs(main:GetDescendants()) do
            if d:IsA("TextButton") and isThemePreview(d) and not d:GetAttribute("KimqFinalThemeLock") then
                d:SetAttribute("KimqFinalThemeLock",true)
                d.MouseButton1Click:Connect(function()
                    task.delay(.03,function() repaint(THEMES[_G.KimqCuteTheme or "Matcha Pink"]) end)
                    task.delay(.14,function() repaint(THEMES[_G.KimqCuteTheme or "Matcha Pink"]) end)
                    task.delay(.34,function() repaint(THEMES[_G.KimqCuteTheme or "Matcha Pink"]) end)
                end)
            end
        end
    end
    hookThemeButtons()
    task.delay(.4,hookThemeButtons)
    task.delay(1,hookThemeButtons)
    repaint(THEMES[_G.KimqCuteTheme or "Matcha Pink"])
end)

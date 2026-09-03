-- Kimqetras HC V33 - short blue/hot-blue loader + Roblox decal resolver.
do
    _G.KimqV33Ready = false
    local Players = game:GetService("Players")
    local CoreGui = game:GetService("CoreGui")
    local ContentProvider = game:GetService("ContentProvider")
    local TweenService = game:GetService("TweenService")
    local lp = Players.LocalPlayer
    local pg = lp:WaitForChild("PlayerGui")

    local ids = {
        Pompom = 98379642851874,
        PompomIcon = 109428653544528,
        Paw = 138088505213748,
        Title = 99152748483206,
        Subtitle = 94248590271491,
        Minus = 121030051960124,
        X = 129350478207195,
        ToggleOn = 95234565377817,
        ToggleOff = 97764595221865,
        Reset = 104585185562435,
    }

    local function resolveDecal(id)
        local fallback = "rbxassetid://" .. tostring(id)
        local ok, objects = pcall(function() return game:GetObjects(fallback) end)
        if ok and type(objects) == "table" and objects[1] then
            local obj = objects[1]
            local content
            pcall(function()
                if obj:IsA("Decal") or obj:IsA("Texture") then content = obj.Texture end
                if obj:IsA("ImageLabel") or obj:IsA("ImageButton") then content = obj.Image end
            end)
            pcall(function() obj:Destroy() end)
            if content and content ~= "" then return content end
        end
        return fallback
    end

    local A = {}
    for name,id in pairs(ids) do A[name] = resolveDecal(id) end
    _G.KimqV33Assets = A
    _G.KimqV33AssetIds = ids

    local gui = Instance.new("ScreenGui")
    gui.Name = "KimqV33Loader"
    gui.IgnoreGuiInset = true
    gui.ResetOnSpawn = false
    gui.DisplayOrder = 9000000
    pcall(function() gui.Parent = CoreGui end)
    if not gui.Parent then gui.Parent = pg end

    local bg = Instance.new("Frame", gui)
    bg.Size = UDim2.fromScale(1,1)
    bg.BackgroundColor3 = Color3.fromRGB(207,231,255)
    bg.BorderSizePixel = 0
    local bgGrad = Instance.new("UIGradient", bg)
    bgGrad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(237,248,255)),
        ColorSequenceKeypoint.new(.55, Color3.fromRGB(207,231,255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(170,207,255)),
    })
    bgGrad.Rotation = 18

    local card = Instance.new("Frame", bg)
    card.AnchorPoint = Vector2.new(.5,.5)
    card.Position = UDim2.fromScale(.5,.5)
    card.Size = UDim2.fromOffset(650,390)
    card.BackgroundColor3 = Color3.fromRGB(247,252,255)
    card.BorderSizePixel = 0
    Instance.new("UICorner", card).CornerRadius = UDim.new(0,28)
    local cs = Instance.new("UIStroke", card)
    cs.Color = Color3.fromRGB(46,98,255)
    cs.Thickness = 2
    cs.Transparency = .15

    -- stitched border is kept in a dedicated gutter so it never collides with content.
    local stitch = Instance.new("Frame", card)
    stitch.Size = UDim2.new(1,-30,1,-30)
    stitch.Position = UDim2.fromOffset(15,15)
    stitch.BackgroundTransparency = 1
    local function dot(x,y,w,h)
        local d=Instance.new("Frame",stitch); d.Size=UDim2.fromOffset(w,h); d.Position=UDim2.new(x,0,y,0); d.AnchorPoint=Vector2.new(.5,.5); d.BackgroundColor3=Color3.fromRGB(105,159,242); d.BackgroundTransparency=.32; d.BorderSizePixel=0; Instance.new("UICorner",d).CornerRadius=UDim.new(1,0)
    end
    for i=0,22 do dot(i/22,0,12,2); dot(i/22,1,12,2) end
    for i=1,12 do dot(0,i/13,2,12); dot(1,i/13,2,12) end

    local mascot = Instance.new("ImageLabel", card)
    mascot.BackgroundTransparency = 1
    mascot.Size = UDim2.fromOffset(118,118)
    mascot.Position = UDim2.fromOffset(48,43)
    mascot.Image = A.Pompom
    mascot.ScaleType = Enum.ScaleType.Fit

    local title = Instance.new("ImageLabel", card)
    title.BackgroundTransparency = 1
    title.Size = UDim2.fromOffset(340,86)
    title.Position = UDim2.fromOffset(170,46)
    title.Image = A.Title
    title.ScaleType = Enum.ScaleType.Fit

    local subtitle = Instance.new("ImageLabel", card)
    subtitle.BackgroundTransparency = 1
    subtitle.Size = UDim2.fromOffset(185,56)
    subtitle.Position = UDim2.fromOffset(247,111)
    subtitle.Image = A.Subtitle
    subtitle.ScaleType = Enum.ScaleType.Fit

    local avatarCard = Instance.new("Frame",card)
    avatarCard.Size = UDim2.fromOffset(160,46)
    avatarCard.Position = UDim2.new(1,-205,0,48)
    avatarCard.BackgroundColor3 = Color3.fromRGB(233,245,255)
    avatarCard.BorderSizePixel=0
    Instance.new("UICorner",avatarCard).CornerRadius=UDim.new(0,14)
    local avs=Instance.new("UIStroke",avatarCard); avs.Color=Color3.fromRGB(142,184,238); avs.Transparency=.35
    local av=Instance.new("ImageLabel",avatarCard); av.Size=UDim2.fromOffset(32,32); av.Position=UDim2.fromOffset(7,7); av.BackgroundColor3=Color3.fromRGB(218,237,255); av.BorderSizePixel=0; Instance.new("UICorner",av).CornerRadius=UDim.new(1,0)
    pcall(function() av.Image=Players:GetUserThumbnailAsync(lp.UserId,Enum.ThumbnailType.HeadShot,Enum.ThumbnailSize.Size100x100) end)
    local nm=Instance.new("TextLabel",avatarCard); nm.BackgroundTransparency=1; nm.Size=UDim2.new(1,-48,0,18); nm.Position=UDim2.fromOffset(45,5); nm.Text=lp.DisplayName; nm.Font=Enum.Font.FredokaOne; nm.TextSize=12; nm.TextColor3=Color3.fromRGB(50,83,145); nm.TextXAlignment=Enum.TextXAlignment.Left
    local us=Instance.new("TextLabel",avatarCard); us.BackgroundTransparency=1; us.Size=UDim2.new(1,-48,0,16); us.Position=UDim2.fromOffset(45,23); us.Text="@"..lp.Name; us.Font=Enum.Font.Gotham; us.TextSize=9; us.TextColor3=Color3.fromRGB(105,132,177); us.TextXAlignment=Enum.TextXAlignment.Left

    local line=Instance.new("Frame",card); line.Size=UDim2.new(1,-96,0,1); line.Position=UDim2.fromOffset(48,175); line.BackgroundColor3=Color3.fromRGB(147,187,240); line.BackgroundTransparency=.35; line.BorderSizePixel=0
    local status=Instance.new("TextLabel",card); status.BackgroundTransparency=1; status.Size=UDim2.new(1,-80,0,28); status.Position=UDim2.fromOffset(40,198); status.Text="loading your controls..."; status.Font=Enum.Font.FredokaOne; status.TextSize=18; status.TextColor3=Color3.fromRGB(52,94,186); status.TextXAlignment=Enum.TextXAlignment.Center

    local track=Instance.new("Frame",card); track.Size=UDim2.new(1,-120,0,20); track.Position=UDim2.fromOffset(60,246); track.BackgroundColor3=Color3.fromRGB(214,233,252); track.BorderSizePixel=0; Instance.new("UICorner",track).CornerRadius=UDim.new(1,0)
    local ts=Instance.new("UIStroke",track); ts.Color=Color3.fromRGB(132,177,236); ts.Transparency=.3
    local bar=Instance.new("Frame",track); bar.Size=UDim2.new(.08,0,1,0); bar.BackgroundColor3=Color3.fromRGB(45,92,255); bar.BorderSizePixel=0; Instance.new("UICorner",bar).CornerRadius=UDim.new(1,0)
    local bgrad=Instance.new("UIGradient",bar); bgrad.Color=ColorSequence.new(Color3.fromRGB(101,176,255),Color3.fromRGB(41,86,255))

    local pawL=Instance.new("ImageLabel",card); pawL.BackgroundTransparency=1; pawL.Size=UDim2.fromOffset(42,42); pawL.Position=UDim2.fromOffset(45,300); pawL.Image=A.Paw; pawL.ScaleType=Enum.ScaleType.Fit
    local pawR=Instance.new("ImageLabel",card); pawR.BackgroundTransparency=1; pawR.Size=UDim2.fromOffset(42,42); pawR.Position=UDim2.new(1,-87,0,300); pawR.Image=A.Paw; pawR.ScaleType=Enum.ScaleType.Fit
    local note=Instance.new("TextLabel",card); note.BackgroundTransparency=1; note.Size=UDim2.new(1,-180,0,42); note.Position=UDim2.fromOffset(90,290); note.Text="same features • fresh GUI • blue + hot blue"; note.Font=Enum.Font.GothamSemibold; note.TextSize=12; note.TextColor3=Color3.fromRGB(91,124,177); note.TextXAlignment=Enum.TextXAlignment.Center

    pcall(function() ContentProvider:PreloadAsync({mascot,title,subtitle,pawL,pawR}) end)

    local steps={
        {"loading the working backend...",.25,.45},
        {"organizing every feature page...",.48,.45},
        {"building the blue interface...",.68,.45},
        {"setting up environment + skins...",.84,.45},
        {"finishing the cute details...",.94,.35},
    }
    task.spawn(function()
        for _,s in ipairs(steps) do
            if _G.KimqV33Ready or not gui.Parent then break end
            status.Text=s[1]
            TweenService:Create(bar,TweenInfo.new(.30,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{Size=UDim2.new(s[2],0,1,0)}):Play()
            task.wait(s[3])
        end
    end)

    -- Keep the old safe-loader hidden behind this one without destroying objects it is still updating.
    task.spawn(function()
        while gui.Parent and not _G.KimqV33Ready do
            for _,root in ipairs({CoreGui,pg}) do
                local b=root:FindFirstChild("KimpetrasHC_Boot")
                if b then pcall(function() b.Enabled=false end) end
            end
            task.wait(.08)
        end
    end)

    _G.KimqV33Loader={Gui=gui,Bg=bg,Card=card,Status=status,Bar=bar}
end


-- KIMPETRAS HC - SAFE REBUILT BOOTSTRAP
-- This file intentionally compiles each major module separately so Luau's
-- 200-local-register limit in large merged scripts cannot stop the UI from booting.

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local lp = Players.LocalPlayer
local playerGui = lp:WaitForChild("PlayerGui")

pcall(function()
    local old = CoreGui:FindFirstChild("KimpetrasHC")
    if old then old:Destroy() end
    local oldBoot = CoreGui:FindFirstChild("KimpetrasHC_Boot")
    if oldBoot then oldBoot:Destroy() end
end)
pcall(function()
    local old = playerGui:FindFirstChild("KimpetrasHC")
    if old then old:Destroy() end
    local oldBoot = playerGui:FindFirstChild("KimpetrasHC_Boot")
    if oldBoot then oldBoot:Destroy() end
end)

local BootGui = Instance.new("ScreenGui")
BootGui.Name = "KimpetrasHC_Boot"
BootGui.ResetOnSpawn = false
BootGui.IgnoreGuiInset = true
BootGui.DisplayOrder = 999999

local parented = pcall(function()
    BootGui.Parent = CoreGui
end)
if not parented or not BootGui.Parent then
    BootGui.Parent = playerGui
end

local Shade = Instance.new("Frame", BootGui)
Shade.Size = UDim2.fromScale(1, 1)
Shade.BackgroundColor3 = Color3.fromRGB(18, 12, 18)
Shade.BackgroundTransparency = 0.35
Shade.BorderSizePixel = 0

local Panel = Instance.new("Frame", Shade)
Panel.AnchorPoint = Vector2.new(0, 0.5)
Panel.Position = UDim2.new(0.02, 0, 0.5, 0)
Panel.Size = UDim2.new(0, 500, 0, 250)
Panel.BackgroundColor3 = Color3.fromRGB(35, 24, 33)
Panel.BorderSizePixel = 0
Instance.new("UICorner", Panel).CornerRadius = UDim.new(0, 16)

local Stroke = Instance.new("UIStroke", Panel)
Stroke.Color = Color3.fromRGB(255, 153, 199)
Stroke.Thickness = 2
Stroke.Transparency = 0.25

local Title = Instance.new("TextLabel", Panel)
Title.Position = UDim2.fromOffset(22, 20)
Title.Size = UDim2.new(1, -44, 0, 34)
Title.BackgroundTransparency = 1
Title.Text = "Kimpetras HC"
Title.TextColor3 = Color3.fromRGB(255, 191, 220)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 23
Title.TextXAlignment = Enum.TextXAlignment.Left

local Credit = Instance.new("TextLabel", Panel)
Credit.Position = UDim2.fromOffset(22, 53)
Credit.Size = UDim2.new(1, -44, 0, 22)
Credit.BackgroundTransparency = 1
Credit.Text = "made by Kimqetras"
Credit.TextColor3 = Color3.fromRGB(255, 226, 174)
Credit.Font = Enum.Font.Gotham
Credit.TextSize = 13
Credit.TextXAlignment = Enum.TextXAlignment.Left

local Status = Instance.new("TextLabel", Panel)
Status.Position = UDim2.fromOffset(22, 91)
Status.Size = UDim2.new(1, -44, 0, 115)
Status.BackgroundTransparency = 1
Status.Text = "starting safe loader..."
Status.TextColor3 = Color3.fromRGB(255, 235, 244)
Status.Font = Enum.Font.Code
Status.TextSize = 14
Status.TextWrapped = true
Status.TextXAlignment = Enum.TextXAlignment.Left
Status.TextYAlignment = Enum.TextYAlignment.Top

local BarBack = Instance.new("Frame", Panel)
BarBack.Position = UDim2.new(0, 22, 1, -27)
BarBack.Size = UDim2.new(1, -44, 0, 7)
BarBack.BackgroundColor3 = Color3.fromRGB(85, 57, 75)
BarBack.BorderSizePixel = 0
Instance.new("UICorner", BarBack).CornerRadius = UDim.new(1, 0)

local Bar = Instance.new("Frame", BarBack)
Bar.Size = UDim2.new(0.03, 0, 1, 0)
Bar.BackgroundColor3 = Color3.fromRGB(255, 119, 182)
Bar.BorderSizePixel = 0
Instance.new("UICorner", Bar).CornerRadius = UDim.new(1, 0)

local failures = {}
local completed = 0
local total = 6

local function setProgress(name)
    completed = completed + 1
    Bar.Size = UDim2.new(math.clamp(completed / total, 0, 1), 0, 1, 0)
    Status.Text = "loading " .. name .. "...  (" .. completed .. "/" .. total .. ")"
end

local function runChunk(name, source, required)
    setProgress(name)
    task.wait()
    local fn, compileErr = loadstring(source)
    if not fn then
        local msg = name .. " COMPILE: " .. tostring(compileErr)
        table.insert(failures, msg)
        Status.Text = "❌ " .. msg
        if required then
            Status.Text = Status.Text .. "\n\nCore could not compile, so loading stopped."
            return false
        end
        task.wait(0.2)
        return true
    end

    local ok, runtimeErr = pcall(fn)
    if not ok then
        local msg = name .. " RUNTIME: " .. tostring(runtimeErr)
        table.insert(failures, msg)
        Status.Text = "⚠ " .. msg
        if required then
            Status.Text = Status.Text .. "\n\nCore could not start, so loading stopped."
            return false
        end
        task.wait(0.2)
    end
    return true
end

task.wait(0.1)

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
    card.BackgroundColor3 = Color3.fromRGB(255, 225, 238)
    card.BorderSizePixel = 0
    card.Parent = Scroll
    
    local c = Instance.new("UICorner", card)
    c.CornerRadius = UDim.new(0, 8)
    
    local s = Instance.new("UIStroke", card)
    s.Color = Color3.fromRGB(255, 175, 215)
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
    lbl.TextColor3 = Color3.fromRGB(166, 55, 105)
    lbl.Font = Enum.Font.SourceSansBold
    lbl.TextSize = 15
    lbl.TextXAlignment = Enum.TextXAlignment.Left

    local btn = Instance.new("TextButton", card)
    btn.Size = UDim2.new(0, 44, 0, 22)
    btn.Position = UDim2.new(1, -54, 0.5, -11)
    btn.BackgroundColor3 = default and Color3.fromRGB(255, 20, 147) or Color3.fromRGB(255, 206, 226)
    btn.Text = ""
    btn.AutoButtonColor = false

    local bc = Instance.new("UICorner", btn)
    bc.CornerRadius = UDim.new(1, 0)

    local circle = Instance.new("Frame", btn)
    circle.Size = UDim2.new(0, 18, 0, 18)
    circle.Position = default and UDim2.new(1, -20, 0.5, -9) or UDim2.new(0, 2, 0.5, -9)
    circle.BackgroundColor3 = Color3.fromRGB(255, 225, 238)
    
    local cc = Instance.new("UICorner", circle)
    cc.CornerRadius = UDim.new(1, 0)

    local state = default
    btn.MouseButton1Click:Connect(function()
        state = not state
        btn.BackgroundColor3 = state and Color3.fromRGB(255, 20, 147) or Color3.fromRGB(255, 206, 226)
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
    lbl.TextColor3 = Color3.fromRGB(166, 55, 105)
    lbl.Font = Enum.Font.SourceSansBold
    lbl.TextSize = 15
    lbl.TextXAlignment = Enum.TextXAlignment.Left

    local valLbl = Instance.new("TextLabel", card)
    valLbl.Size = UDim2.new(0.3, 0, 0, 20)
    valLbl.Position = UDim2.new(0.7, -10, 0, 4)
    valLbl.BackgroundTransparency = 1
    valLbl.Text = tostring(default)
    valLbl.TextColor3 = Color3.fromRGB(210, 65, 135)
    valLbl.Font = Enum.Font.SourceSans
    valLbl.TextSize = 14
    valLbl.TextXAlignment = Enum.TextXAlignment.Right

    local bg = Instance.new("Frame", card)
    bg.Size = UDim2.new(1, -20, 0, 8)
    bg.Position = UDim2.new(0, 10, 0, 30)
    bg.BackgroundColor3 = Color3.fromRGB(255, 202, 224)
    Instance.new("UICorner", bg).CornerRadius = UDim.new(1, 0)

    local fill = Instance.new("Frame", bg)
    fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    fill.BackgroundColor3 = Color3.fromRGB(255, 20, 147)
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
    lbl.TextColor3 = Color3.fromRGB(166, 55, 105)
    lbl.Font = Enum.Font.SourceSansBold
    lbl.TextSize = 15
    lbl.TextXAlignment = Enum.TextXAlignment.Left

    local valLbl = Instance.new("TextLabel", card)
    valLbl.Size = UDim2.new(0.3, 0, 0, 20)
    valLbl.Position = UDim2.new(0.7, -10, 0, 4)
    valLbl.BackgroundTransparency = 1
    valLbl.Text = string.format("%." .. decimals .. "f", default)
    valLbl.TextColor3 = Color3.fromRGB(210, 65, 135)
    valLbl.Font = Enum.Font.SourceSans
    valLbl.TextSize = 14
    valLbl.TextXAlignment = Enum.TextXAlignment.Right

    local bg = Instance.new("Frame", card)
    bg.Size = UDim2.new(1, -20, 0, 8)
    bg.Position = UDim2.new(0, 10, 0, 30)
    bg.BackgroundColor3 = Color3.fromRGB(255, 202, 224)
    Instance.new("UICorner", bg).CornerRadius = UDim.new(1, 0)

    local fill = Instance.new("Frame", bg)
    fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    fill.BackgroundColor3 = Color3.fromRGB(255, 20, 147)
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
    lbl.TextColor3 = Color3.fromRGB(166, 55, 105)
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
    lbl.TextColor3 = Color3.fromRGB(166, 55, 105)
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
local ExtraESPColor = Color3.fromRGB(255, 20, 147)

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
Instance.new("UICorner", FogSquare).CornerRadius = UDim.new(0, 6)

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
Instance.new("UICorner", FogPreview).CornerRadius = UDim.new(0,7)

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
Instance.new("UICorner", FogHex).CornerRadius = UDim.new(0,6)
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
    Instance.new("UICorner", box).CornerRadius = UDim.new(0,6)
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
_G.UIToggleKey = Enum.KeyCode.RightShift
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

for _, v in ipairs(game:GetDescendants()) do applyCustomDelay(v) end
game.DescendantAdded:Connect(function(v) applyCustomDelay(v) end)

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
    Status.Text = "ready ♥\nKimpetras HC loaded successfully."
    Bar.Size = UDim2.new(1, 0, 1, 0)
    task.wait(0.8)
    BootGui:Destroy()
else
    local first = failures[1] or "unknown issue"
    Status.Text = "Kimpetras HC is open.\n" .. tostring(#failures) .. " optional module issue(s) were skipped.\n\nFirst issue:\n" .. first
    Bar.Size = UDim2.new(1, 0, 1, 0)

    local Close = Instance.new("TextButton", Panel)
    Close.Size = UDim2.fromOffset(28, 28)
    Close.Position = UDim2.new(1, -38, 0, 12)
    Close.BackgroundColor3 = Color3.fromRGB(255, 172, 209)
    Close.Text = "×"
    Close.TextColor3 = Color3.fromRGB(130, 44, 85)
    Close.Font = Enum.Font.GothamBold
    Close.TextSize = 18
    Instance.new("UICorner", Close).CornerRadius = UDim.new(0, 8)
    Close.MouseButton1Click:Connect(function()
        BootGui:Destroy()
    end)
end


-- Kimqetras HC V33 - fresh GUI built around the original working control instances.
task.spawn(function()
    local Players=game:GetService("Players")
    local CoreGui=game:GetService("CoreGui")
    local UIS=game:GetService("UserInputService")
    local TweenService=game:GetService("TweenService")
    local ContentProvider=game:GetService("ContentProvider")
    local Lighting=game:GetService("Lighting")
    local ReplicatedStorage=game:GetService("ReplicatedStorage")
    local RunService=game:GetService("RunService")
    local lp=Players.LocalPlayer
    local pg=lp:WaitForChild("PlayerGui")
    local C=_G.KimpetrasCtx
    local waitStart=tick()
    while (not C or not C.ScreenGui or not C.Main or not C.Scroll) and tick()-waitStart<12 do
        task.wait(.08); C=_G.KimpetrasCtx
    end
    if not C or not C.ScreenGui or not C.Main or not C.Scroll then
        local L=_G.KimqV33Loader
        if L and L.Status then L.Status.Text="the working backend did not load" end
        return
    end

    local gui,oldMain,oldScroll=C.ScreenGui,C.Main,C.Scroll
    local A=_G.KimqV33Assets or {}
    gui.IgnoreGuiInset=true
    gui.DisplayOrder=1000

    local Themes={
        Blue={bg=Color3.fromRGB(215,235,255),paper=Color3.fromRGB(248,252,255),panel=Color3.fromRGB(239,247,255),soft=Color3.fromRGB(220,238,255),soft2=Color3.fromRGB(199,225,255),hot=Color3.fromRGB(43,88,255),hot2=Color3.fromRGB(91,166,255),line=Color3.fromRGB(130,178,240),text=Color3.fromRGB(48,79,145),sub=Color3.fromRGB(94,123,175),white=Color3.fromRGB(255,255,255)},
        Purple={bg=Color3.fromRGB(235,223,255),paper=Color3.fromRGB(251,248,255),panel=Color3.fromRGB(245,239,255),soft=Color3.fromRGB(230,214,255),soft2=Color3.fromRGB(211,190,255),hot=Color3.fromRGB(131,70,245),hot2=Color3.fromRGB(175,121,255),line=Color3.fromRGB(190,158,238),text=Color3.fromRGB(88,60,145),sub=Color3.fromRGB(126,103,171),white=Color3.fromRGB(255,255,255)},
        Pink={bg=Color3.fromRGB(255,226,240),paper=Color3.fromRGB(255,249,252),panel=Color3.fromRGB(255,240,247),soft=Color3.fromRGB(255,214,234),soft2=Color3.fromRGB(255,190,220),hot=Color3.fromRGB(245,65,155),hot2=Color3.fromRGB(255,118,184),line=Color3.fromRGB(239,157,198),text=Color3.fromRGB(144,61,106),sub=Color3.fromRGB(177,105,140),white=Color3.fromRGB(255,255,255)},
        Red={bg=Color3.fromRGB(255,226,226),paper=Color3.fromRGB(255,249,249),panel=Color3.fromRGB(255,239,239),soft=Color3.fromRGB(255,214,214),soft2=Color3.fromRGB(255,190,190),hot=Color3.fromRGB(224,52,68),hot2=Color3.fromRGB(255,103,113),line=Color3.fromRGB(235,151,158),text=Color3.fromRGB(136,56,64),sub=Color3.fromRGB(168,99,105),white=Color3.fromRGB(255,255,255)},
        Aqua={bg=Color3.fromRGB(215,249,250),paper=Color3.fromRGB(247,254,255),panel=Color3.fromRGB(235,251,252),soft=Color3.fromRGB(207,243,246),soft2=Color3.fromRGB(176,231,237),hot=Color3.fromRGB(28,175,191),hot2=Color3.fromRGB(85,218,227),line=Color3.fromRGB(121,205,213),text=Color3.fromRGB(42,112,121),sub=Color3.fromRGB(84,147,154),white=Color3.fromRGB(255,255,255)},
        Green={bg=Color3.fromRGB(224,248,230),paper=Color3.fromRGB(249,254,250),panel=Color3.fromRGB(239,251,242),soft=Color3.fromRGB(211,240,218),soft2=Color3.fromRGB(184,226,195),hot=Color3.fromRGB(44,170,86),hot2=Color3.fromRGB(91,215,130),line=Color3.fromRGB(135,204,155),text=Color3.fromRGB(55,113,73),sub=Color3.fromRGB(95,151,111),white=Color3.fromRGB(255,255,255)},
    }
    local UI={themeName="Blue",T=Themes.Blue,roles={},toggles={},statusToggles={},navButtons={},pages={},meta={},imageTint={},blueOnly={},themeButtons={}}
    local function reg(o,role)
        if not o then return o end
        UI.roles[role]=UI.roles[role] or {}
        table.insert(UI.roles[role],o)
        return o
    end
    local function corner(o,r)
        local c=o:FindFirstChildOfClass("UICorner") or Instance.new("UICorner",o); c.CornerRadius=UDim.new(0,r or 12); return c
    end
    local function stroke(o,role,thickness,transparency)
        local s=o:FindFirstChildOfClass("UIStroke") or Instance.new("UIStroke",o); s.Thickness=thickness or 1; s.Transparency=transparency or .18; reg(s,role or "line"); return s
    end
    local function txt(parent,text,size,pos,font,ts,role,align)
        local l=Instance.new("TextLabel",parent); l.BackgroundTransparency=1; l.Size=size; l.Position=pos; l.Text=text; l.Font=font or Enum.Font.Gotham; l.TextSize=ts or 12; l.TextXAlignment=align or Enum.TextXAlignment.Left; l.TextYAlignment=Enum.TextYAlignment.Center; reg(l,role or "text"); return l
    end
    local function img(parent,asset,size,pos,z)
        local i=Instance.new("ImageLabel",parent); i.BackgroundTransparency=1; i.Size=size; i.Position=pos; i.Image=asset or ""; i.ScaleType=Enum.ScaleType.Fit; i.ZIndex=z or 3; return i
    end
    local function button(parent,text,size,pos,hot)
        local b=Instance.new("TextButton",parent); b.Size=size; b.Position=pos; b.BorderSizePixel=0; b.Text=text; b.Font=Enum.Font.GothamBold; b.TextSize=12; b.AutoButtonColor=false; corner(b,10); stroke(b,"line",1,.28); reg(b,hot and "hotButton" or "softButton"); return b
    end

    local function toggleState(entry)
        local b=entry.button
        if not b or not b.Parent then return false end
        local c=b.BackgroundColor3
        if c.R>.85 and c.G<.45 then return true end -- original hot-pink callback state
        local circle=entry.circle
        if circle and circle.Parent then return circle.Position.X.Scale>.5 end
        return false
    end
    local function refreshToggle(entry)
        if not entry.button or not entry.button.Parent then return end
        local on=toggleState(entry); local T=UI.T
        if UI.themeName=="Blue" and entry.art and entry.art.Parent and A.ToggleOn and A.ToggleOff then
            entry.art.Visible=true; entry.art.Image=on and A.ToggleOn or A.ToggleOff; entry.art.ImageColor3=Color3.new(1,1,1)
            entry.button.BackgroundTransparency=1
            if entry.circle then entry.circle.BackgroundTransparency=1 end
        else
            if entry.art then entry.art.Visible=false end
            entry.button.BackgroundTransparency=0; entry.button.BackgroundColor3=on and T.hot or T.soft2
            if entry.circle then
                entry.circle.BackgroundTransparency=0; entry.circle.BackgroundColor3=T.white
                entry.circle.Position=on and UDim2.new(1,-20,.5,-9) or UDim2.new(0,2,.5,-9)
            end
        end
    end
    local function refreshStatusToggle(entry)
        if not entry.button or not entry.button.Parent then return end
        local on=tostring(entry.button.Text):upper()=="ON"; entry.button.BackgroundColor3=on and UI.T.hot or UI.T.soft2; entry.button.TextColor3=on and UI.T.white or UI.T.text
    end

    local function applyTheme(name)
        local T=Themes[name]; if not T then return end
        UI.themeName=name; UI.T=T
        local map={bg="bg",paper="paper",panel="panel",soft="soft",soft2="soft2",hot="hot",hot2="hot2",line="line",text="text",sub="sub"}
        for role,key in pairs(map) do
            for _,o in ipairs(UI.roles[role] or {}) do
                if o and o.Parent then
                    if o:IsA("UIStroke") then
                        o.Color=T[key]
                    elseif o:IsA("ScrollingFrame") then
                        if role=="scroll" then o.ScrollBarImageColor3=T.hot else o.BackgroundColor3=T[key] end
                    elseif o:IsA("TextLabel") or o:IsA("TextButton") or o:IsA("TextBox") then
                        if role=="text" or role=="sub" or role=="hot" or role=="line" then o.TextColor3=T[key] else o.BackgroundColor3=T[key] end
                    else
                        o.BackgroundColor3=T[key]
                    end
                end
            end
        end
        for _,b in ipairs(UI.roles.hotButton or {}) do if b and b.Parent then b.BackgroundColor3=T.hot; b.TextColor3=T.white end end
        for _,b in ipairs(UI.roles.softButton or {}) do if b and b.Parent then b.BackgroundColor3=T.soft; b.TextColor3=T.text end end
        for _,i in ipairs(UI.imageTint) do if i and i.Parent then i.ImageColor3=(name=="Blue") and Color3.new(1,1,1) or T.hot2:Lerp(Color3.new(1,1,1),.30) end end
        for _,p in ipairs(UI.blueOnly) do
            if p.image and p.image.Parent then p.image.Visible=(name=="Blue") end
            if p.fallback and p.fallback.Parent then p.fallback.Visible=(name~="Blue"); p.fallback.TextColor3=T.hot end
        end
        for _,e in ipairs(UI.toggles) do refreshToggle(e) end
        for _,e in ipairs(UI.statusToggles) do refreshStatusToggle(e) end
        for _,n in ipairs(UI.navButtons) do
            if n.button and n.button.Parent then
                local active=n.key==UI.currentPage; n.button.BackgroundColor3=active and T.hot or T.panel; n.button.TextColor3=active and T.white or T.text
                local p=n.paw; if p then p.ImageColor3=active and T.white or ((name=="Blue") and Color3.new(1,1,1) or T.hot2:Lerp(Color3.new(1,1,1),.25)) end
            end
        end
        for key,b in pairs(UI.themeButtons) do if b and b.Parent then local on=key==name; b.BackgroundColor3=on and T.hot or T.soft; b.TextColor3=on and T.white or T.text end end
    end
    _G.KimqApplyThemeV33=applyTheme

    -- Hide the old shell only after we have harvested its live controls.
    local main=Instance.new("Frame",gui)
    main.Name="KimqV33Main"; main.AnchorPoint=Vector2.new(.5,.5); main.Position=UDim2.fromScale(.5,.5); main.Size=UDim2.fromOffset(1160,700); main.BorderSizePixel=0; main.Active=true; reg(main,"bg"); corner(main,26); stroke(main,"hot",2,.08)
    local scaler=Instance.new("UIScale",main)
    local function fitScale()
        local cam=workspace.CurrentCamera; local v=cam and cam.ViewportSize or Vector2.new(1280,720); scaler.Scale=math.min(1,(v.X-26)/1160,(v.Y-26)/700)
    end
    fitScale(); if workspace.CurrentCamera then workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(fitScale) end

    local stitch=Instance.new("Frame",main); stitch.Size=UDim2.new(1,-28,1,-28); stitch.Position=UDim2.fromOffset(14,14); stitch.BackgroundTransparency=1
    local function stitchDot(x,y,w,h)
        local d=Instance.new("Frame",stitch); d.AnchorPoint=Vector2.new(.5,.5); d.Position=UDim2.new(x,0,y,0); d.Size=UDim2.fromOffset(w,h); d.BorderSizePixel=0; corner(d,3); reg(d,"line")
    end
    for i=0,32 do stitchDot(i/32,0,13,2); stitchDot(i/32,1,13,2) end
    for i=1,18 do stitchDot(0,i/19,2,13); stitchDot(1,i/19,2,13) end

    local header=Instance.new("Frame",main); header.Name="Header"; header.Size=UDim2.new(1,-50,0,92); header.Position=UDim2.fromOffset(25,18); header.BackgroundTransparency=1; header.Active=true
    local pom=img(header,A.Pompom,UDim2.fromOffset(96,96),UDim2.fromOffset(2,-3),5); table.insert(UI.imageTint,pom)
    local logo=img(header,A.Title,UDim2.fromOffset(290,70),UDim2.fromOffset(102,0),5)
    local logoFallback=txt(header,"Kimqetras",UDim2.fromOffset(290,50),UDim2.fromOffset(110,6),Enum.Font.FredokaOne,31,"hot"); logoFallback.Visible=false; table.insert(UI.blueOnly,{image=logo,fallback=logoFallback})
    local subLogo=img(header,A.Subtitle,UDim2.fromOffset(180,52),UDim2.fromOffset(145,49),5)
    local subFallback=txt(header,"silent hc  ♡",UDim2.fromOffset(190,25),UDim2.fromOffset(145,55),Enum.Font.FredokaOne,17,"hot"); subFallback.Visible=false; table.insert(UI.blueOnly,{image=subLogo,fallback=subFallback})

    local profile=Instance.new("Frame",header); profile.Size=UDim2.fromOffset(190,48); profile.Position=UDim2.new(1,-330,0,9); profile.BorderSizePixel=0; reg(profile,"panel"); corner(profile,14); stroke(profile,"line",1,.3)
    local av=Instance.new("ImageLabel",profile); av.Size=UDim2.fromOffset(34,34); av.Position=UDim2.fromOffset(7,7); av.BackgroundColor3=Themes.Blue.soft; av.BorderSizePixel=0; corner(av,999); pcall(function() av.Image=Players:GetUserThumbnailAsync(lp.UserId,Enum.ThumbnailType.HeadShot,Enum.ThumbnailSize.Size100x100) end)
    txt(profile,lp.DisplayName,UDim2.new(1,-50,0,18),UDim2.fromOffset(47,5),Enum.Font.FredokaOne,12,"text")
    txt(profile,"@"..lp.Name,UDim2.new(1,-50,0,16),UDim2.fromOffset(47,23),Enum.Font.Gotham,9,"sub")

    local minBtn=Instance.new("TextButton",header); minBtn.Size=UDim2.fromOffset(46,46); minBtn.Position=UDim2.new(1,-116,0,9); minBtn.BackgroundColor3=Themes.Blue.soft; minBtn.BorderSizePixel=0; minBtn.Text=""; minBtn.AutoButtonColor=false; corner(minBtn,14); stroke(minBtn,"line",1,.2); reg(minBtn,"softButton")
    local minImg=img(minBtn,A.Minus,UDim2.fromOffset(38,38),UDim2.fromOffset(4,4),7); table.insert(UI.imageTint,minImg)
    local xBtn=Instance.new("TextButton",header); xBtn.Size=UDim2.fromOffset(46,46); xBtn.Position=UDim2.new(1,-60,0,9); xBtn.BackgroundColor3=Themes.Blue.soft; xBtn.BorderSizePixel=0; xBtn.Text=""; xBtn.AutoButtonColor=false; corner(xBtn,14); stroke(xBtn,"line",1,.2); reg(xBtn,"softButton")
    local xImg=img(xBtn,A.X,UDim2.fromOffset(38,38),UDim2.fromOffset(4,4),7); table.insert(UI.imageTint,xImg)
    local badge=txt(header,"V33 ♥",UDim2.fromOffset(70,24),UDim2.new(1,-190,0,60),Enum.Font.FredokaOne,12,"hot",Enum.TextXAlignment.Center)

    local side=Instance.new("Frame",main); side.Size=UDim2.fromOffset(244,552); side.Position=UDim2.fromOffset(25,122); side.BorderSizePixel=0; reg(side,"panel"); corner(side,18); stroke(side,"line",1,.2)
    local sidePaw=img(side,A.Paw,UDim2.fromOffset(28,28),UDim2.fromOffset(16,13),5); table.insert(UI.imageTint,sidePaw)
    txt(side,"FEATURES",UDim2.new(1,-62,0,28),UDim2.fromOffset(50,12),Enum.Font.FredokaOne,17,"text")
    local sideDash=txt(side,"-  -  -  -  -  -  -  -",UDim2.new(1,-26,0,16),UDim2.fromOffset(13,40),Enum.Font.GothamBold,9,"line",Enum.TextXAlignment.Center)
    local nav=Instance.new("ScrollingFrame",side); nav.Size=UDim2.new(1,-14,1,-102); nav.Position=UDim2.fromOffset(7,60); nav.BackgroundTransparency=1; nav.BorderSizePixel=0; nav.ScrollBarThickness=3; reg(nav,"scroll")
    local nl=Instance.new("UIListLayout",nav); nl.SortOrder=Enum.SortOrder.LayoutOrder; nl.Padding=UDim.new(0,6); nl:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() nav.CanvasSize=UDim2.new(0,0,0,nl.AbsoluteContentSize.Y+6) end)
    local hint=Instance.new("Frame",side); hint.Size=UDim2.new(1,-16,0,34); hint.Position=UDim2.new(0,8,1,-42); hint.BorderSizePixel=0; reg(hint,"soft"); corner(hint,11); stroke(hint,"line",1,.3)
    txt(hint,"Right Shift / Right Click",UDim2.new(1,-10,1,0),UDim2.fromOffset(5,0),Enum.Font.GothamSemibold,9,"sub",Enum.TextXAlignment.Center)

    local content=Instance.new("Frame",main); content.Size=UDim2.fromOffset(842,552); content.Position=UDim2.fromOffset(286,122); content.BackgroundTransparency=1
    local pageHead=Instance.new("Frame",content); pageHead.Size=UDim2.new(1,0,0,72); pageHead.BorderSizePixel=0; reg(pageHead,"panel"); corner(pageHead,17); stroke(pageHead,"line",1,.2)
    local headPaw=img(pageHead,A.Paw,UDim2.fromOffset(27,27),UDim2.fromOffset(17,12),5); table.insert(UI.imageTint,headPaw)
    local pageTitle=txt(pageHead,"overview",UDim2.new(1,-60,0,28),UDim2.fromOffset(51,8),Enum.Font.FredokaOne,21,"text")
    local pageDesc=txt(pageHead,"your account and quick notes",UDim2.new(1,-36,0,18),UDim2.fromOffset(18,40),Enum.Font.Gotham,10,"sub")
    txt(pageHead,"-  -  -  -  -  -  -  -",UDim2.fromOffset(190,16),UDim2.new(1,-210,0,43),Enum.Font.GothamBold,8,"line",Enum.TextXAlignment.Right)
    local host=Instance.new("Frame",content); host.Size=UDim2.new(1,0,1,-84); host.Position=UDim2.fromOffset(0,84); host.BackgroundTransparency=1

    local defs={
        {"overview","overview","your account, quick notes, and a clean welcome page"},
        {"silent","silent aim","cursor targeting, FOV, hit part, and aim key"},
        {"macro","macro","speed controls and macro activation"},
        {"whitelist","whitelist","players ignored by targeting and ESP"},
        {"protection","protection","anti-aim-view protection controls"},
        {"antifall","anti fall","recover from falling-down states"},
        {"delay","delay changer","weapon cooldown values"},
        {"esp","esp","boxes, names, distance, health, tracers, skeletons"},
        {"avatar","avatar","avatar copy, headless, and local accessory tools"},
        {"fog","fog / atmosphere","color picker, fog amount, presets, saturation"},
        {"environment","environment","normal, cute Halloween, and Christmas weather"},
        {"weapons","weapon skins","choose a weapon, choose its local wrap, and apply"},
        {"hcsilent","HC silent aim","Hood Customs targeting, prediction, FOV, checks"},
        {"forcehit","force hit","force-hit mode, tracer, FOV, full auto, fire rate"},
        {"hitbox","hitbox expander","hitbox size and visibility"},
        {"flamelock","flamelock","lock key, prediction, smoothness, offsets"},
        {"camlock","camlock","targeting, smoothing, prediction, checks"},
        {"headless","headless","simple visual headless"},
        {"antimod","anti mod","notification, kick, and anti-mod options"},
        {"settings","settings","FPS and local configuration tools"},
        {"theme","theme","recolor the entire interface"},
        {"info","information","credits and build details"},
    }
    for _,d in ipairs(defs) do
        UI.meta[d[1]]={label=d[2],desc=d[3]}
        local p=Instance.new("ScrollingFrame",host); p.Name="V33_"..d[1]; p.Size=UDim2.fromScale(1,1); p.BackgroundTransparency=1; p.BorderSizePixel=0; p.Visible=false; p.ScrollBarThickness=3; reg(p,"scroll")
        local pad=Instance.new("UIPadding",p); pad.PaddingRight=UDim.new(0,5); pad.PaddingBottom=UDim.new(0,8)
        local li=Instance.new("UIListLayout",p); li.SortOrder=Enum.SortOrder.LayoutOrder; li.Padding=UDim.new(0,9); li:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() p.CanvasSize=UDim2.new(0,0,0,li.AbsoluteContentSize.Y+10) end)
        UI.pages[d[1]]=p
    end

    local function showPage(key)
        UI.currentPage=key
        for k,p in pairs(UI.pages) do p.Visible=(k==key) end
        local m=UI.meta[key]; pageTitle.Text=m and m.label or key; pageDesc.Text=m and m.desc or ""
        applyTheme(UI.themeName)
        if key=="weapons" and UI.scanWeapons then task.defer(UI.scanWeapons) end
    end
    for i,d in ipairs(defs) do
        local b=Instance.new("TextButton",nav); b.LayoutOrder=i; b.Size=UDim2.new(1,-4,0,38); b.BorderSizePixel=0; b.Text="      "..d[2]; b.Font=Enum.Font.FredokaOne; b.TextSize=12; b.TextXAlignment=Enum.TextXAlignment.Left; b.AutoButtonColor=false; corner(b,11); stroke(b,"line",1,.3); reg(b,"panel")
        local p=img(b,A.Paw,UDim2.fromOffset(19,19),UDim2.fromOffset(10,9),5); table.insert(UI.imageTint,p)
        b.MouseButton1Click:Connect(function() showPage(d[1]) end)
        table.insert(UI.navButtons,{button=b,key=d[1],paw=p})
    end

    local function styleLegacyButton(b)
        if not b or not b.Parent then return end
        corner(b,9); local s=b:FindFirstChildOfClass("UIStroke"); if s then reg(s,"line") else stroke(b,"line",1,.35) end
        if b.Text=="" then
            local circle=b:FindFirstChildOfClass("Frame")
            if circle then
                local art=b:FindFirstChild("KimqV33ToggleArt")
                if not art then art=img(b,A.ToggleOff,UDim2.fromScale(1,1),UDim2.fromScale(0,0),8); art.Name="KimqV33ToggleArt" end
                local entry={button=b,circle=circle,art=art}; table.insert(UI.toggles,entry)
                b.MouseButton1Click:Connect(function() task.delay(.18,function() refreshToggle(entry) end) end)
                refreshToggle(entry); return
            end
        end
        if tostring(b.Text):upper()=="ON" or tostring(b.Text):upper()=="OFF" then
            local e={button=b}; table.insert(UI.statusToggles,e); b.MouseButton1Click:Connect(function() task.defer(function() refreshStatusToggle(e) end) end); refreshStatusToggle(e); return
        end
        local hot=tostring(b.Text):lower():find("apply") or tostring(b.Text):lower():find("save")
        reg(b,hot and "hotButton" or "softButton")
    end
    local function styleLegacyCard(obj)
        if not obj or not obj.Parent then return end
        if obj:IsA("Frame") then reg(obj,"panel"); corner(obj,11); local s=obj:FindFirstChildOfClass("UIStroke"); if s then reg(s,"line") else stroke(obj,"line",1,.28) end end
        if obj:IsA("ScrollingFrame") then obj.BackgroundTransparency=0; reg(obj,"panel"); reg(obj,"scroll"); corner(obj,10); local s=obj:FindFirstChildOfClass("UIStroke"); if s then reg(s,"line") else stroke(obj,"line",1,.28) end end
        for _,d in ipairs(obj:GetDescendants()) do
            if d:IsA("TextLabel") then d.Font=(d.TextSize>=16) and Enum.Font.FredokaOne or Enum.Font.GothamSemibold; reg(d,d.TextXAlignment==Enum.TextXAlignment.Right and "hot" or "text")
            elseif d:IsA("TextBox") then d.Font=Enum.Font.Gotham; reg(d,"soft"); reg(d,"text"); corner(d,8); local s=d:FindFirstChildOfClass("UIStroke"); if s then reg(s,"line") else stroke(d,"line",1,.35) end
            elseif d:IsA("TextButton") then styleLegacyButton(d)
            elseif d:IsA("UIStroke") then reg(d,"line")
            elseif d:IsA("Frame") and d~=obj then
                local h=d.Size.Y.Offset
                if h>0 and h<=10 then
                    if d.Parent and d.Parent:IsA("Frame") and d.Parent~=obj and d.Parent.Size.Y.Offset<=12 then reg(d,"hot") else reg(d,"soft2") end
                end
            end
        end
    end

    -- Route the original live controls into brand-new pages. Callbacks remain attached to the same instances.
    local sectionMap={
        ["silent aim"]="silent",["macro"]="macro",["whitelist"]="whitelist",["protection"]="protection",["anti fall"]="antifall",["delay changer"]="delay",["esp"]="esp",["avatar"]="avatar",
        ["combat"]="hcsilent",["force hit"]="forcehit",["hitbox expander"]="hitbox",["flamelock"]="flamelock",["camlock"]="camlock",["visuals"]="fog",["headless"]="headless",["protection + anti mod"]="antimod",["settings"]="settings",["credits"]="info"
    }
    local backendBin=Instance.new("Folder",gui); backendBin.Name="KimqV33BackendBin"
    local current="silent"
    local legacyChildren=oldScroll:GetChildren()
    for _,child in ipairs(legacyChildren) do
        if child:IsA("UIListLayout") or child:IsA("UIPadding") then
        elseif child:IsA("TextLabel") and tostring(child.Text):sub(1,1)=="♥" then
            local clean=tostring(child.Text):gsub("^♥%s*",""):lower():gsub("%s+"," ")
            current=sectionMap[clean] or current; child.Parent=backendBin; child.Visible=false
        elseif (child:IsA("Frame") or child:IsA("ScrollingFrame")) and UI.pages[current] then
            child.Parent=UI.pages[current]; styleLegacyCard(child)
        end
    end
    oldScroll.ChildAdded:Connect(function(ch)
        task.delay(.08,function()
            if ch and ch.Parent==oldScroll and ch:IsA("Frame") then ch.Parent=UI.pages.whitelist; styleLegacyCard(ch); applyTheme(UI.themeName) end
        end)
    end)

    -- Move the original dedicated fog picker into a centered wrapper without touching its functional internals.
    local fogPanel=oldMain:FindFirstChild("FogPanel")
    if fogPanel then
        local wrap=Instance.new("Frame",UI.pages.fog); wrap.Name="FogPickerWrap"; wrap.Size=UDim2.new(1,-6,0,586); wrap.BackgroundTransparency=1
        fogPanel.Parent=wrap; fogPanel.Size=UDim2.fromOffset(570,570); fogPanel.Position=UDim2.new(.5,-285,0,0); reg(fogPanel,"panel"); corner(fogPanel,14); local fs=fogPanel:FindFirstChildOfClass("UIStroke"); if fs then reg(fs,"line") end
        local square,hue,preview
        for _,d in ipairs(fogPanel:GetChildren()) do
            if d:IsA("Frame") and d.Size.X.Offset==300 and d.Size.Y.Offset==300 then square=d end
            if d:IsA("Frame") and d.Size.X.Offset==24 and d.Size.Y.Offset==300 then hue=d end
            if d:IsA("Frame") and d.Size.X.Offset==185 and d.Size.Y.Offset==58 then preview=d end
        end
        for _,d in ipairs(fogPanel:GetDescendants()) do
            local protected=(square and (d==square or d:IsDescendantOf(square))) or (hue and (d==hue or d:IsDescendantOf(hue))) or d==preview
            if d:IsA("TextLabel") then reg(d,"text"); d.Font=(d.TextSize>=16) and Enum.Font.FredokaOne or Enum.Font.GothamSemibold
            elseif d:IsA("TextBox") then reg(d,"soft"); reg(d,"text"); local s=d:FindFirstChildOfClass("UIStroke"); if s then reg(s,"line") end
            elseif d:IsA("TextButton") then reg(d,"softButton"); local s=d:FindFirstChildOfClass("UIStroke"); if s then reg(s,"line") end
            elseif d:IsA("UIStroke") and not protected then reg(d,"line")
            elseif d:IsA("Frame") and not protected then
                if d.Size.Y.Offset<=10 and d.Size.Y.Offset>0 then
                    if d.Parent and d.Parent:IsA("Frame") and d.Parent.Size.Y.Offset<=10 then reg(d,"hot") else reg(d,"soft2") end
                end
            end
        end
        local reset=fogPanel:FindFirstChildWhichIsA("TextButton",true)
        for _,b in ipairs(fogPanel:GetDescendants()) do if b:IsA("TextButton") and tostring(b.Text):lower()=="reset" then reset=b end end
        if reset and A.Reset then local ri=img(reset,A.Reset,UDim2.fromOffset(22,22),UDim2.fromOffset(8,6),7); reset.Text="       Reset"; table.insert(UI.imageTint,ri) end
    end

    oldMain.Visible=false

    -- Clean Overview; intentionally no giant banner.
    do
        local p=UI.pages.overview
        local welcome=Instance.new("Frame",p); welcome.Size=UDim2.new(1,-6,0,190); welcome.BorderSizePixel=0; reg(welcome,"panel"); corner(welcome,16); stroke(welcome,"line",1,.22)
        local icon=img(welcome,A.PompomIcon or A.Pompom,UDim2.fromOffset(120,120),UDim2.fromOffset(22,34),5); table.insert(UI.imageTint,icon)
        txt(welcome,"welcome, "..lp.DisplayName:lower().." ♡",UDim2.new(1,-180,0,36),UDim2.fromOffset(160,28),Enum.Font.FredokaOne,26,"text")
        txt(welcome,"@"..lp.Name.."   •   Kimqetras HC",UDim2.new(1,-190,0,22),UDim2.fromOffset(162,65),Enum.Font.GothamSemibold,11,"sub")
        local body=txt(welcome,"Everything is separated into its own feature page. The controls you already used are still the same live controls underneath this new interface.",UDim2.new(1,-190,0,55),UDim2.fromOffset(162,94),Enum.Font.Gotham,12,"text"); body.TextWrapped=true; body.TextYAlignment=Enum.TextYAlignment.Top
        txt(welcome,"Right Shift or Right Click = hide / show",UDim2.new(1,-190,0,24),UDim2.fromOffset(162,150),Enum.Font.GothamBold,11,"hot")
        local about=Instance.new("Frame",p); about.Size=UDim2.new(1,-6,0,132); about.BorderSizePixel=0; reg(about,"panel"); corner(about,16); stroke(about,"line",1,.22)
        local ap=img(about,A.Paw,UDim2.fromOffset(28,28),UDim2.fromOffset(16,12),5); table.insert(UI.imageTint,ap)
        txt(about,"about",UDim2.new(1,-60,0,30),UDim2.fromOffset(49,10),Enum.Font.FredokaOne,20,"hot")
        txt(about,"-  -  -  -  -  -  -",UDim2.new(0,180,0,16),UDim2.fromOffset(18,41),Enum.Font.GothamBold,8,"line")
        local ab=txt(about,"Every feature has its own clean page.\nSwitch between aiming, movement, visuals, avatar tools, seasonal environment, and weapon skins.\nPick a theme whenever you want the interface to match your style.",UDim2.new(1,-36,0,67),UDim2.fromOffset(18,57),Enum.Font.Gotham,11,"text"); ab.TextWrapped=true; ab.TextYAlignment=Enum.TextYAlignment.Top
    end

    -- Theme page.
    do
        local p=UI.pages.theme
        local box=Instance.new("Frame",p); box.Size=UDim2.new(1,-6,0,250); box.BorderSizePixel=0; reg(box,"panel"); corner(box,16); stroke(box,"line",1,.22)
        local paw=img(box,A.Paw,UDim2.fromOffset(28,28),UDim2.fromOffset(16,12),5); table.insert(UI.imageTint,paw)
        txt(box,"theme recolors",UDim2.new(1,-60,0,30),UDim2.fromOffset(50,10),Enum.Font.FredokaOne,20,"hot")
        txt(box,"The default is light blue + hot blue. Other themes recolor the cards, buttons, sliders, stitching, paws, and text.",UDim2.new(1,-36,0,42),UDim2.fromOffset(18,48),Enum.Font.Gotham,11,"sub")
        local names={"Blue","Purple","Pink","Red","Aqua","Green"}
        for i,n in ipairs(names) do
            local col=(i-1)%3; local row=math.floor((i-1)/3)
            local b=button(box,n,UDim2.new(0.31,-10,0,48),UDim2.new(.02+col*.325,0,0,105+row*60),false); UI.themeButtons[n]=b; b.MouseButton1Click:Connect(function() applyTheme(n) end)
        end
    end

    -- Information page.
    do
        local p=UI.pages.info
        local box=Instance.new("Frame",p); box.Size=UDim2.new(1,-6,0,180); box.BorderSizePixel=0; reg(box,"panel"); corner(box,16); stroke(box,"line",1,.22)
        local pm=img(box,A.PompomIcon or A.Pompom,UDim2.fromOffset(92,92),UDim2.fromOffset(20,45),5); table.insert(UI.imageTint,pm)
        txt(box,"Kimqetras HC",UDim2.new(1,-145,0,34),UDim2.fromOffset(130,25),Enum.Font.FredokaOne,24,"hot")
        txt(box,"original developer / scripter: famesgun",UDim2.new(1,-150,0,22),UDim2.fromOffset(132,65),Enum.Font.GothamSemibold,11,"text")
        txt(box,"Roblox profile: users/4246488996",UDim2.new(1,-150,0,22),UDim2.fromOffset(132,90),Enum.Font.Gotham,10,"sub")
        txt(box,"This rebuild keeps the existing live feature callbacks and replaces only the interface around them.",UDim2.new(1,-155,0,42),UDim2.fromOffset(132,120),Enum.Font.Gotham,10,"sub")
    end

    -- Proven local accessory visual weld, added to the Avatar page.
    do
        local p=UI.pages.avatar
        local box=Instance.new("Frame",p); box.Size=UDim2.new(1,-6,0,178); box.BorderSizePixel=0; reg(box,"panel"); corner(box,14); stroke(box,"line",1,.24)
        local paw=img(box,A.Paw,UDim2.fromOffset(25,25),UDim2.fromOffset(16,12),5); table.insert(UI.imageTint,paw)
        txt(box,"local accessory",UDim2.new(1,-55,0,28),UDim2.fromOffset(48,9),Enum.Font.FredokaOne,18,"hot")
        txt(box,"client-only hat / hair / face accessory try-on",UDim2.new(1,-32,0,20),UDim2.fromOffset(16,38),Enum.Font.Gotham,10,"sub")
        local input=Instance.new("TextBox",box); input.Size=UDim2.new(1,-32,0,34); input.Position=UDim2.fromOffset(16,66); input.PlaceholderText="accessory asset id"; input.Text=""; input.ClearTextOnFocus=false; input.Font=Enum.Font.Gotham; input.TextSize=12; input.TextXAlignment=Enum.TextXAlignment.Left; input.BorderSizePixel=0; corner(input,9); stroke(input,"line",1,.3); reg(input,"soft"); reg(input,"text"); local ip=Instance.new("UIPadding",input); ip.PaddingLeft=UDim.new(0,10)
        local equip=button(box,"Equip Accessory",UDim2.new(.68,-20,0,34),UDim2.fromOffset(16,111),true)
        local remove=button(box,"Remove All",UDim2.new(.32,-12,0,34),UDim2.new(.68,4,0,111),false)
        local stat=txt(box,"ready",UDim2.new(1,-32,0,18),UDim2.fromOffset(16,151),Enum.Font.Gotham,10,"sub")
        _G.KimqV33Accessories=_G.KimqV33Accessories or {}
        local wanted=_G.KimqV33Accessories
        local function clearOne(char)
            if not char then return end
            for _,d in ipairs(char:GetChildren()) do if d:GetAttribute("KimqV33Accessory") then d:Destroy() end end
        end
        local function attach(assetId,quiet)
            local char=lp.Character; if not char then return false end
            local ok,objects=pcall(function() return game:GetObjects("rbxassetid://"..tostring(assetId)) end); if not ok or not objects or not objects[1] then if not quiet then stat.Text="could not load that asset" end return false end
            local source=objects[1]; local acc=source:IsA("Accessory") and source or source:FindFirstChildWhichIsA("Accessory",true); if not acc then pcall(function() source:Destroy() end); if not quiet then stat.Text="that asset is not an accessory" end return false end
            if acc~=source then acc=acc:Clone(); source:Destroy() end
            for _,d in ipairs(acc:GetDescendants()) do if d:IsA("Script") or d:IsA("LocalScript") or d:IsA("ModuleScript") or d:IsA("JointInstance") then pcall(function() d:Destroy() end) elseif d:IsA("BasePart") then d.Anchored=false; d.CanCollide=false; d.CanTouch=false; d.CanQuery=false; d.Massless=true; d.AssemblyLinearVelocity=Vector3.zero; d.AssemblyAngularVelocity=Vector3.zero end end
            local handle=acc:FindFirstChild("Handle"); if not handle or not handle:IsA("BasePart") then acc:Destroy(); if not quiet then stat.Text="accessory has no Handle" end return false end
            local ha=handle:FindFirstChildWhichIsA("Attachment"); local bodyAtt,bodyPart
            if ha then for _,d in ipairs(char:GetDescendants()) do if d:IsA("Attachment") and d.Name==ha.Name and d.Parent:IsA("BasePart") then bodyAtt=d; bodyPart=d.Parent; break end end end
            if not bodyAtt then bodyPart=char:FindFirstChild("Head"); bodyAtt=bodyPart and bodyPart:FindFirstChild("HatAttachment") end
            if not bodyPart then acc:Destroy(); if not quiet then stat.Text="could not find a body attachment" end return false end
            acc:SetAttribute("KimqV33Accessory",true); acc:SetAttribute("KimqAssetId",tostring(assetId)); acc.Parent=char
            if ha and bodyAtt then handle.CFrame=bodyPart.CFrame*bodyAtt.CFrame*ha.CFrame:Inverse() else handle.CFrame=bodyPart.CFrame end
            local weld=Instance.new("Weld",handle); weld.Name="KimqV33AccessoryWeld"; weld.Part0=bodyPart; weld.Part1=handle; if ha and bodyAtt then weld.C0=bodyAtt.CFrame; weld.C1=ha.CFrame end
            if not quiet then stat.Text="equipped locally ♡" end; return true
        end
        equip.MouseButton1Click:Connect(function() local id=tonumber(input.Text); if not id then stat.Text="enter a valid asset id" return end; if attach(id,false) then wanted[tostring(id)]=true end end)
        remove.MouseButton1Click:Connect(function() table.clear(wanted); clearOne(lp.Character); stat.Text="removed" end)
        lp.CharacterAdded:Connect(function(char) task.delay(1,function() for id in pairs(wanted) do attach(tonumber(id),true) end end) end)
    end

    -- Environment: restores only the properties it changes; fog stays fully editable.
    do
        local p=UI.pages.environment
        local box=Instance.new("Frame",p); box.Size=UDim2.new(1,-6,0,330); box.BorderSizePixel=0; reg(box,"panel"); corner(box,16); stroke(box,"line",1,.22)
        local paw=img(box,A.Paw,UDim2.fromOffset(28,28),UDim2.fromOffset(16,12),5); table.insert(UI.imageTint,paw)
        txt(box,"seasonal environment",UDim2.new(1,-60,0,30),UDim2.fromOffset(50,10),Enum.Font.FredokaOne,20,"hot")
        txt(box,"Changes grass/ground + normal lighting only. Your Fog / Atmosphere page stays in control of fog.",UDim2.new(1,-36,0,38),UDim2.fromOffset(18,46),Enum.Font.Gotham,10,"sub")
        local normal=button(box,"Normal",UDim2.new(.31,-8,0,48),UDim2.new(.02,0,0,94),false)
        local christmas=button(box,"Christmas",UDim2.new(.31,-8,0,48),UDim2.new(.345,0,0,94),false)
        local halloween=button(box,"Halloween",UDim2.new(.31,-8,0,48),UDim2.new(.67,0,0,94),false)
        local stat=txt(box,"Environment: Normal",UDim2.new(1,-36,0,22),UDim2.fromOffset(18,154),Enum.Font.GothamSemibold,11,"hot")
        local desc=txt(box,"Normal restores the map exactly as it was when V33 loaded.",UDim2.new(1,-36,0,48),UDim2.fromOffset(18,184),Enum.Font.Gotham,10,"sub"); desc.TextWrapped=true
        local resetIcon=img(normal,A.Reset,UDim2.fromOffset(21,21),UDim2.fromOffset(13,13),6); normal.Text="        Normal"; table.insert(UI.imageTint,resetIcon)
        local props={"Ambient","OutdoorAmbient","Brightness","ClockTime","ExposureCompensation","ColorShift_Top","ColorShift_Bottom","EnvironmentDiffuseScale","EnvironmentSpecularScale","ShadowSoftness"}
        local originalLighting={}; for _,k in ipairs(props) do pcall(function() originalLighting[k]=Lighting[k] end) end
        local Terrain=workspace:FindFirstChildOfClass("Terrain"); local originalGrass; if Terrain then pcall(function() originalGrass=Terrain:GetMaterialColor(Enum.Material.Grass) end) end
        local savedParts=setmetatable({},{__mode="k"}); local currentSeason="Normal"; local snowPart
        local function isCharacterPart(part)
            local m=part:FindFirstAncestorOfClass("Model"); return m and Players:GetPlayerFromCharacter(m)~=nil
        end
        local function groundPart(part)
            if not part:IsA("BasePart") or isCharacterPart(part) then return false end
            local n=part.Name:lower(); if part.Material==Enum.Material.Grass or n:find("grass") or n:find("ground") or n:find("lawn") then return true end
            local c=part.Color; local flat=part.Size.X>=8 and part.Size.Z>=8 and part.Size.Y<=math.max(part.Size.X,part.Size.Z)*.35
            return flat and part.CanCollide and c.G>c.R*1.08 and c.G>c.B*1.05
        end
        local function saveGround()
            for _,d in ipairs(workspace:GetDescendants()) do if d:IsA("BasePart") and groundPart(d) and not savedParts[d] then savedParts[d]={Color=d.Color,Material=d.Material} end end
        end
        local function removeSnow() if snowPart then pcall(function() snowPart:Destroy() end); snowPart=nil end end
        local function addSnow()
            removeSnow(); local char=lp.Character; local root=char and char:FindFirstChild("HumanoidRootPart"); if not root then return end
            local part=Instance.new("Part"); part.Name="KimqV33Snow"; part.Size=Vector3.new(1,1,1); part.Transparency=1; part.CanCollide=false; part.CanTouch=false; part.CanQuery=false; part.Massless=true; part.CFrame=root.CFrame*CFrame.new(0,19,0); part.Parent=char
            local w=Instance.new("WeldConstraint",part); w.Part0=root; w.Part1=part
            local function emitter(rate,size,speed,life,texture)
                local e=Instance.new("ParticleEmitter",part); e.Texture=texture; e.Rate=rate; e.Lifetime=NumberRange.new(life[1],life[2]); e.Speed=NumberRange.new(speed[1],speed[2]); e.EmissionDirection=Enum.NormalId.Bottom; e.SpreadAngle=Vector2.new(70,70); e.Acceleration=Vector3.new(0,-4,0); e.Rotation=NumberRange.new(0,360); e.RotSpeed=NumberRange.new(-45,45); e.Size=NumberSequence.new({NumberSequenceKeypoint.new(0,size[1]),NumberSequenceKeypoint.new(1,size[2])}); e.Color=ColorSequence.new(Color3.fromRGB(245,251,255)); e.LightInfluence=0; return e
            end
            emitter(95,{.16,.11},{7,11},{3.5,5},"rbxasset://textures/particles/smoke_main.dds")
            emitter(35,{.10,.05},{5,8},{4,6},"rbxasset://textures/particles/sparkles_main.dds")
            snowPart=part
        end
        local function restore()
            removeSnow(); for k,v in pairs(originalLighting) do pcall(function() Lighting[k]=v end) end
            if Terrain and originalGrass then pcall(function() Terrain:SetMaterialColor(Enum.Material.Grass,originalGrass) end) end
            for part,data in pairs(savedParts) do if part and part.Parent then pcall(function() part.Color=data.Color; part.Material=data.Material end) end end
            currentSeason="Normal"; stat.Text="Environment: Normal"; desc.Text="Normal restored the original ground and lighting. Fog remains whatever you set on Fog / Atmosphere."
        end
        local function christmasMode()
            restore(); saveGround(); currentSeason="Christmas"
            if Terrain then pcall(function() Terrain:SetMaterialColor(Enum.Material.Grass,Color3.fromRGB(224,239,250)) end) end
            for part in pairs(savedParts) do if part and part.Parent then pcall(function() part.Color=Color3.fromRGB(226,239,248); part.Material=Enum.Material.Snow end) end end
            pcall(function() Lighting.ClockTime=13.4; Lighting.Brightness=2.25; Lighting.ExposureCompensation=.08; Lighting.Ambient=Color3.fromRGB(155,177,204); Lighting.OutdoorAmbient=Color3.fromRGB(180,204,226); Lighting.ColorShift_Top=Color3.fromRGB(218,238,255); Lighting.ColorShift_Bottom=Color3.fromRGB(201,221,242); Lighting.ShadowSoftness=.55 end)
            addSnow(); stat.Text="Environment: Christmas"; desc.Text="Bright icy winter lighting, snowy ground, and two softer layers of local falling snow. Fog is still fully editable."
        end
        local function halloweenMode()
            restore(); saveGround(); currentSeason="Halloween"
            if Terrain then pcall(function() Terrain:SetMaterialColor(Enum.Material.Grass,Color3.fromRGB(154,101,52)) end) end
            for part,data in pairs(savedParts) do if part and part.Parent then pcall(function() part.Color=data.Color:Lerp(Color3.fromRGB(183,92,47),.62) end) end
            pcall(function() Lighting.ClockTime=17.2; Lighting.Brightness=2.0; Lighting.ExposureCompensation=.05; Lighting.Ambient=Color3.fromRGB(151,108,119); Lighting.OutdoorAmbient=Color3.fromRGB(178,126,102); Lighting.ColorShift_Top=Color3.fromRGB(255,173,115); Lighting.ColorShift_Bottom=Color3.fromRGB(160,94,107); Lighting.ShadowSoftness=.72 end)
            stat.Text="Environment: Halloween"; desc.Text="Cute warm autumn lighting and orange/brown grass — spooky without making the map super dark. No pumpkins. Fog is still yours to change."
        end
        normal.MouseButton1Click:Connect(restore); christmas.MouseButton1Click:Connect(christmasMode); halloween.MouseButton1Click:Connect(halloweenMode)
        lp.CharacterAdded:Connect(function() if currentSeason=="Christmas" then task.delay(1,addSnow) end end)
        _G.KimqV33Environment={Normal=restore,Christmas=christmasMode,Halloween=halloweenMode}
    end

    -- Weapon skins: dynamic weapon list, dynamic skin list, whole-model visuals, attachment-aware alignment, and persistent reapply.
    do
        local p=UI.pages.weapons
        local intro=Instance.new("Frame",p); intro.Size=UDim2.new(1,-6,0,64); intro.BorderSizePixel=0; reg(intro,"panel"); corner(intro,14); stroke(intro,"line",1,.22)
        local ipaw=img(intro,A.Paw,UDim2.fromOffset(26,26),UDim2.fromOffset(16,12),5); table.insert(UI.imageTint,ipaw)
        txt(intro,"weapon skins",UDim2.new(1,-60,0,28),UDim2.fromOffset(49,8),Enum.Font.FredokaOne,19,"hot")
        txt(intro,"pick your weapon → pick one of its own skins → apply locally",UDim2.new(1,-32,0,20),UDim2.fromOffset(16,38),Enum.Font.Gotham,10,"sub")
        local row=Instance.new("Frame",p); row.Size=UDim2.new(1,-6,0,342); row.BackgroundTransparency=1
        local left=Instance.new("Frame",row); left.Size=UDim2.new(.34,-5,1,0); left.BorderSizePixel=0; reg(left,"panel"); corner(left,14); stroke(left,"line",1,.22)
        local right=Instance.new("Frame",row); right.Size=UDim2.new(.66,-5,1,0); right.Position=UDim2.new(.34,10,0,0); right.BorderSizePixel=0; reg(right,"panel"); corner(right,14); stroke(right,"line",1,.22)
        txt(left,"Weapon",UDim2.new(1,-100,0,24),UDim2.fromOffset(12,9),Enum.Font.FredokaOne,16,"text")
        local refresh=button(left,"refresh",UDim2.fromOffset(76,27),UDim2.new(1,-88,0,7),false)
        local weapons=Instance.new("ScrollingFrame",left); weapons.Size=UDim2.new(1,-18,1,-48); weapons.Position=UDim2.fromOffset(9,40); weapons.BackgroundTransparency=1; weapons.BorderSizePixel=0; weapons.ScrollBarThickness=3; reg(weapons,"scroll"); local wl=Instance.new("UIListLayout",weapons); wl.Padding=UDim.new(0,7); wl:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() weapons.CanvasSize=UDim2.new(0,0,0,wl.AbsoluteContentSize.Y+6) end)
        txt(right,"Skins",UDim2.fromOffset(90,24),UDim2.fromOffset(12,9),Enum.Font.FredokaOne,16,"text")
        local chosen=txt(right,"pick a weapon",UDim2.new(1,-120,0,22),UDim2.fromOffset(105,9),Enum.Font.Gotham,10,"sub",Enum.TextXAlignment.Right)
        local search=Instance.new("TextBox",right); search.Size=UDim2.new(1,-20,0,32); search.Position=UDim2.fromOffset(10,39); search.PlaceholderText="search skins..."; search.Text=""; search.ClearTextOnFocus=false; search.Font=Enum.Font.Gotham; search.TextSize=11; search.TextXAlignment=Enum.TextXAlignment.Left; search.BorderSizePixel=0; corner(search,9); stroke(search,"line",1,.3); reg(search,"soft"); reg(search,"text"); local sp=Instance.new("UIPadding",search); sp.PaddingLeft=UDim.new(0,10)
        local skins=Instance.new("ScrollingFrame",right); skins.Size=UDim2.new(1,-18,1,-84); skins.Position=UDim2.fromOffset(9,77); skins.BackgroundTransparency=1; skins.BorderSizePixel=0; skins.ScrollBarThickness=3; reg(skins,"scroll"); local sl=Instance.new("UIListLayout",skins); sl.Padding=UDim.new(0,7); sl:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() skins.CanvasSize=UDim2.new(0,0,0,sl.AbsoluteContentSize.Y+6) end)
        local actions=Instance.new("Frame",p); actions.Size=UDim2.new(1,-6,0,58); actions.BorderSizePixel=0; reg(actions,"panel"); corner(actions,14); stroke(actions,"line",1,.22)
        local apply=button(actions,"Apply Skin",UDim2.new(.66,-12,0,36),UDim2.new(0,10,.5,-18),true)
        local reset=button(actions,"        Reset",UDim2.new(.34,-12,0,36),UDim2.new(.66,2,.5,-18),false); local rimg=img(reset,A.Reset,UDim2.fromOffset(22,22),UDim2.fromOffset(14,7),6); table.insert(UI.imageTint,rimg)
        local status=txt(p,"finding your weapon folders...",UDim2.new(1,-12,0,24),UDim2.fromOffset(6,0),Enum.Font.Gotham,10,"sub")
        _G.KimqV33WeaponSkins=_G.KimqV33WeaponSkins or {Selected={}}; local selected=_G.KimqV33WeaponSkins.Selected
        local state={folders={},weaponButtons={},skinButtons={}}
        local function key(s) return tostring(s or ""):lower():gsub("[^%w]","") end
        local function display(s) return tostring(s or ""):gsub("%[",""):gsub("%]","") end
        local function setStatus(t,good) status.Text=t; status.TextColor3=good and UI.T.hot or UI.T.sub end
        local function locateWraps()
            local arr={}; local function scanRoot(root) if not root then return end; local d=root:FindFirstChild("Wraps"); if d then table.insert(arr,d) end; for _,x in ipairs(root:GetDescendants()) do if x.Name=="Wraps" then table.insert(arr,x) end end end; scanRoot(workspace); scanRoot(ReplicatedStorage); table.sort(arr,function(a,b) return #a:GetChildren()>#b:GetChildren() end); return arr[1]
        end
        local function firstPart(o)
            if not o then return end; if o:IsA("BasePart") then return o end; local h=o:FindFirstChild("Handle",true); if h and h:IsA("BasePart") then return h end; if o:IsA("Model") and o.PrimaryPart then return o.PrimaryPart end; local best; for _,d in ipairs(o:GetDescendants()) do if d:IsA("BasePart") and (not best or d.Size.Magnitude>best.Size.Magnitude) then best=d end end; return best
        end
        local function findTool(name)
            local char,bp=lp.Character,lp:FindFirstChildOfClass("Backpack"); local e=(char and char:FindFirstChild(name)) or (bp and bp:FindFirstChild(name)); if e then return e end; local k=key(name); for _,c in ipairs({char,bp}) do if c then for _,t in ipairs(c:GetChildren()) do if t:IsA("Tool") and key(t.Name)==k then return t end end end end
        end
        local function commonAttachment(srcRoot,targetRoot)
            local map={}; for _,a in ipairs(targetRoot:GetDescendants()) do if a:IsA("Attachment") then map[a.Name]=a end end; for _,a in ipairs(srcRoot:GetDescendants()) do if a:IsA("Attachment") and map[a.Name] then return a,map[a.Name] end end
        end
        local function clear(tool)
            if not tool then return end
            for _,d in ipairs(tool:GetDescendants()) do if d.Name=="KimqV33SkinVisual" or d.Name=="KimqV29SkinVisual" or d.Name=="KimqV28SkinVisual" then pcall(function() d:Destroy() end) end end
            for _,d in ipairs(tool:GetDescendants()) do if d:IsA("BasePart") then local v=d:GetAttribute("KimqV33OriginalLTM"); if type(v)=="number" then pcall(function() d.LocalTransparencyModifier=v; d:SetAttribute("KimqV33OriginalLTM",nil) end) end end end
        end
        local function cloneSource(source)
            local old=source.Archivable; pcall(function() source.Archivable=true end); local ok,c=pcall(function() return source:Clone() end); pcall(function() source.Archivable=old end); if ok then return c end
        end
        local function applyVisual(w,s,tool,quiet)
            local wf=state.folders[w]; local source=wf and wf:FindFirstChild(s); if not source then if not quiet then setStatus("That skin is no longer available",false) end return false end
            local gun=tool or findTool(w); if not gun then selected[w]=s; if not quiet then setStatus(display(w).." saved • it will apply when you equip it",true) end return true end
            local target=gun:FindFirstChild("Handle",true); if not target or not target:IsA("BasePart") then target=firstPart(gun) end; if not target then if not quiet then setStatus("This weapon has no usable visual anchor",false) end return false end
            local clone=cloneSource(source); if not clone then if not quiet then setStatus("That skin could not be cloned",false) end return false end
            clear(gun); local wrapper=Instance.new("Model",gun); wrapper.Name="KimqV33SkinVisual"; clone.Parent=wrapper
            for _,d in ipairs(wrapper:GetDescendants()) do if d:IsA("Script") or d:IsA("LocalScript") or d:IsA("ModuleScript") or d:IsA("JointInstance") or d:IsA("Constraint") then pcall(function() d:Destroy() end) end end
            local anchor=firstPart(clone); if not anchor then wrapper:Destroy(); return false end
            local parts={}; if clone:IsA("BasePart") then table.insert(parts,clone) end; for _,d in ipairs(wrapper:GetDescendants()) do if d:IsA("BasePart") and d~=clone then table.insert(parts,d) end end; if #parts==0 then wrapper:Destroy(); return false end
            local srcAtt,tgtAtt=commonAttachment(clone,gun); local delta
            if srcAtt and tgtAtt and srcAtt.Parent:IsA("BasePart") and tgtAtt.Parent:IsA("BasePart") then
                local srcWorld=srcAtt.Parent.CFrame*srcAtt.CFrame; local tgtWorld=tgtAtt.Parent.CFrame*tgtAtt.CFrame; delta=tgtWorld*srcWorld:Inverse()
            else delta=target.CFrame*anchor.CFrame:Inverse() end
            for _,part in ipairs(parts) do part.Anchored=false; part.CanCollide=false; part.CanTouch=false; part.CanQuery=false; part.Massless=true; part.AssemblyLinearVelocity=Vector3.zero; part.AssemblyAngularVelocity=Vector3.zero; part.CFrame=delta*part.CFrame end
            for _,part in ipairs(parts) do local wld=Instance.new("WeldConstraint",part); wld.Name="KimqV33SkinWeld"; wld.Part0=target; wld.Part1=part end
            for _,d in ipairs(gun:GetDescendants()) do if d:IsA("BasePart") and not d:IsDescendantOf(wrapper) then if d:GetAttribute("KimqV33OriginalLTM")==nil then d:SetAttribute("KimqV33OriginalLTM",d.LocalTransparencyModifier) end; d.LocalTransparencyModifier=1 end end
            selected[w]=s; if not quiet then setStatus(display(w).." • "..s.." applied locally",true) end; return true
        end
        local function listButton(parent,text)
            local b=button(parent,text,UDim2.new(1,-5,0,35),UDim2.fromOffset(0,0),false); b.TextXAlignment=Enum.TextXAlignment.Left; local pd=Instance.new("UIPadding",b); pd.PaddingLeft=UDim.new(0,10); return b
        end
        local function styleLists()
            for n,b in pairs(state.weaponButtons) do local on=n==state.weapon; b.BackgroundColor3=on and UI.T.hot or UI.T.soft; b.TextColor3=on and UI.T.white or UI.T.text end
            for n,b in pairs(state.skinButtons) do local on=n==state.skin; b.BackgroundColor3=on and UI.T.hot or UI.T.soft; b.TextColor3=on and UI.T.white or UI.T.text end
        end
        local function buildSkins()
            for _,c in ipairs(skins:GetChildren()) do if c:IsA("TextButton") then c:Destroy() end end; state.skinButtons={}
            local wf=state.weapon and state.folders[state.weapon]; if not wf then chosen.Text="pick a weapon"; return end
            local q=search.Text:lower(); local arr={}; for _,s in ipairs(wf:GetChildren()) do if firstPart(s) and (q=="" or s.Name:lower():find(q,1,true)) then table.insert(arr,s) end end; table.sort(arr,function(a,b) return a.Name:lower()<b.Name:lower() end)
            state.skin=selected[state.weapon]; chosen.Text=state.skin and ("selected: "..state.skin) or display(state.weapon)
            for i,s in ipairs(arr) do local b=listButton(skins,s.Name); b.LayoutOrder=i; state.skinButtons[s.Name]=b; b.MouseButton1Click:Connect(function() state.skin=s.Name; chosen.Text="selected: "..s.Name; styleLists(); setStatus("Selected "..s.Name.." • press Apply Skin",true) end) end
            styleLists(); setStatus(#arr>0 and ("Found "..#arr.." skins for "..display(state.weapon)) or ("No skins found for "..display(state.weapon)),#arr>0)
        end
        local function scanWeapons()
            for _,c in ipairs(weapons:GetChildren()) do if c:IsA("TextButton") then c:Destroy() end end; state.folders={}; state.weaponButtons={}
            local root=locateWraps(); if not root then setStatus("Could not find Workspace.Wraps yet • press refresh",false); return end
            local owned={}; for _,container in ipairs({lp.Character,lp:FindFirstChildOfClass("Backpack")}) do if container then for _,t in ipairs(container:GetChildren()) do if t:IsA("Tool") then owned[key(t.Name)]=true end end end end
            local arr={}; for _,wf in ipairs(root:GetChildren()) do if (wf:IsA("Folder") or wf:IsA("Model")) and #wf:GetChildren()>0 then state.folders[wf.Name]=wf; table.insert(arr,wf) end end
            table.sort(arr,function(a,b) local ao=owned[key(a.Name)] and 0 or 1; local bo=owned[key(b.Name)] and 0 or 1; if ao~=bo then return ao<bo end return a.Name:lower()<b.Name:lower() end)
            for i,wf in ipairs(arr) do local b=listButton(weapons,display(wf.Name)); b.LayoutOrder=i; state.weaponButtons[wf.Name]=b; b.MouseButton1Click:Connect(function() state.weapon=wf.Name; state.skin=selected[state.weapon]; styleLists(); buildSkins() end) end
            if #arr==0 then setStatus("Wraps exists but contains no weapon folders",false); return end
            if not state.weapon or not state.folders[state.weapon] then state.weapon=arr[1].Name end; styleLists(); buildSkins()
        end
        refresh.MouseButton1Click:Connect(scanWeapons); search:GetPropertyChangedSignal("Text"):Connect(function() task.defer(buildSkins) end)
        apply.MouseButton1Click:Connect(function() if not state.weapon then setStatus("Choose a weapon first",false) elseif not state.skin then setStatus("Choose a skin first",false) else applyVisual(state.weapon,state.skin,nil,false) end end)
        reset.MouseButton1Click:Connect(function() if state.weapon then selected[state.weapon]=nil; clear(findTool(state.weapon)); state.skin=nil; chosen.Text=display(state.weapon); styleLists(); setStatus(display(state.weapon).." reset",true) end end)
        local function selectedForTool(name) if selected[name] then return name,selected[name] end; local k=key(name); for w,s in pairs(selected) do if key(w)==k then return w,s end end end
        local function hookContainer(c)
            if not c or c:GetAttribute("KimqV33WeaponHook") then return end; c:SetAttribute("KimqV33WeaponHook",true)
            c.ChildAdded:Connect(function(t) if t:IsA("Tool") then local w,s=selectedForTool(t.Name); if w and s then task.delay(.2,function() applyVisual(w,s,t,true) end) end end end)
            for _,t in ipairs(c:GetChildren()) do if t:IsA("Tool") then t.Equipped:Connect(function() local w,s=selectedForTool(t.Name); if w and s then task.delay(.12,function() applyVisual(w,s,t,true) end) end end) end end
        end
        hookContainer(lp:FindFirstChildOfClass("Backpack")); if lp.Character then hookContainer(lp.Character) end
        lp.CharacterAdded:Connect(function(c) hookContainer(c); task.delay(1,function() hookContainer(lp:FindFirstChildOfClass("Backpack")); scanWeapons() end) end)
        UI.scanWeapons=scanWeapons; scanWeapons()
    end

    -- Hide / show controls + cute reopen button.
    local reopen=Instance.new("ImageButton",gui); reopen.Name="KimqV33Reopen"; reopen.AnchorPoint=Vector2.new(.5,1); reopen.Position=UDim2.new(.5,0,1,-18); reopen.Size=UDim2.fromOffset(66,66); reopen.BackgroundTransparency=1; reopen.Image=A.PompomIcon or A.Pompom; reopen.ScaleType=Enum.ScaleType.Fit; reopen.Visible=false; table.insert(UI.imageTint,reopen)
    local shown=true
    local function setShown(v) shown=v; main.Visible=v; reopen.Visible=not v end
    minBtn.MouseButton1Click:Connect(function() setShown(false) end); xBtn.MouseButton1Click:Connect(function() setShown(false) end); reopen.MouseButton1Click:Connect(function() setShown(true) end)
    UIS.InputBegan:Connect(function(input,processed)
        if input.KeyCode==Enum.KeyCode.RightShift or input.UserInputType==Enum.UserInputType.MouseButton2 then setShown(not shown) end
    end)

    -- Drag only from the header, not from the controls.
    local dragging=false; local dragStart,startPos,dragInput
    header.InputBegan:Connect(function(input) if input.UserInputType==Enum.UserInputType.MouseButton1 then dragging=true; dragStart=input.Position; startPos=main.Position; input.Changed:Connect(function() if input.UserInputState==Enum.UserInputState.End then dragging=false end end) end end)
    header.InputChanged:Connect(function(input) if input.UserInputType==Enum.UserInputType.MouseMovement then dragInput=input end end)
    UIS.InputChanged:Connect(function(input) if input==dragInput and dragging then local d=input.Position-dragStart; main.Position=UDim2.new(startPos.X.Scale,startPos.X.Offset+d.X,startPos.Y.Scale,startPos.Y.Offset+d.Y) end end)

    applyTheme("Blue"); showPage("overview")
    pcall(function() ContentProvider:PreloadAsync({pom,logo,subLogo,minImg,xImg,sidePaw,headPaw,reopen}) end)

    _G.KimqV33Ready=true
    local loader=_G.KimqV33Loader
    if loader and loader.Gui and loader.Gui.Parent then
        if loader.Status then loader.Status.Text="ready ♡" end
        if loader.Bar then TweenService:Create(loader.Bar,TweenInfo.new(.20,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{Size=UDim2.new(1,0,1,0)}):Play() end
        task.wait(.25)
        TweenService:Create(loader.Bg,TweenInfo.new(.28),{BackgroundTransparency=1}):Play()
        TweenService:Create(loader.Card,TweenInfo.new(.25),{BackgroundTransparency=1}):Play()
        task.wait(.30); pcall(function() loader.Gui:Destroy() end)
    end
end)

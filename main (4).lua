-- Kimqetras HC V31: short Roblox-asset loading cover.
do
    _G.KimqV31Ready = false
    local Players = game:GetService("Players")
    local CoreGui = game:GetService("CoreGui")
    local TweenService = game:GetService("TweenService")
    local ContentProvider = game:GetService("ContentProvider")
    local lp = Players.LocalPlayer
    local pg = lp:WaitForChild("PlayerGui")

    local ASSET = {
        Pompom = "rbxassetid://98379642851874",
        PompomIcon = "rbxassetid://109428653544528",
        Paw = "rbxassetid://138088505213748",
        Title = "rbxassetid://99152748483206",
        Subtitle = "rbxassetid://94248590271491",
        Minus = "rbxassetid://121030051960124",
        X = "rbxassetid://129350478207195",
        ToggleOn = "rbxassetid://95234565377817",
        ToggleOff = "rbxassetid://97764595221865",
        Reset = "rbxassetid://104585185562435",
    }
    _G.KimqV31Assets = ASSET

    pcall(function()
        for _,root in ipairs({CoreGui,pg}) do
            local old = root:FindFirstChild("KimqV31Loader")
            if old then old:Destroy() end
        end
    end)

    local gui = Instance.new("ScreenGui")
    gui.Name = "KimqV31Loader"
    gui.IgnoreGuiInset = true
    gui.ResetOnSpawn = false
    gui.DisplayOrder = 9000000
    pcall(function() gui.Parent = CoreGui end)
    if not gui.Parent then gui.Parent = pg end

    local bg = Instance.new("Frame", gui)
    bg.Size = UDim2.fromScale(1,1)
    bg.BackgroundColor3 = Color3.fromRGB(205,228,255)
    bg.BorderSizePixel = 0
    local bgGrad = Instance.new("UIGradient", bg)
    bgGrad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(237,247,255)),
        ColorSequenceKeypoint.new(.55, Color3.fromRGB(202,228,255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(162,203,255)),
    })
    bgGrad.Rotation = 18

    local function corner(o,r)
        local c=Instance.new("UICorner",o); c.CornerRadius=UDim.new(0,r); return c
    end
    local function stroke(o,c,t,w)
        local s=Instance.new("UIStroke",o); s.Color=c; s.Transparency=t or 0; s.Thickness=w or 1; return s
    end
    local function label(p,t,size,pos,font,sz,col,align)
        local x=Instance.new("TextLabel",p); x.BackgroundTransparency=1; x.Size=size; x.Position=pos; x.Text=t; x.Font=font; x.TextSize=sz; x.TextColor3=col; x.TextXAlignment=align or Enum.TextXAlignment.Left; x.TextYAlignment=Enum.TextYAlignment.Center; return x
    end
    local function image(p,id,size,pos,z)
        local x=Instance.new("ImageLabel",p); x.BackgroundTransparency=1; x.Image=id; x.Size=size; x.Position=pos; x.ScaleType=Enum.ScaleType.Fit; x.ZIndex=z or 3; return x
    end

    local card = Instance.new("Frame", bg)
    card.AnchorPoint = Vector2.new(.5,.5)
    card.Position = UDim2.fromScale(.5,.5)
    card.Size = UDim2.fromOffset(720,430)
    card.BackgroundColor3 = Color3.fromRGB(247,251,255)
    card.BorderSizePixel = 0
    corner(card,28)
    stroke(card,Color3.fromRGB(47,105,245),.10,2)

    local stitch = Instance.new("Frame", card)
    stitch.BackgroundTransparency = 1
    stitch.Position = UDim2.fromOffset(16,16)
    stitch.Size = UDim2.new(1,-32,1,-32)
    for i=0,28 do
        for _,yy in ipairs({0,1}) do
            local d=Instance.new("Frame",stitch); d.AnchorPoint=Vector2.new(.5,.5); d.Size=UDim2.fromOffset(12,2); d.Position=UDim2.new(i/28,0,yy,0); d.BackgroundColor3=Color3.fromRGB(83,139,242); d.BackgroundTransparency=.34; d.BorderSizePixel=0; corner(d,2)
        end
    end
    for i=0,16 do
        for _,xx in ipairs({0,1}) do
            local d=Instance.new("Frame",stitch); d.AnchorPoint=Vector2.new(.5,.5); d.Size=UDim2.fromOffset(2,12); d.Position=UDim2.new(xx,0,i/16,0); d.BackgroundColor3=Color3.fromRGB(83,139,242); d.BackgroundTransparency=.34; d.BorderSizePixel=0; corner(d,2)
        end
    end

    local mascot = image(card,ASSET.Pompom,UDim2.fromOffset(116,116),UDim2.fromOffset(56,38),6)
    local title = image(card,ASSET.Title,UDim2.fromOffset(390,88),UDim2.fromOffset(170,44),6)
    local subtitle = image(card,ASSET.Subtitle,UDim2.fromOffset(205,48),UDim2.fromOffset(264,112),6)
    local pawL = image(card,ASSET.Paw,UDim2.fromOffset(38,38),UDim2.fromOffset(28,360),6)
    local pawR = image(card,ASSET.Paw,UDim2.fromOffset(38,38),UDim2.new(1,-66,0,360),6)

    label(card,"-  -  -  -  -  -  -  -  -  -  -  -",UDim2.new(1,-100,0,18),UDim2.fromOffset(50,168),Enum.Font.GothamBold,11,Color3.fromRGB(108,160,235),Enum.TextXAlignment.Center)
    local status = label(card,"loading, please wait...",UDim2.new(1,-90,0,34),UDim2.fromOffset(45,197),Enum.Font.FredokaOne,22,Color3.fromRGB(55,103,205),Enum.TextXAlignment.Center)

    local track = Instance.new("Frame",card)
    track.Size=UDim2.new(1,-150,0,28); track.Position=UDim2.fromOffset(75,245); track.BackgroundColor3=Color3.fromRGB(218,235,255); track.BorderSizePixel=0; corner(track,999); stroke(track,Color3.fromRGB(129,174,237),.26,1)
    local fill=Instance.new("Frame",track); fill.Size=UDim2.new(.05,0,1,0); fill.BackgroundColor3=Color3.fromRGB(36,92,248); fill.BorderSizePixel=0; corner(fill,999)
    local fg=Instance.new("UIGradient",fill); fg.Color=ColorSequence.new(Color3.fromRGB(92,164,255),Color3.fromRGB(36,87,247)); fg.Rotation=0
    local pct=label(card,"5%",UDim2.fromOffset(70,28),UDim2.new(1,-133,0,245),Enum.Font.FredokaOne,18,Color3.fromRGB(44,96,222),Enum.TextXAlignment.Right)

    local info = Instance.new("Frame",card)
    info.Size=UDim2.new(1,-150,0,58); info.Position=UDim2.fromOffset(75,294); info.BackgroundColor3=Color3.fromRGB(239,247,255); info.BorderSizePixel=0; corner(info,15); stroke(info,Color3.fromRGB(151,192,238),.38,1)
    image(info,ASSET.Paw,UDim2.fromOffset(25,25),UDim2.fromOffset(18,16),4)
    label(info,"clean   •   powerful   •   safe   •   cute",UDim2.new(1,-58,1,0),UDim2.fromOffset(50,0),Enum.Font.FredokaOne,15,Color3.fromRGB(59,109,208),Enum.TextXAlignment.Center)

    local made = Instance.new("Frame",card)
    made.Size=UDim2.fromOffset(210,38); made.Position=UDim2.new(.5,-105,1,-56); made.BackgroundColor3=Color3.fromRGB(233,244,255); made.BorderSizePixel=0; corner(made,999); stroke(made,Color3.fromRGB(128,178,239),.28,1)
    label(made,"made with love ♡",UDim2.fromScale(1,1),UDim2.fromOffset(0,0),Enum.Font.FredokaOne,14,Color3.fromRGB(57,108,211),Enum.TextXAlignment.Center)

    task.spawn(function()
        pcall(function() ContentProvider:PreloadAsync({mascot,title,subtitle,pawL,pawR}) end)
    end)

    local steps={
        {"loading your profile...",.22,.45},
        {"setting up the feature pages...",.42,.55},
        {"matching the blue + hot blue theme...",.62,.55},
        {"loading environment + weapon skins...",.80,.55},
        {"finishing the cute details...",.94,.45},
    }
    task.spawn(function()
        for _,s in ipairs(steps) do
            if not gui.Parent or _G.KimqV31Ready then break end
            status.Text=s[1]
            TweenService:Create(fill,TweenInfo.new(.32,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{Size=UDim2.new(s[2],0,1,0)}):Play()
            pct.Text=tostring(math.floor(s[2]*100)).."%"
            task.wait(s[3])
        end
        if gui.Parent and not _G.KimqV31Ready then status.Text="almost ready..." end
    end)

    -- Keep legacy build layers hidden behind this loader.
    task.spawn(function()
        while gui.Parent and not _G.KimqV31Ready do
            pcall(function()
                for _,root in ipairs({CoreGui,pg}) do
                    for _,n in ipairs({"KimpetrasHC_Boot","KimqV4Loader","KimpetrasHC_Loading","KimqV22CuteLoader","KimqV21CuteLoader"}) do
                        local x=root:FindFirstChild(n); if x and x~=gui then x:Destroy() end
                    end
                    local r=root:FindFirstChild("KimpetrasHC"); local m=r and r:FindFirstChild("Main"); if m then m.Visible=false end
                end
            end)
            task.wait(.06)
        end
    end)

    _G.KimqV31Loader={Gui=gui,Background=bg,Card=card,Status=status,Bar=fill,Percent=pct}
    task.delay(10,function() if gui and gui.Parent then pcall(function() gui:Destroy() end) end end)
end


-- KIMQETRAS HC - CUTE BLUE REBUILD
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

local SKY = Color3.fromRGB(221, 239, 255)
local SKY2 = Color3.fromRGB(199, 225, 255)
local HOT = Color3.fromRGB(35, 91, 255)
local HOT2 = Color3.fromRGB(83, 132, 255)
local INK = Color3.fromRGB(38, 74, 143)
local SOFT = Color3.fromRGB(104, 137, 191)
local WHITEBLUE = Color3.fromRGB(246, 251, 255)

local BootGui = Instance.new("ScreenGui")
BootGui.Name = "KimpetrasHC_Boot"
BootGui.ResetOnSpawn = false
BootGui.IgnoreGuiInset = true
BootGui.DisplayOrder = 999999
pcall(function() BootGui.Parent = CoreGui end)
if not BootGui.Parent then BootGui.Parent = playerGui end

local Shade = Instance.new("Frame", BootGui)
Shade.Size = UDim2.fromScale(1, 1)
Shade.BackgroundColor3 = Color3.fromRGB(189, 218, 255)
Shade.BackgroundTransparency = 0.12
Shade.BorderSizePixel = 0

local Panel = Instance.new("Frame", Shade)
Panel.AnchorPoint = Vector2.new(0.5, 0.5)
Panel.Position = UDim2.fromScale(0.5, 0.5)
Panel.Size = UDim2.fromOffset(520, 320)
Panel.BackgroundColor3 = SKY
Panel.BorderSizePixel = 0
Instance.new("UICorner", Panel).CornerRadius = UDim.new(0, 28)
local BootStroke = Instance.new("UIStroke", Panel)
BootStroke.Color = HOT
BootStroke.Thickness = 2
BootStroke.Transparency = 0.25

-- little bubble decorations
for i, data in ipairs({
    {20,20,46,0.35}, {448,26,30,0.48}, {32,250,25,0.52}, {462,240,40,0.43}
}) do
    local b = Instance.new("Frame", Panel)
    b.Size = UDim2.fromOffset(data[3], data[3])
    b.Position = UDim2.fromOffset(data[1], data[2])
    b.BackgroundColor3 = i % 2 == 0 and HOT2 or Color3.fromRGB(173, 211, 255)
    b.BackgroundTransparency = data[4]
    b.BorderSizePixel = 0
    Instance.new("UICorner", b).CornerRadius = UDim.new(1, 0)
end

local Heart = Instance.new("TextLabel", Panel)
Heart.Size = UDim2.fromOffset(70, 70)
Heart.Position = UDim2.new(0.5, -35, 0, 34)
Heart.BackgroundTransparency = 1
Heart.Text = "♥"
Heart.TextColor3 = HOT
Heart.Font = Enum.Font.FredokaOne
Heart.TextSize = 62

local Title = Instance.new("TextLabel", Panel)
Title.Size = UDim2.new(1, -40, 0, 40)
Title.Position = UDim2.fromOffset(20, 106)
Title.BackgroundTransparency = 1
Title.Text = "Kimqetras HC"
Title.TextColor3 = INK
Title.Font = Enum.Font.FredokaOne
Title.TextSize = 31
Title.TextXAlignment = Enum.TextXAlignment.Center

local Hello = Instance.new("TextLabel", Panel)
Hello.Size = UDim2.new(1, -40, 0, 24)
Hello.Position = UDim2.fromOffset(20, 146)
Hello.BackgroundTransparency = 1
Hello.Text = "getting everything ready for " .. lp.DisplayName .. " ♡"
Hello.TextColor3 = SOFT
Hello.Font = Enum.Font.Gotham
Hello.TextSize = 13
Hello.TextXAlignment = Enum.TextXAlignment.Center

local Dashes = Instance.new("TextLabel", Panel)
Dashes.Size = UDim2.new(1, -100, 0, 18)
Dashes.Position = UDim2.fromOffset(50, 178)
Dashes.BackgroundTransparency = 1
Dashes.Text = "-   -   -   -   -   -   -   -   -"
Dashes.TextColor3 = Color3.fromRGB(126, 167, 232)
Dashes.Font = Enum.Font.GothamBold
Dashes.TextSize = 13
Dashes.TextXAlignment = Enum.TextXAlignment.Center

local Status = Instance.new("TextLabel", Panel)
Status.Size = UDim2.new(1, -50, 0, 54)
Status.Position = UDim2.fromOffset(25, 204)
Status.BackgroundTransparency = 1
Status.Text = "starting..."
Status.TextColor3 = INK
Status.Font = Enum.Font.GothamMedium
Status.TextSize = 14
Status.TextWrapped = true
Status.TextXAlignment = Enum.TextXAlignment.Center
Status.TextYAlignment = Enum.TextYAlignment.Center

local BarBack = Instance.new("Frame", Panel)
BarBack.Size = UDim2.new(1, -90, 0, 10)
BarBack.Position = UDim2.new(0, 45, 1, -38)
BarBack.BackgroundColor3 = Color3.fromRGB(179, 214, 255)
BarBack.BorderSizePixel = 0
Instance.new("UICorner", BarBack).CornerRadius = UDim.new(1, 0)

local Bar = Instance.new("Frame", BarBack)
Bar.Size = UDim2.new(0.03, 0, 1, 0)
Bar.BackgroundColor3 = HOT
Bar.BorderSizePixel = 0
Instance.new("UICorner", Bar).CornerRadius = UDim.new(1, 0)

-- small floating animation, subtle and cute
local heartUp = false
task.spawn(function()
    while Heart.Parent do
        heartUp = not heartUp
        TweenService:Create(Heart, TweenInfo.new(0.55, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            Position = heartUp and UDim2.new(0.5, -35, 0, 28) or UDim2.new(0.5, -35, 0, 36)
        }):Play()
        task.wait(0.58)
    end
end)

local failures = {}
local completed = 0
local total = 6

local function setProgress(name)
    completed += 1
    local amount = math.clamp(completed / total, 0, 1)
    TweenService:Create(Bar, TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Size = UDim2.new(amount, 0, 1, 0)
    }):Play()
    Status.Text = "♥  loading " .. name .. "  ♥"
end

local function runChunk(name, source, required)
    setProgress(name)
    task.wait(0.22)
    local fn, compileErr = loadstring(source)
    if not fn then
        local msg = name .. " COMPILE: " .. tostring(compileErr)
        table.insert(failures, msg)
        Status.Text = "♡ " .. msg
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
        Status.Text = "♡ " .. msg
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
local ExtraESPColor = _G.KimqESPColor or Color3.fromRGB(47, 91, 255)
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
    Status.Text = "ready ♥\nKimqetras HC loaded successfully."
    Bar.Size = UDim2.new(1, 0, 1, 0)
    Status.Text = "making it cute... ♥"
    task.wait(0.05)
    -- Kimqetras redesign patch closes the loader after the new UI is ready.
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
        bg = Color3.fromRGB(219, 238, 255),
        bg2 = Color3.fromRGB(202, 228, 255),
        panel = Color3.fromRGB(235, 247, 255),
        card = Color3.fromRGB(246, 251, 255),
        card2 = Color3.fromRGB(225, 241, 255),
        hot = Color3.fromRGB(33, 91, 255),
        hot2 = Color3.fromRGB(76, 126, 255),
        text = Color3.fromRGB(38, 72, 139),
        sub = Color3.fromRGB(99, 131, 187),
        stroke = Color3.fromRGB(146, 188, 242),
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
    local hint = textLabel(rightShiftHint, "♥  Right Shift = hide / show", UDim2.new(1, -12, 1, 0), UDim2.fromOffset(6, 0), Enum.Font.GothamSemibold, 10, T.hot, Enum.TextXAlignment.Center)

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
        local busy = false
        local function recolor()
            if busy or not btn.Parent then return end
            local c = btn.BackgroundColor3
            if isOldPink(c) then
                busy = true
                local wasOn = c.G < 0.55
                btn.BackgroundColor3 = wasOn and T.hot or T.bg2
                busy = false
            end
        end
        recolor()
        btn:GetPropertyChangedSignal("BackgroundColor3"):Connect(recolor)
        for _, ch in ipairs(btn:GetChildren()) do
            if ch:IsA("Frame") then ch.BackgroundColor3 = T.white end
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
            ColorSequenceKeypoint.new(0, Color3.fromRGB(151, 199, 255)),
            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(80, 137, 255)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(35, 91, 255)),
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
    local ovDesc = textLabel(welcomeCard, "Everything has its own page now, so you can find a feature without digging through a giant list. Use the blue buttons on the left, and press Right Shift whenever you want the interface out of the way.", UDim2.new(1, -126, 0, 42), UDim2.fromOffset(104, 202), Enum.Font.Gotham, 11, T.sub)
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
    local tBody = textLabel(tipsCard, "• The selected page turns hot blue so you always know where you are.\n• The banner uses KimqetrasBanner.png from your workspace when it is available.\n• There is no reopen bubble; Right Shift is the only hide/show shortcut.", UDim2.new(1, -24, 0, 66), UDim2.fromOffset(12, 39), Enum.Font.Gotham, 11, T.sub)
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

    -- Fixed hide/show on Right Shift. No floating reopen button.
    local uiShown = true
    UIS.InputBegan:Connect(function(input, processed)
        if processed then return end
        if input.KeyCode == Enum.KeyCode.RightShift then
            uiShown = not uiShown
            main.Visible = uiShown
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
        task.wait(1.35)
        pcall(function() boot:Destroy() end)
    end
end)


task.spawn(function()
    local Players = game:GetService("Players")
    local CoreGui = game:GetService("CoreGui")
    local lp = Players.LocalPlayer
    local playerGui = lp:WaitForChild("PlayerGui")

    local function waitForMain(timeout)
        local start = tick()
        while tick() - start < (timeout or 12) do
            local gui = CoreGui:FindFirstChild("KimpetrasHC") or playerGui:FindFirstChild("KimpetrasHC")
            local main = gui and gui:FindFirstChild("Main")
            if main then return gui, main end
            task.wait(0.1)
        end
    end

    local gui, main = waitForMain(14)
    if not gui or not main then return end
    if main:FindFirstChild("KimqBlueFix2Applied") then return end
    local marker = Instance.new("BoolValue")
    marker.Name = "KimqBlueFix2Applied"
    marker.Parent = main

    local T = {
        hot = Color3.fromRGB(50, 92, 255),
        hot2 = Color3.fromRGB(96, 142, 255),
        panel = Color3.fromRGB(233, 242, 255),
        bg = Color3.fromRGB(223, 235, 252),
        bg2 = Color3.fromRGB(210, 228, 250),
        text = Color3.fromRGB(50, 80, 145),
        sub = Color3.fromRGB(96, 122, 170),
        stroke = Color3.fromRGB(137, 176, 230),
        white = Color3.fromRGB(245, 250, 255),
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
    local function textLabel(parent, text, size, pos, font, textSize, color, align)
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

    local pages = {}
    for _, d in ipairs(main:GetDescendants()) do
        if d:IsA("ScrollingFrame") and d.Name:match("Page$") then
            pages[d.Name:gsub("Page$", ""):lower()] = d
        end
    end
    if not pages.overview then return end

    local pageHeadTitle, pageHeadDesc
    for _, d in ipairs(main:GetDescendants()) do
        if d:IsA("TextLabel") and d.Text == "overview" then
            pageHeadTitle = d
        elseif d:IsA("TextLabel") and tostring(d.Text):find("your account") then
            pageHeadDesc = d
        end
    end
    if pageHeadTitle then pageHeadTitle.TextSize = 24 end
    if pageHeadDesc then pageHeadDesc.TextSize = 12 end

    local sectionMap = {
        ["silent aim"] = "silent",
        ["macro"] = "macro",
        ["whitelist"] = "whitelist",
        ["protection"] = "protection",
        ["anti fall"] = "antifall",
        ["delay changer"] = "delay",
        ["esp"] = "esp",
        ["avatar"] = "avatar",
        ["fog color picker"] = "fog",
        ["fog / atmosphere"] = "fog",
        ["atmosphere presets"] = "fog",
        ["combat"] = "hcsilent",
        ["hc silent aim"] = "hcsilent",
        ["force hit"] = "forcehit",
        ["hitbox expander"] = "hitbox",
        ["flamelock"] = "flamelock",
        ["camlock"] = "camlock",
        ["headless"] = "headless",
        ["protection + anti mod"] = "antimod",
        ["anti mod"] = "antimod",
        ["settings"] = "settings",
        ["information"] = "info",
        ["credits"] = "info",
    }

    local function normalize(txt)
        txt = tostring(txt or "")
        txt = txt:gsub("^%s*[♡♥]%s*", "")
        txt = txt:gsub("%s+", " ")
        txt = txt:lower()
        txt = txt:gsub("^%s+", ""):gsub("%s+$", "")
        return txt
    end

    local function findSectionName(obj)
        if obj:IsA("TextLabel") then
            local n = normalize(obj.Text)
            if sectionMap[n] then return n end
        end
        for _, ch in ipairs(obj:GetChildren()) do
            if ch:IsA("TextLabel") then
                local n = normalize(ch.Text)
                if sectionMap[n] then return n end
            end
        end
        return nil
    end

    local function sortedChildren(page)
        local t = {}
        for _, ch in ipairs(page:GetChildren()) do
            if not ch:IsA("UIListLayout") and not ch:IsA("UIPadding") then
                table.insert(t, ch)
            end
        end
        table.sort(t, function(a, b)
            if a.LayoutOrder ~= b.LayoutOrder then return a.LayoutOrder < b.LayoutOrder end
            if a.AbsolutePosition.Y ~= b.AbsolutePosition.Y then return a.AbsolutePosition.Y < b.AbsolutePosition.Y end
            return a.Name < b.Name
        end)
        return t
    end

    local function reindex(page)
        local i = 0
        for _, ch in ipairs(sortedChildren(page)) do
            i += 1
            ch.LayoutOrder = i
        end
    end

    -- multi-pass redistribution so every header block lands in its own page
    for _ = 1, 4 do
        local movedAny = false
        for pageKey, page in pairs(pages) do
            if pageKey ~= "overview" then
                local targetKey = pageKey
                local objects = sortedChildren(page)
                for _, obj in ipairs(objects) do
                    local sec = findSectionName(obj)
                    if sec and sectionMap[sec] then
                        targetKey = sectionMap[sec]
                    end
                    local target = pages[targetKey]
                    if target and target ~= page then
                        obj.Parent = target
                        obj.LayoutOrder = 9999
                        movedAny = true
                    end
                end
            end
        end
        for _, page in pairs(pages) do reindex(page) end
        if not movedAny then break end
    end

    -- make the section hearts stop overlapping the names
    for _, d in ipairs(main:GetDescendants()) do
        if d:IsA("TextButton") then
            local heart = d:FindFirstChild("Heart")
            if heart and heart:IsA("TextLabel") then
                local clean = tostring(d.Text or ""):gsub("^%s+", "")
                d.Text = "          " .. clean
                d.TextSize = 13
                heart.Size = UDim2.fromOffset(20, 38)
                heart.Position = UDim2.fromOffset(6, 0)
                heart.TextSize = 15
            end
        end
    end

    -- rebuild overview page with larger text and a built-in custom banner
    local overview = pages.overview
    for _, ch in ipairs(overview:GetChildren()) do
        if not ch:IsA("UIListLayout") and not ch:IsA("UIPadding") then
            ch:Destroy()
        end
    end

    local function card(parent, h)
        local f = Instance.new("Frame")
        f.Parent = parent
        f.Size = UDim2.new(1, -6, 0, h)
        f.BackgroundColor3 = T.panel
        f.BorderSizePixel = 0
        corner(f, 18)
        stroke(f, T.stroke, 0.22, 1)
        return f
    end

    local welcomeCard = card(overview, 280)

    local banner = Instance.new("Frame")
    banner.Parent = welcomeCard
    banner.Size = UDim2.new(1, -24, 0, 108)
    banner.Position = UDim2.fromOffset(12, 12)
    banner.BackgroundColor3 = T.bg2
    banner.BorderSizePixel = 0
    corner(banner, 16)
    local grad = Instance.new("UIGradient", banner)
    grad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(169, 208, 255)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(105, 156, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(67, 117, 255)),
    })
    grad.Rotation = 10
    for i, pack in ipairs({
        {"♡", 0.14, 0.45, 28}, {"♥", 0.33, 0.26, 36}, {"♡", 0.55, 0.58, 26},
        {"♥", 0.72, 0.32, 32}, {"♡", 0.85, 0.64, 24}, {"♥", 0.46, 0.72, 22}
    }) do
        local h = textLabel(banner, pack[1], UDim2.fromOffset(40, 40), UDim2.new(pack[2], -20, pack[3], -20), Enum.Font.FredokaOne, pack[4], T.white, Enum.TextXAlignment.Center)
        h.TextTransparency = 0.1
    end

    local avatar = Instance.new("ImageLabel")
    avatar.Parent = welcomeCard
    avatar.Size = UDim2.fromOffset(78, 78)
    avatar.Position = UDim2.fromOffset(18, 142)
    avatar.BackgroundColor3 = T.bg2
    avatar.BorderSizePixel = 0
    corner(avatar, 999)
    stroke(avatar, T.hot2, 0.28, 1)
    pcall(function()
        avatar.Image = Players:GetUserThumbnailAsync(lp.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size180x180)
    end)

    textLabel(welcomeCard, "Kimqetras HC  ♡", UDim2.new(1, -120, 0, 18), UDim2.fromOffset(108, 140), Enum.Font.GothamSemibold, 12, T.sub)
    local bigWelcome = textLabel(welcomeCard, "welcome, " .. lp.DisplayName:lower() .. " ♡", UDim2.new(1, -120, 0, 38), UDim2.fromOffset(108, 160), Enum.Font.FredokaOne, 30, T.text)
    local underUser = textLabel(welcomeCard, "@" .. lp.Name .. "   •   account age: " .. tostring(lp.AccountAge) .. " days", UDim2.new(1, -120, 0, 20), UDim2.fromOffset(108, 198), Enum.Font.Gotham, 12, T.sub)
    local intro = textLabel(welcomeCard, "This build organizes every feature into its own page so the interface stays easy to read. Silent Aim, Macro, Whitelist, ESP, Avatar, Fog / Atmosphere, Camlock, Flamelock, Force Hit, Hitbox, and the rest each have their own section instead of being stacked together.", UDim2.new(1, -126, 0, 58), UDim2.fromOffset(108, 222), Enum.Font.Gotham, 13, T.sub)
    intro.TextWrapped = true
    intro.TextYAlignment = Enum.TextYAlignment.Top

    local overviewCard = card(overview, 178)
    textLabel(overviewCard, "♡  what this script does", UDim2.new(1, -24, 0, 26), UDim2.fromOffset(12, 10), Enum.Font.FredokaOne, 22, T.hot)
    local ovDash = textLabel(overviewCard, "-  -  -  -  -  -  -  -  -  -  -  -  -", UDim2.new(1, -24, 0, 16), UDim2.fromOffset(12, 36), Enum.Font.GothamBold, 10, T.stroke)
    local ovBody = textLabel(overviewCard, "Kimqetras HC combines clean page-based controls for aiming, macro speed, whitelist management, protection tools, anti-fall, delay control, ESP, avatar tools, fog and atmosphere, Hood Customs options, and more. Everything is grouped by purpose so you can jump to what you need quickly.", UDim2.new(1, -24, 0, 110), UDim2.fromOffset(12, 58), Enum.Font.Gotham, 13, T.sub)
    ovBody.TextWrapped = true
    ovBody.TextYAlignment = Enum.TextYAlignment.Top

    local notesCard = card(overview, 178)
    textLabel(notesCard, "♥  quick notes", UDim2.new(1, -24, 0, 26), UDim2.fromOffset(12, 10), Enum.Font.FredokaOne, 22, T.hot)
    local notesDash = textLabel(notesCard, "-  -  -  -  -  -  -  -  -  -  -  -  -", UDim2.new(1, -24, 0, 16), UDim2.fromOffset(12, 36), Enum.Font.GothamBold, 10, T.stroke)
    local notesBody = textLabel(notesCard, "• The blue page button shows where you are right now.\n• Right Shift hides or opens the interface instantly.\n• The overview page explains the layout, and the information page shows developer details.\n• The banner is now built into the script, so it always works even without a workspace image.", UDim2.new(1, -24, 0, 116), UDim2.fromOffset(12, 56), Enum.Font.Gotham, 13, T.sub)
    notesBody.TextWrapped = true
    notesBody.TextYAlignment = Enum.TextYAlignment.Top

    -- add developer info card to the information page
    local info = pages.info
    if info then
        for _, ch in ipairs(sortedChildren(info)) do
            ch.LayoutOrder = ch.LayoutOrder + 1
        end
        local devCard = card(info, 170)
        devCard.LayoutOrder = 1
        textLabel(devCard, "♥  developer information", UDim2.new(1, -24, 0, 26), UDim2.fromOffset(12, 10), Enum.Font.FredokaOne, 22, T.hot)
        local devDash = textLabel(devCard, "-  -  -  -  -  -  -  -  -  -  -  -  -", UDim2.new(1, -24, 0, 16), UDim2.fromOffset(12, 36), Enum.Font.GothamBold, 10, T.stroke)
        local devBody = textLabel(devCard, "Lead developer: famesgun\nPlatform: Roblox\nProfile: https://www.roblox.com/users/4246488996/profile\n\nThis page credits the original developer and keeps the build details in one place.", UDim2.new(1, -24, 0, 110), UDim2.fromOffset(12, 58), Enum.Font.Gotham, 13, T.sub)
        devBody.TextWrapped = true
        devBody.TextYAlignment = Enum.TextYAlignment.Top
        reindex(info)
    end

    -- make the current page header text a bit cleaner
    if pageHeadDesc then
        pageHeadDesc.Text = "your account, a script summary, and helpful notes"
    end
end)


-- KIMQETRAS HC V3: FORCE PAGE SEPARATION + OVERVIEW POLISH
-- Runs after the earlier GUI build and sorts every control by its own label,
-- instead of relying on the old vertical positions.
task.spawn(function()
    task.wait(2.2)

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
        hot = Color3.fromRGB(47, 91, 255),
        hot2 = Color3.fromRGB(88, 139, 255),
        panel = Color3.fromRGB(235, 244, 255),
        bg2 = Color3.fromRGB(210, 229, 253),
        text = Color3.fromRGB(48, 76, 142),
        sub = Color3.fromRGB(94, 120, 169),
        stroke = Color3.fromRGB(139, 178, 232),
        white = Color3.fromRGB(248, 252, 255),
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
        ColorSequenceKeypoint.new(0, Color3.fromRGB(185, 219, 255)),
        ColorSequenceKeypoint.new(0.45, Color3.fromRGB(110, 164, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(50, 94, 255)),
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
    local desc = label(hero, "Kimqetras HC is a page-based control hub that keeps each feature separate so you can find what you need quickly. Use the sidebar to switch tools, and press Right Shift whenever you want to hide or reopen the interface.", UDim2.new(1,-126,0,58), UDim2.fromOffset(108,232), Enum.Font.Gotham, 13, T.sub)
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
        "• The selected page turns hot blue so you always know where you are.\n• Every major feature now has its own page instead of being piled into Silent Aim.\n• The banner is generated inside the script, so it does not depend on a workspace image.\n• Right Shift is the only hide/show shortcut — there is no floating reopen bubble.",
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
    badge.Text = "V3 ♡"
    badge.TextColor3 = T.white
    badge.Font = Enum.Font.FredokaOne
    badge.TextSize = 12
    badge.ZIndex = 60
    corner(badge,999)
end)

-- ========================================================
-- KIMQETRAS HC V5 - UNIFORM CARDS + ESP COLOR + THEMES
-- ========================================================
task.spawn(function()
    task.wait(3.35)

    local Players = game:GetService("Players")
    local UIS = game:GetService("UserInputService")
    local CoreGui = game:GetService("CoreGui")
    local StarterGui = game:GetService("StarterGui")
    local lp = Players.LocalPlayer
    local playerGui = lp:WaitForChild("PlayerGui")

    local gui = CoreGui:FindFirstChild("KimpetrasHC") or playerGui:FindFirstChild("KimpetrasHC")
    local main = gui and gui:FindFirstChild("Main")
    if not main or main:FindFirstChild("KimqV5Applied") then return end

    local marker = Instance.new("BoolValue")
    marker.Name = "KimqV5Applied"
    marker.Parent = main

    local BASE = {
        hot = Color3.fromRGB(47, 91, 255),
        hot2 = Color3.fromRGB(88, 139, 255),
        bg = Color3.fromRGB(219, 238, 255),
        bg2 = Color3.fromRGB(210, 229, 253),
        panel = Color3.fromRGB(235, 244, 255),
        card = Color3.fromRGB(246, 251, 255),
        text = Color3.fromRGB(48, 76, 142),
        sub = Color3.fromRGB(94, 120, 169),
        stroke = Color3.fromRGB(139, 178, 232),
        white = Color3.fromRGB(248, 252, 255),
    }

    local THEMES = {
        Blue = {
            hot = Color3.fromRGB(47, 91, 255), hot2 = Color3.fromRGB(88, 139, 255),
            bg = Color3.fromRGB(219, 238, 255), bg2 = Color3.fromRGB(205, 227, 252),
            panel = Color3.fromRGB(235, 244, 255), card = Color3.fromRGB(247, 251, 255),
            text = Color3.fromRGB(48, 76, 142), sub = Color3.fromRGB(94, 120, 169),
            stroke = Color3.fromRGB(139, 178, 232), white = Color3.fromRGB(250, 253, 255),
        },
        Purple = {
            hot = Color3.fromRGB(151, 61, 255), hot2 = Color3.fromRGB(186, 112, 255),
            bg = Color3.fromRGB(239, 229, 255), bg2 = Color3.fromRGB(225, 210, 250),
            panel = Color3.fromRGB(248, 241, 255), card = Color3.fromRGB(252, 248, 255),
            text = Color3.fromRGB(91, 55, 147), sub = Color3.fromRGB(132, 100, 169),
            stroke = Color3.fromRGB(193, 159, 231), white = Color3.fromRGB(255, 252, 255),
        },
        Red = {
            hot = Color3.fromRGB(255, 54, 87), hot2 = Color3.fromRGB(255, 102, 127),
            bg = Color3.fromRGB(255, 230, 235), bg2 = Color3.fromRGB(250, 211, 220),
            panel = Color3.fromRGB(255, 241, 244), card = Color3.fromRGB(255, 249, 250),
            text = Color3.fromRGB(146, 55, 72), sub = Color3.fromRGB(177, 99, 112),
            stroke = Color3.fromRGB(235, 157, 171), white = Color3.fromRGB(255, 253, 253),
        },
        Pink = {
            hot = Color3.fromRGB(255, 45, 151), hot2 = Color3.fromRGB(255, 107, 180),
            bg = Color3.fromRGB(255, 226, 240), bg2 = Color3.fromRGB(251, 207, 229),
            panel = Color3.fromRGB(255, 241, 248), card = Color3.fromRGB(255, 249, 252),
            text = Color3.fromRGB(158, 58, 109), sub = Color3.fromRGB(187, 104, 144),
            stroke = Color3.fromRGB(239, 163, 201), white = Color3.fromRGB(255, 253, 255),
        },
        Aqua = {
            hot = Color3.fromRGB(0, 177, 235), hot2 = Color3.fromRGB(62, 207, 250),
            bg = Color3.fromRGB(219, 247, 255), bg2 = Color3.fromRGB(199, 238, 249),
            panel = Color3.fromRGB(237, 250, 255), card = Color3.fromRGB(248, 254, 255),
            text = Color3.fromRGB(42, 108, 139), sub = Color3.fromRGB(83, 143, 166),
            stroke = Color3.fromRGB(131, 202, 225), white = Color3.fromRGB(251, 255, 255),
        },
        Green = {
            hot = Color3.fromRGB(40, 190, 121), hot2 = Color3.fromRGB(95, 220, 157),
            bg = Color3.fromRGB(225, 248, 237), bg2 = Color3.fromRGB(205, 239, 222),
            panel = Color3.fromRGB(240, 252, 246), card = Color3.fromRGB(249, 255, 252),
            text = Color3.fromRGB(48, 120, 86), sub = Color3.fromRGB(89, 153, 120),
            stroke = Color3.fromRGB(143, 211, 176), white = Color3.fromRGB(252, 255, 253),
        },
    }

    local currentThemeName = "Blue"
    local currentTheme = THEMES.Blue

    local function corner(obj, r)
        local c = obj:FindFirstChildOfClass("UICorner") or Instance.new("UICorner")
        c.CornerRadius = UDim.new(0, r or 12)
        c.Parent = obj
        return c
    end

    local function stroke(obj, color, tr, th)
        local s = obj:FindFirstChildOfClass("UIStroke") or Instance.new("UIStroke")
        s.Color = color or currentTheme.stroke
        s.Transparency = tr or 0.2
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
        l.TextColor3 = color or currentTheme.text
        l.TextXAlignment = align or Enum.TextXAlignment.Left
        l.TextYAlignment = Enum.TextYAlignment.Center
        return l
    end

    local function normalize(text)
        text = tostring(text or "")
        text = text:gsub("[❤♥♡]", "")
        text = text:gsub("^%s+", ""):gsub("%s+$", "")
        text = text:gsub("%s+", " ")
        return text
    end

    local pages = {}
    for _, d in ipairs(main:GetDescendants()) do
        if d:IsA("ScrollingFrame") and d.Name:match("Page$") then
            pages[d.Name:gsub("Page$", ""):lower()] = d
        end
    end
    if not pages.overview or not pages.silent then return end

    local exact = {
        ["Silent Aim"]="silent", ["Show FOV Circle"]="silent", ["FOV Size"]="silent", ["Bypass Revolver"]="silent",
        ["Wall Check"]="silent", ["Target Closest Part"]="silent", ["HitPart (16 Parts)"]="silent", ["Enable Keybind"]="silent", ["Toggle Aim Key"]="silent",
        ["Macro / Speed Master"]="macro", ["Macro Key"]="macro", ["Macro Speed"]="macro", ["Turn Master on, then press the Macro Key"]="macro",
        ["Clear Whitelist"]="whitelist", ["Anti Aim View"]="protection", ["0% Aim Accuracy"]="protection", ["Anti Fall"]="antifall",
        ["Delay Changer"]="delay", ["[Revolver] Delay"]="delay", ["[Double-Barrel SG] Delay"]="delay", ["[TacticalShotgun] Delay"]="delay", ["Others Delay"]="delay",
        ["ESP"]="esp", ["Box"]="esp", ["Name"]="esp", ["Distance"]="esp", ["Health"]="esp", ["Snapline"]="esp", ["Skeleton"]="esp",
        ["User ID / Username"]="avatar", ["Enable Avatar"]="avatar", ["Visual Headless"]="avatar", ["Apply Avatar"]="avatar", ["Reset Character"]="avatar",
        ["HC Silent Aim"]="hcsilent", ["HC Revolver Bypass"]="hcsilent", ["HC Wall Check"]="hcsilent", ["HC Knock Check"]="hcsilent", ["HC FOV Radius"]="hcsilent",
        ["HC Hit Part"]="hcsilent", ["HC Prediction"]="hcsilent", ["HC Prediction Amount"]="hcsilent", ["HC Godmode"]="hcsilent",
        ["Force Hit"]="forcehit", ["Force Hit Mode"]="forcehit", ["Force Hit FOV"]="forcehit", ["Force Hit Tracer"]="forcehit", ["Force Hit Full Auto"]="forcehit", ["Force Hit Fire Rate"]="forcehit",
        ["Hitbox Expander"]="hitbox", ["Hitbox Size"]="hitbox", ["Hitbox Visibility"]="hitbox",
        ["Flamelock"]="flamelock", ["Right Click Lock"]="flamelock", ["Activation Mode"]="flamelock", ["Flamelock Key"]="flamelock", ["Flame Hit Part"]="flamelock",
        ["Flame Smoothness"]="flamelock", ["Flame Prediction"]="flamelock", ["Flame Left Offset"]="flamelock", ["Flame Up Offset"]="flamelock",
        ["Camlock Enabled"]="camlock", ["Auto Toggle (Gun)"]="camlock", ["Camlock Key"]="camlock", ["Camlock Mode"]="camlock", ["Camlock Hit Part"]="camlock",
        ["Closest Point Mode"]="camlock", ["Closest Point Scale"]="camlock", ["Camlock FOV"]="camlock", ["Max Distance"]="camlock", ["Easing Style"]="camlock",
        ["Easing Direction"]="camlock", ["Camlock Smoothness"]="camlock", ["Pull Strength"]="camlock", ["Pull Base Value"]="camlock", ["Pull Move Value"]="camlock",
        ["Camlock Prediction"]="camlock", ["Prediction X"]="camlock", ["Prediction Y"]="camlock", ["Prediction Z"]="camlock", ["Force Field Check"]="camlock",
        ["Visible Check"]="camlock", ["Carried Check"]="camlock", ["Knocked Check"]="camlock", ["Self Knocked Check"]="camlock",
        ["Atmosphere Preset"]="fog", ["Reset Atmosphere"]="fog", ["Color Correction"]="fog", ["Saturation"]="fog", ["Headless Mode"]="headless",
        ["PWD Anti Aim View"]="antimod", ["Anti Mod Notify"]="antimod", ["Anti Mod Kick"]="antimod", ["Anti Mod Kick Delay"]="antimod",
        ["FPS Unlocker"]="settings", ["Target FPS"]="settings", ["Config Name"]="settings", ["Save PWD Config"]="settings", ["Load PWD Config"]="settings", ["Delete PWD Config"]="settings",
    }

    local headerNames = {
        ["Silent Aim"]=true,["Macro"]=true,["Whitelist"]=true,["Protection"]=true,["Anti Fall"]=true,["Delay Changer"]=true,["ESP"]=true,["Avatar"]=true,
        ["Combat"]=true,["HC Silent Aim"]=true,["Force Hit"]=true,["Hitbox Expander"]=true,["Flamelock"]=true,["Camlock"]=true,["Visuals"]=true,
        ["Atmosphere Presets"]=true,["Headless"]=true,["Protection + Anti Mod"]=true,["Anti Mod"]=true,["Settings"]=true,["Credits"]=true,["Information"]=true,
    }

    local function textsIn(obj)
        local out = {}
        if obj:IsA("TextLabel") or obj:IsA("TextButton") then table.insert(out, normalize(obj.Text)) end
        for _, d in ipairs(obj:GetDescendants()) do
            if d:IsA("TextLabel") or d:IsA("TextButton") then table.insert(out, normalize(d.Text)) end
        end
        return out
    end

    local function exactDestination(obj)
        for _, t in ipairs(textsIn(obj)) do
            if exact[t] then return exact[t] end
        end
        return nil
    end

    local function isPureSectionHeader(obj)
        local hasInteractive = false
        for _, d in ipairs(obj:GetDescendants()) do
            if d:IsA("TextButton") or d:IsA("TextBox") then
                hasInteractive = true
                break
            end
        end
        if hasInteractive then return false end
        for _, t in ipairs(textsIn(obj)) do
            if headerNames[t] then return true end
        end
        return false
    end

    -- First force every real control onto its correct page.
    local allControls = {}
    for key, page in pairs(pages) do
        if key ~= "overview" and key ~= "theme" and key ~= "info" then
            for _, ch in ipairs(page:GetChildren()) do
                if not ch:IsA("UIListLayout") and not ch:IsA("UIPadding") then
                    table.insert(allControls, ch)
                end
            end
        end
    end

    for _, obj in ipairs(allControls) do
        if obj.Parent then
            if isPureSectionHeader(obj) then
                pcall(function() obj:Destroy() end)
            else
                local dest = exactDestination(obj)
                if dest and pages[dest] then obj.Parent = pages[dest] end
            end
        end
    end

    -- Dynamic whitelist player cards.
    for _, page in pairs(pages) do
        if page ~= pages.whitelist and page ~= pages.overview and page ~= pages.theme then
            local moving = {}
            for _, obj in ipairs(page:GetChildren()) do
                if obj:IsA("Frame") then
                    local b = obj:FindFirstChildOfClass("TextButton")
                    local l = obj:FindFirstChildOfClass("TextLabel")
                    if b and l and (b.Text == "ON" or b.Text == "OFF") then table.insert(moving, obj) end
                end
            end
            for _, obj in ipairs(moving) do obj.Parent = pages.whitelist end
        end
    end

    local fogPanel = main:FindFirstChild("FogPanel", true)
    if fogPanel and pages.fog then fogPanel.Parent = pages.fog end

    -- Remove any section header cards that survived on the wrong page.
    for _, page in pairs(pages) do
        if page ~= pages.overview and page ~= pages.theme and page ~= pages.info then
            for _, obj in ipairs(page:GetChildren()) do
                if not obj:IsA("UIListLayout") and not obj:IsA("UIPadding") and isPureSectionHeader(obj) then
                    pcall(function() obj:Destroy() end)
                end
            end
        end
    end

    -- One consistent size for normal controls.
    local function makeStandardCard(card)
        if not card:IsA("Frame") then return end
        if card == fogPanel or card.Name == "ESPColorPicker" or card.Name == "ThemeChoice" then return end
        card.Size = UDim2.new(1, -6, 0, 52)
        corner(card, 12)

        local box = card:FindFirstChildOfClass("TextBox")
        if box then
            box.Size = UDim2.new(0.5, -12, 0, 34)
            box.Position = UDim2.new(0.5, 4, 0.5, -17)
            corner(box, 10)
            for _, ch in ipairs(card:GetChildren()) do
                if ch:IsA("TextLabel") then
                    ch.Size = UDim2.new(0.45, -8, 1, 0)
                    ch.Position = UDim2.fromOffset(12, 0)
                    ch.TextYAlignment = Enum.TextYAlignment.Center
                end
            end
        end
    end

    for key, page in pairs(pages) do
        if key ~= "overview" and key ~= "fog" and key ~= "theme" and key ~= "info" then
            local list = page:FindFirstChildOfClass("UIListLayout")
            if list then list.Padding = UDim.new(0, 8) end
            for _, ch in ipairs(page:GetChildren()) do makeStandardCard(ch) end
        end
    end

    -- Round every part of the fog picker that visually reads as a box.
    if fogPanel then
        fogPanel.Size = UDim2.new(1, -6, 0, 560)
        corner(fogPanel, 18)
        local roundNames = {FogSquare=true,FogHueBar=true,FogPreview=true,FogHexBox=true,FogHBox=true,FogSBox=true,FogVBox=true,FogAmountBar=true}
        for _, d in ipairs(fogPanel:GetDescendants()) do
            if (d:IsA("Frame") or d:IsA("TextBox") or d:IsA("TextButton")) and (roundNames[d.Name] or d:IsA("TextBox")) then
                corner(d, d.Name == "FogHueBar" and 10 or 14)
            end
        end
        local square = fogPanel:FindFirstChild("FogSquare", true)
        if square then corner(square, 16) end
        local hue = fogPanel:FindFirstChild("FogHueBar", true)
        if hue then corner(hue, 12) end
        local preview = fogPanel:FindFirstChild("FogPreview", true)
        if preview then corner(preview, 14) end
    end

    -- ESP color picker: compact, same-height card with a rainbow hue bar.
    if pages.esp then
        local oldPicker = pages.esp:FindFirstChild("ESPColorPicker")
        if oldPicker then oldPicker:Destroy() end

        local picker = Instance.new("Frame")
        picker.Name = "ESPColorPicker"
        picker.Parent = pages.esp
        picker.LayoutOrder = 1
        picker.Size = UDim2.new(1, -6, 0, 52)
        picker.BackgroundColor3 = currentTheme.card
        picker.BorderSizePixel = 0
        corner(picker, 12)
        stroke(picker, currentTheme.stroke, 0.25, 1)

        label(picker, "ESP Color", UDim2.new(0.36, 0, 1, 0), UDim2.fromOffset(12, 0), Enum.Font.GothamSemibold, 14, currentTheme.text)

        local hueBar = Instance.new("Frame")
        hueBar.Name = "ESPHueBar"
        hueBar.Parent = picker
        hueBar.Size = UDim2.new(0.45, 0, 0, 14)
        hueBar.Position = UDim2.new(0.40, 0, 0.5, -7)
        hueBar.BackgroundColor3 = Color3.new(1,1,1)
        hueBar.BorderSizePixel = 0
        hueBar.Active = true
        corner(hueBar, 999)
        local hg = Instance.new("UIGradient", hueBar)
        hg.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0.00, Color3.fromHSV(0.00,1,1)),
            ColorSequenceKeypoint.new(0.17, Color3.fromHSV(0.17,1,1)),
            ColorSequenceKeypoint.new(0.33, Color3.fromHSV(0.33,1,1)),
            ColorSequenceKeypoint.new(0.50, Color3.fromHSV(0.50,1,1)),
            ColorSequenceKeypoint.new(0.67, Color3.fromHSV(0.67,1,1)),
            ColorSequenceKeypoint.new(0.83, Color3.fromHSV(0.83,1,1)),
            ColorSequenceKeypoint.new(1.00, Color3.fromHSV(1.00,1,1)),
        })

        local knob = Instance.new("Frame")
        knob.Parent = hueBar
        knob.Size = UDim2.fromOffset(18,18)
        knob.AnchorPoint = Vector2.new(0.5,0.5)
        knob.Position = UDim2.new(0.61,0,0.5,0)
        knob.BackgroundColor3 = currentTheme.white
        knob.BorderSizePixel = 0
        corner(knob, 999)
        stroke(knob, currentTheme.hot, 0, 2)

        local preview = Instance.new("Frame")
        preview.Name = "ESPColorPreview"
        preview.Parent = picker
        preview.Size = UDim2.fromOffset(30,30)
        preview.Position = UDim2.new(1,-42,0.5,-15)
        preview.BackgroundColor3 = _G.KimqESPColor or currentTheme.hot
        preview.BorderSizePixel = 0
        corner(preview, 9)
        stroke(preview, currentTheme.stroke, 0.2, 1)

        local dragging = false
        local function setHueFromX(x)
            local p = math.clamp((x - hueBar.AbsolutePosition.X) / math.max(1, hueBar.AbsoluteSize.X), 0, 1)
            knob.Position = UDim2.new(p,0,0.5,0)
            local c = Color3.fromHSV(p, 0.78, 1)
            preview.BackgroundColor3 = c
            if type(_G.KimqSetESPColor) == "function" then _G.KimqSetESPColor(c) else _G.KimqESPColor = c end
        end
        hueBar.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = true setHueFromX(input.Position.X) end
        end)
        UIS.InputChanged:Connect(function(input)
            if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then setHueFromX(input.Position.X) end
        end)
        UIS.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
        end)
    end

    -- Theme page: each option is one standard-height card.
    if pages.theme then
        for _, ch in ipairs(pages.theme:GetChildren()) do
            if not ch:IsA("UIListLayout") and not ch:IsA("UIPadding") then ch:Destroy() end
        end
        local list = pages.theme:FindFirstChildOfClass("UIListLayout")
        if list then list.Padding = UDim.new(0, 8) end

        local themeNames = {"Blue", "Purple", "Red", "Pink", "Aqua", "Green"}
        for i, name in ipairs(themeNames) do
            local p = THEMES[name]
            local card = Instance.new("Frame")
            card.Name = "ThemeChoice"
            card.Parent = pages.theme
            card.LayoutOrder = i
            card.Size = UDim2.new(1, -6, 0, 52)
            card.BackgroundColor3 = p.card
            card.BorderSizePixel = 0
            corner(card, 12)
            stroke(card, p.stroke, 0.18, 1)

            label(card, name .. " Theme", UDim2.new(0.48,0,1,0), UDim2.fromOffset(12,0), Enum.Font.GothamSemibold, 14, p.text)

            local light = Instance.new("Frame")
            light.Parent = card
            light.Size = UDim2.fromOffset(30,30)
            light.Position = UDim2.new(1,-126,0.5,-15)
            light.BackgroundColor3 = p.bg2
            light.BorderSizePixel = 0
            corner(light, 9)
            stroke(light, p.stroke, 0.15, 1)

            local hot = Instance.new("Frame")
            hot.Parent = card
            hot.Size = UDim2.fromOffset(30,30)
            hot.Position = UDim2.new(1,-90,0.5,-15)
            hot.BackgroundColor3 = p.hot
            hot.BorderSizePixel = 0
            corner(hot, 9)

            local apply = Instance.new("TextButton")
            apply.Parent = card
            apply.Size = UDim2.fromOffset(48,30)
            apply.Position = UDim2.new(1,-54,0.5,-15)
            apply.BackgroundColor3 = p.hot
            apply.BorderSizePixel = 0
            apply.Text = "♥"
            apply.TextColor3 = p.white
            apply.Font = Enum.Font.FredokaOne
            apply.TextSize = 17
            apply.AutoButtonColor = false
            corner(apply, 9)
            apply:SetAttribute("ThemeName", name)
        end
    end

    -- Replace thin separators with thicker em-dash separators and make hearts filled/thicker.
    for _, d in ipairs(main:GetDescendants()) do
        if d:IsA("TextLabel") then
            local txt = tostring(d.Text or "")
            if txt:match("^[%-%s]+$") then
                d.Text = "—  —  —  —  —  —  —  —"
                d.Font = Enum.Font.GothamBold
                d.TextSize = math.max(d.TextSize, 12)
                d.TextColor3 = currentTheme.stroke
            elseif txt == "♡" then
                d.Text = "♥"
                d.TextSize = math.max(d.TextSize, 18)
            end
        end
    end

    -- Sidebar: rename Pages -> Features and keep hearts safely inside each button.
    for _, d in ipairs(main:GetDescendants()) do
        if d:IsA("TextLabel") and normalize(d.Text):lower() == "pages" then
            d.Text = "♥  features  ♥"
            d.Font = Enum.Font.FredokaOne
            d.TextSize = 19
        end
    end

    local pageNames = {
        ["overview"]=true,["silent aim"]=true,["macro"]=true,["whitelist"]=true,["protection"]=true,["anti fall"]=true,["delay changer"]=true,["esp"]=true,["avatar"]=true,
        ["fog / atmosphere"]=true,["hc silent aim"]=true,["force hit"]=true,["hitbox expander"]=true,["flamelock"]=true,["camlock"]=true,["headless"]=true,["anti mod"]=true,["settings"]=true,["theme"]=true,["information"]=true,
    }
    for _, d in ipairs(main:GetDescendants()) do
        if d:IsA("TextButton") then
            local n = normalize(d.Text):lower()
            if pageNames[n] then
                d.Text = "♥   " .. n
                d.TextXAlignment = Enum.TextXAlignment.Left
                local pad = d:FindFirstChildOfClass("UIPadding") or Instance.new("UIPadding")
                pad.PaddingLeft = UDim.new(0, 10)
                pad.Parent = d
            end
        end
    end

    -- Cleaner overview: fewer words, larger/bolder text.
    if pages.overview then
        for _, ch in ipairs(pages.overview:GetChildren()) do
            if not ch:IsA("UIListLayout") and not ch:IsA("UIPadding") then ch:Destroy() end
        end

        local function card(parent, h)
            local f = Instance.new("Frame")
            f.Parent = parent
            f.Size = UDim2.new(1,-6,0,h)
            f.BackgroundColor3 = currentTheme.panel
            f.BorderSizePixel = 0
            corner(f, 18)
            stroke(f, currentTheme.stroke, 0.2, 1)
            return f
        end

        local hero = card(pages.overview, 246)
        hero.Name = "V5OverviewHero"
        local banner = Instance.new("Frame")
        banner.Name = "V5Banner"
        banner.Parent = hero
        banner.Size = UDim2.new(1,-24,0,108)
        banner.Position = UDim2.fromOffset(12,12)
        banner.BackgroundColor3 = currentTheme.bg2
        banner.BorderSizePixel = 0
        corner(banner,16)
        local grad = Instance.new("UIGradient", banner)
        grad.Name = "V5BannerGradient"
        grad.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0,currentTheme.bg2),
            ColorSequenceKeypoint.new(0.45,currentTheme.hot2),
            ColorSequenceKeypoint.new(1,currentTheme.hot),
        })
        grad.Rotation = 7
        for _, h in ipairs({{"♥",.09,.28,34},{"♥",.29,.67,27},{"♥",.49,.28,38},{"♥",.69,.65,31},{"♥",.89,.30,27}}) do
            local x = label(banner,h[1],UDim2.fromOffset(46,46),UDim2.new(h[2],-23,h[3],-23),Enum.Font.FredokaOne,h[4],currentTheme.white,Enum.TextXAlignment.Center)
            x.TextTransparency = 0.03
        end
        label(banner,"Kimqetras HC",UDim2.new(1,0,0,44),UDim2.new(0,0,0.5,-27),Enum.Font.FredokaOne,35,currentTheme.white,Enum.TextXAlignment.Center)
        label(banner,"simple • clean • cute",UDim2.new(1,0,0,18),UDim2.new(0,0,0.5,17),Enum.Font.GothamBold,12,currentTheme.white,Enum.TextXAlignment.Center)

        local avatar = Instance.new("ImageLabel")
        avatar.Parent = hero
        avatar.Size = UDim2.fromOffset(72,72)
        avatar.Position = UDim2.fromOffset(18,140)
        avatar.BackgroundColor3 = currentTheme.bg2
        avatar.BorderSizePixel = 0
        corner(avatar,999)
        stroke(avatar,currentTheme.hot2,0.22,1)
        pcall(function() avatar.Image = Players:GetUserThumbnailAsync(lp.UserId,Enum.ThumbnailType.HeadShot,Enum.ThumbnailSize.Size180x180) end)

        label(hero,"welcome, "..lp.DisplayName:lower(),UDim2.new(1,-112,0,36),UDim2.fromOffset(102,144),Enum.Font.FredokaOne,29,currentTheme.text)
        label(hero,"@"..lp.Name.."  •  Kimqetras HC",UDim2.new(1,-112,0,20),UDim2.fromOffset(102,181),Enum.Font.GothamBold,12,currentTheme.sub)
        local short = label(hero,"Everything is separated into its own feature page. Pick a tool on the left, or press Right Shift to hide / reopen the GUI.",UDim2.new(1,-118,0,48),UDim2.fromOffset(102,207),Enum.Font.GothamBold,14,currentTheme.text)
        short.TextWrapped = true
        short.TextYAlignment = Enum.TextYAlignment.Top

        local summary = card(pages.overview,150)
        summary.Name = "V5Summary"
        label(summary,"♥  script summary",UDim2.new(1,-24,0,28),UDim2.fromOffset(12,12),Enum.Font.FredokaOne,22,currentTheme.hot)
        label(summary,"—  —  —  —  —  —  —  —",UDim2.new(1,-24,0,18),UDim2.fromOffset(12,42),Enum.Font.GothamBold,12,currentTheme.stroke)
        local s = label(summary,"Silent Aim • Macro • Whitelist • Protection • Anti Fall • Delay Changer\nESP • Avatar • Fog / Atmosphere • HC Silent Aim • Force Hit • Hitbox • Flamelock • Camlock",UDim2.new(1,-24,0,74),UDim2.fromOffset(12,68),Enum.Font.GothamBold,14,currentTheme.text)
        s.TextWrapped = true
        s.TextYAlignment = Enum.TextYAlignment.Top

        local notes = card(pages.overview,132)
        notes.Name = "V5QuickNotes"
        label(notes,"♥  quick notes",UDim2.new(1,-24,0,28),UDim2.fromOffset(12,12),Enum.Font.FredokaOne,22,currentTheme.hot)
        label(notes,"—  —  —  —  —  —  —  —",UDim2.new(1,-24,0,18),UDim2.fromOffset(12,42),Enum.Font.GothamBold,12,currentTheme.stroke)
        local q = label(notes,"• Bright color = the feature you are on.\n• Right Shift = hide / show.\n• Theme changes update the whole GUI and banner.",UDim2.new(1,-24,0,64),UDim2.fromOffset(12,66),Enum.Font.GothamBold,14,currentTheme.text)
        q.TextWrapped = true
        q.TextYAlignment = Enum.TextYAlignment.Top
    end

    -- Chic developer profile card.
    if pages.info then
        for _, ch in ipairs(pages.info:GetChildren()) do
            if not ch:IsA("UIListLayout") and not ch:IsA("UIPadding") then ch:Destroy() end
        end
        local info = Instance.new("Frame")
        info.Name = "V5DeveloperCard"
        info.Parent = pages.info
        info.Size = UDim2.new(1,-6,0,196)
        info.BackgroundColor3 = currentTheme.panel
        info.BorderSizePixel = 0
        corner(info,18)
        stroke(info,currentTheme.stroke,0.2,1)

        local devAvatar = Instance.new("ImageLabel")
        devAvatar.Parent = info
        devAvatar.Size = UDim2.fromOffset(78,78)
        devAvatar.Position = UDim2.fromOffset(18,58)
        devAvatar.BackgroundColor3 = currentTheme.bg2
        devAvatar.BorderSizePixel = 0
        corner(devAvatar,999)
        stroke(devAvatar,currentTheme.hot2,0.22,1)
        pcall(function() devAvatar.Image = Players:GetUserThumbnailAsync(4246488996,Enum.ThumbnailType.HeadShot,Enum.ThumbnailSize.Size180x180) end)

        label(info,"♥  developer",UDim2.new(1,-24,0,30),UDim2.fromOffset(12,12),Enum.Font.FredokaOne,23,currentTheme.hot)
        label(info,"—  —  —  —  —  —  —  —",UDim2.new(1,-24,0,18),UDim2.fromOffset(12,40),Enum.Font.GothamBold,12,currentTheme.stroke)
        label(info,"Famesgun",UDim2.new(1,-122,0,30),UDim2.fromOffset(110,61),Enum.Font.FredokaOne,25,currentTheme.text)
        label(info,"original developer / scripter • Roblox",UDim2.new(1,-122,0,20),UDim2.fromOffset(110,91),Enum.Font.GothamBold,13,currentTheme.sub)
        label(info,"roblox.com/users/4246488996/profile",UDim2.new(1,-122,0,20),UDim2.fromOffset(110,116),Enum.Font.GothamBold,12,currentTheme.text)

        local copy = Instance.new("TextButton")
        copy.Parent = info
        copy.Size = UDim2.fromOffset(150,34)
        copy.Position = UDim2.new(0,110,1,-46)
        copy.BackgroundColor3 = currentTheme.hot
        copy.BorderSizePixel = 0
        copy.Text = "♥  copy profile"
        copy.TextColor3 = currentTheme.white
        copy.Font = Enum.Font.GothamBold
        copy.TextSize = 12
        copy.AutoButtonColor = false
        corner(copy,10)
        copy.MouseButton1Click:Connect(function()
            if type(setclipboard) == "function" then
                pcall(setclipboard,"https://www.roblox.com/users/4246488996/profile")
                copy.Text = "♥  copied"
                task.delay(1,function() if copy.Parent then copy.Text = "♥  copy profile" end end)
            end
        end)
    end

    -- Theme engine -------------------------------------------------------
    local themeRegistry = {}
    local updatingTheme = false

    local baseRefs = {
        hot = {BASE.hot, Color3.fromRGB(33,91,255), Color3.fromRGB(49,93,255), Color3.fromRGB(50,92,255), Color3.fromRGB(255,20,147)},
        hot2 = {BASE.hot2, Color3.fromRGB(76,126,255), Color3.fromRGB(95,140,255)},
        bg = {BASE.bg, Color3.fromRGB(223,235,252)},
        bg2 = {BASE.bg2, Color3.fromRGB(202,228,255), Color3.fromRGB(205,227,252), Color3.fromRGB(255,206,226)},
        panel = {BASE.panel, Color3.fromRGB(235,247,255), Color3.fromRGB(233,242,255), Color3.fromRGB(255,225,238)},
        card = {BASE.card, Color3.fromRGB(246,251,255), Color3.fromRGB(255,247,250)},
        text = {BASE.text, Color3.fromRGB(38,72,139), Color3.fromRGB(52,82,146)},
        sub = {BASE.sub, Color3.fromRGB(99,131,187), Color3.fromRGB(97,122,169)},
        stroke = {BASE.stroke, Color3.fromRGB(146,188,242), Color3.fromRGB(137,176,230)},
        white = {BASE.white, Color3.fromRGB(255,255,255)},
    }

    local function colorDistance(a,b)
        local dr,dg,db = a.R-b.R,a.G-b.G,a.B-b.B
        return math.sqrt(dr*dr+dg*dg+db*db)
    end

    local function classify(c)
        local bestRole,best = nil,math.huge
        for role, refs in pairs(baseRefs) do
            for _, ref in ipairs(refs) do
                local dist = colorDistance(c,ref)
                if dist < best then best,bestRole = dist,role end
            end
        end
        if best <= 0.19 then return bestRole end
        return nil
    end

    local function excluded(obj)
        if fogPanel and obj:IsDescendantOf(fogPanel) then return true end
        if obj:FindFirstAncestor("ESPColorPicker") then return true end
        if obj:FindFirstAncestor("ThemeChoice") then return true end
        return false
    end

    local function register(obj, prop)
        if excluded(obj) then return end
        local ok,val = pcall(function() return obj[prop] end)
        if not ok or typeof(val) ~= "Color3" then return end
        local role = classify(val)
        if not role then return end
        table.insert(themeRegistry,{obj=obj,prop=prop,role=role})
        pcall(function()
            obj:GetPropertyChangedSignal(prop):Connect(function()
                if updatingTheme or not obj.Parent then return end
                local v = obj[prop]
                local dynamicRole = classify(v)
                if dynamicRole and currentTheme[dynamicRole] then
                    updatingTheme = true
                    obj[prop] = currentTheme[dynamicRole]
                    updatingTheme = false
                end
            end)
        end)
    end

    for _, obj in ipairs(main:GetDescendants()) do
        if obj:IsA("Frame") or obj:IsA("TextButton") or obj:IsA("TextBox") or obj:IsA("ImageLabel") or obj:IsA("ImageButton") then register(obj,"BackgroundColor3") end
        if obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("TextBox") then register(obj,"TextColor3") end
        if obj:IsA("ScrollingFrame") then register(obj,"ScrollBarImageColor3") end
        if obj:IsA("UIStroke") then register(obj,"Color") end
    end

    local function applyTheme(name)
        local p = THEMES[name]
        if not p then return end
        currentThemeName = name
        currentTheme = p
        updatingTheme = true
        for _, entry in ipairs(themeRegistry) do
            if entry.obj.Parent and p[entry.role] then
                pcall(function() entry.obj[entry.prop] = p[entry.role] end)
            end
        end
        -- banner follows the selected light/hot pair
        local gradient = main:FindFirstChild("V5BannerGradient", true)
        if gradient and gradient:IsA("UIGradient") then
            gradient.Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0,p.bg2),
                ColorSequenceKeypoint.new(0.45,p.hot2),
                ColorSequenceKeypoint.new(1,p.hot),
            })
        end
        updatingTheme = false
    end

    if pages.theme then
        for _, card in ipairs(pages.theme:GetChildren()) do
            if card:IsA("Frame") and card.Name == "ThemeChoice" then
                local button = card:FindFirstChildOfClass("TextButton")
                if button then
                    local name = button:GetAttribute("ThemeName")
                    button.MouseButton1Click:Connect(function() applyTheme(name) end)
                end
            end
        end
    end

    -- V5 badge so it is obvious the right file loaded.
    local badge = main:FindFirstChild("V3Badge", true) or main:FindFirstChild("V4Badge", true)
    if badge and badge:IsA("TextLabel") then
        badge.Text = "V5 ♥"
        badge.Size = UDim2.fromOffset(58,22)
        badge.Font = Enum.Font.FredokaOne
    end

    -- Owner / developer join notification.
    local nameLower = lp.Name:lower()
    local displayLower = lp.DisplayName:lower()
    if nameLower == "kimqetras" or displayLower == "kimqetras" then
        pcall(function()
            StarterGui:SetCore("SendNotification", {
                Title = "Kimqetras HC",
                Text = "Kimqetras developer joined ♥",
                Duration = 5,
            })
        end)
    end
end)


-- ========================================================
-- KIMQETRAS HC V6 - FULL THEME + CLEAN OVERVIEW POLISH
-- ========================================================
task.spawn(function()
    task.wait(4.15)

    local Players = game:GetService("Players")
    local CoreGui = game:GetService("CoreGui")
    local UIS = game:GetService("UserInputService")
    local lp = Players.LocalPlayer
    local playerGui = lp:WaitForChild("PlayerGui")

    local gui = CoreGui:FindFirstChild("KimpetrasHC") or playerGui:FindFirstChild("KimpetrasHC")
    local main = gui and gui:FindFirstChild("Main")
    if not main or main:FindFirstChild("KimqV6Applied") then return end

    local mark = Instance.new("BoolValue")
    mark.Name = "KimqV6Applied"
    mark.Parent = main

    local THEMES = {
        Blue = {
            hot=Color3.fromRGB(47,91,255), hot2=Color3.fromRGB(104,151,255),
            bg=Color3.fromRGB(219,238,255), bg2=Color3.fromRGB(198,224,252),
            panel=Color3.fromRGB(235,244,255), card=Color3.fromRGB(247,251,255),
            text=Color3.fromRGB(48,76,142), sub=Color3.fromRGB(91,119,169),
            stroke=Color3.fromRGB(134,176,232), white=Color3.fromRGB(250,253,255),
        },
        Purple = {
            hot=Color3.fromRGB(151,61,255), hot2=Color3.fromRGB(192,132,255),
            bg=Color3.fromRGB(239,229,255), bg2=Color3.fromRGB(222,203,251),
            panel=Color3.fromRGB(248,241,255), card=Color3.fromRGB(253,249,255),
            text=Color3.fromRGB(91,55,147), sub=Color3.fromRGB(130,98,168),
            stroke=Color3.fromRGB(190,156,231), white=Color3.fromRGB(255,252,255),
        },
        Red = {
            hot=Color3.fromRGB(255,54,87), hot2=Color3.fromRGB(255,121,142),
            bg=Color3.fromRGB(255,230,235), bg2=Color3.fromRGB(250,207,216),
            panel=Color3.fromRGB(255,241,244), card=Color3.fromRGB(255,249,250),
            text=Color3.fromRGB(146,55,72), sub=Color3.fromRGB(177,98,112),
            stroke=Color3.fromRGB(234,155,170), white=Color3.fromRGB(255,253,253),
        },
        Pink = {
            hot=Color3.fromRGB(255,25,145), hot2=Color3.fromRGB(255,113,184),
            bg=Color3.fromRGB(255,226,240), bg2=Color3.fromRGB(250,202,226),
            panel=Color3.fromRGB(255,241,248), card=Color3.fromRGB(255,249,252),
            text=Color3.fromRGB(158,58,109), sub=Color3.fromRGB(185,101,142),
            stroke=Color3.fromRGB(238,159,199), white=Color3.fromRGB(255,253,255),
        },
        Aqua = {
            hot=Color3.fromRGB(0,177,235), hot2=Color3.fromRGB(70,212,250),
            bg=Color3.fromRGB(219,247,255), bg2=Color3.fromRGB(194,237,249),
            panel=Color3.fromRGB(237,250,255), card=Color3.fromRGB(248,254,255),
            text=Color3.fromRGB(42,108,139), sub=Color3.fromRGB(82,142,165),
            stroke=Color3.fromRGB(126,200,224), white=Color3.fromRGB(251,255,255),
        },
        Green = {
            hot=Color3.fromRGB(40,190,121), hot2=Color3.fromRGB(101,223,160),
            bg=Color3.fromRGB(225,248,237), bg2=Color3.fromRGB(201,238,220),
            panel=Color3.fromRGB(240,252,246), card=Color3.fromRGB(249,255,252),
            text=Color3.fromRGB(48,120,86), sub=Color3.fromRGB(88,151,118),
            stroke=Color3.fromRGB(138,209,173), white=Color3.fromRGB(252,255,253),
        },
    }

    local currentName = "Blue"
    local current = THEMES.Blue
    local applying = false

    local function corner(obj,r)
        local c=obj:FindFirstChildOfClass("UICorner") or Instance.new("UICorner")
        c.CornerRadius=UDim.new(0,r or 12)
        c.Parent=obj
        return c
    end
    local function stroke(obj,color,tr,th)
        local s=obj:FindFirstChildOfClass("UIStroke") or Instance.new("UIStroke")
        s.Color=color or current.stroke
        s.Transparency=tr or 0.2
        s.Thickness=th or 1
        s.Parent=obj
        return s
    end
    local function label(parent,text,size,pos,font,textSize,color,align)
        local l=Instance.new("TextLabel")
        l.Parent=parent
        l.BackgroundTransparency=1
        l.Size=size
        l.Position=pos
        l.Text=text
        l.Font=font or Enum.Font.Gotham
        l.TextSize=textSize or 14
        l.TextColor3=color or current.text
        l.TextXAlignment=align or Enum.TextXAlignment.Left
        l.TextYAlignment=Enum.TextYAlignment.Center
        return l
    end

    -- visible wording cleanup: no PWD branding in the interface.
    for _,obj in ipairs(main:GetDescendants()) do
        if obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("TextBox") then
            local txt=tostring(obj.Text or "")
            txt=txt:gsub("pwd%.MAIN","KIM.MAIN"):gsub("PWD","KIM"):gsub("pwd","KIM")
            txt=txt:gsub("Kimpetras HC","Kimqetras HC")
            obj.Text=txt
        end
    end

    -- Find page frames.
    local pages={}
    for _,d in ipairs(main:GetDescendants()) do
        if d:IsA("ScrollingFrame") and d.Name:match("Page$") then
            pages[d.Name:gsub("Page$",""):lower()]=d
        end
    end

    -- Make body text easier to read without changing the overall font style.
    for _,obj in ipairs(main:GetDescendants()) do
        if obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("TextBox") then
            if obj.TextSize <= 10 then obj.TextSize = 12
            elseif obj.TextSize <= 12 then obj.TextSize = 13
            elseif obj.TextSize <= 14 then obj.TextSize = 15 end
            if obj.Font == Enum.Font.Gotham then
                -- keep normal text feeling like the earlier version, just larger
                obj.Font = Enum.Font.Gotham
            end
        end
    end

    -- Restore the cute spaced hyphen separators, but make them thicker/easier to see.
    for _,obj in ipairs(main:GetDescendants()) do
        if obj:IsA("TextLabel") then
            local txt=tostring(obj.Text or "")
            local stripped=txt:gsub("[%s%-—]","")
            local dashCount=select(2,txt:gsub("[-—]",""))
            if stripped=="" and dashCount>=4 then
                obj.Text="-  -  -  -  -  -  -  -  -"
                obj.Font=Enum.Font.GothamBold
                obj.TextSize=14
            end
        end
    end

    -- Replace the overview's bottom half with two simple, clean cards.
    if pages.overview then
        local overview=pages.overview
        local hero=overview:FindFirstChild("V5OverviewHero") or overview:FindFirstChildWhichIsA("Frame")
        local oldSummary=overview:FindFirstChild("V5Summary")
        local oldNotes=overview:FindFirstChild("V5QuickNotes")
        if oldSummary then oldSummary:Destroy() end
        if oldNotes then oldNotes:Destroy() end

        -- Banner: ONLY Kimqetras HC + decorative hearts.
        local banner=main:FindFirstChild("V5Banner",true)
        if banner and banner:IsA("Frame") then
            for _,ch in ipairs(banner:GetChildren()) do
                if not ch:IsA("UICorner") and not ch:IsA("UIGradient") then ch:Destroy() end
            end
            label(banner,"Kimqetras HC",UDim2.new(1,0,0,52),UDim2.new(0,0,0.5,-26),Enum.Font.FredokaOne,38,current.white,Enum.TextXAlignment.Center)
            for _,h in ipairs({
                {"♥",.09,.32,30},{"♥",.20,.68,24},{"♥",.78,.66,25},{"♥",.91,.31,30},{"♥",.50,.17,22}
            }) do
                local x=label(banner,h[1],UDim2.fromOffset(46,46),UDim2.new(h[2],-23,h[3],-23),Enum.Font.FredokaOne,h[4],current.white,Enum.TextXAlignment.Center)
                x.TextTransparency=0.02
            end
        end

        local function card(parent,h,name)
            local f=Instance.new("Frame")
            f.Name=name
            f.Parent=parent
            f.Size=UDim2.new(1,-6,0,h)
            f.BackgroundColor3=current.panel
            f.BorderSizePixel=0
            corner(f,18)
            stroke(f,current.stroke,0.2,1)
            return f
        end

        local about=card(overview,126,"V6About")
        label(about,"♥  about",UDim2.new(1,-24,0,30),UDim2.fromOffset(12,12),Enum.Font.FredokaOne,23,current.hot)
        label(about,"-  -  -  -  -  -  -  -  -",UDim2.new(1,-24,0,18),UDim2.fromOffset(12,44),Enum.Font.GothamBold,14,current.stroke)
        local a=label(about,"A clean control hub with each tool on its own feature page. Use the left menu to switch between aiming, movement, visuals, avatar tools, HC features, settings, and more.",UDim2.new(1,-24,0,66),UDim2.fromOffset(12,68),Enum.Font.GothamSemibold,15,current.text)
        a.TextWrapped=true
        a.TextYAlignment=Enum.TextYAlignment.Top

        local controls=card(overview,126,"V6Controls")
        label(controls,"♡  controls",UDim2.new(1,-24,0,30),UDim2.fromOffset(12,12),Enum.Font.FredokaOne,23,current.hot)
        label(controls,"-  -  -  -  -  -  -  -  -",UDim2.new(1,-24,0,18),UDim2.fromOffset(12,44),Enum.Font.GothamBold,14,current.stroke)
        local c=label(controls,"Feature menu — switch tools\nRight Shift — hide / reopen\nTheme — recolor the complete interface and banner",UDim2.new(1,-24,0,58),UDim2.fromOffset(12,66),Enum.Font.GothamSemibold,15,current.text)
        c.TextWrapped=true
        c.TextYAlignment=Enum.TextYAlignment.Top
    end

    -- Cleaner wording on Information card.
    if pages.info then
        for _,obj in ipairs(pages.info:GetDescendants()) do
            if obj:IsA("TextLabel") and obj.Text:find("Famesgun") then
                obj.TextSize=math.max(obj.TextSize,15)
            end
        end
    end

    -- Palette references include every theme plus legacy colors, so nothing stays blue
    -- after switching to purple/pink/etc.
    local roleRefs={hot={},hot2={},bg={},bg2={},panel={},card={},text={},sub={},stroke={},white={}}
    for _,p in pairs(THEMES) do
        for role in pairs(roleRefs) do table.insert(roleRefs[role],p[role]) end
    end
    local legacy={
        hot={Color3.fromRGB(35,91,255),Color3.fromRGB(50,92,255),Color3.fromRGB(255,20,147),Color3.fromRGB(230,40,135)},
        hot2={Color3.fromRGB(83,132,255),Color3.fromRGB(95,140,255),Color3.fromRGB(255,175,215)},
        bg={Color3.fromRGB(221,239,255),Color3.fromRGB(223,235,252),Color3.fromRGB(255,214,232)},
        bg2={Color3.fromRGB(199,225,255),Color3.fromRGB(205,227,252),Color3.fromRGB(255,206,226)},
        panel={Color3.fromRGB(235,247,255),Color3.fromRGB(233,242,255),Color3.fromRGB(255,225,238)},
        card={Color3.fromRGB(246,251,255),Color3.fromRGB(255,247,250),Color3.fromRGB(255,242,248)},
        text={Color3.fromRGB(38,74,143),Color3.fromRGB(52,82,146),Color3.fromRGB(166,55,105)},
        sub={Color3.fromRGB(104,137,191),Color3.fromRGB(97,122,169),Color3.fromRGB(197,112,145)},
        stroke={Color3.fromRGB(146,188,242),Color3.fromRGB(137,176,230),Color3.fromRGB(255,175,215)},
        white={Color3.fromRGB(255,255,255),Color3.fromRGB(255,240,247)},
    }
    for role,arr in pairs(legacy) do for _,c in ipairs(arr) do table.insert(roleRefs[role],c) end end

    local function dist(a,b)
        local dr,dg,db=a.R-b.R,a.G-b.G,a.B-b.B
        return math.sqrt(dr*dr+dg*dg+db*db)
    end
    local function roleFor(c)
        local bestRole,best=nil,math.huge
        for role,refs in pairs(roleRefs) do
            for _,ref in ipairs(refs) do
                local d=dist(c,ref)
                if d<best then best,bestRole=d,role end
            end
        end
        if best<=0.24 then return bestRole end
        return nil
    end

    local function ancestorNamed(obj,names)
        local p=obj
        while p and p~=main do
            if names[p.Name] then return true end
            p=p.Parent
        end
        return false
    end
    local colorPickerExclude={FogSquare=true,FogHueBar=true,FogPreview=true,ESPHueBar=true,ESPColorPreview=true}

    local registry={}
    local function register(obj,prop)
        if ancestorNamed(obj,colorPickerExclude) then return end
        local ok,v=pcall(function() return obj[prop] end)
        if not ok or typeof(v)~="Color3" then return end
        local role=roleFor(v)
        if role then table.insert(registry,{obj=obj,prop=prop,role=role}) end
    end

    for _,obj in ipairs(main:GetDescendants()) do
        if obj:IsA("Frame") or obj:IsA("TextButton") or obj:IsA("TextBox") or obj:IsA("ImageLabel") or obj:IsA("ImageButton") then register(obj,"BackgroundColor3") end
        if obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("TextBox") then register(obj,"TextColor3") end
        if obj:IsA("ScrollingFrame") then register(obj,"ScrollBarImageColor3") end
        if obj:IsA("UIStroke") then register(obj,"Color") end
    end
    register(main,"BackgroundColor3")

    local function isThinBar(obj)
        if not obj:IsA("Frame") then return false end
        if ancestorNamed(obj,colorPickerExclude) then return false end
        local h=obj.AbsoluteSize.Y
        local w=obj.AbsoluteSize.X
        return h>0 and h<=12 and w>=90
    end

    local function styleSliders(p)
        -- Fog amount uses original unnamed track/fill/knob.
        local fog=main:FindFirstChild("FogPanel",true)
        if fog then
            for _,obj in ipairs(fog:GetDescendants()) do
                if isThinBar(obj) then
                    obj.BackgroundColor3=p.bg2
                    local frameChildren={}
                    for _,ch in ipairs(obj:GetChildren()) do if ch:IsA("Frame") then table.insert(frameChildren,ch) end end
                    for _,ch in ipairs(frameChildren) do
                        if ch.Size.Y.Scale>=0.9 and ch.Size.X.Scale>0 then ch.BackgroundColor3=p.hot end
                        if ch.AbsoluteSize.X<=22 and ch.AbsoluteSize.Y<=22 then ch.BackgroundColor3=p.hot end
                    end
                end
            end
        end
        -- Generic sliders.
        for _,obj in ipairs(main:GetDescendants()) do
            if isThinBar(obj) and not (fog and obj:IsDescendantOf(fog) and ancestorNamed(obj,colorPickerExclude)) then
                obj.BackgroundColor3=p.bg2
                for _,ch in ipairs(obj:GetChildren()) do
                    if ch:IsA("Frame") then
                        if ch.Size.Y.Scale>=0.8 and ch.Size.X.Scale>0 then ch.BackgroundColor3=p.hot end
                        if ch.AbsoluteSize.X<=22 and ch.AbsoluteSize.Y<=22 then ch.BackgroundColor3=p.hot end
                    end
                end
            end
        end
    end

    local function styleToggles(p)
        for _,btn in ipairs(main:GetDescendants()) do
            if btn:IsA("TextButton") and btn.Text=="" and btn.AbsoluteSize.X>=34 and btn.AbsoluteSize.X<=70 and btn.AbsoluteSize.Y<=30 then
                local circle=nil
                for _,ch in ipairs(btn:GetChildren()) do
                    if ch:IsA("Frame") and ch.AbsoluteSize.X<=24 then circle=ch break end
                end
                if circle then
                    local on = circle.Position.X.Scale > 0.4 or circle.Position.X.Offset > 10
                    btn.BackgroundColor3 = on and p.hot or p.bg2
                    circle.BackgroundColor3 = p.white
                    local st=btn:FindFirstChildOfClass("UIStroke")
                    if st then st.Color=p.stroke end
                end
            end
        end
    end

    local function styleThemeChoices(p)
        if not pages.theme then return end
        for _,card in ipairs(pages.theme:GetChildren()) do
            if card:IsA("Frame") and card.Name=="ThemeChoice" then
                card.BackgroundColor3=p.card
                local st=card:FindFirstChildOfClass("UIStroke")
                if st then st.Color=p.stroke end
                for _,ch in ipairs(card:GetChildren()) do
                    if ch:IsA("TextLabel") then ch.TextColor3=p.text end
                end
            end
        end
    end

    local function applyTheme(name)
        local p=THEMES[name]
        if not p then return end
        currentName=name
        current=p
        applying=true

        for _,entry in ipairs(registry) do
            if entry.obj.Parent and p[entry.role] then
                pcall(function() entry.obj[entry.prop]=p[entry.role] end)
            end
        end

        -- Explicit shell coverage so backgrounds/strokes never stay blue.
        main.BackgroundColor3=p.bg
        for _,obj in ipairs(main:GetDescendants()) do
            if obj:IsA("ScrollingFrame") then obj.ScrollBarImageColor3=p.hot end
            if obj:IsA("UIStroke") and not ancestorNamed(obj,colorPickerExclude) then obj.Color=p.stroke end
        end

        -- active navigation/buttons keep the hot color; inactive stay light.
        for _,btn in ipairs(main:GetDescendants()) do
            if btn:IsA("TextButton") then
                local clean=tostring(btn.Text or ""):lower()
                if clean:find("overview") or clean:find("silent aim") or clean:find("macro") or clean:find("whitelist") or clean:find("protection") or clean:find("anti fall") or clean:find("delay changer") or clean:find("esp") or clean:find("avatar") or clean:find("fog / atmosphere") or clean:find("force hit") or clean:find("hitbox") or clean:find("flamelock") or clean:find("camlock") or clean:find("headless") or clean:find("anti mod") or clean:find("settings") or clean:find("information") or clean:find("theme") then
                    if roleFor(btn.BackgroundColor3)=="hot" then
                        btn.BackgroundColor3=p.hot
                        btn.TextColor3=p.white
                    elseif btn.Parent and btn.Parent.Name~="ThemeChoice" then
                        btn.BackgroundColor3=p.panel
                        btn.TextColor3=p.text
                    end
                end
            end
        end

        -- Banner gradient fully follows theme.
        local gradient=main:FindFirstChild("V5BannerGradient",true)
        if gradient and gradient:IsA("UIGradient") then
            gradient.Color=ColorSequence.new({
                ColorSequenceKeypoint.new(0,p.bg2),
                ColorSequenceKeypoint.new(0.45,p.hot2),
                ColorSequenceKeypoint.new(1,p.hot),
            })
        end
        local banner=main:FindFirstChild("V5Banner",true)
        if banner then
            banner.BackgroundColor3=p.bg2
            for _,ch in ipairs(banner:GetChildren()) do
                if ch:IsA("TextLabel") then ch.TextColor3=p.white end
            end
        end

        local badge=main:FindFirstChild("V3Badge",true) or main:FindFirstChild("V4Badge",true) or main:FindFirstChild("V5Badge",true)
        if badge and badge:IsA("TextLabel") then
            badge.Text="V6 ♥"
            badge.BackgroundColor3=p.hot
            badge.TextColor3=p.white
        end

        styleSliders(p)
        styleToggles(p)
        styleThemeChoices(p)
        applying=false
    end

    -- Theme button connections. V6 runs after V5, so this final pass wins.
    if pages.theme then
        for _,card in ipairs(pages.theme:GetChildren()) do
            if card:IsA("Frame") and card.Name=="ThemeChoice" then
                local button=card:FindFirstChildOfClass("TextButton")
                if button then
                    local name=button:GetAttribute("ThemeName")
                    button.MouseButton1Click:Connect(function()
                        task.defer(function() applyTheme(name) end)
                    end)
                end
            end
        end
    end

    -- Keep nav and toggles themed after their original click callbacks run.
    for _,btn in ipairs(main:GetDescendants()) do
        if btn:IsA("TextButton") then
            btn.MouseButton1Click:Connect(function()
                task.defer(function() applyTheme(currentName) end)
            end)
        end
    end

    -- Label PWD -> KIM even if later UI text gets refreshed.
    main.DescendantAdded:Connect(function(obj)
        if obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("TextBox") then
            task.defer(function()
                if not obj.Parent then return end
                local txt=tostring(obj.Text or "")
                obj.Text=txt:gsub("pwd%.MAIN","KIM.MAIN"):gsub("PWD","KIM"):gsub("pwd","KIM")
                if obj.TextSize<=13 then obj.TextSize=14 end
            end)
        end
    end)

    applyTheme("Blue")

    -- ========================================================
    -- V7 polish: true theme previews + simple overview + motion
    -- ========================================================
    local TweenService = game:GetService("TweenService")

    -- Make every theme option show ITS OWN colors instead of being recolored
    -- to whichever theme is currently active.
    local function refreshThemeChoices()
        if not pages.theme then return end
        for _, card in ipairs(pages.theme:GetChildren()) do
            if card:IsA("Frame") and card.Name == "ThemeChoice" then
                local applyButton = card:FindFirstChildOfClass("TextButton")
                local themeName = applyButton and applyButton:GetAttribute("ThemeName")
                local palette = themeName and THEMES[themeName]
                if palette then
                    -- The row itself is a tiny preview of that theme.
                    card.BackgroundColor3 = palette.card
                    local cardStroke = card:FindFirstChildOfClass("UIStroke")
                    if cardStroke then
                        cardStroke.Color = palette.stroke
                        cardStroke.Thickness = themeName == currentName and 2 or 1
                        cardStroke.Transparency = themeName == currentName and 0.02 or 0.18
                    end

                    local directFrames = {}
                    for _, child in ipairs(card:GetChildren()) do
                        if child:IsA("Frame") then
                            table.insert(directFrames, child)
                        elseif child:IsA("TextLabel") then
                            child.TextColor3 = palette.text
                        end
                    end
                    table.sort(directFrames, function(a, b)
                        return a.Position.X.Offset < b.Position.X.Offset
                    end)

                    if directFrames[1] then
                        directFrames[1].BackgroundColor3 = palette.bg2
                        local s = directFrames[1]:FindFirstChildOfClass("UIStroke")
                        if s then s.Color = palette.stroke end
                    end
                    if directFrames[2] then
                        directFrames[2].BackgroundColor3 = palette.hot
                    end

                    if applyButton then
                        applyButton.BackgroundColor3 = palette.hot
                        applyButton.TextColor3 = palette.white
                    end
                end
            end
        end
    end

    -- Rewrite About Kimqetras HC as three clean stacked sentences.
    local about = pages.overview and pages.overview:FindFirstChild("V6About")
    if about then
        about.Size = UDim2.new(1, -6, 0, 126)

        for _, child in ipairs(about:GetChildren()) do
            if child:IsA("TextLabel") then
                local txt = tostring(child.Text or "")
                if not txt:lower():match("^♥%s+about$") and not txt:match("^[%s%-—]+$") then
                    child:Destroy()
                end
            end
        end

        local aboutBody = label(about, "Every feature has its own clean page.\nSwitch between aiming, movement, visuals, avatar tools, and utilities.\nPick a theme whenever you want the interface to match your style.", UDim2.new(1, -24, 0, 58), UDim2.fromOffset(12, 66), Enum.Font.GothamSemibold, 15, current.text)
        aboutBody.TextWrapped = true
        aboutBody.TextYAlignment = Enum.TextYAlignment.Top
    end

    -- Cute, subtle banner motion: only the decorative hearts float a few pixels.
    local banner = main:FindFirstChild("V5Banner", true)
    if banner then
        local heartIndex = 0
        for _, child in ipairs(banner:GetChildren()) do
            if child:IsA("TextLabel") and (child.Text == "♥" or child.Text == "♡" or child.Text == "❤") then
                heartIndex += 1
                if not child:GetAttribute("KimqFloat") then
                    child:SetAttribute("KimqFloat", true)
                    local startPos = child.Position
                    local offset = (heartIndex % 2 == 0) and 3 or -3
                    task.spawn(function()
                        task.wait(heartIndex * 0.08)
                        while child.Parent do
                            local up = UDim2.new(startPos.X.Scale, startPos.X.Offset, startPos.Y.Scale, startPos.Y.Offset + offset)
                            local down = UDim2.new(startPos.X.Scale, startPos.X.Offset, startPos.Y.Scale, startPos.Y.Offset - offset)
                            TweenService:Create(child, TweenInfo.new(1.35, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Position = up}):Play()
                            task.wait(1.37)
                            if not child.Parent then break end
                            TweenService:Create(child, TweenInfo.new(1.35, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Position = down}):Play()
                            task.wait(1.37)
                        end
                    end)
                end
            end
        end
    end

    -- Tiny hover lift for feature buttons; it feels responsive without being flashy.
    local navWords = {
        ["overview"] = true, ["silent aim"] = true, ["macro"] = true, ["whitelist"] = true,
        ["protection"] = true, ["anti fall"] = true, ["delay changer"] = true, ["esp"] = true,
        ["avatar"] = true, ["fog / atmosphere"] = true, ["hc silent aim"] = true, ["force hit"] = true,
        ["hitbox expander"] = true, ["flamelock"] = true, ["camlock"] = true, ["headless"] = true,
        ["anti mod"] = true, ["settings"] = true, ["theme"] = true, ["information"] = true,
    }

    local function cleanButtonText(txt)
        txt = tostring(txt or ""):lower()
        txt = txt:gsub("[❤♥♡]", "")
        txt = txt:gsub("^%s+", ""):gsub("%s+$", "")
        txt = txt:gsub("%s+", " ")
        return txt
    end

    for _, btn in ipairs(main:GetDescendants()) do
        if btn:IsA("TextButton") then
            local cleaned = cleanButtonText(btn.Text)
            if navWords[cleaned] then
                local scale = btn:FindFirstChild("KimqHoverScale")
                if not scale then
                    scale = Instance.new("UIScale")
                    scale.Name = "KimqHoverScale"
                    scale.Scale = 1
                    scale.Parent = btn
                    btn.MouseEnter:Connect(function()
                        TweenService:Create(scale, TweenInfo.new(0.22, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Scale = 1.012}):Play()
                    end)
                    btn.MouseLeave:Connect(function()
                        TweenService:Create(scale, TweenInfo.new(0.22, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Scale = 1}):Play()
                    end)
                end
            end
        end
    end

    -- Theme heart buttons get the same subtle hover effect.
    if pages.theme then
        for _, card in ipairs(pages.theme:GetChildren()) do
            if card:IsA("Frame") and card.Name == "ThemeChoice" then
                local btn = card:FindFirstChildOfClass("TextButton")
                if btn and not btn:FindFirstChild("KimqThemeScale") then
                    local scale = Instance.new("UIScale")
                    scale.Name = "KimqThemeScale"
                    scale.Scale = 1
                    scale.Parent = btn
                    btn.MouseEnter:Connect(function()
                        TweenService:Create(scale, TweenInfo.new(0.20, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Scale = 1.055}):Play()
                    end)
                    btn.MouseLeave:Connect(function()
                        TweenService:Create(scale, TweenInfo.new(0.20, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Scale = 1}):Play()
                    end)
                end
            end
        end
    end

    -- V6's theme engine intentionally recolors every control after clicks.
    -- Re-apply the independent theme previews afterward so the chooser stays multicolor.
    for _, btn in ipairs(main:GetDescendants()) do
        if btn:IsA("TextButton") then
            btn.MouseButton1Click:Connect(function()
                task.delay(0.08, refreshThemeChoices)
            end)
        end
    end

    -- Update About text whenever the theme changes so its new labels follow the active palette.
    local function refreshV7TextColors()
        if not about then return end
        for _, child in ipairs(about:GetChildren()) do
            if child:IsA("TextLabel") then
                local txt = tostring(child.Text or "")
                if txt:find("Every feature") or txt:find("Switch between") or txt:find("Pick a theme") then
                    child.TextColor3 = current.text
                end
            end
        end
    end
    for _, btn in ipairs(main:GetDescendants()) do
        if btn:IsA("TextButton") then
            btn.MouseButton1Click:Connect(function()
                task.delay(0.09, refreshV7TextColors)
            end)
        end
    end

    -- V8 font + spacing polish: keep card titles and body copy consistent.
    if about then
        for _, child in ipairs(about:GetChildren()) do
            if child:IsA("TextLabel") then
                local txt = tostring(child.Text or "")
                if txt:lower():match("^♥%s+about$") then
                    child.Font = Enum.Font.FredokaOne
                    child.TextSize = 23
                elseif not txt:match("^[%s%-—]+$") then
                    child.Font = Enum.Font.GothamSemibold
                    child.TextSize = 15
                    child.TextXAlignment = Enum.TextXAlignment.Left
                end
            end
        end
    end
    local controlsCard = pages.overview and pages.overview:FindFirstChild("V6Controls")
    if controlsCard then
        for _, child in ipairs(controlsCard:GetChildren()) do
            if child:IsA("TextLabel") then
                local txt = tostring(child.Text or "")
                if txt:lower():find("controls") then
                    child.Font = Enum.Font.FredokaOne
                    child.TextSize = 23
                elseif not txt:match("^[%s%-—]+$") then
                    child.Font = Enum.Font.GothamSemibold
                    child.TextSize = 15
                    child.TextXAlignment = Enum.TextXAlignment.Left
                end
            end
        end
    end

    -- Mark this visibly so it is obvious the newest build loaded.
    local badge = main:FindFirstChild("V3Badge", true) or main:FindFirstChild("V4Badge", true) or main:FindFirstChild("V5Badge", true)
    if badge and badge:IsA("TextLabel") then
        badge.Text = "V8 ♥"
    end

    refreshThemeChoices()
    refreshV7TextColors()

    -- Reveal only after V7 is fully built/themed, preventing older layouts from flashing.
    main.Visible = true
    gui.Enabled = true
end)



-- =============================================================
-- KIMQETRAS HC V31 FINAL REBUILD
-- Fresh shell over the stable V8 backend. Existing controls are
-- re-parented instead of recreated so their original callbacks stay intact.
-- =============================================================
task.spawn(function()
    local Players = game:GetService("Players")
    local UIS = game:GetService("UserInputService")
    local RunService = game:GetService("RunService")
    local TweenService = game:GetService("TweenService")
    local CoreGui = game:GetService("CoreGui")
    local ContentProvider = game:GetService("ContentProvider")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local Lighting = game:GetService("Lighting")
    local Terrain = workspace:FindFirstChildOfClass("Terrain")
    local lp = Players.LocalPlayer
    local pg = lp:WaitForChild("PlayerGui")
    local cam = workspace.CurrentCamera
    local A = _G.KimqV31Assets or {
        Pompom = "rbxassetid://98379642851874",
        PompomIcon = "rbxassetid://109428653544528",
        Paw = "rbxassetid://138088505213748",
        Title = "rbxassetid://99152748483206",
        Subtitle = "rbxassetid://94248590271491",
        Minus = "rbxassetid://121030051960124",
        X = "rbxassetid://129350478207195",
        ToggleOn = "rbxassetid://95234565377817",
        ToggleOff = "rbxassetid://97764595221865",
        Reset = "rbxassetid://104585185562435",
    }

    -- V8's last visual patch settles at ~4.15s. This is still far shorter than V22-V30.
    task.wait(4.35)

    local gui = CoreGui:FindFirstChild("KimpetrasHC") or pg:FindFirstChild("KimpetrasHC")
    local oldMain = gui and gui:FindFirstChild("Main")
    if not gui or not oldMain then
        _G.KimqV31Ready = true
        local l=_G.KimqV31Loader; if l and l.Gui then pcall(function() l.Gui:Destroy() end) end
        return
    end
    if gui:FindFirstChild("KimqV31Shell") then return end

    gui.Enabled = false

    local PALS = {
        Blue={bg=Color3.fromRGB(218,236,255),shell=Color3.fromRGB(242,249,255),panel=Color3.fromRGB(236,246,255),row=Color3.fromRGB(247,251,255),soft=Color3.fromRGB(211,232,255),hot=Color3.fromRGB(39,91,255),hot2=Color3.fromRGB(82,147,255),text=Color3.fromRGB(43,84,170),sub=Color3.fromRGB(94,125,181),line=Color3.fromRGB(126,174,239),white=Color3.fromRGB(252,254,255)},
        Purple={bg=Color3.fromRGB(235,226,255),shell=Color3.fromRGB(250,246,255),panel=Color3.fromRGB(245,238,255),row=Color3.fromRGB(252,249,255),soft=Color3.fromRGB(226,208,255),hot=Color3.fromRGB(135,61,244),hot2=Color3.fromRGB(179,112,255),text=Color3.fromRGB(95,61,151),sub=Color3.fromRGB(130,103,171),line=Color3.fromRGB(194,160,236),white=Color3.fromRGB(255,253,255)},
        Red={bg=Color3.fromRGB(255,225,229),shell=Color3.fromRGB(255,248,249),panel=Color3.fromRGB(255,239,242),row=Color3.fromRGB(255,251,252),soft=Color3.fromRGB(255,210,218),hot=Color3.fromRGB(230,57,76),hot2=Color3.fromRGB(255,104,120),text=Color3.fromRGB(151,61,74),sub=Color3.fromRGB(180,103,113),line=Color3.fromRGB(237,158,169),white=Color3.fromRGB(255,253,253)},
        Pink={bg=Color3.fromRGB(255,228,241),shell=Color3.fromRGB(255,248,252),panel=Color3.fromRGB(255,239,248),row=Color3.fromRGB(255,251,253),soft=Color3.fromRGB(255,209,233),hot=Color3.fromRGB(244,73,158),hot2=Color3.fromRGB(255,126,191),text=Color3.fromRGB(166,69,120),sub=Color3.fromRGB(191,112,151),line=Color3.fromRGB(239,168,205),white=Color3.fromRGB(255,253,254)},
        Aqua={bg=Color3.fromRGB(215,246,247),shell=Color3.fromRGB(244,253,253),panel=Color3.fromRGB(232,250,250),row=Color3.fromRGB(249,254,254),soft=Color3.fromRGB(196,239,241),hot=Color3.fromRGB(32,180,191),hot2=Color3.fromRGB(77,213,221),text=Color3.fromRGB(44,124,131),sub=Color3.fromRGB(92,151,156),line=Color3.fromRGB(126,207,212),white=Color3.fromRGB(252,255,255)},
        Green={bg=Color3.fromRGB(224,247,229),shell=Color3.fromRGB(248,253,249),panel=Color3.fromRGB(237,250,240),row=Color3.fromRGB(251,254,252),soft=Color3.fromRGB(207,240,214),hot=Color3.fromRGB(47,174,91),hot2=Color3.fromRGB(89,207,127),text=Color3.fromRGB(57,127,81),sub=Color3.fromRGB(101,153,119),line=Color3.fromRGB(145,208,166),white=Color3.fromRGB(253,255,253)},
    }
    local currentName="Blue"
    local P=PALS.Blue

    local function corner(o,r)
        local c=o:FindFirstChildOfClass("UICorner") or Instance.new("UICorner"); c.CornerRadius=UDim.new(0,r or 12); c.Parent=o; return c
    end
    local function stroke(o,c,t,w)
        local s=o:FindFirstChildOfClass("UIStroke") or Instance.new("UIStroke"); s.Color=c; s.Transparency=t or 0; s.Thickness=w or 1; s.Parent=o; return s
    end
    local function label(parent,text,size,pos,font,sz,color,align)
        local x=Instance.new("TextLabel",parent); x.BackgroundTransparency=1; x.Size=size; x.Position=pos; x.Text=text; x.Font=font or Enum.Font.Gotham; x.TextSize=sz or 13; x.TextColor3=color or P.text; x.TextXAlignment=align or Enum.TextXAlignment.Left; x.TextYAlignment=Enum.TextYAlignment.Center; return x
    end
    local function image(parent,id,size,pos,z)
        local x=Instance.new("ImageLabel",parent); x.BackgroundTransparency=1; x.Image=id; x.Size=size; x.Position=pos; x.ScaleType=Enum.ScaleType.Fit; x.ZIndex=z or 4; return x
    end
    local function buttonImage(parent,id,size,pos)
        local b=Instance.new("ImageButton",parent); b.BackgroundTransparency=1; b.Image=id; b.Size=size; b.Position=pos; b.ScaleType=Enum.ScaleType.Fit; b.AutoButtonColor=false; b.ZIndex=12; return b
    end
    local function norm(s) return tostring(s or ""):lower():gsub("[♡♥]",""):gsub("^%s+",""):gsub("%s+$",""):gsub("%s+"," ") end

    -- Preserve working page objects and their event connections before deleting the old shell.
    local vault=Instance.new("Folder",gui); vault.Name="KimqV31PageVault"
    local pages={}
    for _,d in ipairs(oldMain:GetDescendants()) do
        if d:IsA("ScrollingFrame") and d.Name:match("Page$") then
            local key=d.Name:gsub("Page$",""):lower()
            pages[key]=d
        end
    end
    for _,p in pairs(pages) do p.Parent=vault end
    oldMain:Destroy()

    local main=Instance.new("Frame",gui)
    main.Name="KimqV31Shell"
    main.AnchorPoint=Vector2.new(.5,.5)
    main.Position=UDim2.fromScale(.5,.5)
    main.Size=UDim2.fromOffset(1120,680)
    main.BackgroundColor3=P.bg
    main.BorderSizePixel=0
    main.Active=true
    corner(main,26); stroke(main,P.hot,.10,2)

    local uiScale=Instance.new("UIScale",main)
    local function fit()
        local v=cam and cam.ViewportSize or Vector2.new(1280,720)
        uiScale.Scale=math.min(1, math.max(.44, math.min((v.X-34)/1120,(v.Y-34)/680)))
    end
    fit()
    if cam then cam:GetPropertyChangedSignal("ViewportSize"):Connect(fit) end

    -- Stitching sits only in the 18px outer gutter.
    local stitch=Instance.new("Frame",main); stitch.Name="V31Stitching"; stitch.BackgroundTransparency=1; stitch.Position=UDim2.fromOffset(15,15); stitch.Size=UDim2.new(1,-30,1,-30); stitch.ZIndex=2
    local stitchParts={}
    local function stitchPart(size,pos)
        local d=Instance.new("Frame",stitch); d.AnchorPoint=Vector2.new(.5,.5); d.Size=size; d.Position=pos; d.BackgroundColor3=P.line; d.BackgroundTransparency=.28; d.BorderSizePixel=0; corner(d,2); table.insert(stitchParts,d)
    end
    for i=0,34 do for _,yy in ipairs({0,1}) do stitchPart(UDim2.fromOffset(12,2),UDim2.new(i/34,0,yy,0)) end end
    for i=0,20 do for _,xx in ipairs({0,1}) do stitchPart(UDim2.fromOffset(2,12),UDim2.new(xx,0,i/20,0)) end end

    -- Header: actual user decals, no fake banner.
    local header=Instance.new("Frame",main); header.Name="V31Header"; header.Position=UDim2.fromOffset(28,25); header.Size=UDim2.new(1,-56,0,96); header.BackgroundTransparency=1; header.ZIndex=3
    local pompom=image(header,A.Pompom,UDim2.fromOffset(98,94),UDim2.fromOffset(0,0),7)
    local titleImg=image(header,A.Title,UDim2.fromOffset(315,64),UDim2.fromOffset(94,1),7)
    local subImg=image(header,A.Subtitle,UDim2.fromOffset(173,40),UDim2.fromOffset(139,53),7)
    local titleFallback=label(header,"Kimqetras",UDim2.fromOffset(315,56),UDim2.fromOffset(100,2),Enum.Font.FredokaOne,38,P.hot); titleFallback.Visible=false
    local subFallback=label(header,"silent hc  ♡",UDim2.fromOffset(200,34),UDim2.fromOffset(140,55),Enum.Font.FredokaOne,20,P.hot); subFallback.Visible=false
    local minus=buttonImage(header,A.Minus,UDim2.fromOffset(48,48),UDim2.new(1,-112,0,17))
    local close=buttonImage(header,A.X,UDim2.fromOffset(48,48),UDim2.new(1,-55,0,17))

    local side=Instance.new("Frame",main); side.Name="V31Sidebar"; side.Position=UDim2.fromOffset(30,124); side.Size=UDim2.fromOffset(238,526); side.BackgroundColor3=P.panel; side.BorderSizePixel=0; side.ZIndex=3; corner(side,18); stroke(side,P.line,.18,1)
    local sidePaw=image(side,A.Paw,UDim2.fromOffset(29,29),UDim2.fromOffset(15,12),5)
    local sideTitle=label(side,"FEATURES",UDim2.new(1,-58,0,30),UDim2.fromOffset(48,10),Enum.Font.FredokaOne,18,P.text)
    local sideDash=label(side,"-  -  -  -  -  -  -",UDim2.new(1,-28,0,15),UDim2.fromOffset(14,39),Enum.Font.GothamBold,9,P.line,Enum.TextXAlignment.Center)
    local nav=Instance.new("ScrollingFrame",side); nav.Name="V31Nav"; nav.Position=UDim2.fromOffset(9,58); nav.Size=UDim2.new(1,-18,1,-105); nav.BackgroundTransparency=1; nav.BorderSizePixel=0; nav.ScrollBarThickness=3; nav.ScrollBarImageColor3=P.hot; nav.ZIndex=4
    local navList=Instance.new("UIListLayout",nav); navList.Padding=UDim.new(0,6); navList.SortOrder=Enum.SortOrder.LayoutOrder; navList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() nav.CanvasSize=UDim2.new(0,0,0,navList.AbsoluteContentSize.Y+7) end)
    local hint=Instance.new("Frame",side); hint.Size=UDim2.new(1,-18,0,34); hint.Position=UDim2.new(0,9,1,-42); hint.BackgroundColor3=P.row; hint.BorderSizePixel=0; hint.ZIndex=5; corner(hint,10); stroke(hint,P.line,.3,1)
    local hintText=label(hint,"Right Shift / Right Click = hide / show",UDim2.fromScale(1,1),UDim2.fromOffset(0,0),Enum.Font.GothamSemibold,10,P.sub,Enum.TextXAlignment.Center)

    local right=Instance.new("Frame",main); right.Name="V31Right"; right.Position=UDim2.fromOffset(282,124); right.Size=UDim2.new(1,-312,1,-154); right.BackgroundTransparency=1; right.ZIndex=3
    local pageHead=Instance.new("Frame",right); pageHead.Size=UDim2.new(1,0,0,72); pageHead.BackgroundColor3=P.panel; pageHead.BorderSizePixel=0; corner(pageHead,17); stroke(pageHead,P.line,.18,1)
    local headPaw=image(pageHead,A.Paw,UDim2.fromOffset(29,29),UDim2.fromOffset(16,12),5)
    local pageTitle=label(pageHead,"overview",UDim2.new(1,-70,0,28),UDim2.fromOffset(51,8),Enum.Font.FredokaOne,20,P.text)
    local pageDesc=label(pageHead,"your account, quick notes, and controls",UDim2.new(1,-36,0,21),UDim2.fromOffset(18,40),Enum.Font.Gotham,11,P.sub)
    local headDash=label(pageHead,"-  -  -  -  -  -  -",UDim2.fromOffset(160,16),UDim2.new(1,-177,0,8),Enum.Font.GothamBold,9,P.line,Enum.TextXAlignment.Right)
    local content=Instance.new("Frame",right); content.Name="V31PageHost"; content.Position=UDim2.fromOffset(0,84); content.Size=UDim2.new(1,0,1,-84); content.BackgroundTransparency=1

    -- Put all original working pages into the new content host.
    for _,p in pairs(pages) do
        p.Parent=content; p.Size=UDim2.fromScale(1,1); p.Position=UDim2.fromOffset(0,0); p.BackgroundTransparency=1; p.ScrollBarThickness=3; p.ScrollBarImageColor3=P.hot; p.Visible=false
    end
    vault:Destroy()

    local meta={
        overview={"overview","your account, quick notes, and controls"}, silent={"silent aim","cursor targeting, FOV, hit part, and aim key"}, macro={"macro","speed controls and your macro activation key"}, whitelist={"whitelist","players targeting and ESP should ignore"}, protection={"protection","anti-aim-view and protection controls"}, antifall={"anti fall","keep your character from staying fallen"}, delay={"delay changer","weapon cooldown values"}, esp={"esp","boxes, names, health, tracers, and skeletons"}, avatar={"avatar","avatar copying and local visual accessories"}, fog={"fog / atmosphere","fog color picker, presets, and saturation"}, hcsilent={"HC silent aim","Hood Customs targeting and prediction"}, forcehit={"force hit","force-hit controls and fire settings"}, hitbox={"hitbox expander","hitbox size and visibility"}, flamelock={"flamelock","lock key, hit part, prediction, and offsets"}, camlock={"camlock","lock behavior, smoothing, and checks"}, headless={"headless","local visual headless"}, antimod={"anti mod","notification and anti-mod controls"}, settings={"settings","FPS and local configuration"}, theme={"theme","recolor the complete interface"}, info={"information","credits and developer information"}, environment={"environment","cute local seasonal map styles"}, weaponskins={"weapon skins","choose a weapon and apply one of its local wraps"},
    }
    local order={"overview","silent","macro","whitelist","protection","antifall","delay","esp","avatar","fog","environment","weaponskins","hcsilent","forcehit","hitbox","flamelock","camlock","headless","antimod","settings","theme","info"}

    -- Build a normal page helper for V31-only pages.
    local function newPage(key)
        local p=Instance.new("ScrollingFrame",content); p.Name=key.."Page"; p.Size=UDim2.fromScale(1,1); p.BackgroundTransparency=1; p.BorderSizePixel=0; p.Visible=false; p.ScrollBarThickness=3; p.ScrollBarImageColor3=P.hot
        local pad=Instance.new("UIPadding",p); pad.PaddingRight=UDim.new(0,4); pad.PaddingBottom=UDim.new(0,5)
        local l=Instance.new("UIListLayout",p); l.Padding=UDim.new(0,9); l.SortOrder=Enum.SortOrder.LayoutOrder; l:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() p.CanvasSize=UDim2.new(0,0,0,l.AbsoluteContentSize.Y+10) end)
        pages[key]=p; return p
    end
    if not pages.environment then pages.environment=newPage("environment") end
    if not pages.weaponskins then pages.weaponskins=newPage("weaponskins") end

    local themedImages={sidePaw,headPaw}
    local themedFrames={main,side,hint,pageHead}
    local themedTexts={sideTitle,hintText,pageTitle,pageDesc,headDash,sideDash}
    local navButtons={}

    local function addImg(parent,id,size,pos)
        local x=image(parent,id,size,pos,6); table.insert(themedImages,x); return x
    end
    local function card(page,h,name)
        local f=Instance.new("Frame",page); f.Name=name or "V31Card"; f.Size=UDim2.new(1,-6,0,h); f.BackgroundColor3=P.row; f.BorderSizePixel=0; corner(f,13); stroke(f,P.line,.22,1); return f
    end

    -- Rebuild overview completely; no banner.
    do
        local p=pages.overview
        for _,c in ipairs(p:GetChildren()) do if not c:IsA("UIListLayout") and not c:IsA("UIPadding") then c:Destroy() end end
        local list=p:FindFirstChildOfClass("UIListLayout") or Instance.new("UIListLayout",p); list.Padding=UDim.new(0,9); list.SortOrder=Enum.SortOrder.LayoutOrder; list:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() p.CanvasSize=UDim2.new(0,0,0,list.AbsoluteContentSize.Y+10) end)
        local welcome=card(p,150,"V31Welcome")
        local av=Instance.new("ImageLabel",welcome); av.Size=UDim2.fromOffset(86,86); av.Position=UDim2.fromOffset(18,33); av.BackgroundColor3=P.soft; av.BorderSizePixel=0; corner(av,999); stroke(av,P.line,.18,1); pcall(function() av.Image=Players:GetUserThumbnailAsync(lp.UserId,Enum.ThumbnailType.HeadShot,Enum.ThumbnailSize.Size180x180) end)
        addImg(welcome,A.Paw,UDim2.fromOffset(27,27),UDim2.fromOffset(18,8))
        local wt=label(welcome,"welcome, "..lp.DisplayName:lower(),UDim2.new(1,-245,0,32),UDim2.fromOffset(120,28),Enum.Font.FredokaOne,24,P.text); table.insert(themedTexts,wt)
        local wu=label(welcome,"@"..lp.Name.."  •  Kimqetras HC",UDim2.new(1,-245,0,20),UDim2.fromOffset(120,60),Enum.Font.GothamBold,11,P.sub); table.insert(themedTexts,wu)
        local wd=label(welcome,"Every feature is still separated into its own page.\nPick a feature on the left, or use Right Shift / Right Click to hide the GUI.",UDim2.new(1,-255,0,50),UDim2.fromOffset(120,84),Enum.Font.GothamSemibold,12,P.text); wd.TextWrapped=true; wd.TextYAlignment=Enum.TextYAlignment.Top; table.insert(themedTexts,wd)
        local pm=addImg(welcome,A.Pompom,UDim2.fromOffset(112,106),UDim2.new(1,-130,0,24))

        local about=card(p,126,"V31About"); addImg(about,A.Paw,UDim2.fromOffset(27,27),UDim2.fromOffset(16,12)); local at=label(about,"about",UDim2.new(1,-58,0,28),UDim2.fromOffset(49,9),Enum.Font.FredokaOne,20,P.text); table.insert(themedTexts,at); local ad=label(about,"-  -  -  -  -  -  -  -",UDim2.new(1,-28,0,15),UDim2.fromOffset(14,38),Enum.Font.GothamBold,9,P.line); table.insert(themedTexts,ad); local ab=label(about,"Every feature has its own clean page.\nSwitch between aiming, movement, visuals, avatar tools, and utilities.\nPick a theme whenever you want the interface to match your style.",UDim2.new(1,-28,0,62),UDim2.fromOffset(14,56),Enum.Font.GothamSemibold,12,P.text); ab.TextWrapped=true; ab.TextYAlignment=Enum.TextYAlignment.Top; table.insert(themedTexts,ab)

        local controls=card(p,94,"V31Controls"); addImg(controls,A.Paw,UDim2.fromOffset(27,27),UDim2.fromOffset(16,12)); local ct=label(controls,"controls",UDim2.new(1,-58,0,28),UDim2.fromOffset(49,9),Enum.Font.FredokaOne,20,P.text); table.insert(themedTexts,ct); local cd=label(controls,"-  -  -  -  -  -  -  -",UDim2.new(1,-28,0,15),UDim2.fromOffset(14,38),Enum.Font.GothamBold,9,P.line); table.insert(themedTexts,cd); local cb=label(controls,"Right Shift / Right Click = hide / show the GUI",UDim2.new(1,-28,0,27),UDim2.fromOffset(14,57),Enum.Font.GothamSemibold,12,P.text); table.insert(themedTexts,cb)
    end

    -- Style original feature controls without replacing their callbacks.
    local function isColorWidget(o)
        local n=o.Name:lower()
        if n:find("fogsquare") or n:find("hue") or n:find("colorpicker") or n:find("preview") then return true end
        if o:IsA("Frame") then
            local g=o:FindFirstChildOfClass("UIGradient")
            if g and #g.Color.Keypoints>3 then return true end
        end
        return false
    end
    local function skinToggle(btn)
        if btn:FindFirstChild("V31ToggleArt") then return end
        local circle=nil
        for _,c in ipairs(btn:GetChildren()) do if c:IsA("Frame") and c:FindFirstChildOfClass("UICorner") then circle=c break end end
        if not circle then return end
        btn.BackgroundTransparency=1
        circle.BackgroundTransparency=1
        local art=Instance.new("ImageLabel",btn); art.Name="V31ToggleArt"; art.BackgroundTransparency=1; art.Size=UDim2.new(1,8,1,8); art.Position=UDim2.fromOffset(-4,-4); art.ScaleType=Enum.ScaleType.Fit; art.ZIndex=btn.ZIndex+2; table.insert(themedImages,art)
        local function sync() art.Image=(circle.Position.X.Scale>.5) and A.ToggleOn or A.ToggleOff end
        sync(); circle:GetPropertyChangedSignal("Position"):Connect(sync)
    end
    local function stylePage(p)
        if p==pages.overview or p==pages.environment or p==pages.weaponskins then return end
        p.ScrollBarImageColor3=P.hot
        for _,o in ipairs(p:GetDescendants()) do
            if o:IsA("Frame") then
                if not isColorWidget(o) then
                    local parentPage=o.Parent==p
                    if parentPage or (o.Size.Y.Offset>=30 and o.Size.Y.Offset<=95) then
                        o.BackgroundColor3=P.row; o.BorderSizePixel=0; corner(o,11); local s=o:FindFirstChildOfClass("UIStroke"); if s then s.Color=P.line; s.Transparency=.26 end
                    elseif o.Size.Y.Offset<=10 and o.Size.X.Scale>.35 then
                        o.BackgroundColor3=P.soft
                        for _,c in ipairs(o:GetChildren()) do if c:IsA("Frame") and c.Size.Y.Scale==1 then c.BackgroundColor3=P.hot end end
                    end
                end
            elseif o:IsA("TextLabel") then
                if o.TextSize>=18 or o.Font==Enum.Font.FredokaOne then o.Font=Enum.Font.FredokaOne; o.TextColor3=P.text else o.Font=Enum.Font.GothamSemibold; o.TextColor3=P.text end
            elseif o:IsA("TextButton") then
                if o.Text=="" and o.Size.Y.Offset>=18 and o.Size.Y.Offset<=28 and o.Size.X.Offset>=36 and o.Size.X.Offset<=60 then
                    skinToggle(o)
                else
                    o.BackgroundColor3=P.soft; o.TextColor3=P.text; o.Font=Enum.Font.GothamBold; corner(o,9); local s=o:FindFirstChildOfClass("UIStroke"); if s then s.Color=P.line end
                end
            elseif o:IsA("TextBox") then
                o.BackgroundColor3=P.soft; o.TextColor3=P.text; o.PlaceholderColor3=P.sub; o.Font=Enum.Font.Gotham; corner(o,9); local s=o:FindFirstChildOfClass("UIStroke"); if s then s.Color=P.line end
            elseif o:IsA("UIStroke") and o.Parent and not isColorWidget(o.Parent) then
                o.Color=P.line
            end
        end
    end

    -- Local accessory try-on, using the proven manual attachment method.
    do
        local p=pages.avatar
        if p and not p:FindFirstChild("V31AccessoryCard") then
            local c=card(p,160,"V31AccessoryCard")
            addImg(c,A.Paw,UDim2.fromOffset(27,27),UDim2.fromOffset(14,11)); local tt=label(c,"local accessory",UDim2.new(1,-54,0,27),UDim2.fromOffset(48,8),Enum.Font.FredokaOne,19,P.text); table.insert(themedTexts,tt)
            local input=Instance.new("TextBox",c); input.Size=UDim2.new(1,-28,0,34); input.Position=UDim2.fromOffset(14,43); input.BackgroundColor3=P.soft; input.BorderSizePixel=0; input.PlaceholderText="paste accessory asset ID"; input.PlaceholderColor3=P.sub; input.Text=""; input.TextColor3=P.text; input.Font=Enum.Font.Gotham; input.TextSize=12; input.ClearTextOnFocus=false; input.TextXAlignment=Enum.TextXAlignment.Left; corner(input,9); stroke(input,P.line,.3,1); local ip=Instance.new("UIPadding",input); ip.PaddingLeft=UDim.new(0,10)
            local equip=Instance.new("TextButton",c); equip.Size=UDim2.new(.58,-7,0,34); equip.Position=UDim2.fromOffset(14,87); equip.BackgroundColor3=P.hot; equip.BorderSizePixel=0; equip.Text="equip locally"; equip.TextColor3=P.white; equip.Font=Enum.Font.GothamBold; equip.TextSize=12; corner(equip,9)
            local remove=Instance.new("TextButton",c); remove.Size=UDim2.new(.42,-21,0,34); remove.Position=UDim2.new(.58,7,0,87); remove.BackgroundColor3=P.soft; remove.BorderSizePixel=0; remove.Text="remove all"; remove.TextColor3=P.text; remove.Font=Enum.Font.GothamBold; remove.TextSize=12; corner(remove,9); stroke(remove,P.line,.3,1)
            local status=label(c,"client-side visual only",UDim2.new(1,-28,0,24),UDim2.fromOffset(14,127),Enum.Font.Gotham,11,P.sub); table.insert(themedTexts,status)
            _G.KimqV31AccessoryIds=_G.KimqV31AccessoryIds or {}
            local function cleanLocal(char)
                if not char then return end
                for _,x in ipairs(char:GetChildren()) do if x:IsA("Accessory") and x:GetAttribute("KimqV31Accessory") then x:Destroy() end end
            end
            local function equipOne(id,quiet)
                local char=lp.Character; local hum=char and char:FindFirstChildOfClass("Humanoid"); local head=char and char:FindFirstChild("Head")
                if not char or not hum or not head then if not quiet then status.Text="character is not ready" end return false end
                local loaded
                local ok,res=pcall(function() return game:GetObjects("rbxassetid://"..id) end)
                if ok and type(res)=="table" then for _,x in ipairs(res) do if x:IsA("Accessory") then loaded=x break elseif x:IsA("Model") then loaded=x:FindFirstChildWhichIsA("Accessory",true); if loaded then break end end end end
                if not loaded then if not quiet then status.Text="could not load that accessory" end return false end
                local acc=loaded:Clone(); local handle=acc:FindFirstChild("Handle")
                if not handle or not handle:IsA("BasePart") then acc:Destroy(); if not quiet then status.Text="that item has no accessory Handle" end return false end
                for _,d in ipairs(acc:GetDescendants()) do if d:IsA("Script") or d:IsA("LocalScript") or d:IsA("ModuleScript") then d:Destroy() elseif d:IsA("BasePart") then d.CanCollide=false; d.CanTouch=false; d.CanQuery=false; d.Massless=true; d.Anchored=false; d.AssemblyLinearVelocity=Vector3.zero; d.AssemblyAngularVelocity=Vector3.zero elseif d:IsA("Weld") or d:IsA("Motor6D") or d:IsA("WeldConstraint") then d:Destroy() end end
                local ha=handle:FindFirstChildWhichIsA("Attachment")
                local ba=ha and char:FindFirstChild(ha.Name,true)
                local body=ba and ba.Parent
                if not ba or not body or not body:IsA("BasePart") then acc:Destroy(); if not quiet then status.Text="this accessory attachment is unsupported" end return false end
                acc.Parent=char; handle.CFrame=body.CFrame*ba.CFrame*ha.CFrame:Inverse()
                local w=Instance.new("Weld",handle); w.Name="KimqV31AccessoryWeld"; w.Part0=body; w.Part1=handle; w.C0=ba.CFrame; w.C1=ha.CFrame
                acc:SetAttribute("KimqV31Accessory",true); acc:SetAttribute("KimqAssetId",id)
                if not quiet then status.Text="equipped locally ♡" end
                return true
            end
            equip.MouseButton1Click:Connect(function()
                local id=tostring(input.Text):match("%d+"); if not id then status.Text="enter a valid asset ID" return end
                for _,v in ipairs(_G.KimqV31AccessoryIds) do if v==id then equipOne(id,false); return end end
                if equipOne(id,false) then table.insert(_G.KimqV31AccessoryIds,id) end
            end)
            remove.MouseButton1Click:Connect(function() table.clear(_G.KimqV31AccessoryIds); cleanLocal(lp.Character); status.Text="removed local accessories" end)
            lp.CharacterAdded:Connect(function(char) task.delay(1,function() for _,id in ipairs(_G.KimqV31AccessoryIds) do equipOne(id,true) end end) end)
        end
    end

    -- Environment page. It deliberately never edits fog/Atmosphere so the Fog page stays usable.
    do
        local p=pages.environment
        for _,c in ipairs(p:GetChildren()) do if not c:IsA("UIListLayout") and not c:IsA("UIPadding") then c:Destroy() end end
        local original={Ambient=Lighting.Ambient,OutdoorAmbient=Lighting.OutdoorAmbient,Brightness=Lighting.Brightness,ClockTime=Lighting.ClockTime,Exposure=Lighting.ExposureCompensation,Grass=Terrain and Terrain:GetMaterialColor(Enum.Material.Grass),Ground=Terrain and Terrain:GetMaterialColor(Enum.Material.Ground)}
        local changed={}; local folder=workspace:FindFirstChild("KimqV31Environment") or Instance.new("Folder",workspace); folder.Name="KimqV31Environment"; local snowConn; local active="Normal"
        local function grassLike(part)
            if not part:IsA("BasePart") or part:IsDescendantOf(folder) then return false end
            local n=part.Name:lower(); if part.Material==Enum.Material.Grass or n:find("grass",1,true) or n:find("lawn",1,true) or n:find("turf",1,true) then return true end
            local c=part.Color; return part.Size.Y<=5 and (part.Size.X>=6 or part.Size.Z>=6) and c.G>c.R*1.12 and c.G>c.B*1.08 and c.G>.22
        end
        local function savePart(part)
            if changed[part] then return end
            local r={Color=part.Color,Material=part.Material,Children={}}; for _,d in ipairs(part:GetDescendants()) do if d:IsA("Texture") or d:IsA("Decal") then table.insert(r.Children,{Obj=d,Transparency=d.Transparency}) end end; changed[part]=r
        end
        local function recolor(color,material,hideTextures)
            local count=0; for _,part in ipairs(workspace:GetDescendants()) do if grassLike(part) then savePart(part); part.Color=color; if material then part.Material=material end; if hideTextures then for _,r in ipairs(changed[part].Children) do if r.Obj and r.Obj.Parent then r.Obj.Transparency=1 end end end; count+=1; if count>4500 then break end end end
        end
        local function clearFX() if snowConn then snowConn:Disconnect(); snowConn=nil end; folder:ClearAllChildren() end
        local function restore()
            clearFX(); for part,r in pairs(changed) do if part and part.Parent then pcall(function() part.Color=r.Color; part.Material=r.Material end); for _,d in ipairs(r.Children) do if d.Obj and d.Obj.Parent then d.Obj.Transparency=d.Transparency end end end end; table.clear(changed)
            Lighting.Ambient=original.Ambient; Lighting.OutdoorAmbient=original.OutdoorAmbient; Lighting.Brightness=original.Brightness; Lighting.ClockTime=original.ClockTime; Lighting.ExposureCompensation=original.Exposure
            if Terrain then pcall(function() Terrain:SetMaterialColor(Enum.Material.Grass,original.Grass) end); pcall(function() Terrain:SetMaterialColor(Enum.Material.Ground,original.Ground) end) end; active="Normal"
        end
        local function snow()
            local holder=Instance.new("Part",folder); holder.Size=Vector3.new(150,1,150); holder.Transparency=1; holder.Anchored=true; holder.CanCollide=false; holder.CanTouch=false; holder.CanQuery=false
            local function emitter(rate,a,b,sa,sb,spread,alpha)
                local e=Instance.new("ParticleEmitter",holder); e.Texture="rbxasset://textures/particles/sparkles_main.dds"; e.Rate=rate; e.Lifetime=NumberRange.new(7,10); e.Speed=NumberRange.new(sa,sb); e.Acceleration=Vector3.new(.2,-1.35,.12); e.Drag=.35; e.EmissionDirection=Enum.NormalId.Bottom; e.SpreadAngle=Vector2.new(spread,spread); e.Rotation=NumberRange.new(0,360); e.RotSpeed=NumberRange.new(-10,10); e.Color=ColorSequence.new(Color3.new(1,1,1),Color3.fromRGB(222,240,255)); e.Size=NumberSequence.new({NumberSequenceKeypoint.new(0,a),NumberSequenceKeypoint.new(.55,b),NumberSequenceKeypoint.new(1,a*.5)}); e.Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,alpha),NumberSequenceKeypoint.new(.9,alpha+.12),NumberSequenceKeypoint.new(1,1)})
            end
            emitter(175,.06,.11,1.6,2.9,22,.05); emitter(70,.13,.21,1.1,2.2,30,.15); emitter(24,.22,.32,.8,1.5,38,.28)
            local function follow() local hrp=lp.Character and lp.Character:FindFirstChild("HumanoidRootPart"); if hrp and holder.Parent then holder.CFrame=CFrame.new(hrp.Position+Vector3.new(0,48,0)) end end; follow(); snowConn=RunService.RenderStepped:Connect(follow)
        end
        local intro=card(p,75,"V31EnvIntro"); addImg(intro,A.Paw,UDim2.fromOffset(27,27),UDim2.fromOffset(15,11)); local it=label(intro,"environment",UDim2.new(1,-55,0,28),UDim2.fromOffset(48,8),Enum.Font.FredokaOne,20,P.text); table.insert(themedTexts,it); local isub=label(intro,"Seasonal looks only — your Fog / Atmosphere controls stay editable.",UDim2.new(1,-28,0,24),UDim2.fromOffset(14,42),Enum.Font.Gotham,11,P.sub); table.insert(themedTexts,isub)
        local rows={}; local statusText
        local desc={Normal="restore the exact map look",Christmas="soft snowy ground + layered falling snow",Halloween="warm cute autumn colors — not too dark"}
        local function syncRows() for name,r in pairs(rows) do local on=name==active; r.Button.Text=on and "selected ♡" or "choose"; r.Button.BackgroundColor3=on and P.hot or P.soft; r.Button.TextColor3=on and P.white or P.text end; if statusText then statusText.Text=active end end
        local function apply(name)
            restore(); active=name
            if name=="Christmas" then if Terrain then pcall(function() Terrain:SetMaterialColor(Enum.Material.Grass,Color3.fromRGB(239,247,253)) end); pcall(function() Terrain:SetMaterialColor(Enum.Material.Ground,Color3.fromRGB(230,241,250)) end) end; recolor(Color3.fromRGB(241,248,253),Enum.Material.Snow,true); Lighting.Ambient=original.Ambient:Lerp(Color3.fromRGB(225,237,249),.18); Lighting.OutdoorAmbient=original.OutdoorAmbient:Lerp(Color3.fromRGB(236,246,253),.22); Lighting.Brightness=math.max(original.Brightness,1.85); Lighting.ExposureCompensation=original.Exposure+.02; snow()
            elseif name=="Halloween" then if Terrain then pcall(function() Terrain:SetMaterialColor(Enum.Material.Grass,Color3.fromRGB(194,136,80)) end) end; recolor(Color3.fromRGB(198,133,75),nil,false); Lighting.Ambient=original.Ambient:Lerp(Color3.fromRGB(194,144,137),.11); Lighting.OutdoorAmbient=original.OutdoorAmbient:Lerp(Color3.fromRGB(223,169,130),.12); Lighting.Brightness=math.max(original.Brightness*.99,1.85); Lighting.ClockTime=16.5; Lighting.ExposureCompensation=original.Exposure end
            syncRows()
        end
        for _,name in ipairs({"Normal","Christmas","Halloween"}) do
            local r=card(p,64,"V31Env"..name); local n=label(r,name,UDim2.new(.36,-10,0,24),UDim2.fromOffset(14,8),Enum.Font.FredokaOne,17,P.text); table.insert(themedTexts,n); local d=label(r,desc[name],UDim2.new(1,-160,0,22),UDim2.fromOffset(14,35),Enum.Font.Gotham,11,P.sub); table.insert(themedTexts,d); local b=Instance.new("TextButton",r); b.Size=UDim2.fromOffset(116,34); b.Position=UDim2.new(1,-130,.5,-17); b.BackgroundColor3=P.soft; b.BorderSizePixel=0; b.Text="choose"; b.TextColor3=P.text; b.Font=Enum.Font.GothamBold; b.TextSize=11; b.AutoButtonColor=false; corner(b,9); stroke(b,P.line,.3,1); b.MouseButton1Click:Connect(function() apply(name) end); rows[name]={Row=r,Button=b}
        end
        local st=card(p,50,"V31EnvStatus"); addImg(st,A.Paw,UDim2.fromOffset(22,22),UDim2.fromOffset(14,14)); local sl=label(st,"Environment",UDim2.fromOffset(120,50),UDim2.fromOffset(44,0),Enum.Font.GothamBold,12,P.text); table.insert(themedTexts,sl); statusText=label(st,"Normal",UDim2.new(1,-175,1,0),UDim2.fromOffset(165,0),Enum.Font.GothamBold,12,P.hot); table.insert(themedTexts,statusText); syncRows(); _G.KimqEnvironmentController={Apply=apply,Restore=restore,GetPreset=function() return active end}
    end

    -- Weapon skins with entire-model cloning + attachment-aware alignment.
    local weaponThemeSync
    do
        local p=pages.weaponskins
        for _,c in ipairs(p:GetChildren()) do if not c:IsA("UIListLayout") and not c:IsA("UIPadding") then c:Destroy() end end
        local intro=card(p,74,"V31SkinIntro"); addImg(intro,A.Paw,UDim2.fromOffset(27,27),UDim2.fromOffset(15,11)); local it=label(intro,"weapon skins",UDim2.new(1,-55,0,28),UDim2.fromOffset(48,8),Enum.Font.FredokaOne,20,P.text); table.insert(themedTexts,it); local isu=label(intro,"Choose a weapon, pick one of its matching skins, then apply it locally.",UDim2.new(1,-28,0,24),UDim2.fromOffset(14,42),Enum.Font.Gotham,11,P.sub); table.insert(themedTexts,isu)
        local choose=card(p,142,"V31WeaponChoose"); local wh=label(choose,"Weapon",UDim2.fromOffset(110,24),UDim2.fromOffset(14,8),Enum.Font.GothamBold,13,P.text); table.insert(themedTexts,wh)
        local refresh=Instance.new("TextButton",choose); refresh.Size=UDim2.fromOffset(88,28); refresh.Position=UDim2.new(1,-101,0,6); refresh.BackgroundColor3=P.soft; refresh.BorderSizePixel=0; refresh.Text="refresh"; refresh.TextColor3=P.text; refresh.Font=Enum.Font.GothamBold; refresh.TextSize=10; corner(refresh,8); stroke(refresh,P.line,.3,1)
        local weapons=Instance.new("ScrollingFrame",choose); weapons.Size=UDim2.new(1,-20,0,96); weapons.Position=UDim2.fromOffset(10,39); weapons.BackgroundTransparency=1; weapons.BorderSizePixel=0; weapons.ScrollBarThickness=3; weapons.ScrollBarImageColor3=P.hot; local wg=Instance.new("UIGridLayout",weapons); wg.CellPadding=UDim2.fromOffset(7,7); wg.CellSize=UDim2.new(.32,-5,0,36); wg.SortOrder=Enum.SortOrder.LayoutOrder; wg:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() weapons.CanvasSize=UDim2.new(0,0,0,wg.AbsoluteContentSize.Y+7) end)
        local skinsCard=card(p,270,"V31SkinListCard"); local chosen=label(skinsCard,"Skins",UDim2.new(1,-28,0,24),UDim2.fromOffset(14,8),Enum.Font.GothamBold,13,P.text); table.insert(themedTexts,chosen)
        local search=Instance.new("TextBox",skinsCard); search.Size=UDim2.new(1,-28,0,32); search.Position=UDim2.fromOffset(14,37); search.BackgroundColor3=P.soft; search.BorderSizePixel=0; search.PlaceholderText="search skins..."; search.PlaceholderColor3=P.sub; search.Text=""; search.TextColor3=P.text; search.Font=Enum.Font.Gotham; search.TextSize=11; search.ClearTextOnFocus=false; search.TextXAlignment=Enum.TextXAlignment.Left; corner(search,9); stroke(search,P.line,.3,1); local sp=Instance.new("UIPadding",search); sp.PaddingLeft=UDim.new(0,10)
        local skins=Instance.new("ScrollingFrame",skinsCard); skins.Size=UDim2.new(1,-24,1,-82); skins.Position=UDim2.fromOffset(12,75); skins.BackgroundTransparency=1; skins.BorderSizePixel=0; skins.ScrollBarThickness=3; skins.ScrollBarImageColor3=P.hot; local sg=Instance.new("UIGridLayout",skins); sg.CellPadding=UDim2.fromOffset(7,7); sg.CellSize=UDim2.new(.32,-5,0,36); sg.SortOrder=Enum.SortOrder.LayoutOrder; sg:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() skins.CanvasSize=UDim2.new(0,0,0,sg.AbsoluteContentSize.Y+7) end)
        local actions=card(p,56,"V31SkinActions"); local apply=Instance.new("TextButton",actions); apply.Size=UDim2.new(.64,-16,0,34); apply.Position=UDim2.fromOffset(14,11); apply.BackgroundColor3=P.hot; apply.BorderSizePixel=0; apply.Text="apply skin"; apply.TextColor3=P.white; apply.Font=Enum.Font.GothamBold; apply.TextSize=12; corner(apply,9)
        local reset=Instance.new("ImageButton",actions); reset.Size=UDim2.new(.36,-20,0,38); reset.Position=UDim2.new(.64,6,.5,-19); reset.BackgroundTransparency=1; reset.Image=A.Reset; reset.ScaleType=Enum.ScaleType.Fit; reset.AutoButtonColor=false
        local st=card(p,45,"V31SkinStatus"); local status=label(st,"scanning your weapon folders...",UDim2.new(1,-28,1,0),UDim2.fromOffset(14,0),Enum.Font.Gotham,11,P.sub); table.insert(themedTexts,status)

        _G.KimqV31WeaponSkins=_G.KimqV31WeaponSkins or {Selected={}}
        local selected=_G.KimqV31WeaponSkins.Selected
        local wrapRoot,currentWeapon,currentSkin; local folderByName,weaponButtons,skinButtons={},{},{}
        local function display(n) return tostring(n or ""):gsub("%[",""):gsub("%]","") end
        local function setStatus(t,good) status.Text=t; status.TextColor3=good and P.hot or P.sub end
        local function firstPart(o)
            if not o then return nil end; if o:IsA("BasePart") then return o end; local h=o:FindFirstChild("Handle",true); if h and h:IsA("BasePart") then return h end; return o:FindFirstChildWhichIsA("BasePart",true)
        end
        local function locateWraps()
            local list={}; local d=workspace:FindFirstChild("Wraps"); if d then table.insert(list,d) end; for _,x in ipairs(workspace:GetDescendants()) do if x.Name=="Wraps" then table.insert(list,x) end end; local r=ReplicatedStorage:FindFirstChild("Wraps"); if r then table.insert(list,r) end; for _,x in ipairs(ReplicatedStorage:GetDescendants()) do if x.Name=="Wraps" then table.insert(list,x) end end; table.sort(list,function(a,b) return #a:GetChildren()>#b:GetChildren() end); return list[1]
        end
        local function findTool(name) local char=lp.Character; local bp=lp:FindFirstChildOfClass("Backpack"); return (char and char:FindFirstChild(name)) or (bp and bp:FindFirstChild(name)) end
        local function clear(tool)
            if not tool then return end; local target=tool:FindFirstChild("Handle",true); if target and target:IsA("BasePart") then pcall(function() target.LocalTransparencyModifier=0 end) end; for _,d in ipairs(tool:GetDescendants()) do if d.Name=="KimqV31SkinVisual" then d:Destroy() end end
        end
        local function cloneSource(src)
            local ok,cl=pcall(function() return src:Clone() end); if not ok or not cl then return nil end; for _,d in ipairs(cl:GetDescendants()) do if d:IsA("Script") or d:IsA("LocalScript") or d:IsA("ModuleScript") then d:Destroy() end end; return cl
        end
        local function matchingAttachment(srcAnchor,target)
            for _,sa in ipairs(srcAnchor:GetChildren()) do if sa:IsA("Attachment") then local ta=target:FindFirstChild(sa.Name); if ta and ta:IsA("Attachment") then return sa,ta end end end
        end
        local function applyVisual(w,s,tool,quiet)
            local wf=folderByName[w]; local source=wf and wf:FindFirstChild(s); if not source then if not quiet then setStatus("That skin is no longer available",false) end return false end
            local gun=tool or findTool(w); if not gun then selected[w]=s; if not quiet then setStatus(display(w).." saved • equip it and it will apply",true) end return true end
            local target=gun:FindFirstChild("Handle",true); if not target or not target:IsA("BasePart") then target=firstPart(gun) end; local sourceAnchor=firstPart(source); if not target or not sourceAnchor then if not quiet then setStatus("That skin has no usable visual anchor",false) end return false end
            clear(gun); local clone=cloneSource(source); if not clone then if not quiet then setStatus("That skin could not be cloned",false) end return false end; local clonedAnchor=firstPart(clone); if not clonedAnchor then clone:Destroy(); return false end
            local parts={}; if clone:IsA("BasePart") then table.insert(parts,clone) else for _,d in ipairs(clone:GetDescendants()) do if d:IsA("BasePart") then table.insert(parts,d) end end end; if #parts==0 then clone:Destroy(); return false end
            local desired=target.CFrame; local sa,ta=matchingAttachment(clonedAnchor,target); if sa and ta then desired=target.CFrame*ta.CFrame*sa.CFrame:Inverse() end
            local rel={}; for _,part in ipairs(parts) do rel[part]=clonedAnchor.CFrame:ToObjectSpace(part.CFrame) end
            local wrapper=Instance.new("Folder",gun); wrapper.Name="KimqV31SkinVisual"
            if clone:IsA("BasePart") then clone.Parent=wrapper else for _,child in ipairs(clone:GetChildren()) do child.Parent=wrapper end; clone:Destroy() end
            for _,part in ipairs(parts) do if part and part.Parent then part.Anchored=false; part.CanCollide=false; part.CanTouch=false; part.CanQuery=false; part.Massless=true; part.AssemblyLinearVelocity=Vector3.zero; part.AssemblyAngularVelocity=Vector3.zero; part.CFrame=desired*rel[part]; local wld=Instance.new("WeldConstraint",part); wld.Part0=part; wld.Part1=target end end
            pcall(function() target.LocalTransparencyModifier=1 end); selected[w]=s; if not quiet then setStatus(display(w).." • "..s.." applied locally",true) end; return true
        end
        local function makeB(parent,text)
            local b=Instance.new("TextButton",parent); b.BackgroundColor3=P.soft; b.BorderSizePixel=0; b.Text=text; b.TextColor3=P.text; b.Font=Enum.Font.GothamBold; b.TextSize=10; b.AutoButtonColor=false; corner(b,9); stroke(b,P.line,.3,1); return b
        end
        local function styleButtons() for n,b in pairs(weaponButtons) do local on=n==currentWeapon; b.BackgroundColor3=on and P.hot or P.soft; b.TextColor3=on and P.white or P.text end; for n,b in pairs(skinButtons) do local on=n==currentSkin; b.BackgroundColor3=on and P.hot or P.soft; b.TextColor3=on and P.white or P.text end end
        local function buildSkins()
            for _,c in ipairs(skins:GetChildren()) do if c:IsA("TextButton") then c:Destroy() end end; table.clear(skinButtons); local wf=currentWeapon and folderByName[currentWeapon]; if not wf then chosen.Text="Skins • pick a weapon"; setStatus("Choose a weapon first",false); return end
            local q=search.Text:lower(); local list={}; for _,x in ipairs(wf:GetChildren()) do if firstPart(x) and (q=="" or x.Name:lower():find(q,1,true)) then table.insert(list,x) end end; table.sort(list,function(a,b) return a.Name:lower()<b.Name:lower() end); currentSkin=selected[currentWeapon]; chosen.Text=currentSkin and ("selected: "..currentSkin) or ("Skins • "..display(currentWeapon))
            for i,x in ipairs(list) do local b=makeB(skins,x.Name); b.LayoutOrder=i; skinButtons[x.Name]=b; b.MouseButton1Click:Connect(function() currentSkin=x.Name; chosen.Text="selected: "..x.Name; styleButtons(); setStatus("Selected "..x.Name.." • press apply skin",true) end) end; styleButtons(); setStatus(#list>0 and ("Found "..#list.." skins for "..display(currentWeapon)) or ("No matching skins found for "..display(currentWeapon)),#list>0)
        end
        local function scan()
            for _,c in ipairs(weapons:GetChildren()) do if c:IsA("TextButton") then c:Destroy() end end; table.clear(folderByName); table.clear(weaponButtons); wrapRoot=locateWraps(); if not wrapRoot then setStatus("Could not find a Wraps folder • try refresh",false); return end
            local list={}; for _,wf in ipairs(wrapRoot:GetChildren()) do if (wf:IsA("Folder") or wf:IsA("Model")) and #wf:GetChildren()>0 then table.insert(list,wf); folderByName[wf.Name]=wf end end; table.sort(list,function(a,b) return a.Name:lower()<b.Name:lower() end)
            for i,wf in ipairs(list) do local b=makeB(weapons,display(wf.Name)); b.LayoutOrder=i; weaponButtons[wf.Name]=b; b.MouseButton1Click:Connect(function() currentWeapon=wf.Name; currentSkin=selected[currentWeapon]; styleButtons(); buildSkins() end) end; if #list==0 then setStatus("Wraps exists but no weapon folders were found",false); return end; if not currentWeapon or not folderByName[currentWeapon] then currentWeapon=list[1].Name end; styleButtons(); buildSkins()
        end
        refresh.MouseButton1Click:Connect(scan); search:GetPropertyChangedSignal("Text"):Connect(function() task.defer(buildSkins) end); apply.MouseButton1Click:Connect(function() if not currentWeapon then setStatus("Choose a weapon first",false) elseif not currentSkin then setStatus("Choose a skin first",false) else applyVisual(currentWeapon,currentSkin,nil,false) end end); reset.MouseButton1Click:Connect(function() if currentWeapon then selected[currentWeapon]=nil; clear(findTool(currentWeapon)); currentSkin=nil; chosen.Text="Skins • "..display(currentWeapon); styleButtons(); setStatus(display(currentWeapon).." reset",true) end end)
        local function hook(container) if not container or container:GetAttribute("KimqV31SkinHook") then return end; container:SetAttribute("KimqV31SkinHook",true); container.ChildAdded:Connect(function(ch) local s=selected[ch.Name]; if s then task.delay(.12,function() applyVisual(ch.Name,s,ch,true) end) end end) end
        hook(lp:FindFirstChildOfClass("Backpack")); if lp.Character then hook(lp.Character) end; lp.CharacterAdded:Connect(function(char) hook(char); task.delay(1,function() hook(lp:FindFirstChildOfClass("Backpack")); for w,s in pairs(selected) do local t=findTool(w); if t then applyVisual(w,s,t,true) end end end) end)
        p:GetPropertyChangedSignal("Visible"):Connect(function() if p.Visible then task.defer(scan) end end); scan()
        weaponThemeSync=function() weapons.ScrollBarImageColor3=P.hot; skins.ScrollBarImageColor3=P.hot; refresh.BackgroundColor3=P.soft; refresh.TextColor3=P.text; search.BackgroundColor3=P.soft; search.TextColor3=P.text; search.PlaceholderColor3=P.sub; apply.BackgroundColor3=P.hot; styleButtons() end
    end

    -- Sidebar navigation.
    local activeKey="overview"
    local function navStyle()
        for key,b in pairs(navButtons) do
            local on=key==activeKey; b.BackgroundColor3=on and P.hot or P.row; b.TextColor3=on and P.white or P.text; local s=b:FindFirstChildOfClass("UIStroke"); if s then s.Color=on and P.hot or P.line end
        end
    end
    local function showPage(key)
        activeKey=key; for k,p in pairs(pages) do p.Visible=(k==key) end; local m=meta[key] or {key,""}; pageTitle.Text=m[1]; pageDesc.Text=m[2]; navStyle(); if key=="weaponskins" then task.defer(function() pages.weaponskins.CanvasPosition=Vector2.zero end) end
    end
    for i,key in ipairs(order) do
        if pages[key] then
            local b=Instance.new("TextButton",nav); b.LayoutOrder=i; b.Size=UDim2.new(1,-5,0,36); b.BackgroundColor3=P.row; b.BorderSizePixel=0; b.Text=(meta[key] and meta[key][1] or key); b.TextColor3=P.text; b.Font=Enum.Font.FredokaOne; b.TextSize=12; b.TextXAlignment=Enum.TextXAlignment.Left; b.AutoButtonColor=false; corner(b,10); stroke(b,P.line,.28,1); local pd=Instance.new("UIPadding",b); pd.PaddingLeft=UDim.new(0,13); b.MouseButton1Click:Connect(function() showPage(key) end); navButtons[key]=b
        end
    end

    -- Theme sync including new shell. Blue uses the actual blue logo decals; other themes use text fallbacks.
    local function applyPalette(name)
        P=PALS[name] or PALS.Blue; currentName=name
        main.BackgroundColor3=P.bg; local ms=main:FindFirstChildOfClass("UIStroke"); if ms then ms.Color=P.hot end; side.BackgroundColor3=P.panel; hint.BackgroundColor3=P.row; pageHead.BackgroundColor3=P.panel; nav.ScrollBarImageColor3=P.hot
        for _,d in ipairs(stitchParts) do d.BackgroundColor3=P.line end
        for _,x in ipairs(themedFrames) do if x~=main and x~=side and x~=hint and x~=pageHead and x.Parent then x.BackgroundColor3=P.panel end end
        sideTitle.TextColor3=P.text; hintText.TextColor3=P.sub; pageTitle.TextColor3=P.text; pageDesc.TextColor3=P.sub; sideDash.TextColor3=P.line; headDash.TextColor3=P.line
        for _,x in ipairs(themedTexts) do if x and x.Parent then local t=x.Text:lower(); if t:find("environment") and x.Parent and x.Parent.Name=="V31EnvStatus" then x.TextColor3=P.hot elseif x.Font==Enum.Font.Gotham or x.TextSize<=11 then x.TextColor3=P.sub else x.TextColor3=P.text end end end
        for _,x in ipairs(themedImages) do if x and x.Parent then x.ImageColor3=Color3.new(1,1,1) end end
        -- Decal logo was uploaded blue. In other themes use crisp text instead of muddy tinting.
        local blue=name=="Blue"; titleImg.Visible=blue; subImg.Visible=blue; titleFallback.Visible=not blue; subFallback.Visible=not blue; titleFallback.TextColor3=P.hot; subFallback.TextColor3=P.hot
        for _,p in pairs(pages) do stylePage(p) end
        weaponThemeSync = weaponThemeSync
        if weaponThemeSync then weaponThemeSync() end
        navStyle()
    end

    -- Connect existing theme choice cards from V8.
    if pages.theme then
        for _,b in ipairs(pages.theme:GetDescendants()) do
            if b:IsA("TextButton") then
                local n=b:GetAttribute("ThemeName")
                if n and PALS[n] then b.MouseButton1Click:Connect(function() task.delay(.12,function() applyPalette(n) end) end) end
            end
        end
    end

    for _,p in pairs(pages) do stylePage(p) end
    applyPalette("Blue")

    -- Responsive, clamped header dragging.
    local dragging=false; local dragStart; local centerStart; local dragInput
    header.Active=true
    header.InputBegan:Connect(function(input)
        if input.UserInputType==Enum.UserInputType.MouseButton1 then
            dragging=true; dragStart=input.Position; centerStart=Vector2.new(main.AbsolutePosition.X+main.AbsoluteSize.X/2,main.AbsolutePosition.Y+main.AbsoluteSize.Y/2)
            input.Changed:Connect(function() if input.UserInputState==Enum.UserInputState.End then dragging=false end end)
        end
    end)
    header.InputChanged:Connect(function(input) if input.UserInputType==Enum.UserInputType.MouseMovement then dragInput=input end end)
    UIS.InputChanged:Connect(function(input)
        if dragging and input==dragInput then
            local delta=input.Position-dragStart; local v=cam.ViewportSize; local half=main.AbsoluteSize/2; local x=math.clamp(centerStart.X+delta.X,half.X,v.X-half.X); local y=math.clamp(centerStart.Y+delta.Y,half.Y,v.Y-half.Y); main.Position=UDim2.fromOffset(x,y)
        end
    end)

    local reopen=Instance.new("ImageButton",gui); reopen.Name="V31Reopen"; reopen.AnchorPoint=Vector2.new(.5,1); reopen.Position=UDim2.new(.5,0,1,-12); reopen.Size=UDim2.fromOffset(64,64); reopen.BackgroundColor3=P.panel; reopen.BorderSizePixel=0; reopen.Image=A.PompomIcon; reopen.ScaleType=Enum.ScaleType.Fit; reopen.Visible=false; reopen.AutoButtonColor=false; corner(reopen,16); stroke(reopen,P.hot,.08,2)
    local function setShown(v) main.Visible=v; reopen.Visible=not v end
    minus.MouseButton1Click:Connect(function() setShown(false) end); close.MouseButton1Click:Connect(function() setShown(false) end); reopen.MouseButton1Click:Connect(function() setShown(true) end)
    -- Fresh shell shortcuts: both Right Shift and Right Click toggle this rebuilt GUI.
    UIS.InputBegan:Connect(function(input)
        if input.KeyCode==Enum.KeyCode.RightShift or input.UserInputType==Enum.UserInputType.MouseButton2 then setShown(not main.Visible) end
    end)

    showPage("overview")
    gui.Enabled=true
    main.Visible=true
    _G.KimqV31Ready=true

    -- Finish loader immediately after the final shell is ready.
    local loader=_G.KimqV31Loader
    if loader and loader.Gui and loader.Gui.Parent then
        loader.Status.Text="ready ♡"; loader.Percent.Text="100%"; TweenService:Create(loader.Bar,TweenInfo.new(.22,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{Size=UDim2.new(1,0,1,0)}):Play(); task.wait(.25)
        TweenService:Create(loader.Background,TweenInfo.new(.25),{BackgroundTransparency=1}):Play(); TweenService:Create(loader.Card,TweenInfo.new(.25),{BackgroundTransparency=1}):Play(); task.wait(.27); pcall(function() loader.Gui:Destroy() end)
    end

    -- Visible version marker on the sidebar, small and out of the way.
    local ver=label(side,"V31  ♡",UDim2.fromOffset(64,18),UDim2.new(1,-72,0,13),Enum.Font.FredokaOne,11,P.hot,Enum.TextXAlignment.Right)
end)

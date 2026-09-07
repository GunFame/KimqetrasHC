-- Kimqetras HC v2.81 • v2.80 base + phased RAGE knock/stomp transition + movement release
-- Rebuilt from the last known-good v2.19 base instead of stacking patches from v2.20-v2.28.
-- Macro/Speed behavior is sourced only from the script supplied by the user.

local KIMQ_SINGLE_KEY = "KimqHC_v21_SingleRuntimeOptimized"
local KIMQ_BUILD = "v2.81-rage-phase-stomp-fix"

local function kimqFindExistingGui()
    local Players0 = game:GetService("Players")
    local CoreGui0 = game:GetService("CoreGui")
    local lp0 = Players0.LocalPlayer
    local pg0 = lp0 and lp0:FindFirstChildOfClass("PlayerGui")
    return CoreGui0:FindFirstChild("KimpetrasHC") or (pg0 and pg0:FindFirstChild("KimpetrasHC"))
end

do
    local StarterGui0 = game:GetService("StarterGui")
    local RunService0 = game:GetService("RunService")
    local SHARED0 = (type(getgenv)=="function" and getgenv()) or _G

    local running = rawget(SHARED0, KIMQ_SINGLE_KEY)
    local runningBuild = rawget(SHARED0, "KimqHC_CurrentBuild")
    local runtimeState = rawget(SHARED0, "KimqHC_RuntimeState")
    local runtimeStartedAt = tonumber(rawget(SHARED0, "KimqHC_RuntimeStartedAt"))
    local runningGui = kimqFindExistingGui()

    local function notifyBoot(text,duration)
        pcall(function()
            StarterGui0:SetCore("SendNotification",{
                Title="Kimqetras HC",
                Text=text,
                Duration=duration or 5,
            })
        end)
    end

    local function clearRuntimeClaim()
        SHARED0[KIMQ_SINGLE_KEY]=nil
        SHARED0.KimqHC_CurrentBuild=nil
        SHARED0.KimqHC_RuntimeState=nil
        SHARED0.KimqHC_RuntimeStartedAt=nil
        _G[KIMQ_SINGLE_KEY]=nil
        _G.KimqHC_CurrentBuild=nil
        _G.KimqHC_RuntimeState=nil
        _G.KimqHC_RuntimeStartedAt=nil
    end

    -- v2.69 startup recovery:
    -- v2.68 claimed the single-runtime flag BEFORE the GUI was guaranteed to exist.
    -- If that first boot failed, executing it again could immediately return forever
    -- even though there was literally no Kimqetras GUI to reopen.
    if running and runningBuild == KIMQ_BUILD then
        if runningGui then
            pcall(function()
                runningGui.Enabled = true
                local main0 = runningGui:FindFirstChild("Main")
                local explicitVisible=rawget(SHARED0,"KimqMainUserVisibleState")
                if main0 and explicitVisible~=false then main0.Visible = true end
            end)
            notifyBoot((runtimeState=="ready") and "v2.81 is already running ♡" or "v2.81 is already starting ♡",4)
            return
        end

        -- Same-build claim with no GUI is a failed/stale boot, not a live runtime.
        -- Clear only the claim and retry normally; no feature callbacks are touched.
        clearRuntimeClaim()
        running=false
        runningBuild=nil
        runtimeState=nil
        runtimeStartedAt=nil
        notifyBoot("Recovering a failed v2.81 boot ♡",4)
    end

    -- A DIFFERENT fully-running build may still have hidden input/heartbeat callbacks,
    -- so we still refuse to stack on top of a real older runtime.
    -- But an older build that died while booting and never created a GUI is safe to
    -- treat as stale after a short grace period.
    local oldRuntimeDetected =
        (running and runningBuild and runningBuild ~= KIMQ_BUILD)
        or (running and not runningBuild)
        or (rawget(SHARED0,"KimqHC_v21_PerformanceLoaded")==true and runningBuild~=KIMQ_BUILD)

    if oldRuntimeDetected then
        local age = runtimeStartedAt and math.max(0,os.clock()-runtimeStartedAt) or math.huge
        local staleBoot = (not runningGui) and runtimeState=="booting" and age>6
        if staleBoot then
            clearRuntimeClaim()
            running=false
            runningBuild=nil
            runtimeState=nil
            notifyBoot("Cleared a stale Kimqetras boot and retrying ♡",5)
        else
            notifyBoot("STOP: another Kimqetras HC build is already active. v2.81 DID NOT LOAD. Rejoin once, then run only v2.81.",9)
            warn("[Kimqetras HC v2.81] Another build is active. v2.81 DID NOT LOAD; rejoin once before testing.")
            return
        end
    end

    -- GUI with no runtime owner = stale/failed boot. Safe to remove.
    if runningGui then
        pcall(function() runningGui:Destroy() end)
    end

    local Players0=game:GetService("Players")
    local CoreGui0=game:GetService("CoreGui")
    local lp0=Players0.LocalPlayer
    local pg0=lp0 and lp0:FindFirstChildOfClass("PlayerGui")
    for _,root in ipairs({CoreGui0,pg0}) do
        if root then
            for _,name in ipairs({"KimpetrasHC_Boot","KimqetrasHC_Error","KimpetrasHC_Error"}) do
                local g=root:FindFirstChild(name)
                if g then pcall(function() g:Destroy() end) end
            end
        end
    end

    -- Clean only named render bindings from failed old boots, after confirming
    -- that no real old runtime is active.
    local knownRenderBindings = {
        "KimqMacroSpeedV240","KimqMacroSpeedV241","KimqMacroSpeedV242","KimqMacroSpeedV261",
        "KimqPermanentTimeV229","KimqPermanentTimeV230","KimqPermanentTimeV231",
        "KimqPermanentTimeV232","KimqPermanentTimeV233","KimqPermanentTimeV234",
        "KimqPermanentTimeV235","KimqPermanentTimeV236","KimqPermanentTimeV237",
        "KimqPermanentTimeV238","KimqPermanentTimeV239","KimqPermanentTimeV240",
        "KimqPermanentTimeV241","KimqPermanentTimeV242","KimqPermanentTimeV261",
    }
    for _,binding in ipairs(knownRenderBindings) do
        pcall(function() RunService0:UnbindFromRenderStep(binding) end)
    end

    -- Claim the runtime immediately so two executes during the loading screen
    -- can never create two copies.
    SHARED0[KIMQ_SINGLE_KEY] = true
    SHARED0.KimqHC_CurrentBuild = KIMQ_BUILD
    SHARED0.KimqHC_RuntimeState = "booting"
    SHARED0.KimqHC_RuntimeStartedAt = os.clock()

    -- Mirror into this script's _G too for old internal code.
    _G[KIMQ_SINGLE_KEY] = true
    _G.KimqHC_CurrentBuild = KIMQ_BUILD
    _G.KimqHC_RuntimeState = "booting"
    _G.KimqHC_RuntimeStartedAt = SHARED0.KimqHC_RuntimeStartedAt

    _G.KimqShotCameraSwapEnabled = false
    _G.KimqV26FeaturesReady = false
    _G.KimqBasePagesReady = false
    _G.KimqPageRepairReady = false
    _G.KimqThemeEngineReady = false
    _G.KimqAccessoryUIReady = false
    _G.KimqV26Loader = nil
    _G.KimqRefreshWingMiniTheme = nil
    -- v2.80: nil means the user has not explicitly opened/closed the main GUI yet.
    -- Late startup/watchdog passes must never override a real user choice.
    _G.KimqMainUserVisibleState = nil
    SHARED0.KimqMainUserVisibleState = nil
end


-- v2.1 uses native GUI/text hearts only; obsolete mascot/decal table removed.
-- Working safe backend + completely reorganized feature pages.

-- v2.29 keeps the v2.19 working base and adds only the requested audited features.
_G.KimqSectionRoutingVersion = "v2.1-strict-sections"

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
BootGui.Enabled = true
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
task.spawn(function()
    local ok,img=pcall(function()
        return Players:GetUserThumbnailAsync(lp.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size180x180)
    end)
    if ok and Avatar and Avatar.Parent then Avatar.Image=img end
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
Hello.Text = "v2.81  •  phased RAGE stomp + stable avatar ♡"
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
local total = 7

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
    useKeybind = false,
    silentAimKey = Enum.KeyCode.V,
    uiToggleKey = Enum.KeyCode.RightControl,

    -- v2.63: all Silent Aim controls below now feed the SAME target resolver.
    silentAimHitChance = 100,
    silentAimFOV = 150,
    silentAimFOVShow = false,
    silentAimFOVFilled = false,
    silentAimFOVOpacity = 0.58,
    silentAimFOVColor = Color3.fromRGB(255, 20, 147),
    silentAimStrictFOV = true,
    silentAimStickiness = 18,
    silentAimPriority = "Closest Cursor",

    silentAimPart = "Head",
    silentAimClosestPart = false,

    silentAimTeamCheck = false,
    silentAimWallCheck = false,
    -- v2.80: stop redirecting bullets into K.O/downed/dead targets.
    silentAimKnockCheck = true,
    silentAimMaxDist = 1000,

    -- Manual prediction is always available. Auto Prediction adds a ping-aware
    -- lead on top of these values instead of silently replacing them.
    silentAimPredX = 0,
    silentAimPredY = 0,
    silentAimAutoPrediction = true,
    silentAimAutoPredictionStrength = 1.00,

    bypassRevolver = false,
}

local bodyPartsList = {
    "Head", "UpperTorso", "HumanoidRootPart", "LowerTorso",
    "LeftUpperArm", "RightUpperArm", "LeftLowerArm", "RightLowerArm",
    "LeftHand", "RightHand", "LeftUpperLeg", "RightUpperLeg",
    "LeftLowerLeg", "RightLowerLeg", "LeftFoot", "RightFoot"
}

local Stats=nil
pcall(function() Stats=game:GetService("Stats") end)

-- Drawing is optional. Target selection still works even if the executor cannot
-- draw a circle; only the visual circle is unavailable in that case.
local fovCircle = {
    Thickness = 1.5,
    NumSides = 72,
    Radius = cfg.silentAimFOV,
    Color = cfg.silentAimFOVColor,
    Filled = cfg.silentAimFOVFilled,
    Visible = false,
    Transparency = cfg.silentAimFOVOpacity,
    Position = Vector2.new(0, 0),
}
if type(Drawing) == "table" and type(Drawing.new) == "function" then
    pcall(function()
        local realCircle = Drawing.new("Circle")
        realCircle.Thickness = 1.5
        realCircle.NumSides = 72
        realCircle.Radius = cfg.silentAimFOV
        realCircle.Color = cfg.silentAimFOVColor
        realCircle.Filled = cfg.silentAimFOVFilled
        realCircle.Visible = cfg.silentAimFOVShow
        realCircle.Transparency = cfg.silentAimFOVOpacity
        fovCircle = realCircle
    end)
end

local silentAimCachedPart = nil
local silentAimCachedPoint = nil
local silentAimVelocityCache = setmetatable({}, {__mode="k"})
local hitChancePart=nil
local hitChanceUntil=0
local hitChancePass=true
local lastPingRead=0
local cachedPingSeconds=.065

local function getSmoothedAimVelocity(part)
    if not part or not part:IsA("BasePart") then return Vector3.zero end
    local now=part.AssemblyLinearVelocity
    local old=silentAimVelocityCache[part]
    -- Slightly stronger smoothing than v2.62: less jitter without flattening
    -- legitimate movement/prediction.
    local smooth=old and old:Lerp(now,.48) or now
    silentAimVelocityCache[part]=smooth
    return smooth
end

local function pingSeconds()
    local now=os.clock()
    if now-lastPingRead<.35 then return cachedPingSeconds end
    lastPingRead=now

    local ms=nil
    if Stats then
        pcall(function()
            local net=Stats:FindFirstChild("Network")
            local server=net and net:FindFirstChild("ServerStatsItem")
            local ping=server and server:FindFirstChild("Data Ping")
            if ping then
                local ok,v=pcall(function() return ping:GetValue() end)
                if ok and type(v)=="number" then ms=v end
                if not ms then
                    local ok2,s=pcall(function() return ping:GetValueString() end)
                    if ok2 and s then ms=tonumber(tostring(s):match("[%d%.]+")) end
                end
            end
        end)
    end

    if type(ms)=="number" then
        cachedPingSeconds=math.clamp(ms/1000,.018,.240)
    end
    return cachedPingSeconds
end

local function isHoldingRevolver()
    if not cfg.bypassRevolver then return false end
    local char = lp.Character
    if not char then return false end

    local tool = char:FindFirstChildOfClass("Tool")
    if tool then
        local toolName = string.lower(tool.Name)
        if string.find(toolName, "revolver",1,true) or string.find(toolName, "rev",1,true) then
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

local function silentAimIsKnocked(p)
    if not cfg.silentAimKnockCheck then return false end
    local char=p and p.Character
    if not char then return true end
    local hum=char:FindFirstChildOfClass("Humanoid")
    if not hum or hum.Health<=0 or hum:GetState()==Enum.HumanoidStateType.Dead then return true end

    -- Primary game convention used elsewhere in Kimqetras HC.
    local bodyEffects=char:FindFirstChild("BodyEffects")
    if bodyEffects then
        local ko=bodyEffects:FindFirstChild("K.O") or bodyEffects:FindFirstChild("KO")
            or bodyEffects:FindFirstChild("Knocked") or bodyEffects:FindFirstChild("Downed")
        if ko then
            if ko:IsA("BoolValue") and ko.Value then return true end
            if (ko:IsA("IntValue") or ko:IsA("NumberValue")) and ko.Value~=0 then return true end
        end
    end

    -- Small direct fallback for games that store the flag on the character.
    for _,name in ipairs({"K.O","KO","Knocked","Downed","Dead","Unconscious"}) do
        local flag=char:FindFirstChild(name)
        if flag then
            if flag:IsA("BoolValue") and flag.Value then return true end
            if (flag:IsA("IntValue") or flag:IsA("NumberValue")) and flag.Value~=0 then return true end
        end
    end
    return false
end

local function sameTeam(p)
    return lp.Team and p.Team and lp.Team == p.Team
end

-- v2.63 Wall Check:
-- Trace repeatedly past purely visual/non-collidable clutter instead of treating
-- a transparent effect as a concrete wall. A solid obstruction still rejects
-- the target immediately.
local function wallBetween(pos,targetCharacter)
    if not cfg.silentAimWallCheck then return false end
    local camera=workspace.CurrentCamera
    if not camera then return true end

    local origin=camera.CFrame.Position
    local ignore={}
    if lp.Character then table.insert(ignore,lp.Character) end

    for _=1,7 do
        local direction=pos-origin
        if direction.Magnitude<=.05 then return false end

        local params=RaycastParams.new()
        params.FilterDescendantsInstances=ignore
        params.FilterType=Enum.RaycastFilterType.Exclude
        params.IgnoreWater=true

        local hit=workspace:Raycast(origin,direction,params)
        if not hit then return false end
        local inst=hit.Instance
        if targetCharacter and inst and inst:IsDescendantOf(targetCharacter) then
            return false
        end

        local ignorable=false
        if inst and inst:IsA("BasePart") then
            ignorable=(inst.Transparency>=.86 and not inst.CanCollide)
                or (not inst.CanQuery)
        end

        if ignorable then
            table.insert(ignore,inst)
            origin=hit.Position + direction.Unit*.03
        else
            return true
        end
    end
    return false
end

-- Use screen-space coordinates consistently for BOTH the target radius and the
-- Drawing circle. This fixes the "circle says they're inside but aim says no"
-- behavior caused by mixing viewport and screen coordinate spaces.
local function screenPoint(pos)
    local camera=workspace.CurrentCamera
    if not camera then return Vector3.zero,false end
    local sp,on=Vector3.zero,false
    pcall(function()
        sp,on=camera:WorldToScreenPoint(pos)
    end)
    return sp,on
end

-- v2.65 TRUE CLOSEST POINT
-- "Closest Point" now follows the actual cursor ray. If the cursor is physically
-- over a leg/arm/head, the ray resolves that exact body part AND the exact world
-- point underneath the cursor instead of comparing only the centers of parts.
local function cursorDistancePoint(point)
    if typeof(point)~="Vector3" then return math.huge,false end
    local sp,on=screenPoint(point)
    if not on or sp.Z<=0 then return math.huge,false end
    local mousePos=UIS:GetMouseLocation()
    return (Vector2.new(sp.X,sp.Y)-mousePos).Magnitude,true
end

local function fovAllowsPoint(point,extraScale)
    local d,on=cursorDistancePoint(point)
    if not on then return false,d end
    local scale=extraScale or 1
    return d <= math.max(1,cfg.silentAimFOV)*scale,d
end

local function cursorWorldRay()
    local camera=workspace.CurrentCamera
    if not camera then return nil,nil end
    local m=UIS:GetMouseLocation()
    local ray=nil

    -- ScreenPointToRay matches UIS:GetMouseLocation on normal desktop clients.
    local ok=pcall(function()
        ray=camera:ScreenPointToRay(m.X,m.Y,0)
    end)
    if (not ok or not ray) then
        pcall(function()
            ray=camera:ViewportPointToRay(m.X,m.Y,0)
        end)
    end
    if not ray or ray.Direction.Magnitude<=.001 then return nil,nil end
    return ray.Origin,ray.Direction.Unit
end

local function characterBodyParts(char)
    local parts={}
    if not char then return parts end

    -- Scan direct character body parts instead of assuming R15 names only.
    -- This also makes Closest Point work on R6/custom rigs while naturally
    -- ignoring Accessory/Tool handles because those live under child containers.
    for _,p in ipairs(char:GetChildren()) do
        if p:IsA("BasePart") then
            table.insert(parts,p)
        end
    end

    -- Very unusual rigs can keep body parts nested; retain the known-name
    -- fallback without inserting duplicates.
    if #parts==0 then
        for _,name in ipairs(bodyPartsList) do
            local bp=char:FindFirstChild(name,true)
            if bp and bp:IsA("BasePart") then
                table.insert(parts,bp)
            end
        end
    end
    return parts
end

local function closestPointForCharacter(char,rayOrigin,rayDir)
    if not char then return nil,nil end
    local parts=characterBodyParts(char)
    if #parts==0 then
        local fallback=char:FindFirstChild("Head") or char:FindFirstChild("HumanoidRootPart")
        return fallback,fallback and fallback.Position or nil
    end

    -- First choice: exact cursor intersection with one of the character's real
    -- body parts. This is what makes cursor-on-leg -> leg, cursor-on-arm -> arm.
    if rayOrigin and rayDir then
        local params=RaycastParams.new()
        params.FilterType=Enum.RaycastFilterType.Include
        params.FilterDescendantsInstances=parts
        params.IgnoreWater=true
        local length=math.max(5000,(tonumber(cfg.silentAimMaxDist) or 1000)+500)
        local result=workspace:Raycast(rayOrigin,rayDir*length,params)
        if result and result.Instance and result.Instance:IsA("BasePart") then
            return result.Instance,result.Position
        end
    end

    -- If the cursor is just beside the character, fall back to the nearest
    -- body-part center. The expensive surface solver is intentionally avoided
    -- here: exact surface targeting already happened above when the cursor was
    -- actually over the avatar, while this fallback keeps large servers smooth.
    local bestPart,bestPoint=nil,nil
    local bestDist=math.huge
    for _,part in ipairs(parts) do
        local point=part.Position
        local dist,on=cursorDistancePoint(point)
        if on and dist<bestDist then
            bestDist=dist
            bestPart=part
            bestPoint=point
        end
    end

    if bestPart then return bestPart,bestPoint end
    local fallback=char:FindFirstChild("Head") or char:FindFirstChild("HumanoidRootPart")
    return fallback,fallback and fallback.Position or nil
end

local function getTargetPartAndPoint(char,rayOrigin,rayDir)
    if not char then return nil,nil end
    if cfg.silentAimClosestPart then
        return closestPointForCharacter(char,rayOrigin,rayDir)
    end
    local part=char:FindFirstChild(cfg.silentAimPart)
        or char:FindFirstChild("Head")
        or char:FindFirstChild("HumanoidRootPart")
    return part,part and part.Position or nil
end

local function targetScore(pl,part,cursorDist,dist3D)
    local mode=tostring(cfg.silentAimPriority or "Closest Cursor")
    if mode=="Closest Distance" then
        -- Still obeys the FOV; this only decides WHO wins inside it.
        return dist3D + cursorDist*.02
    elseif mode=="Lowest Health" then
        local h=getHum(pl)
        local ratio=1
        if h and h.MaxHealth>0 then ratio=math.clamp(h.Health/h.MaxHealth,0,1) end
        return ratio*10000 + cursorDist
    end
    return cursorDist
end

local function validCandidate(pl,part,aimPoint,fovScale)
    if not pl or pl==lp or not part or not part.Parent or typeof(aimPoint)~="Vector3" then
        return false,nil,nil
    end
    if _G.KHWhitelist[pl.UserId] then return false,nil,nil end
    if not isAlive(pl) then return false,nil,nil end
    if silentAimIsKnocked(pl) then return false,nil,nil end
    if cfg.silentAimTeamCheck and sameTeam(pl) then return false,nil,nil end

    local camera=workspace.CurrentCamera
    if not camera then return false,nil,nil end
    local dist3D=(aimPoint-camera.CFrame.Position).Magnitude
    if dist3D>cfg.silentAimMaxDist then return false,nil,nil end

    local fovOK,cursorDist=fovAllowsPoint(aimPoint,fovScale)
    if not fovOK then return false,nil,nil end
    if wallBetween(aimPoint,pl.Character) then return false,nil,nil end
    return true,cursorDist,dist3D
end

local function getClosestPlayerToCursor()
    if isHoldingRevolver() then return nil,nil end

    local bestPart,bestPoint=nil,nil
    local bestScore=math.huge
    -- Resolve the cursor ray once per frame, then reuse it for every candidate.
    local rayOrigin,rayDir=cursorWorldRay()

    -- Stickiness belongs to the PLAYER, not a frozen body part. In Closest Point
    -- mode we recalculate the exact point every frame so moving the cursor from
    -- torso -> leg immediately changes the selected hit location.
    local stickyPart,stickyPoint=nil,nil
    local stickyScore=math.huge
    if silentAimCachedPart and silentAimCachedPart.Parent then
        local stickyChar=silentAimCachedPart:FindFirstAncestorOfClass("Model")
        local stickyPlayer=stickyChar and Players:GetPlayerFromCharacter(stickyChar)
        if stickyPlayer and stickyChar then
            stickyPart,stickyPoint=getTargetPartAndPoint(stickyChar,rayOrigin,rayDir)
            local stickyScale=cfg.silentAimStrictFOV and 1 or 1.12
            local ok,cursorDist,dist3D=validCandidate(stickyPlayer,stickyPart,stickyPoint,stickyScale)
            if ok then
                stickyScore=targetScore(stickyPlayer,stickyPart,cursorDist,dist3D)
            else
                stickyPart,stickyPoint=nil,nil
            end
        end
    end

    for _,p in ipairs(Players:GetPlayers()) do
        if p~=lp and not _G.KHWhitelist[p.UserId] and isAlive(p) and not silentAimIsKnocked(p) then
            if cfg.silentAimTeamCheck and sameTeam(p) then continue end
            local part,point=getTargetPartAndPoint(p.Character,rayOrigin,rayDir)
            local ok,cursorDist,dist3D=validCandidate(p,part,point,1)
            if ok then
                local score=targetScore(p,part,cursorDist,dist3D)
                if score<bestScore then
                    bestScore=score
                    bestPart=part
                    bestPoint=point
                end
            end
        end
    end

    if stickyPart then
        if not bestPart then return stickyPart,stickyPoint end
        local stick=math.clamp(tonumber(cfg.silentAimStickiness) or 0,0,80)/100
        local stealThreshold=stickyScore*(1-stick)
        if bestScore>=stealThreshold then
            return stickyPart,stickyPoint
        end
    end
    return bestPart,bestPoint
end

local function predictedHitPosition(part,basePoint)
    if not part then return nil end
    local velocity=getSmoothedAimVelocity(part)
    local leadX=tonumber(cfg.silentAimPredX) or 0
    local leadY=tonumber(cfg.silentAimPredY) or 0

    if cfg.silentAimAutoPrediction then
        local auto=pingSeconds()*math.clamp(tonumber(cfg.silentAimAutoPredictionStrength) or 1,.25,2.5)
        -- Horizontal movement generally benefits from the full lead; vertical
        -- movement gets a slightly calmer lead so jumps do not over-shoot.
        leadX+=auto
        leadY+=auto*.82
    end

    local originPoint=(typeof(basePoint)=="Vector3") and basePoint or part.Position
    return originPoint + Vector3.new(
        velocity.X*leadX,
        velocity.Y*leadY,
        velocity.Z*leadX
    )
end

local function passesHitChance(part)
    local now=os.clock()
    -- Cache the roll briefly so Mouse.Hit / Target / UnitRay from the SAME shot
    -- all agree. v2.62 could roll three different answers for one click.
    if part~=hitChancePart or now>=hitChanceUntil then
        hitChancePart=part
        hitChanceUntil=now+.055
        hitChancePass=math.random(1,100)<=math.clamp(tonumber(cfg.silentAimHitChance) or 100,1,100)
    end
    return hitChancePass
end

-- HOOK METAMETHOD (kept narrow: it changes only Mouse aim reads and leaves all
-- unrelated remotes/sections untouched).
pcall(function()
    if type(getrawmetatable) ~= "function" or type(setreadonly) ~= "function" or type(checkcaller) ~= "function" then
        return
    end
    local _grm = getrawmetatable(game)
    local _oldIndex = _grm.__index
    setreadonly(_grm, false)

    _grm.__index = function(self, key)
        if not checkcaller() and self == mouse and cfg.silentAim and not isHoldingRevolver() then
            local part=silentAimCachedPart
            local targetChar=part and part:FindFirstAncestorOfClass("Model")
            local targetPlayer=targetChar and Players:GetPlayerFromCharacter(targetChar)
            if (key == "Hit" or key == "Target" or key == "UnitRay")
                and part
                and (not targetPlayer or not silentAimIsKnocked(targetPlayer))
                and passesHitChance(part)
            then
                local camera=workspace.CurrentCamera
                local hitPos=predictedHitPosition(part,silentAimCachedPoint)
                if camera and hitPos then
                    local origin=camera.CFrame.Position
                    if key == "UnitRay" then
                        local delta=hitPos-origin
                        if delta.Magnitude>.001 then
                            return Ray.new(origin,delta.Unit)
                        end
                    elseif key == "Hit" then
                        return CFrame.new(hitPos)
                    elseif key == "Target" then
                        return part
                    end
                end
            end
        end
        return _oldIndex(self, key)
    end
    setreadonly(_grm, true)
end)

-- v2.64: Silent Aim is permanently enabled for this runtime.
-- There is no master ON/OFF toggle or keybind anymore; the controls below
-- only tune how the already-active Silent Aim behaves.
cfg.silentAim = true

RunService.RenderStepped:Connect(function()
    local mousePos=UIS:GetMouseLocation()

    fovCircle.Position=mousePos
    fovCircle.Radius=math.max(1,cfg.silentAimFOV)
    fovCircle.Color=cfg.silentAimFOVColor
    fovCircle.Filled=cfg.silentAimFOVFilled
    fovCircle.Transparency=math.clamp(cfg.silentAimFOVOpacity,0.05,1)

    if not cfg.silentAim then
        fovCircle.Visible=false
        silentAimCachedPart=nil
        silentAimCachedPoint=nil
        return
    end

    fovCircle.Visible=cfg.silentAimFOVShow and not isHoldingRevolver()
    silentAimCachedPart,silentAimCachedPoint=getClosestPlayerToCursor()
end)

-- Small read-only bridge for the GUI/debug layer; no other combat section is
-- changed to depend on Silent Aim.
_G.KimqSilentAimCurrentPart=function()
    return silentAimCachedPart
end
_G.KimqSilentAimCurrentPoint=function()
    return silentAimCachedPoint
end


local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KimpetrasHC"
pcall(function()
    ScreenGui:SetAttribute("KimqBuild",KIMQ_BUILD)
    ScreenGui:SetAttribute("KimqSingleRuntime",true)
end)
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
Title.Text = "Kimqetras HC"
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

-- Give every original top-level control a permanent creation order.
-- The v2.1 page builder uses this to separate sections reliably instead of
-- depending on AbsolutePosition while Roblox is still laying the GUI out.
local ScrollOrderCounter = 0
Scroll.ChildAdded:Connect(function(child)
    if child ~= UIList and not child:IsA("UIListLayout") and not child:IsA("UIPadding") then
        ScrollOrderCounter = ScrollOrderCounter + 1
        child.LayoutOrder = ScrollOrderCounter
    end
end)

UIList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    Scroll.CanvasSize = UDim2.new(0, 0, 0, UIList.AbsoluteContentSize.Y + 10)
end)


local function minimizeUI()
    local x = math.clamp(Main.AbsolutePosition.X + (Main.AbsoluteSize.X / 2) - 24, 0, cam.ViewportSize.X - 48)
    local y = math.clamp(Main.AbsolutePosition.Y + (Main.AbsoluteSize.Y / 2) - 24, 0, cam.ViewportSize.Y - 48)
    MiniBubble.Position = UDim2.new(0, x, 0, y)
    _G.KimqMainUserVisibleState = false
    pcall(function() if type(getgenv)=="function" then getgenv().KimqMainUserVisibleState=false end end)
    Main.Visible = false
    MiniBubble.Visible = true
end

local function restoreUI()
    local x = math.clamp(MiniBubble.AbsolutePosition.X - (Main.AbsoluteSize.X / 2) + 24, 0, cam.ViewportSize.X - Main.AbsoluteSize.X)
    local y = math.clamp(MiniBubble.AbsolutePosition.Y - (Main.AbsoluteSize.Y / 2) + 24, 0, cam.ViewportSize.Y - Main.AbsoluteSize.Y)
    Main.Position = UDim2.new(0, x, 0, y)
    MiniBubble.Visible = false
    _G.KimqMainUserVisibleState = true
    pcall(function() if type(getgenv)=="function" then getgenv().KimqMainUserVisibleState=true end end)
    Main.Visible = true
end

MinimizeBtn.MouseButton1Click:Connect(minimizeUI)
MiniBubble.MouseButton1Click:Connect(restoreUI)

-- Every control is stamped with its real feature section at creation time.
-- This is the authoritative ownership system for the v2.1 pages; later page
-- builders no longer have to guess from screen position or nearby headers.
_G.KimqBuildSection = _G.KimqBuildSection or "silent"

local function createCard(height)
    local card = Instance.new("Frame")
    card.Size = UDim2.new(1, -6, 0, height or 40)
    card.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    card.BorderSizePixel = 0
    card.Parent = Scroll
    local section = tostring(_G.KimqBuildSection or "")
    if section ~= "" then
        card:SetAttribute("KimqSection", section)
    end
    
    local c = Instance.new("UICorner", card)
    c.CornerRadius = UDim.new(0, 8)
    
    local s = Instance.new("UIStroke", card)
    s.Color = Color3.fromRGB(255, 212, 243)
    s.Thickness = 1
    return card
end


-- Central control registry used by the v2.1 config system.
-- Each helper registers a getter + setter so loading a config updates BOTH
-- the GUI control and the feature's local variable/callback (Macro included).
-- v2.1 uses one authoritative config registry. Rebuild it for this execution so
-- stale setters from an older injected copy cannot leak into new presets.
_G.KimqConfigControls = {}
local KimqConfigControls = _G.KimqConfigControls

local function registerConfigControl(name, kind, getter, setter)
    if type(name) ~= "string" or name == "" then return end
    KimqConfigControls[name] = {
        kind = kind,
        get = getter,
        set = setter,
    }
end
_G.KimqRegisterConfigControl = registerConfigControl

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
    btn.Text = ""
    btn.AutoButtonColor = false

    local bc = Instance.new("UICorner", btn)
    bc.CornerRadius = UDim.new(1, 0)

    local circle = Instance.new("Frame", btn)
    circle.Size = UDim2.new(0, 18, 0, 18)
    circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    local cc = Instance.new("UICorner", circle)
    cc.CornerRadius = UDim.new(1, 0)

    local state = not not default
    local function paint()
        local live = _G.KimqThemeLivePalette
        local onColor = (live and live.hot) or Color3.fromRGB(243, 161, 211)
        local offColor = (live and (live.bg2 or live.bg)) or Color3.fromRGB(236, 255, 243)
        btn.BackgroundColor3 = state and onColor or offColor
        circle.Position = state and UDim2.new(1, -20, 0.5, -9) or UDim2.new(0, 2, 0.5, -9)
    end
    local function setState(v, fireCallback)
        state = not not v
        paint()
        if fireCallback ~= false then pcall(callback, state) end
    end

    paint()
    btn.MouseButton1Click:Connect(function()
        state = not state
        local live = _G.KimqThemeLivePalette
        local onColor = (live and live.hot) or Color3.fromRGB(243, 161, 211)
        local offColor = (live and (live.bg2 or live.bg)) or Color3.fromRGB(236, 255, 243)
        btn.BackgroundColor3 = state and onColor or offColor
        circle:TweenPosition(state and UDim2.new(1, -20, 0.5, -9) or UDim2.new(0, 2, 0.5, -9), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.15, true)
        callback(state)
    end)

    registerConfigControl(text, "toggle", function() return state end, function(v) setState(v, true) end)
    return card, btn
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
    fill.BackgroundColor3 = Color3.fromRGB(243, 161, 211)
    Instance.new("UICorner", fill).CornerRadius = UDim.new(1, 0)

    local currentValue = math.clamp(tonumber(default) or min, min, max)
    local function setValue(v, fireCallback)
        v = math.clamp(tonumber(v) or currentValue, min, max)
        currentValue = math.floor(v + 0.5)
        local pos = (currentValue - min) / math.max(max - min, 1e-6)
        fill.Size = UDim2.new(pos, 0, 1, 0)
        valLbl.Text = tostring(currentValue)
        if fireCallback ~= false then pcall(callback, currentValue) end
    end
    setValue(currentValue, false)

    local sDragging = false
    local function update(input)
        local pos = math.clamp((input.Position.X - bg.AbsolutePosition.X) / math.max(bg.AbsoluteSize.X, 1), 0, 1)
        setValue(min + (max - min) * pos, true)
    end
    bg.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then sDragging = true update(input) end
    end)
    UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then sDragging = false end
    end)
    UIS.InputChanged:Connect(function(input)
        if sDragging and input.UserInputType == Enum.UserInputType.MouseMovement then update(input) end
    end)

    registerConfigControl(text, "slider", function() return currentValue end, function(v) setValue(v, true) end)
    return card
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
    fill.BackgroundColor3 = Color3.fromRGB(243, 161, 211)
    Instance.new("UICorner", fill).CornerRadius = UDim.new(1, 0)

    local scale = 10 ^ decimals
    local currentValue = tonumber(default) or min
    local function setValue(v, fireCallback)
        v = math.clamp(tonumber(v) or currentValue, min, max)
        currentValue = math.floor(v * scale + 0.5) / scale
        local pos = (currentValue - min) / math.max(max - min, 1e-6)
        fill.Size = UDim2.new(pos, 0, 1, 0)
        valLbl.Text = string.format("%." .. decimals .. "f", currentValue)
        if fireCallback ~= false then pcall(callback, currentValue) end
    end
    setValue(currentValue, false)

    local dragging = false
    local function update(input)
        local pos = math.clamp((input.Position.X - bg.AbsolutePosition.X) / math.max(bg.AbsoluteSize.X, 1), 0, 1)
        setValue(min + (max - min) * pos, true)
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

    registerConfigControl(text, "decimal", function() return currentValue end, function(v) setValue(v, true) end)
    return card
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
    btn.Text = tostring(default)
    btn.TextColor3 = Color3.fromRGB(230, 40, 135)
    btn.Font = Enum.Font.SourceSans
    btn.TextSize = 14
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    local s = Instance.new("UIStroke", btn)
    s.Color = Color3.fromRGB(255, 105, 180)

    -- Keep the dropdown INSIDE its own control card.  Older builds parented
    -- every option list directly to the master Scroll, so hidden dropdowns
    -- were sorted into Silent Aim and appeared on the wrong page.
    local closedHeight, openHeight = 40, 168
    local dropFrame = Instance.new("ScrollingFrame", card)
    dropFrame.Name = "KimqDropdownOptions"
    dropFrame.Size = UDim2.new(1, -16, 0, 120)
    dropFrame.Position = UDim2.new(0, 8, 0, 40)
    dropFrame.BackgroundColor3 = Color3.fromRGB(255, 225, 238)
    dropFrame.Visible = false
    dropFrame.BorderSizePixel = 0
    dropFrame.ScrollBarThickness = 3
    dropFrame.ZIndex = 25
    Instance.new("UICorner", dropFrame).CornerRadius = UDim.new(0, 8)
    local dList = Instance.new("UIListLayout", dropFrame)
    dList.SortOrder = Enum.SortOrder.LayoutOrder
    dList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        dropFrame.CanvasSize = UDim2.new(0, 0, 0, dList.AbsoluteContentSize.Y)
    end)

    local currentValue = tostring(default)
    local valid = {}
    for _,v in ipairs(list) do valid[tostring(v)] = true end

    local function setOpen(open)
        dropFrame.Visible = open == true
        card.Size = UDim2.new(1, -6, 0, open and openHeight or closedHeight)
    end

    local function setValue(v, fireCallback)
        v = tostring(v)
        if not valid[v] then return false end
        currentValue = v
        btn.Text = v
        setOpen(false)
        if fireCallback ~= false then pcall(callback, v) end
        return true
    end

    for _, v in ipairs(list) do
        local item = Instance.new("TextButton", dropFrame)
        item.Size = UDim2.new(1, 0, 0, 24)
        item.BackgroundTransparency = 1
        item.Text = tostring(v)
        item.TextColor3 = Color3.fromRGB(166, 55, 105)
        item.Font = Enum.Font.SourceSans
        item.TextSize = 13
        item.ZIndex = 26
        item.MouseButton1Click:Connect(function() setValue(v, true) end)
    end
    btn.MouseButton1Click:Connect(function() setOpen(not dropFrame.Visible) end)

    registerConfigControl(text, "dropdown", function() return currentValue end, function(v) setValue(v, true) end)
    return card, btn
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
    btn.TextColor3 = Color3.fromRGB(230, 40, 135)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 12
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    local st = Instance.new("UIStroke", btn)
    st.Color = Color3.fromRGB(255, 105, 180)

    local currentKey = defaultKey
    btn.Text = currentKey.Name
    local listening = false

    local function resolveKey(v)
        if typeof(v) == "EnumItem" and v.EnumType == Enum.KeyCode then return v end
        local key = nil
        pcall(function() key = Enum.KeyCode[tostring(v)] end)
        return key
    end
    local function setKey(v, fireCallback)
        local key = resolveKey(v)
        if not key or key == Enum.KeyCode.Unknown then return false end
        currentKey = key
        btn.Text = key.Name
        if fireCallback ~= false then pcall(callback, key) end
        return true
    end

    btn.MouseButton1Click:Connect(function()
        listening = true
        btn.Text = "..."
    end)
    UIS.InputBegan:Connect(function(input, gpe)
        if listening and not gpe and input.UserInputType == Enum.UserInputType.Keyboard then
            listening = false
            setKey(input.KeyCode, true)
        end
    end)

    registerConfigControl(text, "keybind", function() return currentKey.Name end, function(v) setKey(v, true) end)
    return card, btn
end


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

-- Primary Silent Aim page controls. v2.63 keeps this section isolated, but
-- every control now feeds the same resolver used by Mouse.Hit/Target/UnitRay.
if not runChunk("silent_ui", [=====[
local C = _G.KimpetrasCtx
if not C then error("Kimqetras core context missing") end
local cfg = C.cfg
local addToggle = C.addToggle
local addSlider = C.addSlider
local addDecimalSlider = C.addDecimalSlider
local addDropdown = C.addDropdown
local addKeybind = C.addKeybind
_G.KimqBuildSection = "silent"

local silentParts = {
    "Closest Point",
    "Head", "UpperTorso", "HumanoidRootPart", "LowerTorso",
    "LeftUpperArm", "RightUpperArm", "LeftLowerArm", "RightLowerArm",
    "LeftHand", "RightHand", "LeftUpperLeg", "RightUpperLeg",
    "LeftLowerLeg", "RightLowerLeg", "LeftFoot", "RightFoot"
}

-- v2.64: Silent Aim is already active when the script loads.
-- Do not register a "Silent Aim" config control, so loading an older config
-- cannot switch the resolver off behind the user's back.
cfg.silentAim = true

addToggle("Show FOV Circle", cfg.silentAimFOVShow, function(v) cfg.silentAimFOVShow = v end)
addSlider("FOV Size", 10, 1000, cfg.silentAimFOV, function(v) cfg.silentAimFOV = v end)
addToggle("Strict FOV", cfg.silentAimStrictFOV, function(v) cfg.silentAimStrictFOV=v end)
addToggle("Filled FOV", cfg.silentAimFOVFilled, function(v) cfg.silentAimFOVFilled=v end)
addSlider("FOV Opacity", 5, 100, math.floor(cfg.silentAimFOVOpacity*100+.5), function(v)
    cfg.silentAimFOVOpacity=math.clamp(v/100,.05,1)
end)

addSlider("Hit Chance", 1, 100, cfg.silentAimHitChance, function(v) cfg.silentAimHitChance = v end)
addSlider("Target Stickiness", 0, 80, cfg.silentAimStickiness, function(v) cfg.silentAimStickiness=v end)
addDropdown("Target Priority", {"Closest Cursor","Closest Distance","Lowest Health"}, cfg.silentAimPriority, function(v)
    cfg.silentAimPriority=v
end)

addToggle("Bypass Revolver", cfg.bypassRevolver, function(v) cfg.bypassRevolver = v end)
addToggle("Wall Check", cfg.silentAimWallCheck, function(v) cfg.silentAimWallCheck = v end)
addToggle("Team Check", cfg.silentAimTeamCheck, function(v) cfg.silentAimTeamCheck = v end)
addToggle("Knock Check", cfg.silentAimKnockCheck, function(v) cfg.silentAimKnockCheck = v end)

local initialSilentPart = cfg.silentAimClosestPart and "Closest Point" or cfg.silentAimPart
addDropdown("Hit Part", silentParts, initialSilentPart, function(v)
    if v=="Closest Point" or v=="Closest Part" then
        cfg.silentAimClosestPart=true
    else
        cfg.silentAimClosestPart=false
        cfg.silentAimPart=v
    end
end)

-- Saved v2.63/v2.64 configs used the old string "Closest Part".
-- Transparently migrate that value instead of breaking old presets.
pcall(function()
    local reg=_G.KimqConfigControls and _G.KimqConfigControls["Hit Part"]
    if reg and type(reg.set)=="function" then
        local oldSet=reg.set
        reg.set=function(v)
            if tostring(v)=="Closest Part" then v="Closest Point" end
            return oldSet(v)
        end
    end
end)

addSlider("Max Target Distance", 50, 5000, cfg.silentAimMaxDist, function(v) cfg.silentAimMaxDist = v end)

addToggle("Auto Prediction", cfg.silentAimAutoPrediction, function(v) cfg.silentAimAutoPrediction=v end)
addDecimalSlider("Auto Prediction Strength", .25, 2.5, cfg.silentAimAutoPredictionStrength, 2, function(v)
    cfg.silentAimAutoPredictionStrength=v
end)
addDecimalSlider("Silent Prediction X", 0, 0.5, cfg.silentAimPredX, 3, function(v) cfg.silentAimPredX = v end)
addDecimalSlider("Silent Prediction Y", 0, 0.5, cfg.silentAimPredY, 3, function(v) cfg.silentAimPredY = v end)


-- Optional alternating camera swap on each local gun shot.
-- It only reacts while a real gun Tool is equipped in the Character.
-- Normal camera rotation/zoom remains available between shots; scrolling during
-- a transition cancels the scripted zoom immediately and gives control back.
-- Defaults: Zoom Speed 8 / Zoom Min 5 / Zoom Max 25 / Stay Min .500 /
-- Stay Max .500 / Frequency 2.000. Shift+4 toggles the feature.
_G.KimqShotCameraSwapEnabled = _G.KimqShotCameraSwapEnabled == true
-- v2.80: independent ambient/random zoom mode. It uses the same speed/min/max/
-- stay/frequency tuning but does not require a shot or even an equipped gun.
_G.KimqRandomCameraZoomEnabled = _G.KimqRandomCameraZoomEnabled == true
_G.KimqCameraZoomSpeed = tonumber(_G.KimqCameraZoomSpeed) or 8
_G.KimqCameraZoomMin = tonumber(_G.KimqCameraZoomMin) or 5
_G.KimqCameraZoomMax = tonumber(_G.KimqCameraZoomMax) or 25
_G.KimqCameraStayMin = tonumber(_G.KimqCameraStayMin) or 0.500
_G.KimqCameraStayMax = tonumber(_G.KimqCameraStayMax) or 0.500
_G.KimqCameraFrequency = tonumber(_G.KimqCameraFrequency) or 2.000

local lp = C.lp
local RunService = C.RunService
local UIS = C.UIS
local hookedCameraTools = setmetatable({}, {__mode="k"})
local hookedCameraContainers = setmetatable({}, {__mode="k"})
local cameraSwapToken = 0
local lastThirdDistance = 10
local nextCameraSwapAllowed = 0
local savedZoomMin, savedZoomMax, savedCameraMode = nil, nil, nil
local equippedCameraGun = nil
local randomCameraLoopToken = 0
local lastShotCameraSwapAt = 0

local function cameraTuning()
    local speed=math.clamp(tonumber(_G.KimqCameraZoomSpeed) or 8,1,20)
    local zmin=math.clamp(tonumber(_G.KimqCameraZoomMin) or 5,1,60)
    local zmax=math.clamp(tonumber(_G.KimqCameraZoomMax) or 25,1,60)
    if zmin>zmax then zmin,zmax=zmax,zmin end
    local smin=math.clamp(tonumber(_G.KimqCameraStayMin) or .5,0,3)
    local smax=math.clamp(tonumber(_G.KimqCameraStayMax) or .5,0,3)
    if smin>smax then smin,smax=smax,smin end
    local freq=math.clamp(tonumber(_G.KimqCameraFrequency) or 2,.25,10)
    return speed,zmin,zmax,smin,smax,freq
end

local function cameraDistance()
    local cam = workspace.CurrentCamera
    if not cam then return 10 end
    local ok,dist = pcall(function() return (cam.CFrame.Position-cam.Focus.Position).Magnitude end)
    if ok and type(dist)=="number" and dist==dist then return math.clamp(dist,0.5,128) end
    return 10
end

local function inFirstPerson()
    return lp.CameraMode==Enum.CameraMode.LockFirstPerson or cameraDistance()<=1.05
end

local function saveCameraDefaults()
    if savedZoomMin==nil then
        savedZoomMin=lp.CameraMinZoomDistance
        savedZoomMax=lp.CameraMaxZoomDistance
        savedCameraMode=lp.CameraMode
    end
end

local function restoreCameraLimits(restoreMode)
    if savedZoomMin~=nil then pcall(function() lp.CameraMinZoomDistance=savedZoomMin end) end
    if savedZoomMax~=nil then pcall(function() lp.CameraMaxZoomDistance=savedZoomMax end) end
    if restoreMode and savedCameraMode~=nil then pcall(function() lp.CameraMode=savedCameraMode end) end
end

local function cancelCameraTween(restoreMode)
    cameraSwapToken+=1
    restoreCameraLimits(restoreMode==true)
end

local function setExactZoom(z)
    z=math.clamp(tonumber(z) or 0.5,0.5,128)
    pcall(function()
        -- Classic keeps normal mouse-look/camera rotation alive. We only constrain
        -- zoom for the tiny duration of the smooth transition.
        lp.CameraMode=Enum.CameraMode.Classic
        lp.CameraMinZoomDistance=z
        lp.CameraMaxZoomDistance=z
    end)
end

local function isLikelyGun(tool)
    if not tool or not tool:IsA("Tool") then return false end
    local n=tostring(tool.Name or ""):lower()
    if n:find("knife",1,true) or n:find("wallet",1,true) or n:find("phone",1,true) then return false end
    local gunWords={"revolver","shotgun","silencer","smg","pistol","rifle","gun","tactical","double","glock","uzi","ak"}
    for _,word in ipairs(gunWords) do if n:find(word,1,true) then return true end end
    for _,d in ipairs(tool:GetDescendants()) do
        local dn=tostring(d.Name or ""):lower()
        if dn=="ammo" or dn=="clip" or dn=="muzzle" or dn=="muzzleflash" then return true end
    end
    return false
end

local function gunIsActuallyEquipped(tool)
    return tool and tool==equippedCameraGun and tool.Parent==lp.Character and isLikelyGun(tool)
end

local function smoothZoomTo(target,token,tool)
    local start=cameraDistance()
    local speed,_,_,_,_,freq=cameraTuning()
    local duration=math.clamp(.32*(8/speed)*(2/freq),.08,.9)
    local t0=os.clock()
    while token==cameraSwapToken and _G.KimqShotCameraSwapEnabled and gunIsActuallyEquipped(tool) do
        local a=math.clamp((os.clock()-t0)/duration,0,1)
        local eased=a*a*(3-2*a)
        setExactZoom(start+(target-start)*eased)
        if a>=1 then break end
        RunService.RenderStepped:Wait()
    end
    if token~=cameraSwapToken or not _G.KimqShotCameraSwapEnabled or not gunIsActuallyEquipped(tool) then
        restoreCameraLimits(false)
        return
    end
    setExactZoom(target)
    RunService.RenderStepped:Wait()
    -- Give all normal wheel zoom + mouse camera control back immediately.
    restoreCameraLimits(false)
    pcall(function() lp.CameraMode=Enum.CameraMode.Classic end)
end

local function doShotCameraSwap(tool)
    if not _G.KimqShotCameraSwapEnabled or not gunIsActuallyEquipped(tool) then return end

    local now=os.clock()
    lastShotCameraSwapAt=now
    if now<nextCameraSwapAllowed then return end

    local _,zmin,zmax,stayMin,stayMax,freq=cameraTuning()
    local stay=stayMin
    if stayMax>stayMin then stay=stayMin+(stayMax-stayMin)*math.random() end
    nextCameraSwapAllowed=now+math.max(stay,1/freq)

    saveCameraDefaults()
    local dist=cameraDistance()
    local first=inFirstPerson()

    -- Your actual current view decides the next direction. So you can freely
    -- zoom anywhere between shots and the next shot still behaves naturally.
    local target
    if first then
        target=math.clamp(lastThirdDistance or zmin,zmin,zmax)
    else
        if dist>1.1 then lastThirdDistance=math.clamp(dist,zmin,zmax) end
        target=0.5
    end

    cameraSwapToken+=1
    local token=cameraSwapToken
    task.spawn(function() smoothZoomTo(target,token,tool) end)
end

local function randomCameraCanRun()
    if not _G.KimqRandomCameraZoomEnabled then return false end
    local camera=workspace.CurrentCamera
    if not camera or camera.CameraType==Enum.CameraType.Scriptable then return false end
    -- Let an actual shot-camera transition win briefly if both modes are enabled.
    if os.clock()-lastShotCameraSwapAt<.65 then return false end
    return true
end

local function smoothRandomZoomTo(target,token)
    local start=cameraDistance()
    local speed=select(1,cameraTuning())
    local duration=math.clamp(.34*(8/speed),.08,.9)
    local t0=os.clock()
    while token==cameraSwapToken and randomCameraCanRun() do
        local a=math.clamp((os.clock()-t0)/duration,0,1)
        local eased=a*a*(3-2*a)
        setExactZoom(start+(target-start)*eased)
        if a>=1 then break end
        RunService.RenderStepped:Wait()
    end
    restoreCameraLimits(false)
    pcall(function() lp.CameraMode=Enum.CameraMode.Classic end)
end

local function doRandomCameraZoom()
    if not randomCameraCanRun() then return end
    local _,zmin,zmax=cameraTuning()
    if zmax-zmin<.25 then return end
    saveCameraDefaults()
    local dist=cameraDistance()
    local midpoint=(zmin+zmax)*.5
    local target
    -- Alternate based on current distance so it visibly goes IN and OUT instead
    -- of repeatedly choosing nearly-identical random distances.
    if dist<=midpoint then
        target=midpoint+(zmax-midpoint)*(.35+.65*math.random())
    else
        target=zmin+(midpoint-zmin)*(.65*math.random())
    end
    cameraSwapToken+=1
    local token=cameraSwapToken
    task.spawn(function() smoothRandomZoomTo(target,token) end)
end

local function startRandomCameraLoop()
    randomCameraLoopToken+=1
    local loopToken=randomCameraLoopToken
    if not _G.KimqRandomCameraZoomEnabled then return end
    task.spawn(function()
        while loopToken==randomCameraLoopToken and _G.KimqRandomCameraZoomEnabled do
            local _,_,_,stayMin,stayMax,freq=cameraTuning()
            local waitTime=stayMin
            if stayMax>stayMin then waitTime=stayMin+(stayMax-stayMin)*math.random() end
            waitTime=math.max(waitTime,1/math.max(freq,.25),.12)
            task.wait(waitTime)
            if loopToken~=randomCameraLoopToken or not _G.KimqRandomCameraZoomEnabled then break end
            doRandomCameraZoom()
        end
    end)
end

addToggle("Random Camera Zoom", _G.KimqRandomCameraZoomEnabled, function(v)
    _G.KimqRandomCameraZoomEnabled=v==true
    randomCameraLoopToken+=1
    cancelCameraTween(false)
    if _G.KimqRandomCameraZoomEnabled then
        saveCameraDefaults()
        startRandomCameraLoop()
    else
        restoreCameraLimits(false)
    end
end)

addToggle("Shot Camera Swap", _G.KimqShotCameraSwapEnabled, function(v)
    _G.KimqShotCameraSwapEnabled=v==true
    cancelCameraTween(not _G.KimqShotCameraSwapEnabled)
    nextCameraSwapAllowed=0
    if not _G.KimqShotCameraSwapEnabled then
        savedZoomMin,savedZoomMax,savedCameraMode=nil,nil,nil
    else
        local _,zmin,zmax=cameraTuning()
        local d=cameraDistance()
        if d>1.1 then lastThirdDistance=math.clamp(d,zmin,zmax) end
    end
end)

addSlider("Zoom Speed", 1, 20, _G.KimqCameraZoomSpeed, function(v)
    _G.KimqCameraZoomSpeed=v
end)
addSlider("Zoom Min", 1, 30, _G.KimqCameraZoomMin, function(v)
    _G.KimqCameraZoomMin=v
end)
addSlider("Zoom Max", 5, 50, _G.KimqCameraZoomMax, function(v)
    _G.KimqCameraZoomMax=v
end)
addDecimalSlider("Stay Min", 0, 2, _G.KimqCameraStayMin, 3, function(v)
    _G.KimqCameraStayMin=v
end)
addDecimalSlider("Stay Max", 0, 2, _G.KimqCameraStayMax, 3, function(v)
    _G.KimqCameraStayMax=v
end)
addDecimalSlider("Frequency", 0.25, 8, _G.KimqCameraFrequency, 3, function(v)
    _G.KimqCameraFrequency=v
end)

if _G.KimqRandomCameraZoomEnabled then
    task.defer(startRandomCameraLoop)
end

UIS.InputBegan:Connect(function(input,gpe)
    if gpe or input.UserInputType~=Enum.UserInputType.Keyboard then return end
    if input.KeyCode==Enum.KeyCode.Four and (UIS:IsKeyDown(Enum.KeyCode.LeftShift) or UIS:IsKeyDown(Enum.KeyCode.RightShift)) then
        local nextValue=not _G.KimqShotCameraSwapEnabled
        local reg=rawget(_G,"KimqConfigControls")
        local control=reg and reg["Shot Camera Swap"]
        if control and type(control.set)=="function" then
            pcall(control.set,nextValue)
        else
            _G.KimqShotCameraSwapEnabled=nextValue
            cancelCameraTween(not nextValue)
            nextCameraSwapAllowed=0
            if not nextValue then savedZoomMin,savedZoomMax,savedCameraMode=nil,nil,nil end
        end
    end
end)

-- If you scroll while a scripted zoom is moving, manual control wins instantly.
UIS.InputChanged:Connect(function(input,gpe)
    if gpe then return end
    if input.UserInputType==Enum.UserInputType.MouseWheel and equippedCameraGun then
        cancelCameraTween(false)
        task.defer(function()
            local _,zmin,zmax=cameraTuning()
            local d=cameraDistance()
            if d>1.1 then lastThirdDistance=math.clamp(d,zmin,zmax) end
        end)
    end
end)

local function hookCameraTool(tool)
    if not tool or not tool:IsA("Tool") or hookedCameraTools[tool] then return end
    hookedCameraTools[tool]=true
    tool.Equipped:Connect(function()
        if isLikelyGun(tool) then
            equippedCameraGun=tool
            local _,zmin,zmax=cameraTuning()
            local d=cameraDistance()
            if d>1.1 then lastThirdDistance=math.clamp(d,zmin,zmax) end
        end
    end)
    tool.Unequipped:Connect(function()
        if equippedCameraGun==tool then
            equippedCameraGun=nil
            cancelCameraTween(false)
            nextCameraSwapAllowed=0
        end
    end)
    tool.Activated:Connect(function()
        doShotCameraSwap(tool)
    end)
end

local function hookCameraContainer(container)
    if not container or hookedCameraContainers[container] then return end
    hookedCameraContainers[container]=true
    for _,ch in ipairs(container:GetChildren()) do hookCameraTool(ch) end
    container.ChildAdded:Connect(hookCameraTool)
end

hookCameraContainer(lp:FindFirstChildOfClass("Backpack"))
if lp.Character then
    hookCameraContainer(lp.Character)
    for _,ch in ipairs(lp.Character:GetChildren()) do
        if ch:IsA("Tool") and isLikelyGun(ch) then equippedCameraGun=ch break end
    end
end
lp.CharacterAdded:Connect(function(char)
    equippedCameraGun=nil
    cancelCameraTween(false)
    nextCameraSwapAllowed=0
    task.delay(0.15,function()
        hookCameraContainer(char)
        hookCameraContainer(lp:FindFirstChildOfClass("Backpack"))
    end)
end)
]=====], false) then return end

if not runChunk("macro", [=====[
local C = _G.KimpetrasCtx
if not C then error("Kimqetras core context missing") end
local UIS, RunService, lp, Scroll = C.UIS, C.RunService, C.lp, C.Scroll
local createCard, addToggle, addSlider, addKeybind = C.createCard, C.addToggle, C.addSlider, C.addKeybind
_G.KimqBuildSection = "macro"

-- ========================================================
-- MACRO / SPEED + I/O
-- Restored from the older working Kimqetras macro.
-- ========================================================
local MacroMaster = false
local MacroActive = false
local MacroSpeed = 50
local MacroKey = Enum.KeyCode.X

local MacroIOSpam = false
local MacroIOInterval = 0.022
local MacroIOFlip = false
local MacroIOAccumulator = 0

local VirtualInputManager = nil
pcall(function()
    VirtualInputManager = game:GetService("VirtualInputManager")
end)

-- Compatibility globals for configs / other Kimqetras modules.
_G.SpeedMaster = MacroMaster
_G.SpeedActive = MacroActive
_G.SpeedValue = MacroSpeed
_G.SpeedKey = MacroKey

local MacroHeader = Instance.new("TextLabel", Scroll)
MacroHeader.Size = UDim2.new(1,-6,0,34)
MacroHeader.BackgroundTransparency = 1
MacroHeader.Text = "♥  Macro"
MacroHeader.TextColor3 = Color3.fromRGB(225,73,140)
MacroHeader.Font = Enum.Font.GothamBold
MacroHeader.TextSize = 18
MacroHeader.TextXAlignment = Enum.TextXAlignment.Left

addToggle("Macro / Speed Master", MacroMaster, function(v)
    MacroMaster = not not v
    _G.SpeedMaster = MacroMaster
    if not MacroMaster then
        MacroActive = false
        _G.SpeedActive = false
        MacroIOAccumulator = 0
        MacroIOFlip = false
    end
end)

addKeybind("Macro Key", MacroKey, function(v)
    MacroKey = v
    _G.SpeedKey = v
end)

addSlider("Macro Speed", 16, 1000, MacroSpeed, function(v)
    MacroSpeed = v
    _G.SpeedValue = v
end)

addToggle("I / O Spam While Macroing", MacroIOSpam, function(v)
    MacroIOSpam = not not v
    MacroIOAccumulator = 0
    MacroIOFlip = false
end)

local MacroHintCard = createCard(54)
local MacroHint = Instance.new("TextLabel", MacroHintCard)
MacroHint.Size = UDim2.new(1,-20,1,0)
MacroHint.Position = UDim2.fromOffset(10,0)
MacroHint.BackgroundTransparency = 1
MacroHint.Text = "Turn Master on, press your Macro Key to toggle it. I / O spam alternates I and O while the macro is active."
MacroHint.TextColor3 = Color3.fromRGB(197,112,145)
MacroHint.Font = Enum.Font.Gotham
MacroHint.TextSize = 11
MacroHint.TextXAlignment = Enum.TextXAlignment.Left
MacroHint.TextWrapped = true

UIS.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == MacroKey then
        if MacroMaster then
            MacroActive = not MacroActive
            _G.SpeedActive = MacroActive
            if MacroActive then
                task.defer(function()
                    local char=lp.Character
                    local hum=char and char:FindFirstChildOfClass("Humanoid")
                    if hum then
                        local wanted=math.clamp(tonumber(MacroSpeed) or 50,16,1000)
                        pcall(function() hum.WalkSpeed=wanted end)
                    end
                end)
            end
        end
    end
end)

local function sendMacroIO(keyCode)
    local sent = false

    if VirtualInputManager then
        sent = pcall(function()
            VirtualInputManager:SendKeyEvent(true, keyCode, false, game)
            task.delay(.006, function()
                pcall(function()
                    VirtualInputManager:SendKeyEvent(false, keyCode, false, game)
                end)
            end)
        end)
    end
    if sent then return end

    -- Executor fallback used by the older working build.
    local vk = (keyCode == Enum.KeyCode.I) and 0x49 or 0x4F
    if type(keypress) == "function" and type(keyrelease) == "function" then
        pcall(function()
            keypress(vk)
            keyrelease(vk)
        end)
    end
end

local macroHumanoid=nil
local macroWalkConn=nil
local macroCharConn=nil
local macroApplying=false

local function desiredMacroSpeed()
    return math.clamp(tonumber(MacroSpeed) or 50,16,1000)
end

local function enforceMacroSpeed()
    if macroApplying or not (MacroMaster and MacroActive) then return end
    local char=lp.Character
    if not char then return end
    local hum=char:FindFirstChildOfClass("Humanoid")
    if not hum then return end

    local wanted=desiredMacroSpeed()
    if hum.WalkSpeed~=wanted then
        macroApplying=true
        pcall(function() hum.WalkSpeed=wanted end)
        macroApplying=false
    end
end

local function bindMacroHumanoid(char)
    if macroWalkConn then pcall(function() macroWalkConn:Disconnect() end); macroWalkConn=nil end
    macroHumanoid=nil
    if not char then return end

    local hum=char:FindFirstChildOfClass("Humanoid") or char:WaitForChild("Humanoid",6)
    if not hum then return end
    macroHumanoid=hum

    -- FFA's round controller changes WalkSpeed after the character initially
    -- spawns. Re-assert immediately whenever that happens.
    macroWalkConn=hum:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
        if MacroMaster and MacroActive and not macroApplying then
            enforceMacroSpeed()
        end
    end)

    if MacroMaster and MacroActive then
        task.defer(enforceMacroSpeed)
    end
end

if lp.Character then task.defer(bindMacroHumanoid,lp.Character) end
macroCharConn=lp.CharacterAdded:Connect(function(char)
    task.defer(bindMacroHumanoid,char)
end)

-- PreSimulation affects the next physics step.
pcall(function()
    RunService.PreSimulation:Connect(function()
        enforceMacroSpeed()
    end)
end)

-- Heartbeat catches round scripts that update during simulation.
RunService.Heartbeat:Connect(function(dt)
    enforceMacroSpeed()

    if MacroMaster and MacroActive and MacroIOSpam then
        MacroIOAccumulator += dt
        while MacroIOAccumulator >= MacroIOInterval do
            MacroIOAccumulator -= MacroIOInterval
            MacroIOFlip = not MacroIOFlip
            sendMacroIO(MacroIOFlip and Enum.KeyCode.I or Enum.KeyCode.O)
        end
    else
        MacroIOAccumulator = 0
        MacroIOFlip = false
    end

    _G.SpeedMaster = MacroMaster
    _G.SpeedActive = MacroActive
    _G.SpeedValue = MacroSpeed
    _G.SpeedKey = MacroKey
end)

-- A late render pass catches client round controllers that clamp speed
-- after Heartbeat. This still uses Humanoid.WalkSpeed only; no CFrame macro.
pcall(function()
    RunService:BindToRenderStep("KimqMacroSpeedV261",Enum.RenderPriority.Last.Value,function()
        enforceMacroSpeed()
    end)
end)

]=====], false) then return end

if not runChunk("extras", [=====[
local C = _G.KimpetrasCtx
if not C then error("Kimqetras core context missing") end
local Players, RunService, lp, cam, Scroll = C.Players, C.RunService, C.lp, C.cam, C.Scroll
local createCard, addToggle, addSlider, addDecimalSlider, addButton = C.createCard, C.addToggle, C.addSlider, C.addDecimalSlider, C.addButton
-- ========================================================
-- KIM.CHAR / AVATAR - MERGED INTO KIMQETRAS
-- ========================================================

local AvatarEnabled = false
local AvatarHeadless = false
local AvatarTarget = ""

-- ========================================================
-- EXTRA FEATURES FROM DOCUMENT (3)
-- Whitelist / Protection / Anti Fall / Delay Changer / ESP
-- ========================================================

local ExtraAntiAimView = true
local ExtraAntiFall = false
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
-- Event-driven instead of polling every Heartbeat.
local extraAntiFallStateConn
local function hookExtraAntiFall(char)
    if extraAntiFallStateConn then pcall(function() extraAntiFallStateConn:Disconnect() end); extraAntiFallStateConn=nil end
    local hum=char and (char:FindFirstChildOfClass("Humanoid") or char:WaitForChild("Humanoid",5))
    if not hum then return end
    extraAntiFallStateConn=hum.StateChanged:Connect(function(_,newState)
        if ExtraAntiFall and hum.Health>1 and newState==Enum.HumanoidStateType.FallingDown then
            hum:ChangeState(Enum.HumanoidStateType.GettingUp)
        end
    end)
end
if lp.Character then hookExtraAntiFall(lp.Character) end
lp.CharacterAdded:Connect(hookExtraAntiFall)

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
    local backpack=lp:FindFirstChildOfClass("Backpack")
    if backpack then for _,v in ipairs(backpack:GetDescendants()) do applyExtraDelay(v) end end
    local char=lp.Character
    if char then for _,v in ipairs(char:GetDescendants()) do applyExtraDelay(v) end end
end

local extraDelayBackpack=lp:FindFirstChildOfClass("Backpack")
if extraDelayBackpack then extraDelayBackpack.DescendantAdded:Connect(function(v) if ExtraDelayChanger then applyExtraDelay(v) end end) end
lp.CharacterAdded:Connect(function(char)
    char.DescendantAdded:Connect(function(v) if ExtraDelayChanger then applyExtraDelay(v) end end)
    if ExtraDelayChanger then task.defer(applyAllExtraDelays) end
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

local extraESPWasEnabled = false
RunService.RenderStepped:Connect(function()
    if not ExtraESPEnabled then
        if extraESPWasEnabled then
            for _, objs in pairs(extraESPObjects) do hideExtraESP(objs) end
            extraESPWasEnabled = false
        end
        return
    end
    extraESPWasEnabled = true
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
_G.KimqBuildSection = "whitelist"
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
    card:SetAttribute("KimqSection", "whitelist")
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
        local live = _G.KimqThemeLivePalette
        local hot = (live and live.hot) or Color3.fromRGB(243,161,211)
        local soft = (live and (live.soft or live.bg2)) or Color3.fromRGB(236,255,243)
        local white = (live and live.white) or Color3.new(1,1,1)
        local text = (live and live.text) or Color3.fromRGB(82,116,94)
        btn.BackgroundColor3 = on and hot or soft
        btn.TextColor3 = on and white or text
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
            if btn then
                local live = _G.KimqThemeLivePalette
                btn.Text = "OFF"
                btn.BackgroundColor3 = (live and (live.soft or live.bg2)) or Color3.fromRGB(236,255,243)
                btn.TextColor3 = (live and live.text) or Color3.fromRGB(82,116,94)
            end
        end
    end
end)

-- Protection section
_G.KimqBuildSection = "protection"
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
_G.KimqBuildSection = "antifall"
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
_G.KimqBuildSection = "delay"
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
_G.KimqBuildSection = "esp"
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

-- Full RGB ESP picker: 0-255 on each channel can create any RGB color.
local ESP_R = math.floor(ExtraESPColor.R*255 + .5)
local ESP_G = math.floor(ExtraESPColor.G*255 + .5)
local ESP_B = math.floor(ExtraESPColor.B*255 + .5)
local ESPColorPreview
local function applyESPColorRGB()
    ExtraESPColor = Color3.fromRGB(
        math.clamp(math.floor(ESP_R+.5),0,255),
        math.clamp(math.floor(ESP_G+.5),0,255),
        math.clamp(math.floor(ESP_B+.5),0,255)
    )
    _G.KimqESPColor = ExtraESPColor
    if type(_G.KimqSetESPColor)=="function" then pcall(_G.KimqSetESPColor,ExtraESPColor) end
    if ESPColorPreview and ESPColorPreview.Parent then ESPColorPreview.BackgroundColor3=ExtraESPColor end
end

local espColorCard=createCard(54)
espColorCard.Name="KimqESPColorPreviewCard"
local espColorLabel=Instance.new("TextLabel",espColorCard)
espColorLabel.Size=UDim2.new(1,-78,1,0); espColorLabel.Position=UDim2.fromOffset(10,0)
espColorLabel.BackgroundTransparency=1; espColorLabel.Text="ESP Color  •  RGB"
espColorLabel.TextColor3=Color3.fromRGB(82,116,94); espColorLabel.Font=Enum.Font.GothamSemibold
espColorLabel.TextSize=11; espColorLabel.TextXAlignment=Enum.TextXAlignment.Left
ESPColorPreview=Instance.new("Frame",espColorCard)
ESPColorPreview.Size=UDim2.fromOffset(46,30); ESPColorPreview.Position=UDim2.new(1,-58,.5,-15)
ESPColorPreview.BorderSizePixel=0; ESPColorPreview.BackgroundColor3=ExtraESPColor
Instance.new("UICorner",ESPColorPreview).CornerRadius=UDim.new(0,8)
local espStroke=Instance.new("UIStroke",ESPColorPreview); espStroke.Color=Color3.new(1,1,1); espStroke.Transparency=.15; espStroke.Thickness=1
addSlider("ESP Red",0,255,ESP_R,function(v) ESP_R=v; applyESPColorRGB() end)
addSlider("ESP Green",0,255,ESP_G,function(v) ESP_G=v; applyESPColorRGB() end)
addSlider("ESP Blue",0,255,ESP_B,function(v) ESP_B=v; applyESPColorRGB() end)
applyESPColorRGB()

-- document (3) starts Anti Aim View enabled
setExtraAntiAimView(ExtraAntiAimView)

_G.KimqBuildSection = "avatar"
local AvatarHeader = Instance.new("TextLabel", Scroll)
AvatarHeader.Size = UDim2.new(1,-6,0,34)
AvatarHeader.BackgroundTransparency = 1
AvatarHeader.Text = "♥  Avatar"
AvatarHeader.TextColor3 = Color3.fromRGB(225, 73, 140)
AvatarHeader.Font = Enum.Font.GothamBold
AvatarHeader.TextSize = 18
AvatarHeader.TextXAlignment = Enum.TextXAlignment.Left

local AvatarIntro = createCard(58)
local AvatarIntroTitle = Instance.new("TextLabel", AvatarIntro)
AvatarIntroTitle.Size = UDim2.new(1,-20,0,22)
AvatarIntroTitle.Position = UDim2.fromOffset(10,7)
AvatarIntroTitle.BackgroundTransparency = 1
AvatarIntroTitle.Text = "Copy a Roblox avatar"
AvatarIntroTitle.TextColor3 = Color3.fromRGB(230,40,135)
AvatarIntroTitle.Font = Enum.Font.GothamBold
AvatarIntroTitle.TextSize = 14
AvatarIntroTitle.TextXAlignment = Enum.TextXAlignment.Left
local AvatarIntroSub = Instance.new("TextLabel", AvatarIntro)
AvatarIntroSub.Size = UDim2.new(1,-20,0,18)
AvatarIntroSub.Position = UDim2.fromOffset(10,31)
AvatarIntroSub.BackgroundTransparency = 1
AvatarIntroSub.Text = "Paste a username or user ID. Changes are visual/local."
AvatarIntroSub.TextColor3 = Color3.fromRGB(197,112,145)
AvatarIntroSub.Font = Enum.Font.Gotham
AvatarIntroSub.TextSize = 11
AvatarIntroSub.TextXAlignment = Enum.TextXAlignment.Left

local AvatarTargetCard = createCard(70)
local AvatarTargetLabel = Instance.new("TextLabel", AvatarTargetCard)
AvatarTargetLabel.Size = UDim2.new(1,-20,0,20)
AvatarTargetLabel.Position = UDim2.fromOffset(10,6)
AvatarTargetLabel.BackgroundTransparency = 1
AvatarTargetLabel.Text = "Username / User ID"
AvatarTargetLabel.TextColor3 = Color3.fromRGB(230,40,135)
AvatarTargetLabel.Font = Enum.Font.GothamBold
AvatarTargetLabel.TextSize = 13
AvatarTargetLabel.TextXAlignment = Enum.TextXAlignment.Left

local AvatarTargetBox = Instance.new("TextBox", AvatarTargetCard)
AvatarTargetBox.Size = UDim2.new(1,-20,0,31)
AvatarTargetBox.Position = UDim2.fromOffset(10,32)
AvatarTargetBox.BackgroundColor3 = Color3.fromRGB(255,225,238)
AvatarTargetBox.BorderSizePixel = 0
AvatarTargetBox.Text = ""
AvatarTargetBox.PlaceholderText = "@username or user id"
AvatarTargetBox.PlaceholderColor3 = Color3.fromRGB(197,112,145)
AvatarTargetBox.TextColor3 = Color3.fromRGB(230,40,135)
AvatarTargetBox.Font = Enum.Font.Gotham
AvatarTargetBox.TextSize = 13
AvatarTargetBox.TextXAlignment = Enum.TextXAlignment.Left
AvatarTargetBox.ClearTextOnFocus = false
Instance.new("UICorner", AvatarTargetBox).CornerRadius = UDim.new(0,8)
local AvatarPad = Instance.new("UIPadding", AvatarTargetBox)
AvatarPad.PaddingLeft = UDim.new(0,9)
AvatarPad.PaddingRight = UDim.new(0,9)

if type(_G.KimqRegisterConfigControl) == "function" then
    _G.KimqRegisterConfigControl("Avatar Target", "text",
        function() return tostring(AvatarTargetBox.Text or "") end,
        function(v)
            AvatarTargetBox.Text = tostring(v or "")
            AvatarTarget = AvatarTargetBox.Text
        end
    )
end

-- This replaces the old confusing "Enable Avatar" gate. Apply always works;
-- this toggle only controls whether the chosen look comes back after respawn.
addToggle("Keep Avatar After Respawn", false, function(v) AvatarEnabled = v end)

local function setAvatarKeepEnabled(v)
    v = not not v
    -- v2.77: the local persistence flag is authoritative.  Update it FIRST so
    -- respawn logic cannot depend on whether a config/UI setter succeeds.
    AvatarEnabled = v
    local reg = _G.KimqConfigControls and _G.KimqConfigControls["Keep Avatar After Respawn"]
    if reg and type(reg.set)=="function" then
        pcall(reg.set, v)
    end
end

addToggle("Visual Headless", false, function(v) AvatarHeadless = v end)

local AvatarActions = createCard(50)
local ApplyAvatarBtn = Instance.new("TextButton", AvatarActions)
ApplyAvatarBtn.Size = UDim2.new(.5,-14,0,34)
ApplyAvatarBtn.Position = UDim2.new(0,10,.5,-17)
ApplyAvatarBtn.BackgroundColor3 = Color3.fromRGB(255,20,147)
ApplyAvatarBtn.BorderSizePixel = 0
ApplyAvatarBtn.Text = "♥  Apply User Avatar"
ApplyAvatarBtn.TextColor3 = Color3.fromRGB(255,240,247)
ApplyAvatarBtn.Font = Enum.Font.GothamBold
ApplyAvatarBtn.TextSize = 12
ApplyAvatarBtn.AutoButtonColor = false
Instance.new("UICorner", ApplyAvatarBtn).CornerRadius = UDim.new(0,9)

local ResetAvatarBtn = Instance.new("TextButton", AvatarActions)
ResetAvatarBtn.Size = UDim2.new(.5,-14,0,34)
ResetAvatarBtn.Position = UDim2.new(.5,4,.5,-17)
ResetAvatarBtn.BackgroundColor3 = Color3.fromRGB(255,205,228)
ResetAvatarBtn.BorderSizePixel = 0
ResetAvatarBtn.Text = "Reset to My Avatar"
ResetAvatarBtn.TextColor3 = Color3.fromRGB(230,40,135)
ResetAvatarBtn.Font = Enum.Font.GothamBold
ResetAvatarBtn.TextSize = 12
ResetAvatarBtn.AutoButtonColor = false
Instance.new("UICorner", ResetAvatarBtn).CornerRadius = UDim.new(0,9)

local AvatarStatusCard = createCard(42)
local AvatarStatus = Instance.new("TextLabel", AvatarStatusCard)
AvatarStatus.Size = UDim2.new(1,-20,1,0)
AvatarStatus.Position = UDim2.fromOffset(10,0)
AvatarStatus.BackgroundTransparency = 1
AvatarStatus.Text = "Ready ♡"
AvatarStatus.TextColor3 = Color3.fromRGB(197,112,145)
AvatarStatus.Font = Enum.Font.Gotham
AvatarStatus.TextSize = 12
AvatarStatus.TextXAlignment = Enum.TextXAlignment.Left

local function setAvatarStatus(text, positive)
    AvatarStatus.Text = tostring(text or "")
    local p=_G.KimqThemeLivePalette
    AvatarStatus.TextColor3 = positive and ((p and p.hot) or Color3.fromRGB(230,40,135))
        or ((p and p.sub) or Color3.fromRGB(197,112,145))
end

local function resolveAvatarUserId(value)
    value = tostring(value or ""):gsub("%s+",""):gsub("^@","")
    if value == "" then return nil end
    local n = tonumber(value)
    if n then return math.floor(n) end
    local ok,id = pcall(function() return Players:GetUserIdFromNameAsync(value) end)
    return ok and id or nil
end

local function applyHeadless(char)
    local head = char and char:FindFirstChild("Head")
    if not head then return end
    local visualHead = char:FindFirstChild("KimqAvatarVisualHead")
    if visualHead and visualHead:IsA("BasePart") then
        -- Keep the gameplay head intact/invisible and show the copied user's exact
        -- visual head on top. This preserves dynamic-head faces without replacing
        -- the real Head that the game may depend on.
        head.Transparency = 1
        for _,d in ipairs(head:GetDescendants()) do
            if d:IsA("Decal") or d:IsA("Texture") then d.Transparency = 1 end
        end
        local original = visualHead:GetAttribute("KimqOriginalTransparency")
        visualHead.Transparency = AvatarHeadless and 1 or (type(original)=="number" and original or 0)
        for _,d in ipairs(visualHead:GetDescendants()) do
            if d:IsA("Decal") or d:IsA("Texture") then
                local base=d:GetAttribute("KimqOriginalTransparency")
                d.Transparency = AvatarHeadless and 1 or (type(base)=="number" and base or 0)
            end
        end
    else
        head.Transparency = AvatarHeadless and 1 or 0
        for _,d in ipairs(head:GetDescendants()) do
            if d:IsA("Decal") or d:IsA("Texture") then
                d.Transparency = AvatarHeadless and 1 or 0
            end
        end
    end
end

local function reapplySavedLocalAccessories(char)
    local controller = _G.KimqAccessoryController
    local ids = _G.KimqLocalVisualAccessoriesV15
    if not controller or type(controller.Equip)~="function" or type(ids)~="table" then return end
    task.defer(function()
        task.wait(.15)
        for _,assetId in ipairs(ids) do
            pcall(controller.Equip, tonumber(assetId), char, true)
            task.wait(.03)
        end
    end)
end

local function copyAnimationsFromDummy(char, dummy)
    local myAnimate = char and char:FindFirstChild("Animate")
    local dummyAnimate = dummy and dummy:FindFirstChild("Animate")
    local humanoid = char and char:FindFirstChildOfClass("Humanoid")
    if not myAnimate or not dummyAnimate or not humanoid then return end

    -- v2.80: do not stop currently-playing tracks here. Repeatedly killing every
    -- animation track was the source of random stiff/idle-looking moments while
    -- the avatar persistence guard repaired visuals. Updating the Animate IDs is
    -- enough; Roblox naturally uses them on the next animation state transition.
    for _,folder in ipairs(dummyAnimate:GetChildren()) do
        local mine=myAnimate:FindFirstChild(folder.Name)
        if mine then
            for _,anim in ipairs(folder:GetChildren()) do
                if anim:IsA("Animation") then
                    local existing=mine:FindFirstChild(anim.Name)
                    if existing and existing:IsA("Animation") then
                        pcall(function() existing.AnimationId=anim.AnimationId end)
                    else
                        pcall(function() anim:Clone().Parent=mine end)
                    end
                end
            end
        end
    end
end

-- v2.67: freeze the exact applied avatar inside saved configs instead of
-- re-querying the source user's CURRENT Roblox avatar later.
local activeAvatarSnapshot=nil
-- v2.78: remember HOW the current copied avatar was applied.  Manual Apply User
-- Avatar uses applyAvatarUser(), and that is the path confirmed to work in this game.
-- Respawns now use that same path instead of relying only on snapshot restoration.
local activeAvatarUserId=nil
local avatarPersistenceMode="snapshot" -- "user" for manual char-into, "snapshot" for frozen config snapshots
-- v2.79: keep a complete local clone of the successfully-applied avatar model.
-- Respawn restoration uses this cached model instead of re-fetching Roblox data.
local avatarPersistTemplate=nil

-- v2.68: isolated visibility editor for accessories that belong to the copied
-- avatar. This never deletes the accessory; it only hides/shows its local
-- visual descendants, so the copied avatar can be customized safely.
local avatarHiddenAccessoryKeys={}
local avatarAccessoryVisualBackup=setmetatable({}, {__mode="k"})
local avatarAccessoryRows={}
local avatarAccessoryRefreshToken=0

local function avatarAccessoryKey(acc)
    if not acc or not acc:IsA("Accessory") then return nil end
    local bits={tostring(acc.Name or "Accessory")}
    local okType,accessoryType=pcall(function() return acc.AccessoryType end)
    if okType and accessoryType then table.insert(bits,tostring(accessoryType.Name or accessoryType)) end
    local handle=acc:FindFirstChild("Handle")
    if handle then
        if handle:IsA("MeshPart") then
            table.insert(bits,tostring(handle.MeshId or ""))
            table.insert(bits,tostring(handle.TextureID or ""))
        else
            local mesh=handle:FindFirstChildOfClass("SpecialMesh")
            if mesh then
                table.insert(bits,tostring(mesh.MeshId or ""))
                table.insert(bits,tostring(mesh.TextureId or ""))
            end
        end
    end
    return table.concat(bits,"|")
end

local function copiedAvatarAccessory(acc)
    if not acc or not acc:IsA("Accessory") then return false end
    if acc:GetAttribute("KimqLocalV15") then return false end
    if acc:GetAttribute("KimqWornEquippable") then return false end
    if acc.Name=="KimqWornAngelWings" or tostring(acc.Name):match("^KimqLocal_") then return false end
    return true
end

local function rememberAccessoryVisual(obj,property,value)
    local rec=avatarAccessoryVisualBackup[obj]
    if not rec then rec={}; avatarAccessoryVisualBackup[obj]=rec end
    if rec[property]==nil then rec[property]=value end
end

local function setOneAccessoryHidden(acc,hidden)
    if not copiedAvatarAccessory(acc) then return end
    for _,obj in ipairs(acc:GetDescendants()) do
        if obj:IsA("BasePart") then
            if hidden then
                rememberAccessoryVisual(obj,"Transparency",obj.Transparency)
                local okLTM,ltm=pcall(function() return obj.LocalTransparencyModifier end)
                if okLTM then rememberAccessoryVisual(obj,"LocalTransparencyModifier",ltm) end
                obj.Transparency=1
                pcall(function() obj.LocalTransparencyModifier=1 end)
            else
                local rec=avatarAccessoryVisualBackup[obj]
                if rec then
                    if rec.Transparency~=nil then pcall(function() obj.Transparency=rec.Transparency end) end
                    if rec.LocalTransparencyModifier~=nil then pcall(function() obj.LocalTransparencyModifier=rec.LocalTransparencyModifier end) end
                    avatarAccessoryVisualBackup[obj]=nil
                end
            end
        elseif obj:IsA("Decal") or obj:IsA("Texture") then
            if hidden then
                rememberAccessoryVisual(obj,"Transparency",obj.Transparency)
                obj.Transparency=1
            else
                local rec=avatarAccessoryVisualBackup[obj]
                if rec and rec.Transparency~=nil then pcall(function() obj.Transparency=rec.Transparency end) end
                avatarAccessoryVisualBackup[obj]=nil
            end
        elseif obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Beam")
            or obj:IsA("PointLight") or obj:IsA("SpotLight") or obj:IsA("SurfaceLight")
            or obj:IsA("Highlight") or obj:IsA("BillboardGui") or obj:IsA("SurfaceGui") then
            if hidden then
                local okEnabled,enabled=pcall(function() return obj.Enabled end)
                if okEnabled then
                    rememberAccessoryVisual(obj,"Enabled",enabled)
                    pcall(function() obj.Enabled=false end)
                end
            else
                local rec=avatarAccessoryVisualBackup[obj]
                if rec and rec.Enabled~=nil then pcall(function() obj.Enabled=rec.Enabled end) end
                avatarAccessoryVisualBackup[obj]=nil
            end
        end
    end
end

local function hiddenAccessoryArray()
    local out={}
    for key,hidden in pairs(avatarHiddenAccessoryKeys) do
        if hidden then table.insert(out,key) end
    end
    table.sort(out)
    return out
end

local function syncHiddenAccessoriesIntoSnapshot()
    if type(activeAvatarSnapshot)=="table" then
        activeAvatarSnapshot.HiddenAccessories=hiddenAccessoryArray()
    end
end

local function loadHiddenAccessoriesFromSnapshot(state)
    table.clear(avatarHiddenAccessoryKeys)
    if type(state)=="table" and type(state.HiddenAccessories)=="table" then
        for _,key in ipairs(state.HiddenAccessories) do
            if type(key)=="string" and key~="" then avatarHiddenAccessoryKeys[key]=true end
        end
    end
end

local function collectCopiedAvatarAccessories(char)
    local groups={}
    char=char or lp.Character
    if not char then return groups end
    for _,acc in ipairs(char:GetChildren()) do
        if copiedAvatarAccessory(acc) then
            local key=avatarAccessoryKey(acc)
            if key then
                local group=groups[key]
                if not group then
                    group={key=key,name=tostring(acc.Name or "Accessory"),items={}}
                    groups[key]=group
                end
                table.insert(group.items,acc)
            end
        end
    end
    return groups
end

local function applyHiddenAccessoryState(char)
    local groups=collectCopiedAvatarAccessories(char)
    for key,group in pairs(groups) do
        local hidden=avatarHiddenAccessoryKeys[key]==true
        for _,acc in ipairs(group.items) do
            setOneAccessoryHidden(acc,hidden)
        end
    end
end

-- Cute editor card. It lives only on Avatar and uses the normal Kimq theme roles.
local AvatarAccessoryEditor=createCard(244)
AvatarAccessoryEditor.Name="KimqCopiedAvatarAccessoryEditor"

local AvatarAccessoryEditorTitle=Instance.new("TextLabel",AvatarAccessoryEditor)
AvatarAccessoryEditorTitle.BackgroundTransparency=1
AvatarAccessoryEditorTitle.Position=UDim2.fromOffset(12,8)
AvatarAccessoryEditorTitle.Size=UDim2.new(1,-104,0,22)
AvatarAccessoryEditorTitle.Text="♥  Avatar Accessories"
AvatarAccessoryEditorTitle.Font=Enum.Font.GothamBold
AvatarAccessoryEditorTitle.TextSize=13
AvatarAccessoryEditorTitle.TextXAlignment=Enum.TextXAlignment.Left
AvatarAccessoryEditorTitle.TextColor3=Color3.fromRGB(230,40,135)
AvatarAccessoryEditorTitle:SetAttribute("KimqV26Role","hotText")

local AvatarAccessoryEditorSub=Instance.new("TextLabel",AvatarAccessoryEditor)
AvatarAccessoryEditorSub.BackgroundTransparency=1
AvatarAccessoryEditorSub.Position=UDim2.fromOffset(12,30)
AvatarAccessoryEditorSub.Size=UDim2.new(1,-24,0,28)
AvatarAccessoryEditorSub.Text="Hide or show pieces from the copied avatar. Hidden pieces stay saved with configs."
AvatarAccessoryEditorSub.TextWrapped=true
AvatarAccessoryEditorSub.Font=Enum.Font.Gotham
AvatarAccessoryEditorSub.TextSize=10
AvatarAccessoryEditorSub.TextXAlignment=Enum.TextXAlignment.Left
AvatarAccessoryEditorSub.TextColor3=Color3.fromRGB(197,112,145)
AvatarAccessoryEditorSub:SetAttribute("KimqV26Role","subText")

local AvatarAccessoryRefresh=Instance.new("TextButton",AvatarAccessoryEditor)
AvatarAccessoryRefresh.Position=UDim2.new(1,-84,0,7)
AvatarAccessoryRefresh.Size=UDim2.fromOffset(72,26)
AvatarAccessoryRefresh.BackgroundColor3=Color3.fromRGB(255,225,238)
AvatarAccessoryRefresh.BorderSizePixel=0
AvatarAccessoryRefresh.Text="refresh"
AvatarAccessoryRefresh.Font=Enum.Font.GothamSemibold
AvatarAccessoryRefresh.TextSize=10
AvatarAccessoryRefresh.TextColor3=Color3.fromRGB(225,55,135)
AvatarAccessoryRefresh.AutoButtonColor=false
AvatarAccessoryRefresh:SetAttribute("KimqV26Role","lightBg")
Instance.new("UICorner",AvatarAccessoryRefresh).CornerRadius=UDim.new(0,8)

local AvatarAccessoryList=Instance.new("ScrollingFrame",AvatarAccessoryEditor)
AvatarAccessoryList.Position=UDim2.fromOffset(10,66)
AvatarAccessoryList.Size=UDim2.new(1,-20,1,-76)
AvatarAccessoryList.BackgroundColor3=Color3.fromRGB(255,245,250)
AvatarAccessoryList.BorderSizePixel=0
AvatarAccessoryList.ScrollBarThickness=3
AvatarAccessoryList.ScrollBarImageColor3=Color3.fromRGB(243,161,211)
AvatarAccessoryList.CanvasSize=UDim2.new()
AvatarAccessoryList:SetAttribute("KimqV26Role","lightBg")
Instance.new("UICorner",AvatarAccessoryList).CornerRadius=UDim.new(0,10)
local AvatarAccessoryPad=Instance.new("UIPadding",AvatarAccessoryList)
AvatarAccessoryPad.PaddingTop=UDim.new(0,6)
AvatarAccessoryPad.PaddingBottom=UDim.new(0,6)
AvatarAccessoryPad.PaddingLeft=UDim.new(0,6)
AvatarAccessoryPad.PaddingRight=UDim.new(0,6)
local AvatarAccessoryLayout=Instance.new("UIListLayout",AvatarAccessoryList)
AvatarAccessoryLayout.SortOrder=Enum.SortOrder.LayoutOrder
AvatarAccessoryLayout.Padding=UDim.new(0,5)
AvatarAccessoryLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    AvatarAccessoryList.CanvasSize=UDim2.new(0,0,0,AvatarAccessoryLayout.AbsoluteContentSize.Y+12)
end)

local function paintAvatarAccessoryRow(row,button,hidden)
    local p=_G.KimqThemeLivePalette
    local soft=(p and (p.soft or p.bg2)) or Color3.fromRGB(255,225,238)
    local panel=(p and p.panel) or Color3.fromRGB(255,255,255)
    local hot=(p and p.hot) or Color3.fromRGB(243,161,211)
    local text=(p and p.text) or Color3.fromRGB(82,116,94)
    local white=(p and p.white) or Color3.fromRGB(255,255,255)
    if row then row.BackgroundColor3=panel end
    if button then
        button.BackgroundColor3=hidden and hot or soft
        button.TextColor3=hidden and white or text
        button.Text=hidden and "HIDDEN" or "VISIBLE"
    end
end

local function refreshAvatarAccessoryTheme()
    for _,rec in pairs(avatarAccessoryRows) do
        if rec.row and rec.row.Parent then
            paintAvatarAccessoryRow(rec.row,rec.button,avatarHiddenAccessoryKeys[rec.key]==true)
        end
    end
    local p=_G.KimqThemeLivePalette
    if p and AvatarAccessoryList then
        AvatarAccessoryList.BackgroundColor3=p.soft or p.bg2 or AvatarAccessoryList.BackgroundColor3
        AvatarAccessoryList.ScrollBarImageColor3=p.hot or AvatarAccessoryList.ScrollBarImageColor3
        AvatarAccessoryRefresh.BackgroundColor3=p.soft or p.bg2 or AvatarAccessoryRefresh.BackgroundColor3
        AvatarAccessoryRefresh.TextColor3=p.hot or AvatarAccessoryRefresh.TextColor3
    end
end
_G.KimqRefreshAvatarAccessoryTheme=refreshAvatarAccessoryTheme

local function clearAvatarAccessoryRows()
    table.clear(avatarAccessoryRows)
    for _,child in ipairs(AvatarAccessoryList:GetChildren()) do
        if child~=AvatarAccessoryLayout and child~=AvatarAccessoryPad then child:Destroy() end
    end
end

local function refreshAvatarAccessoryList()
    avatarAccessoryRefreshToken+=1
    local myToken=avatarAccessoryRefreshToken
    clearAvatarAccessoryRows()
    local groups=collectCopiedAvatarAccessories(lp.Character)
    local ordered={}
    for _,group in pairs(groups) do table.insert(ordered,group) end
    table.sort(ordered,function(a,b) return a.name:lower()<b.name:lower() end)

    if #ordered==0 then
        local empty=Instance.new("TextLabel",AvatarAccessoryList)
        empty.Name="KimqAvatarAccessoryEmpty"
        empty.Size=UDim2.new(1,-8,0,42)
        empty.BackgroundTransparency=1
        empty.Text="apply a user avatar to edit its accessories ♡"
        empty.TextWrapped=true
        empty.Font=Enum.Font.Gotham
        empty.TextSize=10
        empty.TextColor3=(_G.KimqThemeLivePalette and _G.KimqThemeLivePalette.sub) or Color3.fromRGB(197,112,145)
        empty:SetAttribute("KimqV26Role","subText")
        return
    end

    for index,group in ipairs(ordered) do
        if myToken~=avatarAccessoryRefreshToken then return end
        local row=Instance.new("Frame",AvatarAccessoryList)
        row.Name="Accessory_"..tostring(index)
        row.Size=UDim2.new(1,-4,0,34)
        row.BorderSizePixel=0
        row.LayoutOrder=index
        row:SetAttribute("KimqV26Role","panel")
        Instance.new("UICorner",row).CornerRadius=UDim.new(0,8)

        local nameLabel=Instance.new("TextLabel",row)
        nameLabel.BackgroundTransparency=1
        nameLabel.Position=UDim2.fromOffset(9,0)
        nameLabel.Size=UDim2.new(1,-100,1,0)
        nameLabel.Text=group.name
        nameLabel.TextTruncate=Enum.TextTruncate.AtEnd
        nameLabel.Font=Enum.Font.GothamSemibold
        nameLabel.TextSize=10
        nameLabel.TextXAlignment=Enum.TextXAlignment.Left
        nameLabel.TextColor3=(_G.KimqThemeLivePalette and _G.KimqThemeLivePalette.text) or Color3.fromRGB(82,116,94)
        nameLabel:SetAttribute("KimqV26Role","textText")

        local visibility=Instance.new("TextButton",row)
        visibility.Size=UDim2.fromOffset(78,24)
        visibility.Position=UDim2.new(1,-84,.5,-12)
        visibility.BorderSizePixel=0
        visibility.Font=Enum.Font.GothamBold
        visibility.TextSize=9
        visibility.AutoButtonColor=false
        Instance.new("UICorner",visibility).CornerRadius=UDim.new(0,7)

        avatarAccessoryRows[group.key]={row=row,button=visibility,key=group.key}
        paintAvatarAccessoryRow(row,visibility,avatarHiddenAccessoryKeys[group.key]==true)

        visibility.MouseButton1Click:Connect(function()
            local hidden=not (avatarHiddenAccessoryKeys[group.key]==true)
            avatarHiddenAccessoryKeys[group.key]=hidden or nil
            for _,acc in ipairs(group.items) do
                if acc and acc.Parent then setOneAccessoryHidden(acc,hidden) end
            end
            syncHiddenAccessoriesIntoSnapshot()
            paintAvatarAccessoryRow(row,visibility,hidden)
            setAvatarStatus((hidden and "Hidden " or "Showing ")..group.name.." ♡",true)
        end)
    end
    refreshAvatarAccessoryTheme()
end
_G.KimqRefreshAvatarAccessoryList=refreshAvatarAccessoryList

AvatarAccessoryRefresh.MouseButton1Click:Connect(function()
    applyHiddenAccessoryState(lp.Character)
    refreshAvatarAccessoryList()
end)

local AVATAR_DESCRIPTION_PROPERTIES={
    "AccessoryBlob","BackAccessory","FaceAccessory","FrontAccessory","HairAccessory","HatAccessory","NeckAccessory","ShouldersAccessory","WaistAccessory",
    "Shirt","Pants","GraphicTShirt","Face","Head","Torso","LeftArm","RightArm","LeftLeg","RightLeg",
    "BodyTypeScale","DepthScale","HeadScale","HeightScale","ProportionScale","WidthScale",
    "HeadColor","TorsoColor","LeftArmColor","RightArmColor","LeftLegColor","RightLegColor",
    "ClimbAnimation","FallAnimation","IdleAnimation","JumpAnimation","RunAnimation","SwimAnimation","WalkAnimation","MoodAnimation"
}

local function avatarColorToState(c)
    return {__type="Color3",r=c.R,g=c.G,b=c.B}
end

local function avatarStateToColor(t)
    if type(t)~="table" or t.__type~="Color3" then return nil end
    return Color3.new(
        math.clamp(tonumber(t.r) or 0,0,1),
        math.clamp(tonumber(t.g) or 0,0,1),
        math.clamp(tonumber(t.b) or 0,0,1)
    )
end

local function snapshotHumanoidDescription(desc,sourceUserId)
    if not desc then return nil end
    local state={Version=1,SourceUserId=tonumber(sourceUserId),Properties={}}
    for _,prop in ipairs(AVATAR_DESCRIPTION_PROPERTIES) do
        local ok,v=pcall(function() return desc[prop] end)
        if ok then
            if typeof(v)=="Color3" then
                state.Properties[prop]=avatarColorToState(v)
            elseif type(v)=="number" or type(v)=="string" or type(v)=="boolean" then
                state.Properties[prop]=v
            end
        end
    end

    pcall(function()
        local accessories=desc:GetAccessories(true)
        local out={}
        for _,entry in ipairs(accessories or {}) do
            local rec={}
            for k,v in pairs(entry) do
                if typeof(v)=="EnumItem" then
                    rec[k]={__type="EnumItem",enum=tostring(v.EnumType),name=v.Name}
                elseif type(v)=="number" or type(v)=="string" or type(v)=="boolean" then
                    rec[k]=v
                end
            end
            table.insert(out,rec)
        end
        state.Accessories=out
    end)
    pcall(function() state.Emotes=desc:GetEmotes() end)
    pcall(function() state.EquippedEmotes=desc:GetEquippedEmotes() end)
    return state
end

local function enumFromAvatarState(v)
    if type(v)~="table" or v.__type~="EnumItem" then return nil end
    local enumName=tostring(v.enum or ""):match("Enum%.(.+)")
    local enumType=enumName and Enum[enumName] or nil
    return enumType and enumType[tostring(v.name or "")] or nil
end

local function descriptionFromAvatarSnapshot(state)
    if type(state)~="table" then return nil end
    local desc=Instance.new("HumanoidDescription")
    for prop,v in pairs(type(state.Properties)=="table" and state.Properties or {}) do
        pcall(function()
            local c=avatarStateToColor(v)
            if c then desc[prop]=c else desc[prop]=v end
        end)
    end
    if type(state.Accessories)=="table" then
        pcall(function()
            local accessories={}
            for _,rec in ipairs(state.Accessories) do
                if type(rec)=="table" then
                    local entry={}
                    for k,v in pairs(rec) do
                        local enumItem=enumFromAvatarState(v)
                        entry[k]=enumItem or v
                    end
                    table.insert(accessories,entry)
                end
            end
            desc:SetAccessories(accessories,true)
        end)
    end
    if type(state.Emotes)=="table" then pcall(function() desc:SetEmotes(state.Emotes) end) end
    if type(state.EquippedEmotes)=="table" then pcall(function() desc:SetEquippedEmotes(state.EquippedEmotes) end) end
    return desc
end


local AvatarVisual = {}

function AvatarVisual.applyDescription(humanoid, desc)
    if not humanoid or not desc then return false end
    local ok=pcall(function()
        humanoid:ApplyDescription(desc)
    end)
    if not ok then
        ok=pcall(function()
            if humanoid.ApplyDescriptionReset then humanoid:ApplyDescriptionReset(desc) end
        end)
    end
    return ok
end

function AvatarVisual.createDummyFromDescription(desc, rigType)
    if not desc then return nil end
    local ok,dummy=pcall(function()
        return Players:CreateHumanoidModelFromDescription(desc, rigType or Enum.HumanoidRigType.R15)
    end)
    return ok and dummy or nil
end

function AvatarVisual.createDummyFromUser(userId, rigType)
    local desc=nil
    pcall(function() desc=Players:GetHumanoidDescriptionFromUserId(userId) end)
    local dummy=desc and AvatarVisual.createDummyFromDescription(desc,rigType) or nil
    if not dummy then
        local ok,fallback=pcall(function() return Players:CreateHumanoidModelFromUserId(userId) end)
        if ok then dummy=fallback end
    end
    if not desc and dummy then
        local h=dummy:FindFirstChildOfClass("Humanoid")
        if h then pcall(function() desc=h:GetAppliedDescription() end) end
    end
    return dummy,desc
end

function AvatarVisual.copyBodyColors(char, dummy)
    if not char or not dummy then return end
    local src=dummy:FindFirstChildOfClass("BodyColors")
    if not src then return end
    local dst=char:FindFirstChildOfClass("BodyColors")
    if dst then
        pcall(function()
            dst.HeadColor3=src.HeadColor3; dst.TorsoColor3=src.TorsoColor3
            dst.LeftArmColor3=src.LeftArmColor3; dst.RightArmColor3=src.RightArmColor3
            dst.LeftLegColor3=src.LeftLegColor3; dst.RightLegColor3=src.RightLegColor3
        end)
    else
        pcall(function() src:Clone().Parent=char end)
    end
end

function AvatarVisual.makeVisualHead(char, dummy)
    if not char or not dummy then return nil end
    local base=char:FindFirstChild("Head")
    local source=dummy:FindFirstChild("Head")
    if not base or not source or not source:IsA("BasePart") then return nil end
    local old=char:FindFirstChild("KimqAvatarVisualHead")
    if old then pcall(function() old:Destroy() end) end

    local visual=source:Clone()
    visual.Name="KimqAvatarVisualHead"

    -- v2.80: some dynamic/custom heads clone with a black tint in this game even
    -- though the copied BodyColors are correct. Force the visual shell to the
    -- copied avatar's actual head skin tone while keeping its face/mesh assets.
    local skinTone=base.Color
    local sourceColors=dummy:FindFirstChildOfClass("BodyColors")
    if sourceColors then pcall(function() skinTone=sourceColors.HeadColor3 end) end
    pcall(function() visual.Color=skinTone end)

    visual:SetAttribute("KimqOriginalTransparency",visual.Transparency)
    for _,d in ipairs(visual:GetDescendants()) do
        if d:IsA("JointInstance") or d:IsA("WeldConstraint") then
            pcall(function() d:Destroy() end)
        elseif d:IsA("Decal") or d:IsA("Texture") then
            d:SetAttribute("KimqOriginalTransparency",d.Transparency)
        elseif d:IsA("SpecialMesh") then
            pcall(function()
                local vc=d.VertexColor
                if vc.X+vc.Y+vc.Z<.18 then d.VertexColor=Vector3.new(1,1,1) end
            end)
        elseif d:IsA("SurfaceAppearance") then
            -- Newer SurfaceAppearance versions expose Color. If unavailable the
            -- pcall simply leaves the source appearance untouched.
            pcall(function()
                local c=d.Color
                if typeof(c)=="Color3" and c.R+c.G+c.B<.18 then d.Color=skinTone end
            end)
        end
    end
    visual.Anchored=false
    visual.CanCollide=false
    visual.CanTouch=false
    pcall(function() visual.CanQuery=false end)
    visual.Massless=true
    visual.CFrame=base.CFrame
    visual.Parent=char
    local weld=Instance.new("WeldConstraint")
    weld.Name="KimqAvatarVisualHeadWeld"
    weld.Part0=base
    weld.Part1=visual
    weld.Parent=visual
    return visual
end

function AvatarVisual.findBodyAttachment(char, name)
    if not char or not name then return nil end
    for _,part in ipairs(char:GetChildren()) do
        if part:IsA("BasePart") and part.Name~="KimqAvatarVisualHead" then
            local a=part:FindFirstChild(name)
            if a and a:IsA("Attachment") then return a end
        end
    end
    return nil
end

function AvatarVisual.forceAttach(char, acc, sourceAcc)
    if not char or not acc or not acc:IsA("Accessory") then return false end
    local handle=acc:FindFirstChild("Handle")
    local sourceHandle=sourceAcc and sourceAcc:FindFirstChild("Handle") or nil
    if not handle or not handle:IsA("BasePart") then return false end
    handle.CanCollide=false; handle.Massless=true
    pcall(function() handle.CanTouch=false; handle.CanQuery=false end)

    local old=handle:FindFirstChild("AccessoryWeld")
    if old then pcall(function() old:Destroy() end) end

    local handleAttachment=nil
    for _,d in ipairs(handle:GetChildren()) do
        if d:IsA("Attachment") then handleAttachment=d break end
    end
    if handleAttachment then
        local bodyAttachment=AvatarVisual.findBodyAttachment(char,handleAttachment.Name)
        if bodyAttachment and bodyAttachment.Parent and bodyAttachment.Parent:IsA("BasePart") then
            handle.CFrame=bodyAttachment.WorldCFrame*handleAttachment.CFrame:Inverse()
            local w=Instance.new("Weld")
            w.Name="AccessoryWeld"
            w.Part0=handle; w.Part1=bodyAttachment.Parent
            w.C0=handleAttachment.CFrame; w.C1=bodyAttachment.CFrame
            w.Parent=handle
            return true
        end
    end

    local sourceWeld=sourceHandle and sourceHandle:FindFirstChild("AccessoryWeld")
    if sourceWeld and sourceWeld:IsA("Weld") and sourceWeld.Part1 then
        local body=char:FindFirstChild(sourceWeld.Part1.Name)
        if body and body:IsA("BasePart") then
            local w=Instance.new("Weld")
            w.Name="AccessoryWeld"
            w.Part0=handle; w.Part1=body
            w.C0=sourceWeld.C0; w.C1=sourceWeld.C1
            w.Parent=handle
            pcall(function() handle.CFrame=body.CFrame*w.C1*w.C0:Inverse() end)
            return true
        end
    end
    return false
end

function AvatarVisual.findMatchingAccessory(char, sourceAcc)
    local wanted=avatarAccessoryKey(sourceAcc)
    if not wanted then return nil end
    for _,obj in ipairs(char:GetChildren()) do
        if obj:IsA("Accessory") and avatarAccessoryKey(obj)==wanted then return obj end
    end
    return nil
end

function AvatarVisual.copyAccessories(char, humanoid, dummy)
    if not char or not dummy then return 0 end
    local count=0
    for _,sourceAcc in ipairs(dummy:GetChildren()) do
        if sourceAcc:IsA("Accessory") then
            count+=1
            local acc=AvatarVisual.findMatchingAccessory(char,sourceAcc)
            if not acc then
                acc=sourceAcc:Clone()
                acc:SetAttribute("KimqCopiedAvatarAccessory",true)
                acc.Parent=char
            else
                pcall(function() acc:SetAttribute("KimqCopiedAvatarAccessory",true) end)
            end
            local attached=AvatarVisual.forceAttach(char,acc,sourceAcc)
            if not attached and humanoid and humanoid.AddAccessory then
                pcall(function()
                    if acc.Parent then acc.Parent=nil end
                    humanoid:AddAccessory(acc)
                    acc:SetAttribute("KimqCopiedAvatarAccessory",true)
                end)
            end
        end
    end
    return count
end

function AvatarVisual.copyClassicVisuals(char,dummy)
    if not char or not dummy then return end

    -- Clothing can be overwritten by a game's own appearance loader without
    -- removing the character. Replace only classic avatar clothing with the
    -- copied avatar's exact classic pieces and mark them for integrity checks.
    local classes={"Shirt","Pants","ShirtGraphic","BodyColors","CharacterMesh"}
    for _,className in ipairs(classes) do
        for _,existing in ipairs(char:GetChildren()) do
            if existing.ClassName==className and not existing:GetAttribute("KimqLocalV15") then
                pcall(function() existing:Destroy() end)
            end
        end
        for _,source in ipairs(dummy:GetChildren()) do
            if source.ClassName==className then
                pcall(function()
                    local clone=source:Clone()
                    clone:SetAttribute("KimqCopiedAvatarVisual",true)
                    clone.Parent=char
                end)
            end
        end
    end
end

function AvatarVisual.finish(char, humanoid, dummy)
    if not char or not char.Parent then return 0 end
    AvatarVisual.copyClassicVisuals(char,dummy)
    AvatarVisual.copyBodyColors(char,dummy)
    AvatarVisual.makeVisualHead(char,dummy)
    local count=AvatarVisual.copyAccessories(char,humanoid,dummy)
    applyHeadless(char)
    applyHiddenAccessoryState(char)
    reapplySavedLocalAccessories(char)
    if type(_G.KimqRefreshAvatarAccessoryList)=="function" then pcall(_G.KimqRefreshAvatarAccessoryList) end
    return count
end

local function applyAvatarSnapshot(state,char,quiet)
    char=char or lp.Character
    if type(state)~="table" or not char then return false end
    local humanoid=char:FindFirstChildOfClass("Humanoid") or char:WaitForChild("Humanoid",5)
    if not humanoid then return false end
    local desc=descriptionFromAvatarSnapshot(state)
    if not desc then return false end

    -- Build the fallback model from the SAVED description itself.  v2.77 does
    -- not depend on ApplyDescription succeeding: some games reject/overwrite it
    -- during fresh spawn, so the manual visual path must still run.
    local dummy=AvatarVisual.createDummyFromDescription(desc,humanoid.RigType)
    if dummy then
        pcall(function()
            if avatarPersistTemplate then avatarPersistTemplate:Destroy() end
            avatarPersistTemplate=dummy:Clone()
            avatarPersistTemplate.Name="KimqAvatarPersistTemplate"
            avatarPersistTemplate.Parent=nil
        end)
    end
    local descriptionOk=AvatarVisual.applyDescription(humanoid,desc)
    pcall(function() desc:Destroy() end)

    activeAvatarSnapshot=state
    loadHiddenAccessoriesFromSnapshot(state)

    local visualOk=false
    if dummy then
        visualOk=true
        -- Immediate pass plus delayed settle passes.  These restore face/head,
        -- accessories and classic clothing even if the game's avatar loader won.
        pcall(function() AvatarVisual.finish(char,humanoid,dummy) end)
        task.defer(function()
            task.wait(.16)
            if char and char.Parent and char==lp.Character then
                pcall(function() AvatarVisual.finish(char,humanoid,dummy) end)
                task.wait(.42)
                if char and char.Parent and char==lp.Character then
                    pcall(function() AvatarVisual.finish(char,humanoid,dummy) end)
                end
            end
            pcall(function() dummy:Destroy() end)
        end)
    end

    local ok=descriptionOk or visualOk
    if not quiet then
        setAvatarStatus(ok and "Saved avatar restored ♡" or "Saved avatar could not be restored",ok)
    end
    return ok
end

local avatarApplySerial=0

local function applyAvatarUser(userId, char, quiet)
    char=char or lp.Character
    if not char then
        if not quiet then setAvatarStatus("Character is not ready",false) end
        return
    end

    avatarApplySerial+=1
    local serial=avatarApplySerial

    task.spawn(function()
        if not quiet then setAvatarStatus("Loading full avatar...",false) end
        local humanoid=char:FindFirstChildOfClass("Humanoid") or char:WaitForChild("Humanoid",5)
        if not humanoid or serial~=avatarApplySerial then
            if not quiet then setAvatarStatus("Humanoid not found",false) end
            return
        end

        local dummy,desc=AvatarVisual.createDummyFromUser(userId,humanoid.RigType)
        if not dummy or serial~=avatarApplySerial then
            if dummy then pcall(function() dummy:Destroy() end) end
            if desc then pcall(function() desc:Destroy() end) end
            if not quiet then setAvatarStatus("Avatar could not be loaded",false) end
            return
        end

        -- Cache the exact fully-built model that made manual Apply work. This clone
        -- survives character death because it is held only by this script, not the Character.
        if AvatarEnabled and avatarPersistenceMode=="user"
            and tonumber(activeAvatarUserId)==tonumber(userId) then
            pcall(function()
                if avatarPersistTemplate then avatarPersistTemplate:Destroy() end
                avatarPersistTemplate=dummy:Clone()
                avatarPersistTemplate.Name="KimqAvatarPersistTemplate"
                avatarPersistTemplate.Parent=nil
            end)
        end

        -- Clear only avatar visuals that this feature replaces. Gameplay folders,
        -- scripts and tools remain untouched.
        local oldVisualHead=char:FindFirstChild("KimqAvatarVisualHead")
        if oldVisualHead then pcall(function() oldVisualHead:Destroy() end) end
        for _,obj in ipairs(char:GetChildren()) do
            if obj:IsA("Accessory") or obj:IsA("Shirt") or obj:IsA("Pants")
                or obj:IsA("ShirtGraphic") or obj:IsA("BodyColors")
                or obj:IsA("CharacterMesh") then
                pcall(function() obj:Destroy() end)
            end
        end

        if not desc then
            local dh=dummy:FindFirstChildOfClass("Humanoid")
            if dh then pcall(function() desc=dh:GetAppliedDescription() end) end
        end
        if desc then
            activeAvatarSnapshot=snapshotHumanoidDescription(desc,userId)
            if activeAvatarSnapshot then activeAvatarSnapshot.HiddenAccessories={} end
            loadHiddenAccessoriesFromSnapshot(activeAvatarSnapshot)
            AvatarVisual.applyDescription(humanoid,desc)
        end

        -- Keep the older classic/body mesh fallbacks too.
        for _,item in ipairs(dummy:GetChildren()) do
            if item:IsA("Shirt") or item:IsA("Pants") or item:IsA("ShirtGraphic")
                or item:IsA("CharacterMesh") or item:IsA("BodyColors") then
                pcall(function() item:Clone().Parent=char end)
            end
        end
        for _,dPart in ipairs(dummy:GetChildren()) do
            if dPart:IsA("MeshPart") and dPart.Name~="Head" then
                local myPart=char:FindFirstChild(dPart.Name)
                if myPart and myPart:IsA("MeshPart") then
                    pcall(function() myPart.MeshId=dPart.MeshId; myPart.TextureID=dPart.TextureID end)
                end
            end
        end

        local accessoryCount=AvatarVisual.finish(char,humanoid,dummy)
        copyAnimationsFromDummy(char,dummy)
        task.defer(function()
            task.wait(.18)
            if char and char.Parent then accessoryCount=AvatarVisual.finish(char,humanoid,dummy) end
            task.wait(.28)
            if char and char.Parent then AvatarVisual.finish(char,humanoid,dummy) end
            pcall(function() dummy:Destroy() end)
        end)
        if desc then pcall(function() desc:Destroy() end) end

        if not quiet then
            setAvatarStatus("Full avatar applied ♡ • "..tostring(accessoryCount).." accessories",true)
        end
    end)
end

local function applyTargetAvatar(quiet)
    AvatarTarget=tostring(AvatarTargetBox.Text or "")
    if AvatarTarget=="" then
        if not quiet then setAvatarStatus("Enter a username or user ID",false) end
        return
    end
    local userId=resolveAvatarUserId(AvatarTarget)
    if not userId then
        if not quiet then setAvatarStatus("User not found",false) end
        return
    end
    -- Once a valid copied avatar is chosen, keep it through death/reset until
    -- Reset to My Avatar (or the keep toggle) explicitly turns persistence off.
    -- v2.78 stores the exact user id so respawn can run the SAME applyAvatarUser
    -- path as this button instead of a different snapshot-only path.
    activeAvatarUserId=tonumber(userId)
    avatarPersistenceMode="user"
    setAvatarKeepEnabled(true)
    applyAvatarUser(userId,lp.Character,quiet)
end

ApplyAvatarBtn.MouseButton1Click:Connect(function()
    applyTargetAvatar(false)
end)

ResetAvatarBtn.MouseButton1Click:Connect(function()
    setAvatarStatus("Restoring your avatar...",false)
    setAvatarKeepEnabled(false)
    table.clear(avatarHiddenAccessoryKeys)
    activeAvatarSnapshot=nil
    activeAvatarUserId=nil
    avatarPersistenceMode="snapshot"
    if avatarPersistTemplate then pcall(function() avatarPersistTemplate:Destroy() end) end
    avatarPersistTemplate=nil
    applyAvatarUser(lp.UserId,lp.Character,false)
end)

local avatarRespawnGuardSerial=0
local avatarVisualRepairBusy=false
local avatarSuppressRepairUntil=0
-- v2.80: repeated ApplyDescription + animation resets were what could make the
-- character randomly stiff. Full humanoid/animation setup runs once per spawn;
-- later repairs repaint only the cached visual pieces.
local avatarRespawnFullApplied=setmetatable({}, {__mode="k"})

local function expectedCopiedAccessoryCount()
    local state=activeAvatarSnapshot
    if type(state)=="table" and type(state.Accessories)=="table" then
        return #state.Accessories
    end
    return 0
end

local function countCopiedAccessories(char)
    local n=0
    if not char then return 0 end
    for _,obj in ipairs(char:GetChildren()) do
        if obj:IsA("Accessory") and obj:GetAttribute("KimqCopiedAvatarAccessory") then n+=1 end
    end
    return n
end

local function avatarVisualLooksIntact(char)
    if not AvatarEnabled or not char or char~=lp.Character then return true end
    if not activeAvatarSnapshot and not avatarPersistTemplate then return false end

    local visualHead=char:FindFirstChild("KimqAvatarVisualHead")
    if not visualHead or not visualHead:IsA("BasePart") then return false end

    local expected=expectedCopiedAccessoryCount()
    if expected>0 and countCopiedAccessories(char)<expected then return false end

    -- If Roblox/the game adds the local player's original accessories again after
    -- our restore, treat that as an overwrite even if our copied pieces still exist.
    for _,obj in ipairs(char:GetChildren()) do
        if obj:IsA("Accessory") then
            local allowed=obj:GetAttribute("KimqCopiedAvatarAccessory")
                or obj:GetAttribute("KimqLocalV15")
                or obj:GetAttribute("KimqWornEquippable")
                or obj.Name=="KimqWornAngelWings"
                or tostring(obj.Name):match("^KimqLocal_")
            if not allowed then return false end
        end
    end

    local props=(activeAvatarSnapshot and activeAvatarSnapshot.Properties) or {}
    if tonumber(props.Shirt or 0)>0 then
        local shirt=char:FindFirstChildOfClass("Shirt")
        if not shirt or not shirt:GetAttribute("KimqCopiedAvatarVisual") then return false end
    end
    if tonumber(props.Pants or 0)>0 then
        local pants=char:FindFirstChildOfClass("Pants")
        if not pants or not pants:GetAttribute("KimqCopiedAvatarVisual") then return false end
    end

    -- Detect a late game pass that silently restores the original BodyColors.
    local expectedColors=avatarPersistTemplate and avatarPersistTemplate:FindFirstChildOfClass("BodyColors")
    local liveColors=char:FindFirstChildOfClass("BodyColors")
    if expectedColors and liveColors then
        local function colorDiff(a,b)
            return math.abs(a.R-b.R)+math.abs(a.G-b.G)+math.abs(a.B-b.B)
        end
        if colorDiff(expectedColors.HeadColor3,liveColors.HeadColor3)>.08
            or colorDiff(expectedColors.TorsoColor3,liveColors.TorsoColor3)>.08 then
            return false
        end
    end
    return true
end

local function restoreKeptAvatar(char)
    if not AvatarEnabled or not char or char~=lp.Character or not char.Parent then return false end
    if avatarVisualRepairBusy then return false end
    avatarVisualRepairBusy=true
    avatarSuppressRepairUntil=os.clock()+.55

    -- Cancel any older async avatar request from the previous character. Respawn
    -- restore below is synchronous and uses the already-cached successful model.
    avatarApplySerial+=1

    local humanoid=char:FindFirstChildOfClass("Humanoid") or char:WaitForChild("Humanoid",6)
    local head=char:FindFirstChild("Head") or char:WaitForChild("Head",6)
    if not humanoid or not head or char~=lp.Character then
        avatarVisualRepairBusy=false
        return false
    end
    -- Never fight the game's death cleanup on the old character. The new
    -- CharacterAdded guard will restore the cached avatar on the respawned model.
    if humanoid.Health<=0 or humanoid:GetState()==Enum.HumanoidStateType.Dead then
        avatarVisualRepairBusy=false
        return false
    end

    -- Snapshot configs can rebuild a template locally with no user/network lookup.
    if not avatarPersistTemplate and activeAvatarSnapshot then
        local rebuildDesc=descriptionFromAvatarSnapshot(activeAvatarSnapshot)
        if rebuildDesc then
            local rebuilt=AvatarVisual.createDummyFromDescription(rebuildDesc,humanoid.RigType)
            pcall(function() rebuildDesc:Destroy() end)
            if rebuilt then
                avatarPersistTemplate=rebuilt
                avatarPersistTemplate.Name="KimqAvatarPersistTemplate"
                avatarPersistTemplate.Parent=nil
            end
        end
    end

    if not avatarPersistTemplate then
        -- Last-resort recovery only. Normally manual Apply already cached the model.
        local userId=tonumber(activeAvatarUserId)
        if not userId and tostring(AvatarTargetBox.Text or "")~="" then
            userId=resolveAvatarUserId(AvatarTargetBox.Text)
            activeAvatarUserId=userId and tonumber(userId) or activeAvatarUserId
        end
        avatarVisualRepairBusy=false
        if userId then applyAvatarUser(userId,char,true) end
        return userId~=nil
    end

    -- Remove the current Roblox avatar visuals before putting the cached look back.
    -- Local try-on accessories / wings are kept and the normal local-accessory helper
    -- is still called by AvatarVisual.finish.
    local oldVisualHead=char:FindFirstChild("KimqAvatarVisualHead")
    if oldVisualHead then pcall(function() oldVisualHead:Destroy() end) end
    for _,obj in ipairs(char:GetChildren()) do
        local remove=false
        if obj:IsA("Accessory") then
            remove=not (obj:GetAttribute("KimqLocalV15")
                or obj:GetAttribute("KimqWornEquippable")
                or obj.Name=="KimqWornAngelWings"
                or tostring(obj.Name):match("^KimqLocal_"))
        elseif obj:IsA("Shirt") or obj:IsA("Pants") or obj:IsA("ShirtGraphic")
            or obj:IsA("BodyColors") or obj:IsA("CharacterMesh") then
            remove=true
        end
        if remove then pcall(function() obj:Destroy() end) end
    end

    -- Apply body/package/scales only ONCE on this newly-spawned Humanoid. Repeating
    -- ApplyDescription during integrity repairs can interrupt the Animate pipeline.
    local firstFullRestore=avatarRespawnFullApplied[char]~=true
    if firstFullRestore and activeAvatarSnapshot then
        local desc=descriptionFromAvatarSnapshot(activeAvatarSnapshot)
        if desc then
            pcall(function() AvatarVisual.applyDescription(humanoid,desc) end)
            pcall(function() desc:Destroy() end)
        end
    end

    for _,dPart in ipairs(avatarPersistTemplate:GetChildren()) do
        if dPart:IsA("MeshPart") and dPart.Name~="Head" then
            local myPart=char:FindFirstChild(dPart.Name)
            if myPart and myPart:IsA("MeshPart") then
                pcall(function() myPart.MeshId=dPart.MeshId; myPart.TextureID=dPart.TextureID end)
            end
        end
    end

    pcall(function() AvatarVisual.finish(char,humanoid,avatarPersistTemplate) end)
    if firstFullRestore then
        avatarRespawnFullApplied[char]=true
        -- Copy animation IDs once per new character; never stop/restart tracks during
        -- later visual integrity repairs.
        pcall(function() copyAnimationsFromDummy(char,avatarPersistTemplate) end)
    end

    -- One local settle pass. No Roblox avatar re-fetch and no competing serials.
    task.delay(.28,function()
        if AvatarEnabled and char==lp.Character and char.Parent and avatarPersistTemplate then
            pcall(function() AvatarVisual.finish(char,humanoid,avatarPersistTemplate) end)
        end
    end)

    task.delay(.42,function()
        avatarVisualRepairBusy=false
    end)
    return true
end

local function startKeptAvatarRespawnGuard(char)
    if not AvatarEnabled or not char then return end
    avatarRespawnGuardSerial+=1
    local serial=avatarRespawnGuardSerial

    task.spawn(function()
        local t0=os.clock()
        while os.clock()-t0<6 and (lp.Character~=char or not char.Parent) do task.wait(.05) end
        if serial~=avatarRespawnGuardSerial or not AvatarEnabled or lp.Character~=char then return end
        char:WaitForChild("Humanoid",8)
        char:WaitForChild("Head",8)

        -- Games can apply the player's original appearance several times after spawn.
        -- Reassert the cached avatar at spaced points; each pass is local/cached, not a
        -- new Roblox web/avatar request. The copied look therefore wins the final pass.
        local checkpoints={.18,.65,1.35,2.35,3.8,5.8,8.0}
        local elapsed=0
        for _,targetTime in ipairs(checkpoints) do
            task.wait(math.max(0,targetTime-elapsed))
            elapsed=targetTime
            if serial~=avatarRespawnGuardSerial or not AvatarEnabled or lp.Character~=char or not char.Parent then return end
            if not avatarVisualLooksIntact(char) then restoreKeptAvatar(char) end
        end

        -- After spawn settles, only repair when something actually overwrites it.
        while serial==avatarRespawnGuardSerial and AvatarEnabled and lp.Character==char and char.Parent do
            task.wait(1.5)
            if not avatarVisualLooksIntact(char) then restoreKeptAvatar(char) end
        end
    end)

    char.ChildRemoved:Connect(function(obj)
        if serial~=avatarRespawnGuardSerial or not AvatarEnabled or lp.Character~=char then return end
        if os.clock()<avatarSuppressRepairUntil then return end
        local visual=obj.Name=="KimqAvatarVisualHead"
            or obj:IsA("Accessory") or obj:IsA("Shirt") or obj:IsA("Pants")
            or obj:IsA("ShirtGraphic") or obj:IsA("BodyColors") or obj:IsA("CharacterMesh")
        if visual then
            task.delay(.12,function()
                if serial==avatarRespawnGuardSerial and AvatarEnabled and lp.Character==char
                    and not avatarVisualLooksIntact(char) then restoreKeptAvatar(char) end
            end)
        end
    end)

    char.ChildAdded:Connect(function(obj)
        if serial~=avatarRespawnGuardSerial or not AvatarEnabled or lp.Character~=char then return end
        if os.clock()<avatarSuppressRepairUntil then return end
        if obj:IsA("Accessory") or obj:IsA("Shirt") or obj:IsA("Pants") or obj:IsA("BodyColors") then
            task.delay(.16,function()
                if serial==avatarRespawnGuardSerial and AvatarEnabled and lp.Character==char
                    and not avatarVisualLooksIntact(char) then restoreKeptAvatar(char) end
            end)
        end
    end)
end

lp.CharacterAdded:Connect(function(char)
    if not AvatarEnabled then return end
    startKeptAvatarRespawnGuard(char)
end)

lp.CharacterAppearanceLoaded:Connect(function(char)
    if not AvatarEnabled or not char then return end
    task.delay(.12,function()
        if AvatarEnabled and lp.Character==char and not avatarVisualLooksIntact(char) then
            restoreKeptAvatar(char)
        end
    end)
end)


_G.KimqAvatarController = {
    GetTarget=function() return tostring(AvatarTargetBox.Text or "") end,
    GetKeepAfterRespawn=function() return AvatarEnabled==true end,
    SetTarget=function(v)
        AvatarTargetBox.Text=tostring(v or "")
        AvatarTarget=AvatarTargetBox.Text
    end,
    GetSnapshot=function()
        syncHiddenAccessoriesIntoSnapshot()
        return activeAvatarSnapshot
    end,
    SetSnapshot=function(state)
        activeAvatarSnapshot=type(state)=="table" and state or nil
        if activeAvatarSnapshot then
            avatarPersistenceMode="snapshot"
            activeAvatarUserId=nil
            if avatarPersistTemplate then pcall(function() avatarPersistTemplate:Destroy() end) end
            avatarPersistTemplate=nil
        end
        loadHiddenAccessoriesFromSnapshot(activeAvatarSnapshot)
        if type(_G.KimqRefreshAvatarAccessoryList)=="function" then pcall(_G.KimqRefreshAvatarAccessoryList) end
    end,
    ApplySnapshot=function(state,quiet)
        if type(state)=="table" then activeAvatarSnapshot=state end
        if activeAvatarSnapshot then
            avatarPersistenceMode="snapshot"
            activeAvatarUserId=nil
            if avatarPersistTemplate then pcall(function() avatarPersistTemplate:Destroy() end) end
            avatarPersistTemplate=nil
            setAvatarKeepEnabled(true)
        end
        return applyAvatarSnapshot(activeAvatarSnapshot,lp.Character,quiet==true)
    end,
    ApplySaved=function()
        if activeAvatarSnapshot and lp.Character then
            setAvatarKeepEnabled(true)
            return applyAvatarSnapshot(activeAvatarSnapshot,lp.Character,true)
        end
        AvatarTarget=AvatarTargetBox.Text
        if AvatarTarget~="" and lp.Character then
            local userId=resolveAvatarUserId(AvatarTarget)
            if userId then
                activeAvatarUserId=tonumber(userId)
                avatarPersistenceMode="user"
                setAvatarKeepEnabled(true)
                applyAvatarUser(userId,lp.Character,true)
            end
        end
    end,
    Apply=function(v)
        if v~=nil then
            AvatarTargetBox.Text=tostring(v)
            AvatarTarget=AvatarTargetBox.Text
            activeAvatarSnapshot=nil
            activeAvatarUserId=nil
            avatarPersistenceMode="user"
        end
        setAvatarKeepEnabled(true)
        applyTargetAvatar(false)
    end,
    Reset=function()
        setAvatarKeepEnabled(false)
        activeAvatarSnapshot=nil
        activeAvatarUserId=nil
        avatarPersistenceMode="snapshot"
        if avatarPersistTemplate then pcall(function() avatarPersistTemplate:Destroy() end) end
        avatarPersistTemplate=nil
        table.clear(avatarHiddenAccessoryKeys)
        applyAvatarUser(lp.UserId,lp.Character,false)
    end,
}

]=====], false) then return end

if not runChunk("fog", [=====[
local C = _G.KimpetrasCtx
if not C then error("Kimqetras core context missing") end
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

local function fogPackColor(c)
    if typeof(c) ~= "Color3" then return nil end
    return {r=c.R, g=c.G, b=c.B}
end

local function fogUnpackColor(t)
    if type(t) ~= "table" then return nil end
    local r,g,b=tonumber(t.r),tonumber(t.g),tonumber(t.b)
    if not (r and g and b) then return nil end
    return Color3.new(math.clamp(r,0,1), math.clamp(g,0,1), math.clamp(b,0,1))
end

local function getFogConfigState()
    -- Save both picker values and the exact Lighting/Atmosphere values that are
    -- currently visible. Keeping both makes config restores deterministic.
    local state = {
        h=FogH, s=FogS, v=FogV, amount=FogAmount,
        selected=fogPackColor(FogSelected),
        lighting={},
        atmosphere={}
    }
    pcall(function()
        state.lighting.color=fogPackColor(FogLighting.FogColor)
        state.lighting.start=FogLighting.FogStart
        state.lighting.finish=FogLighting.FogEnd
    end)
    pcall(function()
        state.atmosphere.color=fogPackColor(FogAtmosphere.Color)
        state.atmosphere.density=FogAtmosphere.Density
        state.atmosphere.haze=FogAtmosphere.Haze
        state.atmosphere.glare=FogAtmosphere.Glare
        state.atmosphere.offset=FogAtmosphere.Offset
    end)
    return state
end

local function setFogConfigState(state)
    if type(state) ~= "table" then return end

    FogH = math.clamp(tonumber(state.h) or FogH, 0, 360)
    FogS = math.clamp(tonumber(state.s) or FogS, 0, 100)
    FogV = math.clamp(tonumber(state.v) or FogV, 0, 100)
    FogAmount = math.clamp(tonumber(state.amount) or FogAmount, 0, 100)

    -- First rebuild from the picker values so every UI element matches.
    applyUnifiedFog()

    -- Then restore the exact saved values. This prevents rounding/formula changes
    -- or another preset loaded earlier in the config from changing the result.
    local selected=fogUnpackColor(state.selected)
    if selected then FogSelected=selected end

    if type(state.lighting)=="table" then
        pcall(function()
            local c=fogUnpackColor(state.lighting.color)
            if c then FogLighting.FogColor=c end
            if tonumber(state.lighting.start) then FogLighting.FogStart=tonumber(state.lighting.start) end
            if tonumber(state.lighting.finish) then FogLighting.FogEnd=tonumber(state.lighting.finish) end
        end)
    end

    if type(state.atmosphere)=="table" then
        pcall(function()
            local c=fogUnpackColor(state.atmosphere.color)
            if c then FogAtmosphere.Color=c end
            if tonumber(state.atmosphere.density) then FogAtmosphere.Density=tonumber(state.atmosphere.density) end
            if tonumber(state.atmosphere.haze) then FogAtmosphere.Haze=tonumber(state.atmosphere.haze) end
            if tonumber(state.atmosphere.glare) then FogAtmosphere.Glare=tonumber(state.atmosphere.glare) end
            if tonumber(state.atmosphere.offset) then FogAtmosphere.Offset=tonumber(state.atmosphere.offset) end
        end)
    end

    -- The custom fog owns the visible atmosphere while active.
    for _, obj in ipairs(FogLighting:GetChildren()) do
        if obj:IsA("Atmosphere") and obj ~= FogAtmosphere then
            pcall(function() obj.Density=0 end)
        end
    end

    refreshFogUI()
end
_G.KimqFogController = {GetState=getFogConfigState, SetState=setFogConfigState}
if type(_G.KimqRegisterConfigControl) == "function" then
    _G.KimqRegisterConfigControl("Fog / Atmosphere State", "state", getFogConfigState, setFogConfigState)
end

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

-- Kimqetras HC owner presence notification.
-- Build-role branding is restricted to Kimqetras (owner) and famesgun (developer / scripter).
local KIMQ_OWNER_USER_ID = 11150537473
local ownerNoticeSeen = {}
local function notifyKimqOwner(player)
    if not player or player.UserId ~= KIMQ_OWNER_USER_ID or ownerNoticeSeen[player] then return end
    ownerNoticeSeen[player] = true
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Kimqetras HC ♡",
            Text = "Kimqetras owner joined ♡",
            Duration = 8
        })
    end)
end

for _,player in ipairs(Players:GetPlayers()) do
    notifyKimqOwner(player)
end
Players.PlayerAdded:Connect(function(player)
    if player.UserId == KIMQ_OWNER_USER_ID then
        task.wait(0.35)
        notifyKimqOwner(player)
    end
end)

pcall(function()
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Kimqetras HC ♡",
        Text = "Kimqetras owner build loaded ♡",
        Duration = 2
    })
end)

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
task.defer(function() if _G.FPSUnlocker and type(setfpscap) == "function" then pcall(setfpscap, _G.FPSTarget) end end)
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
_G.AntiFallEnabled = false -- duplicate backend path disabled; visible Anti Fall page owns this feature

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

local Camlock = {
    Target = nil,
    Active = false,
    Connection = nil,
    ResumeAfterRespawn = false,
}

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
                Camlock.ResumeAfterRespawn = true
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
        Camlock.ResumeAfterRespawn = true
        if not Camlock.Connection then Camlock.Connection = RunService.RenderStepped:Connect(UpdateCamlock) end
    end
end

local function DisableCamlock()
    Camlock.Active = false
    Camlock.ResumeAfterRespawn = false
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
        -- old KIM window removed in Kimpetras merge
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
    -- v2.62: dying no longer clears the COMBAT Camlock target.
    -- Keep the exact selected Player object and resume the same lock after
    -- our new character finishes spawning.
    local savedTarget = Camlock.Target
    local shouldResume = Camlock.ResumeAfterRespawn and savedTarget ~= nil

    Camlock.Active = false

    task.delay(.40, function()
        if shouldResume
            and _G.CamlockEnabled
            and savedTarget
            and savedTarget.Parent == Players
        then
            Camlock.Target = savedTarget
            Camlock.Active = true
            Camlock.ResumeAfterRespawn = true
        end
    end)

    if headlessActive then
        local char = LocalPlayer.Character
        if char then
            local head = char:WaitForChild("Head", 5)
            if head then head.Transparency = 1 end
        end
    end
end)

RunService.Heartbeat:Connect(function()
    -- This backend loop is only needed while Force Hit full-auto is actively firing.
    if not (_G.ForceHitFullAutoEnabled and ForceHitIsHoldingMouse and _G.ForceHitEnabled) then return end
    do
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

-- Duplicate legacy ESP renderer disabled. The visible ESP page uses ExtraESP only.

local fovCircle = SafeDrawing("Circle")
fovCircle.Thickness = 1
fovCircle.NumSides = 60
fovCircle.Radius = _G.FOV_RADIUS
fovCircle.Filled = false
fovCircle.Color = ColorPresets[_G.CurrentTheme].AccentColor
fovCircle.Visible = false

-- Lightweight visual loop: FOV + Flamelock only.
-- The second hidden ESP renderer and per-frame FPS-cap call were removed.
RunService.RenderStepped:Connect(function()
    local needFov = _G.ShowFOV == true
    local needFlame = _G.FlamelockEnabled and _G.FlameActive
    if not needFov then fovCircle.Visible = false end
    if not needFov and not needFlame then return end

    if needFov then
        fovCircle.Radius = _G.FOV_RADIUS
        local currentTheme = ColorPresets[_G.CurrentTheme] or ColorPresets["Cinnamoroll"]
        fovCircle.Color = currentTheme.AccentColor
        fovCircle.Position = Vector2.new(cam.ViewportSize.X / 2, cam.ViewportSize.Y / 2)
        fovCircle.Visible = true
    end

    if needFlame then
        if not flameTargetPart or not flameTargetPart.Parent then
            local target = getFlameTarget()
            if target then
                flameTargetPart = target
            else
                _G.FlameActive = false
                return
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
end)

local CONFIG_ROOT = "KimqetrasHC"
local CONFIG_DIR = CONFIG_ROOT .. "/configs"
_G.KimqMemoryConfigs = _G.KimqMemoryConfigs or {}
local KimqMemoryConfigs = _G.KimqMemoryConfigs

local function notifyConfig(text)
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "KIM ♡",
            Text = text,
            Duration = 3
        })
    end)
end

local function cleanConfigName(name)
    name = tostring(name or "")
    name = name:gsub("[%c/\\:*?\"<>|]", "")
    name = name:gsub("^%s+", ""):gsub("%s+$", "")
    if name == "" then name = "Kimqetras" end
    return name:sub(1, 48)
end

local function ensureConfigFolder()
    if type(isfolder) ~= "function" or type(makefolder) ~= "function" then return false end
    pcall(function() if not isfolder(CONFIG_ROOT) then makefolder(CONFIG_ROOT) end end)
    pcall(function() if not isfolder(CONFIG_DIR) then makefolder(CONFIG_DIR) end end)
    local ok, exists = pcall(isfolder, CONFIG_DIR)
    return ok and exists == true
end

local function configPath(name)
    return CONFIG_DIR .. "/" .. cleanConfigName(name) .. ".json"
end

local function serializable(v)
    local t = type(v)
    return t == "boolean" or t == "number" or t == "string"
end

-- JSON-safe deep copy for custom GUI state (avatar/accessories/fog/environment/skins).
-- This intentionally accepts only primitive values and tables made from them.
local function configSafeValue(v, depth)
    depth = depth or 0
    if depth > 8 then return nil end
    if serializable(v) then return v end
    if type(v) ~= "table" then return nil end
    local out = {}
    for k, child in pairs(v) do
        local kt=type(k)
        if kt=="string" or kt=="number" then
            local safe=configSafeValue(child, depth+1)
            if safe ~= nil then out[k]=safe end
        end
    end
    return out
end

local CONFIG_EXCLUDED_CONTROLS = {
    ["Fog / Atmosphere State"] = true,
    ["Atmosphere Preset"] = true,
    ["Reset Atmosphere"] = true,
    ["Color Correction"] = true,
    ["Saturation"] = true,
}

local function snapshotControls()
    local out = {}
    for name, entry in pairs(_G.KimqConfigControls or {}) do
        if not CONFIG_EXCLUDED_CONTROLS[name] and type(entry) == "table" and type(entry.get) == "function" then
            local ok, value = pcall(entry.get)
            if ok then
                local safe=configSafeValue(value)
                if safe ~= nil then out[name] = safe end
            end
        end
    end
    return out
end

local function SaveConfig(configName)
    local name = cleanConfigName(configName)
    local configData = {
        format = "KimqetrasHC-v2.68-all-settings",
        name = name,
        controls = snapshotControls(),
        theme = tostring(_G.KimqCuteTheme or "Matcha Pink"),
        whitelist = {},
        backendWhitelist = {},
    }

    -- Freeze the exact CURRENT copied avatar into this config. The config does
    -- not depend on the source user keeping the same Roblox outfit later.
    if _G.KimqAvatarController and type(_G.KimqAvatarController.GetSnapshot)=="function" then
        local ok,snapshot=pcall(_G.KimqAvatarController.GetSnapshot)
        if ok and type(snapshot)=="table" then
            configData.avatarSnapshot=configSafeValue(snapshot)
        end
    end

    -- Fog is saved separately from normal controls so environment/theme setters
    -- cannot race it during load. This snapshot includes exact visible values.
    if _G.KimqFogController and type(_G.KimqFogController.GetState)=="function" then
        local ok, fogState = pcall(_G.KimqFogController.GetState)
        if ok then configData.fog = configSafeValue(fogState) end
    end

    for uid, value in pairs(_G.KHWhitelist or {}) do
        if value then configData.whitelist[tostring(uid)] = true end
    end
    for uid, value in pairs(_G.Whitelist or {}) do
        if value then configData.backendWhitelist[tostring(uid)] = true end
    end

    -- Save the current window size too, so a compact layout can be restored with a preset.
    pcall(function()
        local root = game:GetService("CoreGui"):FindFirstChild("KimpetrasHC") or LocalPlayer.PlayerGui:FindFirstChild("KimpetrasHC")
        local main = root and root:FindFirstChild("Main")
        if main then
            configData.window = {
                w = main.AbsoluteSize.X, h = main.AbsoluteSize.Y,
                x = main.AbsolutePosition.X, y = main.AbsolutePosition.Y
            }
        end
    end)

    local okJson, json = pcall(function() return game:GetService("HttpService"):JSONEncode(configData) end)
    if not okJson then notifyConfig("Could not save config") return false end

    local wrote = false
    if ensureConfigFolder() and type(writefile) == "function" then
        wrote = pcall(writefile, configPath(name), json)
    end
    if not wrote then KimqMemoryConfigs[name] = json end

    _G.KimqSelectedConfig = name
    notifyConfig("Saved config: " .. name)
    if type(_G.KimqRefreshConfigList) == "function" then pcall(_G.KimqRefreshConfigList) end
    return true
end

local function readConfigText(name)
    name = cleanConfigName(name)
    local path = configPath(name)
    if type(isfile) == "function" and type(readfile) == "function" then
        local okExists, exists = pcall(isfile, path)
        if okExists and exists then
            local ok, data = pcall(readfile, path)
            if ok and type(data) == "string" then return data end
        end
    end
    return KimqMemoryConfigs[name]
end

local function configValuesEqual(a,b,depth)
    depth=(depth or 0)+1
    if depth>8 then return false end
    if type(a)~=type(b) then return false end
    if type(a)~="table" then return a==b end
    for k,v in pairs(a) do if not configValuesEqual(v,b[k],depth) then return false end end
    for k,_ in pairs(b) do if a[k]==nil then return false end end
    return true
end

local function LoadConfig(configName)
    local name = cleanConfigName(configName)
    local json = readConfigText(name)
    if not json then notifyConfig("Config not found: " .. name) return false end

    local okDecode, configData = pcall(function() return game:GetService("HttpService"):JSONDecode(json) end)
    if not okDecode or type(configData) ~= "table" then notifyConfig("That config could not be read") return false end

    -- New configs keep Fog / Atmosphere separate and apply it LAST. Older builds
    -- that happened to store it in controls are still supported as a fallback.
    local savedFogState = type(configData.fog)=="table" and configData.fog or
        (type(configData.controls)=="table" and configData.controls["Fog / Atmosphere State"] or nil)

    -- New v2.1 configs apply through registered control setters. This matters for
    -- local states such as MacroMaster/MacroSpeed: changing only _G would not update them.
    if type(configData.controls) == "table" then
        for controlName, value in pairs(configData.controls) do
            if not CONFIG_EXCLUDED_CONTROLS[controlName] then
                local entry = (_G.KimqConfigControls or {})[controlName]
                if type(entry) == "table" and type(entry.set) == "function" then
                    -- Do not fire expensive callbacks for settings that are already identical.
                    local same=false
                    if type(entry.get)=="function" then
                        local okCur,cur=pcall(entry.get)
                        if okCur then same=configValuesEqual(configSafeValue(cur),configSafeValue(value)) end
                    end
                    if not same then pcall(entry.set, value) end
                end
            end
        end
    else
        -- Compatibility with very old primitive-global configs.
        for k, v in pairs(configData) do
            if k ~= "Whitelist" and serializable(v) then _G[k] = v end
        end
    end

    if type(configData.whitelist) == "table" then
        table.clear(_G.KHWhitelist)
        for uid, value in pairs(configData.whitelist) do
            if value then _G.KHWhitelist[tonumber(uid) or uid] = true end
        end
    end
    if type(configData.backendWhitelist) == "table" then
        table.clear(_G.Whitelist)
        for uid, value in pairs(configData.backendWhitelist) do
            if value then _G.Whitelist[tonumber(uid) or uid] = true end
        end
    end

    if type(configData.theme) == "string" then
        -- Store it now; paint once at the end after controls finish restoring.
        _G.KimqCuteTheme = configData.theme
    end

    -- v2.67: configs store the avatar's HumanoidDescription snapshot. Loading it
    -- restores THAT saved look even if the source user has changed their avatar.
    if _G.KimqAvatarController then
        local savedAvatarSnapshot=type(configData.avatarSnapshot)=="table" and configData.avatarSnapshot or nil
        task.defer(function()
            if savedAvatarSnapshot and type(_G.KimqAvatarController.ApplySnapshot)=="function" then
                pcall(_G.KimqAvatarController.ApplySnapshot,savedAvatarSnapshot,true)
            elseif type(_G.KimqAvatarController.ApplySaved)=="function" then
                -- Backward compatibility for old configs that only stored username/id.
                pcall(_G.KimqAvatarController.ApplySaved)
            end
        end)
    end

    -- Applying a saved avatar can replace accessories. Re-apply the saved local
    -- accessories afterward so a preset containing BOTH avatar + accessories
    -- restores the final look rather than losing the local accessories.
    local savedAccessoryState = type(configData.controls)=="table" and configData.controls["Local Accessories"] or nil
    if savedAccessoryState and _G.KimqAccessoryController and type(_G.KimqAccessoryController.SetState)=="function" then
        task.delay(2.0, function()
            pcall(_G.KimqAccessoryController.SetState, savedAccessoryState)
        end)
    end

    if type(configData.window) == "table" then
        pcall(function()
            local w = math.clamp(tonumber(configData.window.w) or 980, 720, 1800)
            local h = math.clamp(tonumber(configData.window.h) or 620, 460, 1100)
            local root = game:GetService("CoreGui"):FindFirstChild("KimpetrasHC") or LocalPlayer.PlayerGui:FindFirstChild("KimpetrasHC")
            local main = root and root:FindFirstChild("Main")
            if main then
                main.Size = UDim2.fromOffset(w, h)
                if tonumber(configData.window.x) and tonumber(configData.window.y) then
                    local cam = workspace.CurrentCamera
                    local vp = cam and cam.ViewportSize or Vector2.new(1920,1080)
                    local x = math.clamp(tonumber(configData.window.x), 0, math.max(0, vp.X-w))
                    local y = math.clamp(tonumber(configData.window.y), 0, math.max(0, vp.Y-h))
                    main.Position = UDim2.fromOffset(x, y)
                end
            end
        end)
    end

    _G.KimqSelectedConfig = name
    if type(_G.KimqApplyTheme) == "function" then pcall(_G.KimqApplyTheme, _G.KimqCuteTheme or "Matcha Pink") end

    -- Restore fog after every other setting, especially Environment Preset.
    -- A few short re-applies handle games that rewrite Lighting for a frame or two
    -- when their own atmosphere scripts react to a preset/config load.
    if savedFogState and _G.KimqFogController and type(_G.KimqFogController.SetState)=="function" then
        _G.KimqFogLoadToken = (_G.KimqFogLoadToken or 0) + 1
        local token = _G.KimqFogLoadToken
        local function restoreSavedFog()
            if _G.KimqFogLoadToken ~= token then return end
            pcall(_G.KimqFogController.SetState, savedFogState)
        end
        restoreSavedFog()
        -- One delayed settle handles late Lighting writes without hammering the fog UI.
        task.delay(0.18, restoreSavedFog)
    end

    notifyConfig("Loaded config: " .. name)
    if type(_G.KimqRefreshConfigList) == "function" then pcall(_G.KimqRefreshConfigList) end
    return true
end

local function DeleteConfig(configName)
    local name = cleanConfigName(configName)
    local removed = false
    local path = configPath(name)
    if type(isfile) == "function" and type(delfile) == "function" then
        local okExists, exists = pcall(isfile, path)
        if okExists and exists then removed = pcall(delfile, path) end
    end
    if KimqMemoryConfigs[name] then KimqMemoryConfigs[name] = nil removed = true end
    if removed then
        if _G.KimqSelectedConfig == name then _G.KimqSelectedConfig = nil end
        notifyConfig("Deleted config: " .. name)
    else
        notifyConfig("Config not found: " .. name)
    end
    if type(_G.KimqRefreshConfigList) == "function" then pcall(_G.KimqRefreshConfigList) end
    return removed
end

local function GetConfigs()
    local names, seen = {}, {}
    local function add(name)
        name = cleanConfigName(name)
        if name ~= "" and not seen[name] then seen[name] = true table.insert(names, name) end
    end

    if ensureConfigFolder() and type(listfiles) == "function" then
        local ok, files = pcall(listfiles, CONFIG_DIR)
        if ok and type(files) == "table" then
            for _, filePath in ipairs(files) do
                local filename = tostring(filePath):match("([^/\\]+)%.json$")
                if filename then add(filename) end
            end
        end
    end
    for name in pairs(KimqMemoryConfigs) do add(name) end
    table.sort(names, function(a,b) return a:lower() < b:lower() end)
    return names
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

-- Export backend helpers to the Kimqetras interface.
_G.KimpetrasKIMBackend = {
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
if not C then error("Kimqetras core context missing") end
local UIS, lp, cfg = C.UIS, C.lp, C.cfg
local createCard, addToggle, addSlider, addDecimalSlider, addButton, addDropdown, addKeybind =
    C.createCard, C.addToggle, C.addSlider, C.addDecimalSlider, C.addButton, C.addDropdown, C.addKeybind
-- ========================================================
-- CLEAN KIM FEATURE SECTIONS
-- Remaining document (3) controls, styled for Kimpetras HC.
-- ========================================================

local sectionKeyByTitle = {
    ["Combat"] = "hcsilent",
    ["Force Hit"] = "hcsilent",
    ["Hitbox Expander"] = "hitbox",
    ["Flamelock"] = "flamelock",
    ["Camlock"] = "camlock",
    ["Visuals"] = "fog",
    ["Headless"] = "avatar",
    ["Protection + Anti Mod"] = "antimod",
    ["Settings"] = "settings",
    ["Credits"] = "info",
}

local function addCleanSection(title, subtitle)
    local key = sectionKeyByTitle[title]
    if key then _G.KimqBuildSection = key end
    -- v2.62: pageHead already displays the section name.
    -- Do not add another title card inside the page.
    return nil
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

local KIM = _G.KimpetrasKIMBackend or {}
local allParts = {
    "Head", "UpperTorso", "LowerTorso", "HumanoidRootPart",
    "LeftUpperArm", "RightUpperArm", "LeftLowerArm", "RightLowerArm",
    "LeftUpperLeg", "RightUpperLeg", "LeftLowerLeg", "RightLowerLeg",
    "LeftFoot", "RightFoot", "LeftHand", "RightHand", "Closest Point"
}

-- COMBAT -------------------------------------------------
addCleanSection("Combat", "HC Silent Aim + Force Hit")

addToggle("HC Silent Aim", _G.HCSilentAimEnabled, function(v)
    _G.HCSilentAimEnabled = v
    if KIM.enableHCSilentAim then KIM.enableHCSilentAim(v) end
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
        if KIM.HCGodmodeStart then KIM.HCGodmodeStart() end
    else
        if KIM.HCGodmodeStop then KIM.HCGodmodeStop() end
    end
end)

addCleanSection("Force Hit", "Force-hit controls")
addToggle("Force Hit", _G.ForceHitEnabled, function(v) _G.ForceHitEnabled = v end)
addDropdown("Force Hit Mode", {"Fov", "Manual"}, _G.ForceHitMode, function(v) _G.ForceHitMode = v end)
addSlider("Force Hit FOV", 10, 1000, _G.ForceHitFOV, function(v) _G.ForceHitFOV = v end)
addToggle("Force Hit Tracer", _G.ForceHitTracerEnabled, function(v) _G.ForceHitTracerEnabled = v end)
addToggle("Force Hit Full Auto", _G.ForceHitFullAutoEnabled, function(v) _G.ForceHitFullAutoEnabled = v end)
addDecimalSlider("Force Hit Fire Rate", 0.01, 0.5, _G.ForceHitFireRate, 3, function(v) _G.ForceHitFireRate = v end)

addCleanSection("Hitbox Expander", "Adjust hitbox settings")
addToggle("Hitbox Expander", _G.HitboxEnabled, function(v)
    _G.HitboxEnabled = v
    if KIM.UpdateHitboxes then KIM.UpdateHitboxes() end
end)
addSlider("Hitbox Size", 1, 20, _G.HitboxSize, function(v) _G.HitboxSize = v end)
addDecimalSlider("Hitbox Visibility", 0, 1, _G.HitboxTransparency, 2, function(v) _G.HitboxTransparency = v end)

addCleanSection("Flamelock", "Customize flamelock settings")
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
addCleanSection("Camlock", "Customize camlock settings")
addToggle("Camlock Enabled", _G.CamlockEnabled, function(v)
    _G.CamlockEnabled = v
    if not v and KIM.DisableCamlock then KIM.DisableCamlock() end
end)
addToggle("Auto Toggle (Gun)", _G.CamlockAutoToggle, function(v) _G.CamlockAutoToggle = v end)
addKeybind("Camlock Key", Enum.KeyCode[_G.CamlockToggleKey] or Enum.KeyCode.C, function(v) _G.CamlockToggleKey = v.Name end)
addDropdown("Camlock Mode", {"Hold","Toggle"}, _G.CamlockMode, function(v)
    _G.CamlockMode = v
    if KIM.DisableCamlock then KIM.DisableCamlock() end
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
addCleanSection("Visuals", "Customize the look of the game")
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

-- AVATAR / HEADLESS --------------------------------------
-- Headless is built directly into the revamped Avatar page as "Visual Headless".

-- PROTECTION ---------------------------------------------
addCleanSection("Protection + Anti Mod", "Extra protection options")
addToggle("KIM Anti Aim View", _G.AntiAimViewEnabled, function(v)
    _G.AntiAimViewEnabled = v
    if KIM.toggleAntiAimView then KIM.toggleAntiAimView(v) end
end)
addToggle("Anti Mod Notify", false, function(v) _G.AntiModNotification = v end)
addToggle("Anti Mod Kick", false, function(v) _G.AntiModKick = v end)
addSlider("Anti Mod Kick Delay", 1, 10, _G.AntiModKickDelay, function(v) _G.AntiModKickDelay = v end)
addSmallNote("Anti Mod controls are OFF here by default so the script does not kick you unless you choose to enable it.")

-- SETTINGS -----------------------------------------------
addCleanSection("Settings", "Performance and saved setup options")
addToggle("FPS Unlocker", _G.FPSUnlocker, function(v)
    _G.FPSUnlocker = v
    if v and type(setfpscap) == "function" then pcall(setfpscap, _G.FPSTarget) end
end)
addSlider("Target FPS", 240, 1000, _G.FPSTarget, function(v)
    _G.FPSTarget = v
    if _G.FPSUnlocker and type(setfpscap) == "function" then pcall(setfpscap, v) end
end)

local configName = "Kimqetras"
local selectedConfig = _G.KimqSelectedConfig

-- v2.67: one compact Saved Configs card instead of five separate action cards.
local savedCard = createCard(322)
savedCard.Name = "KimqSavedConfigsCard"
savedCard:SetAttribute("KimqSection", "settings")
local savedTitle = Instance.new("TextLabel", savedCard)
savedTitle.Size = UDim2.new(1,-96,0,22)
savedTitle.Position = UDim2.fromOffset(10,7)
savedTitle.BackgroundTransparency = 1
savedTitle.Text = "♥  Saved Configs"
savedTitle.TextColor3 = Color3.fromRGB(220,45,125)
savedTitle.Font = Enum.Font.GothamBold
savedTitle.TextSize = 15
savedTitle.TextXAlignment = Enum.TextXAlignment.Left
savedTitle:SetAttribute("KimqV26Role","hotText")

local savedHint = Instance.new("TextLabel", savedCard)
savedHint.Size = UDim2.new(1,-20,0,17)
savedHint.Position = UDim2.fromOffset(10,30)
savedHint.BackgroundTransparency = 1
savedHint.Text = "save, update, load, or delete one setup ♡"
savedHint.TextColor3 = Color3.fromRGB(184,100,125)
savedHint.Font = Enum.Font.Gotham
savedHint.TextSize = 10
savedHint.TextXAlignment = Enum.TextXAlignment.Left
savedHint:SetAttribute("KimqV26Role","subText")

local refreshConfigButton = Instance.new("TextButton", savedCard)
refreshConfigButton.Size = UDim2.fromOffset(74,26)
refreshConfigButton.Position = UDim2.new(1,-84,0,7)
refreshConfigButton.BackgroundColor3 = Color3.fromRGB(255,225,238)
refreshConfigButton.BorderSizePixel = 0
refreshConfigButton.Text = "refresh"
refreshConfigButton.TextColor3 = Color3.fromRGB(225,55,135)
refreshConfigButton.Font = Enum.Font.GothamSemibold
refreshConfigButton.TextSize = 10
Instance.new("UICorner", refreshConfigButton).CornerRadius = UDim.new(0,8)
refreshConfigButton:SetAttribute("KimqV26Role","lightBg")

local configNameLabel = Instance.new("TextLabel", savedCard)
configNameLabel.Size = UDim2.new(1,-20,0,18)
configNameLabel.Position = UDim2.fromOffset(10,51)
configNameLabel.BackgroundTransparency = 1
configNameLabel.Text = "Config Name"
configNameLabel.TextColor3 = Color3.fromRGB(166,55,105)
configNameLabel.Font = Enum.Font.GothamSemibold
configNameLabel.TextSize = 11
configNameLabel.TextXAlignment = Enum.TextXAlignment.Left
configNameLabel:SetAttribute("KimqV26Role","textText")

local configBox = Instance.new("TextBox", savedCard)
configBox.Size = UDim2.new(1,-20,0,30)
configBox.Position = UDim2.fromOffset(10,72)
configBox.BackgroundColor3 = Color3.fromRGB(255,225,238)
configBox.BorderSizePixel = 0
configBox.PlaceholderText = "Kimqetras"
configBox.PlaceholderColor3 = Color3.fromRGB(197,112,145)
configBox.TextColor3 = Color3.fromRGB(225,55,135)
configBox.Font = Enum.Font.Gotham
configBox.TextSize = 12
configBox.ClearTextOnFocus = false
Instance.new("UICorner", configBox).CornerRadius = UDim.new(0,8)
configBox:SetAttribute("KimqV26Role","lightBg")
local configBoxPad=Instance.new("UIPadding",configBox); configBoxPad.PaddingLeft=UDim.new(0,9); configBoxPad.PaddingRight=UDim.new(0,9)
configBox.FocusLost:Connect(function()
    local v=tostring(configBox.Text or ""):gsub("^%s+",""):gsub("%s+$","")
    if v~="" then configName=v end
end)

local savedList = Instance.new("ScrollingFrame", savedCard)
savedList.Name = "KimqSavedConfigList"
savedList.Size = UDim2.new(1,-20,0,112)
savedList.Position = UDim2.fromOffset(10,111)
savedList.BackgroundColor3 = Color3.fromRGB(255,245,250)
savedList.BorderSizePixel = 0
savedList.ScrollBarThickness = 3
savedList.ScrollBarImageColor3 = Color3.fromRGB(243,161,211)
Instance.new("UICorner", savedList).CornerRadius = UDim.new(0,9)
local savedLayout = Instance.new("UIListLayout", savedList)
savedLayout.Padding = UDim.new(0,5)
savedLayout.SortOrder = Enum.SortOrder.LayoutOrder
local savedPad = Instance.new("UIPadding", savedList)
savedPad.PaddingTop = UDim.new(0,6)
savedPad.PaddingBottom = UDim.new(0,6)
savedPad.PaddingLeft = UDim.new(0,6)
savedPad.PaddingRight = UDim.new(0,6)
savedLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    savedList.CanvasSize = UDim2.new(0,0,0,savedLayout.AbsoluteContentSize.Y + 12)
end)

local function settingsAction(text,pos,callback)
    local b=Instance.new("TextButton",savedCard)
    b.Size=UDim2.new(.5,-15,0,34)
    b.Position=pos
    b.BackgroundColor3=Color3.fromRGB(255,225,238)
    b.BorderSizePixel=0
    b.Text=text
    b.TextColor3=Color3.fromRGB(225,55,135)
    b.Font=Enum.Font.GothamSemibold
    b.TextSize=11
    b.AutoButtonColor=false
    Instance.new("UICorner",b).CornerRadius=UDim.new(0,9)
    b:SetAttribute("KimqV26Role","lightBg")
    local st=Instance.new("UIStroke",b); st.Color=Color3.fromRGB(255,190,220); st.Transparency=.35; st.Thickness=1
    b.MouseButton1Click:Connect(callback)
    return b
end

local function refreshConfigList()
    for _,ch in ipairs(savedList:GetChildren()) do
        if ch:IsA("TextButton") or ch:IsA("TextLabel") then ch:Destroy() end
    end
    local configs = (KIM.GetConfigs and KIM.GetConfigs()) or {}
    if #configs == 0 then
        local empty = Instance.new("TextLabel", savedList)
        empty.Size = UDim2.new(1,-4,0,30)
        empty.BackgroundTransparency = 1
        empty.Text = "no saved configs yet ♡"
        empty.TextColor3 = Color3.fromRGB(184,100,125)
        empty.Font = Enum.Font.Gotham
        empty.TextSize = 11
    else
        for i,name in ipairs(configs) do
            local row = Instance.new("TextButton", savedList)
            row.Name = "Config_" .. tostring(i)
            row.LayoutOrder = i
            row.Size = UDim2.new(1,-4,0,30)
            row.BackgroundColor3 = (selectedConfig == name) and Color3.fromRGB(243,161,211) or Color3.fromRGB(236,255,243)
            row.BorderSizePixel = 0
            row.Text = ((selectedConfig == name) and "♥  " or "♡  ") .. name
            row.TextColor3 = (selectedConfig == name) and Color3.fromRGB(255,255,255) or Color3.fromRGB(82,116,94)
            row.Font = Enum.Font.GothamSemibold
            row.TextSize = 11
            row.TextXAlignment = Enum.TextXAlignment.Left
            Instance.new("UICorner", row).CornerRadius = UDim.new(0,8)
            local rowPad = Instance.new("UIPadding", row)
            rowPad.PaddingLeft = UDim.new(0,10)
            row.MouseButton1Click:Connect(function()
                selectedConfig = name
                _G.KimqSelectedConfig = name
                configName = name
                configBox.Text = name
                refreshConfigList()
            end)
        end
    end
end
_G.KimqRefreshConfigList = refreshConfigList

local saveConfigButton=settingsAction("Save",UDim2.fromOffset(10,232),function()
    if configBox.Text ~= "" then configName = configBox.Text end
    if KIM.SaveConfig and KIM.SaveConfig(configName) then
        selectedConfig = configName
        _G.KimqSelectedConfig = configName
        refreshConfigList()
    end
end)
local updateConfigButton=settingsAction("Update",UDim2.new(.5,5,0,232),function()
    if not selectedConfig or selectedConfig == "" then
        pcall(function() game:GetService("StarterGui"):SetCore("SendNotification",{Title="KIM ♡",Text="Select a saved config first",Duration=3}) end)
        return
    end
    local oldName = selectedConfig
    local wantedName = tostring(configBox.Text or ""):gsub("^%s+",""):gsub("%s+$","")
    if wantedName == "" then wantedName = oldName end
    if KIM.SaveConfig and KIM.SaveConfig(wantedName) then
        if wantedName ~= oldName and KIM.DeleteConfig then pcall(function() KIM.DeleteConfig(oldName) end) end
        selectedConfig=wantedName; configName=wantedName; configBox.Text=wantedName; _G.KimqSelectedConfig=wantedName
        refreshConfigList()
    end
end)
local loadConfigButton=settingsAction("Load",UDim2.fromOffset(10,276),function()
    local name = selectedConfig or configName
    if KIM.LoadConfig and KIM.LoadConfig(name) then
        selectedConfig=name; _G.KimqSelectedConfig=name; configBox.Text=name; refreshConfigList()
    end
end)
local deleteConfigButton=settingsAction("Delete",UDim2.new(.5,5,0,276),function()
    local name = selectedConfig or configName
    if KIM.DeleteConfig and KIM.DeleteConfig(name) then
        if selectedConfig == name then selectedConfig=nil end
        _G.KimqSelectedConfig=selectedConfig
        refreshConfigList()
    end
end)
refreshConfigButton.MouseButton1Click:Connect(refreshConfigList)
refreshConfigList()

-- Keep Emergency Restore at the very bottom with no extra description card.
local emergencyCard=createCard(48)
emergencyCard.Name="KimqEmergencyRestoreCard"
emergencyCard:SetAttribute("KimqSection","settings")
local emergencyRestoreButton=Instance.new("TextButton",emergencyCard)
emergencyRestoreButton.Name="KimqEmergencyRestoreButton"
emergencyRestoreButton.Size=UDim2.new(1,-16,1,-10)
emergencyRestoreButton.Position=UDim2.fromOffset(8,5)
emergencyRestoreButton.BackgroundColor3=Color3.fromRGB(255,205,228)
emergencyRestoreButton.BorderSizePixel=0
emergencyRestoreButton.Text="♥  Emergency Restore"
emergencyRestoreButton.TextColor3=Color3.fromRGB(225,55,135)
emergencyRestoreButton.Font=Enum.Font.GothamBold
emergencyRestoreButton.TextSize=12
emergencyRestoreButton.AutoButtonColor=false
Instance.new("UICorner",emergencyRestoreButton).CornerRadius=UDim.new(0,9)
emergencyRestoreButton:SetAttribute("KimqV26Role","lightBg")
local emergencyStroke=Instance.new("UIStroke",emergencyRestoreButton); emergencyStroke.Color=Color3.fromRGB(255,170,210); emergencyStroke.Transparency=.28; emergencyStroke.Thickness=1
emergencyRestoreButton.MouseButton1Click:Connect(function()
    pcall(function()
        if type(_G.KimqRageEmergencyRestore)=="function" then _G.KimqRageEmergencyRestore() end
    end)
    pcall(function()
        _G.FlameActive=false
        if KIM and KIM.DisableCamlock then KIM.DisableCamlock() end
    end)
    pcall(function()
        local c=workspace.CurrentCamera
        local char=Players.LocalPlayer.Character
        local hum=char and char:FindFirstChildOfClass("Humanoid")
        local root=char and char:FindFirstChild("HumanoidRootPart")
        if hum then hum.PlatformStand=false; hum.Sit=false; hum.AutoRotate=true end
        if root then root.AssemblyLinearVelocity=Vector3.zero; root.AssemblyAngularVelocity=Vector3.zero end
        if c then c.CameraType=Enum.CameraType.Custom; if hum then c.CameraSubject=hum end end
        UIS.MouseBehavior=Enum.MouseBehavior.Default
        UIS.MouseIconEnabled=true
    end)
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification",{Title="KIM ♡",Text="Emergency Restore complete ♡",Duration=3})
    end)
end)

]=====], false) then return end

if #failures == 0 then
    Status.Text = "ready ♡"
    Bar.Size = UDim2.new(1, 0, 1, 0)
    Status.Text = "finishing up... ♡"
    task.wait(0.05)
    -- Kimqetras redesign patch closes the loader after the new UI is ready.
else
    local first = failures[1] or "unknown issue"
    Status.Text = "Kimqetras HC is open.\n" .. tostring(#failures) .. " optional module issue(s) were skipped.\n\nFirst issue:\n" .. first
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
-- KIMQETRAS HC PAGE CONSTRUCTION
-- One page shell is created; feature controls are moved into it once.
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
    -- Keep a live reference so the final theme engine can update callbacks that use T.
    _G.KimqThemePaletteRefs = _G.KimqThemePaletteRefs or {}
    table.insert(_G.KimqThemePaletteRefs, T)

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
    task.spawn(function()
        local ok,img=pcall(function()
            return Players:GetUserThumbnailAsync(lp.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100)
        end)
        if ok and topAvatar and topAvatar.Parent then topAvatar.Image=img end
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

    local navSearch = Instance.new("TextBox")
    navSearch.Name = "PageSearch"
    navSearch.Parent = side
    navSearch.Size = UDim2.new(1, -16, 0, 30)
    navSearch.Position = UDim2.fromOffset(8, 56)
    navSearch.BackgroundColor3 = T.panel
    navSearch.BorderSizePixel = 0
    navSearch.PlaceholderText = "♡  find a page..."
    navSearch.PlaceholderColor3 = T.sub
    navSearch.Text = ""
    navSearch.TextColor3 = T.text
    navSearch.Font = Enum.Font.Gotham
    navSearch.TextSize = 11
    navSearch.ClearTextOnFocus = false
    navSearch.TextXAlignment = Enum.TextXAlignment.Left
    corner(navSearch, 10)
    stroke(navSearch, T.stroke, .28, 1)
    local navSearchPad=Instance.new("UIPadding",navSearch)
    navSearchPad.PaddingLeft=UDim.new(0,10)
    navSearchPad.PaddingRight=UDim.new(0,10)

    local nav = Instance.new("ScrollingFrame")
    nav.Parent = side
    nav.Size = UDim2.new(1, -14, 1, -144)
    nav.Position = UDim2.fromOffset(7, 92)
    nav.BackgroundTransparency = 1
    nav.BorderSizePixel = 0
    nav.ScrollBarThickness = 2
    nav.ScrollBarImageColor3 = T.hot
    local navLayout = Instance.new("UIListLayout", nav)
    navLayout.SortOrder = Enum.SortOrder.LayoutOrder
    navLayout.Padding = UDim.new(0, 6)
    navLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        nav.CanvasSize = UDim2.new(0, 0, 0, navLayout.AbsoluteContentSize.Y + 16)
    end)

    local rightShiftHint = Instance.new("Frame")
    rightShiftHint.Parent = side
    rightShiftHint.Size = UDim2.new(1, -16, 0, 30)
    rightShiftHint.Position = UDim2.new(0, 8, 1, -38)
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

    -- v2.62: pages are grouped by what they actually do so the sidebar is
    -- easier to understand. Environment + Weapon Skins are canonical pages now,
    -- not late-added special buttons that can disappear during startup.
    local pageDefs = {
        -- HOME
        {"overview", "overview", "your account, quick notes, and a little welcome page", "HOME"},
        {"theme", "theme", "change the colors of the whole interface", "HOME"},
        {"settings", "settings", "performance and saved setup options", "HOME"},

        -- COMBAT
        {"hcsilent", "HC silent aim", "HC targeting and force-hit controls together", "COMBAT"},
        {"silent", "silent aim", "adjust your targeting settings", "COMBAT"},
        {"camlock", "camlock", "customize camlock settings", "COMBAT"},
        {"flamelock", "flamelock", "customize flamelock settings", "COMBAT"},
        {"hitbox", "hitbox expander", "adjust hitbox settings", "COMBAT"},
        {"delay", "delay changer", "adjust weapon delay settings", "COMBAT"},

        -- VISUALS
        {"fog", "fog / atmosphere", "customize fog, atmosphere, and colors", "VISUALS"},
        {"environment", "environment", "day/night and seasonal map styles", "VISUALS"},
        {"esp", "ESP", "customize player ESP", "VISUALS"},

        -- PLAYER
        {"avatar", "avatar", "copy an avatar, wear local items, and use headless", "PLAYER"},
        {"weaponskins", "weapon skins", "wraps, bullets, knives, and equippable items", "PLAYER"},
        {"whitelist", "whitelist", "choose players you want to ignore", "PLAYER"},
        {"protection", "protection", "extra protection options", "PLAYER"},
        {"antifall", "anti fall", "helps with unwanted falling states", "PLAYER"},
        {"antimod", "anti mod", "extra anti-mod options", "PLAYER"},
        {"spawn", "spawn point", "choose where you return after respawning", "PLAYER"},
        {"macro", "macro", "control how your macro behaves", "PLAYER"},

        -- RAGE
        {"ragecam", "rage camlock", "select one or more players and keep target lock through respawn", "RAGE"},
        {"rageorbit", "target orbit", "teleport to and orbit your current queued target", "RAGE"},
        {"ragecombat", "rage combat", "auto attack, finish, and advance through your target queue", "RAGE"},
        {"ragepresets", "rage presets", "OP one-tap targeting, queue wipe, orbit hunt, or calm mode", "RAGE"},

        -- CREDITS
        {"info", "information", "credits and roles for this build", "CREDITS"},
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
            txt = txt:gsub("^%s+", "")
            local first = txt:sub(1, 1)
            if first ~= "♥" and first ~= "♡" then return nil end
            txt = txt:gsub("^[♥♡]%s*", "")
            txt = txt:gsub("%s+", " "):gsub("^%s+", ""):gsub("%s+$", "")
            return txt:lower()
        end
        if obj:IsA("TextLabel") then
            return cleanText(obj.Text), obj
        elseif obj:IsA("Frame") then
            for _, ch in ipairs(obj:GetDescendants()) do
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
        ["force hit"] = "hcsilent",
        ["hitbox expander"] = "hitbox",
        ["flamelock"] = "flamelock",
        ["camlock"] = "camlock",
        ["visuals"] = "fog",
        ["headless"] = "avatar",
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
        -- All original controls now receive a unique LayoutOrder at creation.
        -- This is deterministic even when an item (such as a dropdown) is hidden.
        if a.LayoutOrder ~= b.LayoutOrder then
            return a.LayoutOrder < b.LayoutOrder
        end
        local ay, by = a.AbsolutePosition.Y, b.AbsolutePosition.Y
        if ay ~= by then return ay < by end
        return a.Name < b.Name
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

            -- Standalone labels such as "♥ Avatar", "♥ Macro", etc. were
            -- section dividers in the old one-page GUI. The new page header
            -- already says this, so discard those duplicates.
            if child:IsA("TextLabel") then
                pcall(function() child:Destroy() end)
                continue
            end
        end

        -- Cards created by v2.1 know exactly which page owns them.  Use that
        -- stamp first; only legacy header-only objects fall back to `current`.
        local stamped = child:GetAttribute("KimqSection")
        if stamped=="forcehit" then stamped="hcsilent" end
        if stamped=="headless" then stamped="avatar" end
        local target = (stamped and pages[stamped]) and stamped or current
        local page = pages[target]
        if page then
            orderCount[target] = (orderCount[target] or 0) + 1
            child.LayoutOrder = orderCount[target]
            child.Parent = page
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

    -- Overview is intentionally left empty here. The final v2.1 builder creates it once.

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

    local navGroupLabels = {}
    local lastGroup = nil
    for i, d in ipairs(pageDefs) do
        local groupName = tostring(d[4] or "PAGES")
        if groupName ~= lastGroup then
            lastGroup = groupName
            local group = Instance.new("TextLabel")
            group.Name = "Group_" .. groupName
            group.Parent = nav
            group.LayoutOrder = i * 10 - 1
            group.Size = UDim2.new(1, -4, 0, 18)
            group.BackgroundTransparency = 1
            group.Text = "   " .. groupName
            group.TextColor3 = T.sub
            group.Font = Enum.Font.GothamBold
            group.TextSize = 9
            group.TextXAlignment = Enum.TextXAlignment.Left
            navGroupLabels[groupName] = group
        end

        local btn = Instance.new("TextButton")
        btn.Parent = nav
        btn.LayoutOrder = i * 10
        btn.Size = UDim2.new(1, -4, 0, 35)
        btn.BackgroundColor3 = T.panel
        btn.BorderSizePixel = 0
        btn.Text = "      " .. d[2]
        btn.TextColor3 = T.text
        btn.Font = Enum.Font.FredokaOne
        btn.TextSize = 12
        btn.TextXAlignment = Enum.TextXAlignment.Left
        btn.AutoButtonColor = false
        corner(btn, 11)
        stroke(btn, T.stroke, 0.28, 1)

        local h = textLabel(btn, "♡", UDim2.fromOffset(28, 35), UDim2.fromOffset(7, 0), Enum.Font.FredokaOne, 16, T.hot, Enum.TextXAlignment.Center)
        h.Name = "Heart"

        btn.MouseButton1Click:Connect(function() showPage(d[1]) end)
        table.insert(navButtons, {button = btn, key = d[1], label = d[2], group = groupName})
    end

    local function refreshPageSearch()
        local q = tostring(navSearch.Text or ""):lower():gsub("^%s+",""):gsub("%s+$","")
        local groupHasVisible = {}
        for _, entry in ipairs(navButtons) do
            local aliases=""
            if entry.key=="hcsilent" then aliases=" force hit forcehit" end
            if entry.key=="avatar" then aliases=" headless catalog limited accessory" end
            if entry.key=="ragecam" then aliases=" target queue player list view spectate" end
            if entry.key=="rageorbit" then aliases=" auto teleport circle fly angel wings" end
            if entry.key=="ragecombat" then aliases=" auto shoot force hit stomp finish queue" end
            if entry.key=="ragepresets" then aliases=" preset presets solo full send queue sweep orbit evasive manual calm" end
            local hay = (tostring(entry.label) .. " " .. tostring(entry.key) .. aliases):lower()
            local visible = q == "" or hay:find(q, 1, true) ~= nil
            entry.button.Visible = visible
            if visible then groupHasVisible[entry.group] = true end
        end
        for groupName, label in pairs(navGroupLabels) do
            label.Visible = q == "" or groupHasVisible[groupName] == true
        end
    end
    navSearch:GetPropertyChangedSignal("Text"):Connect(refreshPageSearch)
    refreshPageSearch()

    -- ================================================================
    -- v2.67 ISOLATED RAGE MODULE
    -- This entire feature is deferred and protected. If it errors, only
    -- RAGE fails; the rest of Kimqetras HC keeps loading normally.
    -- ================================================================
    task.defer(function()
        local rageOK,rageERR=pcall(function()
            local rageCamPage=pages.ragecam
            local rageOrbitPage=pages.rageorbit
            local rageCombatPage=pages.ragecombat
            if not (rageCamPage and rageOrbitPage and rageCombatPage) then return end

            local PlayersR=game:GetService("Players")
            local RunServiceR=game:GetService("RunService")
            local UISR=game:GetService("UserInputService")
            local ReplicatedStorageR=game:GetService("ReplicatedStorage")
            local VIMR=nil
            pcall(function() VIMR=game:GetService("VirtualInputManager") end)

            local queue={}
            local queued={}
            local currentIndex=1
            local playerList=nil
            local selectedLabels={}
            local previewViewport=nil
            local previewTitle=nil
            local previewToken=0
            local previewPoseConn=nil
            local previewPoseResolved=nil

            local camEnabled=false
            local viewEnabled=false
            -- v2.63 RAGE Lock is a translation-follow camera: it keeps one fixed
            -- world-space offset from the target, so YOUR orbit cannot spin it.
            local camSmooth=1
            local camPart="Head"
            local rageLockOffset=nil
            local rageLockTargetId=nil
            local rageLockDeadLatch=false

            -- Free local spectator camera for RAGE > View.
            local viewYaw=0
            local viewPitch=.10
            local viewDistance=12
            local viewDragging=false
            local viewPreviousType=nil
            local viewPreviousSubject=nil
            local viewPreviousMouseBehavior=nil
            local viewPreviousMouseIcon=nil

            -- Dedicated movement connection. Keeping orbit out of the normal
            -- RAGE camera loop makes the game movement controller less likely
            -- to overwrite it immediately.
            local orbitEnabled=false
            local orbitSpeed=8
            local orbitRadius=8
            local orbitHeight=4
            local orbitAngle=0
            local orbitMotionConn=nil
            local orbitHumanoid=nil
            local orbitOldPlatformStand=nil
            local orbitOldAutoRotate=nil

            -- Best-effort evasive orbit. This cannot make the player server-invulnerable,
            -- but it makes simple position/prediction locks much less predictable.
            local antiLockEnabled=false
            local antiLockStrength=1
            local antiLockPhase=math.random()*100

            local autoTeleport=false
            local teleportDelay=.25
            local teleportClock=0

            local autoShoot=false
            local shootDelay=.08
            local shootClock=0
            local hitPart="Head"
            local burstCount=6
            local combatMode="Normal Gun"

            -- v2.67: RAGE-only helpers. These do not modify normal COMBAT/Silent Aim.
            local autoWeaponProfiles=true
            local queueOrderMode="Manual"
            local queueSkipDowned=true
            local queueSkipWhitelisted=true
            local rageHudEnabled=true
            local rageHudFrame=nil
            local rageHudTarget=nil
            local rageHudStatus=nil
            local rageHudQueue=nil
            local rageHudWeapon=nil
            local rageHudNext=nil
            local rageHudHeader=nil
            local rageHudTitle=nil
            local rageHudHint=nil
            local rageHudGradient=nil
            local rageHudStroke=nil
            local rageHudStatusPill=nil
            local rageHudStatusPillStroke=nil
            local rageHudBody=nil
            local rageHudBodyStroke=nil
            local rageHudAccent=nil
            local rageHudClock=0

            -- v2.71: keep all RAGE preset setters in ONE table instead of thirteen
            -- separate locals. v2.67-v2.70 crossed Luau's active-local/register limit
            -- inside this protected RAGE function, which prevented the ENTIRE file from
            -- compiling before even the loader could appear. This is state-only refactoring:
            -- the same controls, callbacks, presets, and behavior are preserved.
            local rageControl={}

            -- v2.63: optional reload helper for RAGE combat only.
            -- It never touches normal gun behavior unless the toggle is enabled.
            local autoReload=false
            local reloadBusy=false
            local lastReloadAt=0

            local orbitAnimTrack=nil
            local lastWingTry=0

            local autoHunt=false
            local autoStomp=true
            local autoAdvance=true
            local stompRepeats=3
            local stompBusy=false
            -- v2.81: explicit RAGE phases live on the existing control table so this
            -- giant RAGE chunk does not consume extra local registers.
            rageControl.phase="IDLE"
            rageControl.phaseTargetId=nil
            local finishedWaiting={}
            local respawnScanClock=0
            local lastDownCheck=0

            local function pal()
                return _G.KimqThemeLivePalette or T
            end

            local function role(obj,name)
                if obj then obj:SetAttribute("KimqV26Role",name) end
                return obj
            end
            local order={}
            local function decorateRageCard(f,page,height)
                if not f then return end
                if not (page==rageCamPage or page==rageOrbitPage or page==rageCombatPage or page==pages.ragepresets) then return end
                local wash=Instance.new("Frame")
                wash.Name="RageCardWash"
                wash.Parent=f
                wash.Position=UDim2.fromOffset(10,8)
                wash.Size=UDim2.new(1,-74,0,12)
                wash.BackgroundTransparency=.16
                wash.BorderSizePixel=0
                wash.ZIndex=0
                role(wash,"lightBg")
                corner(wash,999)
                local washGrad=Instance.new("UIGradient",wash)
                washGrad.Transparency=NumberSequence.new({
                    NumberSequenceKeypoint.new(0,.18),
                    NumberSequenceKeypoint.new(.82,.52),
                    NumberSequenceKeypoint.new(1,1)
                })
                local bubble=Instance.new("Frame")
                bubble.Name="RageCardBubble"
                bubble.Parent=f
                bubble.Size=UDim2.fromOffset(42,12)
                bubble.Position=UDim2.new(1,-54,0,8)
                bubble.BorderSizePixel=0
                bubble.ZIndex=0
                role(bubble,"lightBg")
                corner(bubble,999)
                stroke(bubble,pal().line or pal().stroke or T.stroke,.52,1)
                for i=0,2 do
                    local dot=Instance.new("Frame")
                    dot.Name="RageDot"..tostring(i+1)
                    dot.Parent=bubble
                    dot.Size=UDim2.fromOffset(6,6)
                    dot.Position=UDim2.fromOffset(8+i*11,3)
                    dot.BorderSizePixel=0
                    dot.ZIndex=1
                    role(dot,(i==1) and "hotBg" or "panel")
                    corner(dot,999)
                end
                local accent=Instance.new("Frame")
                accent.Name="RageAccent"
                accent.Parent=f
                accent.Size=UDim2.fromOffset(5, math.clamp((height or 48)-16, 24, 48))
                accent.Position=UDim2.fromOffset(8,8)
                accent.BorderSizePixel=0
                accent.ZIndex=0
                role(accent,"hotBg")
                corner(accent,999)
            end

            local function card(page,height)
                order[page]=(order[page] or 0)+1
                local p=pal()
                local f=Instance.new("Frame")
                f.Parent=page
                f.LayoutOrder=order[page]
                f.Size=UDim2.new(1,-6,0,height)
                f.BackgroundColor3=p.panel or T.panel
                f.BorderSizePixel=0

                -- Exact page ownership. Later cleanup code must never mistake a
                -- RAGE ON/OFF card for a Whitelist player toggle.
                if page==rageCamPage then
                    f:SetAttribute("KimqSection","ragecam")
                elseif page==rageOrbitPage then
                    f:SetAttribute("KimqSection","rageorbit")
                elseif page==rageCombatPage then
                    f:SetAttribute("KimqSection","ragecombat")
                elseif page==pages.ragepresets then
                    f:SetAttribute("KimqSection","ragepresets")
                end

                role(f,"panel")
                corner(f,14)
                stroke(f,p.line or p.stroke or T.stroke,.22,1)
                decorateRageCard(f,page,height)
                return f
            end

            local function label(parent,text,size,pos,font,textSize,color,align)
                local p=pal()
                local l=textLabel(
                    parent,text,size,pos,
                    font or Enum.Font.Gotham,
                    textSize or 11,
                    color or p.text or T.text,
                    align or Enum.TextXAlignment.Left
                )
                return l
            end

            local function button(parent,text,pos,size,fn)
                local p=pal()
                local b=Instance.new("TextButton")
                b.Parent=parent
                b.Position=pos
                b.Size=size
                b.BackgroundColor3=p.soft or p.bg2 or T.bg2
                b.BorderSizePixel=0
                b.Text=text
                b.TextColor3=p.hot or T.hot
                b.Font=Enum.Font.GothamSemibold
                b.TextSize=11
                b.AutoButtonColor=false
                role(b,"lightBg")
                corner(b,9)
                stroke(b,p.line or p.stroke or T.stroke,.28,1)
                b.MouseButton1Click:Connect(function()
                    local ok,err=pcall(fn)
                    if not ok then warn("[Kimqetras HC v2.67 RAGE button] "..tostring(err)) end
                end)
                return b
            end

            local function makeToggle(page,text,default,fn)
                local state=not not default
                local c=card(page,48)
                role(label(c,text,UDim2.new(1,-82,1,0),UDim2.fromOffset(12,0),Enum.Font.GothamSemibold,12,pal().text or T.text),"textText")
                local b
                local function paint()
                    b.Text=state and "ON" or "OFF"
                    if state then
                        b.BackgroundColor3=pal().hot or T.hot
                        b.TextColor3=pal().white or Color3.new(1,1,1)
                        b:SetAttribute("KimqV26Role","hotBg")
                    else
                        b.BackgroundColor3=pal().soft or pal().bg2 or T.bg2
                        b.TextColor3=pal().hot or T.hot
                        b:SetAttribute("KimqV26Role","lightBg")
                    end
                end
                local function setState(v,fireCallback)
                    state=not not v
                    paint()
                    if fireCallback~=false then fn(state) end
                end
                b=button(c,state and "ON" or "OFF",UDim2.new(1,-68,.5,-15),UDim2.fromOffset(56,30),function()
                    setState(not state,true)
                end)
                setState(state,true)
                return b,setState
            end

            local function makeSlider(page,text,minV,maxV,default,fn,formatFn)
                local c=card(page,64)
                role(label(c,text,UDim2.new(.66,-12,0,24),UDim2.fromOffset(12,5),Enum.Font.GothamSemibold,12,pal().text or T.text),"textText")
                local valueLabel=role(label(c,"",UDim2.new(.34,-12,0,24),UDim2.new(.66,0,0,5),Enum.Font.Gotham,10,pal().sub or T.sub,Enum.TextXAlignment.Right),"subText")

                local track=Instance.new("Frame")
                track.Parent=c
                track.Position=UDim2.fromOffset(12,40)
                track.Size=UDim2.new(1,-24,0,9)
                track.BackgroundColor3=pal().soft or T.bg2
                track.BorderSizePixel=0
                track.Active=true
                role(track,"lightBg")
                corner(track,999)

                local fill=Instance.new("Frame")
                fill.Parent=track
                fill.BackgroundColor3=pal().hot or T.hot
                fill.BorderSizePixel=0
                role(fill,"hotBg")
                corner(fill,999)

                local hit=Instance.new("TextButton")
                hit.Parent=track
                hit.Size=UDim2.fromScale(1,1)
                hit.BackgroundTransparency=1
                hit.Text=""
                hit.ZIndex=5

                local value=default
                local function set(v)
                    value=math.clamp(tonumber(v) or default,minV,maxV)
                    fill.Size=UDim2.new((value-minV)/(maxV-minV),0,1,0)
                    valueLabel.Text=formatFn and formatFn(value) or tostring(math.floor(value*100+.5)/100)
                    fn(value)
                end

                local dragging=false
                local function fromX(x)
                    local a=math.clamp((x-track.AbsolutePosition.X)/math.max(track.AbsoluteSize.X,1),0,1)
                    set(minV+(maxV-minV)*a)
                end

                hit.InputBegan:Connect(function(i)
                    if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
                        dragging=true
                        fromX(i.Position.X)
                    end
                end)
                UISR.InputChanged:Connect(function(i)
                    if dragging and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then
                        fromX(i.Position.X)
                    end
                end)
                UISR.InputEnded:Connect(function(i)
                    if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
                        dragging=false
                    end
                end)

                set(default)
                return c,set
            end

            local function makeCycle(page,text,items,default,fn)
                local idx=table.find(items,default) or 1
                local c=card(page,50)
                role(label(c,text,UDim2.new(.46,-12,1,0),UDim2.fromOffset(12,0),Enum.Font.GothamSemibold,12,pal().text or T.text),"textText")
                local b
                local function setValue(v,fireCallback)
                    local found=table.find(items,v)
                    if not found then return false end
                    idx=found
                    if b then b.Text=items[idx] end
                    if fireCallback~=false then fn(items[idx]) end
                    return true
                end
                b=button(c,items[idx],UDim2.new(.46,0,.5,-15),UDim2.new(.54,-12,0,30),function()
                    setValue(items[(idx % #items)+1],true)
                end)
                setValue(items[idx],true)
                return b,setValue
            end


            local function rageIsWhitelisted(pl)
                if not pl then return false end
                local a=rawget(_G,"KHWhitelist")
                local b=rawget(_G,"Whitelist")
                return (type(a)=="table" and a[pl.UserId])==true
                    or (type(b)=="table" and b[pl.UserId])==true
            end

            local function queueLooksDowned(pl)
                local char=pl and pl.Character
                if not char then return true end

                local okKnown,known=false,false
                pcall(function()
                    okKnown=true
                    known=IsKnocked(char)==true
                end)
                if okKnown and known then return true end

                local hum=char:FindFirstChildOfClass("Humanoid")
                if not hum or hum.Health<=0 then return true end

                local names={ko=true,["k.o"]=true,knocked=true,downed=true,dead=true,unconscious=true}
                for _,d in ipairs(char:GetDescendants()) do
                    if names[d.Name:lower()] then
                        if d:IsA("BoolValue") and d.Value then return true end
                        if (d:IsA("IntValue") or d:IsA("NumberValue")) and d.Value~=0 then return true end
                    end
                end
                return false
            end

            local function queueCandidateAllowed(pl)
                if not pl or pl==lp or pl.Parent~=PlayersR then return false end
                if queueSkipWhitelisted and rageIsWhitelisted(pl) then return false end
                if queueSkipDowned and queueLooksDowned(pl) then return false end
                return true
            end

            local function targetDistanceFromLocal(pl)
                local mine=lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
                local theirs=pl and pl.Character and pl.Character:FindFirstChild("HumanoidRootPart")
                if not mine or not theirs then return math.huge end
                return (mine.Position-theirs.Position).Magnitude
            end

            local function targetHealth(pl)
                local hum=pl and pl.Character and pl.Character:FindFirstChildOfClass("Humanoid")
                return hum and hum.Health or math.huge
            end

            local function currentId()
                if #queue==0 then return nil end
                currentIndex=math.clamp(currentIndex,1,#queue)
                return queue[currentIndex]
            end

            local function currentPlayer()
                local id=currentId()
                return id and PlayersR:GetPlayerByUserId(id) or nil
            end

            local function queueIndex(id)
                for i,v in ipairs(queue) do
                    if v==id then return i end
                end
            end

            local function queueText()
                local pl=currentPlayer()
                if not pl then
                    return #queue==0 and "No targets selected" or ("Target unavailable • "..#queue.." queued")
                end
                return tostring(currentIndex).."/"..tostring(#queue).." • "..pl.DisplayName.."  (@"..pl.Name..")"
            end

            local function refreshSelected()
                local txt=queueText()
                for _,l in ipairs(selectedLabels) do
                    if l and l.Parent then l.Text=txt end
                end
            end

            local refreshPlayerList
            local applyQueueOrdering
            local function removeId(id)
                local idx=queueIndex(id)
                if not idx then return end
                queued[id]=nil
                table.remove(queue,idx)
                if #queue==0 then
                    currentIndex=1
                elseif currentIndex>#queue then
                    currentIndex=1
                elseif idx<currentIndex then
                    currentIndex-=1
                end
                refreshSelected()
                if refreshPlayerList then refreshPlayerList() end
            end

            local function togglePlayer(pl)
                if not pl or pl==lp then return end
                if queued[pl.UserId] then
                    removeId(pl.UserId)
                else
                    queued[pl.UserId]=true
                    table.insert(queue,pl.UserId)
                    refreshSelected()
                    if refreshPlayerList then refreshPlayerList() end
                end
            end

            local function swapQueue(a,b)
                if not queue[a] or not queue[b] then return false end
                queue[a],queue[b]=queue[b],queue[a]
                return true
            end

            local function shuffleQueue()
                for i=#queue,2,-1 do
                    local j=math.random(1,i)
                    queue[i],queue[j]=queue[j],queue[i]
                end
            end

            applyQueueOrdering=function(forceRandom)
                if #queue<=1 then
                    refreshSelected()
                    if refreshPlayerList then refreshPlayerList() end
                    return
                end

                local keep=currentId()
                if queueOrderMode=="Closest" then
                    table.sort(queue,function(a,b)
                        return targetDistanceFromLocal(PlayersR:GetPlayerByUserId(a))
                            < targetDistanceFromLocal(PlayersR:GetPlayerByUserId(b))
                    end)
                elseif queueOrderMode=="Lowest Health" then
                    table.sort(queue,function(a,b)
                        local pa=PlayersR:GetPlayerByUserId(a)
                        local pb=PlayersR:GetPlayerByUserId(b)
                        local ah,bh=targetHealth(pa),targetHealth(pb)
                        if math.abs(ah-bh)<.001 then
                            return targetDistanceFromLocal(pa)<targetDistanceFromLocal(pb)
                        end
                        return ah<bh
                    end)
                elseif queueOrderMode=="Random" and forceRandom then
                    shuffleQueue()
                end

                local keepIndex=keep and queueIndex(keep)
                if keepIndex then currentIndex=keepIndex else currentIndex=math.clamp(currentIndex,1,#queue) end
                refreshSelected()
                if refreshPlayerList then refreshPlayerList() end
            end

            local function seekNextAllowed(step)
                if #queue==0 then return false end
                step=step or 1
                local start=currentIndex
                for _=1,#queue do
                    currentIndex=((currentIndex-1+step)%#queue)+1
                    local pl=PlayersR:GetPlayerByUserId(queue[currentIndex])
                    if queueCandidateAllowed(pl) then return true end
                end
                currentIndex=start
                return false
            end

            local function advance(removeCurrent)
                local id=currentId()
                if removeCurrent and id then
                    removeId(id)
                    if #queue>0 then
                        applyQueueOrdering(queueOrderMode=="Random")
                        if not queueCandidateAllowed(currentPlayer()) then seekNextAllowed(1) end
                    end
                    refreshSelected()
                    if refreshPlayerList then refreshPlayerList() end
                    return
                end

                if #queue>1 then
                    if queueOrderMode=="Closest" or queueOrderMode=="Lowest Health" then
                        applyQueueOrdering(false)
                    end
                    seekNextAllowed(1)
                end
                refreshSelected()
                if refreshPlayerList then refreshPlayerList() end
            end

            local function previousTarget()
                if #queue>1 then seekNextAllowed(-1) end
                refreshSelected()
                if refreshPlayerList then refreshPlayerList() end
            end

            local function moveCurrentInQueue(delta)
                if queueOrderMode~="Manual" or #queue<2 then return false end
                local nextIndex=math.clamp(currentIndex+delta,1,#queue)
                if nextIndex==currentIndex then return false end
                if swapQueue(currentIndex,nextIndex) then
                    currentIndex=nextIndex
                    refreshSelected()
                    if refreshPlayerList then refreshPlayerList() end
                    return true
                end
                return false
            end

            local function getPart(pl,choice)
                local char=pl and pl.Character
                if not char then return nil end
                if choice=="Closest Part" then
                    local mouse=UISR:GetMouseLocation()
                    local best,bestD=nil,math.huge
                    for _,n in ipairs({"Head","UpperTorso","LowerTorso","HumanoidRootPart","LeftUpperArm","RightUpperArm","LeftUpperLeg","RightUpperLeg"}) do
                        local p=char:FindFirstChild(n)
                        if p and p:IsA("BasePart") then
                            local v,on=workspace.CurrentCamera:WorldToViewportPoint(p.Position)
                            if on then
                                local d=(Vector2.new(v.X,v.Y)-mouse).Magnitude
                                if d<bestD then bestD=d; best=p end
                            end
                        end
                    end
                    return best or char:FindFirstChild("HumanoidRootPart")
                end
                return char:FindFirstChild(choice)
                    or char:FindFirstChild("HumanoidRootPart")
                    or char:FindFirstChild("Head")
            end

            local function clearPreview()
                if previewPoseConn then
                    pcall(function() previewPoseConn:Disconnect() end)
                    previewPoseConn=nil
                end
                if not previewViewport then return end
                previewToken+=1
                for _,ch in ipairs(previewViewport:GetChildren()) do
                    if ch:IsA("WorldModel") or ch:IsA("Camera") then
                        pcall(function() ch:Destroy() end)
                    end
                end
                previewViewport.CurrentCamera=nil
            end

            local function resolvePreviewPoseId()
                if previewPoseResolved then return previewPoseResolved end
                local direct="rbxassetid://114788518778194"
                local resolved=direct

                -- If this is a catalog/emote wrapper, extract the real AnimationId.
                local ok,objs=pcall(function()
                    return game:GetObjects(direct)
                end)
                if ok and type(objs)=="table" then
                    for _,obj in ipairs(objs) do
                        local anim=obj:IsA("Animation") and obj
                            or obj:FindFirstChildWhichIsA("Animation",true)
                        if anim and tostring(anim.AnimationId or "")~="" then
                            resolved=tostring(anim.AnimationId)
                            break
                        end
                    end
                    for _,obj in ipairs(objs) do
                        pcall(function() obj:Destroy() end)
                    end
                end

                previewPoseResolved=resolved
                return resolved
            end

            local function makePreviewModel(pl)
                -- Live clone first: layered clothing/custom proportions load better.
                local live=pl and pl.Character
                if live then
                    local oldArch=live.Archivable
                    local clone=nil
                    pcall(function()
                        live.Archivable=true
                        clone=live:Clone()
                    end)
                    pcall(function() live.Archivable=oldArch end)

                    if clone then
                        clone.Name="KimqRagePreviewCharacter"
                        for _,d in ipairs(clone:GetDescendants()) do
                            if d:IsA("Script") or d:IsA("LocalScript") or d:IsA("Tool") then
                                pcall(function() d:Destroy() end)
                            end
                        end
                        return clone
                    end
                end

                -- Fallback with retries.
                for attempt=1,4 do
                    local ok,model=pcall(function()
                        return PlayersR:CreateHumanoidModelFromUserId(pl.UserId)
                    end)
                    if ok and model then
                        model.Name="KimqRagePreviewCharacter"
                        return model
                    end
                    task.wait(.10*attempt)
                end
                return nil
            end

            local function playPreviewPose(model)
                local hum=model and model:FindFirstChildOfClass("Humanoid")
                if not hum then return nil end

                -- The supplied pose is an R15 pose. R6/custom rigs stay in their
                -- normal standing pose instead of being stretched apart.
                if hum.RigType~=Enum.HumanoidRigType.R15 then
                    return nil
                end

                local animator=hum:FindFirstChildOfClass("Animator")
                if not animator then
                    animator=Instance.new("Animator")
                    animator.Parent=hum
                end

                pcall(function()
                    for _,tr in ipairs(animator:GetPlayingAnimationTracks()) do
                        tr:Stop(0)
                    end
                end)

                local anim=Instance.new("Animation")
                anim.AnimationId=resolvePreviewPoseId()
                local ok,track=pcall(function()
                    return animator:LoadAnimation(anim)
                end)
                anim:Destroy()

                if ok and track then
                    pcall(function()
                        track.Looped=true
                        track.Priority=Enum.AnimationPriority.Action4
                        track:Play(.08,1,1)
                    end)
                    return track
                end
                return nil
            end

            local function resetPreviewPose(model,track)
                if track then
                    pcall(function() track:Stop(.05) end)
                end
                if model then
                    for _,d in ipairs(model:GetDescendants()) do
                        if d:IsA("Motor6D") then
                            pcall(function() d.Transform=CFrame.new() end)
                        end
                    end
                end
            end

            local function previewPoseLooksBroken(model,baseSize,posedSize)
                if not model or not baseSize or not posedSize then return false end

                -- Large growth usually means the animation is incompatible with
                -- that avatar/package.
                if posedSize.X>math.max(baseSize.X*1.85,baseSize.X+4)
                    or posedSize.Y>math.max(baseSize.Y*1.55,baseSize.Y+4)
                    or posedSize.Z>math.max(baseSize.Z*2.0,baseSize.Z+5)
                then
                    return true
                end

                local root=model:FindFirstChild("HumanoidRootPart")
                if root then
                    local limit=math.max(baseSize.Magnitude*1.35,12)
                    for _,d in ipairs(model:GetDescendants()) do
                        if d:IsA("BasePart") and (d.Position-root.Position).Magnitude>limit then
                            return true
                        end
                    end
                end
                return false
            end

            local function normalizePreviewFacing(model)
                local root=model and model:FindFirstChild("HumanoidRootPart")
                if not root then return end

                -- Identity yaw faces the preview camera which is placed on -Z.
                pcall(function()
                    local targetRoot=CFrame.new(0,root.Position.Y,0)
                    local delta=targetRoot*root.CFrame:Inverse()
                    model:PivotTo(delta*model:GetPivot())
                end)
            end

            local function placePreviewFeet(model)
                local ok,cf,size=pcall(function()
                    return model:GetBoundingBox()
                end)
                if not ok then return nil,nil end

                local bottom=cf.Position.Y-(size.Y*.5)
                pcall(function()
                    model:PivotTo(
                        CFrame.new(-cf.Position.X,-bottom+.08,-cf.Position.Z)
                        * model:GetPivot()
                    )
                end)

                local ok2,cf2,size2=pcall(function()
                    return model:GetBoundingBox()
                end)
                if ok2 then return cf2,size2 end
                return cf,size
            end

            local function fitPreviewCamera(cam,cf,size)
                if not cam or not cf or not size then return end

                local vfov=math.rad(cam.FieldOfView)
                local abs=previewViewport and previewViewport.AbsoluteSize or Vector2.new(1,1)
                local aspect=math.max(abs.X/math.max(abs.Y,1),.45)
                local tanV=math.tan(vfov*.5)
                local tanH=tanV*aspect

                local fitHeight=size.Y/(2*math.max(tanV,.01))
                local fitWidth=math.max(size.X,size.Z*.70)/(2*math.max(tanH,.01))
                local dist=math.clamp(math.max(fitHeight,fitWidth)*1.27,7,40)

                local focus=Vector3.new(0,math.max(size.Y*.47,1.45),0)
                cam.CFrame=CFrame.lookAt(
                    Vector3.new(0,focus.Y,-dist),
                    focus,
                    Vector3.new(0,1,0)
                )
            end

            local function showPreview(pl)
                if not previewViewport or not previewViewport.Parent then return end
                clearPreview()
                previewToken+=1
                local token=previewToken

                if not pl then
                    previewTitle.Text="Hover a player"
                    return
                end

                previewTitle.Text="loading "..pl.DisplayName.."..."

                task.spawn(function()
                    local model=makePreviewModel(pl)
                    if not model or token~=previewToken or not previewViewport or not previewViewport.Parent then
                        if model then pcall(function() model:Destroy() end) end
                        if token==previewToken and previewTitle and previewTitle.Parent then
                            previewTitle.Text="hover again • preview didn't load"
                        end
                        return
                    end

                    previewTitle.Text=pl.DisplayName.."  •  @"..pl.Name

                    local world=Instance.new("WorldModel")
                    world.Name="KimqRagePreviewWorld"
                    world.Parent=previewViewport
                    model.Parent=world

                    local root=model:FindFirstChild("HumanoidRootPart")
                    for _,d in ipairs(model:GetDescendants()) do
                        if d:IsA("BasePart") then
                            d.CanCollide=false
                            d.CastShadow=false
                            d.Massless=true
                            d.Anchored=(d==root)
                        elseif d:IsA("Humanoid") then
                            pcall(function()
                                d.DisplayDistanceType=Enum.HumanoidDisplayDistanceType.None
                                d.AutoRotate=false
                            end)
                        end
                    end

                    normalizePreviewFacing(model)
                    local cf,size=placePreviewFeet(model)
                    if not cf or not size then
                        pcall(function() world:Destroy() end)
                        return
                    end

                    local p=pal()

                    local platform=Instance.new("Part")
                    platform.Name="KimqRagePreviewPlatform"
                    platform.Shape=Enum.PartType.Cylinder
                    platform.Size=Vector3.new(.30,5.6,5.6)
                    platform.Material=Enum.Material.SmoothPlastic
                    platform.Color=p.soft or T.bg2
                    platform.Transparency=.04
                    platform.Anchored=true
                    platform.CanCollide=false
                    platform.CastShadow=false
                    platform.CFrame=CFrame.new(0,-.14,0)*CFrame.Angles(0,0,math.rad(90))
                    platform.Parent=world

                    local ring=Instance.new("Part")
                    ring.Name="KimqRagePreviewRing"
                    ring.Shape=Enum.PartType.Cylinder
                    ring.Size=Vector3.new(.08,6.05,6.05)
                    ring.Material=Enum.Material.Neon
                    ring.Color=p.hot or T.hot
                    ring.Transparency=.12
                    ring.Anchored=true
                    ring.CanCollide=false
                    ring.CastShadow=false
                    ring.CFrame=CFrame.new(0,.025,0)*CFrame.Angles(0,0,math.rad(90))
                    ring.Parent=world

                    local baseSize=size
                    local poseTrack=playPreviewPose(model)

                    -- Let the requested pose change the bounds, then validate it.
                    task.wait(.12)
                    if token~=previewToken or not model.Parent then return end
                    normalizePreviewFacing(model)
                    local posedCF,posedSize=placePreviewFeet(model)

                    if poseTrack and previewPoseLooksBroken(model,baseSize,posedSize) then
                        -- Graceful fallback: incompatible avatars show normally instead
                        -- of exploding/stretching across the preview.
                        resetPreviewPose(model,poseTrack)
                        task.wait(.06)
                        normalizePreviewFacing(model)
                        cf,size=placePreviewFeet(model)
                    else
                        cf,size=posedCF,posedSize
                    end

                    local cam=Instance.new("Camera")
                    cam.Name="KimqRagePreviewCamera"
                    cam.FieldOfView=27
                    cam.Parent=previewViewport
                    previewViewport.CurrentCamera=cam
                    fitPreviewCamera(cam,cf,size)

                    -- Keep the platform/ring synced to the live GUI theme.
                    -- Do NOT force the avatar root every frame; that was able to fight
                    -- certain animation rigs and make limbs look broken.
                    local themeClock=0
                    previewPoseConn=RunServiceR.RenderStepped:Connect(function(dt)
                        if token~=previewToken or not world.Parent then return end

                        themeClock+=dt
                        if themeClock>=.15 then
                            themeClock=0
                            local live=pal()
                            if platform and platform.Parent then
                                platform.Color=live.soft or live.bg2 or T.bg2
                            end
                            if ring and ring.Parent then
                                ring.Color=live.hot or T.hot
                            end
                        end
                    end)
                end)
            end

            local function restoreCamera()
                viewEnabled=false
                viewDragging=false
                local cam=workspace.CurrentCamera
                if cam then
                    pcall(function()
                        cam.CameraType=viewPreviousType or Enum.CameraType.Custom
                    end)
                    local hum=lp.Character and lp.Character:FindFirstChildOfClass("Humanoid")
                    pcall(function()
                        cam.CameraSubject=hum or viewPreviousSubject
                    end)
                end

                pcall(function()
                    if viewPreviousMouseBehavior~=nil then
                        UISR.MouseBehavior=viewPreviousMouseBehavior
                    else
                        UISR.MouseBehavior=Enum.MouseBehavior.Default
                    end
                    if viewPreviousMouseIcon~=nil then
                        UISR.MouseIconEnabled=viewPreviousMouseIcon
                    end
                end)

                viewPreviousType=nil
                viewPreviousSubject=nil
                viewPreviousMouseBehavior=nil
                viewPreviousMouseIcon=nil
            end

            local function localCameraRestore()
                local cam=workspace.CurrentCamera
                local hum=lp.Character and lp.Character:FindFirstChildOfClass("Humanoid")
                if cam then
                    pcall(function()
                        cam.CameraType=Enum.CameraType.Custom
                        if hum then cam.CameraSubject=hum end
                    end)
                end
            end

            local function stopStableLock()
                camEnabled=false
                rageLockOffset=nil
                rageLockTargetId=nil
                rageLockDeadLatch=false
                localCameraRestore()
            end

            local function captureStableOffset(pl)
                local cam=workspace.CurrentCamera
                local part=getPart(pl,camPart)
                if not cam or not part then return nil end

                local delta=cam.CFrame.Position-part.Position
                local mag=delta.Magnitude

                -- If RAGE orbit put the local camera almost inside the target (or
                -- extremely far away), derive one clean offset from the CURRENT
                -- viewing direction. Once captured, it never rotates with orbit.
                if mag<6 or mag>34 then
                    local back=-cam.CFrame.LookVector
                    if back.Magnitude<.1 then back=Vector3.new(0,0,1) end
                    delta=back.Unit*12 + Vector3.new(0,2.4,0)
                end
                return delta
            end

            local function startStableLock(pl)
                if not pl then return false end
                if viewEnabled then restoreCamera() end

                local cam=workspace.CurrentCamera
                local part=getPart(pl,camPart)
                if not cam or not part then return false end

                rageLockOffset=captureStableOffset(pl) or Vector3.new(0,2.4,12)
                rageLockTargetId=pl.UserId
                rageLockDeadLatch=false
                camEnabled=true

                pcall(function()
                    cam.CameraType=Enum.CameraType.Scriptable
                    local pos=part.Position+rageLockOffset
                    cam.CFrame=CFrame.lookAt(pos,part.Position,Vector3.yAxis)
                end)
                return true
            end

            local function startFreeView(pl)
                local hum=pl and pl.Character and pl.Character:FindFirstChildOfClass("Humanoid")
                local cam=workspace.CurrentCamera
                if not hum or not cam then return false end

                if camEnabled then stopStableLock() end
                if not viewEnabled then
                    viewPreviousType=cam.CameraType
                    viewPreviousSubject=cam.CameraSubject
                    viewPreviousMouseBehavior=UISR.MouseBehavior
                    viewPreviousMouseIcon=UISR.MouseIconEnabled
                end

                -- Use Roblox's native Custom camera on the target as the subject.
                -- The target only supplies the focus point; YOU retain normal mouse
                -- camera control.
                viewEnabled=true
                cam.CameraType=Enum.CameraType.Custom
                cam.CameraSubject=hum

                pcall(function()
                    UISR.MouseBehavior=Enum.MouseBehavior.Default
                    UISR.MouseIconEnabled=true
                end)
                return true
            end

            -- RMB drag = rotate, wheel = zoom.
            UISR.InputBegan:Connect(function(input,gpe)
                if not viewEnabled or gpe then return end
                if input.UserInputType==Enum.UserInputType.MouseButton2 then
                    viewDragging=true
                end
            end)

            UISR.InputEnded:Connect(function(input)
                if input.UserInputType==Enum.UserInputType.MouseButton2 then
                    viewDragging=false
                end
            end)

            UISR.InputChanged:Connect(function(input,gpe)
                if not viewEnabled or gpe then return end
                if input.UserInputType==Enum.UserInputType.MouseMovement and viewDragging then
                    viewYaw-=input.Delta.X*.0065
                    viewPitch=math.clamp(viewPitch-input.Delta.Y*.0065,-1.18,1.18)
                elseif input.UserInputType==Enum.UserInputType.MouseWheel then
                    viewDistance=math.clamp(viewDistance-input.Position.Z*1.35,4,38)
                end
            end)

            local function teleportTo(pl,close)
                local tr=pl and pl.Character and pl.Character:FindFirstChild("HumanoidRootPart")
                local char=lp.Character
                local mr=char and char:FindFirstChild("HumanoidRootPart")
                if not (tr and char and mr) then return false end

                local offset
                if close then
                    offset=tr.CFrame.LookVector*2.2+Vector3.new(0,1.2,0)
                else
                    offset=Vector3.new(0,math.max(orbitHeight,3),math.max(orbitRadius,4))
                end

                local pos=tr.Position+offset
                char:PivotTo(CFrame.lookAt(pos,tr.Position))
                mr.AssemblyLinearVelocity=Vector3.zero
                mr.AssemblyAngularVelocity=Vector3.zero
                return true
            end

            local function rageFindGun()
                local char=lp.Character
                local hum=char and char:FindFirstChildOfClass("Humanoid")
                if not char or not hum then return nil end

                local equipped=char:FindFirstChildOfClass("Tool")
                if equipped and table.find(ForceHitAllowedTools,equipped.Name) then
                    return equipped
                end

                local backpack=lp:FindFirstChildOfClass("Backpack")
                if backpack then
                    for _,name in ipairs(ForceHitAllowedTools) do
                        local tool=backpack:FindFirstChild(name)
                        if tool and tool:IsA("Tool") then
                            pcall(function() hum:EquipTool(tool) end)
                            return tool
                        end
                    end
                end
                return nil
            end

            local function pressKey(keyCode,virtualKey)
                if VIMR then
                    pcall(function()
                        VIMR:SendKeyEvent(true,keyCode,false,game)
                        task.wait(.035)
                        VIMR:SendKeyEvent(false,keyCode,false,game)
                    end)
                    return
                end
                if type(keypress)=="function" then
                    pcall(keypress,virtualKey)
                    task.wait(.035)
                    if type(keyrelease)=="function" then
                        pcall(keyrelease,virtualKey)
                    end
                end
            end

            local ammoNames={"Clip","Magazine","Mag","CurrentAmmo","Ammo","Bullets"}
            local function readAmmoCount(tool)
                if not tool then return nil end

                for _,name in ipairs(ammoNames) do
                    local obj=tool:FindFirstChild(name,true)
                    if obj then
                        if obj:IsA("IntValue") or obj:IsA("NumberValue") then
                            return tonumber(obj.Value)
                        elseif obj:IsA("StringValue") then
                            local n=tonumber(tostring(obj.Value):match("%-?%d+%.?%d*"))
                            if n~=nil then return n end
                        end
                    end

                    local attr=nil
                    pcall(function() attr=tool:GetAttribute(name) end)
                    if type(attr)=="number" then
                        return attr
                    end
                end
                return nil
            end

            local function requestReload(tool)
                if not tool then return end

                -- Normal R key path first, so games that own their reload input
                -- continue to run their usual client animation/state.
                pressKey(Enum.KeyCode.R,0x52)

                -- Protected game-specific fallback used by the same MainEvent family
                -- as this script's existing ForceHit path. If unsupported, it simply
                -- does nothing and the R-key path remains the only behavior.
                local mainEvent=ReplicatedStorageR:FindFirstChild("MainEvent")
                if mainEvent and mainEvent:IsA("RemoteEvent") then
                    pcall(function()
                        mainEvent:FireServer("Reload",tool)
                    end)
                end
            end

            local function tryAutoReload(tool)
                if not autoReload or not tool then return false end

                local ammo=readAmmoCount(tool)
                if ammo==nil or ammo>0 then return false end

                local now=os.clock()
                if reloadBusy or now-lastReloadAt<.65 then
                    return true
                end

                reloadBusy=true
                lastReloadAt=now
                task.spawn(function()
                    requestReload(tool)

                    -- Stay in the reload state until ammo comes back or the normal
                    -- reload window has had enough time to finish.
                    local deadline=os.clock()+3.0
                    repeat
                        task.wait(.10)
                        if not tool.Parent then break end
                        local current=readAmmoCount(tool)
                        if current==nil or current>0 then break end
                    until os.clock()>=deadline

                    reloadBusy=false
                end)
                return true
            end


            local rageWeaponProfiles={
                ["[Revolver]"]={Name="Precision",Delay=.13,Part="Head"},
                ["[DoubleBarrel]"]={Name="Heavy Burst",Delay=.18,Part="UpperTorso"},
                ["[Shotgun]"]={Name="Shotgun",Delay=.16,Part="UpperTorso"},
                ["[TacticalShotgun]"]={Name="Tactical",Delay=.12,Part="UpperTorso"},
                ["[SMG]"]={Name="Rapid",Delay=.055,Part="UpperTorso"},
                ["[Silencer]"]={Name="Fast Precision",Delay=.075,Part="Head"},
            }

            local function profileForTool(tool)
                if not autoWeaponProfiles or not tool then return nil end
                return rageWeaponProfiles[tool.Name]
            end

            local function effectiveHitPart(tool)
                local profile=profileForTool(tool)
                return profile and profile.Part or hitPart
            end

            local function effectiveShootDelay()
                local tool=lp.Character and lp.Character:FindFirstChildOfClass("Tool")
                local profile=profileForTool(tool)
                return profile and profile.Delay or shootDelay
            end

            local function forceHit(pl,count)
                if not pl then return false end
                local tool=rageFindGun()
                if not tool then return false end
                if tryAutoReload(tool) then return false end

                local n=math.clamp(math.floor(count or 1),1,12)
                task.spawn(function()
                    pcall(function() tool:Activate() end)
                    task.wait(.012)

                    for i=1,n do
                        local part=getPart(pl,effectiveHitPart(tool))
                        if not part then break end
                        pcall(ForceHit_Fire,part)

                        -- Every other packet also tries torso. This helps when a custom
                        -- head/accessory setup makes a head-only packet unreliable.
                        if i%2==0 and pl.Character then
                            local torso=pl.Character:FindFirstChild("UpperTorso")
                                or pl.Character:FindFirstChild("Torso")
                                or pl.Character:FindFirstChild("HumanoidRootPart")
                            if torso then pcall(ForceHit_Fire,torso) end
                        end

                        if i<n then task.wait(.008) end
                    end
                end)
                return true
            end

            local function tryEquipRageWings()
                if os.clock()-lastWingTry<1.25 then return end
                lastWingTry=os.clock()

                local char=lp.Character
                if not char or char:FindFirstChild("KimqWornAngelWings") then return end

                -- Protected cross-module call: failure cannot leave RAGE or the main
                -- script in an error state.
                pcall(function()
                    local ctl=_G.KimqWeaponExtrasController
                    if not ctl and type(getgenv)=="function" then
                        ctl=getgenv().KimqWeaponExtrasController
                    end
                    if ctl and type(ctl.EquipItem)=="function" then
                        ctl.EquipItem("Angel Wings")
                    end
                end)
            end

            local function stopOrbitAnimation()
                if orbitAnimTrack then
                    pcall(function() orbitAnimTrack:Stop(.12) end)
                end
                orbitAnimTrack=nil
            end

            local function startOrbitAnimation()
                stopOrbitAnimation()
                local hum=lp.Character and lp.Character:FindFirstChildOfClass("Humanoid")
                if not hum then return end
                local animator=hum:FindFirstChildOfClass("Animator")
                if not animator then
                    animator=Instance.new("Animator")
                    animator.Parent=hum
                end

                local anim=Instance.new("Animation")
                anim.AnimationId="rbxassetid://100607985396998"
                local ok,track=pcall(function()
                    return animator:LoadAnimation(anim)
                end)
                anim:Destroy()
                if ok and track then
                    orbitAnimTrack=track
                    pcall(function()
                        track.Looped=true
                        track.Priority=Enum.AnimationPriority.Action
                        track:Play(.12,1,1)
                    end)
                end
            end

            local function restoreOrbitHumanoid()
                if orbitHumanoid and orbitHumanoid.Parent then
                    pcall(function()
                        if orbitOldPlatformStand~=nil then
                            orbitHumanoid.PlatformStand=orbitOldPlatformStand
                        end
                        if orbitOldAutoRotate~=nil then
                            orbitHumanoid.AutoRotate=orbitOldAutoRotate
                        end
                    end)
                end
                orbitHumanoid=nil
                orbitOldPlatformStand=nil
                orbitOldAutoRotate=nil
            end

            local function stopOrbitMotion()
                if orbitMotionConn then
                    pcall(function() orbitMotionConn:Disconnect() end)
                    orbitMotionConn=nil
                end
                restoreOrbitHumanoid()
            end

            local function startOrbitMotion()
                if orbitMotionConn then return end

                orbitMotionConn=RunServiceR.Heartbeat:Connect(function(dt)
                    local ok,err=pcall(function()
                        if not (orbitEnabled or autoHunt) then return end
                        -- During the finish phase the stomp routine has exclusive
                        -- ownership of local movement. Never re-enable PlatformStand
                        -- or circle away from the knocked body here.
                        if rageControl.phase=="STOMP" or rageControl.phase=="FINISH" or stompBusy then return end

                        local pl=currentPlayer()
                        if not pl or finishedWaiting[pl.UserId] then return end

                        local tr=pl.Character and pl.Character:FindFirstChild("HumanoidRootPart")
                        local char=lp.Character
                        local mr=char and char:FindFirstChild("HumanoidRootPart")
                        local hum=char and char:FindFirstChildOfClass("Humanoid")
                        if not (tr and char and mr and hum) then return end

                        tryEquipRageWings()
                        if not orbitAnimTrack then startOrbitAnimation() end

                        if orbitHumanoid~=hum then
                            restoreOrbitHumanoid()
                            orbitHumanoid=hum
                            orbitOldPlatformStand=hum.PlatformStand
                            orbitOldAutoRotate=hum.AutoRotate
                        end

                        -- This makes the local movement controller stop fighting the orbit.
                        hum.PlatformStand=true
                        hum.AutoRotate=false

                        local now=os.clock()+antiLockPhase
                        local speedJitter=1
                        local radiusNow=orbitRadius
                        local heightNow=orbitHeight

                        if antiLockEnabled then
                            speedJitter=1
                                + math.sin(now*7.3)*(.12*antiLockStrength)
                                + math.sin(now*13.9)*(.05*antiLockStrength)
                            radiusNow=math.max(2.5,
                                orbitRadius
                                + math.sin(now*8.8)*(.70*antiLockStrength)
                                + math.sin(now*17.1)*(.28*antiLockStrength)
                            )
                            heightNow=
                                orbitHeight
                                + math.sin(now*6.7)*(.85*antiLockStrength)
                                + math.sin(now*14.4)*(.30*antiLockStrength)
                        end

                        orbitAngle=(
                            orbitAngle
                            + dt*math.max(orbitSpeed,.05)*math.pi*2*math.max(speedJitter,.25)
                        )%(math.pi*2)

                        local focus=tr.Position+Vector3.new(0,1.45,0)
                        local pos=Vector3.new(
                            tr.Position.X+math.cos(orbitAngle)*radiusNow,
                            tr.Position.Y+heightNow,
                            tr.Position.Z+math.sin(orbitAngle)*radiusNow
                        )
                        local wanted=CFrame.lookAt(pos,focus)

                        char:PivotTo(wanted)
                        mr.CFrame=wanted

                        if antiLockEnabled then
                            -- Replicate a plausible, changing tangent velocity instead
                            -- of a permanently-zero prediction vector.
                            local tangent=Vector3.new(
                                -math.sin(orbitAngle),
                                0,
                                math.cos(orbitAngle)
                            )
                            local vel=math.min(95,math.max(12,orbitSpeed*radiusNow*2.4))
                            mr.AssemblyLinearVelocity=
                                tangent*vel
                                + Vector3.new(0,math.sin(now*12.3)*7*antiLockStrength,0)
                        else
                            mr.AssemblyLinearVelocity=Vector3.zero
                        end
                        mr.AssemblyAngularVelocity=Vector3.zero
                    end)

                    if not ok then
                        warn("[Kimqetras HC v2.67 RAGE orbit] "..tostring(err))
                    end
                end)
            end

            local function ensureGunEquipped()
                return rageFindGun()
            end

            local function normalGunShoot(pl)
                local tool=ensureGunEquipped()
                if not tool then return false end
                if tryAutoReload(tool) then return false end

                local part=getPart(pl,effectiveHitPart(tool))
                if not part then return false end

                -- Never move or lock the user's actual mouse. The equipped tool is
                -- activated normally while the existing targeted Shoot path supplies
                -- the selected target.
                pcall(function() tool:Activate() end)
                pcall(ForceHit_Fire,part)
                return true
            end

            local function rageShoot(pl)
                if not pl then return end
                if combatMode=="One Shot" then
                    -- Stronger multi-packet path. Server-side damage rules still win.
                    forceHit(pl,burstCount)
                else
                    normalGunShoot(pl)
                end
            end

            local function pressE()
                pressKey(Enum.KeyCode.E,0x45)
            end

            local function pressStomp()
                -- Keep the real E input because that is the game's normal stomp path.
                pressE()

                -- Protected fallback for the same game family. This is intentionally
                -- isolated to the stomp routine so no other script behavior changes.
                local mainEvent=ReplicatedStorageR:FindFirstChild("MainEvent")
                if mainEvent and mainEvent:IsA("RemoteEvent") then
                    pcall(function()
                        mainEvent:FireServer("Stomp")
                    end)
                end
            end

            local function placeOnTopForStomp(pl)
                local targetChar=pl and pl.Character
                local targetRoot=targetChar and (
                    targetChar:FindFirstChild("HumanoidRootPart")
                    or targetChar:FindFirstChild("UpperTorso")
                    or targetChar:FindFirstChild("Torso")
                    or targetChar:FindFirstChild("LowerTorso")
                )

                local char=lp.Character
                local myRoot=char and char:FindFirstChild("HumanoidRootPart")
                local hum=char and char:FindFirstChildOfClass("Humanoid")
                if not (targetRoot and char and myRoot and hum) then return false end

                -- Orbit uses PlatformStand so the movement controller cannot fight it.
                -- A stomp needs the opposite: stand upright directly over the body.
                pcall(function()
                    hum.PlatformStand=false
                    hum.Sit=false
                    hum.AutoRotate=true
                end)

                local forward=Vector3.new(myRoot.CFrame.LookVector.X,0,myRoot.CFrame.LookVector.Z)
                if forward.Magnitude<.05 then
                    forward=Vector3.new(0,0,-1)
                else
                    forward=forward.Unit
                end

                -- Directly above the target instead of 2.2 studs beside them.
                -- Keeping this world-up offset also works when the knocked body is tilted.
                local pos=targetRoot.Position+Vector3.new(0,3.0,0)
                local wanted=CFrame.lookAt(pos,pos+forward)

                char:PivotTo(wanted)
                myRoot.CFrame=wanted
                myRoot.AssemblyLinearVelocity=Vector3.zero
                myRoot.AssemblyAngularVelocity=Vector3.zero
                return true
            end

            local downNames={ko=true,["k.o"]=true,knocked=true,downed=true,dead=true,unconscious=true}
            local function downed(pl)
                local char=pl and pl.Character
                if not char then return false end

                local okKnown,knownKO=pcall(function()
                    return IsKnocked(char)
                end)
                if okKnown and knownKO then return true end

                local hum=char:FindFirstChildOfClass("Humanoid")
                if hum and hum.Health<=0 then return true end

                for _,d in ipairs(char:GetDescendants()) do
                    if downNames[d.Name:lower()] then
                        if d:IsA("BoolValue") and d.Value then return true end
                        if (d:IsA("IntValue") or d:IsA("NumberValue")) and d.Value~=0 then
                            return true
                        end
                    end
                end
                return false
            end


            local function nextQueuePlayer()
                if #queue<2 then return nil end
                for step=1,#queue-1 do
                    local idx=((currentIndex-1+step)%#queue)+1
                    local pl=PlayersR:GetPlayerByUserId(queue[idx])
                    if queueCandidateAllowed(pl) then return pl end
                end
                return nil
            end

            local function refreshRageHudTheme()
                if not rageHudFrame or not rageHudFrame.Parent then return end
                local p=pal()
                rageHudFrame.BackgroundColor3=p.panel or T.panel
                if rageHudStroke then rageHudStroke.Color=p.line or p.stroke or T.stroke end
                if rageHudHeader then
                    rageHudHeader.BackgroundColor3=p.soft or p.bg2 or T.bg2
                    rageHudHeader.BackgroundTransparency=0
                end
                if rageHudAccent then rageHudAccent.BackgroundColor3=p.hot or T.hot end
                if rageHudGradient then
                    rageHudGradient.Color=ColorSequence.new({
                        ColorSequenceKeypoint.new(0,p.hot2 or p.hot or T.hot),
                        ColorSequenceKeypoint.new(1,p.hot or T.hot)
                    })
                end
                if rageHudBody then rageHudBody.BackgroundColor3=p.soft or p.bg2 or T.bg2 end
                if rageHudBodyStroke then rageHudBodyStroke.Color=p.line or p.stroke or T.stroke end
                if rageHudTitle then rageHudTitle.TextColor3=p.hot or T.hot end
                if rageHudHint then rageHudHint.TextColor3=p.sub or T.sub end
                if rageHudTarget then rageHudTarget.TextColor3=p.text or T.text end
                if rageHudQueue then rageHudQueue.TextColor3=p.sub or T.sub end
                if rageHudWeapon then rageHudWeapon.TextColor3=p.text or T.text end
                if rageHudNext then rageHudNext.TextColor3=p.sub or T.sub end
                if rageHudStatusPill then rageHudStatusPill.BackgroundColor3=p.hot or T.hot end
                if rageHudStatusPillStroke then rageHudStatusPillStroke.Color=p.hot2 or p.line or T.stroke end
                if rageHudStatus then rageHudStatus.TextColor3=p.white or Color3.new(1,1,1) end
            end
            _G.KimqRefreshRageMiniTheme=refreshRageHudTheme

            local function buildRageHud()
                if rageHudFrame and rageHudFrame.Parent then return end

                rageHudFrame=Instance.new("Frame")
                rageHudFrame.Name="KimqRageMiniHUD"
                rageHudFrame.Parent=gui
                rageHudFrame.AnchorPoint=Vector2.new(1,0)
                rageHudFrame.Position=UDim2.new(1,-22,0,22)
                rageHudFrame.Size=UDim2.fromOffset(304,158)
                rageHudFrame.BorderSizePixel=0
                rageHudFrame.Visible=false
                rageHudFrame.ZIndex=80
                corner(rageHudFrame,16)
                rageHudStroke=stroke(rageHudFrame,pal().line or T.stroke,.18,1)

                rageHudHeader=Instance.new("Frame")
                rageHudHeader.Name="Header"
                rageHudHeader.Parent=rageHudFrame
                rageHudHeader.Size=UDim2.new(1,-16,0,42)
                rageHudHeader.Position=UDim2.fromOffset(8,8)
                rageHudHeader.BackgroundColor3=pal().soft or pal().bg2 or T.bg2
                rageHudHeader.BorderSizePixel=0
                rageHudHeader.Active=true
                rageHudHeader.ZIndex=81
                corner(rageHudHeader,12)
                stroke(rageHudHeader,pal().line or T.stroke,.48,1)

                rageHudAccent=Instance.new("Frame")
                rageHudAccent.Name="Accent"
                rageHudAccent.Parent=rageHudHeader
                rageHudAccent.Size=UDim2.fromOffset(7,24)
                rageHudAccent.Position=UDim2.fromOffset(10,9)
                rageHudAccent.BorderSizePixel=0
                rageHudAccent.ZIndex=82
                corner(rageHudAccent,999)
                rageHudGradient=Instance.new("UIGradient")
                rageHudGradient.Parent=rageHudAccent
                rageHudGradient.Rotation=90

                local rageHudCharm=Instance.new("Frame")
                rageHudCharm.Name="Charm"
                rageHudCharm.Parent=rageHudHeader
                rageHudCharm.Size=UDim2.fromOffset(34,12)
                rageHudCharm.Position=UDim2.new(1,-124,0,15)
                rageHudCharm.BorderSizePixel=0
                rageHudCharm.ZIndex=82
                role(rageHudCharm,"lightBg")
                corner(rageHudCharm,999)
                stroke(rageHudCharm,pal().line or T.stroke,.55,1)
                for i=0,2 do
                    local dot=Instance.new("Frame")
                    dot.Parent=rageHudCharm
                    dot.Size=UDim2.fromOffset(5,5)
                    dot.Position=UDim2.fromOffset(7+i*9,4)
                    dot.BorderSizePixel=0
                    dot.ZIndex=83
                    role(dot,(i==1) and "hotBg" or "panel")
                    corner(dot,999)
                end

                rageHudTitle=label(
                    rageHudHeader,"♥  RAGE MINI",
                    UDim2.new(1,-142,0,24),UDim2.fromOffset(24,4),
                    Enum.Font.FredokaOne,14,pal().hot or T.hot
                )
                rageHudTitle.ZIndex=82
                rageHudHint=label(
                    rageHudHeader,"cute quick view ♡",
                    UDim2.new(1,-142,0,12),UDim2.fromOffset(24,23),
                    Enum.Font.Gotham,8,pal().sub or T.sub
                )
                rageHudHint.ZIndex=82

                rageHudStatusPill=Instance.new("Frame")
                rageHudStatusPill.Parent=rageHudHeader
                rageHudStatusPill.Size=UDim2.fromOffset(86,24)
                rageHudStatusPill.Position=UDim2.new(1,-96,.5,-12)
                rageHudStatusPill.BorderSizePixel=0
                rageHudStatusPill.ZIndex=82
                corner(rageHudStatusPill,999)
                rageHudStatusPillStroke=stroke(rageHudStatusPill,pal().hot2 or pal().line or T.stroke,.28,1)

                rageHudStatus=label(
                    rageHudStatusPill,"READY",
                    UDim2.fromScale(1,1),UDim2.new(),
                    Enum.Font.GothamBold,9,pal().white or Color3.new(1,1,1),
                    Enum.TextXAlignment.Center
                )
                rageHudStatus.ZIndex=83

                rageHudBody=Instance.new("Frame")
                rageHudBody.Name="Body"
                rageHudBody.Parent=rageHudFrame
                rageHudBody.Position=UDim2.fromOffset(8,56)
                rageHudBody.Size=UDim2.new(1,-16,1,-64)
                rageHudBody.BorderSizePixel=0
                rageHudBody.ZIndex=81
                corner(rageHudBody,12)
                rageHudBodyStroke=stroke(rageHudBody,pal().line or T.stroke,.48,1)

                rageHudTarget=label(
                    rageHudBody,"TARGET  ♡  none",
                    UDim2.new(1,-16,0,20),UDim2.fromOffset(12,10),
                    Enum.Font.GothamBold,10,pal().text or T.text
                )
                rageHudTarget.ZIndex=82
                rageHudTarget.TextTruncate=Enum.TextTruncate.AtEnd

                rageHudQueue=label(
                    rageHudBody,"QUEUE  0/0  ♡  MANUAL",
                    UDim2.new(1,-16,0,17),UDim2.fromOffset(12,34),
                    Enum.Font.Gotham,9,pal().sub or T.sub
                )
                rageHudQueue.ZIndex=82

                rageHudWeapon=label(
                    rageHudBody,"WEAPON  ♡  none",
                    UDim2.new(1,-16,0,18),UDim2.fromOffset(12,56),
                    Enum.Font.GothamSemibold,9,pal().text or T.text
                )
                rageHudWeapon.ZIndex=82
                rageHudWeapon.TextTruncate=Enum.TextTruncate.AtEnd

                rageHudNext=label(
                    rageHudBody,"NEXT  ♡  none",
                    UDim2.new(1,-16,0,16),UDim2.fromOffset(12,78),
                    Enum.Font.Gotham,9,pal().sub or T.sub
                )
                rageHudNext.ZIndex=82
                rageHudNext.TextTruncate=Enum.TextTruncate.AtEnd

                local dragging=false
                local dragStart=nil
                local startPos=nil
                rageHudHeader.InputBegan:Connect(function(input)
                    if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then
                        dragging=true
                        dragStart=input.Position
                        startPos=rageHudFrame.Position
                    end
                end)
                UISR.InputEnded:Connect(function(input)
                    if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then
                        dragging=false
                    end
                end)
                UISR.InputChanged:Connect(function(input)
                    if not dragging or not dragStart or not startPos then return end
                    if input.UserInputType~=Enum.UserInputType.MouseMovement and input.UserInputType~=Enum.UserInputType.Touch then return end
                    local delta=input.Position-dragStart
                    rageHudFrame.Position=UDim2.new(
                        startPos.X.Scale,startPos.X.Offset+delta.X,
                        startPos.Y.Scale,startPos.Y.Offset+delta.Y
                    )
                end)

                refreshRageHudTheme()
            end

            local function updateRageHud()
                buildRageHud()
                if not rageHudFrame then return end
                rageHudFrame.Visible=rageHudEnabled and (autoHunt or orbitEnabled or autoShoot or camEnabled or viewEnabled)
                if not rageHudFrame.Visible then return end

                local pl=currentPlayer()
                local status="READY"
                if rageControl.phase=="STOMP" or stompBusy then status="STOMPING"
                elseif rageControl.phase=="FINISH" then status="FINISHING"
                elseif rageControl.phase=="DONE" then status="DONE"
                elseif reloadBusy then status="RELOADING"
                elseif pl and queueLooksDowned(pl) then status="FINISHING"
                elseif autoHunt then status="HUNTING"
                elseif autoShoot then status="SHOOTING"
                elseif orbitEnabled then status="ORBITING"
                elseif camEnabled then status="LOCKED"
                elseif viewEnabled then status="VIEWING" end
                rageHudStatus.Text=status

                if pl then
                    rageHudTarget.Text="TARGET  ♡  "..pl.DisplayName.."  (@"..pl.Name..")"
                else
                    rageHudTarget.Text="TARGET  ♡  none"
                end
                rageHudQueue.Text="QUEUE  "..tostring(#queue==0 and 0 or currentIndex).."/"..tostring(#queue).."  ♡  "..string.upper(queueOrderMode)

                local tool=lp.Character and lp.Character:FindFirstChildOfClass("Tool")
                if tool then
                    local ammo=readAmmoCount(tool)
                    local profile=profileForTool(tool)
                    local ammoText=ammo~=nil and tostring(math.max(0,math.floor(ammo+.5))) or "?"
                    local profileText=profile and ("  •  "..profile.Name) or ""
                    rageHudWeapon.Text="WEAPON  ♡  "..tostring(tool.Name):gsub("%[",""):gsub("%]","").."  •  AMMO "..ammoText..profileText
                else
                    rageHudWeapon.Text="WEAPON  ♡  none"
                end

                local nxt=nextQueuePlayer()
                rageHudNext.Text=nxt and ("NEXT  ♡  "..nxt.DisplayName.."  (@"..nxt.Name..")") or "NEXT  ♡  none"
            end

            rageControl.releaseMovementForStomp=function()
                -- stopOrbitMotion() restores the Humanoid values captured when the
                -- orbit started (PlatformStand / AutoRotate) before the stomp begins.
                stopOrbitMotion()
                stopOrbitAnimation()

                local char=lp.Character
                local root=char and char:FindFirstChild("HumanoidRootPart")
                local hum=char and char:FindFirstChildOfClass("Humanoid")
                if hum then
                    pcall(function()
                        hum.PlatformStand=false
                        hum.Sit=false
                        hum.AutoRotate=true
                    end)
                end
                if root then
                    pcall(function()
                        root.AssemblyLinearVelocity=Vector3.zero
                        root.AssemblyAngularVelocity=Vector3.zero
                    end)
                end
            end

            rageControl.resumeAttackOnCurrent=function()
                if not autoHunt then return end
                local nxt=currentPlayer()
                if not nxt then return end
                rageControl.phase="ATTACK"
                rageControl.phaseTargetId=nxt.UserId
                orbitAngle=0
                rageLockTargetId=nil
                rageLockDeadLatch=false
                startStableLock(nxt)
                tryEquipRageWings()
                teleportTo(nxt,false)
                startOrbitAnimation()
                startOrbitMotion()
            end

            rageControl.stopAfterSoloFinish=function()
                rageControl.phase="DONE"
                rageControl.phaseTargetId=nil
                rageControl.releaseMovementForStomp()
                stopStableLock()

                -- Keep the UI toggle synchronized with the actual automation state.
                if type(rageControl.setRageMasterToggle)=="function" then
                    pcall(rageControl.setRageMasterToggle,false,true)
                else
                    autoHunt=false
                end
                updateRageHud()
            end

            local function finish(pl)
                if stompBusy or not pl then return end
                local id=pl.UserId
                if finishedWaiting[id] then return end

                finishedWaiting[id]=true
                stompBusy=true
                rageControl.phase="STOMP"
                rageControl.phaseTargetId=id

                -- IMPORTANT: orbit previously only *skipped* the knocked target, which
                -- left PlatformStand=true and made the local body feel frozen. Release
                -- the orbit controller immediately before moving above the target.
                rageControl.releaseMovementForStomp()

                task.spawn(function()
                    if autoStomp then
                        -- Stand upright directly over the knocked player and repeatedly
                        -- use the normal E stomp path. Re-snapping prevents normal game
                        -- physics from nudging us away while the stomp is being sent.
                        local presses=0
                        local wantedPresses=math.max(stompRepeats,8)
                        local deadline=os.clock()+2.65

                        while pl.Parent and os.clock()<deadline and presses<wantedPresses do
                            if placeOnTopForStomp(pl) then
                                task.wait(.10)
                                placeOnTopForStomp(pl)
                                pressStomp()
                                presses+=1
                            end
                            task.wait(.13)
                        end
                    end

                    rageControl.phase="FINISH"

                    -- Queue preset: only after the stomp sequence ends do we select
                    -- the next player and give orbit control back to the attack phase.
                    if autoAdvance and queued[id] and #queue>1 then
                        advance(false)
                        rageLockTargetId=nil
                        rageLockDeadLatch=false
                        stompBusy=false
                        task.wait(.08)
                        rageControl.resumeAttackOnCurrent()
                    else
                        -- Solo / one-target RAGE is finished. Do not sit in a hidden
                        -- orbit state or leave the Humanoid stiff after the stomp.
                        stompBusy=false
                        rageControl.stopAfterSoloFinish()
                    end
                end)
            end

            -- ---------------- RAGE CAM ----------------
            -- v2.71: UI-only locals are scoped so they are released before the next
            -- RAGE page is built. Closures keep whatever objects they actually use.
            do
            local chooser=card(rageCamPage,338)

            local previewBox=Instance.new("Frame")
            previewBox.Parent=chooser
            previewBox.Position=UDim2.fromOffset(8,8)
            previewBox.Size=UDim2.new(.43,-12,1,-16)
            previewBox.BackgroundColor3=pal().panel or T.panel
            previewBox.BorderSizePixel=0
            role(previewBox,"panel")
            corner(previewBox,12)
            stroke(previewBox,pal().line or pal().stroke or T.stroke,.25,1)

            previewTitle=role(label(previewBox,"Hover a player",UDim2.new(1,-12,0,34),UDim2.fromOffset(6,5),Enum.Font.GothamBold,11,pal().text or T.text,Enum.TextXAlignment.Center),"textText")

            local gradientBack=Instance.new("Frame")
            gradientBack.Parent=previewBox
            gradientBack.Position=UDim2.fromOffset(7,43)
            gradientBack.Size=UDim2.new(1,-14,0,220)
            gradientBack.BackgroundColor3=pal().soft or T.bg2
            gradientBack.BorderSizePixel=0
            role(gradientBack,"lightBg")
            corner(gradientBack,11)

            local grad=Instance.new("UIGradient")
            grad.Name="V26BannerGradient"
            grad.Parent=gradientBack
            grad.Color=ColorSequence.new({
                ColorSequenceKeypoint.new(0,pal().soft or T.bg2),
                ColorSequenceKeypoint.new(1,pal().hot or T.hot)
            })
            grad.Rotation=90

            previewViewport=Instance.new("ViewportFrame")
            previewViewport.Parent=gradientBack
            previewViewport.Size=UDim2.fromScale(1,1)
            previewViewport.BackgroundTransparency=1
            previewViewport.BorderSizePixel=0
            previewViewport.Ambient=Color3.new(1,1,1)
            previewViewport.LightColor=Color3.new(1,1,1)
            previewViewport.LightDirection=Vector3.new(-1,-1,-1)

            local sel=role(label(previewBox,queueText(),UDim2.new(1,-12,0,54),UDim2.fromOffset(6,270),Enum.Font.GothamSemibold,10,pal().sub or T.sub,Enum.TextXAlignment.Center),"subText")
            sel.TextWrapped=true
            table.insert(selectedLabels,sel)

            local listBox=Instance.new("Frame")
            listBox.Parent=chooser
            listBox.Position=UDim2.new(.43,4,0,8)
            listBox.Size=UDim2.new(.57,-12,1,-16)
            listBox.BackgroundColor3=pal().panel or T.panel
            listBox.BorderSizePixel=0
            role(listBox,"panel")
            corner(listBox,12)
            stroke(listBox,pal().line or pal().stroke or T.stroke,.25,1)

            role(label(listBox,"Target Queue",UDim2.new(1,-74,0,30),UDim2.fromOffset(10,5),Enum.Font.GothamBold,12,pal().text or T.text),"textText")
            local refreshBtn=button(listBox,"refresh",UDim2.new(1,-68,0,5),UDim2.fromOffset(58,28),function()
                refreshPlayerList()
            end)

            playerList=Instance.new("ScrollingFrame")
            playerList.Parent=listBox
            playerList.Position=UDim2.fromOffset(8,40)
            playerList.Size=UDim2.new(1,-16,1,-48)
            playerList.BackgroundTransparency=1
            playerList.BorderSizePixel=0
            playerList.ScrollBarThickness=2
            playerList.ScrollBarImageColor3=pal().hot or T.hot

            local pll=Instance.new("UIListLayout")
            pll.Parent=playerList
            pll.Padding=UDim.new(0,5)
            pll.SortOrder=Enum.SortOrder.LayoutOrder
            pll:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                playerList.CanvasSize=UDim2.new(0,0,0,pll.AbsoluteContentSize.Y+6)
            end)

            refreshPlayerList=function()
                if not playerList or not playerList.Parent then return end
                for _,ch in ipairs(playerList:GetChildren()) do
                    if not ch:IsA("UIListLayout") then ch:Destroy() end
                end
                local list={}
                for _,pl in ipairs(PlayersR:GetPlayers()) do
                    if pl~=lp then table.insert(list,pl) end
                end
                table.sort(list,function(a,b) return a.DisplayName:lower()<b.DisplayName:lower() end)

                local cid=currentId()
                for i,pl in ipairs(list) do
                    local q=queued[pl.UserId]
                    local active=cid==pl.UserId
                    local b=button(playerList,"",UDim2.new(),UDim2.new(1,-2,0,46),function()
                        togglePlayer(pl)
                    end)
                    b.LayoutOrder=i
                    if active then
                        b.BackgroundColor3=pal().hot or T.hot
                        b:SetAttribute("KimqV26Role","hotBg")
                    end
                    local prefix=q and ("#"..tostring(queueIndex(pl.UserId))) or "+"
                    role(label(b,prefix,UDim2.fromOffset(28,46),UDim2.fromOffset(5,0),Enum.Font.GothamBold,11,active and (pal().white or Color3.new(1,1,1)) or (pal().hot or T.hot),Enum.TextXAlignment.Center),active and "whiteText" or "hotText")
                    role(label(b,pl.DisplayName,UDim2.new(1,-42,0,21),UDim2.fromOffset(36,4),Enum.Font.GothamBold,11,active and (pal().white or Color3.new(1,1,1)) or (pal().text or T.text)),active and "whiteText" or "textText")
                    role(label(b,"@"..pl.Name,UDim2.new(1,-42,0,16),UDim2.fromOffset(36,24),Enum.Font.Gotham,9,active and (pal().white or Color3.new(1,1,1)) or (pal().sub or T.sub)),active and "whiteText" or "subText")
                    b.MouseEnter:Connect(function() showPreview(pl) end)
                    b.MouseLeave:Connect(function() showPreview(currentPlayer()) end)
                end
            end

            refreshPlayerList()
            PlayersR.PlayerAdded:Connect(function() task.defer(refreshPlayerList) end)
            PlayersR.PlayerRemoving:Connect(function(pl)
                if queued[pl.UserId] then removeId(pl.UserId) end
                task.defer(refreshPlayerList)
            end)

            local actions=card(rageCamPage,96)
            button(actions,"Lock",UDim2.fromOffset(10,8),UDim2.new(.25,-13,0,34),function()
                startStableLock(currentPlayer())
            end)
            button(actions,"Unlock",UDim2.new(.25,3,0,8),UDim2.new(.25,-13,0,34),function()
                stopStableLock()
            end)
            button(actions,"View",UDim2.new(.5,6,0,8),UDim2.new(.25,-13,0,34),function()
                startFreeView(currentPlayer())
            end)
            button(actions,"Unview",UDim2.new(.75,9,0,8),UDim2.new(.25,-19,0,34),restoreCamera)
            button(actions,"Teleport",UDim2.fromOffset(10,52),UDim2.new(.5,-15,0,34),function()
                teleportTo(currentPlayer(),false)
            end)
            button(actions,"Clear Queue",UDim2.new(.5,5,0,52),UDim2.new(.5,-15,0,34),function()
                queue={}
                queued={}
                finishedWaiting={}
                currentIndex=1
                stopStableLock()
                autoHunt=false
                orbitEnabled=false
                autoShoot=false
                autoTeleport=false
                stopOrbitMotion()
                stopOrbitAnimation()
                restoreCamera()
                refreshSelected()
                refreshPlayerList()
            end)


            local queueOrderButton
            queueOrderButton,rageControl.setQueueOrderCycle=makeCycle(rageCamPage,"Queue Order",{"Manual","Closest","Lowest Health","Random"},queueOrderMode,function(v)
                queueOrderMode=v
                applyQueueOrdering(v=="Random")
            end)
            local queueSkipDownedButton
            queueSkipDownedButton,rageControl.setQueueSkipDownedToggle=makeToggle(rageCamPage,"Skip Downed / Dead On Advance",true,function(v)
                queueSkipDowned=v
            end)
            local queueSkipWhitelistButton
            queueSkipWhitelistButton,rageControl.setQueueSkipWhitelistToggle=makeToggle(rageCamPage,"Skip Whitelisted On Advance",true,function(v)
                queueSkipWhitelisted=v
            end)

            local queueManage=card(rageCamPage,104)
            button(queueManage,"← Previous",UDim2.fromOffset(10,8),UDim2.new(.5,-15,0,34),previousTarget)
            button(queueManage,"Next →",UDim2.new(.5,5,0,8),UDim2.new(.5,-15,0,34),function() advance(false) end)
            button(queueManage,"Move ↑",UDim2.fromOffset(10,52),UDim2.new(.33,-13,0,34),function() moveCurrentInQueue(-1) end)
            button(queueManage,"Move ↓",UDim2.new(.33,4,0,52),UDim2.new(.33,-13,0,34),function() moveCurrentInQueue(1) end)
            button(queueManage,"Remove",UDim2.new(.66,8,0,52),UDim2.new(.34,-18,0,34),function() advance(true) end)

            local queueNote=card(rageCamPage,52)
            local queueNoteText=role(label(
                queueNote,
                "Manual keeps your exact order. Closest + Lowest Health sort automatically. Random shuffles when selected / when Combat Master starts. Move ↑/↓ only edits Manual order.",
                UDim2.new(1,-24,1,-10),UDim2.fromOffset(12,5),
                Enum.Font.Gotham,9,pal().sub or T.sub
            ),"subText")
            queueNoteText.TextWrapped=true

            makeCycle(rageCamPage,"Camlock Part",{"Head","UpperTorso","HumanoidRootPart","Closest Part"},camPart,function(v) camPart=v end)
            rageControl._,rageControl.setCamSmooth=makeSlider(rageCamPage,"Camlock Follow Strength",.10,1,camSmooth,function(v) camSmooth=v end,function(v) return string.format("%.2f",v) end)
            end

            -- ---------------- ORBIT ----------------
            do
            local orbitHead=card(rageOrbitPage,74)
            role(label(orbitHead,"Current Target",UDim2.new(1,-24,0,24),UDim2.fromOffset(12,8),Enum.Font.GothamBold,13,pal().hot or T.hot),"hotText")
            local orbitSel=role(label(orbitHead,queueText(),UDim2.new(1,-24,0,32),UDim2.fromOffset(12,35),Enum.Font.Gotham,10,pal().sub or T.sub),"subText")
            orbitSel.TextWrapped=true
            table.insert(selectedLabels,orbitSel)

            local teleCard=card(rageOrbitPage,52)
            button(teleCard,"♥  Teleport To Current Target",UDim2.fromOffset(10,9),UDim2.new(1,-20,0,34),function()
                teleportTo(currentPlayer(),false)
            end)

            local autoTeleportButton
            autoTeleportButton,rageControl.setAutoTeleportToggle=makeToggle(rageOrbitPage,"Auto Teleport",false,function(v) autoTeleport=v; teleportClock=0 end)
            makeSlider(rageOrbitPage,"Auto Teleport Delay",.05,2,teleportDelay,function(v) teleportDelay=v end,function(v) return string.format("%.2fs",v) end)
            local orbitMasterButton
            orbitMasterButton,rageControl.setOrbitMasterToggle=makeToggle(rageOrbitPage,"Target Orbit Master",false,function(v)
                orbitEnabled=v
                orbitAngle=0
                teleportClock=0
                if v then
                    -- One switch: teleport once, then orbit continuously.
                    tryEquipRageWings()
                    teleportTo(currentPlayer(),false)
                    startOrbitAnimation()
                    startOrbitMotion()
                else
                    if not autoHunt then
                        stopOrbitMotion()
                        stopOrbitAnimation()
                    end
                end
                updateRageHud()
            end)
            rageControl._,rageControl.setOrbitSpeed=makeSlider(rageOrbitPage,"Flight / Orbit Speed",.25,20,orbitSpeed,function(v) orbitSpeed=v end,function(v) return string.format("%.1fx",v) end)
            rageControl._,rageControl.setOrbitRadius=makeSlider(rageOrbitPage,"Orbit Radius",3,30,orbitRadius,function(v) orbitRadius=v end,function(v) return string.format("%.1f",v) end)
            rageControl._,rageControl.setOrbitHeight=makeSlider(rageOrbitPage,"Orbit Height",-2,18,orbitHeight,function(v) orbitHeight=v end,function(v) return string.format("%.1f",v) end)
            end

            -- ---------------- COMBAT ----------------
            do
            local combatHead=card(rageCombatPage,74)
            role(label(combatHead,"Current Target",UDim2.new(1,-24,0,24),UDim2.fromOffset(12,8),Enum.Font.GothamBold,13,pal().hot or T.hot),"hotText")
            local combatSel=role(label(combatHead,queueText(),UDim2.new(1,-24,0,32),UDim2.fromOffset(12,35),Enum.Font.Gotham,10,pal().sub or T.sub),"subText")
            combatSel.TextWrapped=true
            table.insert(selectedLabels,combatSel)

            rageControl._,rageControl.setHitPart=makeCycle(rageCombatPage,"Hit Part",{"Head","UpperTorso","HumanoidRootPart","Closest Part"},hitPart,function(v) hitPart=v end)

            rageControl._,rageControl.setCombatMode=makeCycle(rageCombatPage,"Combat Mode",{"Normal Gun","One Shot"},combatMode,function(v)
                combatMode=v
                if v=="Normal Gun" and autoShoot then
                    ensureGunEquipped()
                end
            end)


            local autoWeaponProfilesButton
            autoWeaponProfilesButton,rageControl.setAutoWeaponProfilesToggle=makeToggle(rageCombatPage,"Auto Weapon Profiles",true,function(v)
                autoWeaponProfiles=v
            end)
            local rageHudButton
            rageHudButton,rageControl.setRageHudToggle=makeToggle(rageCombatPage,"Rage Mini HUD",true,function(v)
                rageHudEnabled=v
                updateRageHud()
            end)

            local profileNote=card(rageCombatPage,58)
            local profileNoteText=role(label(
                profileNote,
                "Auto Weapon Profiles only tunes RAGE fire timing + hit part: Revolver/Silencer favor precision, shotguns favor torso, and SMG uses faster timing. Turn it OFF to use your manual Hit Part + Auto Shoot Delay.",
                UDim2.new(1,-24,1,-10),UDim2.fromOffset(12,5),
                Enum.Font.Gotham,9,pal().sub or T.sub
            ),"subText")
            profileNoteText.TextWrapped=true

            local autoShootButton
            autoShootButton,rageControl.setAutoShootToggle=makeToggle(rageCombatPage,"Auto Shoot Current Target",false,function(v)
                autoShoot=v
                shootClock=0
                if v and combatMode=="Normal Gun" then
                    ensureGunEquipped()
                end
                updateRageHud()
            end)

            rageControl._,rageControl.setShootDelay=makeSlider(rageCombatPage,"Auto Shoot Delay",.03,1,shootDelay,function(v) shootDelay=v end,function(v) return string.format("%.2fs",v) end)

            local autoReloadButton
            autoReloadButton,rageControl.setAutoReloadToggle=makeToggle(rageCombatPage,"Auto Reload When Empty",false,function(v)
                autoReload=v
                reloadBusy=false
                lastReloadAt=0
            end)

            rageControl._,rageControl.setBurstCount=makeSlider(rageCombatPage,"One-Shot Power",1,10,burstCount,function(v)
                burstCount=math.floor(v+.5)
            end,function(v) return tostring(math.floor(v+.5)) end)

            local burstCard=card(rageCombatPage,52)
            button(burstCard,"♥  Fire Selected Combat Mode",UDim2.fromOffset(10,9),UDim2.new(1,-20,0,34),function()
                rageShoot(currentPlayer())
            end)

            local rageMasterButton
            rageMasterButton,rageControl.setRageMasterToggle=makeToggle(rageCombatPage,"Rage Combat Master",false,function(v)
                autoHunt=v
                orbitAngle=0
                shootClock=0
                teleportClock=0
                if v then
                    rageControl.phase="ATTACK"
                    local phasePl=currentPlayer()
                    rageControl.phaseTargetId=phasePl and phasePl.UserId or nil
                    applyQueueOrdering(queueOrderMode=="Random")
                    if not queueCandidateAllowed(currentPlayer()) then seekNextAllowed(1) end
                    updateRageHud()

                    -- v2.63: Combat Master automatically uses the STABLE target camera.
                    -- The camera translates with the selected target at a fixed offset;
                    -- local orbit movement can no longer whip/spin the view around.
                    if viewEnabled then restoreCamera() end
                    startStableLock(currentPlayer())

                    tryEquipRageWings()
                    teleportTo(currentPlayer(),false)
                    startOrbitAnimation()
                    startOrbitMotion()
                    if combatMode=="Normal Gun" or combatMode=="One Shot" then
                        ensureGunEquipped()
                    end
                else
                    rageControl.phase="IDLE"
                    rageControl.phaseTargetId=nil
                    if not orbitEnabled then
                        stopOrbitMotion()
                        stopOrbitAnimation()
                    end
                    updateRageHud()
                end
            end)
            local antiLockButton
            antiLockButton,rageControl.setAntiLockToggle=makeToggle(rageCombatPage,"Anti Lock / Evasive",false,function(v)
                antiLockEnabled=v
            end)
            makeSlider(
                rageCombatPage,
                "Anti Lock Strength",
                .25,2,antiLockStrength,
                function(v) antiLockStrength=v end,
                function(v) return string.format("%.2fx",v) end
            )

            local autoStompButton
            autoStompButton,rageControl.setAutoStompToggle=makeToggle(rageCombatPage,"Auto Stomp With E",true,function(v) autoStomp=v end)
            rageControl._,rageControl.setStompRepeats=makeSlider(rageCombatPage,"Stomp E Repeats",1,6,stompRepeats,function(v) stompRepeats=math.floor(v+.5) end,function(v) return tostring(math.floor(v+.5)) end)
            local autoAdvanceButton
            autoAdvanceButton,rageControl.setAutoAdvanceToggle=makeToggle(rageCombatPage,"Auto Advance After Finish",true,function(v) autoAdvance=v end)
            end

            -- v2.76 OP RAGE Presets: aggressive one-tap target/combat setups.
            -- They only touch variables and controls owned by the isolated RAGE module.
            do
            local ragePresetCard=card(pages.ragepresets,184)
            role(label(ragePresetCard,"♥  OP RAGE Presets",UDim2.new(1,-24,0,24),UDim2.fromOffset(12,7),Enum.Font.GothamBold,13,pal().hot or T.hot),"hotText")
            local ragePresetSub=role(label(
                ragePresetCard,"aggressive targeting + combat presets ♡ • other Kimqetras sections stay untouched",
                UDim2.new(1,-24,0,20),UDim2.fromOffset(12,30),Enum.Font.Gotham,9,pal().sub or T.sub
            ),"subText")

            local function setRageToggle(setter,value)
                if type(setter)=="function" then setter(value,true) end
            end
            local function setRageValue(setter,value)
                if type(setter)=="function" then pcall(setter,value) end
            end
            local function armOpCombat(autoAdvanceValue,orbitRadiusValue,orbitHeightValue)
                setRageValue(rageControl.setCamSmooth,1)
                setRageValue(rageControl.setHitPart,"Head")
                setRageValue(rageControl.setCombatMode,"One Shot")
                setRageValue(rageControl.setShootDelay,.03)
                setRageValue(rageControl.setBurstCount,10)
                setRageValue(rageControl.setStompRepeats,6)
                setRageValue(rageControl.setOrbitSpeed,20)
                setRageValue(rageControl.setOrbitRadius,orbitRadiusValue or 4)
                setRageValue(rageControl.setOrbitHeight,orbitHeightValue or 2.5)
                setRageToggle(rageControl.setQueueSkipDownedToggle,true)
                setRageToggle(rageControl.setQueueSkipWhitelistToggle,true)
                setRageToggle(rageControl.setAutoWeaponProfilesToggle,true)
                setRageToggle(rageControl.setRageHudToggle,true)
                setRageToggle(rageControl.setAutoReloadToggle,true)
                setRageToggle(rageControl.setAutoStompToggle,true)
                setRageToggle(rageControl.setAutoAdvanceToggle,autoAdvanceValue==true)
                setRageToggle(rageControl.setAntiLockToggle,true)
                -- Combat Master already performs its own teleport + orbit. Keep the
                -- separate teleport/orbit masters off so two movement loops never fight.
                setRageToggle(rageControl.setAutoTeleportToggle,false)
                setRageToggle(rageControl.setOrbitMasterToggle,false)
                setRageToggle(rageControl.setAutoShootToggle,true)
                setRageToggle(rageControl.setRageMasterToggle,true)
            end

            local function applyRagePreset(name)
                if name~="Manual / Calm" and not currentPlayer() then
                    pcall(function()
                        game:GetService("StarterGui"):SetCore("SendNotification",{
                            Title="KIM ♡",Text="Pick a RAGE target first",Duration=3
                        })
                    end)
                    return
                end

                if name=="OP SOLO" then
                    local id=currentId()
                    if id then
                        queue={id}
                        queued={[id]=true}
                        currentIndex=1
                        finishedWaiting={}
                        refreshSelected(); refreshPlayerList()
                    end
                    if type(rageControl.setQueueOrderCycle)=="function" then rageControl.setQueueOrderCycle("Manual",true) end
                    armOpCombat(false,3.6,2.2)

                elseif name=="OP QUEUE WIPE" then
                    if type(rageControl.setQueueOrderCycle)=="function" then rageControl.setQueueOrderCycle("Lowest Health",true) end
                    armOpCombat(true,4.2,2.6)

                elseif name=="OP ORBIT HUNT" then
                    if type(rageControl.setQueueOrderCycle)=="function" then rageControl.setQueueOrderCycle("Closest",true) end
                    -- Same kill/finish automation, but with a tighter/faster orbit.
                    armOpCombat(true,3.2,4.0)

                elseif name=="Manual / Calm" then
                    setRageToggle(rageControl.setRageMasterToggle,false)
                    setRageToggle(rageControl.setOrbitMasterToggle,false)
                    setRageToggle(rageControl.setAutoShootToggle,false)
                    setRageToggle(rageControl.setAutoTeleportToggle,false)
                    setRageToggle(rageControl.setAntiLockToggle,false)
                    reloadBusy=false
                    stopStableLock()
                    updateRageHud()
                end

                pcall(function()
                    game:GetService("StarterGui"):SetCore("SendNotification",{
                        Title="KIM ♡",Text="RAGE preset: "..name,Duration=3
                    })
                end)
            end

            button(ragePresetCard,"OP SOLO",UDim2.fromOffset(10,60),UDim2.new(.5,-15,0,36),function() applyRagePreset("OP SOLO") end)
            button(ragePresetCard,"OP QUEUE WIPE",UDim2.new(.5,5,0,60),UDim2.new(.5,-15,0,36),function() applyRagePreset("OP QUEUE WIPE") end)
            button(ragePresetCard,"OP ORBIT HUNT",UDim2.fromOffset(10,106),UDim2.new(.5,-15,0,36),function() applyRagePreset("OP ORBIT HUNT") end)
            button(ragePresetCard,"Manual / Calm",UDim2.new(.5,5,0,106),UDim2.new(.5,-15,0,36),function() applyRagePreset("Manual / Calm") end)
            end

            do
            local note=card(rageCombatPage,64)
            local noteText=role(label(
                note,
                "Rage Combat Master runs by itself: stable target camera → orbit → auto-fire → detect K.O → stomp → automatically continue to the next queued target. Presets are now in the separate RAGE > rage presets page.",
                UDim2.new(1,-24,1,-12),UDim2.fromOffset(12,6),
                Enum.Font.Gotham,9,pal().sub or T.sub
            ),"subText")
            noteText.TextWrapped=true
            end

            -- ---------------- LIVE LOOPS ----------------
            RunServiceR.RenderStepped:Connect(function(dt)
                local ok,err=pcall(function()
                    local pl=currentPlayer()
                    local cam=workspace.CurrentCamera
                    if not cam then return end

                    if viewEnabled then
                        local hum=pl and pl.Character and pl.Character:FindFirstChildOfClass("Humanoid")
                        if hum then
                            cam.CameraType=Enum.CameraType.Custom
                            if cam.CameraSubject~=hum then cam.CameraSubject=hum end
                        end

                    elseif camEnabled then
                        if not pl then
                            stopStableLock()
                            return
                        end

                        -- Manual RAGE Lock also advances through the queue if its
                        -- target is dead/KO. Combat Master already advances after its
                        -- stomp, so it owns advancement while autoHunt is active.
                        if not autoHunt then
                            local deadNow=downed(pl)
                            if deadNow and not rageLockDeadLatch then
                                rageLockDeadLatch=true
                                if #queue>1 then
                                    advance(false)
                                    pl=currentPlayer()
                                    rageLockTargetId=nil
                                end
                            elseif not deadNow then
                                rageLockDeadLatch=false
                            end
                        end

                        if not pl then return end
                        local part=getPart(pl,camPart)
                        if not part then return end

                        -- Keep the SAME world-space offset while the target moves.
                        -- This is the key difference from the old look-at camera:
                        -- local orbit no longer changes camera position, therefore
                        -- there is no continuous circular/spinning camera motion.
                        if not rageLockOffset then
                            rageLockOffset=captureStableOffset(pl) or Vector3.new(0,2.4,12)
                        end

                        if rageLockTargetId~=pl.UserId then
                            rageLockTargetId=pl.UserId
                            rageLockDeadLatch=false
                        end

                        cam.CameraType=Enum.CameraType.Scriptable
                        local desiredPos=part.Position+rageLockOffset
                        local a=math.clamp(tonumber(camSmooth) or 1,.10,1)
                        local pos=(a>=.995) and desiredPos or cam.CFrame.Position:Lerp(desiredPos,a)
                        cam.CFrame=CFrame.lookAt(pos,part.Position,Vector3.yAxis)
                        cam.Focus=CFrame.new(part.Position)
                    end
                end)

                if not ok then
                    warn("[Kimqetras HC v2.67 RAGE camera] "..tostring(err))
                end
            end)

            RunServiceR.Heartbeat:Connect(function(dt)
                local ok,err=pcall(function()
                    local pl=currentPlayer()

                    if pl and autoTeleport and not (orbitEnabled or autoHunt) then
                        teleportClock+=dt
                        if teleportClock>=teleportDelay then
                            teleportClock=0
                            teleportTo(pl,false)
                        end
                    else
                        teleportClock=0
                    end

                    local waiting=pl and finishedWaiting[pl.UserId]

                    -- Check the currently-equipped RAGE gun before the next shot.
                    -- If it is empty and Auto Reload is enabled, shooting pauses until
                    -- the ammo value comes back.
                    if pl and not waiting and autoReload and (autoShoot or autoHunt) then
                        local tool=ensureGunEquipped()
                        if tool then tryAutoReload(tool) end
                    end

                    -- Completely automatic: while Combat Master / Auto Shoot is on,
                    -- fire the selected Combat Mode at the current target.
                    if pl and not waiting and (autoShoot or autoHunt) and not reloadBusy then
                        shootClock+=dt
                        if shootClock>=effectiveShootDelay() then
                            shootClock=0
                            rageShoot(pl)
                        end
                    else
                        shootClock=0
                    end

                    -- Keep finished targets in the queue and automatically unlock them
                    -- after their next healthy respawn.
                    respawnScanClock+=dt
                    if respawnScanClock>=.35 then
                        respawnScanClock=0
                        for _,id in ipairs(queue) do
                            if finishedWaiting[id] then
                                local rp=PlayersR:GetPlayerByUserId(id)
                                if rp and rp.Character then
                                    local hum=rp.Character:FindFirstChildOfClass("Humanoid")
                                    if hum and hum.Health>0 and not downed(rp) then
                                        finishedWaiting[id]=nil
                                    end
                                end
                            end
                        end
                    end

                    local now=os.clock()
                    if autoHunt
                        and pl
                        and not finishedWaiting[pl.UserId]
                        and not stompBusy
                        and now-lastDownCheck>.1
                    then
                        lastDownCheck=now
                        if downed(pl) then
                            finish(pl)
                        end
                    end

                    rageHudClock+=dt
                    if rageHudClock>=.10 then
                        rageHudClock=0
                        updateRageHud()
                    end
                end)
                if not ok then
                    warn("[Kimqetras HC v2.67 RAGE heartbeat] "..tostring(err))
                end
            end)


            _G.KimqRageEmergencyRestore=function()
                autoHunt=false
                rageControl.phase="IDLE"
                rageControl.phaseTargetId=nil
                autoShoot=false
                autoTeleport=false
                orbitEnabled=false
                reloadBusy=false
                stompBusy=false
                antiLockEnabled=false
                viewEnabled=false
                camEnabled=false
                stopOrbitMotion()
                stopOrbitAnimation()
                restoreCamera()
                stopStableLock()

                local char=lp.Character
                local hum=char and char:FindFirstChildOfClass("Humanoid")
                local root=char and char:FindFirstChild("HumanoidRootPart")
                if hum then
                    pcall(function()
                        hum.PlatformStand=false
                        hum.Sit=false
                        hum.AutoRotate=true
                    end)
                end
                if root then
                    pcall(function()
                        root.AssemblyLinearVelocity=Vector3.zero
                        root.AssemblyAngularVelocity=Vector3.zero
                    end)
                end
                if rageHudFrame then rageHudFrame.Visible=false end
            end

            -- Target queue intentionally survives YOUR respawn.
            lp.CharacterAdded:Connect(function()
                stopOrbitAnimation()
                restoreOrbitHumanoid()
                task.delay(.45,function()
                    if orbitEnabled or autoHunt then
                        tryEquipRageWings()
                        teleportTo(currentPlayer(),false)
                        startOrbitAnimation()
                        startOrbitMotion()
                        if autoHunt then startStableLock(currentPlayer()) end
                    end
                end)
            end)

            refreshSelected()
            showPreview(currentPlayer())
        end)

        if not rageOK then
            warn("[Kimqetras HC v2.71] RAGE module isolated error: "..tostring(rageERR))
        end
    end)

    -- ================================================================
    -- v2.14 SPAWN POINT
    -- A lightweight selector for the map's real spawn locations. It does
    -- no constant workspace scanning: the list is refreshed only when the
    -- page is opened or the user presses Refresh.
    -- ================================================================
    do
        local spawnPage = pages.spawn
        if spawnPage then
            local selectedSpawn = nil
            local selectedPath = nil
            local selectedName = "Game Default"
            local fallbackPosition = nil
            local useSelectedSpawn = false
            local scannedOnce = false
            local spawnEntries = {}

            local function palette()
                return _G.KimqThemeLivePalette or T
            end

            local function makeCard(height, order)
                local p = palette()
                local f = Instance.new("Frame")
                f.Parent = spawnPage
                f.LayoutOrder = order or 1
                f.Size = UDim2.new(1, -6, 0, height)
                f.BackgroundColor3 = p.panel or T.panel
                f.BorderSizePixel = 0
                f:SetAttribute("KimqV26Role", "panel")
                corner(f, 14)
                stroke(f, p.line or p.stroke or T.stroke, .22, 1)
                return f
            end

            local intro = makeCard(76, 1)
            local introTitle = textLabel(intro, "♥  Spawn Point", UDim2.new(1,-24,0,28), UDim2.fromOffset(12,9), Enum.Font.FredokaOne, 20, palette().hot or T.hot)
            introTitle:SetAttribute("KimqV26Role", "hotText")
            local introSub = textLabel(intro, "Choose where your character returns after respawning.", UDim2.new(1,-24,0,28), UDim2.fromOffset(12,40), Enum.Font.Gotham, 12, palette().sub or T.sub)
            introSub.TextWrapped = true
            introSub:SetAttribute("KimqV26Role", "subText")

            local listCard = makeCard(330, 2)
            local listTitle = textLabel(listCard, "Available Spawn Points", UDim2.new(1,-130,0,24), UDim2.fromOffset(12,8), Enum.Font.GothamBold, 14, palette().text or T.text)
            listTitle:SetAttribute("KimqV26Role", "textText")

            local refreshBtn = Instance.new("TextButton")
            refreshBtn.Parent = listCard
            refreshBtn.Size = UDim2.fromOffset(104, 30)
            refreshBtn.Position = UDim2.new(1,-116,0,6)
            refreshBtn.BackgroundColor3 = palette().soft or T.bg2
            refreshBtn.BorderSizePixel = 0
            refreshBtn.Text = "refresh"
            refreshBtn.TextColor3 = palette().hot or T.hot
            refreshBtn.Font = Enum.Font.GothamSemibold
            refreshBtn.TextSize = 11
            refreshBtn:SetAttribute("KimqV26Role", "soft")
            corner(refreshBtn, 9)
            stroke(refreshBtn, palette().line or palette().stroke or T.stroke, .34, 1)

            local selectedLabel = textLabel(listCard, "Selected: Game Default", UDim2.new(1,-24,0,20), UDim2.fromOffset(12,38), Enum.Font.GothamSemibold, 11, palette().sub or T.sub)
            selectedLabel:SetAttribute("KimqV26Role", "subText")

            local spawnList = Instance.new("ScrollingFrame")
            spawnList.Parent = listCard
            spawnList.Size = UDim2.new(1,-20,0,218)
            spawnList.Position = UDim2.fromOffset(10,68)
            spawnList.BackgroundTransparency = 1
            spawnList.BorderSizePixel = 0
            spawnList.ScrollBarThickness = 3
            spawnList.ScrollBarImageColor3 = palette().hot or T.hot
            local spawnGrid = Instance.new("UIGridLayout", spawnList)
            spawnGrid.CellPadding = UDim2.fromOffset(7,7)
            spawnGrid.CellSize = UDim2.new(.5,-5,0,36)
            spawnGrid.SortOrder = Enum.SortOrder.LayoutOrder
            spawnGrid:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                spawnList.CanvasSize = UDim2.new(0,0,0,spawnGrid.AbsoluteContentSize.Y+8)
            end)

            local hint = textLabel(listCard, "Pick a point below, or use Game Default.", UDim2.new(1,-24,0,18), UDim2.fromOffset(12,302), Enum.Font.Gotham, 10, palette().sub or T.sub)
            hint:SetAttribute("KimqV26Role", "subText")

            local actionCard = makeCard(132, 3)
            local actionTitle = textLabel(actionCard, "Spawn Behavior", UDim2.new(1,-24,0,22), UDim2.fromOffset(12,8), Enum.Font.GothamBold, 14, palette().text or T.text)
            actionTitle:SetAttribute("KimqV26Role", "textText")
            local actionSub = textLabel(actionCard, "Use your selected point whenever your character respawns.", UDim2.new(1,-24,0,18), UDim2.fromOffset(12,31), Enum.Font.Gotham, 10, palette().sub or T.sub)
            actionSub:SetAttribute("KimqV26Role", "subText")

            local toggleLabel = textLabel(actionCard, "Use Selected Spawn", UDim2.new(0,220,0,28), UDim2.fromOffset(12,54), Enum.Font.GothamSemibold, 12, palette().text or T.text)
            toggleLabel:SetAttribute("KimqV26Role", "textText")
            local toggle = Instance.new("TextButton")
            toggle.Parent = actionCard
            toggle.Size = UDim2.fromOffset(48,24)
            toggle.Position = UDim2.new(0,228,0,56)
            toggle.Text = ""
            toggle.AutoButtonColor = false
            toggle.BorderSizePixel = 0
            corner(toggle, 999)
            local knob = Instance.new("Frame", toggle)
            knob.Size = UDim2.fromOffset(18,18)
            knob.Position = UDim2.new(0,3,.5,-9)
            knob.BackgroundColor3 = Color3.new(1,1,1)
            knob.BorderSizePixel = 0
            corner(knob, 999)

            local nowBtn = Instance.new("TextButton")
            nowBtn.Parent = actionCard
            nowBtn.Size = UDim2.fromOffset(150,32)
            nowBtn.Position = UDim2.new(1,-162,0,53)
            nowBtn.BackgroundColor3 = palette().soft or T.bg2
            nowBtn.BorderSizePixel = 0
            nowBtn.Text = "spawn here now"
            nowBtn.TextColor3 = palette().hot or T.hot
            nowBtn.Font = Enum.Font.GothamSemibold
            nowBtn.TextSize = 11
            nowBtn:SetAttribute("KimqV26Role", "soft")
            corner(nowBtn, 9)
            stroke(nowBtn, palette().line or palette().stroke or T.stroke, .34, 1)

            local behaviorStatus = textLabel(actionCard, "Game Default is active.", UDim2.new(1,-24,0,20), UDim2.fromOffset(12,98), Enum.Font.GothamSemibold, 10, palette().sub or T.sub)
            behaviorStatus:SetAttribute("KimqV26Role", "subText")

            local function normalizeName(v)
                return tostring(v or ""):lower():gsub("[%s_%-%[%]%(%)]+", "")
            end

            local function isSpawnContainerName(name)
                local n = normalizeName(name)
                return n=="spawns" or n=="spawnpoints" or n=="spawnlocations" or n=="playerspawns" or n=="teamspawns"
            end

            local function isSpawnCandidate(obj)
                if obj:IsA("SpawnLocation") then return true end
                if not obj:IsA("BasePart") then return false end
                local n = normalizeName(obj.Name)
                if n=="spawn" or n=="spawnpoint" or n=="spawnlocation" or n=="playerspawn" or n=="teamspawn" then return true end
                local p = obj.Parent
                if p and isSpawnContainerName(p.Name) then return true end
                local pp = p and p.Parent
                if pp and isSpawnContainerName(pp.Name) then return true end
                return false
            end

            local function pathFor(obj)
                local parts = {}
                local cur = obj
                while cur and cur ~= workspace do
                    table.insert(parts, 1, cur.Name)
                    cur = cur.Parent
                end
                return cur == workspace and parts or nil
            end

            local function resolvePath(parts)
                if type(parts) ~= "table" then return nil end
                local cur = workspace
                for _,name in ipairs(parts) do
                    if not cur then return nil end
                    cur = cur:FindFirstChild(tostring(name))
                end
                return cur
            end

            local function targetCFrame(obj)
                if obj and obj.Parent then
                    if obj:IsA("BasePart") then return obj.CFrame end
                    if obj:IsA("Model") then
                        local ok,cf = pcall(function() return obj:GetPivot() end)
                        if ok then return cf end
                    end
                end
                if type(fallbackPosition)=="table" then
                    local x,y,z=tonumber(fallbackPosition.X),tonumber(fallbackPosition.Y),tonumber(fallbackPosition.Z)
                    if x and y and z then return CFrame.new(x,y,z) end
                end
                return nil
            end

            local function setRespawnLocationProperty(obj)
                pcall(function()
                    if useSelectedSpawn then
                        if obj and obj:IsA("SpawnLocation") then
                            lp.RespawnLocation = obj
                        else
                            -- Generic map markers are handled by our one-time
                            -- post-respawn correction. Do not leave an older
                            -- Roblox SpawnLocation stuck here.
                            lp.RespawnLocation = nil
                        end
                    else
                        lp.RespawnLocation = nil
                    end
                end)
            end

            local function paintToggle()
                local p = palette()
                toggle.BackgroundColor3 = useSelectedSpawn and (p.hot or T.hot) or (p.soft or p.bg2 or T.bg2)
                knob.Position = useSelectedSpawn and UDim2.new(1,-21,.5,-9) or UDim2.new(0,3,.5,-9)
                behaviorStatus.Text = useSelectedSpawn and ("Respawning at: "..tostring(selectedName)) or "Game Default is active."
                behaviorStatus.TextColor3 = useSelectedSpawn and (p.hot or T.hot) or (p.sub or T.sub)
                selectedLabel.Text = "Selected: " .. tostring(selectedName)
            end

            local function zeroSpawnVelocity(char)
                if not char then return end
                for _,part in ipairs(char:GetDescendants()) do
                    if part:IsA("BasePart") then
                        pcall(function()
                            part.AssemblyLinearVelocity=Vector3.zero
                            part.AssemblyAngularVelocity=Vector3.zero
                        end)
                    end
                end
            end

            local function moveCharacter(char, forcePhysicalMove)
                if not useSelectedSpawn then return false end
                local obj = selectedSpawn
                if not (obj and obj.Parent) then obj = resolvePath(selectedPath); selectedSpawn = obj end
                if obj and obj:IsA("SpawnLocation") and not forcePhysicalMove then
                    setRespawnLocationProperty(obj)
                    return true
                end
                local cf = targetCFrame(obj)
                if not cf then return false end
                local root = char and (char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("UpperTorso") or char:FindFirstChild("Torso"))
                local hum = char and char:FindFirstChildOfClass("Humanoid")
                if not (root and root:IsA("BasePart")) then return false end
                local wasAnchored=root.Anchored
                zeroSpawnVelocity(char)
                pcall(function() root.Anchored=true end)
                local lift=math.max(4.5,(hum and hum.HipHeight or 2)+2.5)
                local ok=pcall(function() char:PivotTo(cf*CFrame.new(0,lift,0)) end)
                RunService.Heartbeat:Wait()
                zeroSpawnVelocity(char)
                pcall(function() root.Anchored=wasAnchored end)
                return ok
            end

            local function applySelected(obj, label, enable)
                selectedSpawn = obj
                selectedPath = obj and pathFor(obj) or nil
                selectedName = label or (obj and obj.Name) or "Game Default"
                if obj and obj:IsA("BasePart") then
                    fallbackPosition = {X=obj.Position.X,Y=obj.Position.Y,Z=obj.Position.Z}
                elseif not obj then
                    fallbackPosition = nil
                end
                if enable ~= nil then useSelectedSpawn = not not enable end
                setRespawnLocationProperty(obj)
                paintToggle()

                if useSelectedSpawn then
                    behaviorStatus.Text="Selected spawn locked: "..tostring(selectedName)
                    behaviorStatus.TextColor3=palette().hot or T.hot
                end
            end

            local function clearSpawnButtons()
                for _,ch in ipairs(spawnList:GetChildren()) do
                    if ch:IsA("TextButton") then ch:Destroy() end
                end
                table.clear(spawnEntries)
            end

            local function makeSpawnButton(label, obj, order, defaultButton)
                local p = palette()
                local b = Instance.new("TextButton")
                b.Parent = spawnList
                b.LayoutOrder = order
                b.BackgroundColor3 = p.soft or p.bg2 or T.bg2
                b.BorderSizePixel = 0
                b.Text = label
                b.TextColor3 = p.text or T.text
                b.Font = Enum.Font.GothamSemibold
                b.TextSize = 11
                b.TextWrapped = true
                b.AutoButtonColor = false
                b:SetAttribute("KimqV26Role", "soft")
                corner(b, 9)
                stroke(b, p.line or p.stroke or T.stroke, .38, 1)
                b.MouseButton1Click:Connect(function()
                    if defaultButton then
                        applySelected(nil, "Game Default", false)
                    else
                        applySelected(obj, label, true)
                    end
                    for _,entry in ipairs(spawnEntries) do
                        if entry.Button and entry.Button.Parent then
                            local chosen = (not defaultButton and entry.Object==selectedSpawn) or (defaultButton and entry.Default and not useSelectedSpawn)
                            local live = palette()
                            entry.Button.BackgroundColor3 = chosen and (live.hot or T.hot) or (live.soft or live.bg2 or T.bg2)
                            entry.Button.TextColor3 = chosen and Color3.new(1,1,1) or (live.text or T.text)
                        end
                    end
                end)
                table.insert(spawnEntries,{Button=b,Object=obj,Default=defaultButton})
                return b
            end

            local function displayNameFor(obj, used)
                local generic = normalizeName(obj.Name)
                local label = obj.Name
                if generic=="spawn" or generic=="spawnpoint" or generic=="spawnlocation" then
                    if obj.Parent and obj.Parent~=workspace then label = obj.Parent.Name end
                end
                local base = label
                local n = (used[base] or 0) + 1
                used[base] = n
                if n > 1 then label = base .. " #" .. n end
                return label
            end

            local function scanSpawnPoints()
                clearSpawnButtons()
                local found = {}
                for _,obj in ipairs(workspace:GetDescendants()) do
                    if isSpawnCandidate(obj) then table.insert(found,obj) end
                end
                table.sort(found,function(a,b)
                    local an,bn=tostring(a.Name):lower(),tostring(b.Name):lower()
                    if an~=bn then return an<bn end
                    return tostring(a:GetFullName())<tostring(b:GetFullName())
                end)
                local used = {}
                makeSpawnButton("Game Default", nil, 1, true)
                local order = 2
                for _,obj in ipairs(found) do
                    local label = displayNameFor(obj, used)
                    makeSpawnButton(label, obj, order, false)
                    order += 1
                end
                if #found==0 then
                    local p=palette()
                    local empty=Instance.new("TextButton")
                    empty.Parent=spawnList; empty.LayoutOrder=2; empty.BackgroundColor3=p.soft or T.bg2; empty.BorderSizePixel=0
                    empty.Text="No spawn points found"; empty.TextColor3=p.sub or T.sub; empty.Font=Enum.Font.GothamSemibold; empty.TextSize=11; empty.AutoButtonColor=false
                    corner(empty,9); stroke(empty,p.line or p.stroke or T.stroke,.45,1)
                end
                scannedOnce = true

                if selectedPath then
                    local resolved = resolvePath(selectedPath)
                    if resolved then selectedSpawn = resolved end
                end
                for _,entry in ipairs(spawnEntries) do
                    if entry.Button and entry.Button.Parent then
                        local chosen = (useSelectedSpawn and entry.Object==selectedSpawn) or ((not useSelectedSpawn) and entry.Default)
                        local p=palette()
                        entry.Button.BackgroundColor3=chosen and (p.hot or T.hot) or (p.soft or p.bg2 or T.bg2)
                        entry.Button.TextColor3=chosen and Color3.new(1,1,1) or (p.text or T.text)
                    end
                end
                paintToggle()
            end

            refreshBtn.MouseButton1Click:Connect(scanSpawnPoints)
            spawnPage:GetPropertyChangedSignal("Visible"):Connect(function()
                if spawnPage.Visible and not scannedOnce then task.defer(scanSpawnPoints) end
            end)

            toggle.MouseButton1Click:Connect(function()
                if not selectedSpawn and not selectedPath then
                    useSelectedSpawn = false
                    selectedName = "Game Default"
                else
                    useSelectedSpawn = not useSelectedSpawn
                end
                setRespawnLocationProperty(selectedSpawn)
                paintToggle()
            end)

            nowBtn.MouseButton1Click:Connect(function()
                if not selectedSpawn and not selectedPath then
                    behaviorStatus.Text = "Pick a spawn point first."
                    behaviorStatus.TextColor3 = palette().sub or T.sub
                    return
                end
                useSelectedSpawn = true
                setRespawnLocationProperty(selectedSpawn)
                local ok = moveCharacter(lp.Character,true)
                behaviorStatus.Text = ok and ("Moved to and locked: "..tostring(selectedName)) or "Could not move to that point."
                behaviorStatus.TextColor3 = ok and (palette().hot or T.hot) or (palette().sub or T.sub)
                task.delay(1.2,paintToggle)
            end)

            local spawnDeathConn=nil

            local function bindSpawnDeath(char)
                if spawnDeathConn then
                    pcall(function() spawnDeathConn:Disconnect() end)
                    spawnDeathConn=nil
                end
                if not char then return end
                local hum=char:FindFirstChildOfClass("Humanoid") or char:WaitForChild("Humanoid",5)
                if not hum then return end
                spawnDeathConn=hum.Died:Connect(function()
                    if not useSelectedSpawn then return end
                    local obj=selectedSpawn
                    if not (obj and obj.Parent) then
                        obj=resolvePath(selectedPath)
                        selectedSpawn=obj
                    end
                    -- Set this before Roblox chooses the next spawn.
                    setRespawnLocationProperty(obj)
                end)
            end

            if lp.Character then task.defer(bindSpawnDeath,lp.Character) end

            local spawnCorrectionSerial=0

            local function selectedTargetCFrame()
                local obj=selectedSpawn
                if not (obj and obj.Parent) then
                    obj=resolvePath(selectedPath)
                    if obj then selectedSpawn=obj end
                end
                return targetCFrame(obj)
            end

            local function isNearSelectedSpawn(char,maxDistance)
                local root=char and (char:FindFirstChild("HumanoidRootPart")
                    or char:FindFirstChild("UpperTorso")
                    or char:FindFirstChild("Torso"))
                local cf=selectedTargetCFrame()
                if not (root and root:IsA("BasePart") and cf) then return false end
                return (root.Position-cf.Position).Magnitude <= (maxDistance or 12)
            end

            local function beginSpawnCorrectionWindow(char)
                spawnCorrectionSerial += 1
                local mySerial=spawnCorrectionSerial

                task.spawn(function()
                    local root=char:WaitForChild("HumanoidRootPart",6)
                        or char:FindFirstChild("UpperTorso")
                        or char:FindFirstChild("Torso")
                    local hum=char:FindFirstChildOfClass("Humanoid") or char:WaitForChild("Humanoid",6)
                    if not root or not hum then return end

                    -- Let the game's own spawn/FFA logic settle, then do ONE
                    -- correction only if it ignored the selected point.
                    task.wait(1.35)

                    if mySerial~=spawnCorrectionSerial
                        or char~=lp.Character
                        or not char.Parent
                        or not useSelectedSpawn then
                        return
                    end

                    local obj=selectedSpawn
                    if not (obj and obj.Parent) then
                        obj=resolvePath(selectedPath)
                        if obj then selectedSpawn=obj end
                    end
                    setRespawnLocationProperty(obj)

                    if not isNearSelectedSpawn(char,18) then
                        moveCharacter(char,true)
                    end
                end)
            end
            lp.CharacterAdded:Connect(function(char)
                task.defer(bindSpawnDeath,char)
                if not useSelectedSpawn then return end

                local obj=selectedSpawn
                if not (obj and obj.Parent) then
                    obj=resolvePath(selectedPath)
                    if obj then selectedSpawn=obj end
                end

                -- Set the Roblox property as early as possible, then keep a
                -- short correction window in case the game's own round script
                -- teleports the character back to its normal spawn afterward.
                setRespawnLocationProperty(obj)
                beginSpawnCorrectionWindow(char)
            end)

            local function getSpawnConfig()
                return {
                    Enabled=useSelectedSpawn,
                    Name=selectedName,
                    Path=selectedPath,
                    Position=fallbackPosition,
                }
            end
            local function setSpawnConfig(v)
                if type(v)~="table" then return end
                useSelectedSpawn = not not v.Enabled
                selectedName = tostring(v.Name or "Game Default")
                selectedPath = type(v.Path)=="table" and v.Path or nil
                fallbackPosition = type(v.Position)=="table" and v.Position or nil
                selectedSpawn = resolvePath(selectedPath)
                if not selectedSpawn and not selectedPath then
                    useSelectedSpawn=false; selectedName="Game Default"
                end
                setRespawnLocationProperty(selectedSpawn)
                paintToggle()
                if scannedOnce then task.defer(scanSpawnPoints) end
            end
            if type(_G.KimqRegisterConfigControl)=="function" then
                _G.KimqRegisterConfigControl("Spawn Point", "state", getSpawnConfig, setSpawnConfig)
            end

            _G.KimqSpawnPointController = {
                Refresh=scanSpawnPoints,
                GetState=getSpawnConfig,
                SetState=setSpawnConfig,
                SpawnNow=function() return moveCharacter(lp.Character,true) end,
            }

            paintToggle()
        end
    end

    -- v2.1 canonical GUI hide/show: F1 ONLY.
    -- Do not rely on a separate uiShown boolean, because later visual passes can
    -- change Main.Visible and leave that boolean out of sync.
    UIS.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Keyboard
            and input.KeyCode == Enum.KeyCode.F1 then
            if main and main.Parent then
                local nextVisible=not main.Visible
                _G.KimqMainUserVisibleState=nextVisible
                pcall(function() if type(getgenv)=="function" then getgenv().KimqMainUserVisibleState=nextVisible end end)
                main.Visible=nextVisible
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
    _G.KimqBasePagesReady = true
end)


-- v2.1: legacy BlueFix2 visual pass removed for performance.

-- KIMQETRAS HC PAGE ASSIGNMENT REPAIR
-- One lightweight pass sorts controls by their own labels; it does not build another GUI.
task.spawn(function()
    local baseWait=tick()
    while not _G.KimqBasePagesReady and tick()-baseWait<8 do task.wait(.02) end

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
    -- Keep a live reference so the final theme engine can update callbacks that use T.
    _G.KimqThemePaletteRefs = _G.KimqThemePaletteRefs or {}
    table.insert(_G.KimqThemePaletteRefs, T)

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
        ["Use Silent Aim Keybind"] = "silent",
        ["Silent Aim Key"] = "silent",
        ["Show FOV Circle"] = "silent",
        ["FOV Size"] = "silent",
        ["Strict FOV"] = "silent",
        ["Filled FOV"] = "silent",
        ["FOV Opacity"] = "silent",
        ["Target Stickiness"] = "silent",
        ["Target Priority"] = "silent",
        ["Auto Prediction"] = "silent",
        ["Auto Prediction Strength"] = "silent",
        ["Silent Prediction X"] = "silent",
        ["Silent Prediction Y"] = "silent",
        ["Hit Chance"] = "silent",
        ["Bypass Revolver"] = "silent",
        ["Wall Check"] = "silent",
        ["Team Check"] = "silent",
        ["Target Closest Part"] = "silent",
        ["Hit Part"] = "silent",
        ["Max Target Distance"] = "silent",
        ["Prediction X"] = "silent",
        ["Prediction Y"] = "silent",
        ["Shot Camera Swap"] = "silent",
        ["Random Camera Zoom"] = "silent",
        ["Knock Check"] = "silent",
        -- compatibility with older labels
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
        ["Keep Avatar After Respawn"] = "avatar",
        ["Visual Headless"] = "avatar",
        ["♥  Apply User Avatar"] = "avatar",
        ["Apply User Avatar"] = "avatar",
        ["Reset to My Avatar"] = "avatar",

        ["HC Silent Aim"] = "hcsilent",
        ["HC Revolver Bypass"] = "hcsilent",
        ["HC Wall Check"] = "hcsilent",
        ["HC Knock Check"] = "hcsilent",
        ["HC FOV Radius"] = "hcsilent",
        ["HC Hit Part"] = "hcsilent",
        ["HC Prediction"] = "hcsilent",
        ["HC Prediction Amount"] = "hcsilent",
        ["HC Godmode"] = "hcsilent",

        ["Force Hit"] = "hcsilent",
        ["Force Hit Mode"] = "hcsilent",
        ["Force Hit FOV"] = "hcsilent",
        ["Force Hit Tracer"] = "hcsilent",
        ["Force Hit Full Auto"] = "hcsilent",
        ["Force Hit Fire Rate"] = "hcsilent",

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

        ["Headless Mode"] = "avatar",

        ["KIM Anti Aim View"] = "antimod",
        ["Anti Mod Notify"] = "antimod",
        ["Anti Mod Kick"] = "antimod",
        ["Anti Mod Kick Delay"] = "antimod",
        ["Anti Mod controls are OFF here by default so the script does not kick you unless you choose to enable it."] = "antimod",

        ["FPS Unlocker"] = "settings",
        ["Target FPS"] = "settings",
        ["Config Name"] = "settings",
        ["Save KIM Config"] = "settings",
        ["Load KIM Config"] = "settings",
        ["Delete KIM Config"] = "settings",
        ["Saved Configs"] = "settings",
        ["Save Current Config"] = "settings",
        ["Update Selected Config"] = "settings",
        ["Load Selected Config"] = "settings",
        ["Delete Selected Config"] = "settings",
        ["Refresh Config List"] = "settings",
        ["Configs save your setup, including the exact fog color and amount, so it comes back the same when loaded."] = "settings",
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

    -- Move cards by their creation-time ownership stamp.  Exact label mapping
    -- remains only as a compatibility fallback for truly old untagged cards.
    for _, obj in ipairs(all) do
        if obj.Parent and not isSectionHeader(obj) then
            local stamped = obj:GetAttribute("KimqSection")
            if stamped=="forcehit" then stamped="hcsilent" end
            if stamped=="headless" then stamped="avatar" end
            local key = stamped
            if not (key and pages[key]) then
                local t = controlLabel(obj)
                key = t and exact[t]
            end
            if key and pages[key] then
                obj.Parent = pages[key]
            end
        end
    end

    -- Legacy builds created dropdown option ScrollingFrames as standalone page rows.
    -- The current addDropdown no longer does that; remove any orphan leftovers so
    -- an option list can never appear in Silent Aim or another unrelated page.
    for _, page in pairs(pages) do
        for _, obj in ipairs(page:GetChildren()) do
            if obj:IsA("ScrollingFrame") and obj.Name == "KimqDropdownOptions" then
                -- New dropdowns are children of their card, never direct children of a page.
                obj:Destroy()
            end
        end
    end

    -- Dynamic Whitelist player cards already receive KimqSection="whitelist"
    -- when they are created. Use that exact ownership stamp only.
    --
    -- IMPORTANT: do NOT infer Whitelist from an ON/OFF button. RAGE, Anti Fall,
    -- Protection, etc. also contain ON/OFF toggles and must stay on their pages.
    if pages.whitelist then
        for _, page in pairs(pages) do
            if page ~= pages.overview and page ~= pages.whitelist then
                local moving = {}
                for _, obj in ipairs(page:GetChildren()) do
                    if obj:IsA("Frame") and obj:GetAttribute("KimqSection")=="whitelist" then
                        table.insert(moving,obj)
                    end
                end
                for _,obj in ipairs(moving) do
                    obj.Parent=pages.whitelist
                end
            end
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

    -- Overview rendering is owned by the final v2.1 builder; no temporary V3 overview is created.

    -- Clean Information page: text-only credits, intentionally simple and theme-safe.
    local info = pages.info
    if info then
        for _, ch in ipairs(info:GetChildren()) do
            if not ch:IsA("UIListLayout") and not ch:IsA("UIPadding") then pcall(function() ch:Destroy() end) end
        end

        local cardInfo = Instance.new("Frame")
        cardInfo.Name = "KimqInformationCard"
        cardInfo.Parent = info
        cardInfo.Size = UDim2.new(1,-6,0,144)
        cardInfo.LayoutOrder = -100
        cardInfo.BackgroundColor3 = T.panel
        cardInfo.BorderSizePixel = 0
        cardInfo:SetAttribute("KimqV26Role","panel")
        corner(cardInfo,18)
        stroke(cardInfo,T.stroke,0.2,1)

        local infoTitle=label(cardInfo,"♥  information",UDim2.new(1,-24,0,28),UDim2.fromOffset(12,10),Enum.Font.GothamSemibold,20,T.hot)
        infoTitle:SetAttribute("KimqV26Role","hotText")
        local infoSub=label(cardInfo,"Kimqetras HC ♡",UDim2.new(1,-24,0,18),UDim2.fromOffset(12,38),Enum.Font.Gotham,12,T.sub)
        infoSub:SetAttribute("KimqV26Role","subText")

        local kimName=label(cardInfo,"kimqetras",UDim2.new(0,160,0,25),UDim2.fromOffset(16,67),Enum.Font.GothamSemibold,14,T.hot)
        kimName:SetAttribute("KimqV26Role","hotText")
        local kimRole=label(cardInfo,"owner ♡",UDim2.new(1,-202,0,25),UDim2.fromOffset(188,67),Enum.Font.Gotham,12,T.sub,Enum.TextXAlignment.Right)
        kimRole:SetAttribute("KimqV26Role","subText")

        local fameName=label(cardInfo,"famesgun",UDim2.new(0,160,0,25),UDim2.fromOffset(16,101),Enum.Font.GothamSemibold,14,T.hot)
        fameName:SetAttribute("KimqV26Role","hotText")
        local fameRole=label(cardInfo,"original developer / scripter",UDim2.new(1,-202,0,25),UDim2.fromOffset(188,101),Enum.Font.Gotham,12,T.sub,Enum.TextXAlignment.Right)
        fameRole:SetAttribute("KimqV26Role","subText")
    end

    -- Add a visible V3 badge so the user can immediately tell this file loaded.
    local badge = Instance.new("TextLabel")
    badge.Name = "V3Badge"
    badge.Parent = main
    badge.Size = UDim2.fromOffset(54,22)
    badge.Position = UDim2.new(1,-68,0,76)
    badge.BackgroundColor3 = T.hot
    badge.BorderSizePixel = 0
    badge.Text = "v2.4 ♡"
    badge.TextColor3 = T.white
    badge.Font = Enum.Font.FredokaOne
    badge.TextSize = 12
    badge.ZIndex = 60
    corner(badge,999)
    _G.KimqPageRepairReady = true
end)

-- ========================================================
-- v2.1 CLEAN BUILD: legacy V5/V6/V7/V8 visual/theme layers removed.
-- The page/backend layer remains intact; a single lightweight v2.1 theme pass runs at the end.

-- v2.62 module: local catalog / limited accessory try-on.
task.spawn(function()
    _G.KimqAccessoryUIReady=false
    local Players = game:GetService("Players")
    local CoreGui = game:GetService("CoreGui")
    local TweenService = game:GetService("TweenService")
    local MarketplaceService = game:GetService("MarketplaceService")
    local InsertService = game:GetService("InsertService")

    local lp = Players.LocalPlayer
    local playerGui = lp:WaitForChild("PlayerGui")
    _G.KimqLocalVisualAccessoriesV15 = _G.KimqLocalVisualAccessoriesV15 or {}

    local pageReadyStart=tick()
    while not _G.KimqBasePagesReady and tick()-pageReadyStart<8 do task.wait(.02) end

    local function waitForMain(timeout)
        local t0 = tick()
        while tick() - t0 < (timeout or 20) do
            local root = CoreGui:FindFirstChild("KimpetrasHC") or playerGui:FindFirstChild("KimpetrasHC")
            local main = root and root:FindFirstChild("Main")
            if main then return root, main end
            task.wait(0.08)
        end
    end

    local rootGui, main = waitForMain(10)
    if not rootGui or not main then _G.KimqAccessoryUIReady=true; return end
    if main:FindFirstChild("KimqV15AccessoryApplied") then _G.KimqAccessoryUIReady=true; return end

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
    if not avatarPage then _G.KimqAccessoryUIReady=true; return end

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
    titleLbl.Text = "Wear Item by ID"
    titleLbl.TextColor3 = textColor
    titleLbl.Font = Enum.Font.GothamBold
    titleLbl.TextSize = 14
    titleLbl.TextXAlignment = Enum.TextXAlignment.Left

    local titleSub = Instance.new("TextLabel")
    titleSub.Parent = titleRow
    titleSub.Size = UDim2.new(0.62, -20, 1, 0)
    titleSub.Position = UDim2.new(0.38, 8, 0, 0)
    titleSub.BackgroundTransparency = 1
    titleSub.Text = "catalog / limited accessory • local only"
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
    inputLbl.Text = "Catalog Item ID"
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
    input.PlaceholderText = "paste ID or catalog link..."
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
    equip.Text = "♥  Wear Item"
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

    local function findAvatarAttachPair(character, handle)
        if not character or not handle then return nil end

        -- Match ANY normal Roblox accessory attachment (hat/hair/face/back/waist/
        -- shoulder/neck/front/etc.) instead of restricting the feature to head items.
        for _,handleAtt in ipairs(handle:GetChildren()) do
            if handleAtt:IsA("Attachment") then
                for _,bodyAtt in ipairs(character:GetDescendants()) do
                    if bodyAtt:IsA("Attachment")
                        and bodyAtt.Name==handleAtt.Name
                        and bodyAtt.Parent
                        and bodyAtt.Parent:IsA("BasePart") then
                        return bodyAtt.Parent, bodyAtt, handleAtt
                    end
                end
            end
        end

        -- Classic fallback.
        local head=character:FindFirstChild("Head")
        local handleHat=handle:FindFirstChild("HatAttachment")
        local headHat=head and head:FindFirstChild("HatAttachment")
        if head and handleHat and headHat then return head,headHat,handleHat end
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

        local bodyPart, bodyAtt, handleAtt = findAvatarAttachPair(char, handle)
        if not bodyPart or not bodyAtt or not handleAtt then
            pcall(function() acc:Destroy() end)
            if not quiet then setStatus("That accessory attachment is not supported", false) end
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
            setStatus("Enter an item ID or catalog link", false)
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
            if equip.Parent then equip.Text = "♥  Wear Item" end
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

    local function getAccessoryConfigState()
        local ids = {}
        for _, assetId in ipairs(_G.KimqLocalVisualAccessoriesV15 or {}) do
            if tonumber(assetId) then table.insert(ids, tonumber(assetId)) end
        end
        return {input=tostring(input.Text or ""), ids=ids}
    end
    local function setAccessoryConfigState(state)
        if type(state) ~= "table" then return end
        input.Text = tostring(state.input or "")
        removeAll()
        table.clear(_G.KimqLocalVisualAccessoriesV15)
        for _, rawId in ipairs(type(state.ids)=="table" and state.ids or {}) do
            local assetId = tonumber(rawId)
            if assetId then saveId(assetId) end
        end
        if lp.Character and #_G.KimqLocalVisualAccessoriesV15 > 0 then
            task.spawn(function()
                for _, assetId in ipairs(_G.KimqLocalVisualAccessoriesV15) do
                    attachAccessory(assetId, lp.Character, true)
                    task.wait(0.08)
                end
                setStatus("Restored saved accessories", true)
            end)
        end
    end
    _G.KimqAccessoryController = {
        GetState=getAccessoryConfigState,
        SetState=setAccessoryConfigState,
        Equip=attachAccessory,
        RemoveAll=removeAll,
    }
    if type(_G.KimqRegisterConfigControl) == "function" then
        _G.KimqRegisterConfigControl("Local Accessories", "state", getAccessoryConfigState, setAccessoryConfigState)
    end

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
    _G.KimqAccessoryUIReady=true
end)


-- ========================================================


-- v2.62 module: Environment + Weapon Skins (canonical sidebar pages).
task.spawn(function()
    local pageReadyStart=tick()
    while not _G.KimqBasePagesReady and tick()-pageReadyStart<8 do task.wait(.02) end

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

    setProgress("fixing the final pages...", .91)

    local root = CoreGui:FindFirstChild("KimpetrasHC") or pg:FindFirstChild("KimpetrasHC")
    local main = root and root:FindFirstChild("Main")
    if not main then
        _G.KimqV26FeaturesReady=true
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
        _G.KimqV26FeaturesReady=true; return
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
        _G.KimqV26FeaturesReady=true; return
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
    if not inactiveTemplate then _G.KimqV26FeaturesReady=true; return end

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
    local function pcolor(key,fallback)
        local p=_G.KimqThemeLivePalette
        if type(p)=="table" and p[key] then return p[key] end
        return fallback
    end

    -- v2.62: Environment and Weapon Skins are already real canonical pages/buttons.
    -- Populate those pages instead of deleting/recreating navigation after startup.
    local function card(page,h)
        local f=Instance.new("Frame",page); f.Size=UDim2.new(1,-6,0,h or 56); f.BackgroundColor3=panelColor; f.BorderSizePixel=0; corner(f,14); stroke(f,lineColor,.2,1); return f
    end

    local envPage=pages.environment
    local skinsPage=pages.weaponskins
    if not envPage or not skinsPage then
        _G.KimqV26FeaturesReady=true
        return
    end

    -- Clear only old content frames if this module is ever rebuilt; keep layout/padding.
    for _,page in ipairs({envPage,skinsPage}) do
        for _,ch in ipairs(page:GetChildren()) do
            if not ch:IsA("UIListLayout") and not ch:IsA("UIPadding") then
                pcall(function() ch:Destroy() end)
            end
        end
    end

    local envBtn,skinsBtn
    for _,b in ipairs(nav:GetChildren()) do
        if b:IsA("TextButton") then
            local n=norm(b.Text)
            if n=="environment" then envBtn=b end
            if n=="weapon skins" then skinsBtn=b end
        end
    end
    if not envBtn or not skinsBtn then
        _G.KimqV26FeaturesReady=true
        return
    end

    local envBuildOk, envBuildErr = pcall(function()
    -- Environment ----------------------------------------------------------
    pcall(function() if _G.KimqEnvironmentController and _G.KimqEnvironmentController.Restore then _G.KimqEnvironmentController.Restore() end end)
    for _,n in ipairs({"KimqV20Environment","KimqV21Environment","KimqV26Environment"}) do local x=workspace:FindFirstChild(n); if x then x:Destroy() end end
    local oldCC=Lighting:FindFirstChild("KimqV21SeasonColor"); if oldCC then oldCC:Destroy() end

    local ei=card(envPage,78)
    local eiTitle=txt(ei,"♥  environment",UDim2.new(1,-24,0,28),UDim2.fromOffset(12,9),Enum.Font.FredokaOne,21,hotColor)
    local eiSub=txt(ei,"Change the overall environment style.",UDim2.new(1,-24,0,30),UDim2.fromOffset(12,40),Enum.Font.Gotham,12,subColor); eiSub.TextWrapped=true

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
    if type(_G.KimqRegisterConfigControl) == "function" then
        _G.KimqRegisterConfigControl("Environment Preset", "dropdown",
            function() return activePreset end,
            function(v)
                v=tostring(v or "Normal")
                if v~="Normal" and v~="Christmas" and v~="Halloween" then v="Normal" end
                applyEnv(v)
            end
        )
    end

    -- Permanent Day / Night. Only ClockTime is locked; the game's own sky, colors,
    -- fog and environment remain intact. This prevents competing time loops from flashing.
    local timeMode="Game Default"
    local nightLights=false
    local DAY_CLOCK=tonumber(original.ClockTime) or 14
    if DAY_CLOCK<6 or DAY_CLOCK>18 then DAY_CLOCK=14 end
    local NIGHT_CLOCK=0
    local forcingClock=false
    local lightOriginal=setmetatable({}, {__mode="k"})
    local lightConnections=setmetatable({}, {__mode="k"})

    local function isMapLight(light)
        if not (light:IsA("PointLight") or light:IsA("SpotLight") or light:IsA("SurfaceLight")) then return false end
        for _,plr in ipairs(Players:GetPlayers()) do
            if plr.Character and light:IsDescendantOf(plr.Character) then return false end
        end
        local cur=light.Parent
        while cur and cur~=workspace do
            local n=tostring(cur.Name):lower()
            if n:find("bullet",1,true) or n:find("tracer",1,true) or n:find("projectile",1,true) or n:find("muzzle",1,true) or n=="ignore" then return false end
            cur=cur.Parent
        end
        return true
    end
    local function rememberMapLight(light)
        if not isMapLight(light) then return end
        if lightOriginal[light]==nil then lightOriginal[light]=light.Enabled end
        if not lightConnections[light] then
            lightConnections[light]=light:GetPropertyChangedSignal("Enabled"):Connect(function()
                if timeMode=="Night" and nightLights and light.Parent and not light.Enabled then
                    pcall(function() light.Enabled=true end)
                end
            end)
        end
        if timeMode=="Night" and nightLights then pcall(function() light.Enabled=true end) end
    end
    local function scanMapLights()
        for _,d in ipairs(workspace:GetDescendants()) do if isMapLight(d) then rememberMapLight(d) end end
    end
    workspace.DescendantAdded:Connect(function(d)
        if (d:IsA("PointLight") or d:IsA("SpotLight") or d:IsA("SurfaceLight")) then
            task.defer(function() if d.Parent then rememberMapLight(d) end end)
        end
    end)
    local function applyNightLights()
        if nightLights and timeMode=="Night" then scanMapLights() end
        local forceOn=nightLights and timeMode=="Night"
        for light,wasEnabled in pairs(lightOriginal) do
            if light and light.Parent then pcall(function() light.Enabled=forceOn and true or wasEnabled end) end
        end
    end
    local function wantedClock()
        if timeMode=="Day" then return DAY_CLOCK end
        if timeMode=="Night" then return NIGHT_CLOCK end
        return nil
    end
    local function enforceClock()
        local wanted=wantedClock(); if wanted==nil then return end
        if math.abs(Lighting.ClockTime-wanted)>.005 then
            forcingClock=true
            pcall(function() Lighting.ClockTime=wanted end)
            forcingClock=false
        end
    end

    local timeCard=card(envPage,184); timeCard.Name="KimqTimeOfDayCard"
    txt(timeCard,"♥  Day / Night",UDim2.new(1,-24,0,24),UDim2.fromOffset(12,8),Enum.Font.GothamBold,14,textColor)
    local timeSub=txt(timeCard,"Choose a permanent time. The game can keep running its clock script without changing your sky.",UDim2.new(1,-24,0,34),UDim2.fromOffset(12,31),Enum.Font.Gotham,10,subColor); timeSub.TextWrapped=true
    local function timeButton(label,x,w)
        local b=Instance.new("TextButton",timeCard); b.Size=UDim2.new(w,-6,0,34); b.Position=UDim2.new(x,6,0,70); b.BackgroundColor3=lightColor; b.BorderSizePixel=0; b.Text=label; b.TextColor3=textColor; b.Font=Enum.Font.GothamSemibold; b.TextSize=11; b.AutoButtonColor=false; corner(b,9); stroke(b,lineColor,.3,1); return b
    end
    local defaultTimeBtn=timeButton("game default",0,.34)
    local dayTimeBtn=timeButton("day",.34,.33)
    local nightTimeBtn=timeButton("night",.67,.33)
    txt(timeCard,"Night Lights",UDim2.new(0,180,0,24),UDim2.fromOffset(12,116),Enum.Font.GothamSemibold,11,textColor)
    local nightToggle=Instance.new("TextButton",timeCard); nightToggle.Size=UDim2.fromOffset(48,24); nightToggle.Position=UDim2.fromOffset(196,116); nightToggle.Text=""; nightToggle.AutoButtonColor=false; nightToggle.BorderSizePixel=0; corner(nightToggle,999)
    local nightKnob=Instance.new("Frame",nightToggle); nightKnob.Size=UDim2.fromOffset(18,18); nightKnob.Position=UDim2.new(0,3,.5,-9); nightKnob.BackgroundColor3=Color3.new(1,1,1); nightKnob.BorderSizePixel=0; corner(nightKnob,999)
    local timeStatus=txt(timeCard,"Game clock is unchanged.",UDim2.new(1,-24,0,26),UDim2.fromOffset(12,150),Enum.Font.Gotham,10,subColor); timeStatus.TextWrapped=true
    local function refreshTimeUI()
        local function style(b,on) b.BackgroundColor3=on and pcolor("hot",hotColor) or pcolor("soft",lightColor); b.TextColor3=on and Color3.new(1,1,1) or pcolor("text",textColor) end
        style(defaultTimeBtn,timeMode=="Game Default"); style(dayTimeBtn,timeMode=="Day"); style(nightTimeBtn,timeMode=="Night")
        nightToggle.BackgroundColor3=nightLights and pcolor("hot",hotColor) or pcolor("soft",lightColor)
        nightKnob.Position=nightLights and UDim2.new(1,-21,.5,-9) or UDim2.new(0,3,.5,-9)
        if timeMode=="Day" then timeStatus.Text="Day is locked to the game's normal daylight look."
        elseif timeMode=="Night" then timeStatus.Text=nightLights and "Midnight locked • map lights on ♡" or "Midnight locked."
        else timeStatus.Text="Game clock is unchanged." end
        timeStatus.TextColor3=timeMode=="Game Default" and pcolor("sub",subColor) or pcolor("hot",hotColor)
    end
    local function setTimeMode(mode)
        if mode~="Day" and mode~="Night" then mode="Game Default" end
        timeMode=mode
        if timeMode=="Game Default" then
            forcingClock=true; pcall(function() Lighting.ClockTime=original.ClockTime end); forcingClock=false
        else enforceClock() end
        applyNightLights(); refreshTimeUI()
    end
    defaultTimeBtn.MouseButton1Click:Connect(function() setTimeMode("Game Default") end)
    dayTimeBtn.MouseButton1Click:Connect(function() setTimeMode("Day") end)
    nightTimeBtn.MouseButton1Click:Connect(function() setTimeMode("Night") end)
    nightToggle.MouseButton1Click:Connect(function() nightLights=not nightLights; applyNightLights(); refreshTimeUI() end)
    Lighting:GetPropertyChangedSignal("ClockTime"):Connect(function() if not forcingClock and wantedClock()~=nil then enforceClock() end end)
    pcall(function()
        RunService:BindToRenderStep("KimqPermanentTimeV261",Enum.RenderPriority.Last.Value,function()
            if wantedClock()~=nil then enforceClock() end
        end)
    end)
    refreshTimeUI()
    _G.KimqEnvironmentController.SetTimeMode=setTimeMode
    _G.KimqEnvironmentController.GetTimeMode=function() return timeMode end
    _G.KimqEnvironmentController.SetNightLights=function(v) nightLights=not not v; applyNightLights(); refreshTimeUI() end
    _G.KimqEnvironmentController.GetNightLights=function() return nightLights end
    if type(_G.KimqRegisterConfigControl)=="function" then
        _G.KimqRegisterConfigControl("Time of Day","dropdown",function() return timeMode end,function(v) setTimeMode(tostring(v or "Game Default")) end)
        _G.KimqRegisterConfigControl("Night Lights","toggle",function() return nightLights end,function(v) nightLights=not not v; applyNightLights(); refreshTimeUI() end)
    end

    end)

    if not envBuildOk then
        warn("[Kimqetras HC v2.63] Environment page fallback: "..tostring(envBuildErr))

        -- If a seasonal/environment-specific part fails in a particular game,
        -- keep the core Day / Night controls available instead of aborting the
        -- entire Weapon Skins builder.
        for _,ch in ipairs(envPage:GetChildren()) do
            if not ch:IsA("UIListLayout") and not ch:IsA("UIPadding") then
                pcall(function() ch:Destroy() end)
            end
        end

        local fallbackTitle=card(envPage,70)
        txt(fallbackTitle,"♥  environment",UDim2.new(1,-24,0,26),UDim2.fromOffset(12,8),Enum.Font.FredokaOne,20,hotColor)
        local fbSub=txt(fallbackTitle,"Day / night controls are available. Seasonal effects were skipped for compatibility.",UDim2.new(1,-24,0,28),UDim2.fromOffset(12,35),Enum.Font.Gotham,11,subColor)
        fbSub.TextWrapped=true

        local fallbackMode="Game Default"
        local fallbackDay=Lighting.ClockTime
        if fallbackDay < 6 or fallbackDay >= 18 then fallbackDay=12 end
        local fallbackLocked=false
        local fallbackNightLights=false
        local rememberedLights=setmetatable({}, {__mode="k"})

        local function lightLooksGameplay(light)
            local n=tostring(light.Name or ""):lower()
            if n:find("bullet",1,true) or n:find("tracer",1,true) or n:find("muzzle",1,true)
                or n:find("ray",1,true) or n:find("projectile",1,true) then
                return true
            end
            local p=light.Parent
            if p then
                local pn=tostring(p.Name or ""):lower()
                if pn:find("bullet",1,true) or pn:find("tracer",1,true) or pn:find("muzzle",1,true)
                    or pn:find("ray",1,true) or pn:find("projectile",1,true) then
                    return true
                end
            end
            return false
        end

        local function restoreRememberedLights()
            for light,enabled in pairs(rememberedLights) do
                if light and light.Parent then pcall(function() light.Enabled=enabled end) end
            end
            table.clear(rememberedLights)
        end

        local function applyFallbackLights()
            if not fallbackNightLights or fallbackMode~="Night" then
                restoreRememberedLights()
                return
            end
            for _,rootObj in ipairs({workspace,Lighting}) do
                for _,d in ipairs(rootObj:GetDescendants()) do
                    if d:IsA("Light") and not lightLooksGameplay(d) then
                        if rememberedLights[d]==nil then rememberedLights[d]=d.Enabled end
                        pcall(function() d.Enabled=true end)
                    end
                end
            end
        end

        local function setFallbackMode(mode)
            mode=tostring(mode or "Game Default")
            if mode~="Game Default" and mode~="Day" and mode~="Night" then mode="Game Default" end
            fallbackMode=mode
            fallbackLocked=mode~="Game Default"
            if mode=="Day" then Lighting.ClockTime=fallbackDay end
            if mode=="Night" then Lighting.ClockTime=0 end
            if mode=="Game Default" then restoreRememberedLights() end
            applyFallbackLights()
        end

        local fallbackConn=RunService.RenderStepped:Connect(function()
            if fallbackLocked then
                local wanted=(fallbackMode=="Night") and 0 or fallbackDay
                if math.abs(Lighting.ClockTime-wanted)>.01 then
                    Lighting.ClockTime=wanted
                end
            end
        end)

        local modeCard=card(envPage,112)
        txt(modeCard,"Time of Day",UDim2.new(1,-24,0,22),UDim2.fromOffset(12,8),Enum.Font.GothamBold,14,textColor)

        local modeButtons={}
        local modes={"Game Default","Day","Night"}
        for i,name in ipairs(modes) do
            local b=Instance.new("TextButton",modeCard)
            b.Size=UDim2.new(1/3,-10,0,34)
            b.Position=UDim2.new((i-1)/3,6+(i-1)*2,0,39)
            b.BackgroundColor3=(name=="Game Default") and hotColor or lightColor
            b.BorderSizePixel=0
            b.Text=name
            b.TextColor3=(name=="Game Default") and Color3.new(1,1,1) or textColor
            b.Font=Enum.Font.GothamBold
            b.TextSize=11
            corner(b,9)
            stroke(b,lineColor,.3,1)
            modeButtons[name]=b
            b.MouseButton1Click:Connect(function()
                setFallbackMode(name)
                for _,modeName in ipairs(modes) do
                    local mb=modeButtons[modeName]
                    local on=modeName==fallbackMode
                    mb.BackgroundColor3=on and hotColor or lightColor
                    mb.TextColor3=on and Color3.new(1,1,1) or textColor
                end
            end)
        end

        local lightButton=Instance.new("TextButton",modeCard)
        lightButton.Size=UDim2.new(1,-24,0,28)
        lightButton.Position=UDim2.fromOffset(12,79)
        lightButton.BackgroundColor3=lightColor
        lightButton.BorderSizePixel=0
        lightButton.Text="Night Lights: OFF"
        lightButton.TextColor3=textColor
        lightButton.Font=Enum.Font.GothamBold
        lightButton.TextSize=11
        corner(lightButton,9)
        stroke(lightButton,lineColor,.3,1)
        lightButton.MouseButton1Click:Connect(function()
            fallbackNightLights=not fallbackNightLights
            lightButton.Text="Night Lights: "..(fallbackNightLights and "ON" or "OFF")
            applyFallbackLights()
        end)

        _G.KimqEnvironmentController={
            Apply=function() end,
            Restore=function()
                fallbackLocked=false
                fallbackMode="Game Default"
                restoreRememberedLights()
            end,
            GetPreset=function() return "Normal" end,
            SetTimeMode=setFallbackMode,
            GetTimeMode=function() return fallbackMode end,
            SetNightLights=function(v)
                fallbackNightLights=not not v
                lightButton.Text="Night Lights: "..(fallbackNightLights and "ON" or "OFF")
                applyFallbackLights()
            end,
            GetNightLights=function() return fallbackNightLights end,
        }

        if type(_G.KimqRegisterConfigControl)=="function" then
            _G.KimqRegisterConfigControl("Time of Day","dropdown",
                function() return fallbackMode end,
                function(v) setFallbackMode(tostring(v or "Game Default")) end)
            _G.KimqRegisterConfigControl("Night Lights","toggle",
                function() return fallbackNightLights end,
                function(v)
                    fallbackNightLights=not not v
                    lightButton.Text="Night Lights: "..(fallbackNightLights and "ON" or "OFF")
                    applyFallbackLights()
                end)
        end
    end

    setProgress("finding all of the weapon skins...", .95)

    -- Weapon skins --------------------------------------------------------
    local wi=card(skinsPage,76)
    local wiTitle=txt(wi,"♥  weapon skins",UDim2.new(1,-24,0,28),UDim2.fromOffset(12,9),Enum.Font.FredokaOne,21,hotColor)
    local wiSub=txt(wi,"Customize the look of your weapons and items.",UDim2.new(1,-24,0,28),UDim2.fromOffset(12,40),Enum.Font.Gotham,12,subColor)

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

    -- Static hover preview for the selected weapon's skins.
    -- No platform, no animation, no scripts: just the authored visual.
    local skinPreviewCard=card(skinsPage,230)
    skinPreviewCard.Name="KimqWeaponSkinHoverPreviewCard"
    local skinPreviewTitle=txt(
        skinPreviewCard,
        "Hover a skin to preview it",
        UDim2.new(1,-24,0,24),
        UDim2.fromOffset(12,7),
        Enum.Font.GothamBold,12,textColor
    )

    local skinPreviewBackdrop=Instance.new("Frame")
    skinPreviewBackdrop.Name="KimqWeaponSkinPreviewBackdrop"
    skinPreviewBackdrop.Parent=skinPreviewCard
    skinPreviewBackdrop.Position=UDim2.fromOffset(10,38)
    skinPreviewBackdrop.Size=UDim2.new(1,-20,1,-48)
    skinPreviewBackdrop.BackgroundColor3=lightColor
    skinPreviewBackdrop.BorderSizePixel=0
    corner(skinPreviewBackdrop,11)
    stroke(skinPreviewBackdrop,lineColor,.35,1)

    local skinPreviewGradient=Instance.new("UIGradient")
    skinPreviewGradient.Name="KimqWeaponSkinPreviewGradient"
    skinPreviewGradient.Parent=skinPreviewBackdrop
    skinPreviewGradient.Color=ColorSequence.new({
        ColorSequenceKeypoint.new(0,lightColor),
        ColorSequenceKeypoint.new(.55,lightColor),
        ColorSequenceKeypoint.new(1,hotColor),
    })
    skinPreviewGradient.Rotation=90

    local skinPreviewGlow=Instance.new("Frame")
    skinPreviewGlow.Name="Glow"
    skinPreviewGlow.Parent=skinPreviewBackdrop
    skinPreviewGlow.AnchorPoint=Vector2.new(.5,.5)
    skinPreviewGlow.Position=UDim2.fromScale(.5,.53)
    skinPreviewGlow.Size=UDim2.fromOffset(154,154)
    skinPreviewGlow.BackgroundColor3=Color3.new(1,1,1)
    skinPreviewGlow.BackgroundTransparency=.88
    skinPreviewGlow.BorderSizePixel=0
    corner(skinPreviewGlow,999)

    local skinPreview=Instance.new("ViewportFrame")
    skinPreview.Name="KimqWeaponSkinHoverPreview"
    skinPreview.Parent=skinPreviewBackdrop
    skinPreview.Position=UDim2.fromOffset(0,0)
    skinPreview.Size=UDim2.fromScale(1,1)
    skinPreview.BackgroundTransparency=1
    skinPreview.BorderSizePixel=0
    skinPreview.Ambient=Color3.new(1,1,1)
    skinPreview.LightColor=Color3.new(1,1,1)
    skinPreview.LightDirection=Vector3.new(-1,-1,-1)
    corner(skinPreview,11)

    -- Live theme sync, local to this preview only.
    local skinPreviewThemeClock=0
    local skinPreviewThemeConn
    skinPreviewThemeConn=RunService.Heartbeat:Connect(function(dt)
        if not skinPreviewCard.Parent then
            pcall(function() skinPreviewThemeConn:Disconnect() end)
            return
        end

        skinPreviewThemeClock+=dt
        if skinPreviewThemeClock<.18 then return end
        skinPreviewThemeClock=0

        local p=_G.KimqThemeLivePalette or {}
        local soft=p.soft or p.bg2 or lightColor
        local mid=p.bg2 or p.panel or lightColor
        local hot=p.hot or hotColor
        local line=p.stroke or p.line or lineColor

        skinPreviewBackdrop.BackgroundColor3=mid
        skinPreviewGradient.Color=ColorSequence.new({
            ColorSequenceKeypoint.new(0,soft),
            ColorSequenceKeypoint.new(.55,mid),
            ColorSequenceKeypoint.new(1,hot),
        })

        local st=skinPreviewBackdrop:FindFirstChildOfClass("UIStroke")
        if st then st.Color=line end
        skinPreviewTitle.TextColor3=p.text or textColor
    end)

    local skinPreviewToken=0

    local function clearSkinPreview()
        skinPreviewToken+=1
        for _,ch in ipairs(skinPreview:GetChildren()) do
            if ch:IsA("WorldModel") or ch:IsA("Camera") then
                pcall(function() ch:Destroy() end)
            end
        end
        skinPreview.CurrentCamera=nil
    end

    local function showSkinPreview(source)
        clearSkinPreview()
        if not source then
            skinPreviewTitle.Text="Hover a skin to preview it"
            return
        end

        skinPreviewToken+=1
        local token=skinPreviewToken
        skinPreviewTitle.Text=source.Name

        task.spawn(function()
            local ok,visual=pcall(function() return source:Clone() end)
            if not ok or not visual or token~=skinPreviewToken then
                if visual then pcall(function() visual:Destroy() end) end
                return
            end

            -- Preview is intentionally static. Remove code/animation drivers and
            -- disable moving emitters so nothing can affect the actual game/tool.
            for _,d in ipairs(visual:GetDescendants()) do
                if d:IsA("LocalScript") or d:IsA("Script") or d:IsA("ModuleScript")
                    or d:IsA("Humanoid") or d:IsA("AnimationController")
                    or d:IsA("Animator") or d:IsA("Animation")
                    or d:IsA("BodyMover")
                then
                    pcall(function() d:Destroy() end)
                elseif d:IsA("BasePart") then
                    d.Anchored=true
                    d.CanCollide=false
                    d.CanTouch=false
                    d.CanQuery=false
                    d.CastShadow=false
                elseif d:IsA("ParticleEmitter") or d:IsA("Trail") or d:IsA("Beam")
                    or d:IsA("Fire") or d:IsA("Smoke") or d:IsA("Sparkles")
                then
                    pcall(function() d.Enabled=false end)
                end
            end
            if visual:IsA("BasePart") then
                visual.Anchored=true
                visual.CanCollide=false
                visual.CanTouch=false
                visual.CanQuery=false
                visual.CastShadow=false
            end

            if token~=skinPreviewToken or not skinPreview.Parent then
                visual:Destroy()
                return
            end

            local world=Instance.new("WorldModel")
            world.Name="KimqWeaponSkinPreviewWorld"
            world.Parent=skinPreview
            visual.Parent=world

            local okBox,cf,size=pcall(function()
                if visual:IsA("Model") then
                    return visual:GetBoundingBox()
                end

                local parts={}
                if visual:IsA("BasePart") then table.insert(parts,visual) end
                for _,d in ipairs(visual:GetDescendants()) do
                    if d:IsA("BasePart") then table.insert(parts,d) end
                end
                if #parts==0 then error("no preview parts") end

                local minV=Vector3.new(math.huge,math.huge,math.huge)
                local maxV=Vector3.new(-math.huge,-math.huge,-math.huge)
                for _,p in ipairs(parts) do
                    local half=p.Size*.5
                    minV=Vector3.new(
                        math.min(minV.X,p.Position.X-half.X),
                        math.min(minV.Y,p.Position.Y-half.Y),
                        math.min(minV.Z,p.Position.Z-half.Z)
                    )
                    maxV=Vector3.new(
                        math.max(maxV.X,p.Position.X+half.X),
                        math.max(maxV.Y,p.Position.Y+half.Y),
                        math.max(maxV.Z,p.Position.Z+half.Z)
                    )
                end
                local center=(minV+maxV)*.5
                return CFrame.new(center),maxV-minV
            end)

            if not okBox then
                world:Destroy()
                return
            end

            -- Center the skin only. Do not animate or add a display stand.
            local pivot=nil
            pcall(function() pivot=visual:GetPivot() end)
            if pivot then
                pcall(function()
                    visual:PivotTo(CFrame.new(-cf.Position)*pivot*CFrame.Angles(0,math.rad(28),0))
                end)
            else
                for _,d in ipairs(visual:GetDescendants()) do
                    if d:IsA("BasePart") then
                        d.CFrame=CFrame.new(-cf.Position)*d.CFrame*CFrame.Angles(0,math.rad(28),0)
                    end
                end
            end

            local cam=Instance.new("Camera")
            cam.Name="KimqWeaponSkinPreviewCamera"
            cam.FieldOfView=28
            cam.Parent=skinPreview
            skinPreview.CurrentCamera=cam

            local abs=skinPreview.AbsoluteSize
            local aspect=math.max(abs.X/math.max(abs.Y,1),.55)
            local vfov=math.rad(cam.FieldOfView)
            local fitH=size.Y/(2*math.tan(vfov*.5))
            local fitW=size.X/(2*math.tan(vfov*.5)*aspect)
            local dist=math.clamp(math.max(fitH,fitW,size.Z*1.6)*1.35,2.5,40)

            cam.CFrame=CFrame.lookAt(
                Vector3.new(0,0,-dist),
                Vector3.zero,
                Vector3.new(0,1,0)
            )
        end)
    end

    local actions=card(skinsPage,54)
    local apply=Instance.new("TextButton",actions); apply.Size=UDim2.new(.68,-14,0,34); apply.Position=UDim2.new(0,10,.5,-17); apply.BackgroundColor3=hotColor; apply.BorderSizePixel=0; apply.Text="♥  Apply Skin"; apply.TextColor3=Color3.fromRGB(250,252,255); apply.Font=Enum.Font.GothamBold; apply.TextSize=13; corner(apply,10)
    local reset=Instance.new("TextButton",actions); reset.Size=UDim2.new(.32,-14,0,34); reset.Position=UDim2.new(.68,4,.5,-17); reset.BackgroundColor3=lightColor; reset.BorderSizePixel=0; reset.Text="Reset"; reset.TextColor3=textColor; reset.Font=Enum.Font.GothamBold; reset.TextSize=12; corner(reset,10); stroke(reset,lineColor,.3,1)
    local statusCard=card(skinsPage,48)
    local skinStatus=txt(statusCard,"Open this page or press Refresh to scan for weapons.",UDim2.new(1,-24,1,0),UDim2.fromOffset(12,0),Enum.Font.Gotham,12,subColor)

    _G.KimqV26WeaponSkins=_G.KimqV26WeaponSkins or {Selected={}}
    _G.KimqV26WeaponSkins.Selected=_G.KimqV26WeaponSkins.Selected or {}
    _G.KimqV26WeaponSkins.Mirrors=_G.KimqV26WeaponSkins.Mirrors or setmetatable({}, {__mode="k"})
    local selectedByWeapon=_G.KimqV26WeaponSkins.Selected
    local skinMirrors=_G.KimqV26WeaponSkins.Mirrors
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
        local conn=skinMirrors[tool]
        if conn then pcall(function() conn:Disconnect() end); skinMirrors[tool]=nil end
        local h=tool:FindFirstChild("Handle"); if h and h:IsA("BasePart") then pcall(function() h.LocalTransparencyModifier=0 end) end
        for _,d in ipairs(tool:GetDescendants()) do
            if d.Name=="KimqV26SkinVisual" or d.Name=="KimqV21AnimatedSkinVisual" then pcall(function() d:Destroy() end) end
        end
    end
    local function sourceSkin(w,s)
        local wf=folderByName[w]
        local sf=wf and wf:FindFirstChild(s)
        return sf,findHandle(sf)
    end
    local function hasAnimatedVisuals(obj)
        if not obj then return false end
        for _,d in ipairs(obj:GetDescendants()) do
            if d:IsA("ParticleEmitter") or d:IsA("Trail") or d:IsA("Beam") or d:IsA("Humanoid") or d:IsA("AnimationController") or d:IsA("Animator") or d:IsA("Animation") or d:IsA("Constraint") or d:IsA("BodyMover") or d:IsA("Motor6D") or d:IsA("Bone") or d:IsA("LocalScript") or d:IsA("Script") then return true end
        end
        return false
    end

    -- Pair a source skin with its clone without changing the game model.  We use
    -- name/class occurrence matching so animated source parts, bones and attachments
    -- can be mirrored into the equipped cosmetic when the game's own animation is
    -- happening on the source model.
    local function pairTrees(src,dst,out)
        out=out or {}
        if not src or not dst then return out end
        out[src]=dst
        local dchildren=dst:GetChildren()
        local used={}
        for _,sc in ipairs(src:GetChildren()) do
            local match=nil
            for _,dc in ipairs(dchildren) do
                if not used[dc] and dc.Name==sc.Name and dc.ClassName==sc.ClassName then match=dc; break end
            end
            if match then used[match]=true; pairTrees(sc,match,out) end
        end
        return out
    end

    local function startSourceMirror(tool,sourceContainer,sourceRoot,visual,cloneRoot,pairMap,mirrorParts)
        local old=skinMirrors[tool]
        if old then pcall(function() old:Disconnect() end) end
        local conn
        local mirrorAccumulator=0
        conn=RunService.Heartbeat:Connect(function(dt)
            mirrorAccumulator += dt
            if mirrorAccumulator < (1/30) then return end
            mirrorAccumulator = 0
            if not tool.Parent or not visual.Parent or not sourceContainer.Parent or not sourceRoot.Parent then
                pcall(function() conn:Disconnect() end); skinMirrors[tool]=nil; return
            end
            -- Backpack skins are not visible, so pause the expensive pose copy
            -- until that tool is actually equipped.
            if tool.Parent~=lp.Character then return end
            local target=tool:FindFirstChild("Handle")
            if not target or not target:IsA("BasePart") then return end
            local delta=target.CFrame*sourceRoot.CFrame:Inverse()
            for s,c in pairs(pairMap) do
                if s and c and s.Parent and c.Parent then
                    if mirrorParts and s:IsA("BasePart") and c:IsA("BasePart") then
                        pcall(function() c.CFrame=delta*s.CFrame end)
                    elseif s:IsA("Bone") and c:IsA("Bone") then
                        pcall(function() c.Transform=s.Transform end)
                    elseif s:IsA("Attachment") and c:IsA("Attachment") then
                        pcall(function() c.CFrame=s.CFrame end)
                    elseif s:IsA("SpecialMesh") and c:IsA("SpecialMesh") then
                        pcall(function() c.Scale=s.Scale; c.Offset=s.Offset end)
                    elseif (s:IsA("ParticleEmitter") and c:IsA("ParticleEmitter")) or (s:IsA("Trail") and c:IsA("Trail")) or (s:IsA("Beam") and c:IsA("Beam")) then
                        pcall(function() c.Enabled=s.Enabled end)
                    end
                end
            end
        end)
        skinMirrors[tool]=conn
        return conn
    end

    -- Animation support for Wraps. Most wrap folders are storage models, so their
    -- Animator has NO playing tracks to mirror. We therefore also load embedded
    -- loop/idle/effect Animation objects directly on the cloned visual.
    -- Animated wraps often ship a dedicated Humanoid (for example,
    -- "ANIMATE_HUMANOID") and their Animation is authored against that rig.
    -- Loading those tracks into a brand-new AnimationController changes the
    -- animation root and leaves the skin frozen. Prefer the skin's own Humanoid.
    local function ensureDriverAnimator(driver)
        if not driver then return nil,nil,"none" end
        if driver:IsA("Animator") then
            local host=driver.Parent
            if host and host:IsA("Humanoid") then return driver,host,"humanoid" end
            if host and host:IsA("AnimationController") then return driver,nil,"animation controller" end
            return driver,nil,"animator"
        end
        if driver:IsA("Humanoid") then
            pcall(function() driver.RequiresNeck=false end)
            pcall(function() driver.BreakJointsOnDeath=false end)
            pcall(function()
                if driver.MaxHealth<=0 then driver.MaxHealth=100 end
                driver.Health=driver.MaxHealth
            end)
            local animator=driver:FindFirstChildWhichIsA("Animator")
            if not animator then
                animator=Instance.new("Animator")
                animator.Name="KimqSkinAnimator"
                animator.Parent=driver
            end
            return animator,driver,"humanoid"
        end
        if driver:IsA("AnimationController") then
            local animator=driver:FindFirstChildWhichIsA("Animator")
            if not animator then
                animator=Instance.new("Animator")
                animator.Name="KimqSkinAnimator"
                animator.Parent=driver
            end
            return animator,nil,"animation controller"
        end
        return nil,nil,"none"
    end

    local function collectRigDrivers(root,createFallback)
        local out,seen={},{}
        if not root then return out end

        local function add(host)
            if not host or seen[host] then return end
            local animator,humanoid,mode=ensureDriverAnimator(host)
            if animator then
                seen[host]=true
                table.insert(out,{host=host,animator=animator,humanoid=humanoid,mode=mode})
            end
        end

        -- Humanoids first because many Wraps (including Ascension) are tiny authored
        -- humanoid rigs. Then AnimationControllers. Bare Animators are only added if
        -- they are not already owned by one of those drivers.
        for _,d in ipairs(root:GetDescendants()) do if d:IsA("Humanoid") then add(d) end end
        for _,d in ipairs(root:GetDescendants()) do if d:IsA("AnimationController") then add(d) end end
        for _,d in ipairs(root:GetDescendants()) do
            if d:IsA("Animator") then
                local par=d.Parent
                if not (par and (par:IsA("Humanoid") or par:IsA("AnimationController"))) then add(d) end
            end
        end

        if #out==0 and createFallback then
            local controller=Instance.new("AnimationController")
            controller.Name="KimqSkinAnimationController"
            controller.Parent=root
            add(controller)
        end
        return out
    end

    local function getOrCreateAnimator(root)
        local drivers=collectRigDrivers(root,true)
        local first=drivers[1]
        if not first then return nil,nil,"none" end
        return first.animator,first.humanoid,first.mode
    end

    local function collectSkinAnimations(obj)
        local found={}
        if not obj then return found end
        if obj:IsA("Animation") then table.insert(found,obj) end
        for _,d in ipairs(obj:GetDescendants()) do
            if d:IsA("Animation") and tostring(d.AnimationId or "")~="" and tostring(d.AnimationId or "")~="rbxassetid://0" then
                table.insert(found,d)
            end
        end
        return found
    end

    local function isActionAnimationName(name)
        name=tostring(name or ""):lower()
        return name:find("reload",1,true) or name:find("shoot",1,true) or name:find("fire",1,true)
            or name:find("equip",1,true) or name:find("unequip",1,true) or name:find("inspect",1,true)
            or name:find("attack",1,true) or name:find("melee",1,true)
    end

    local function nearestDriversForAnimation(anim,root,drivers)
        if #drivers<=1 then return drivers end
        local ranked={}
        for index,info in ipairs(drivers) do
            local score=9999
            local ancestor=anim.Parent
            local depth=0
            while ancestor and depth<64 do
                if info.host==ancestor or info.host:IsDescendantOf(ancestor) then
                    score=depth
                    break
                end
                if ancestor==root then break end
                ancestor=ancestor.Parent
                depth+=1
            end
            table.insert(ranked,{info=info,score=score,index=index})
        end
        table.sort(ranked,function(a,b)
            if a.score==b.score then
                -- Prefer Humanoid-authored rigs when equally close.
                if a.info.mode~=b.info.mode then return a.info.mode=="humanoid" end
                return a.index<b.index
            end
            return a.score<b.score
        end)
        local out={}
        for _,r in ipairs(ranked) do table.insert(out,r.info) end
        return out
    end

    local function playSkinAnimationsFromIds(sourceObj,cloneObj)
        if not cloneObj then return 0,"none",0 end

        -- Use the cloned Animation objects themselves. This keeps any attributes the
        -- skin author attached to the Animation while still letting us read its ID.
        local animations=collectSkinAnimations(cloneObj)
        if #animations==0 and sourceObj then
            -- Extremely defensive fallback in case an Animation was not Archivable.
            for _,src in ipairs(collectSkinAnimations(sourceObj)) do
                local copy=Instance.new("Animation")
                copy.Name=src.Name
                copy.AnimationId=src.AnimationId
                copy.Parent=cloneObj
                table.insert(animations,copy)
            end
        end
        if #animations==0 then return 0,"none",0 end

        local drivers=collectRigDrivers(cloneObj,true)
        if #drivers==0 then return 0,"none",#animations end

        local started=0
        local modes={}
        local playedIds={}
        for _,anim in ipairs(animations) do
            local id=tostring(anim.AnimationId or "")
            if id~="" and id~="rbxassetid://0" and not playedIds[id] and not isActionAnimationName(anim.Name) then
                local candidates=nearestDriversForAnimation(anim,cloneObj,drivers)
                local track=nil
                local used=nil
                for _,info in ipairs(candidates) do
                    -- Some authored mini-rigs only behave correctly through Humanoid:LoadAnimation;
                    -- others use AnimationController/Animator. Try the intended driver first,
                    -- then fall through to the other drivers in this skin.
                    if info.humanoid then
                        local ok,result=pcall(function() return info.humanoid:LoadAnimation(anim) end)
                        if ok and result then track=result end
                    end
                    if not track then
                        local ok,result=pcall(function() return info.animator:LoadAnimation(anim) end)
                        if ok and result then track=result end
                    end
                    if track then used=info break end
                end

                if track then
                    playedIds[id]=true
                    pcall(function() track.Priority=Enum.AnimationPriority.Action end)
                    pcall(function() track.Looped=true end)
                    pcall(function() track:Play(0.08,1,1) end)
                    pcall(function() track:AdjustSpeed(1) end)
                    started+=1
                    modes[used and used.mode or "animator"]=true
                end
            end
        end

        local modeList={}
        for mode in pairs(modes) do table.insert(modeList,mode) end
        table.sort(modeList)
        return started,(#modeList>0 and table.concat(modeList," + ") or "none"),#animations
    end

    local function mirrorPlayingAnimations(sourceObj,cloneObj)
        local cloneAnimator=cloneObj and getOrCreateAnimator(cloneObj)
        if not cloneAnimator then return 0 end
        local count=0
        for _,srcAnimator in ipairs(sourceObj:GetDescendants()) do
            if srcAnimator:IsA("Animator") then
                local ok,tracks=pcall(function() return srcAnimator:GetPlayingAnimationTracks() end)
                if ok and tracks then
                    for _,track in ipairs(tracks) do
                        local anim=nil
                        pcall(function() anim=track.Animation end)
                        if anim and anim:IsA("Animation") and anim.AnimationId~="" then
                            local copied=Instance.new("Animation")
                            copied.AnimationId=anim.AnimationId
                            copied.Name=anim.Name
                            local okLoad,newTrack=pcall(function() return cloneAnimator:LoadAnimation(copied) end)
                            if okLoad and newTrack then
                                pcall(function() newTrack.Priority=track.Priority end)
                                pcall(function() newTrack.Looped=track.Looped end)
                                pcall(function() newTrack:Play(.05,1,1) end)
                                pcall(function() newTrack.TimePosition=track.TimePosition end)
                                pcall(function() newTrack:AdjustSpeed(track.Speed) end)
                                count+=1
                            end
                            copied:Destroy()
                        end
                    end
                end
            end
        end
        return count
    end
    local function applySkin(w,s,tool,quiet)
        local gun=tool or findTool(w)
        if not gun then if not quiet then setStatus(displayWeapon(w).." is not in your Backpack / Character",false) end return false end
        local target=gun:FindFirstChild("Handle")
        local sourceContainer,sourceRoot=sourceSkin(w,s)
        if not target or not target:IsA("BasePart") or not sourceContainer or not sourceRoot then if not quiet then setStatus("That skin does not have a usable Handle",false) end return false end
        clearVisual(gun)

        -- Clone the WHOLE skin, not only its Handle. This keeps particles, beams,
        -- trails, attachments, extra meshes, bones/Motor6Ds and AnimationControllers.
        local visual=sourceContainer:Clone()
        visual.Name="KimqV21AnimatedSkinVisual"
        local cloneRoot=findHandle(visual)
        if not cloneRoot then visual:Destroy(); if not quiet then setStatus("That skin clone lost its Handle",false) end return false end
        local sourcePairs=pairTrees(sourceContainer,visual,{})

        -- Keep client-side animation code instead of deleting it.  Many wraps use a
        -- LocalScript + ModuleScript rather than an Animation object, and deleting
        -- those was why those skins could never animate. Server-only scripts are
        -- still removed because they cannot run in a local cosmetic clone.
        local clientScripts=0
        for _,d in ipairs(visual:GetDescendants()) do
            if d:IsA("LocalScript") then
                clientScripts+=1
                pcall(function() d.Disabled=false end)
                pcall(function() d.Enabled=true end)
            elseif d:IsA("ModuleScript") then
                -- Keep modules: cloned LocalScripts may require them.
            elseif d:IsA("Script") then
                local isClient=false
                pcall(function() isClient=(d.RunContext==Enum.RunContext.Client) end)
                if isClient then
                    clientScripts+=1
                    pcall(function() d.Disabled=false end)
                    pcall(function() d.Enabled=true end)
                else
                    d:Destroy()
                end
            elseif d:IsA("BasePart") then
                d.Anchored=false; d.CanCollide=false; d.CanTouch=false; d.CanQuery=false; d.Massless=true
                pcall(function() d.AssemblyLinearVelocity=Vector3.zero; d.AssemblyAngularVelocity=Vector3.zero end)
            elseif d:IsA("ParticleEmitter") or d:IsA("Trail") or d:IsA("Beam") or d:IsA("Fire") or d:IsA("Smoke") or d:IsA("Sparkles") then
                pcall(function() d.Enabled=true end)
            elseif d:IsA("PointLight") or d:IsA("SpotLight") or d:IsA("SurfaceLight") then
                pcall(function() d.Enabled=true end)
            elseif d:IsA("SurfaceGui") or d:IsA("BillboardGui") then
                pcall(function() d.Enabled=true end)
            end
        end
        if visual:IsA("BasePart") then
            visual.Anchored=false; visual.CanCollide=false; visual.CanTouch=false; visual.CanQuery=false; visual.Massless=true
        end

        -- Move every skin part by the same Handle->gun transform so multi-part skins
        -- keep their authored offsets instead of bunching up at the gun Handle.
        local delta=target.CFrame*sourceRoot.CFrame:Inverse()
        if visual:IsA("BasePart") then visual.CFrame=delta*visual.CFrame end
        for _,d in ipairs(visual:GetDescendants()) do if d:IsA("BasePart") then d.CFrame=delta*d.CFrame end end
        visual.Parent=gun

        -- Preserve authored animation rigs. Do NOT safety-weld parts that are already
        -- controlled by Motor6Ds, welds, hinges, springs, Align constraints,
        -- AngularVelocity/LinearVelocity, or legacy BodyMovers. Welding those parts
        -- rigidly was the reason animated wraps looked frozen.
        local jointed={}
        for _,j in ipairs(visual:GetDescendants()) do
            if j:IsA("JointInstance") then
                if j.Part0 then jointed[j.Part0]=true end; if j.Part1 then jointed[j.Part1]=true end
            elseif j:IsA("WeldConstraint") then
                if j.Part0 then jointed[j.Part0]=true end; if j.Part1 then jointed[j.Part1]=true end
            elseif j:IsA("Constraint") then
                local a0,a1=nil,nil
                pcall(function() a0=j.Attachment0 end)
                pcall(function() a1=j.Attachment1 end)
                if a0 and a0.Parent and a0.Parent:IsA("BasePart") then jointed[a0.Parent]=true end
                if a1 and a1.Parent and a1.Parent:IsA("BasePart") then jointed[a1.Parent]=true end
            elseif j:IsA("BodyMover") and j.Parent and j.Parent:IsA("BasePart") then
                jointed[j.Parent]=true
            end
        end
        local rootWeld=Instance.new("WeldConstraint",cloneRoot); rootWeld.Name="KimqV21SkinRootWeld"; rootWeld.Part0=cloneRoot; rootWeld.Part1=target
        for _,d in ipairs(visual:GetDescendants()) do
            if d:IsA("BasePart") and d~=cloneRoot and not jointed[d] then
                local wld=Instance.new("WeldConstraint",d); wld.Name="KimqV21LooseVisualWeld"; wld.Part0=d; wld.Part1=cloneRoot
            end
        end

        -- Storage models in Workspace.Wraps are usually idle, so there may be no
        -- currently-playing track to mirror. Start embedded cosmetic Animation
        -- objects first, then also mirror any preview track that actually is running.
        local embedded,embeddedDriver,animationIdsFound=playSkinAnimationsFromIds(sourceContainer,visual)
        local mirrored=mirrorPlayingAnimations(sourceContainer,visual)

        -- If the wrap is animated by the game's source model rather than an embedded
        -- Animation/LocalScript, mirror that live pose too.  Base-part CFrames are
        -- only mirrored when there is no cloned client script or animation track, so
        -- we do not fight the clone's own animation. Bones/attachments/VFX can still
        -- mirror safely and cover skinned meshes, beams and trails.
        local needsFallbackMirror=(clientScripts==0 and embedded==0 and mirrored==0)

        -- v2.62 stability rule:
        -- Never copy cosmetic BasePart CFrames from the storage model every frame.
        -- That world-space 30fps mirror visibly lagged/wobbled behind the player's
        -- moving gun. The clone now stays physically attached to the real Handle.
        --
        -- As a fallback we can still mirror Bones, Attachments, mesh offsets and VFX
        -- state; those do not fight the Handle weld.
        local mirrorParts=false
        if needsFallbackMirror then
            startSourceMirror(
                gun,
                sourceContainer,
                sourceRoot,
                visual,
                cloneRoot,
                sourcePairs,
                false
            )
        end

        pcall(function() target.LocalTransparencyModifier=1 end)
        selectedByWeapon[w]=s
        if not quiet then
            local animated=hasAnimatedVisuals(sourceContainer)
            local animCount=embedded+mirrored
            local detail=" • applied locally"
            if animCount>0 then detail=" • "..animCount.." animation"..(animCount==1 and "" or "s").." running from ID via "..tostring(embeddedDriver)
            elseif clientScripts>0 then detail=" • client animation script"..(clientScripts==1 and "" or "s").." kept"
            elseif animationIdsFound and animationIdsFound>0 then detail=" • animation ID found, but this rig could not play it"
            elseif animated then detail=needsFallbackMirror and " • stable attached fallback + effects preserved" or " • animated effects preserved" end
            setStatus(displayWeapon(w).." • "..s..detail,true)
        end
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
        if not currentWeapon or not folderByName[currentWeapon] then
            skinsHeader.Text="Skins"
            clearSkinPreview()
            skinPreviewTitle.Text="Hover a skin to preview it"
            setStatus("Choose a weapon first",false)
            return
        end
        skinsHeader.Text="Skins • "..displayWeapon(currentWeapon)
        local skins={}
        for _,sf in ipairs(folderByName[currentWeapon]:GetChildren()) do if findHandle(sf) then table.insert(skins,sf) end end
        table.sort(skins,function(a,b) return a.Name:lower()<b.Name:lower() end)
        selectedSkin=selectedByWeapon[currentWeapon]
        for i,sf in ipairs(skins) do
            local b=Instance.new("TextButton",skinList); b.LayoutOrder=i; b.BackgroundColor3=lightColor; b.BorderSizePixel=0; b.Text=sf.Name; b.TextColor3=textColor; b.Font=Enum.Font.GothamBold; b.TextSize=11; b.AutoButtonColor=false; corner(b,10); stroke(b,lineColor,.35,1)
            b.MouseButton1Click:Connect(function()
                selectedSkin=sf.Name
                refreshSkinStyle()
                setStatus("Selected "..sf.Name.." • press Apply Skin",true)
                showSkinPreview(sf)
            end)
            b.MouseEnter:Connect(function()
                showSkinPreview(sf)
            end)
            b.MouseLeave:Connect(function()
                local keep=selectedSkin and folderByName[currentWeapon] and folderByName[currentWeapon]:FindFirstChild(selectedSkin)
                showSkinPreview(keep)
            end)
            skinButtons[sf.Name]=b
        end
        refreshSkinStyle()
        local selectedSource=selectedSkin and folderByName[currentWeapon]:FindFirstChild(selectedSkin)
        if selectedSource then
            showSkinPreview(selectedSource)
        else
            clearSkinPreview()
            skinPreviewTitle.Text="Hover a skin to preview it"
        end
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
        if currentWeapon then
            selectedByWeapon[currentWeapon]=nil
            clearVisual(findTool(currentWeapon))
            selectedSkin=nil
            refreshSkinStyle()
            clearSkinPreview()
            skinPreviewTitle.Text="Hover a skin to preview it"
            setStatus(displayWeapon(currentWeapon).." reset",true)
        end
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

    local function getWeaponSkinConfigState()
        local selections={}
        for weaponName,skinName in pairs(selectedByWeapon) do
            if type(weaponName)=="string" and type(skinName)=="string" then selections[weaponName]=skinName end
        end
        return {selected=selections,currentWeapon=currentWeapon,selectedSkin=selectedSkin}
    end
    local function setWeaponSkinConfigState(state)
        if type(state) ~= "table" then return end
        -- Clear visuals from selections that are about to be replaced.
        for weaponName in pairs(selectedByWeapon) do
            local tool=findTool(weaponName)
            if tool then clearVisual(tool) end
        end
        table.clear(selectedByWeapon)
        if type(state.selected)=="table" then
            for weaponName,skinName in pairs(state.selected) do
                if type(weaponName)=="string" and type(skinName)=="string" then
                    selectedByWeapon[weaponName]=skinName
                end
            end
        end
        currentWeapon = type(state.currentWeapon)=="string" and state.currentWeapon or currentWeapon
        selectedSkin = currentWeapon and selectedByWeapon[currentWeapon] or (type(state.selectedSkin)=="string" and state.selectedSkin or nil)
        task.defer(function()
            -- Build the Wraps lookup even if the Weapon Skins page is closed;
            -- otherwise a config loaded from another page would know the names but
            -- have no source folder to clone from.
            scanWeapons()
            for weaponName,skinName in pairs(selectedByWeapon) do
                local tool=findTool(weaponName)
                if tool then applySkin(weaponName,skinName,tool,true) end
            end
            refreshWeaponStyle(); refreshSkinStyle()
            setStatus("Restored saved weapon skins", true)
        end)
    end
    _G.KimqWeaponSkinController={GetState=getWeaponSkinConfigState,SetState=setWeaponSkinConfigState,Apply=applySkin}
    if type(_G.KimqRegisterConfigControl) == "function" then
        _G.KimqRegisterConfigControl("Weapon Skin Selections", "state", getWeaponSkinConfigState, setWeaponSkinConfigState)
    end


    -- Weapon extras -------------------------------------------------------
    -- Local cosmetic support for ReplicatedStorage.BulletBeams, Knives, and
    -- EquipableItem.  Everything here stays client-side and lives on the same
    -- Weapon Skins page.
    local function setupWeaponExtras()
        if _G.KimqWeaponExtrasInstalled then return end
        _G.KimqWeaponExtrasInstalled=true

        _G.KimqWeaponExtrasState=_G.KimqWeaponExtrasState or {
            BulletBeam="None",
            BulletColorMode="Preset",
            BulletColorHex="#FF69B4",
            BulletLightBrightness=0.65,
            KnifeSkin="None",
            KnifeAccentMode="Off",
            EquipableItem="None",
        }
        _G.KimqBulletLightBrightness=math.clamp(
            tonumber(_G.KimqWeaponExtrasState.BulletLightBrightness)
            or tonumber(_G.KimqBulletLightBrightness)
            or 0.65, 0, 2.5
        )
        local extraState=_G.KimqWeaponExtrasState
        extraState.BulletBeam=tostring(extraState.BulletBeam or "None")
        extraState.BulletColorMode=tostring(extraState.BulletColorMode or "Preset")
        if extraState.BulletColorMode~="Preset" and extraState.BulletColorMode~="Custom" and extraState.BulletColorMode~="Rainbow" then extraState.BulletColorMode="Preset" end
        extraState.BulletColorHex=tostring(extraState.BulletColorHex or "#FF69B4")
        extraState.KnifeAccentMode=tostring(extraState.KnifeAccentMode or "Off")
        if extraState.KnifeAccentMode~="Off" and extraState.KnifeAccentMode~="Theme" and extraState.KnifeAccentMode~="Bullet" then extraState.KnifeAccentMode="Off" end
        local extraKnifeMirrors=setmetatable({}, {__mode="k"})
        local lastLocalShot=0

        local function palette()
            local p=_G.KimqThemeLivePalette
            if type(p)=="table" then return p end
            return {
                hot=hotColor, hot2=hotColor, bg=panelColor, bg2=panelColor,
                panel=panelColor, soft=lightColor, text=textColor, sub=subColor,
                line=lineColor, white=Color3.fromRGB(250,252,255)
            }
        end
        local function pcolor(key,fallback)
            local p=palette(); return p[key] or fallback
        end
        local function makeGridButton(parent,name)
            local p=palette()
            local b=Instance.new("TextButton",parent)
            b.BackgroundColor3=p.soft; b.BorderSizePixel=0; b.Text=name
            b.TextColor3=p.text; b.Font=Enum.Font.GothamSemibold; b.TextSize=11
            b.AutoButtonColor=false; corner(b,10); stroke(b,p.line,.35,1)
            return b
        end
        local function styleChoiceButtons(buttons,selected)
            local p=palette()
            for name,b in pairs(buttons) do
                if b and b.Parent then
                    local on=(name==selected)
                    b.BackgroundColor3=on and p.hot or p.soft
                    b.TextColor3=on and p.white or p.text
                    local st=b:FindFirstChildOfClass("UIStroke")
                    if st then st.Color=on and p.hot or p.line end
                end
            end
        end
        local function findFolder(names)
            for _,name in ipairs(names) do
                local direct=ReplicatedStorage:FindFirstChild(name)
                if direct then return direct end
            end
            for _,name in ipairs(names) do
                local recursive=ReplicatedStorage:FindFirstChild(name,true)
                if recursive then return recursive end
            end
            return nil
        end
        local function firstPart(obj)
            if not obj then return nil end
            if obj:IsA("BasePart") then return obj end
            local h=obj:FindFirstChild("Handle",true)
            if h and h:IsA("BasePart") then return h end
            return obj:FindFirstChildWhichIsA("BasePart",true)
        end
        local function firstOfClass(obj,className)
            if not obj then return nil end
            if obj:IsA(className) then return obj end
            return obj:FindFirstChildWhichIsA(className,true)
        end
        local function safeCopy(dst,src,props)
            if not dst or not src then return end
            for _,prop in ipairs(props) do
                pcall(function() dst[prop]=src[prop] end)
            end
        end
        local function templateColor(root)
            local beam=firstOfClass(root,"Beam")
            if beam then
                local ok,v=pcall(function() return beam.Color.Keypoints[1].Value end)
                if ok and v then return v end
            end
            local trail=firstOfClass(root,"Trail")
            if trail then
                local ok,v=pcall(function() return trail.Color.Keypoints[1].Value end)
                if ok and v then return v end
            end
            local emitter=firstOfClass(root,"ParticleEmitter")
            if emitter then
                local ok,v=pcall(function() return emitter.Color.Keypoints[1].Value end)
                if ok and v then return v end
            end
            local part=firstPart(root)
            return part and part.Color or nil
        end
        local function copyBulletStyle(inst,root)
            if not inst or not root or extraState.BulletBeam=="None" then return end
            if inst:IsA("Beam") then
                local src=firstOfClass(root,"Beam")
                if src then
                    safeCopy(inst,src,{"Color","Transparency","Width0","Width1","CurveSize0","CurveSize1","FaceCamera","LightEmission","LightInfluence","Segments","Texture","TextureLength","TextureMode","TextureSpeed","ZOffset"})
                else
                    local c=templateColor(root); if c then pcall(function() inst.Color=ColorSequence.new(c) end) end
                end
            elseif inst:IsA("Trail") then
                local src=firstOfClass(root,"Trail")
                if src then
                    safeCopy(inst,src,{"Color","Transparency","Lifetime","MinLength","WidthScale","FaceCamera","LightEmission","LightInfluence","Texture","TextureLength","TextureMode"})
                else
                    local c=templateColor(root); if c then pcall(function() inst.Color=ColorSequence.new(c) end) end
                end
            elseif inst:IsA("ParticleEmitter") then
                local src=firstOfClass(root,"ParticleEmitter")
                if src then
                    safeCopy(inst,src,{"Color","Transparency","Texture","LightEmission","LightInfluence","Size","Lifetime","Speed","Rate","Rotation","RotSpeed","SpreadAngle","Acceleration","Drag","LockedToPart","Orientation","TimeScale","VelocityInheritance"})
                else
                    local c=templateColor(root); if c then pcall(function() inst.Color=ColorSequence.new(c) end) end
                end
            elseif inst:IsA("BasePart") then
                -- Only recolor an actual projectile/tracer part. Never recolor a gun Handle.
                local n=tostring(inst.Name):lower()
                local explicit=n:find("bullet",1,true) or n:find("tracer",1,true) or n:find("projectile",1,true) or n:find("laser",1,true)
                if explicit then
                    local c=templateColor(root); if c then pcall(function() inst.Color=c end) end
                end
            end
        end
        local function insideToolOrCharacter(obj)
            local x=obj
            while x do
                if x:IsA("Tool") then return true end
                if x==lp.Character then return true end
                x=x.Parent
            end
            return false
        end
        local function bulletish(obj)
            local x=obj
            for _=1,6 do
                if not x then break end
                if x:IsA("Tool") then return false end
                local n=tostring(x.Name):lower()
                if n:find("bullet",1,true) or n:find("beam",1,true) or n:find("tracer",1,true)
                    or n:find("projectile",1,true) or n:find("laser",1,true) then
                    return true
                end
                x=x.Parent
            end
            return false
        end
        local selectedBeamSource
        local function isInsideNamedVisual(d,name)
            local x=d
            while x and x~=workspace do
                if x.Name==name then return true end
                x=x.Parent
            end
            return false
        end
        local function styleToolShotVfx(tool)
            if not tool or not tool:IsA("Tool") then return end
            local src=selectedBeamSource()
            if not src then return end
            for _,d in ipairs(tool:GetDescendants()) do
                if not isInsideNamedVisual(d,"KimqSkinVisual") and not isInsideNamedVisual(d,"KimqKnifeSkinVisual") then
                    if d:IsA("Beam") or d:IsA("Trail") then
                        copyBulletStyle(d,src)
                    elseif d:IsA("ParticleEmitter") and bulletish(d) then
                        copyBulletStyle(d,src)
                    end
                end
            end
        end
        selectedBeamSource=function()
            if extraState.BulletBeam=="None" then return nil end
            local root=findFolder({"BulletBeams","Bullet Beams","BulletBeam"})
            return root and root:FindFirstChild(extraState.BulletBeam)
        end

        -- The game keeps its bullet presets in ReplicatedStorage.BulletBeams.
        -- Instead of guessing the name of the live projectile, patch the LOCAL
        -- templates themselves. Whichever preset the game's own shot code clones
        -- will therefore inherit the selected look. A pristine clone lets None
        -- restore every template exactly.
        local bulletBeamRoot=findFolder({"BulletBeams","Bullet Beams","BulletBeam"})
        local bulletBeamBackup=nil
        if bulletBeamRoot then pcall(function() bulletBeamBackup=bulletBeamRoot:Clone() end) end

        local function copyTemplateVisuals(targetRoot,sourceRoot)
            if not targetRoot or not sourceRoot then return end
            local srcBeam=firstOfClass(sourceRoot,"Beam")
            local srcTrail=firstOfClass(sourceRoot,"Trail")
            local srcEmitter=firstOfClass(sourceRoot,"ParticleEmitter")
            local srcPart=firstPart(sourceRoot)
            local srcColor=templateColor(sourceRoot)
            for _,d in ipairs(targetRoot:GetDescendants()) do
                if d:IsA("Beam") then
                    if srcBeam then safeCopy(d,srcBeam,{"Color","Transparency","Width0","Width1","CurveSize0","CurveSize1","FaceCamera","LightEmission","LightInfluence","Segments","Texture","TextureLength","TextureMode","TextureSpeed","ZOffset"})
                    elseif srcColor then pcall(function() d.Color=ColorSequence.new(srcColor) end) end
                    pcall(function() d.Enabled=true end)
                elseif d:IsA("Trail") then
                    if srcTrail then safeCopy(d,srcTrail,{"Color","Transparency","Lifetime","MinLength","WidthScale","FaceCamera","LightEmission","LightInfluence","Texture","TextureLength","TextureMode"})
                    elseif srcColor then pcall(function() d.Color=ColorSequence.new(srcColor) end) end
                    pcall(function() d.Enabled=true end)
                elseif d:IsA("ParticleEmitter") then
                    if srcEmitter then safeCopy(d,srcEmitter,{"Color","Transparency","Texture","LightEmission","LightInfluence","Size","Lifetime","Speed","Rate","Rotation","RotSpeed","SpreadAngle","Acceleration","Drag","LockedToPart","Orientation","TimeScale","VelocityInheritance"})
                    elseif srcColor then pcall(function() d.Color=ColorSequence.new(srcColor) end) end
                    pcall(function() d.Enabled=true end)
                elseif d:IsA("Color3Value") and srcColor then
                    pcall(function() d.Value=srcColor end)
                elseif d:IsA("BasePart") and srcPart then
                    -- Safe here: these are ReplicatedStorage bullet templates, not guns.
                    safeCopy(d,srcPart,{"Color","Material","Transparency","Reflectance"})
                end
            end
            if targetRoot:IsA("BasePart") and srcPart then safeCopy(targetRoot,srcPart,{"Color","Material","Transparency","Reflectance"}) end
        end

        local function setLocalBeamSelectionHints(name)
            -- Some games read a local StringValue/attribute before cloning a preset.
            -- Only touch names that unambiguously describe bullet/tracer selection.
            local wanted={bulletbeam=true,bulletbeamcolor=true,bullettrail=true,tracer=true,tracerstyle=true}
            local function norm(x) return tostring(x):lower():gsub("[^%w]","") end
            local function scan(root)
                if not root then return end
                for _,d in ipairs(root:GetDescendants()) do
                    if d:IsA("StringValue") and wanted[norm(d.Name)] then pcall(function() d.Value=name end) end
                end
                for key,_ in pairs(root:GetAttributes()) do
                    if wanted[norm(key)] then pcall(function() root:SetAttribute(key,name) end) end
                end
            end
            scan(lp); scan(lp.Character); scan(lp:FindFirstChildOfClass("Backpack"))
        end

        local function applyBulletBeamOverride(name)
            -- v2.2: DO NOT rewrite ReplicatedStorage.BulletBeams. Doing that can recolor
            -- bullets belonging to other players on this client. We only remember the
            -- selected preset and copy it onto bullet_rays created during OUR shot window.
            name=tostring(name or "None")
            local root=findFolder({"BulletBeams","Bullet Beams","BulletBeam"})
            if name~="None" and (not root or not root:FindFirstChild(name)) then
                return false,"Bullet preset was not found"
            end
            setLocalBeamSelectionHints(name)
            if name=="None" then return true,"Bullet beam: None" end
            return true,"Bullet beam: "..name.."  •  local only"
        end

        -- Bullet-beam selector.
        local beamCard=card(skinsPage,205)
        beamCard.Name="KimqBulletBeamsCard"
        txt(beamCard,"Bullet Beams",UDim2.new(1,-24,0,22),UDim2.fromOffset(12,8),Enum.Font.GothamBold,14,pcolor("text",textColor))
        txt(beamCard,"Changes the look of your bullets when you shoot.",UDim2.new(1,-24,0,20),UDim2.fromOffset(12,32),Enum.Font.Gotham,11,pcolor("sub",subColor))
        local beamList=Instance.new("ScrollingFrame",beamCard); beamList.Name="KimqBulletBeamList"; beamList.Size=UDim2.new(1,-20,0,105); beamList.Position=UDim2.fromOffset(10,62); beamList.BackgroundTransparency=1; beamList.BorderSizePixel=0; beamList.ScrollBarThickness=3; beamList.ScrollBarImageColor3=pcolor("hot",hotColor)
        local beamGrid=Instance.new("UIGridLayout",beamList); beamGrid.CellPadding=UDim2.fromOffset(7,7); beamGrid.CellSize=UDim2.new(.24,-5,0,34); beamGrid.SortOrder=Enum.SortOrder.LayoutOrder
        beamGrid:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() beamList.CanvasSize=UDim2.new(0,0,0,beamGrid.AbsoluteContentSize.Y+7) end)
        local beamStatus=txt(beamCard,"Bullet beam: None",UDim2.new(1,-24,0,22),UDim2.fromOffset(12,176),Enum.Font.GothamSemibold,11,pcolor("sub",subColor))
        local beamButtons={}
        local function refreshBeamStyle()
            styleChoiceButtons(beamButtons,extraState.BulletBeam)
            beamStatus.Text="Bullet beam: "..tostring(extraState.BulletBeam or "None")
            beamStatus.TextColor3=(extraState.BulletBeam~="None") and pcolor("hot",hotColor) or pcolor("sub",subColor)
        end
        local function scanBeams()
            for _,ch in ipairs(beamList:GetChildren()) do if ch:IsA("TextButton") then ch:Destroy() end end
            table.clear(beamButtons)
            local root=findFolder({"BulletBeams","Bullet Beams","BulletBeam"})
            local names={}
            if root then
                for _,ch in ipairs(root:GetChildren()) do
                    local hasVisual=ch.Name=="None" or firstOfClass(ch,"Beam") or firstOfClass(ch,"Trail") or firstOfClass(ch,"ParticleEmitter") or firstPart(ch)
                    if hasVisual and not ch:IsA("Sound") then table.insert(names,ch.Name) end
                end
            end
            if not table.find(names,"None") then table.insert(names,"None") end
            table.sort(names,function(a,b) if a=="None" then return true elseif b=="None" then return false else return a:lower()<b:lower() end end)
            for i,name in ipairs(names) do
                local b=makeGridButton(beamList,name); b.LayoutOrder=i; beamButtons[name]=b
                b.MouseButton1Click:Connect(function()
                    extraState.BulletBeam=name
                    local ok,msg=applyBulletBeamOverride(name)
                    refreshBeamStyle()
                    beamStatus.Text=msg
                    beamStatus.TextColor3=ok and pcolor("hot",hotColor) or pcolor("sub",subColor)
                end)
            end
            refreshBeamStyle()
        end

        -- Custom bullet color + rainbow mode --------------------------------
        local function normalizeHex(s)
            s=tostring(s or ""):gsub("#",""):gsub("[^%x]",""):upper()
            if #s==3 then s=s:sub(1,1):rep(2)..s:sub(2,2):rep(2)..s:sub(3,3):rep(2) end
            if #s~=6 then return nil end
            return "#"..s
        end
        local function colorFromHex(s)
            local h=normalizeHex(s)
            if not h then return nil end
            return Color3.fromRGB(tonumber(h:sub(2,3),16),tonumber(h:sub(4,5),16),tonumber(h:sub(6,7),16))
        end
        local function hexFromColor(c)
            return string.format("#%02X%02X%02X",math.floor(c.R*255+.5),math.floor(c.G*255+.5),math.floor(c.B*255+.5))
        end
        local bulletCustomColor=colorFromHex(extraState.BulletColorHex) or Color3.fromRGB(255,105,180)
        extraState.BulletColorHex=hexFromColor(bulletCustomColor)
        local bulletHue,bulletSat,bulletVal=bulletCustomColor:ToHSV()

        local bulletColorCard=card(skinsPage,286)
        bulletColorCard.Name="KimqBulletColorCard"
        txt(bulletColorCard,"Bullet Color",UDim2.new(1,-24,0,22),UDim2.fromOffset(12,8),Enum.Font.GothamBold,14,pcolor("text",textColor))
        local bulletColorSub=txt(bulletColorCard,"Choose a custom or rainbow color for your bullets.",UDim2.new(1,-24,0,32),UDim2.fromOffset(12,30),Enum.Font.Gotham,11,pcolor("sub",subColor))
        bulletColorSub.TextWrapped=true

        local sv=Instance.new("Frame",bulletColorCard)
        sv.Name="BulletSV"; sv:SetAttribute("KimqThemePreview",true); sv.Size=UDim2.new(1,-190,0,142); sv.Position=UDim2.fromOffset(12,69); sv.BackgroundColor3=Color3.fromHSV(bulletHue,1,1); sv.BorderSizePixel=0; sv.Active=true; corner(sv,10); stroke(sv,pcolor("line",lineColor),.25,1)
        local white=Instance.new("Frame",sv); white.Size=UDim2.fromScale(1,1); white.BackgroundColor3=Color3.new(1,1,1); white.BorderSizePixel=0; white.Active=false; corner(white,10)
        local wg=Instance.new("UIGradient",white); wg.Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,0),NumberSequenceKeypoint.new(1,1)})
        local black=Instance.new("Frame",sv); black.Size=UDim2.fromScale(1,1); black.BackgroundColor3=Color3.new(0,0,0); black.BorderSizePixel=0; black.Active=false; black.ZIndex=2; corner(black,10)
        local bg=Instance.new("UIGradient",black); bg.Rotation=90; bg.Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,1),NumberSequenceKeypoint.new(1,0)})
        local svDot=Instance.new("Frame",sv); svDot.Size=UDim2.fromOffset(12,12); svDot.AnchorPoint=Vector2.new(.5,.5); svDot.BackgroundTransparency=1; svDot.ZIndex=5; corner(svDot,999)
        local svStroke=Instance.new("UIStroke",svDot); svStroke.Color=Color3.new(1,1,1); svStroke.Thickness=2
        local svHit=Instance.new("TextButton",sv); svHit.Size=UDim2.fromScale(1,1); svHit.BackgroundTransparency=1; svHit.Text=""; svHit.AutoButtonColor=false; svHit.ZIndex=10

        local hue=Instance.new("Frame",bulletColorCard)
        hue.Name="BulletHue"; hue:SetAttribute("KimqThemePreview",true); hue.Size=UDim2.fromOffset(22,142); hue.Position=UDim2.new(1,-166,0,69); hue.BorderSizePixel=0; hue.Active=true; corner(hue,11)
        local hg=Instance.new("UIGradient",hue); hg.Rotation=90; hg.Color=ColorSequence.new({
            ColorSequenceKeypoint.new(0,Color3.fromRGB(255,0,0)),ColorSequenceKeypoint.new(1/6,Color3.fromRGB(255,255,0)),
            ColorSequenceKeypoint.new(2/6,Color3.fromRGB(0,255,0)),ColorSequenceKeypoint.new(3/6,Color3.fromRGB(0,255,255)),
            ColorSequenceKeypoint.new(4/6,Color3.fromRGB(0,0,255)),ColorSequenceKeypoint.new(5/6,Color3.fromRGB(255,0,255)),
            ColorSequenceKeypoint.new(1,Color3.fromRGB(255,0,0))})
        local hueKnob=Instance.new("Frame",hue); hueKnob.Size=UDim2.fromOffset(30,8); hueKnob.AnchorPoint=Vector2.new(.5,.5); hueKnob.Position=UDim2.new(.5,0,bulletHue,0); hueKnob.BackgroundColor3=Color3.new(1,1,1); hueKnob.BorderSizePixel=0; hueKnob.ZIndex=5; corner(hueKnob,999); stroke(hueKnob,Color3.fromRGB(80,80,80),.15,1)
        local hueHit=Instance.new("TextButton",hue); hueHit.Size=UDim2.fromScale(1,1); hueHit.BackgroundTransparency=1; hueHit.Text=""; hueHit.AutoButtonColor=false; hueHit.ZIndex=10

        local preview=Instance.new("Frame",bulletColorCard); preview:SetAttribute("KimqThemePreview",true); preview.Size=UDim2.fromOffset(116,38); preview.Position=UDim2.new(1,-132,0,69); preview.BackgroundColor3=bulletCustomColor; preview.BorderSizePixel=0; corner(preview,10); stroke(preview,pcolor("line",lineColor),.2,1)
        local hexBox=Instance.new("TextBox",bulletColorCard); hexBox.Size=UDim2.fromOffset(116,32); hexBox.Position=UDim2.new(1,-132,0,115); hexBox.BackgroundColor3=pcolor("soft",lightColor); hexBox.BorderSizePixel=0; hexBox.Text=extraState.BulletColorHex; hexBox.PlaceholderText="#FF69B4"; hexBox.TextColor3=pcolor("text",textColor); hexBox.Font=Enum.Font.GothamSemibold; hexBox.TextSize=11; hexBox.ClearTextOnFocus=false; corner(hexBox,9); stroke(hexBox,pcolor("line",lineColor),.3,1)
        local customBtn=makeGridButton(bulletColorCard,"Custom Color"); customBtn.Size=UDim2.fromOffset(116,31); customBtn.Position=UDim2.new(1,-132,0,153)
        local rainbowBtn=makeGridButton(bulletColorCard,"Rainbow"); rainbowBtn.Size=UDim2.fromOffset(116,31); rainbowBtn.Position=UDim2.new(1,-132,0,190)
        local presetBtn=makeGridButton(bulletColorCard,"Preset Color"); presetBtn.Size=UDim2.new(.5,-15,0,34); presetBtn.Position=UDim2.fromOffset(12,225)
        local colorStatus=txt(bulletColorCard,"Mode: "..extraState.BulletColorMode,UDim2.new(.5,-15,0,34),UDim2.new(.5,3,0,225),Enum.Font.GothamSemibold,11,pcolor("sub",subColor),Enum.TextXAlignment.Center)

        local function refreshBulletColorUI()
            bulletCustomColor=Color3.fromHSV(bulletHue,bulletSat,bulletVal)
            extraState.BulletColorHex=hexFromColor(bulletCustomColor)
            preview.BackgroundColor3=bulletCustomColor; sv.BackgroundColor3=Color3.fromHSV(bulletHue,1,1)
            hexBox.Text=extraState.BulletColorHex
            svDot.Position=UDim2.new(bulletSat,0,1-bulletVal,0); hueKnob.Position=UDim2.new(.5,0,bulletHue,0)
            colorStatus.Text="Mode: "..tostring(extraState.BulletColorMode)
            local refreshTemplates=rawget(_G,"KimqRefreshBulletTemplates")
            if type(refreshTemplates)=="function" then pcall(refreshTemplates) end
            local p=palette()
            for name,b in pairs({Custom=customBtn,Rainbow=rainbowBtn,Preset=presetBtn}) do
                local on=extraState.BulletColorMode==name
                b.BackgroundColor3=on and p.hot or p.soft; b.TextColor3=on and p.white or p.text
            end
        end
        local function setCustomColor(c,activate)
            if not c then return end
            bulletCustomColor=c; bulletHue,bulletSat,bulletVal=c:ToHSV(); extraState.BulletColorHex=hexFromColor(c)
            if activate then extraState.BulletColorMode="Custom" end
            refreshBulletColorUI()
        end
        customBtn.MouseButton1Click:Connect(function() extraState.BulletColorMode="Custom"; refreshBulletColorUI() end)
        rainbowBtn.MouseButton1Click:Connect(function() extraState.BulletColorMode="Rainbow"; refreshBulletColorUI() end)
        presetBtn.MouseButton1Click:Connect(function() extraState.BulletColorMode="Preset"; refreshBulletColorUI() end)
        hexBox.FocusLost:Connect(function()
            local c=colorFromHex(hexBox.Text)
            if c then setCustomColor(c,true) else hexBox.Text=extraState.BulletColorHex end
        end)

        local pickerUIS=game:GetService("UserInputService")
        local draggingSV,draggingHue=false,false
        local function updateSV(pos)
            local p=sv.AbsolutePosition; local s=sv.AbsoluteSize
            bulletSat=math.clamp((pos.X-p.X)/math.max(s.X,1),0,1)
            bulletVal=1-math.clamp((pos.Y-p.Y)/math.max(s.Y,1),0,1)
            extraState.BulletColorMode="Custom"; refreshBulletColorUI()
        end
        local function updateHue(pos)
            local p=hue.AbsolutePosition; local s=hue.AbsoluteSize
            bulletHue=math.clamp((pos.Y-p.Y)/math.max(s.Y,1),0,1)
            extraState.BulletColorMode="Custom"; refreshBulletColorUI()
        end
        svHit.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then draggingSV=true; updateSV(i.Position) end end)
        hueHit.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then draggingHue=true; updateHue(i.Position) end end)
        pickerUIS.InputChanged:Connect(function(i)
            if i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch then
                if draggingSV then updateSV(i.Position) elseif draggingHue then updateHue(i.Position) end
            end
        end)
        pickerUIS.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then draggingSV=false; draggingHue=false end end)
        refreshBulletColorUI()

        -- Live bullet/tracer recolor -------------------------------------------------
        -- v2.8 persistent + low-lag path:
        --   * selected bullet color remains active across equip/unequip and gun replacement
        --   * local gun-side bullet templates are pre-colored so new shots start in the chosen color
        --   * only local shots are accepted (owner metadata first, muzzle-origin fallback second)
        --   * no per-effect PropertyChanged locks and no RenderStepped rescans
        --   * a few tiny delayed re-applies beat late game-side default-color writes without stutter
        local rainbowRoots=setmetatable({}, {__mode="k"})
        local localShotSerial=0
        local activeShotSerial=0
        local activeShotOrigin=nil
        local activeShotAt=0
        -- The first bullet_rays child that appears immediately after OUR Tool.Activated
        -- is claimed synchronously. This removes the one-frame default-color flash.
        local instantClaimSerial=0
        local instantClaimRoot=nil
        local claimedShotRoots=setmetatable({}, {__mode="k"})
        local bulletContainers=setmetatable({}, {__mode="k"})
        local hookedBulletContainers=setmetatable({}, {__mode="k"})
        local hookedShotTools=setmetatable({}, {__mode="k"})
        local hookedShotContainers=setmetatable({}, {__mode="k"})
        -- Birth time exists only for bullet_rays objects that appear after this script
        -- starts. A pre-existing shared holder has no birth stamp, so we never recolor
        -- the entire shared holder and accidentally touch somebody else's shot.
        local bulletRayBirth=setmetatable({}, {__mode="k"})
        local toolTemplateEffects=setmetatable({}, {__mode="k"})
        local templateRefreshQueued=false

        local function bulletEffectEnabled()
            return extraState.BulletColorMode=="Custom" or extraState.BulletColorMode=="Rainbow" or extraState.BulletBeam~="None"
        end

        local function currentBulletColor()
            if extraState.BulletColorMode=="Custom" then return bulletCustomColor end
            if extraState.BulletColorMode=="Rainbow" then return Color3.fromHSV((os.clock()*.45)%1,1,1) end
            return nil
        end

        local function isColorEffect(d)
            return d and (d:IsA("Beam") or d:IsA("Trail") or d:IsA("ParticleEmitter") or d:IsA("Color3Value") or d:IsA("PointLight") or d:IsA("SpotLight") or d:IsA("SurfaceLight") or d:IsA("BasePart"))
        end

        local function applyColorOnly(d,c)
            if not d or not d.Parent or not c then return end
            if d:IsA("Beam") or d:IsA("Trail") or d:IsA("ParticleEmitter") then
                pcall(function() d.Color=ColorSequence.new(c) end)
            elseif d:IsA("Color3Value") then
                pcall(function() d.Value=c end)
            elseif d:IsA("PointLight") or d:IsA("SpotLight") or d:IsA("SurfaceLight") or d:IsA("BasePart") then
                pcall(function() d.Color=c end)
            end
        end

        -- Keep the selected tracer/bullet color, but stop the effect from blooming
        -- across the whole screen. This only runs on verified local bullet effects and
        -- local bullet templates; it does not dim the map, Lighting, or other players.
        local function softenBulletGlow(d)
            if not d or not d.Parent then return end
            local glow=math.clamp(tonumber(_G.KimqBulletLightBrightness) or 0.65,0,2.5)
            if d:IsA("PointLight") or d:IsA("SpotLight") or d:IsA("SurfaceLight") then
                pcall(function() d.Brightness=glow end)
                pcall(function() d.Range=math.min(d.Range,8) end)
            elseif d:IsA("Beam") or d:IsA("Trail") or d:IsA("ParticleEmitter") then
                pcall(function() d.LightEmission=math.clamp(glow/2.5,0,1) end)
                pcall(function() d.LightInfluence=math.clamp(1-(glow/3),0.15,1) end)
            end
        end

        local function applyBulletModeTo(d,cOverride)
            if not d or not d.Parent then return end
            local src=selectedBeamSource()
            if src and extraState.BulletBeam~="None" then
                if d:IsA("Beam") or d:IsA("Trail") or d:IsA("ParticleEmitter") then
                    copyBulletStyle(d,src)
                elseif d:IsA("BasePart") then
                    local c=templateColor(src); if c then applyColorOnly(d,c) end
                end
            end
            local c=cOverride or currentBulletColor()
            if c then applyColorOnly(d,c) end
            softenBulletGlow(d)
        end

        local function toolMuzzleOrigin(tool)
            if not tool or not tool.Parent then return nil end
            for _,name in ipairs({"Muzzle","MuzzleAttachment","GunMuzzle","FirePoint","FireAttachment","BarrelAttachment"}) do
                local a=tool:FindFirstChild(name,true)
                if a and a:IsA("Attachment") then return a.WorldPosition end
                if a and a:IsA("BasePart") then return a.Position end
            end
            local handle=tool:FindFirstChild("Handle")
            if handle and handle:IsA("BasePart") then return handle.Position end
            local part=tool:FindFirstChildWhichIsA("BasePart",true)
            if part then return part.Position end
            local att=tool:FindFirstChildWhichIsA("Attachment",true)
            return att and att.WorldPosition or nil
        end

        local function ownerVerdict(obj)
            local keys={"OwnerUserId","ShooterUserId","PlayerUserId","UserId","ownerUserId","shooterUserId"}
            local x=obj
            for _=1,7 do
                if not x then break end
                for _,k in ipairs(keys) do
                    local ok,v=pcall(function() return x:GetAttribute(k) end)
                    if ok and v~=nil then
                        local n=tonumber(v)
                        if n then return n==lp.UserId end
                        local sv=tostring(v):lower()
                        if sv~="" then return sv==lp.Name:lower() or sv==lp.DisplayName:lower() end
                    end
                end
                for _,name in ipairs({"Owner","Shooter","Creator","Player"}) do
                    local ov=x:FindFirstChild(name)
                    if ov and ov:IsA("ObjectValue") and ov.Value then return ov.Value==lp end
                end
                x=x.Parent
            end
            return nil
        end

        local function bulletRayShotRoot(obj)
            local x=obj
            local child=obj
            for _=1,12 do
                if not x or x==workspace then break end
                if tostring(x.Name):lower()=="bullet_rays" then
                    if x==obj then return x end
                    return child
                end
                child=x
                x=x.Parent
            end
            return nil
        end

        local function rayStartsAtOrigin(root,origin)
            if not root or not origin then return false end
            local MAX_START_DISTANCE=8.5
            local function closePos(pos) return pos and (pos-origin).Magnitude<=MAX_START_DISTANCE end
            local function beamStartsClose(beam)
                local a0,a1=beam.Attachment0,beam.Attachment1
                return (a0 and closePos(a0.WorldPosition)) or (a1 and closePos(a1.WorldPosition))
            end
            local function partTouchesOrigin(part)
                if closePos(part.Position) then return true end
                local ok,p=pcall(function() return part.CFrame:PointToObjectSpace(origin) end)
                if not ok then return false end
                local half=part.Size*.5+Vector3.new(4,4,4)
                return math.abs(p.X)<=half.X and math.abs(p.Y)<=half.Y and math.abs(p.Z)<=half.Z
            end
            if root:IsA("Attachment") and closePos(root.WorldPosition) then return true end
            if root:IsA("Beam") and beamStartsClose(root) then return true end
            if root:IsA("BasePart") and partTouchesOrigin(root) then return true end
            local checked=0
            for _,d in ipairs(root:GetDescendants()) do
                checked+=1
                if d:IsA("Attachment") and closePos(d.WorldPosition) then return true end
                if d:IsA("Beam") and beamStartsClose(d) then return true end
                if d:IsA("BasePart") and partTouchesOrigin(d) then return true end
                if checked>=40 then break end
            end
            return false
        end

        local function styleRootPass(root,cOverride)
            if not root or not root.Parent then return nil end
            local effects={}
            if isColorEffect(root) then applyBulletModeTo(root,cOverride); effects[#effects+1]=root end
            for _,d in ipairs(root:GetDescendants()) do
                if isColorEffect(d) then applyBulletModeTo(d,cOverride); effects[#effects+1]=d end
            end
            return effects
        end

        local function styleVerifiedRoot(root,serial)
            if not root or not root.Parent then return end
            claimedShotRoots[root]=serial

            -- Apply synchronously first. If the game creates the root before adding its
            -- Beam/Trail/parts, briefly color new descendants as they arrive too.
            local effects=styleRootPass(root)
            local shortConn
            shortConn=root.DescendantAdded:Connect(function(d)
                if d and d.Parent and isColorEffect(d) then
                    applyBulletModeTo(d)
                    if extraState.BulletColorMode=="Rainbow" then
                        local list=rainbowRoots[root]
                        if list then list[#list+1]=d end
                    end
                end
            end)
            task.delay(.16,function()
                if shortConn then pcall(function() shortConn:Disconnect() end); shortConn=nil end
            end)

            pcall(function()
                root:SetAttribute("KimqLocalBulletStyled",true)
                root:SetAttribute("KimqLocalShotSerial",serial)
            end)
            if extraState.BulletColorMode=="Rainbow" then rainbowRoots[root]=effects or {} else rainbowRoots[root]=nil end

            -- The game can write its default color a moment after construction. These
            -- two tiny passes happen before/around the first visible frames without a
            -- per-frame scanner or PropertyChanged lock.
            for _,delayTime in ipairs({0.008,0.032}) do
                task.delay(delayTime,function()
                    if not root or not root.Parent then return end
                    local refreshed=styleRootPass(root)
                    if extraState.BulletColorMode=="Rainbow" and refreshed then rainbowRoots[root]=refreshed end
                end)
            end
        end

        local function instantClaimCandidate(obj,serial)
            if not bulletEffectEnabled() or serial~=activeShotSerial then return false end
            if (os.clock()-activeShotAt)>.24 then return false end
            local root=bulletRayShotRoot(obj)
            if not root or not root.Parent then return false end
            if claimedShotRoots[root]==serial then return true end

            -- Never touch a projectile explicitly owned by somebody else. When the
            -- game has not populated owner/origin metadata yet, only the FIRST new
            -- bullet root after our own Tool.Activated is provisionally ours.
            local verdict=ownerVerdict(root)
            if verdict==false then return false end
            if verdict==true or instantClaimSerial~=serial then
                instantClaimSerial=serial
                instantClaimRoot=root
                styleVerifiedRoot(root,serial)
                return true
            end
            return instantClaimRoot==root
        end

        local function tryCaptureCandidate(obj,serial)
            if not bulletEffectEnabled() or serial~=activeShotSerial then return false end
            if (os.clock()-activeShotAt)>.38 then return false end
            local root=bulletRayShotRoot(obj)
            if not root or not root.Parent then return false end
            if claimedShotRoots[root]==serial then return true end
            local verdict=ownerVerdict(root)
            if verdict==false then return false end
            if verdict~=true and not rayStartsAtOrigin(root,activeShotOrigin) then return false end
            styleVerifiedRoot(root,serial)
            return true
        end

        local function captureWithShortRetry(obj,serial)
            -- First try the synchronous shot claim so the bullet never renders in its
            -- default color. If metadata is already available, the normal verifier is
            -- still used; delayed retries are only a fallback for late-populated rays.
            if instantClaimCandidate(obj,serial) then return end
            if tryCaptureCandidate(obj,serial) then return end
            for _,delayTime in ipairs({0.012,0.045}) do
                task.delay(delayTime,function()
                    if serial~=activeShotSerial or not obj or not obj.Parent then return end
                    local root=bulletRayShotRoot(obj)
                    if root and claimedShotRoots[root]==serial then return end
                    if instantClaimCandidate(obj,serial) then return end
                    tryCaptureCandidate(obj,serial)
                end)
            end
        end

        local function hasBulletAncestorName(d)
            local x=d
            for _=1,6 do
                if not x then break end
                local n=tostring(x.Name or ""):lower()
                if n:find("bullet",1,true) or n:find("tracer",1,true) or n:find("projectile",1,true) or n:find("ray",1,true) or n:find("beam",1,true) then return true end
                x=x.Parent
            end
            return false
        end

        local function likelyBulletGun(tool)
            if not tool or not tool:IsA("Tool") then return false end
            local n=tostring(tool.Name or ""):lower()
            if n:find("knife",1,true) or n:find("blade",1,true) or n:find("wallet",1,true) or n:find("phone",1,true) then return false end
            local words={"revolver","shotgun","silencer","smg","pistol","rifle","gun","tactical","double","glock","uzi","ak"}
            for _,w in ipairs(words) do if n:find(w,1,true) then return true end end
            -- Unknown Tools are only treated as guns if they expose a typical muzzle/ammo marker.
            return tool:FindFirstChild("Muzzle",true)~=nil or tool:FindFirstChild("Ammo",true)~=nil or tool:FindFirstChild("Clip",true)~=nil
        end

        local function getToolTemplateEffects(tool)
            if not tool or not tool.Parent then return {} end
            local cached=toolTemplateEffects[tool]
            if cached then return cached end
            cached={}
            local touched=0
            for _,d in ipairs(tool:GetDescendants()) do
                if (d:IsA("Beam") or d:IsA("Trail") or d:IsA("ParticleEmitter") or d:IsA("Color3Value") or d:IsA("PointLight") or d:IsA("SpotLight") or d:IsA("SurfaceLight")) and hasBulletAncestorName(d) then
                    cached[#cached+1]=d
                    touched+=1
                    if touched>=48 then break end
                end
            end
            toolTemplateEffects[tool]=cached
            return cached
        end

        local function styleLocalToolTemplates(tool)
            if not tool or not tool.Parent then return end
            local c=currentBulletColor()
            if not c then return end
            for _,d in ipairs(getToolTemplateEffects(tool)) do
                if d and d.Parent then
                    applyColorOnly(d,c)
                    softenBulletGlow(d)
                end
            end
        end

        local function refreshAllLocalGunTemplates()
            if templateRefreshQueued then return end
            templateRefreshQueued=true
            task.defer(function()
                templateRefreshQueued=false
                -- Only the equipped gun needs immediate repainting. Backpack guns are
                -- recolored once when equipped, avoiding full inventory scans.
                if lp.Character then
                    for _,tool in ipairs(lp.Character:GetChildren()) do
                        if tool:IsA("Tool") and likelyBulletGun(tool) then styleLocalToolTemplates(tool) end
                    end
                end
            end)
        end
        _G.KimqRefreshBulletTemplates=refreshAllLocalGunTemplates

        local function hookBulletContainer(container)
            if not container or hookedBulletContainers[container] then return end
            hookedBulletContainers[container]=true
            bulletContainers[container]=true

            -- In this game bullet_rays can be either a shared folder OR the transient
            -- shot object itself. v2.14 assumed it was always a folder, which meant
            -- some guns never got recolored at all. During OUR short Tool.Activated
            -- window, try the bullet_rays object itself synchronously first.
            local serial=activeShotSerial
            local born=bulletRayBirth[container]
            if born and serial~=0 and (os.clock()-activeShotAt)<=.38 and math.abs(born-activeShotAt)<=.45 then
                captureWithShortRetry(container,serial)
            end

            container.ChildAdded:Connect(function(ch)
                local shotSerial=activeShotSerial
                if shotSerial==0 or (os.clock()-activeShotAt)>.38 then return end
                -- Handles the other layout where bullet_rays is a folder containing
                -- a fresh ray/model for each shot.
                captureWithShortRetry(ch,shotSerial)
            end)

            serial=activeShotSerial
            if serial~=0 and (os.clock()-activeShotAt)<=.38 then
                local children=container:GetChildren()
                local newest=children[#children]
                if newest then captureWithShortRetry(newest,serial) end
            end
        end

        -- bullet_rays are transient in this game, so avoid a full workspace scan.
        -- Catch an already-existing object cheaply, then color a newly-created
        -- bullet_rays synchronously when it appears during OUR own shot window.
        local existingBulletRays=workspace:FindFirstChild("bullet_rays",true)
        if existingBulletRays then hookBulletContainer(existingBulletRays) end
        workspace.DescendantAdded:Connect(function(d)
            if tostring(d.Name):lower()=="bullet_rays" then
                local now=os.clock()
                bulletRayBirth[d]=now
                local serial=activeShotSerial
                if serial~=0 and (now-activeShotAt)<=.38 then
                    -- A bullet_rays object born right beside our Tool.Activated is a
                    -- transient local-shot candidate. Style it immediately.
                    captureWithShortRetry(d,serial)
                end
                hookBulletContainer(d)
            end
        end)

        local function markLocalShot(tool)
            if not tool or tool.Parent~=lp.Character then return end
            local origin=toolMuzzleOrigin(tool)
            if not origin then return end
            -- Gun templates are already colored on equip; do not rescan the Tool on every shot.
            localShotSerial+=1
            activeShotSerial=localShotSerial
            activeShotAt=os.clock()
            activeShotOrigin=origin
            instantClaimSerial=0
            instantClaimRoot=nil
            lastLocalShot=activeShotAt
            local serial=activeShotSerial
            -- ChildAdded is the normal capture path. This one-item fallback handles
            -- a bullet created in the same scheduler slice without walking old rays.
            task.defer(function()
                for container,_ in pairs(bulletContainers) do
                    if container and container.Parent then
                        -- Claim bullet_rays itself only when it was newly born around
                        -- this shot. A pre-existing shared holder is never bulk-colored.
                        local born=bulletRayBirth[container]
                        if born and math.abs(born-activeShotAt)<=.45 then
                            captureWithShortRetry(container,serial)
                        end
                        -- If it is a shared holder, claim only its newest child.
                        local children=container:GetChildren()
                        local newest=children[#children]
                        if newest then captureWithShortRetry(newest,serial) end
                    end
                end
            end)
        end

        local function hookShotTool(tool)
            if not tool or not tool:IsA("Tool") or hookedShotTools[tool] then return end
            hookedShotTools[tool]=true

            -- Some guns rewrite/rebuild their local bullet template on equip. Repaint
            -- it a few times only around equip (not every frame), and color any newly
            -- inserted bullet/beam effect immediately. This keeps the selected color
            -- persistent after putting the gun away and taking it back out.
            tool.DescendantAdded:Connect(function(d)
                if bulletEffectEnabled() and isColorEffect(d) and hasBulletAncestorName(d) then
                    applyBulletModeTo(d)
                    toolTemplateEffects[tool]=nil
                end
            end)
            tool.Equipped:Connect(function()
                if not likelyBulletGun(tool) then return end
                toolTemplateEffects[tool]=nil
                styleLocalToolTemplates(tool)
                task.delay(.035,function() if tool and tool.Parent then toolTemplateEffects[tool]=nil; styleLocalToolTemplates(tool) end end)
                task.delay(.12,function() if tool and tool.Parent then toolTemplateEffects[tool]=nil; styleLocalToolTemplates(tool) end end)
            end)
            tool.Activated:Connect(function() markLocalShot(tool) end)
        end

        local function hookShotContainer(container)
            if not container or hookedShotContainers[container] then return end
            hookedShotContainers[container]=true
            for _,ch in ipairs(container:GetChildren()) do hookShotTool(ch) end
            container.ChildAdded:Connect(hookShotTool)
        end

        local function hookAllShotContainers()
            hookShotContainer(lp:FindFirstChildOfClass("Backpack"))
            if lp.Character then hookShotContainer(lp.Character) end
            refreshAllLocalGunTemplates()
        end
        hookAllShotContainers()
        lp.CharacterAdded:Connect(function()
            activeShotSerial=0; activeShotOrigin=nil; instantClaimSerial=0; instantClaimRoot=nil
            task.delay(.15,hookAllShotContainers)
        end)

        local rainbowAccumulator=0
        RunService.Heartbeat:Connect(function(dt)
            if extraState.BulletColorMode~="Rainbow" then
                if next(rainbowRoots)~=nil then table.clear(rainbowRoots) end
                return
            end
            rainbowAccumulator+=dt
            if rainbowAccumulator<0.05 then return end
            rainbowAccumulator=0
            local c=Color3.fromHSV((os.clock()*.45)%1,1,1)
            for root,effects in pairs(rainbowRoots) do
                if not root or not root.Parent then
                    rainbowRoots[root]=nil
                else
                    local alive=0
                    for _,d in ipairs(effects) do if d and d.Parent then applyColorOnly(d,c); alive+=1 end end
                    if alive==0 then rainbowRoots[root]=nil end
                end
            end
        end)

        refreshAllLocalGunTemplates()


        -- Shared animated cosmetic clone for knife skins. It uses the same animation
        -- ID/Humanoid/AnimationController logic that made Ascension work.
        local function sanitizeClone(root)
            local clientScripts=0
            for _,d in ipairs(root:GetDescendants()) do
                if d:IsA("LocalScript") then
                    -- Cosmetic clones do not need their own game scripts. Running cloned
                    -- scripts was a major knife-equip performance spike.
                    clientScripts+=1; pcall(function() d.Disabled=true end); pcall(function() d.Enabled=false end)
                elseif d:IsA("ModuleScript") then
                    -- Keep modules for local animation scripts.
                elseif d:IsA("Script") then
                    local isClient=false; pcall(function() isClient=(d.RunContext==Enum.RunContext.Client) end)
                    if isClient then clientScripts+=1; pcall(function() d.Disabled=true end); pcall(function() d.Enabled=false end) else d:Destroy() end
                elseif d:IsA("BasePart") then
                    d.Anchored=false; d.CanCollide=false; d.CanTouch=false; d.CanQuery=false; d.Massless=true
                    pcall(function() d.AssemblyLinearVelocity=Vector3.zero; d.AssemblyAngularVelocity=Vector3.zero end)
                elseif d:IsA("ParticleEmitter") then
                    pcall(function() d.Enabled=true; d.Rate=math.min(d.Rate,45) end)
                elseif d:IsA("Trail") or d:IsA("Beam") or d:IsA("Fire") or d:IsA("Smoke") or d:IsA("Sparkles") then
                    pcall(function() d.Enabled=true end)
                elseif d:IsA("PointLight") or d:IsA("SpotLight") or d:IsA("SurfaceLight") then
                    pcall(function() d.Enabled=true end)
                elseif d:IsA("SurfaceGui") or d:IsA("BillboardGui") then
                    pcall(function() d.Enabled=true end)
                end
            end
            if root:IsA("BasePart") then root.Anchored=false; root.CanCollide=false; root.CanTouch=false; root.CanQuery=false; root.Massless=true end
            return clientScripts
        end
        local knifeEquipHooks=setmetatable({}, {__mode="k"})
        local knifeClearing=setmetatable({}, {__mode="k"})
        local applyKnifeSkin

        local function clearKnifeVisual(tool,keepSelection)
            if not tool then return end
            knifeClearing[tool]=true
            for _,ch in ipairs(tool:GetChildren()) do
                if ch.Name=="KimqKnifeSkinVisual" then pcall(function() ch:Destroy() end) end
            end
            for _,d in ipairs(tool:GetDescendants()) do
                if d:IsA("BasePart") and d:GetAttribute("KimqKnifeOriginalPart") then
                    pcall(function() d.LocalTransparencyModifier=d:GetAttribute("KimqKnifeOldLTM") or 0 end)
                    d:SetAttribute("KimqKnifeOriginalPart",nil); d:SetAttribute("KimqKnifeOldLTM",nil)
                end
            end
            knifeClearing[tool]=nil
        end
        local function findKnifeTool()
            local function scan(container)
                if not container then return nil end
                for _,ch in ipairs(container:GetChildren()) do
                    if ch:IsA("Tool") then
                        local n=ch.Name:lower():gsub("[%[%]]","")
                        if n=="knife" or n:find("knife",1,true) or n:find("blade",1,true) then return ch end
                    end
                end
                -- Some games wrap the Tool one level down.
                for _,ch in ipairs(container:GetDescendants()) do
                    if ch:IsA("Tool") then
                        local n=ch.Name:lower():gsub("[%[%]]","")
                        if n=="knife" or n:find("knife",1,true) or n:find("blade",1,true) then return ch end
                    end
                end
            end
            return scan(lp.Character) or scan(lp:FindFirstChildOfClass("Backpack"))
        end
        local function visibleKnifePart(part)
            local n=tostring(part.Name):upper()
            if n:find("HITBOX",1,true) or n=="HUMANOIDROOTPART" or n:find("PARTICLE_PART",1,true)
                or n:find("COLLIDER",1,true) or n:find("COLLISION",1,true) or n:find("HIT_PART",1,true) then
                return false
            end

            -- Plain Handle parts are commonly just weld/animation carriers. Keep them
            -- invisible so a grey rectangular block cannot surround the selected knife.
            -- A Handle with a SpecialMesh is real visible geometry and is kept.
            if part.Name=="Handle" and part:IsA("Part") and not part:FindFirstChildWhichIsA("SpecialMesh") then
                return false
            end
            if part:IsA("MeshPart") or part:IsA("UnionOperation") or part:FindFirstChildWhichIsA("SpecialMesh") then
                return true
            end

            -- Other plain BaseParts are visible only when the template intentionally made them visible.
            return part.Transparency < .95
        end
        local function ensureKnifeEquipHook(tool)
            if not tool or knifeEquipHooks[tool] then return end
            knifeEquipHooks[tool]=true
            tool.Equipped:Connect(function()
                task.delay(.08,function()
                    if tool.Parent==lp.Character and extraState.KnifeSkin and extraState.KnifeSkin~="None" and not tool:FindFirstChild("KimqKnifeSkinVisual") then
                        if applyKnifeSkin then applyKnifeSkin(extraState.KnifeSkin,true) end
                    end
                end)
            end)
            tool.ChildRemoved:Connect(function(ch)
                if ch.Name=="KimqKnifeSkinVisual" and not knifeClearing[tool] and extraState.KnifeSkin and extraState.KnifeSkin~="None" then
                    task.delay(.12,function()
                        if tool.Parent and not tool:FindFirstChild("KimqKnifeSkinVisual") and applyKnifeSkin then applyKnifeSkin(extraState.KnifeSkin,true) end
                    end)
                end
            end)
        end

        local knifeAccentButtons={}
        local function knifeAccentColor()
            if extraState.KnifeAccentMode=="Theme" then
                return pcolor("hot",hotColor)
            elseif extraState.KnifeAccentMode=="Bullet" then
                return currentBulletColor() or bulletCustomColor
            end
            return nil
        end
        local function knifeAccentCandidate(d)
            if d:IsA("Beam") or d:IsA("Trail") or d:IsA("ParticleEmitter") or d:IsA("Color3Value")
                or d:IsA("PointLight") or d:IsA("SpotLight") or d:IsA("SurfaceLight") then
                return true
            end
            if d:IsA("BasePart") then
                local n=d.Name:lower()
                return d.Material==Enum.Material.Neon
                    or n:find("glow",1,true) or n:find("effect",1,true) or n:find("aura",1,true)
                    or n:find("light",1,true) or n:find("neon",1,true) or n:find("energy",1,true)
                    or n:find("accent",1,true)
            end
            return false
        end
        local function applyKnifeAccentTo(root)
            local c=knifeAccentColor()
            if not root or not c then return end
            if knifeAccentCandidate(root) then applyColorOnly(root,c) end
            for _,d in ipairs(root:GetDescendants()) do
                if knifeAccentCandidate(d) then applyColorOnly(d,c) end
            end
        end
        local function refreshKnifeAccentStyle()
            local p=palette()
            for mode,b in pairs(knifeAccentButtons) do
                if b and b.Parent then
                    local on=mode==extraState.KnifeAccentMode
                    b.BackgroundColor3=on and p.hot or p.soft
                    b.TextColor3=on and (p.white or Color3.new(1,1,1)) or p.text
                    local st=b:FindFirstChildOfClass("UIStroke")
                    if st then st.Color=on and p.hot or p.line end
                end
            end
        end
        local function refreshKnifeAccentVisual()
            local t=findKnifeTool()
            local visual=t and t:FindFirstChild("KimqKnifeSkinVisual")
            if visual and extraState.KnifeAccentMode~="Off" then applyKnifeAccentTo(visual) end
        end
        _G.KimqRefreshKnifeAccentTheme=function()
            refreshKnifeAccentStyle()
            if extraState.KnifeAccentMode=="Theme" then refreshKnifeAccentVisual() end
        end

        applyKnifeSkin=function(name,quiet)
            name=tostring(name or "None")
            extraState.KnifeSkin=name
            local tool=findKnifeTool()
            if not tool then return false,"Knife is not in your Backpack / Character" end
            ensureKnifeEquipHook(tool)
            clearKnifeVisual(tool,true)
            if name=="None" then return true,"Knife skin reset" end
            local root=findFolder({"Knives","KnifeSkins","Knife Skins"})
            local source=root and root:FindFirstChild(name)
            if not source then return false,"Knife skin was not found" end
            local sourceRoot=source:FindFirstChild("Handle")
            if not (sourceRoot and sourceRoot:IsA("BasePart")) then sourceRoot=firstPart(source) end
            local target=tool:FindFirstChild("Handle")
            if not (target and target:IsA("BasePart")) then target=firstPart(tool) end
            if not sourceRoot then return false,"Selected knife has no Handle" end
            if not target then return false,"Your equipped Knife has no Handle" end

            -- Capture ORIGINAL tool visuals before parenting the clone so we never
            -- accidentally hide our own skin. This was the main reason some skins
            -- ended up completely invisible in the previous build.
            local originals={}
            for _,d in ipairs(tool:GetDescendants()) do
                if d:IsA("BasePart") then table.insert(originals,d) end
            end

            -- Clone the complete ReplicatedStorage.Knives model exactly. Beta/Bitcoin/
            -- Nightblade store the meshes, unions, trails and attachments under Handle;
            -- Fishbone can also include an AnimationController and extra rig parts.
            local visual=source:Clone()
            visual.Name="KimqKnifeSkinVisual"
            sanitizeClone(visual)
            local cloneRoot=visual:FindFirstChild("Handle")
            if not (cloneRoot and cloneRoot:IsA("BasePart")) then cloneRoot=firstPart(visual) end
            if not cloneRoot then visual:Destroy(); return false,"Knife clone lost its Handle" end

            -- Reveal authored display geometry only. Keep hitboxes/particle carriers hidden.
            local visibleCount=0
            local allParts={}
            if visual:IsA("BasePart") then table.insert(allParts,visual) end
            for _,d in ipairs(visual:GetDescendants()) do if d:IsA("BasePart") then table.insert(allParts,d) end end
            for _,part in ipairs(allParts) do
                part.Anchored=false; part.CanCollide=false; part.CanTouch=false; part.CanQuery=false; part.Massless=true
                part.LocalTransparencyModifier=0
                if visibleKnifePart(part) then
                    if part.Transparency>=.95 then pcall(function() part.Transparency=0 end) end
                    visibleCount+=1
                else
                    pcall(function() part.Transparency=1 end)
                end
            end

            -- Match the selected template Handle directly to the real Knife Handle.
            -- No auto-scaling: every skin keeps its authored proportions.
            local delta=target.CFrame*sourceRoot.CFrame:Inverse()
            if visual:IsA("BasePart") then visual.CFrame=delta*visual.CFrame end
            for _,d in ipairs(visual:GetDescendants()) do if d:IsA("BasePart") then d.CFrame=delta*d.CFrame end end
            visual.Parent=tool

            -- Preserve authored joints/constraints/AnimationController rigs, and only
            -- weld genuinely loose visual parts to the cloned Handle.
            local jointed={}
            for _,j in ipairs(visual:GetDescendants()) do
                if j:IsA("JointInstance") then
                    if j.Part0 then jointed[j.Part0]=true end; if j.Part1 then jointed[j.Part1]=true end
                elseif j:IsA("WeldConstraint") then
                    if j.Part0 then jointed[j.Part0]=true end; if j.Part1 then jointed[j.Part1]=true end
                elseif j:IsA("Constraint") then
                    local a0,a1=nil,nil; pcall(function() a0=j.Attachment0 end); pcall(function() a1=j.Attachment1 end)
                    if a0 and a0.Parent and a0.Parent:IsA("BasePart") then jointed[a0.Parent]=true end
                    if a1 and a1.Parent and a1.Parent:IsA("BasePart") then jointed[a1.Parent]=true end
                end
            end
            local rootWeld=Instance.new("WeldConstraint")
            rootWeld.Name="KimqKnifeRootWeld"; rootWeld.Part0=target; rootWeld.Part1=cloneRoot; rootWeld.Parent=cloneRoot
            for _,d in ipairs(visual:GetDescendants()) do
                if d:IsA("BasePart") and d~=cloneRoot and not jointed[d] then
                    local w=Instance.new("WeldConstraint"); w.Name="KimqKnifeLooseWeld"; w.Part0=cloneRoot; w.Part1=d; w.Parent=d
                end
            end

            -- Hide only ORIGINAL display geometry, never hitboxes and never the clone.
            for _,d in ipairs(originals) do
                if d.Parent and visibleKnifePart(d) then
                    d:SetAttribute("KimqKnifeOriginalPart",true)
                    d:SetAttribute("KimqKnifeOldLTM",d.LocalTransparencyModifier)
                    d.LocalTransparencyModifier=1
                end
            end

            applyKnifeAccentTo(visual)
            local embedded,driver,found=playSkinAnimationsFromIds(source,visual)
            local mirrored=mirrorPlayingAnimations(source,visual)
            local detail=""
            if embedded+mirrored>0 then detail="  •  animated"
            elseif found and found>0 then detail="  •  animation ready"
            elseif hasAnimatedVisuals(source) then detail="  •  VFX ready" end
            return true,"Knife skin: "..name..detail.."  •  "..tostring(visibleCount).." visible part(s)"
        end

        local knifeCard=card(skinsPage,205); knifeCard.Name="KimqKnifeSkinsCard"
        txt(knifeCard,"Knife Skins",UDim2.new(1,-24,0,22),UDim2.fromOffset(12,8),Enum.Font.GothamBold,14,pcolor("text",textColor))
        txt(knifeCard,"Choose the knife style you want to use.",UDim2.new(1,-24,0,20),UDim2.fromOffset(12,32),Enum.Font.Gotham,11,pcolor("sub",subColor))
        local knifeList=Instance.new("ScrollingFrame",knifeCard); knifeList.Name="KimqKnifeList"; knifeList.Size=UDim2.new(1,-20,0,105); knifeList.Position=UDim2.fromOffset(10,62); knifeList.BackgroundTransparency=1; knifeList.BorderSizePixel=0; knifeList.ScrollBarThickness=3; knifeList.ScrollBarImageColor3=pcolor("hot",hotColor)
        local knifeGrid=Instance.new("UIGridLayout",knifeList); knifeGrid.CellPadding=UDim2.fromOffset(7,7); knifeGrid.CellSize=UDim2.new(.24,-5,0,34); knifeGrid.SortOrder=Enum.SortOrder.LayoutOrder
        knifeGrid:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() knifeList.CanvasSize=UDim2.new(0,0,0,knifeGrid.AbsoluteContentSize.Y+7) end)
        local knifeStatus=txt(knifeCard,"Knife skin: None",UDim2.new(1,-24,0,22),UDim2.fromOffset(12,176),Enum.Font.GothamSemibold,11,pcolor("sub",subColor))
        local knifeButtons={}
        local function refreshKnifeStyle() styleChoiceButtons(knifeButtons,extraState.KnifeSkin) end
        local function scanKnives()
            for _,ch in ipairs(knifeList:GetChildren()) do if ch:IsA("TextButton") then ch:Destroy() end end; table.clear(knifeButtons)
            local root=findFolder({"Knives","KnifeSkins","Knife Skins"}); local names={"None"}
            if root then for _,ch in ipairs(root:GetChildren()) do if ch.Name~="None" and (firstPart(ch) or ch:IsA("Tool")) then table.insert(names,ch.Name) end end end
            table.sort(names,function(a,b) if a=="None" then return true elseif b=="None" then return false else return a:lower()<b:lower() end end)
            for i,name in ipairs(names) do
                local b=makeGridButton(knifeList,name); b.LayoutOrder=i; knifeButtons[name]=b
                b.MouseButton1Click:Connect(function()
                    local ok,msg=applyKnifeSkin(name,false); refreshKnifeStyle(); knifeStatus.Text=msg; knifeStatus.TextColor3=ok and pcolor("hot",hotColor) or pcolor("sub",subColor)
                end)
            end
            refreshKnifeStyle()
        end

        local knifeAccentCard=card(skinsPage,94); knifeAccentCard.Name="KimqKnifeAccentCard"
        txt(knifeAccentCard,"Knife Accent Recolor",UDim2.new(1,-24,0,22),UDim2.fromOffset(12,8),Enum.Font.GothamBold,14,pcolor("text",textColor))
        txt(knifeAccentCard,"Optional: recolor knife glow/VFX + neon accent pieces, not the whole mesh.",UDim2.new(1,-24,0,18),UDim2.fromOffset(12,31),Enum.Font.Gotham,10,pcolor("sub",subColor))
        for i,mode in ipairs({"Off","Theme","Bullet"}) do
            local b=makeGridButton(knifeAccentCard,mode)
            b.Size=UDim2.new(.333,-10,0,30)
            b.Position=UDim2.new((i-1)/3,8+(i-1)*2,0,56)
            knifeAccentButtons[mode]=b
            b.MouseButton1Click:Connect(function()
                extraState.KnifeAccentMode=mode
                refreshKnifeAccentStyle()
                local t=findKnifeTool()
                if t and extraState.KnifeSkin and extraState.KnifeSkin~="None" then
                    -- Reclone from the untouched template so switching Off restores authored colors.
                    applyKnifeSkin(extraState.KnifeSkin,true)
                end
            end)
        end
        refreshKnifeAccentStyle()

        -- Equippable local items.
        local equipCard=card(skinsPage,238); equipCard.Name="KimqEquipableItemsCard"
        txt(equipCard,"Equippable Items",UDim2.new(1,-24,0,22),UDim2.fromOffset(12,8),Enum.Font.GothamBold,14,pcolor("text",textColor))
        txt(equipCard,"Choose an item to wear or hold locally.",UDim2.new(1,-24,0,20),UDim2.fromOffset(12,32),Enum.Font.Gotham,11,pcolor("sub",subColor))
        local equipList=Instance.new("ScrollingFrame",equipCard); equipList.Name="KimqEquipableList"; equipList.Size=UDim2.new(1,-20,0,112); equipList.Position=UDim2.fromOffset(10,62); equipList.BackgroundTransparency=1; equipList.BorderSizePixel=0; equipList.ScrollBarThickness=3; equipList.ScrollBarImageColor3=pcolor("hot",hotColor)
        local equipGrid=Instance.new("UIGridLayout",equipList); equipGrid.CellPadding=UDim2.fromOffset(7,7); equipGrid.CellSize=UDim2.new(.32,-5,0,34); equipGrid.SortOrder=Enum.SortOrder.LayoutOrder
        equipGrid:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() equipList.CanvasSize=UDim2.new(0,0,0,equipGrid.AbsoluteContentSize.Y+7) end)
        local equipStatus=txt(equipCard,"Equippable: None",UDim2.new(1,-150,0,22),UDim2.fromOffset(12,184),Enum.Font.GothamSemibold,11,pcolor("sub",subColor))
        local removeEquip=Instance.new("TextButton",equipCard); removeEquip.Size=UDim2.fromOffset(126,32); removeEquip.Position=UDim2.new(1,-138,0,181); removeEquip.BackgroundColor3=pcolor("soft",lightColor); removeEquip.BorderSizePixel=0; removeEquip.Text="remove item"; removeEquip.TextColor3=pcolor("text",textColor); removeEquip.Font=Enum.Font.GothamSemibold; removeEquip.TextSize=11; corner(removeEquip,9); stroke(removeEquip,pcolor("line",lineColor),.35,1)
        local equipButtons={}
        local activeWornEquippable=nil

        local function clearWornEquippable()
            if activeWornEquippable and activeWornEquippable.Parent then
                pcall(function() activeWornEquippable:Destroy() end)
            end
            activeWornEquippable=nil
            local char=lp.Character
            if char then
                for _,ch in ipairs(char:GetChildren()) do
                    if ch:GetAttribute("KimqWornEquippable") then
                        pcall(function() ch:Destroy() end)
                    end
                end
            end
        end

        local function clearLocalEquippables()
            clearWornEquippable()
            local function clean(container)
                if not container then return end
                for _,ch in ipairs(container:GetChildren()) do
                    if ch:IsA("Tool") and ch:GetAttribute("KimqLocalEquippable") then
                        ch:Destroy()
                    end
                end
            end
            clean(lp.Character); clean(lp:FindFirstChildOfClass("Backpack"))
        end

        local function findMatchingBodyAttachment(handle,char)
            if not handle or not char then return nil,nil end
            -- Prefer a matching authored attachment when the model has one.
            for _,a in ipairs(handle:GetDescendants()) do
                if a:IsA("Attachment") then
                    local target=char:FindFirstChild(a.Name,true)
                    if target and target:IsA("Attachment") and target.Parent and target.Parent:IsA("BasePart") then
                        return a,target
                    end
                end
            end
            return nil,nil
        end

        -- Angel Wings fit only moves the ROOT Handle. The original Handle -> wing
        -- Motor6Ds (and their authored C0/C1 values) are never rewritten.
        local WING_FIT_PATH = "KimqetrasHC/angel_wings_fit.json"
        local wingFitDefault={X=0,Y=0.12,Z=0.30,RX=0,RY=0,RZ=0}
        local wingFit={X=wingFitDefault.X,Y=wingFitDefault.Y,Z=wingFitDefault.Z,RX=0,RY=0,RZ=0}

        local function wingFitCFrame()
            return CFrame.new(wingFit.X,wingFit.Y,wingFit.Z) * CFrame.Angles(math.rad(wingFit.RX),math.rad(wingFit.RY),math.rad(wingFit.RZ))
        end
        local function ensureWingFitFolder()
            if type(isfolder)~="function" or type(makefolder)~="function" then return false end
            pcall(function() if not isfolder("KimqetrasHC") then makefolder("KimqetrasHC") end end)
            local ok,v=pcall(isfolder,"KimqetrasHC")
            return ok and v==true
        end
        local function loadWingFitDisk()
            if type(isfile)~="function" or type(readfile)~="function" then return false end
            local okExists,exists=pcall(isfile,WING_FIT_PATH); if not okExists or not exists then return false end
            local okRaw,raw=pcall(readfile,WING_FIT_PATH); if not okRaw or type(raw)~="string" then return false end
            local okData,data=pcall(function() return game:GetService("HttpService"):JSONDecode(raw) end)
            if not okData or type(data)~="table" then return false end
            for _,k in ipairs({"X","Y","Z","RX","RY","RZ"}) do
                local n=tonumber(data[k]); if n then wingFit[k]=n end
            end
            return true
        end
        local function saveWingFitDisk()
            if not ensureWingFitFolder() or type(writefile)~="function" then return false end
            local payload={X=wingFit.X,Y=wingFit.Y,Z=wingFit.Z,RX=wingFit.RX,RY=wingFit.RY,RZ=wingFit.RZ}
            local okJson,json=pcall(function() return game:GetService("HttpService"):JSONEncode(payload) end)
            if not okJson then return false end
            return pcall(writefile,WING_FIT_PATH,json)
        end
        loadWingFitDisk()

        local function prepareAngelWingsClone(visual)
            -- Preserve the full object hierarchy and every Motor6D/Animation/Humanoid.
            -- Scripts are kept in the clone (not destroyed) but disabled so a local cosmetic
            -- cannot start duplicate gameplay loops.
            for _,d in ipairs(visual:GetDescendants()) do
                if d:IsA("LocalScript") or d:IsA("Script") then
                    pcall(function() d.Disabled=true end); pcall(function() d.Enabled=false end)
                elseif d:IsA("BasePart") then
                    d.Anchored=false; d.CanCollide=false; d.CanTouch=false; d.CanQuery=false; d.Massless=true
                    pcall(function() d.AssemblyLinearVelocity=Vector3.zero; d.AssemblyAngularVelocity=Vector3.zero end)
                elseif d:IsA("ParticleEmitter") or d:IsA("Trail") or d:IsA("Beam") or d:IsA("Fire") or d:IsA("Smoke") or d:IsA("Sparkles") then
                    pcall(function() d.Enabled=true end)
                elseif d:IsA("PointLight") or d:IsA("SpotLight") or d:IsA("SurfaceLight") then
                    pcall(function() d.Enabled=true end)
                elseif d:IsA("SurfaceGui") or d:IsA("BillboardGui") then
                    pcall(function() d.Enabled=true end)
                end
            end
        end

        local function applyWingFitToCurrent()
            local visual=activeWornEquippable
            if not visual or not visual.Parent then
                local char=lp.Character
                visual=char and char:FindFirstChild("KimqWornAngelWings")
            end
            if not visual then return false end
            local handle=visual:FindFirstChild("Handle",true)
            if not (handle and handle:IsA("BasePart")) then return false end
            local root=handle:FindFirstChild("KimqAngelWingsRoot")
            if root and root:IsA("Motor6D") then
                root.C0=wingFitCFrame(); root.C1=CFrame.new()
                return true
            end
            return false
        end

        local function markWingRigSafe(visual)
            -- Keep the mini-rig that ships with Angel Wings intact.  Its Humanoid / Animator
            -- is what drives the authored Motor6Ds, so deleting it makes some wing poses,
            -- halo effects, and animation tracks stop working.
            for _,d in ipairs(visual:GetDescendants()) do
                if d:IsA("Humanoid") then
                    pcall(function() d.DisplayDistanceType=Enum.HumanoidDisplayDistanceType.None end)
                    pcall(function() d.NameDisplayDistance=0 end)
                    pcall(function() d.HealthDisplayDistance=0 end)
                    pcall(function() d.BreakJointsOnDeath=false end)
                    pcall(function() d.RequiresNeck=false end)
                    pcall(function() d.AutoRotate=false end)
                elseif d:IsA("BasePart") then
                    d.Anchored=true
                    d.CanCollide=false
                    d.CanTouch=false
                    d.CanQuery=false
                    d.Massless=true
                    d.LocalTransparencyModifier=0
                    pcall(function()
                        d.AssemblyLinearVelocity=Vector3.zero
                        d.AssemblyAngularVelocity=Vector3.zero
                    end)
                elseif d:IsA("ParticleEmitter") or d:IsA("Trail") or d:IsA("Beam") then
                    pcall(function() d.Enabled=true end)
                elseif d:IsA("PointLight") or d:IsA("SpotLight") or d:IsA("SurfaceLight") then
                    pcall(function() d.Enabled=true end)
                end
            end
        end

        local function revealWingHalo(visual)
            -- Some versions of Angel Wings keep the halo/effect carrier almost transparent
            -- in storage and reveal it when equipped. Reveal only objects whose name/parent
            -- identifies them as halo visuals; the invisible body Handle stays hidden below.
            for _,d in ipairs(visual:GetDescendants()) do
                if d:IsA("BasePart") then
                    local n=tostring(d.Name):lower()
                    local par=tostring(d.Parent and d.Parent.Name or ""):lower()
                    if n:find("halo",1,true) or par:find("halo",1,true) then
                        d.LocalTransparencyModifier=0
                        if d.Transparency>=.95 then pcall(function() d.Transparency=0 end) end
                    end
                elseif d:IsA("ParticleEmitter") or d:IsA("Trail") or d:IsA("Beam") then
                    local n=tostring(d.Name):lower()
                    local par=tostring(d.Parent and d.Parent.Name or ""):lower()
                    if n:find("halo",1,true) or par:find("halo",1,true) then
                        pcall(function() d.Enabled=true end)
                    end
                end
            end
        end

        local function attachNestedAccessoryToCharacter(acc,char)
            if not acc or not acc:IsA("Accessory") or not char then return false end
            local h=acc:FindFirstChild("Handle")
            if not (h and h:IsA("BasePart")) then return false end
            local bestBody,bestBodyAtt,bestHandleAtt=nil,nil,nil
            for _,a in ipairs(h:GetDescendants()) do
                if a:IsA("Attachment") then
                    local target=char:FindFirstChild(a.Name,true)
                    if target and target:IsA("Attachment") and target.Parent and target.Parent:IsA("BasePart") then
                        bestBody=target.Parent; bestBodyAtt=target; bestHandleAtt=a; break
                    end
                end
            end
            if not bestBody then
                local low=tostring(acc.Name):lower()
                if low:find("halo",1,true) then
                    bestBody=char:FindFirstChild("Head")
                    if bestBody and bestBody:IsA("BasePart") then
                        acc.Parent=char
                        h.CFrame=bestBody.CFrame*CFrame.new(0,0.85,0)
                        local w=Instance.new("WeldConstraint")
                        w.Name="KimqHaloWeld"; w.Part0=bestBody; w.Part1=h; w.Parent=h
                        acc:SetAttribute("KimqWornEquippable",true)
                        h.CanCollide=false; h.CanTouch=false; h.CanQuery=false; h.Massless=true; h.Anchored=false
                        return true
                    end
                end
                return false
            end
            acc.Parent=char
            h.CFrame=bestBody.CFrame*bestBodyAtt.CFrame*bestHandleAtt.CFrame:Inverse()
            local w=Instance.new("Weld")
            w.Name="KimqWingAccessoryWeld"; w.Part0=bestBody; w.Part1=h
            w.C0=bestBodyAtt.CFrame; w.C1=bestHandleAtt.CFrame; w.Parent=h
            acc:SetAttribute("KimqWornEquippable",true)
            h.CanCollide=false; h.CanTouch=false; h.CanQuery=false; h.Massless=true; h.Anchored=false
            return true
        end

        local function makeAngelWingsWearable(source,tool)
            local char=lp.Character
            if not char then return false,"Character was not ready" end

            clearWornEquippable()

            -- Clone the complete authored mini-rig and keep all original Motor6Ds intact.
            local visual=source:Clone()
            visual.Name="KimqWornAngelWings"
            visual:SetAttribute("KimqWornEquippable",true)
            prepareAngelWingsClone(visual)
            markWingRigSafe(visual)
            revealWingHalo(visual)

            local handle=visual:FindFirstChild("Handle",true)
            if not (handle and handle:IsA("BasePart")) then handle=firstPart(visual) end
            local torso=char:FindFirstChild("UpperTorso") or char:FindFirstChild("Torso") or char:FindFirstChild("HumanoidRootPart")
            if not handle or not torso or not torso:IsA("BasePart") then
                visual:Destroy()
                return false,"Angel Wings could not find a body attachment"
            end

            -- The rectangular Handle is only the rig carrier. The real wing meshes stay visible.
            pcall(function()
                handle.Transparency=1
                handle.LocalTransparencyModifier=1
                handle.CastShadow=false
                handle.CanCollide=false; handle.CanTouch=false; handle.CanQuery=false; handle.Massless=true
            end)

            -- Place the whole assembly near its final location before unanchoring so there is
            -- no one-frame jump. This transformation does NOT touch any Motor6D C0/C1.
            local desiredHandle=torso.CFrame * wingFitCFrame()
            local delta=desiredHandle * handle.CFrame:Inverse()
            if visual:IsA("BasePart") then visual.CFrame=delta*visual.CFrame end
            for _,d in ipairs(visual:GetDescendants()) do
                if d:IsA("BasePart") then d.CFrame=delta*d.CFrame end
            end

            visual.Parent=char

            -- One root Motor6D is the only new rig joint. Everything below Handle is the
            -- game's original authored rig, so wing animation/spacing remains untouched.
            local bodyMotor=Instance.new("Motor6D")
            bodyMotor.Name="KimqAngelWingsRoot"
            bodyMotor.Part0=torso
            bodyMotor.Part1=handle
            bodyMotor.C0=wingFitCFrame()
            bodyMotor.C1=CFrame.new()
            bodyMotor.Parent=handle

            -- If a true nested Accessory exists (for example a halo in another asset revision),
            -- let Roblox-style attachment matching mount that piece to the correct body part.
            local nested={}
            for _,d in ipairs(visual:GetDescendants()) do
                if d:IsA("Accessory") then table.insert(nested,d) end
            end
            for _,acc in ipairs(nested) do
                pcall(function() attachNestedAccessoryToCharacter(acc,char) end)
            end

            for _,d in ipairs(visual:GetDescendants()) do
                if d:IsA("BasePart") then d.Anchored=false end
            end
            revealWingHalo(visual)

            activeWornEquippable=visual
            if tool and tool.Parent then
                tool:SetAttribute("KimqAngelWingsWorn",true)
                tool.ToolTip="Click to remove Angel Wings"
            end

            -- Keep the original rig driver. If nothing is already playing, start any authored
            -- animation IDs without rebuilding or replacing the wing Motor6Ds.
            task.delay(.12,function()
                if not visual.Parent then return end
                local alreadyPlaying=false
                for _,d in ipairs(visual:GetDescendants()) do
                    if d:IsA("Animator") then
                        local ok,tracks=pcall(function() return d:GetPlayingAnimationTracks() end)
                        if ok and tracks and #tracks>0 then alreadyPlaying=true break end
                    end
                end
                if not alreadyPlaying then pcall(function() playSkinAnimationsFromIds(source,visual) end) end
                pcall(function() applyWingFitToCurrent() end)
                pcall(function() revealWingHalo(visual) end)
            end)
            return true,"Angel Wings are on ♡"
        end

        local function buildAngelWingsTool(source)
            local tool=Instance.new("Tool")
            tool.Name=source.Name
            tool.RequiresHandle=true
            tool.CanBeDropped=false
            tool.ToolTip="Equip, then click to wear Angel Wings"
            tool:SetAttribute("KimqLocalEquippable",true)
            tool:SetAttribute("KimqAngelWingsTool",true)

            local handle=Instance.new("Part")
            handle.Name="Handle"
            handle.Size=Vector3.new(.2,.2,.2)
            handle.Transparency=1
            handle.CanCollide=false
            handle.CanTouch=false
            handle.CanQuery=false
            handle.Massless=true
            handle.CastShadow=false
            handle.Parent=tool

            tool.Activated:Connect(function()
                if tool:GetAttribute("KimqAngelWingsWorn") then
                    clearWornEquippable()
                    tool:SetAttribute("KimqAngelWingsWorn",false)
                    tool.ToolTip="Click to wear Angel Wings"
                    if equipStatus and equipStatus.Parent then
                        equipStatus.Text="Angel Wings removed"
                        equipStatus.TextColor3=pcolor("sub",subColor)
                    end
                else
                    local ok,msg=makeAngelWingsWearable(source,tool)
                    if equipStatus and equipStatus.Parent then
                        equipStatus.Text=msg
                        equipStatus.TextColor3=ok and pcolor("hot",hotColor) or pcolor("sub",subColor)
                    end
                    if ok then
                        -- Put the wearable tool back into the hotbar after the click so
                        -- the wings stay worn without leaving an invisible tool in-hand.
                        task.delay(.06,function()
                            local hum=lp.Character and lp.Character:FindFirstChildOfClass("Humanoid")
                            if hum then pcall(function() hum:UnequipTools() end) end
                        end)
                    end
                end
            end)

            return tool
        end

        local function buildLocalEquippable(name)
            clearLocalEquippables()
            if name=="None" then extraState.EquipableItem="None"; return true,"Equippable removed" end
            local root=findFolder({"EquipableItem","EquippableItem","EquipableItems","EquippableItems"})
            local source=root and root:FindFirstChild(name)
            if not source then return false,"Equippable item was not found" end

            local isAngelWings=(source.Name:lower()=="angel wings" or source.Name:lower()=="angelwings")
            local tool

            if isAngelWings then
                -- Angel Wings behaves like a wearable: add the tool to Backpack,
                -- equip it from the Roblox hotbar, then click/tap once to wear it.
                tool=buildAngelWingsTool(source)
            elseif source:IsA("Tool") then
                tool=source:Clone()
            else
                tool=Instance.new("Tool"); tool.Name=source.Name; tool.RequiresHandle=false; tool.CanBeDropped=false
                local visual=source:Clone()
                if visual:IsA("Model") or visual:IsA("Folder") then
                    for _,ch in ipairs(visual:GetChildren()) do ch.Parent=tool end
                    visual:Destroy()
                else
                    visual.Parent=tool
                end
            end

            tool:SetAttribute("KimqLocalEquippable",true); tool.Name=source.Name

            if not isAngelWings then
                sanitizeClone(tool)
                local directHandle=tool:FindFirstChild("Handle")
                if not (directHandle and directHandle:IsA("BasePart")) then
                    local rootPart=firstPart(tool)
                    if rootPart then
                        local fake=Instance.new("Part"); fake.Name="Handle"; fake.Size=Vector3.new(.2,.2,.2); fake.Transparency=1; fake.CanCollide=false; fake.CanTouch=false; fake.CanQuery=false; fake.Massless=true; fake.CFrame=rootPart.CFrame; fake.Parent=tool
                        local w=Instance.new("WeldConstraint",fake); w.Part0=fake; w.Part1=rootPart
                        tool.RequiresHandle=true
                    else
                        tool.RequiresHandle=false
                    end
                else
                    tool.RequiresHandle=true
                end
            end

            local bp=lp:FindFirstChildOfClass("Backpack")
            if not bp then tool:Destroy(); return false,"Backpack was not ready" end
            tool.Parent=bp
            extraState.EquipableItem=name

            if isAngelWings then
                return true,"Angel Wings added — equip it from your inventory, then click to wear"
            end

            task.delay(.12,function()
                if not tool.Parent then return end
                local hum=lp.Character and lp.Character:FindFirstChildOfClass("Humanoid")
                if hum then pcall(function() hum:EquipTool(tool) end) end
                task.delay(.08,function()
                    if tool.Parent then pcall(function() playSkinAnimationsFromIds(source,tool) end) end
                end)
            end)
            return true,"Equipped locally: "..name
        end
        local function refreshEquipStyle() styleChoiceButtons(equipButtons,extraState.EquipableItem) end
        local function scanEquipables()
            for _,ch in ipairs(equipList:GetChildren()) do if ch:IsA("TextButton") then ch:Destroy() end end; table.clear(equipButtons)
            local root=findFolder({"EquipableItem","EquippableItem","EquipableItems","EquippableItems"}); local names={"None"}
            if root then for _,ch in ipairs(root:GetChildren()) do if ch.Name~="None" then table.insert(names,ch.Name) end end end
            table.sort(names,function(a,b) if a=="None" then return true elseif b=="None" then return false else return a:lower()<b:lower() end end)
            for i,name in ipairs(names) do
                local b=makeGridButton(equipList,name); b.LayoutOrder=i; equipButtons[name]=b
                b.MouseButton1Click:Connect(function()
                    extraState.EquipableItem=name; refreshEquipStyle(); equipStatus.Text="Selected: "..name; equipStatus.TextColor3=pcolor("hot",hotColor)
                    if name=="None" then local ok,msg=buildLocalEquippable("None"); equipStatus.Text=msg; equipStatus.TextColor3=ok and pcolor("hot",hotColor) or pcolor("sub",subColor) end
                end)
            end
            refreshEquipStyle()
        end
        removeEquip.MouseButton1Click:Connect(function()
            extraState.EquipableItem="None"; local ok,msg=buildLocalEquippable("None"); refreshEquipStyle(); equipStatus.Text=msg; equipStatus.TextColor3=ok and pcolor("hot",hotColor) or pcolor("sub",subColor)
        end)
        -- Double-click is unreliable on Roblox buttons, so selecting an item equips it
        -- immediately on the second click while it is already selected.
        local lastEquipClick=nil; local lastEquipTime=0
        equipList.DescendantAdded:Connect(function(ch)
            if not ch:IsA("TextButton") then return end
            ch.MouseButton1Click:Connect(function()
                local name=ch.Text
                if extraState.EquipableItem==name and lastEquipClick==name and os.clock()-lastEquipTime<1.1 and name~="None" then
                    local ok,msg=buildLocalEquippable(name); refreshEquipStyle(); equipStatus.Text=msg; equipStatus.TextColor3=ok and pcolor("hot",hotColor) or pcolor("sub",subColor)
                end
                lastEquipClick=name; lastEquipTime=os.clock()
            end)
        end)
        -- A clear explicit equip button is easier than needing the second click.
        local equipNow=Instance.new("TextButton",equipCard); equipNow.Size=UDim2.fromOffset(126,32); equipNow.Position=UDim2.new(1,-272,0,181); equipNow.BackgroundColor3=pcolor("hot",hotColor); equipNow.BorderSizePixel=0; equipNow.Text="equip selected"; equipNow.TextColor3=pcolor("white",Color3.new(1,1,1)); equipNow.Font=Enum.Font.GothamSemibold; equipNow.TextSize=11; corner(equipNow,9)
        equipNow.MouseButton1Click:Connect(function()
            local ok,msg=buildLocalEquippable(extraState.EquipableItem or "None"); refreshEquipStyle(); equipStatus.Text=msg; equipStatus.TextColor3=ok and pcolor("hot",hotColor) or pcolor("sub",subColor)
        end)

        -- Angel Wings root-fit calibration. These controls only change the torso -> Handle
        -- Motor6D; they never alter the six original wing Motor6Ds.
        local wingFitCard=card(skinsPage,320); wingFitCard.Name="KimqAngelWingsFitCard"
        txt(wingFitCard,"♥  Angel Wings Fit",UDim2.new(1,-24,0,24),UDim2.fromOffset(12,8),Enum.Font.GothamBold,14,pcolor("text",textColor))
        local wingFitSub=txt(wingFitCard,"Fine-tune where the complete wing rig sits on your back.",UDim2.new(1,-24,0,20),UDim2.fromOffset(12,31),Enum.Font.Gotham,11,pcolor("sub",subColor)); wingFitSub.TextWrapped=true

        local fitValueLabels={}
        local fitRows={
            {"Left / Right","X",.02,false},
            {"Up / Down","Y",.02,false},
            {"Back / Forward","Z",.02,false},
            {"Pitch","RX",2,true},
            {"Yaw","RY",2,true},
            {"Roll","RZ",2,true},
        }
        local function clampWingFit(k,v)
            if k=="X" or k=="Y" or k=="Z" then return math.clamp(v,-3,3) end
            return math.clamp(v,-180,180)
        end
        local function refreshWingFitLabels()
            for _,row in ipairs(fitRows) do
                local key=row[2]; local l=fitValueLabels[key]
                if l and l.Parent then
                    l.Text=row[4] and string.format("%.0f°",wingFit[key]) or string.format("%.2f",wingFit[key])
                end
            end
        end
        local function nudgeWingFit(key,amount)
            wingFit[key]=clampWingFit(key,(tonumber(wingFit[key]) or 0)+amount)
            refreshWingFitLabels()
            applyWingFitToCurrent()
        end
        local function fitButton(parent,textValue,pos)
            local b=Instance.new("TextButton",parent); b.Size=UDim2.fromOffset(30,24); b.Position=pos; b.BackgroundColor3=pcolor("soft",lightColor); b.BorderSizePixel=0; b.Text=textValue; b.TextColor3=pcolor("text",textColor); b.Font=Enum.Font.GothamBold; b.TextSize=14; corner(b,7); stroke(b,pcolor("line",lineColor),.28,1); return b
        end
        for i,row in ipairs(fitRows) do
            local y=58+(i-1)*32
            txt(wingFitCard,row[1],UDim2.new(.52,0,0,24),UDim2.fromOffset(12,y),Enum.Font.GothamSemibold,11,pcolor("text",textColor))
            local minus=fitButton(wingFitCard,"−",UDim2.new(1,-132,0,y))
            local value=txt(wingFitCard,"",UDim2.fromOffset(58,24),UDim2.new(1,-98,0,y),Enum.Font.GothamSemibold,11,pcolor("sub",subColor)); value.TextXAlignment=Enum.TextXAlignment.Center; fitValueLabels[row[2]]=value
            local plus=fitButton(wingFitCard,"+",UDim2.new(1,-38,0,y))
            minus.MouseButton1Click:Connect(function() nudgeWingFit(row[2],-row[3]) end)
            plus.MouseButton1Click:Connect(function() nudgeWingFit(row[2],row[3]) end)
        end
        refreshWingFitLabels()

        local saveFit=Instance.new("TextButton",wingFitCard); saveFit.Size=UDim2.new(.54,-14,0,32); saveFit.Position=UDim2.fromOffset(12,256); saveFit.BackgroundColor3=pcolor("hot",hotColor); saveFit.BorderSizePixel=0; saveFit.Text="♥  Save Wing Position"; saveFit.TextColor3=pcolor("white",Color3.new(1,1,1)); saveFit.Font=Enum.Font.GothamSemibold; saveFit.TextSize=11; corner(saveFit,9)
        local resetFit=Instance.new("TextButton",wingFitCard); resetFit.Size=UDim2.new(.46,-16,0,32); resetFit.Position=UDim2.new(.54,2,0,256); resetFit.BackgroundColor3=pcolor("soft",lightColor); resetFit.BorderSizePixel=0; resetFit.Text="Reset Fit"; resetFit.TextColor3=pcolor("text",textColor); resetFit.Font=Enum.Font.GothamSemibold; resetFit.TextSize=11; corner(resetFit,9); stroke(resetFit,pcolor("line",lineColor),.28,1)
        local fitStatus=txt(wingFitCard,"Saved fit is reused every time Angel Wings are worn.",UDim2.new(1,-24,0,20),UDim2.fromOffset(12,294),Enum.Font.Gotham,10,pcolor("sub",subColor)); fitStatus.TextWrapped=true
        saveFit.MouseButton1Click:Connect(function()
            local ok=saveWingFitDisk()
            fitStatus.Text=ok and "Wing position saved ♡" or "Position applied for this session (file saving unavailable)"
            fitStatus.TextColor3=ok and pcolor("hot",hotColor) or pcolor("sub",subColor)
            applyWingFitToCurrent()
        end)
        resetFit.MouseButton1Click:Connect(function()
            for k,v in pairs(wingFitDefault) do wingFit[k]=v end
            refreshWingFitLabels(); applyWingFitToCurrent()
            fitStatus.Text="Fit reset — adjust it, then save when it looks right"; fitStatus.TextColor3=pcolor("sub",subColor)
        end)

        local function hookKnifeContainer(container)
            if not container or container:GetAttribute("KimqKnifeContainerHook") then return end
            container:SetAttribute("KimqKnifeContainerHook",true)
            container.ChildAdded:Connect(function(ch)
                hookShotTool(ch)
                if ch:IsA("Tool") and ch.Name:lower():find("knife",1,true) and extraState.KnifeSkin and extraState.KnifeSkin~="None" and not ch:FindFirstChild("KimqKnifeSkinVisual") then
                    task.delay(.18,function()
                        if ch.Parent and not ch:FindFirstChild("KimqKnifeSkinVisual") then applyKnifeSkin(extraState.KnifeSkin,true) end
                    end)
                end
            end)
        end
        hookKnifeContainer(lp:FindFirstChildOfClass("Backpack")); if lp.Character then hookKnifeContainer(lp.Character) end
        lp.CharacterAdded:Connect(function(char)
            hookShotContainer(char); hookKnifeContainer(char)
            task.delay(1,function()
                local bp=lp:FindFirstChildOfClass("Backpack"); hookShotContainer(bp); hookKnifeContainer(bp)
                if extraState.KnifeSkin and extraState.KnifeSkin~="None" then applyKnifeSkin(extraState.KnifeSkin,true) end
                if extraState.EquipableItem and extraState.EquipableItem~="None" then buildLocalEquippable(extraState.EquipableItem) end
            end)
        end)

        local function scanAllExtras()
            scanBeams(); scanKnives(); scanEquipables()
            beamList.ScrollBarImageColor3=pcolor("hot",hotColor); knifeList.ScrollBarImageColor3=pcolor("hot",hotColor); equipList.ScrollBarImageColor3=pcolor("hot",hotColor)
        end
        skinsPage:GetPropertyChangedSignal("Visible"):Connect(function() if skinsPage.Visible then task.defer(scanAllExtras) end end)
        task.defer(function()
            -- Lists are populated when Weapon Skins is opened. Avoid three storage scans at startup.
            applyBulletBeamOverride(extraState.BulletBeam or "None")
        end)

        local function getExtraState()
            return {
                BulletBeam=tostring(extraState.BulletBeam or "None"),
                BulletColorMode=tostring(extraState.BulletColorMode or "Preset"),
                BulletColorHex=tostring(extraState.BulletColorHex or "#FF69B4"),
                BulletLightBrightness=tonumber(_G.KimqBulletLightBrightness) or tonumber(extraState.BulletLightBrightness) or 0.65,
                KnifeSkin=tostring(extraState.KnifeSkin or "None"),
                KnifeAccentMode=tostring(extraState.KnifeAccentMode or "Off"),
                EquipableItem=tostring(extraState.EquipableItem or "None"),
                WingFit={X=wingFit.X,Y=wingFit.Y,Z=wingFit.Z,RX=wingFit.RX,RY=wingFit.RY,RZ=wingFit.RZ},
            }
        end
        local function setExtraState(state)
            if type(state)~="table" then return end
            local oldKnife=tostring(extraState.KnifeSkin or "None")
            local oldKnifeAccent=tostring(extraState.KnifeAccentMode or "Off")
            local oldEquip=tostring(extraState.EquipableItem or "None")
            extraState.BulletBeam=type(state.BulletBeam)=="string" and state.BulletBeam or "None"
            extraState.BulletColorMode=type(state.BulletColorMode)=="string" and state.BulletColorMode or "Preset"
            if extraState.BulletColorMode~="Preset" and extraState.BulletColorMode~="Custom" and extraState.BulletColorMode~="Rainbow" then extraState.BulletColorMode="Preset" end
            local savedHex=type(state.BulletColorHex)=="string" and normalizeHex(state.BulletColorHex) or nil
            if savedHex then
                extraState.BulletColorHex=savedHex
                local c=colorFromHex(savedHex); if c then bulletCustomColor=c; bulletHue,bulletSat,bulletVal=c:ToHSV() end
            end
            local savedBrightness=tonumber(state.BulletLightBrightness)
            if savedBrightness then
                savedBrightness=math.clamp(savedBrightness,0,2.5)
                _G.KimqBulletLightBrightness=savedBrightness
                extraState.BulletLightBrightness=savedBrightness
                local setBrightness=rawget(_G,"KimqSetBulletLightBrightness")
                if type(setBrightness)=="function" then pcall(setBrightness,savedBrightness) end
            end
            extraState.KnifeSkin=type(state.KnifeSkin)=="string" and state.KnifeSkin or "None"
            extraState.KnifeAccentMode=type(state.KnifeAccentMode)=="string" and state.KnifeAccentMode or "Off"
            if extraState.KnifeAccentMode~="Off" and extraState.KnifeAccentMode~="Theme" and extraState.KnifeAccentMode~="Bullet" then extraState.KnifeAccentMode="Off" end
            extraState.EquipableItem=type(state.EquipableItem)=="string" and state.EquipableItem or "None"
            if type(state.WingFit)=="table" then
                for _,k in ipairs({"X","Y","Z","RX","RY","RZ"}) do
                    local n=tonumber(state.WingFit[k]); if n then wingFit[k]=n end
                end
                if refreshWingFitLabels then pcall(refreshWingFitLabels) end
            end
            task.defer(function()
                if skinsPage.Visible then scanAllExtras() end
                refreshBeamStyle(); refreshKnifeStyle(); refreshKnifeAccentStyle(); refreshEquipStyle(); refreshBulletColorUI()
                applyBulletBeamOverride(extraState.BulletBeam or "None")
                local t=findKnifeTool()
                local needsKnife=(extraState.KnifeSkin~=oldKnife)
                    or (extraState.KnifeSkin~="None" and t and not t:FindFirstChild("KimqKnifeSkinVisual"))
                    or (extraState.KnifeAccentMode~=oldKnifeAccent and extraState.KnifeSkin~="None" and t)
                if needsKnife then
                    if extraState.KnifeSkin~="None" then applyKnifeSkin(extraState.KnifeSkin,true) elseif t then clearKnifeVisual(t) end
                end
                if extraState.EquipableItem~=oldEquip then
                    if extraState.EquipableItem~="None" then buildLocalEquippable(extraState.EquipableItem) else clearLocalEquippables() end
                end
                pcall(function() applyWingFitToCurrent() end)
            end)
        end
        _G.KimqWeaponExtrasController={GetState=getExtraState,SetState=setExtraState,Refresh=scanAllExtras,RefreshColor=refreshBulletColorUI,ApplyKnife=applyKnifeSkin,EquipItem=buildLocalEquippable}
        if type(_G.KimqRegisterConfigControl)=="function" then
            _G.KimqRegisterConfigControl("Weapon Extras", "state", getExtraState, setExtraState)
        end
    end
    local extrasOk,extrasErr=pcall(setupWeaponExtras)
    if not extrasOk then
        _G.KimqWeaponExtrasInstalled=false
        warn("[Kimqetras HC v2.63] restored v2.19 Weapon Extras: "..tostring(extrasErr))
        setStatus("Weapon extras error • "..tostring(extrasErr):sub(1,100),false)
    else
        pcall(function()
            if type(getgenv)=="function" then
                local e=getgenv()
                e.KimqWeaponExtrasInstalled=true
                e.KimqWeaponExtrasController=_G.KimqWeaponExtrasController
                e.KimqWeaponExtrasState=_G.KimqWeaponExtrasState
            end
        end)
    end


    -- v2.67 Weapon Skin Presets --------------------------------------------
    -- Saves/restores the entire local cosmetic setup without guessing any
    -- game-specific skin names: weapon wraps + bullet/beam + knife + equippable.
    local function setupWeaponPresetManager()
        if skinsPage:FindFirstChild("KimqWeaponPresetCard") then return end

        local HttpService=game:GetService("HttpService")
        local PRESET_DIR="KimqetrasHC/weapon_presets"
        _G.KimqWeaponPresetMemory=_G.KimqWeaponPresetMemory or {}
        local mem=_G.KimqWeaponPresetMemory
        local selectedPreset=nil

        local function cleanPresetName(v)
            v=tostring(v or ""):gsub("^%s+",""):gsub("%s+$","")
            v=v:gsub("[^%w%s_%-%(%)%[%]]","")
            v=v:gsub("%s+"," ")
            if v=="" then v="Angel" end
            return v:sub(1,42)
        end

        local function ensurePresetDir()
            if type(isfolder)=="function" and type(makefolder)=="function" then
                pcall(function()
                    if not isfolder("KimqetrasHC") then makefolder("KimqetrasHC") end
                    if not isfolder(PRESET_DIR) then makefolder(PRESET_DIR) end
                end)
            end
        end

        local function presetPath(name)
            return PRESET_DIR.."/"..cleanPresetName(name)..".json"
        end

        local function capturePreset()
            local skinsCtl=_G.KimqWeaponSkinController
            local extrasCtl=_G.KimqWeaponExtrasController
            return {
                version=1,
                skins=(skinsCtl and skinsCtl.GetState and skinsCtl.GetState()) or {},
                extras=(extrasCtl and extrasCtl.GetState and extrasCtl.GetState()) or {},
            }
        end

        local function savePreset(name)
            name=cleanPresetName(name)
            local ok,json=pcall(HttpService.JSONEncode,HttpService,capturePreset())
            if not ok then return false,"Could not encode preset" end

            ensurePresetDir()
            local wrote=false
            if type(writefile)=="function" then
                wrote=pcall(writefile,presetPath(name),json)
            end
            if not wrote then mem[name]=json end
            return true,"Saved ♥ "..name
        end

        local function readPreset(name)
            name=cleanPresetName(name)
            local p=presetPath(name)
            if type(isfile)=="function" and type(readfile)=="function" then
                local ok,exists=pcall(isfile,p)
                if ok and exists then
                    local okRead,data=pcall(readfile,p)
                    if okRead and data then return data end
                end
            end
            return mem[name]
        end

        local function loadPreset(name)
            name=cleanPresetName(name)
            local raw=readPreset(name)
            if not raw then return false,"Preset not found" end
            local ok,data=pcall(HttpService.JSONDecode,HttpService,raw)
            if not ok or type(data)~="table" then return false,"Preset could not be read" end

            local skinsCtl=_G.KimqWeaponSkinController
            local extrasCtl=_G.KimqWeaponExtrasController
            if skinsCtl and skinsCtl.SetState then pcall(skinsCtl.SetState,data.skins or {}) end
            if extrasCtl and extrasCtl.SetState then pcall(extrasCtl.SetState,data.extras or {}) end
            return true,"Loaded ♥ "..name
        end

        local function deletePreset(name)
            name=cleanPresetName(name)
            local removed=false
            local p=presetPath(name)
            if type(isfile)=="function" and type(delfile)=="function" then
                local ok,exists=pcall(isfile,p)
                if ok and exists then removed=pcall(delfile,p) or removed end
            end
            if mem[name] then mem[name]=nil; removed=true end
            return removed
        end

        local function listPresets()
            local seen,out={},{}
            local function add(name)
                name=cleanPresetName(name)
                if name~="" and not seen[name] then seen[name]=true; table.insert(out,name) end
            end
            ensurePresetDir()
            if type(listfiles)=="function" then
                local ok,files=pcall(listfiles,PRESET_DIR)
                if ok and type(files)=="table" then
                    for _,p in ipairs(files) do
                        local n=tostring(p):match("([^/\\]+)%.json$")
                        if n then add(n) end
                    end
                end
            end
            for n in pairs(mem) do add(n) end
            table.sort(out,function(a,b) return a:lower()<b:lower() end)
            return out
        end

        local p=_G.KimqThemeLivePalette or {}
        local presetCard=card(skinsPage,244)
        presetCard.Name="KimqWeaponPresetCard"

        local title=txt(presetCard,"♥  weapon skin presets",UDim2.new(1,-24,0,24),UDim2.fromOffset(12,8),Enum.Font.FredokaOne,18,p.hot or hotColor)
        local sub=txt(presetCard,"Save a whole cosmetic combo: wraps + bullets + beam + knife + equippable.",UDim2.new(1,-24,0,20),UDim2.fromOffset(12,34),Enum.Font.Gotham,10,p.sub or subColor)

        local nameBox=Instance.new("TextBox",presetCard)
        nameBox.Name="KimqWeaponPresetName"
        nameBox.Size=UDim2.new(1,-24,0,32)
        nameBox.Position=UDim2.fromOffset(12,59)
        nameBox.BackgroundColor3=p.soft or lightColor
        nameBox.BorderSizePixel=0
        nameBox.PlaceholderText="preset name...  (ex: Angel)"
        nameBox.PlaceholderColor3=p.sub or subColor
        nameBox.Text=""
        nameBox.TextColor3=p.text or textColor
        nameBox.Font=Enum.Font.GothamSemibold
        nameBox.TextSize=11
        corner(nameBox,9)
        stroke(nameBox,p.line or lineColor,.30,1)

        local list=Instance.new("ScrollingFrame",presetCard)
        list.Name="KimqWeaponPresetList"
        list.Size=UDim2.new(1,-24,0,78)
        list.Position=UDim2.fromOffset(12,98)
        list.BackgroundTransparency=1
        list.BorderSizePixel=0
        list.ScrollBarThickness=3
        list.ScrollBarImageColor3=p.hot or hotColor
        local ll=Instance.new("UIListLayout",list)
        ll.Padding=UDim.new(0,5)
        ll.SortOrder=Enum.SortOrder.LayoutOrder
        ll:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            list.CanvasSize=UDim2.new(0,0,0,ll.AbsoluteContentSize.Y+6)
        end)

        local status=txt(presetCard,"pick or save a preset ♡",UDim2.new(1,-24,0,18),UDim2.fromOffset(12,216),Enum.Font.Gotham,9,p.sub or subColor)

        local saveBtn=Instance.new("TextButton",presetCard)
        saveBtn.Size=UDim2.new(.34,-10,0,30); saveBtn.Position=UDim2.fromOffset(12,181)
        local loadBtn=Instance.new("TextButton",presetCard)
        loadBtn.Size=UDim2.new(.33,-8,0,30); loadBtn.Position=UDim2.new(.34,4,0,181)
        local deleteBtn=Instance.new("TextButton",presetCard)
        deleteBtn.Size=UDim2.new(.33,-10,0,30); deleteBtn.Position=UDim2.new(.67,2,0,181)

        local presetButtons={}
        local function styleAction(b,text)
            local pp=_G.KimqThemeLivePalette or {}
            b.BackgroundColor3=pp.soft or lightColor
            b.BorderSizePixel=0
            b.Text=text
            b.TextColor3=pp.hot or hotColor
            b.Font=Enum.Font.GothamBold
            b.TextSize=10
            b.AutoButtonColor=false
            corner(b,9)
            stroke(b,pp.line or lineColor,.3,1)
        end
        styleAction(saveBtn,"♥ Save Current")
        styleAction(loadBtn,"Load")
        styleAction(deleteBtn,"Delete")

        local function refreshPresetTheme()
            local pp=_G.KimqThemeLivePalette or {}
            presetCard.BackgroundColor3=pp.panel or panelColor
            local st=presetCard:FindFirstChildOfClass("UIStroke"); if st then st.Color=pp.line or lineColor end
            title.TextColor3=pp.hot or hotColor
            sub.TextColor3=pp.sub or subColor
            nameBox.BackgroundColor3=pp.soft or lightColor
            nameBox.TextColor3=pp.text or textColor
            nameBox.PlaceholderColor3=pp.sub or subColor
            local nst=nameBox:FindFirstChildOfClass("UIStroke"); if nst then nst.Color=pp.line or lineColor end
            list.ScrollBarImageColor3=pp.hot or hotColor
            status.TextColor3=pp.sub or subColor
            for _,b in ipairs({saveBtn,loadBtn,deleteBtn}) do
                b.BackgroundColor3=pp.soft or lightColor
                b.TextColor3=pp.hot or hotColor
                local bst=b:FindFirstChildOfClass("UIStroke"); if bst then bst.Color=pp.line or lineColor end
            end
            for _,child in ipairs(list:GetChildren()) do
                if child:IsA("TextLabel") then child.TextColor3=pp.sub or subColor end
            end
            for name,b in pairs(presetButtons) do
                local on=name==selectedPreset
                b.BackgroundColor3=on and (pp.hot or hotColor) or (pp.soft or lightColor)
                b.TextColor3=on and (pp.white or Color3.new(1,1,1)) or (pp.text or textColor)
                local bst=b:FindFirstChildOfClass("UIStroke")
                if bst then bst.Color=on and (pp.hot or hotColor) or (pp.line or lineColor) end
            end
        end
        _G.KimqRefreshWeaponPresetTheme=refreshPresetTheme

        local refreshList
        refreshList=function()
            for _,ch in ipairs(list:GetChildren()) do
                if ch:IsA("TextButton") or ch:IsA("TextLabel") then ch:Destroy() end
            end
            table.clear(presetButtons)
            local names=listPresets()
            if #names==0 then
                local empty=txt(list,"no weapon presets yet ♡",UDim2.new(1,-4,0,28),UDim2.new(),Enum.Font.Gotham,9,(_G.KimqThemeLivePalette or {}).sub or subColor)
                empty.LayoutOrder=1
            else
                for i,name in ipairs(names) do
                    local b=Instance.new("TextButton",list)
                    b.LayoutOrder=i
                    b.Size=UDim2.new(1,-2,0,28)
                    b.BorderSizePixel=0
                    b.Text="♡  "..name
                    b.TextXAlignment=Enum.TextXAlignment.Left
                    b.Font=Enum.Font.GothamSemibold
                    b.TextSize=10
                    b.AutoButtonColor=false
                    corner(b,8)
                    stroke(b,(_G.KimqThemeLivePalette or {}).line or lineColor,.35,1)
                    local pad=Instance.new("UIPadding",b); pad.PaddingLeft=UDim.new(0,9)
                    b.MouseButton1Click:Connect(function()
                        selectedPreset=name
                        nameBox.Text=name
                        status.Text="selected ♥ "..name
                        refreshPresetTheme()
                    end)
                    presetButtons[name]=b
                end
            end
            refreshPresetTheme()
        end

        saveBtn.MouseButton1Click:Connect(function()
            local name=cleanPresetName(nameBox.Text)
            nameBox.Text=name
            local ok,msg=savePreset(name)
            status.Text=msg
            if ok then selectedPreset=name; refreshList() end
        end)
        loadBtn.MouseButton1Click:Connect(function()
            local name=selectedPreset or cleanPresetName(nameBox.Text)
            local ok,msg=loadPreset(name)
            status.Text=msg
            if ok then selectedPreset=name; nameBox.Text=name end
            refreshPresetTheme()
        end)
        deleteBtn.MouseButton1Click:Connect(function()
            local name=selectedPreset or cleanPresetName(nameBox.Text)
            if deletePreset(name) then
                status.Text="Deleted "..name
                if selectedPreset==name then selectedPreset=nil end
                refreshList()
            else
                status.Text="Preset not found"
            end
        end)

        refreshList()
    end
    local weaponPresetOK,weaponPresetERR=pcall(setupWeaponPresetManager)
    if not weaponPresetOK then warn("[Kimqetras HC v2.67 weapon presets] "..tostring(weaponPresetERR)) end

    local function installBulletBrightnessUI()
        local colorCard=skinsPage:FindFirstChild("KimqBulletColorCard")
        if not colorCard or colorCard:FindFirstChild("KimqBulletBrightnessUI") then return end

        local holder=Instance.new("Frame",colorCard)
        holder.Name="KimqBulletBrightnessUI"
        holder.Size=UDim2.new(1,-24,0,58)
        holder.Position=UDim2.fromOffset(12,264)
        holder.BackgroundTransparency=1
        colorCard.Size=UDim2.new(colorCard.Size.X.Scale,colorCard.Size.X.Offset,0,334)

        local p=_G.KimqThemeLivePalette or {}
        local label=Instance.new("TextLabel",holder)
        label.Size=UDim2.new(.72,0,0,22)
        label.BackgroundTransparency=1
        label.Text="Bullet Light Brightness"
        label.TextColor3=p.text or textColor
        label.Font=Enum.Font.GothamBold
        label.TextSize=11
        label.TextXAlignment=Enum.TextXAlignment.Left

        local value=Instance.new("TextLabel",holder)
        value.Size=UDim2.new(.28,-4,0,22)
        value.Position=UDim2.new(.72,4,0,0)
        value.BackgroundTransparency=1
        value.TextColor3=p.hot or hotColor
        value.Font=Enum.Font.GothamSemibold
        value.TextSize=11
        value.TextXAlignment=Enum.TextXAlignment.Right

        local bar=Instance.new("Frame",holder)
        bar.Name="BulletBrightnessBar"
        bar.Size=UDim2.new(1,0,0,10)
        bar.Position=UDim2.fromOffset(0,31)
        bar.BackgroundColor3=p.soft or lightColor
        bar.BorderSizePixel=0
        bar.Active=true
        corner(bar,999)
        stroke(bar,p.line or lineColor,.35,1)

        local fill=Instance.new("Frame",bar)
        fill.Name="BulletBrightnessFill"
        fill.Size=UDim2.new(0,0,1,0)
        fill.BackgroundColor3=p.hot or hotColor
        fill.BorderSizePixel=0
        corner(fill,999)

        local hit=Instance.new("TextButton",bar)
        hit.Size=UDim2.fromScale(1,1)
        hit.BackgroundTransparency=1
        hit.Text=""
        hit.ZIndex=5

        local function repaint()
            local pal=_G.KimqThemeLivePalette or {}
            label.TextColor3=pal.text or textColor
            value.TextColor3=pal.hot or hotColor
            bar.BackgroundColor3=pal.soft or lightColor
            fill.BackgroundColor3=pal.hot or hotColor
            local st=bar:FindFirstChildOfClass("UIStroke")
            if st then st.Color=pal.line or lineColor end
        end

        local function setGlow(v)
            v=math.clamp(tonumber(v) or 0.65,0,2.5)
            _G.KimqBulletLightBrightness=v
            if _G.KimqWeaponExtrasState then _G.KimqWeaponExtrasState.BulletLightBrightness=v end
            value.Text=tostring(math.floor(v*100+.5)).."%"
            fill.Size=UDim2.new(v/2.5,0,1,0)
            local refreshTemplates=rawget(_G,"KimqRefreshBulletTemplates")
            if type(refreshTemplates)=="function" then pcall(refreshTemplates) end
        end

        _G.KimqSetBulletLightBrightness=setGlow

        local dragging=false
        local UIS2=game:GetService("UserInputService")
        local function update(input)
            local x=math.clamp((input.Position.X-bar.AbsolutePosition.X)/math.max(bar.AbsoluteSize.X,1),0,1)
            setGlow(x*2.5)
        end
        hit.InputBegan:Connect(function(i)
            if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
                dragging=true; update(i)
            end
        end)
        UIS2.InputChanged:Connect(function(i)
            if dragging and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then update(i) end
        end)
        UIS2.InputEnded:Connect(function(i)
            if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then dragging=false end
        end)

        if type(_G.KimqRegisterConfigControl)=="function" then
            _G.KimqRegisterConfigControl("Bullet Light Brightness","decimal",
                function() return tonumber(_G.KimqBulletLightBrightness) or 0.65 end,
                function(v) setGlow(v) end)
        end

        setGlow(_G.KimqBulletLightBrightness)
        repaint()
        local badgeNow=badge
        if badgeNow then
            badgeNow:GetPropertyChangedSignal("BackgroundColor3"):Connect(function() task.defer(repaint) end)
        end
    end
    pcall(installBulletBrightnessUI)

    -- ========================================================
    -- v2.62 ISOLATED ANGEL WINGS FLIGHT
    -- This is intentionally outside setupWeaponExtras().
    -- If flight/animation ever errors, Knives / Equippables / Bullet Beams
    -- have already been created by the restored v2.19 core.
    -- ========================================================
    task.spawn(function()
        local UIS2=game:GetService("UserInputService")
        local RunService2=game:GetService("RunService")
        local CoreGui2=game:GetService("CoreGui")
        local playerGui2=lp:FindFirstChildOfClass("PlayerGui")

        local flightEnabled=true
        local flightActive=false
        local flightSpeed=46
        local lastSpace=0
        local bv,bg,flightConn=nil,nil,nil
        local animTrack=nil
        local mini=nil

        local function livePalette()
            local p=_G.KimqThemeLivePalette
            if type(p)=="table" then return p end
            return {
                bg=panelColor,soft=lightColor,hot=hotColor,text=textColor,
                sub=subColor,line=lineColor,white=Color3.new(1,1,1)
            }
        end

        local function wingsModel()
            local char=lp.Character
            return char and char:FindFirstChild("KimqWornAngelWings")
        end

        local function stopAnim()
            if animTrack then pcall(function() animTrack:Stop(.12) end) end
            animTrack=nil
        end

        local function playFlightAnim()
            stopAnim()
            local char=lp.Character
            local hum=char and char:FindFirstChildOfClass("Humanoid")
            if not hum then return end

            pcall(function()
                local ok,track=pcall(function()
                    return hum:PlayEmoteAndGetAnimTrackById(100607985396998)
                end)
                if ok and track then
                    animTrack=track
                    pcall(function() track.Looped=true; track:Play(.12,1,1) end)
                end
            end)
            if animTrack then return end

            local resolved="rbxassetid://100607985396998"
            pcall(function()
                local objs=game:GetObjects("rbxassetid://100607985396998")
                for _,obj in ipairs(objs) do
                    local a=obj:IsA("Animation") and obj or obj:FindFirstChildWhichIsA("Animation",true)
                    if a and tostring(a.AnimationId or "")~="" then
                        resolved=a.AnimationId
                        break
                    end
                end
                for _,obj in ipairs(objs) do pcall(function() obj:Destroy() end) end
            end)

            local animator=hum:FindFirstChildOfClass("Animator")
            if not animator then
                animator=Instance.new("Animator")
                animator.Parent=hum
            end
            local a=Instance.new("Animation")
            a.AnimationId=resolved
            local ok,track=pcall(function() return animator:LoadAnimation(a) end)
            a:Destroy()
            if ok and track then
                animTrack=track
                pcall(function()
                    track.Looped=true
                    track.Priority=Enum.AnimationPriority.Action
                    track:Play(.12,1,1)
                end)
            end
        end

        local function cleanupFlight()
            flightActive=false
            if flightConn then pcall(function() flightConn:Disconnect() end) end
            flightConn=nil
            if bv then pcall(function() bv:Destroy() end) end
            if bg then pcall(function() bg:Destroy() end) end
            bv=nil; bg=nil
            stopAnim()
            local char=lp.Character
            local hum=char and char:FindFirstChildOfClass("Humanoid")
            if hum then pcall(function() hum.AutoRotate=true end) end
        end

        local function updateMini()
            if not mini or not mini.Parent then return end
            local p=livePalette()
            local frame=mini:FindFirstChild("Frame")
            if not frame then return end
            frame.BackgroundColor3=p.panel
            local st=frame:FindFirstChildOfClass("UIStroke"); if st then st.Color=p.line end
            local title=frame:FindFirstChild("Title")
            local status=frame:FindFirstChild("Status")
            local value=frame:FindFirstChild("SpeedValue")
            local fill=frame:FindFirstChild("Track") and frame.Track:FindFirstChild("Fill")
            if title then title.TextColor3=p.hot end
            if status then
                status.Text=flightActive and "flying ♡ • double jump to stop" or "double jump to fly ♡"
                status.TextColor3=flightActive and p.hot or p.sub
            end
            if value then value.Text="Speed: "..tostring(math.floor(flightSpeed+.5)); value.TextColor3=p.text end
            if fill then fill.BackgroundColor3=p.hot; fill.Size=UDim2.new(math.clamp((flightSpeed-16)/124,0,1),0,1,0) end
        end

        local function makeMini()
            if mini and mini.Parent then updateMini(); return end
            local gui=Instance.new("ScreenGui")
            gui.Name="KimqAngelWingsMini"
            gui.ResetOnSpawn=false
            gui.IgnoreGuiInset=true
            local parented=pcall(function() gui.Parent=CoreGui2 end)
            if not parented then gui.Parent=playerGui2 end
            mini=gui

            local p=livePalette()
            local f=Instance.new("Frame",gui)
            f.Name="Frame"
            f.Size=UDim2.fromOffset(246,122)
            f.Position=UDim2.new(1,-262,.5,-61)
            f.BackgroundColor3=p.panel
            f.BorderSizePixel=0
            local c=Instance.new("UICorner",f); c.CornerRadius=UDim.new(0,16)
            local s=Instance.new("UIStroke",f); s.Color=p.line; s.Transparency=.22; s.Thickness=1

            local accent=Instance.new("Frame",f)
            accent.Name="Accent"; accent.Size=UDim2.fromOffset(7,24); accent.Position=UDim2.fromOffset(10,10)
            accent.BackgroundColor3=p.hot; accent.BorderSizePixel=0
            local ac=Instance.new("UICorner",accent); ac.CornerRadius=UDim.new(1,0)

            local title=Instance.new("TextLabel",f)
            title.Name="Title"; title.Size=UDim2.new(1,-36,0,26); title.Position=UDim2.fromOffset(24,8)
            title.BackgroundTransparency=1; title.Text="♥  Angel Wings"; title.TextColor3=p.hot
            title.Font=Enum.Font.FredokaOne; title.TextSize=13; title.TextXAlignment=Enum.TextXAlignment.Left

            local value=Instance.new("TextLabel",f)
            value.Name="SpeedValue"; value.Size=UDim2.new(1,-24,0,20); value.Position=UDim2.fromOffset(12,37)
            value.BackgroundTransparency=1; value.TextColor3=p.text; value.Font=Enum.Font.Gotham
            value.TextSize=11; value.TextXAlignment=Enum.TextXAlignment.Left

            local track=Instance.new("Frame",f)
            track.Name="Track"; track.Size=UDim2.new(1,-24,0,10); track.Position=UDim2.fromOffset(12,66)
            track.BackgroundColor3=p.soft; track.BorderSizePixel=0; track.Active=true
            local ts=Instance.new("UIStroke",track); ts.Color=p.line; ts.Transparency=.45; ts.Thickness=1
            local tc=Instance.new("UICorner",track); tc.CornerRadius=UDim.new(1,0)
            local fill=Instance.new("Frame",track); fill.Name="Fill"; fill.Size=UDim2.new(.24,0,1,0)
            fill.BackgroundColor3=p.hot; fill.BorderSizePixel=0
            local fc=Instance.new("UICorner",fill); fc.CornerRadius=UDim.new(1,0)
            local hit=Instance.new("TextButton",track); hit.Size=UDim2.fromScale(1,1); hit.BackgroundTransparency=1; hit.Text=""

            local status=Instance.new("TextLabel",f)
            status.Name="Status"; status.Size=UDim2.new(1,-24,0,25); status.Position=UDim2.fromOffset(12,86)
            status.BackgroundTransparency=1; status.Font=Enum.Font.Gotham; status.TextSize=10
            status.TextXAlignment=Enum.TextXAlignment.Left

            local dragging=false
            local function setFromX(x)
                local alpha=math.clamp((x-track.AbsolutePosition.X)/math.max(track.AbsoluteSize.X,1),0,1)
                flightSpeed=16+alpha*124
                updateMini()
            end
            hit.InputBegan:Connect(function(i)
                if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
                    dragging=true; setFromX(i.Position.X)
                end
            end)
            UIS2.InputChanged:Connect(function(i)
                if dragging and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then
                    setFromX(i.Position.X)
                end
            end)
            UIS2.InputEnded:Connect(function(i)
                if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then dragging=false end
            end)
            updateMini()
        end

        local function startFlight()
            if not flightEnabled or not wingsModel() or flightActive then return end
            local char=lp.Character
            local root=char and char:FindFirstChild("HumanoidRootPart")
            local hum=char and char:FindFirstChildOfClass("Humanoid")
            if not root or not hum then return end

            flightActive=true
            hum.AutoRotate=false

            bv=Instance.new("BodyVelocity")
            bv.Name="KimqWingFlightVelocity"
            bv.MaxForce=Vector3.new(1e6,1e6,1e6)
            bv.P=15000
            bv.Velocity=Vector3.zero
            bv.Parent=root

            bg=Instance.new("BodyGyro")
            bg.Name="KimqWingFlightGyro"
            bg.MaxTorque=Vector3.new(1e6,1e6,1e6)
            bg.P=18000
            bg.D=650
            bg.CFrame=root.CFrame
            bg.Parent=root

            playFlightAnim()

            flightConn=RunService2.RenderStepped:Connect(function()
                if not wingsModel() or not root.Parent or not hum.Parent then
                    cleanupFlight(); updateMini(); return
                end
                local cam=workspace.CurrentCamera
                local move=hum.MoveDirection
                local vertical=0
                if UIS2:IsKeyDown(Enum.KeyCode.Space) then vertical+=1 end
                if UIS2:IsKeyDown(Enum.KeyCode.LeftControl) or UIS2:IsKeyDown(Enum.KeyCode.C) then vertical-=1 end

                local planar=move
                if planar.Magnitude>1 then planar=planar.Unit end
                bv.Velocity=planar*flightSpeed + Vector3.new(0,vertical*flightSpeed*.65,0)

                if cam then
                    local look=cam.CFrame.LookVector
                    local flat=Vector3.new(look.X,0,look.Z)
                    if flat.Magnitude>.01 then
                        bg.CFrame=CFrame.lookAt(root.Position,root.Position+flat.Unit)
                    end
                end
            end)
            updateMini()
        end

        local function toggleFlight()
            if flightActive then cleanupFlight() else startFlight() end
            updateMini()
        end

        UIS2.InputBegan:Connect(function(input,gpe)
            if gpe or input.KeyCode~=Enum.KeyCode.Space or not wingsModel() then return end
            local now=os.clock()
            if now-lastSpace<=.42 then
                lastSpace=0
                toggleFlight()
            else
                lastSpace=now
            end
        end)

        local function watchCharacter(char)
            cleanupFlight()
            if mini then pcall(function() mini:Destroy() end); mini=nil end

            local function check()
                if char~=lp.Character then return end
                if char:FindFirstChild("KimqWornAngelWings") then
                    makeMini()
                else
                    cleanupFlight()
                    if mini then pcall(function() mini:Destroy() end); mini=nil end
                end
            end

            char.ChildAdded:Connect(function(ch)
                if ch.Name=="KimqWornAngelWings" then task.defer(check) end
            end)
            char.ChildRemoved:Connect(function(ch)
                if ch.Name=="KimqWornAngelWings" then task.defer(check) end
            end)
            task.defer(check)
        end

        if lp.Character then watchCharacter(lp.Character) end
        lp.CharacterAdded:Connect(watchCharacter)

        _G.KimqRefreshWingMiniTheme=updateMini
    end)

    -- Canonical navigation owns page switching. Weapon discovery stays lazy and
    -- only runs when the user actually opens Weapon Skins.
    skinsBtn.MouseButton1Click:Connect(function()
        task.defer(function()
            scanWeapons()
            local extras=_G.KimqWeaponExtrasController
            if extras and type(extras.Refresh)=="function" then
                local ok,err=pcall(extras.Refresh)
                if not ok then
                    warn("[Kimqetras HC v2.63] extras refresh: "..tostring(err))
                    setStatus("Extras refresh failed • "..tostring(err):sub(1,90),false)
                end
            end
        end)
    end)

    local function syncTheme()
        panelColor,lineColor,hotColor,lightColor,textColor,subColor=sampleTheme()
        skinsPage.ScrollBarImageColor3=hotColor
        weaponList.ScrollBarImageColor3=hotColor
        skinList.ScrollBarImageColor3=hotColor
        wiTitle.TextColor3=hotColor
        wiSub.TextColor3=subColor
        for _,f in ipairs({wi,weaponCard,skinCard,actions,statusCard}) do
            f.BackgroundColor3=panelColor
            local s=f:FindFirstChildOfClass("UIStroke")
            if s then s.Color=lineColor end
        end
        refresh.BackgroundColor3=lightColor
        refresh.TextColor3=textColor
        apply.BackgroundColor3=hotColor
        reset.BackgroundColor3=lightColor
        reset.TextColor3=textColor
        refreshWeaponStyle()
        refreshSkinStyle()
        if _G.KimqWeaponExtrasController and _G.KimqWeaponExtrasController.RefreshColor then
            _G.KimqWeaponExtrasController.RefreshColor()
        end
    end
    if badge then badge:GetPropertyChangedSignal("BackgroundColor3"):Connect(function() task.defer(syncTheme) end) end
    syncTheme()

    -- Do not recursively scan the game at startup. Weapon folders are scanned when the page is opened or Refresh is pressed.
    setStatus("Open Weapon Skins to scan your Wraps folder", true)

    setProgress("ready ♡",1)
    _G.KimqV26FeaturesReady=true
end)




-- v2.1 final GUI: matcha + light pink + white, hearts only, no stitching.
task.spawn(function()
    local Players=game:GetService("Players")
    local CoreGui=game:GetService("CoreGui")
    local TweenService=game:GetService("TweenService")
    local lp=Players.LocalPlayer
    local pg=lp:WaitForChild("PlayerGui")

    local t0=tick()
    while (not _G.KimqV26FeaturesReady or not _G.KimqPageRepairReady) and tick()-t0<12 do
        task.wait(.03)
    end
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
        _G.KimqV26Ready=true; main.Visible=(_G.KimqMainUserVisibleState~=false)
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
    if not shell then _G.KimqV26Ready=true; main.Visible=(_G.KimqMainUserVisibleState~=false); if loader and loader.Gui then loader.Gui:Destroy() end; return end

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
        -- Never use the startup Matcha palette after a theme has been selected.
        -- This legacy nav callback used to be the piece that repainted the sidebar
        -- back to Matcha/Pink whenever a different section was opened.
        local live=_G.KimqThemeLivePalette
        local hot=(live and live.hot) or P.hot
        local panel=(live and live.panel) or P.panel
        local text=(live and live.text) or P.text
        local white=(live and live.white) or P.white
        local line=(live and live.line) or P.line
        for _,b in ipairs(navButtons) do
            local selected=(colorDistance(b.BackgroundColor3,hot)<.28) or (b.TextColor3.R>.83 and b.TextColor3.G>.83 and b.TextColor3.B>.83)
            b.BackgroundColor3=selected and hot or panel
            b.TextColor3=selected and white or text
            b.Font=Enum.Font.FredokaOne; b.TextSize=13; b.TextXAlignment=Enum.TextXAlignment.Left; b.AutoButtonColor=false; corner(b,11); stroke(b,selected and hot or line,selected and .05 or .45,1)
            local pad=b:FindFirstChildOfClass("UIPadding") or Instance.new("UIPadding",b); pad.PaddingLeft=UDim.new(0,28); pad.PaddingRight=UDim.new(0,8)
        end
    end
    styleNav()
    for _,b in ipairs(navButtons) do
        b.MouseButton1Click:Connect(function() task.defer(styleNav) end)
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
        local av=Instance.new("ImageLabel",welcome); av.Size=UDim2.fromOffset(78,78); av.Position=UDim2.fromOffset(18,38); av.BackgroundColor3=P.light; av.BorderSizePixel=0; corner(av,999); stroke(av,P.line,.35,1); role(av,"lightBg"); task.spawn(function()
            local ok,img=pcall(function() return Players:GetUserThumbnailAsync(lp.UserId,Enum.ThumbnailType.HeadShot,Enum.ThumbnailSize.Size180x180) end)
            if ok and av and av.Parent then av.Image=img end
        end)
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
        local cd=label(controls,"F1 = hide / show  •  drag ↘ to resize",UDim2.new(1,-80,0,24),UDim2.fromOffset(18,43),Enum.Font.GothamSemibold,12,P.text); role(cd,"textText")
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
    -- One startup sync only. The performance theme engine below owns all later recolors.
    sync()

    _G.KimqV26Ready=true
    forceBadge()
end)


-- ========================================================
-- ========================================================
-- v2.1 AUTHORITATIVE THEME ENGINE
-- This replaces the previous exact-color registry.  Every visible GUI object is
-- classified once by what it is (heading, body text, card, action, toggle, etc.)
-- and every theme applies those semantic roles.  Theme preview swatches and
-- true color-picker visuals are intentionally left alone.
-- One full cached repaint per theme click; no frame loops and no delayed repaint stacks.
-- ========================================================
task.spawn(function()
    local Players = game:GetService("Players")
    local CoreGui = game:GetService("CoreGui")
    local UIS = game:GetService("UserInputService")
    local lp = Players.LocalPlayer
    local pg = lp:WaitForChild("PlayerGui")

    local t0 = tick()
    while not _G.KimqV26Ready and tick() - t0 < 20 do task.wait(.08) end

    local root = CoreGui:FindFirstChild("KimpetrasHC") or pg:FindFirstChild("KimpetrasHC")
    local main = root and root:FindFirstChild("Main")
    if not main then return end
    local shell = main:FindFirstChild("CuteBlueShell") or main:FindFirstChildWhichIsA("Frame")
    if not shell then return end

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
    local order={"Matcha Pink","Lavender Blue","Baby Blue","Sky Lilac","Lilac Pink","Rose Cream","Peach Cream","Butter Pink","Mint Aqua","Grey Pink","Black Pink","Purple","Red","Pink","Aqua","Green"}
    local labels={
        ["Matcha Pink"]="Matcha + Pink",["Lavender Blue"]="Lavender + Blue",["Baby Blue"]="Baby Blue",["Sky Lilac"]="Sky + Lilac",["Lilac Pink"]="Lilac + Pink",["Rose Cream"]="Rose + Cream",["Peach Cream"]="Peach + Cream",["Butter Pink"]="Butter + Pink",["Mint Aqua"]="Mint + Aqua",["Grey Pink"]="Grey + Pink",["Black Pink"]="Black + Light Pink",Purple="Purple Theme",Red="Red Theme",Pink="Pink Theme",Aqua="Aqua Theme",Green="Green Theme"
    }

    local currentName = _G.KimqCuteTheme or "Matcha Pink"
    if not THEMES[currentName] then currentName = "Matcha Pink" end
    _G.KimqCuteTheme = currentName

    local function clean(s)
        s=tostring(s or ""):lower():gsub("[♥♡❤]",""):gsub("%s+"," ")
        return (s:gsub("^%s+",""):gsub("%s+$",""))
    end
    local function corner(o,r)
        local c=o:FindFirstChildOfClass("UICorner") or Instance.new("UICorner",o)
        c.CornerRadius=UDim.new(0,r or 10)
        return c
    end
    local function outline(o,c,tr,th)
        local st=o:FindFirstChildOfClass("UIStroke") or Instance.new("UIStroke",o)
        st.Color=c; st.Transparency=tr or .42; st.Thickness=th or 1
        return st
    end
    local function colorDistance(a,b)
        local dr=a.R-b.R; local dg=a.G-b.G; local db=a.B-b.B
        return math.sqrt(dr*dr+dg*dg+db*db)
    end
    local function brightness(c) return (c.R+c.G+c.B)/3 end
    local function saturation(c)
        local mx=math.max(c.R,c.G,c.B); local mn=math.min(c.R,c.G,c.B)
        return mx-mn
    end
    local function whiteish(c) return c.R>.90 and c.G>.90 and c.B>.90 end

    local function hasPreviewAncestor(o)
        local x=o
        while x and x~=main do
            if x:GetAttribute("KimqThemePreview") then return true end
            x=x.Parent
        end
        return false
    end
    local function isTrueColorVisual(o)
        local n=tostring(o.Name):lower()
        return n:find("fogsquare",1,true) or n:find("fogpreview",1,true) or n:find("foghue",1,true)
            or n:find("rainbow",1,true) or n:find("espcolor",1,true) or n:find("colorwheel",1,true)
    end

    local pageNames={overview=true,["silent aim"]=true,macro=true,whitelist=true,protection=true,["anti fall"]=true,["delay changer"]=true,esp=true,avatar=true,["fog / atmosphere"]=true,environment=true,["weapon skins"]=true,["hc silent aim"]=true,["force hit"]=true,["hitbox expander"]=true,flamelock=true,camlock=true,headless=true,["anti mod"]=true,["spawn point"]=true,["rage camlock"]=true,["target orbit"]=true,["rage combat"]=true,settings=true,theme=true,information=true}
    local function findNav()
        local best,bestScore=nil,0
        for _,d in ipairs(main:GetDescendants()) do
            if d:IsA("ScrollingFrame") then
                local score=0
                for _,b in ipairs(d:GetChildren()) do
                    if b:IsA("TextButton") and pageNames[clean(b.Text)] then score+=1 end
                end
                if score>bestScore then best,bestScore=d,score end
            end
        end
        return best
    end
    local nav=findNav()
    local themePage=shell:FindFirstChild("themePage",true)

    -- v2.62: preserve the grouped sidebar order from pageDefs.
    -- Do NOT alphabetize/rewrite LayoutOrder after HOME / COMBAT / VISUALS /
    -- PLAYER / SETUP labels have been created.
    if nav then
        local layout=nav:FindFirstChildOfClass("UIListLayout")
        if layout then layout.SortOrder=Enum.SortOrder.LayoutOrder end
        nav.CanvasPosition=Vector2.zero
    end

    local BASE=THEMES["Matcha Pink"]
    local function nearestBaseRole(c)
        local choices={{BASE.bg,"bg"},{BASE.bg2,"bg2"},{BASE.panel,"panel"},{BASE.soft,"soft"},{BASE.hot,"hot"},{BASE.hot2,"hot2"}}
        local bestRole,best= nil,math.huge
        for _,v in ipairs(choices) do
            local d=colorDistance(c,v[1]); if d<best then best,bestRole=d,v[2] end
        end
        if best<.24 then return bestRole end
        return nil
    end

    local function isToggleButton(o)
        if not o:IsA("TextButton") or o.Text~="" then return false end
        if o.AbsoluteSize.X<28 or o.AbsoluteSize.X>70 or o.AbsoluteSize.Y<14 or o.AbsoluteSize.Y>34 then return false end
        for _,c in ipairs(o:GetChildren()) do
            if c:IsA("Frame") and c.AbsoluteSize.X<=24 and c.AbsoluteSize.Y<=24 then return true,c end
        end
        return false,nil
    end

    -- Semantic entries are cached once.  This is deliberately broader than exact RGB
    -- matching so the old pink/green/blue leftovers all get absorbed into the theme.
    local entries={}
    local seen={}
    local function addEntry(o,data)
        if not o or seen[o] or hasPreviewAncestor(o) then return end
        seen[o]=true; data.o=o; table.insert(entries,data)
    end

    local roleMap={cream="bg",cream2="bg2",panel="panel",lightBg="soft",hotBg="hot",whiteBg="panel",hotText="hotText",subText="subText",textText="textText",lineText="lineText",whiteText="whiteText",limeText="textText"}

    local function classify(o)
        if not o or hasPreviewAncestor(o) then return end
        if o:IsA("UIStroke") then
            addEntry(o,{stroke=true}); return
        end
        if o:IsA("UIGradient") then
            if o.Name=="V26BannerGradient" then
                addEntry(o,{gradient=true})
            elseif o.Name=="KimqProfileAvatarGradient" then
                addEntry(o,{profileGradient=true})
            end
            return
        end
        if not (o:IsA("GuiObject") or o:IsA("UIBase")) then return end

        local data={}
        if o:IsA("ScrollingFrame") then data.scroll=true end
        if o:IsA("GuiObject") then o.BorderSizePixel=0 end

        local attr=o:GetAttribute("KimqV26Role")
        if attr and roleMap[attr] then
            local r=roleMap[attr]
            if r=="bg" or r=="bg2" or r=="panel" or r=="soft" or r=="hot" then data.bgRole=r else data.textRole=r end
        end

        if o==main then data.bgRole="bg" end
        if nav and (o==nav or o==nav.Parent) then data.bgRole="bg2" end

        if o:IsA("ScrollingFrame") and o~=nav and o.BackgroundTransparency<.98 then
            local low=tostring(o.Name):lower()
            if low:match("page$") then data.bgRole="bg" end
        end

        if o:IsA("TextButton") then
            local toggle,circle=isToggleButton(o)
            if toggle then data.toggle=true; data.toggleCircle=circle end
        end

        if o:IsA("GuiObject") and o.BackgroundTransparency<.98 and not isTrueColorVisual(o) and not data.toggle then
            if not data.bgRole then
                local r=nearestBaseRole(o.BackgroundColor3)
                if r then data.bgRole=r else
                    local br=brightness(o.BackgroundColor3); local sat=saturation(o.BackgroundColor3)
                    if whiteish(o.BackgroundColor3) then data.bgRole="panel"
                    elseif br>.89 then data.bgRole=(sat>.08 and "soft" or "panel")
                    elseif sat>.18 then data.bgRole="hot"
                    else data.bgRole="soft" end
                end
            end
        end

        if o:IsA("TextLabel") or o:IsA("TextButton") or o:IsA("TextBox") then
            local txt=tostring(o.Text or "")
            local low=clean(txt)
            local c=o.TextColor3
            local sat=saturation(c); local br=brightness(c)
            if not data.textRole then
                if whiteish(c) then data.textRole="whiteText"
                elseif low:match("^v2%.") or low:find("kimqetras hc",1,true) or o.Font==Enum.Font.FredokaOne or o.TextSize>=17 then data.textRole="hotText"
                elseif sat>.17 then data.textRole="hotText"
                elseif br>.57 then data.textRole="subText"
                else data.textRole="textText" end
            end
            if o:IsA("TextBox") then data.placeholderRole="subText" end
        end

        if o:IsA("ImageLabel") or o:IsA("ImageButton") then
            local n=tostring(o.Name):lower()
            if not n:find("avatar",1,true) and not n:find("profile",1,true) and not isTrueColorVisual(o) then
                if not whiteish(o.ImageColor3) and saturation(o.ImageColor3)>.10 then data.imageRole="hot" end
            end
        end

        if next(data) then addEntry(o,data) end
    end

    for _,d in ipairs(main:GetDescendants()) do classify(d) end
    classify(main)

    -- v2.3: recognize colors from ANY theme (plus older hard-coded GUI colors),
    -- not only the original Matcha palette. This lets a full repaint absorb buttons
    -- that a callback may have put back to an older pink/purple/green value.
    local legacyRoleColors={
        {Color3.fromRGB(255,190,220),"hot"},
        {Color3.fromRGB(230,40,135),"hot"},
        {Color3.fromRGB(225,55,135),"hot"},
        {Color3.fromRGB(220,45,125),"hot"},
        {Color3.fromRGB(255,245,250),"soft"},
        {Color3.fromRGB(246,255,250),"soft"},
        {Color3.fromRGB(236,255,243),"bg2"},
        {Color3.fromRGB(217,255,232),"bg"},
        {Color3.fromRGB(255,255,255),"panel"},
    }
    local function nearestAnyThemeRole(c)
        local bestRole,best=nil,math.huge
        for _,p in pairs(THEMES) do
            for _,rv in ipairs({
                {"bg",p.bg},{"bg2",p.bg2},{"panel",p.panel},{"soft",p.soft},
                {"hot",p.hot},{"hot2",p.hot2}
            }) do
                local dist=colorDistance(c,rv[2])
                if dist<best then best,bestRole=dist,rv[1] end
            end
        end
        for _,rv in ipairs(legacyRoleColors) do
            local dist=colorDistance(c,rv[1])
            if dist<best then best,bestRole=dist,rv[2] end
        end
        if best<.30 then return bestRole end

        local br=brightness(c); local sat=saturation(c)
        if whiteish(c) then return "panel" end
        if br>.90 then return sat>.07 and "soft" or "panel" end
        if sat>.16 then return "hot" end
        return "soft"
    end

    local function activePageName()
        local map={antifall="anti fall",antimod="anti mod",delay="delay changer",fog="fog / atmosphere",forcehit="hc silent aim",hcsilent="hc silent aim",hitbox="hitbox expander",info="information",weaponskins="weapon skins",silent="silent aim"}
        for _,d in ipairs(main:GetDescendants()) do
            if d:IsA("ScrollingFrame") and d.Visible and d~=nav and d.Name:lower():match("page$") then
                local n=d.Name:lower():gsub("page$","")
                return map[n] or n
            end
        end
        return "overview"
    end

    local function applyBackground(o,role,p)
        if role=="bg" then o.BackgroundColor3=p.bg
        elseif role=="bg2" then o.BackgroundColor3=p.bg2
        elseif role=="panel" then o.BackgroundColor3=p.panel
        elseif role=="soft" then o.BackgroundColor3=p.soft
        elseif role=="hot" then o.BackgroundColor3=p.hot
        elseif role=="hot2" then o.BackgroundColor3=p.hot2 end
    end
    local function applyText(o,role,p)
        if role=="hotText" then o.TextColor3=p.hot
        elseif role=="subText" then o.TextColor3=p.sub
        elseif role=="whiteText" then o.TextColor3=p.white
        elseif role=="lineText" then o.TextColor3=p.hot2
        else o.TextColor3=p.text end
    end

    local function styleNav(p)
        if not nav then return end
        nav.BackgroundColor3=p.bg2; nav.ScrollBarImageColor3=p.hot
        if nav.Parent and nav.Parent:IsA("GuiObject") then
            nav.Parent.BackgroundColor3=p.bg2
            local st=nav.Parent:FindFirstChildOfClass("UIStroke"); if st then st.Color=p.line end
        end
        local active=activePageName()
        for _,b in ipairs(nav:GetChildren()) do
            if b:IsA("TextButton") and pageNames[clean(b.Text)] then
                local selected=clean(b.Text)==active
                b:SetAttribute("KimqSelected",selected)
                b.BackgroundColor3=selected and p.hot or p.panel
                b.TextColor3=selected and p.white or p.text
                local st=b:FindFirstChildOfClass("UIStroke")
                if st then st.Color=selected and p.hot or p.line; st.Transparency=selected and .05 or .58 end
                for _,c in ipairs(b:GetChildren()) do
                    if c:IsA("TextLabel") and (c.Text=="♡" or c.Text=="♥") then c.TextColor3=selected and p.white or p.hot end
                end
            end
        end
    end

    local function applyTheme(name,settlePass)
        local p=THEMES[name]; if not p then return end
        currentName=name; _G.KimqCuteTheme=name; _G.KimqThemeLivePalette=p
        if type(_G.KimqRefreshWingMiniTheme)=="function" then pcall(_G.KimqRefreshWingMiniTheme) end
        if type(_G.KimqRefreshRageMiniTheme)=="function" then pcall(_G.KimqRefreshRageMiniTheme) end
        if type(_G.KimqRefreshWeaponPresetTheme)=="function" then pcall(_G.KimqRefreshWeaponPresetTheme) end
        if type(_G.KimqRefreshKnifeAccentTheme)=="function" then pcall(_G.KimqRefreshKnifeAccentTheme) end
        if type(_G.KimqRefreshAvatarAccessoryTheme)=="function" then pcall(_G.KimqRefreshAvatarAccessoryTheme) end

        -- Snapshot each opaque object's CURRENT semantic color role before painting.
        -- That preserves selected/unselected states while still translating every old
        -- palette color into the newly chosen theme.
        local liveBgRoles={}
        for _,d in ipairs(main:GetDescendants()) do
            if d:IsA("GuiObject") and d.BackgroundTransparency<.98
                and not hasPreviewAncestor(d) and not isTrueColorVisual(d) then
                liveBgRoles[d]=nearestAnyThemeRole(d.BackgroundColor3)
            end
        end
        if main.BackgroundTransparency<.98 then liveBgRoles[main]="bg" end

        -- Pick up controls that were created after startup (weapon/skin buttons,
        -- dropdown rows, etc.) so they cannot keep the original Matcha colors.
        for _,d in ipairs(main:GetDescendants()) do
            if not seen[d] and not hasPreviewAncestor(d) then classify(d) end
        end

        -- Update every live palette table used by the original control callbacks.
        for _,T in ipairs(_G.KimqThemePaletteRefs or {}) do
            if type(T)=="table" then
                T.bg=p.bg; T.bg2=p.bg2; T.panel=p.panel; T.card=p.panel; T.card2=p.soft
                T.hot=p.hot; T.hot2=p.hot2; T.text=p.text; T.sub=p.sub; T.stroke=p.line; T.white=p.white
            end
        end

        for _,e in ipairs(entries) do
            local o=e.o
            if o and o.Parent and not hasPreviewAncestor(o) then
                if o:IsA("GuiObject") then
                    local liveRole=liveBgRoles[o] or e.bgRole
                    if liveRole then applyBackground(o,liveRole,p) end
                end
                if e.toggle and o:IsA("TextButton") then
                    local c=e.toggleCircle
                    local on=c and c.Parent and c.Position.X.Scale>.5
                    o.BackgroundColor3=on and p.hot or p.soft
                    if c and c.Parent then c.BackgroundColor3=p.white end
                end
                if e.textRole and (o:IsA("TextLabel") or o:IsA("TextButton") or o:IsA("TextBox")) then applyText(o,e.textRole,p) end
                if e.placeholderRole and o:IsA("TextBox") then o.PlaceholderColor3=p.sub end
                if e.imageRole and (o:IsA("ImageLabel") or o:IsA("ImageButton")) then o.ImageColor3=p.hot end
                if e.scroll and o:IsA("ScrollingFrame") then o.ScrollBarImageColor3=p.hot end
                if e.stroke and o:IsA("UIStroke") then o.Color=p.line end
                if e.gradient and o:IsA("UIGradient") then
                    o.Color=ColorSequence.new({ColorSequenceKeypoint.new(0,p.hot2),ColorSequenceKeypoint.new(.52,p.hot),ColorSequenceKeypoint.new(1,p.hot:Lerp(p.white,.12))})
                end
                if e.profileGradient and o:IsA("UIGradient") then
                    o.Color=ColorSequence.new({
                        ColorSequenceKeypoint.new(0,p.hot),
                        ColorSequenceKeypoint.new(1,p.white)
                    })
                end
            end
        end

        -- Full-surface sweep: anything opaque that survived a legacy callback is
        -- translated from its live role as well, even if it was never in the cached
        -- semantic-entry table. Color pickers and theme-preview swatches stay untouched.
        for _,d in ipairs(main:GetDescendants()) do
            if not hasPreviewAncestor(d) then
                if d:IsA("GuiObject") and d.BackgroundTransparency<.98 and not isTrueColorVisual(d) then
                    local role=liveBgRoles[d]
                    if role then applyBackground(d,role,p) end
                end
                if d:IsA("ScrollingFrame") then d.ScrollBarImageColor3=p.hot end
                if d:IsA("UIStroke") then d.Color=p.line end
            end
        end

        -- Action buttons and special branding need deterministic roles regardless of their old RGB.
        for _,d in ipairs(main:GetDescendants()) do
            if not hasPreviewAncestor(d) then
                if d:IsA("TextButton") then
                    local low=clean(d.Text)
                    if d.Name=="KimqResizeGrip" or d:GetAttribute("KimqResizeControl") then
                        d.BackgroundColor3=p.hot; d.TextColor3=p.white
                        local st=d:FindFirstChildOfClass("UIStroke"); if st then st.Color=p.line end
                    elseif low:find("apply",1,true) or low:find("selected",1,true) then
                        d.BackgroundColor3=p.hot; d.TextColor3=p.white
                        local st=d:FindFirstChildOfClass("UIStroke"); if st then st.Color=p.hot end
                    end
                elseif d:IsA("TextLabel") then
                    local low=clean(d.Text)
                    if low:match("^v2%.") then
                        d.BackgroundTransparency=0; d.BackgroundColor3=p.hot; d.TextColor3=p.white
                        local st=d:FindFirstChildOfClass("UIStroke"); if st then st.Color=p.hot end
                    elseif low:find("kimqetras hc",1,true) and d.BackgroundTransparency>.8 then
                        d.TextColor3=p.hot
                    end
                end
            end
        end

        -- v2.62 hard guarantee: old controls created with literal pink/yellow
        -- values are translated too. This catches Avatar, old section controls,
        -- late weapon UI, config buttons, etc. True color pickers/previews are excluded.
        local legacyHot={
            Color3.fromRGB(243,161,211),Color3.fromRGB(255,20,147),
            Color3.fromRGB(255,105,180),Color3.fromRGB(255,190,220),
            Color3.fromRGB(230,40,135),Color3.fromRGB(225,55,135),
            Color3.fromRGB(225,73,140),Color3.fromRGB(220,45,125),
            Color3.fromRGB(212,105,169)
        }
        local legacySoft={
            Color3.fromRGB(255,225,238),Color3.fromRGB(255,205,228),
            Color3.fromRGB(255,236,190),Color3.fromRGB(255,242,206),
            Color3.fromRGB(236,255,243)
        }
        local legacySub={
            Color3.fromRGB(197,112,145),Color3.fromRGB(184,100,125),
            Color3.fromRGB(176,99,122)
        }
        local function nearAny(c,list,tol)
            for _,x in ipairs(list) do
                if colorDistance(c,x)<=tol then return true end
            end
            return false
        end
        for _,d in ipairs(main:GetDescendants()) do
            if not hasPreviewAncestor(d) and not isTrueColorVisual(d) then
                if d:IsA("GuiObject") and d.BackgroundTransparency<.98 then
                    if nearAny(d.BackgroundColor3,legacyHot,.13) then
                        d.BackgroundColor3=p.hot
                    elseif nearAny(d.BackgroundColor3,legacySoft,.13) then
                        d.BackgroundColor3=p.soft
                    end
                end
                if d:IsA("TextLabel") or d:IsA("TextButton") or d:IsA("TextBox") then
                    if nearAny(d.TextColor3,legacyHot,.16) then
                        d.TextColor3=p.hot
                    elseif nearAny(d.TextColor3,legacySub,.16) then
                        d.TextColor3=p.sub
                    end
                    if d:IsA("TextBox") and nearAny(d.PlaceholderColor3,legacySub,.16) then
                        d.PlaceholderColor3=p.sub
                    end
                end
                if d:IsA("UIStroke") and nearAny(d.Color,legacyHot,.18) then
                    d.Color=p.line
                end
            end
        end

        if themePage then themePage.BackgroundColor3=p.bg end
        styleNav(p)

        -- Some old control callbacks repaint themselves a fraction of a second after
        -- a theme click. Two bounded settle passes catch those leftovers without a
        -- permanent frame loop.
        if not settlePass then
            -- One short settle is enough; repeated full-GUI sweeps were a major source of stutter.
            task.delay(.08,function()
                if main.Parent and currentName==name then applyTheme(name,true) end
            end)
        end
    end
    _G.KimqApplyTheme=applyTheme

    -- v2.9: do not repaint the entire GUI after every mouse click. Controls already
    -- use the live theme palette and page/theme changes have their own refresh hooks.
    -- The old global click repaint walked the full GUI several times per interaction.

    -- Rebuild the Theme page once.  These rows are previews, so their swatches keep
    -- their own palette even while the rest of the GUI changes.
    if themePage then
        for _,ch in ipairs(themePage:GetChildren()) do
            if not ch:IsA("UIListLayout") and not ch:IsA("UIPadding") then ch:Destroy() end
        end
        themePage.BackgroundTransparency=0
        local layout=themePage:FindFirstChildOfClass("UIListLayout") or Instance.new("UIListLayout",themePage)
        layout.Padding=UDim.new(0,8); layout.SortOrder=Enum.SortOrder.LayoutOrder
        local pad=themePage:FindFirstChildOfClass("UIPadding") or Instance.new("UIPadding",themePage)
        pad.PaddingTop=UDim.new(0,8); pad.PaddingBottom=UDim.new(0,10); pad.PaddingLeft=UDim.new(0,5); pad.PaddingRight=UDim.new(0,5)
        local function makeRow(name,index)
            local t=THEMES[name]
            local f=Instance.new("Frame",themePage); f.Name="ThemeChoiceClean"; f:SetAttribute("KimqThemePreview",true); f.LayoutOrder=index; f.Size=UDim2.new(1,-10,0,54); f.BackgroundColor3=t.panel; f.BorderSizePixel=0; corner(f,11); outline(f,t.line,.12,1)
            local l=Instance.new("TextLabel",f); l.BackgroundTransparency=1; l.Position=UDim2.fromOffset(14,0); l.Size=UDim2.new(1,-175,1,0); l.Text=labels[name] or name; l.Font=Enum.Font.GothamSemibold; l.TextSize=13; l.TextXAlignment=Enum.TextXAlignment.Left; l.TextColor3=t.text
            local a=Instance.new("Frame",f); a.Size=UDim2.fromOffset(32,32); a.Position=UDim2.new(1,-145,.5,-16); a.BackgroundColor3=t.bg; a.BorderSizePixel=0; corner(a,9); outline(a,t.line,.1,1)
            local b=Instance.new("Frame",f); b.Size=UDim2.fromOffset(32,32); b.Position=UDim2.new(1,-105,.5,-16); b.BackgroundColor3=t.hot; b.BorderSizePixel=0; corner(b,9); outline(b,t.hot,.05,1)
            local btn=Instance.new("TextButton",f); btn.Size=UDim2.fromOffset(56,32); btn.Position=UDim2.new(1,-65,.5,-16); btn.BackgroundColor3=t.hot; btn.BorderSizePixel=0; btn.Text="♥"; btn.TextColor3=t.white; btn.Font=Enum.Font.FredokaOne; btn.TextSize=16; btn.AutoButtonColor=false; corner(btn,9)
            btn.MouseButton1Click:Connect(function() applyTheme(name) end)
        end
        for i,name in ipairs(order) do makeRow(name,i) end
        local function resizeThemeCanvas() themePage.CanvasSize=UDim2.new(0,0,0,layout.AbsoluteContentSize.Y+18) end
        layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(resizeThemeCanvas)
        resizeThemeCanvas()
    end

    -- v2.62: section navigation does not repaint/rescan the entire GUI.
    -- The page builder's live theme palette already keeps nav colors current.

    -- Newly generated controls are classified immediately. Their first paint uses
    -- the current palette, so opening Weapon Skins does not introduce old colors.
    main.DescendantAdded:Connect(function(d)
        if hasPreviewAncestor(d) then return end
        task.defer(function()
            if d.Parent and not seen[d] then
                classify(d)
                local p=THEMES[currentName]
                local e=nil
                for i=#entries,1,-1 do if entries[i].o==d then e=entries[i]; break end end
                if e and p then
                    if e.bgRole and d:IsA("GuiObject") then applyBackground(d,e.bgRole,p) end
                    if e.textRole and (d:IsA("TextLabel") or d:IsA("TextButton") or d:IsA("TextBox")) then applyText(d,e.textRole,p) end
                    if e.placeholderRole and d:IsA("TextBox") then d.PlaceholderColor3=p.sub end
                    if e.imageRole and (d:IsA("ImageLabel") or d:IsA("ImageButton")) then d.ImageColor3=p.hot end
                    if e.scroll and d:IsA("ScrollingFrame") then d.ScrollBarImageColor3=p.hot end
                    if e.stroke and d:IsA("UIStroke") then d.Color=p.line end
                end
            end
        end)
    end)

    -- Bottom-right resize grip. Drag it to make the whole window smaller or larger.
    -- This only changes the final v2.1 Main size; it does not create another GUI layer.
    do
        local oldGrip=main:FindFirstChild("KimqResizeGrip")
        if oldGrip then oldGrip:Destroy() end

        local grip=Instance.new("TextButton")
        grip.Name="KimqResizeGrip"
        grip.Parent=main
        grip.AnchorPoint=Vector2.new(1,1)
        grip.Position=UDim2.new(1,-8,1,-8)
        grip.Size=UDim2.fromOffset(30,30)
        grip.BackgroundColor3=THEMES[currentName].hot
        grip.BackgroundTransparency=.05
        grip.BorderSizePixel=0
        grip.Text="↘"
        grip.TextColor3=THEMES[currentName].white
        grip.Font=Enum.Font.GothamBold
        grip.TextSize=16
        grip.AutoButtonColor=false
        grip.Active=true
        grip.ZIndex=250
        grip:SetAttribute("KimqResizeControl",true)
        corner(grip,9)
        outline(grip,THEMES[currentName].line,.18,1)

        local resizing=false
        local dragInput=nil
        local startMouse=nil
        local startSize=nil
        local MIN_W,MIN_H=720,460

        local function updateResize(input)
            if not resizing or not startMouse or not startSize then return end
            local delta=input.Position-startMouse
            local cam=workspace.CurrentCamera
            local viewport=cam and cam.ViewportSize or Vector2.new(1920,1080)
            local pos=main.AbsolutePosition
            local maxW=math.max(MIN_W,viewport.X-pos.X-10)
            local maxH=math.max(MIN_H,viewport.Y-pos.Y-10)
            local w=math.clamp(startSize.X+delta.X,MIN_W,maxW)
            local h=math.clamp(startSize.Y+delta.Y,MIN_H,maxH)
            main.Size=UDim2.fromOffset(math.floor(w+.5),math.floor(h+.5))
        end

        grip.InputBegan:Connect(function(input)
            if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then
                resizing=true
                dragInput=input
                startMouse=input.Position
                startSize=main.AbsoluteSize
                input.Changed:Connect(function()
                    if input.UserInputState==Enum.UserInputState.End then
                        resizing=false
                        dragInput=nil
                    end
                end)
            end
        end)
        grip.InputChanged:Connect(function(input)
            if input.UserInputType==Enum.UserInputType.MouseMovement or input.UserInputType==Enum.UserInputType.Touch then
                dragInput=input
            end
        end)
        UIS.InputChanged:Connect(function(input)
            if resizing and (input==dragInput or input.UserInputType==Enum.UserInputType.MouseMovement or input.UserInputType==Enum.UserInputType.Touch) then
                updateResize(input)
            end
        end)
    end

    applyTheme(currentName)
    _G.KimqV21FullThemeActive=true
    _G.KimqThemeEngineReady=true

    -- v2.62 reveal happens only after this initial theme pass is complete.
end)


-- v2.62: delayed post-show cleanup passes removed.
-- All essential routing/styling is completed before reveal.

-- ========================================================
-- v2.6 selected-config update + exact Fog / Atmosphere restore
-- ========================================================


-- ========================================================
-- v2.62 branding is deterministic at construction time; no delayed scrub pass.

-- v2.69 BOOT WATCHDOG -------------------------------------------------
-- If an optional late UI pass stalls, never leave the successfully-created
-- Kimqetras ScreenGui disabled forever. This only reveals existing UI; it does
-- not rebuild or restart any feature section.
task.delay(12,function()
    pcall(function()
        local PlayersW=game:GetService("Players")
        local CoreGuiW=game:GetService("CoreGui")
        local lpW=PlayersW.LocalPlayer
        local pgW=lpW and lpW:FindFirstChildOfClass("PlayerGui")
        local rootW=CoreGuiW:FindFirstChild("KimpetrasHC") or (pgW and pgW:FindFirstChild("KimpetrasHC"))
        if rootW then
            rootW.Enabled=true
            local mainW=rootW:FindFirstChild("Main")
            if mainW and _G.KimqMainUserVisibleState~=false then
                mainW.Visible=true
            end
        end
    end)
end)

-- ========================================================
-- v2.62 DETERMINISTIC REVEAL
-- Keep the loading screen up until the actual interface is fully constructed.
-- ========================================================
task.spawn(function()
    local Players=game:GetService("Players")
    local CoreGui=game:GetService("CoreGui")
    local lp=Players.LocalPlayer
    local pg=lp and lp:FindFirstChildOfClass("PlayerGui")

    local t0=tick()
    while (not _G.KimqThemeEngineReady
        or not _G.KimqV26FeaturesReady
        or not _G.KimqAccessoryUIReady)
        and tick()-t0<15 do
        task.wait(.03)
    end

    local root=CoreGui:FindFirstChild("KimpetrasHC") or (pg and pg:FindFirstChild("KimpetrasHC"))
    local main=root and root:FindFirstChild("Main")

    -- v2.62: remove the old one-page section divider labels from the
    -- actual content pages. The large page header already shows the name.
    if main then
        local pageHost=main:FindFirstChild("PageHost",true)
        local legacyHeaders={
            ["silent aim"]=true,["macro"]=true,["whitelist"]=true,
            ["protection"]=true,["anti fall"]=true,["delay changer"]=true,
            ["esp"]=true,["avatar"]=true,["combat"]=true,["force hit"]=true,
            ["hitbox expander"]=true,["flamelock"]=true,["camlock"]=true,
            ["visuals"]=true,["headless"]=true,["protection + anti mod"]=true,
            ["settings"]=true,["credits"]=true,["information"]=true,
            ["environment"]=true,["weapon skins"]=true,["fog / atmosphere"]=true,
            ["spawn point"]=true,
        }

        local function cleanLegacyHeader(text)
            text=tostring(text or ""):gsub("^%s+","")
            local first=text:sub(1,1)
            if first~="♥" and first~="♡" then return nil end
            text=text:gsub("^[♥♡]%s*","")
            text=text:gsub("%s+"," "):gsub("^%s+",""):gsub("%s+$","")
            return text:lower()
        end

        if pageHost then
            for _,page in ipairs(pageHost:GetChildren()) do
                if page:IsA("ScrollingFrame") then
                    for _,obj in ipairs(page:GetDescendants()) do
                        if obj:IsA("TextLabel") then
                            local header=cleanLegacyHeader(obj.Text)
                            if header and legacyHeaders[header] then
                                -- Direct-child divider labels should vanish entirely.
                                -- Labels inside useful cards are removed without
                                -- deleting the rest of that card's controls/text.
                                pcall(function() obj:Destroy() end)
                            end
                        end
                    end
                end
            end
        end
    end

    -- ========================================================
    -- v2.62 FINAL SECTION OWNERSHIP GUARD
    --
    -- The rest of the script is already working, so do not "rediscover"
    -- feature locations from button text.  Seal the layout that survived
    -- the canonical routing pass and use creation-time KimqSection stamps
    -- whenever one exists.
    -- ========================================================
    if main then
        pcall(function()
            local pageHost=main:FindFirstChild("PageHost",true)
            if pageHost then
                local pagesByKey={}
                local pageKeyByInstance=setmetatable({}, {__mode="k"})

                for _,page in ipairs(pageHost:GetChildren()) do
                    if page:IsA("ScrollingFrame") and page.Name:match("Page$") then
                        local key=page.Name:gsub("Page$",""):lower()
                        pagesByKey[key]=page
                        pageKeyByInstance[page]=key
                    end
                end

                local function normalizeSection(section)
                    section=tostring(section or ""):lower()
                    if section=="forcehit" then return "hcsilent" end
                    if section=="headless" then return "avatar" end
                    return section
                end

                local guardBusy=false

                local function enforceDirectChild(page,child)
                    if guardBusy
                        or not page
                        or not child
                        or not child.Parent
                        or child:IsA("UIListLayout")
                        or child:IsA("UIPadding")
                    then
                        return
                    end

                    local currentKey=pageKeyByInstance[page]
                    if not currentKey then return end

                    local stamped=normalizeSection(child:GetAttribute("KimqSection"))

                    if stamped~="" and pagesByKey[stamped] then
                        local owner=pagesByKey[stamped]
                        if child.Parent~=owner then
                            guardBusy=true
                            child.Parent=owner
                            guardBusy=false
                        end
                    else
                        -- No ownership metadata: the card is already in a canonical
                        -- page at this late stage.  Preserve it exactly where it is.
                        child:SetAttribute("KimqSection",currentKey)
                    end
                end

                -- First seal every feature currently in the GUI.
                for _,page in pairs(pagesByKey) do
                    for _,child in ipairs(page:GetChildren()) do
                        enforceDirectChild(page,child)
                    end
                end

                -- Then protect dynamically-created cards (Whitelist entries,
                -- future refreshed cards, etc.) without using visual heuristics.
                for _,page in pairs(pagesByKey) do
                    page.ChildAdded:Connect(function(child)
                        task.defer(function()
                            if child and child.Parent then
                                enforceDirectChild(page,child)
                            end
                        end)
                    end)
                end

                _G.KimqSectionOwnershipReady=true
            end
        end)
    end

    if root then root.Enabled=true end
    if _G.KimqMainUserVisibleState==nil then _G.KimqMainUserVisibleState=true end
    pcall(function() if type(getgenv)=="function" then getgenv().KimqMainUserVisibleState=_G.KimqMainUserVisibleState end end)
    if main then main.Visible=(_G.KimqMainUserVisibleState~=false) end

    _G[KIMQ_SINGLE_KEY]=true
    _G.KimqHC_v21_PerformanceLoaded=true
    _G.KimqHC_CurrentBuild=KIMQ_BUILD
    _G.KimqHC_RuntimeState="ready"
    pcall(function()
        if type(getgenv)=="function" then
            local e=getgenv()
            e[KIMQ_SINGLE_KEY]=true
            e.KimqHC_v21_PerformanceLoaded=true
            e.KimqHC_CurrentBuild=KIMQ_BUILD
            e.KimqHC_RuntimeState="ready"
        end
    end)
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification",{
            Title="Kimqetras HC",
            Text="v2.81 ACTIVE ♡ • phased RAGE stomp + stable avatar ready",
            Duration=7,
        })
    end)

    local boot=CoreGui:FindFirstChild("KimpetrasHC_Boot") or (pg and pg:FindFirstChild("KimpetrasHC_Boot"))
    if boot then pcall(function() boot:Destroy() end) end

    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification",{
            Title="Kimqetras HC",
            Text="v2.81 ready ♡",
            Duration=3
        })
    end)
end)



-- ========================================================
-- v2.76 FEATURE PAGE ORGANIZER (VISUAL ONLY)
-- Keeps HOME/credits pages untouched. Existing controls stay in the exact same
-- relative order and keep their original callbacks/config ownership.
-- ========================================================
task.spawn(function()
    local Players=game:GetService("Players")
    local CoreGui=game:GetService("CoreGui")
    local lp=Players.LocalPlayer
    local pg=lp and lp:WaitForChild("PlayerGui",8)
    local t0=os.clock()
    while not _G.KimqSectionOwnershipReady and os.clock()-t0<12 do task.wait(.08) end

    local root=CoreGui:FindFirstChild("KimpetrasHC") or (pg and pg:FindFirstChild("KimpetrasHC"))
    local main=root and root:FindFirstChild("Main")
    local pageHost=main and main:FindFirstChild("PageHost",true)
    if not pageHost then return end

    local excluded={overview=true,settings=true,theme=true,info=true}
    local pretty={
        hcsilent="HC combat",silent="silent aim",camlock="camlock",flamelock="flamelock",
        hitbox="hitbox",delay="delay changer",fog="fog + atmosphere",environment="environment",
        esp="ESP",avatar="avatar",weaponskins="weapon skins",whitelist="whitelist",
        protection="protection",antifall="anti fall",antimod="anti mod",spawn="spawn point",
        macro="macro",ragecam="rage camlock",rageorbit="target orbit",ragecombat="rage combat",
        ragepresets="rage presets"
    }

    local function palette()
        local p=_G.KimqThemeLivePalette
        return type(p)=="table" and p or {
            panel=Color3.new(1,1,1),soft=Color3.fromRGB(246,255,250),
            hot=Color3.fromRGB(243,161,211),text=Color3.fromRGB(82,116,94),
            sub=Color3.fromRGB(122,153,133),line=Color3.fromRGB(255,212,243)
        }
    end
    local function corner(o,r)
        local c=o:FindFirstChildOfClass("UICorner") or Instance.new("UICorner",o)
        c.CornerRadius=UDim.new(0,r or 10)
    end
    local function stroke(o,c,t)
        local s=o:FindFirstChildOfClass("UIStroke") or Instance.new("UIStroke",o)
        s.Color=c; s.Transparency=t or .35; s.Thickness=1
    end
    local function textLabel(parent,text,size,pos,font,sz,color)
        local l=Instance.new("TextLabel",parent)
        l.BackgroundTransparency=1;l.Size=size;l.Position=pos;l.Text=text
        l.Font=font;l.TextSize=sz;l.TextColor3=color;l.TextXAlignment=Enum.TextXAlignment.Left
        return l
    end

    for _,page in ipairs(pageHost:GetChildren()) do
        if page:IsA("ScrollingFrame") and page.Name:match("Page$") then
            local key=page.Name:gsub("Page$",""):lower()
            if not excluded[key] then
                local list=page:FindFirstChildOfClass("UIListLayout")
                if list then list.Padding=UDim.new(0,8) end

                local cards={}
                for _,child in ipairs(page:GetChildren()) do
                    if child:IsA("GuiObject") and not child:IsA("UIListLayout") and not child:IsA("UIPadding")
                        and not child:GetAttribute("KimqOrganizerDecor") then
                        table.insert(cards,child)
                    end
                end
                table.sort(cards,function(a,b)
                    if a.LayoutOrder==b.LayoutOrder then
                        if a.AbsolutePosition.Y==b.AbsolutePosition.Y then return a.Name<b.Name end
                        return a.AbsolutePosition.Y<b.AbsolutePosition.Y
                    end
                    return a.LayoutOrder<b.LayoutOrder
                end)

                -- Preserve exact existing order; only spread LayoutOrder values to make
                -- room for non-interactive divider labels.
                for i,card in ipairs(cards) do
                    card.LayoutOrder=i*10
                    if card:IsA("Frame") then
                        corner(card,12)
                        local p=palette(); stroke(card,p.line,.35)
                        if not key:match("^rage") and not card:FindFirstChild("KimqOrganizerAccent") then
                            local accent=Instance.new("Frame",card)
                            accent.Name="KimqOrganizerAccent"
                            accent:SetAttribute("KimqOrganizerDecor",true)
                            accent:SetAttribute("KimqV26Role","hotBg")
                            accent.Size=UDim2.fromOffset(3,math.clamp(card.Size.Y.Offset-16,18,38))
                            accent.Position=UDim2.fromOffset(4,8)
                            accent.BorderSizePixel=0
                            accent.BackgroundColor3=p.hot
                            accent.ZIndex=0
                            corner(accent,999)
                        end
                    end
                end

                if not page:FindFirstChild("KimqOrganizerHeader") then
                    local p=palette()
                    local head=Instance.new("Frame",page)
                    head.Name="KimqOrganizerHeader";head:SetAttribute("KimqOrganizerDecor",true)
                    head:SetAttribute("KimqSection",key);head:SetAttribute("KimqV26Role","lightBg")
                    head.LayoutOrder=1;head.Size=UDim2.new(1,-6,0,44)
                    head.BackgroundColor3=p.soft;head.BorderSizePixel=0
                    corner(head,12);stroke(head,p.line,.34)
                    local heart=textLabel(head,"♥",UDim2.fromOffset(28,28),UDim2.fromOffset(10,8),Enum.Font.FredokaOne,18,p.hot)
                    heart:SetAttribute("KimqV26Role","hotText")
                    local title=textLabel(head,(pretty[key] or key).."  •  controls",UDim2.new(1,-52,0,20),UDim2.fromOffset(38,5),Enum.Font.GothamBold,11,p.text)
                    title:SetAttribute("KimqV26Role","textText")
                    local sub=textLabel(head,"clean groups ♡  •  same features, same behavior",UDim2.new(1,-52,0,16),UDim2.fromOffset(38,23),Enum.Font.Gotham,9,p.sub)
                    sub:SetAttribute("KimqV26Role","subText")
                end

                local groupLabels={"more controls ♡","advanced ♡","extras ♡"}
                local starts={7,13,19}
                for gi,startIndex in ipairs(starts) do
                    if #cards>=startIndex and not page:FindFirstChild("KimqOrganizerDivider"..gi) then
                        local p=palette()
                        local d=Instance.new("Frame",page)
                        d.Name="KimqOrganizerDivider"..gi;d:SetAttribute("KimqOrganizerDecor",true)
                        d:SetAttribute("KimqSection",key);d.LayoutOrder=(startIndex*10)-5
                        d.Size=UDim2.new(1,-6,0,24);d.BackgroundTransparency=1
                        local l=textLabel(d,groupLabels[gi],UDim2.new(1,-18,1,0),UDim2.fromOffset(9,0),Enum.Font.GothamSemibold,9,p.hot)
                        l:SetAttribute("KimqV26Role","hotText")
                    end
                end
            end
        end
    end
end)

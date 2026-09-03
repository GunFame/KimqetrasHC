-- V30 Roblox-hosted artwork + Pompompurin stitched GUI.
do
    _G.KimqV29Ready = false
    _G.KimqV30Ready = false
    _G.KimqV29Assets = {
        Pompom     = "rbxassetid://98379642851874",
        PompomIcon = "rbxassetid://109428653544528",
        Paw        = "rbxassetid://138088505213748",
        Title      = "rbxassetid://99152748483206",
        Subtitle   = "rbxassetid://94248590271491",
        Minus      = "rbxassetid://121030051960124",
        Close      = "rbxassetid://129350478207195",
        ToggleOn   = "rbxassetid://95234565377817",
        ToggleOff  = "rbxassetid://97764595221865",
        Reset      = "rbxassetid://104585185562435",
    }
    _G.KimqV30Assets = _G.KimqV29Assets
end


do
    local Players=game:GetService("Players")
    local CoreGui=game:GetService("CoreGui")
    local TweenService=game:GetService("TweenService")
    local ContentProvider=game:GetService("ContentProvider")
    local lp=Players.LocalPlayer
    local pg=lp:WaitForChild("PlayerGui")
    local A=_G.KimqV29Assets or {}
    pcall(function()
        for _,root in ipairs({CoreGui,pg}) do
            for _,n in ipairs({"KimqV30UploadedLoader","KimqV29CuteLoader"}) do local old=root:FindFirstChild(n); if old then old:Destroy() end end
        end
    end)
    local gui=Instance.new("ScreenGui"); gui.Name="KimqV30UploadedLoader"; gui.IgnoreGuiInset=true; gui.ResetOnSpawn=false; gui.DisplayOrder=9000000
    pcall(function() gui.Parent=CoreGui end); if not gui.Parent then gui.Parent=pg end
    local bg=Instance.new("Frame",gui); bg.Size=UDim2.fromScale(1,1); bg.BorderSizePixel=0; bg.BackgroundColor3=Color3.fromRGB(207,231,255)
    local g=Instance.new("UIGradient",bg); g.Color=ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.fromRGB(240,249,255)),ColorSequenceKeypoint.new(.52,Color3.fromRGB(211,232,255)),ColorSequenceKeypoint.new(1,Color3.fromRGB(172,207,255))}); g.Rotation=18
    local function corner(o,r) local c=Instance.new("UICorner",o); c.CornerRadius=UDim.new(0,r); return c end
    local function stroke(o,c,t,w) local s=Instance.new("UIStroke",o); s.Color=c; s.Transparency=t or 0; s.Thickness=w or 1; return s end
    local function lbl(p,t,size,pos,font,sz,col,align) local x=Instance.new("TextLabel",p); x.BackgroundTransparency=1; x.Size=size; x.Position=pos; x.Text=t; x.Font=font; x.TextSize=sz; x.TextColor3=col; x.TextXAlignment=align or Enum.TextXAlignment.Left; x.TextYAlignment=Enum.TextYAlignment.Center; return x end
    local function img(p,a,size,pos,z) if not a then return end local x=Instance.new("ImageLabel",p); x.BackgroundTransparency=1; x.Size=size; x.Position=pos; x.Image=a; x.ScaleType=Enum.ScaleType.Fit; x.ZIndex=z or 3; return x end
    local card=Instance.new("Frame",bg); card.Name="Card"; card.AnchorPoint=Vector2.new(.5,.5); card.Position=UDim2.fromScale(.5,.5); card.Size=UDim2.fromOffset(720,470); card.BackgroundColor3=Color3.fromRGB(249,252,255); card.BorderSizePixel=0; corner(card,28); stroke(card,Color3.fromRGB(74,133,244),.12,2)
    local stitches=Instance.new("Frame",card); stitches.BackgroundTransparency=1; stitches.Position=UDim2.fromOffset(22,22); stitches.Size=UDim2.new(1,-44,1,-44); stitches.ZIndex=2
    for i=0,29 do for _,yy in ipairs({0,1}) do local d=Instance.new("Frame",stitches); d.Size=UDim2.fromOffset(11,2); d.AnchorPoint=Vector2.new(.5,.5); d.Position=UDim2.new(i/29,0,yy,0); d.BackgroundColor3=Color3.fromRGB(104,159,237); d.BackgroundTransparency=.38; d.BorderSizePixel=0; corner(d,2) end end
    for i=0,18 do for _,xx in ipairs({0,1}) do local d=Instance.new("Frame",stitches); d.Size=UDim2.fromOffset(2,11); d.AnchorPoint=Vector2.new(.5,.5); d.Position=UDim2.new(xx,0,i/18,0); d.BackgroundColor3=Color3.fromRGB(104,159,237); d.BackgroundTransparency=.38; d.BorderSizePixel=0; corner(d,2) end end
    img(card,A.Pompom,UDim2.fromOffset(124,118),UDim2.fromOffset(42,31),5)
    local title=img(card,A.Title,UDim2.fromOffset(312,94),UDim2.fromOffset(162,42),5)
    local sub=img(card,A.Subtitle,UDim2.fromOffset(180,58),UDim2.fromOffset(174,105),5)
    if not title then lbl(card,"Kimqetras",UDim2.fromOffset(310,48),UDim2.fromOffset(170,53),Enum.Font.FredokaOne,36,Color3.fromRGB(54,111,227)) end
    if not sub then lbl(card,"silent hc  ♡",UDim2.fromOffset(220,28),UDim2.fromOffset(176,105),Enum.Font.FredokaOne,18,Color3.fromRGB(88,135,214)) end
    local profile=Instance.new("Frame",card); profile.Size=UDim2.fromOffset(205,50); profile.Position=UDim2.new(1,-242,0,38); profile.BackgroundColor3=Color3.fromRGB(239,247,255); profile.BorderSizePixel=0; corner(profile,14); stroke(profile,Color3.fromRGB(156,195,236),.30,1)
    local av=Instance.new("ImageLabel",profile); av.Size=UDim2.fromOffset(36,36); av.Position=UDim2.fromOffset(8,7); av.BackgroundColor3=Color3.fromRGB(220,238,255); av.BorderSizePixel=0; corner(av,999); pcall(function() av.Image=Players:GetUserThumbnailAsync(lp.UserId,Enum.ThumbnailType.HeadShot,Enum.ThumbnailSize.Size100x100) end)
    lbl(profile,lp.DisplayName,UDim2.new(1,-52,0,18),UDim2.fromOffset(50,6),Enum.Font.FredokaOne,13,Color3.fromRGB(56,84,142)); lbl(profile,"@"..lp.Name,UDim2.new(1,-52,0,16),UDim2.fromOffset(50,24),Enum.Font.Gotham,10,Color3.fromRGB(103,128,172))
    local divider=lbl(card,"-  -  -  -  -  -  -  -  -",UDim2.new(1,-90,0,18),UDim2.fromOffset(45,171),Enum.Font.GothamBold,11,Color3.fromRGB(133,173,227),Enum.TextXAlignment.Center)
    local status=lbl(card,"getting the cute stuff ready...",UDim2.new(1,-90,0,24),UDim2.fromOffset(45,199),Enum.Font.GothamSemibold,13,Color3.fromRGB(67,99,162),Enum.TextXAlignment.Center)
    local track=Instance.new("Frame",card); track.Size=UDim2.new(1,-130,0,18); track.Position=UDim2.fromOffset(65,242); track.BackgroundColor3=Color3.fromRGB(222,237,253); track.BorderSizePixel=0; corner(track,999); stroke(track,Color3.fromRGB(148,187,234),.30,1)
    local bar=Instance.new("Frame",track); bar.Name="Bar"; bar.Size=UDim2.new(.06,0,1,0); bar.BackgroundColor3=Color3.fromRGB(72,139,246); bar.BorderSizePixel=0; corner(bar,999); local bgd=Instance.new("UIGradient",bar); bgd.Color=ColorSequence.new(Color3.fromRGB(126,188,255),Color3.fromRGB(62,120,241))
    local pct=lbl(card,"6%",UDim2.fromOffset(70,24),UDim2.new(1,-125,0,269),Enum.Font.FredokaOne,16,Color3.fromRGB(59,112,225),Enum.TextXAlignment.Right)
    local box=Instance.new("Frame",card); box.Size=UDim2.new(1,-130,0,84); box.Position=UDim2.fromOffset(65,308); box.BackgroundColor3=Color3.fromRGB(241,248,255); box.BorderSizePixel=0; corner(box,15); stroke(box,Color3.fromRGB(163,198,237),.34,1)
    img(box,A.Paw,UDim2.fromOffset(34,34),UDim2.fromOffset(26,25),4); img(box,A.Paw,UDim2.fromOffset(34,34),UDim2.new(1,-60,0,25),4)
    lbl(box,"clean pages   •   cute controls   •   blue Pompompurin",UDim2.new(1,-130,0,24),UDim2.fromOffset(65,16),Enum.Font.FredokaOne,14,Color3.fromRGB(67,111,191),Enum.TextXAlignment.Center)
    lbl(box,"loading your features, themes, environment, and weapon skins",UDim2.new(1,-130,0,20),UDim2.fromOffset(65,45),Enum.Font.Gotham,10,Color3.fromRGB(105,133,180),Enum.TextXAlignment.Center)
    -- Preload the Roblox-hosted artwork so the loader does not flash blank placeholders.
    task.spawn(function()
        local preload={}
        for _,d in ipairs(card:GetDescendants()) do if d:IsA("ImageLabel") or d:IsA("ImageButton") then table.insert(preload,d) end end
        pcall(function() ContentProvider:PreloadAsync(preload) end)
    end)
    local steps={{"loading your profile...",.17,1},{"organizing all the feature pages...",.34,1.3},{"styling the stitched blue theme...",.52,1.3},{"setting up environment controls...",.68,1.3},{"checking every weapon skin...",.84,1.4},{"adding the final paws...",.95,1.1}}
    task.spawn(function() for _,s in ipairs(steps) do if not gui.Parent or _G.KimqV30Ready then break end status.Text=s[1]; TweenService:Create(bar,TweenInfo.new(.45,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{Size=UDim2.new(s[2],0,1,0)}):Play(); pct.Text=tostring(math.floor(s[2]*100)).."%"; task.wait(s[3]) end end)
    task.spawn(function() while gui.Parent and not _G.KimqV30Ready do pcall(function() for _,root in ipairs({CoreGui,pg}) do for _,n in ipairs({"KimqV29CuteLoader","KimqV28StitchedLoader","KimqV27ReferenceLoader","KimqV26PompomLoader","KimqV25CanvaLoader","KimqV24CuteLoader","KimqV23DreamyLoader","KimqV22CuteLoader","KimqV21CuteLoader","KimpetrasHC_Boot","KimqV4Loader","KimpetrasHC_Loading"}) do local x=root:FindFirstChild(n); if x and x~=gui then x:Destroy() end end local r=root:FindFirstChild("KimpetrasHC"); local m=r and r:FindFirstChild("Main"); if m then m.Visible=false end end end); task.wait(.07) end end)
    _G.KimqV30Loader={Gui=gui,Background=bg,Card=card,Status=status,Bar=bar,Percent=pct}; _G.KimqV29Loader=_G.KimqV30Loader
    task.delay(60,function() if gui and gui.Parent then pcall(function() gui:Destroy() end) end end)
end


-- V28 clean stitched loader cover.
do
    _G.KimqV28Ready = false
    local Players = game:GetService("Players")
    local CoreGui = game:GetService("CoreGui")
    local TweenService = game:GetService("TweenService")
    local lp = Players.LocalPlayer
    local pg = lp:WaitForChild("PlayerGui")

    pcall(function()
        for _,root in ipairs({CoreGui,pg}) do
            local old = root:FindFirstChild("KimqV28StitchedLoader")
            if old then old:Destroy() end
        end
    end)

    local gui = Instance.new("ScreenGui")
    gui.Name = "KimqV28StitchedLoader"
    gui.IgnoreGuiInset = true
    gui.ResetOnSpawn = false
    gui.DisplayOrder = 7000000
    pcall(function() gui.Parent = CoreGui end)
    if not gui.Parent then gui.Parent = pg end

    local bg = Instance.new("Frame",gui)
    bg.Name = "Background"
    bg.Size = UDim2.fromScale(1,1)
    bg.BackgroundColor3 = Color3.fromRGB(202,225,255)
    bg.BorderSizePixel = 0
    local bgGrad = Instance.new("UIGradient",bg)
    bgGrad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0,Color3.fromRGB(237,247,255)),
        ColorSequenceKeypoint.new(.5,Color3.fromRGB(207,229,255)),
        ColorSequenceKeypoint.new(1,Color3.fromRGB(164,201,255))
    })
    bgGrad.Rotation = 18

    local function corner(o,r)
        local c=Instance.new("UICorner",o); c.CornerRadius=UDim.new(0,r); return c
    end
    local function stroke(o,c,t,w)
        local s=Instance.new("UIStroke",o); s.Color=c; s.Transparency=t or 0; s.Thickness=w or 1; return s
    end
    local function label(p,text,size,pos,font,ts,color,align)
        local l=Instance.new("TextLabel",p); l.BackgroundTransparency=1; l.Size=size; l.Position=pos; l.Text=text; l.Font=font; l.TextSize=ts; l.TextColor3=color
        l.TextXAlignment=align or Enum.TextXAlignment.Left; l.TextYAlignment=Enum.TextYAlignment.Center; return l
    end

    -- soft background bubbles, intentionally subtle
    for _,s in ipairs({{.08,.18,165,.42},{.91,.16,190,.44},{.12,.82,210,.48},{.88,.84,230,.48},{.50,.94,250,.52}}) do
        local b=Instance.new("Frame",bg); b.AnchorPoint=Vector2.new(.5,.5); b.Position=UDim2.new(s[1],0,s[2],0); b.Size=UDim2.fromOffset(s[3],s[3]); b.BackgroundColor3=Color3.fromRGB(248,252,255); b.BackgroundTransparency=s[4]; b.BorderSizePixel=0; corner(b,999)
    end

    local card=Instance.new("Frame",bg)
    card.Name="Card"
    card.AnchorPoint=Vector2.new(.5,.5)
    card.Position=UDim2.fromScale(.5,.5)
    card.Size=UDim2.fromOffset(600,410)
    card.BackgroundColor3=Color3.fromRGB(249,252,255)
    card.BorderSizePixel=0
    corner(card,28)
    stroke(card,Color3.fromRGB(72,126,238),.12,2)

    local stitch=Instance.new("Frame",card)
    stitch.Name="Stitches"; stitch.BackgroundTransparency=1; stitch.Position=UDim2.fromOffset(16,16); stitch.Size=UDim2.new(1,-32,1,-32); stitch.ZIndex=2
    for i=0,25 do
        for _,yy in ipairs({0,1}) do
            local d=Instance.new("Frame",stitch); d.Size=UDim2.fromOffset(11,2); d.AnchorPoint=Vector2.new(.5,.5); d.Position=UDim2.new(i/25,0,yy,0); d.BackgroundColor3=Color3.fromRGB(102,151,231); d.BackgroundTransparency=.42; d.BorderSizePixel=0; corner(d,2)
        end
    end
    for i=0,16 do
        for _,xx in ipairs({0,1}) do
            local d=Instance.new("Frame",stitch); d.Size=UDim2.fromOffset(2,11); d.AnchorPoint=Vector2.new(.5,.5); d.Position=UDim2.new(xx,0,i/16,0); d.BackgroundColor3=Color3.fromRGB(102,151,231); d.BackgroundTransparency=.42; d.BorderSizePixel=0; corner(d,2)
        end
    end

    local mascot=Instance.new("ImageLabel",card)
    mascot.Name="Mascot"
    mascot.BackgroundTransparency=1
    mascot.Size=UDim2.fromOffset(118,108)
    mascot.Position=UDim2.fromOffset(28,28)
    mascot.ScaleType=Enum.ScaleType.Fit
    mascot.ZIndex=5

    local title=label(card,"Kimqetras HC",UDim2.new(1,-190,0,46),UDim2.fromOffset(150,48),Enum.Font.FredokaOne,36,Color3.fromRGB(48,92,185))
    local sub=label(card,"silent hc  ♡",UDim2.new(1,-190,0,24),UDim2.fromOffset(152,91),Enum.Font.FredokaOne,17,Color3.fromRGB(96,132,195))

    local profile=Instance.new("Frame",card)
    profile.Size=UDim2.fromOffset(188,48); profile.Position=UDim2.new(1,-214,0,30); profile.BackgroundColor3=Color3.fromRGB(237,246,255); profile.BorderSizePixel=0; corner(profile,14); stroke(profile,Color3.fromRGB(150,188,234),.34,1)
    local avatar=Instance.new("ImageLabel",profile); avatar.Size=UDim2.fromOffset(34,34); avatar.Position=UDim2.fromOffset(8,7); avatar.BackgroundColor3=Color3.fromRGB(221,238,255); avatar.BorderSizePixel=0; corner(avatar,999)
    pcall(function() avatar.Image=Players:GetUserThumbnailAsync(lp.UserId,Enum.ThumbnailType.HeadShot,Enum.ThumbnailSize.Size100x100) end)
    label(profile,lp.DisplayName,UDim2.new(1,-52,0,18),UDim2.fromOffset(49,6),Enum.Font.FredokaOne,13,Color3.fromRGB(52,77,132))
    label(profile,"@"..lp.Name,UDim2.new(1,-52,0,16),UDim2.fromOffset(49,24),Enum.Font.Gotham,10,Color3.fromRGB(103,127,169))

    local divider=label(card,"-  -  -  -  -  -  -  -  -",UDim2.new(1,-80,0,18),UDim2.fromOffset(40,149),Enum.Font.GothamBold,11,Color3.fromRGB(133,170,223),Enum.TextXAlignment.Center)
    local status=label(card,"getting everything ready...",UDim2.new(1,-70,0,24),UDim2.fromOffset(35,176),Enum.Font.GothamSemibold,13,Color3.fromRGB(63,92,151),Enum.TextXAlignment.Center)

    local track=Instance.new("Frame",card)
    track.Size=UDim2.new(1,-104,0,14); track.Position=UDim2.fromOffset(52,218); track.BackgroundColor3=Color3.fromRGB(220,235,252); track.BorderSizePixel=0; corner(track,999); stroke(track,Color3.fromRGB(145,183,233),.42,1)
    local bar=Instance.new("Frame",track); bar.Name="Bar"; bar.Size=UDim2.new(.06,0,1,0); bar.BackgroundColor3=Color3.fromRGB(56,111,239); bar.BorderSizePixel=0; corner(bar,999)
    local barGrad=Instance.new("UIGradient",bar); barGrad.Color=ColorSequence.new(Color3.fromRGB(96,163,255),Color3.fromRGB(47,103,238))
    local percent=label(card,"6%",UDim2.fromOffset(64,24),UDim2.new(1,-113,0,245),Enum.Font.FredokaOne,16,Color3.fromRGB(55,105,220),Enum.TextXAlignment.Right)

    local note=Instance.new("Frame",card)
    note.Size=UDim2.new(1,-104,0,74); note.Position=UDim2.fromOffset(52,276); note.BackgroundColor3=Color3.fromRGB(242,249,255); note.BorderSizePixel=0; corner(note,16); stroke(note,Color3.fromRGB(160,194,235),.40,1)
    label(note,"clean pages  •  cute controls  •  local visuals",UDim2.new(1,-24,0,25),UDim2.fromOffset(12,10),Enum.Font.FredokaOne,14,Color3.fromRGB(64,105,185),Enum.TextXAlignment.Center)
    label(note,"your profile, themes, environment, and weapon skins are loading",UDim2.new(1,-24,0,22),UDim2.fromOffset(12,37),Enum.Font.Gotham,10,Color3.fromRGB(104,130,174),Enum.TextXAlignment.Center)

    local pawL=Instance.new("ImageLabel",card); pawL.Name="PawL"; pawL.BackgroundTransparency=1; pawL.Size=UDim2.fromOffset(34,31); pawL.Position=UDim2.fromOffset(26,356); pawL.ScaleType=Enum.ScaleType.Fit; pawL.ImageColor3=Color3.fromRGB(72,126,238); pawL.ZIndex=5
    local pawR=Instance.new("ImageLabel",card); pawR.Name="PawR"; pawR.BackgroundTransparency=1; pawR.Size=UDim2.fromOffset(34,31); pawR.Position=UDim2.new(1,-60,0,356); pawR.ScaleType=Enum.ScaleType.Fit; pawR.ImageColor3=Color3.fromRGB(72,126,238); pawR.ZIndex=5

    task.spawn(function()
        local start=tick()
        while gui.Parent and tick()-start<20 do
            if _G.KimqV27PompomAsset and mascot.Image=="" then mascot.Image=_G.KimqV27PompomAsset end
            if _G.KimqV27PawAsset then pawL.Image=_G.KimqV27PawAsset; pawR.Image=_G.KimqV27PawAsset end
            if mascot.Image~="" and pawL.Image~="" then break end
            task.wait(.1)
        end
    end)

    local steps={
        {"loading your profile...",.18,1.0},
        {"organizing every feature page...",.34,1.4},
        {"matching the blue theme...",.50,1.35},
        {"setting up environment controls...",.66,1.4},
        {"checking your weapon wraps...",.82,1.5},
        {"finishing the stitched details...",.94,1.2},
    }
    task.spawn(function()
        for _,s in ipairs(steps) do
            if not gui.Parent or _G.KimqV28Ready then break end
            status.Text=s[1]
            TweenService:Create(bar,TweenInfo.new(.48,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{Size=UDim2.new(s[2],0,1,0)}):Play()
            percent.Text=tostring(math.floor(s[2]*100)).."%"
            task.wait(s[3])
        end
    end)

    task.spawn(function()
        while gui.Parent and not _G.KimqV28Ready do
            pcall(function()
                for _,root in ipairs({CoreGui,pg}) do
                    for _,name in ipairs({"KimqV27ReferenceLoader","KimqV26PompomLoader","KimqV25CanvaLoader","KimqV24CuteLoader","KimqV23DreamyLoader","KimqV22CuteLoader","KimqV21CuteLoader","KimpetrasHC_Boot","KimqV4Loader","KimpetrasHC_Loading"}) do
                        local x=root:FindFirstChild(name); if x and x~=gui then x:Destroy() end
                    end
                    local r=root:FindFirstChild("KimpetrasHC"); local m=r and r:FindFirstChild("Main"); if m then m.Visible=false end
                end
            end)
            task.wait(.07)
        end
    end)

    _G.KimqV28Loader={Gui=gui,Background=bg,Card=card,Status=status,Bar=bar,Percent=percent}
    task.delay(55,function() if gui and gui.Parent then pcall(function() gui:Destroy() end) end end)
end


-- V27 embedded art + reference-style loader.
do
    local function b64decode(data)
        local ok, out
        if type(crypt) == "table" and type(crypt.base64decode) == "function" then
            ok, out = pcall(crypt.base64decode, data)
            if ok and out then return out end
        end
        if type(crypt) == "table" and type(crypt.base64) == "table" and type(crypt.base64.decode) == "function" then
            ok, out = pcall(crypt.base64.decode, data)
            if ok and out then return out end
        end
        if type(syn) == "table" and type(syn.crypt) == "table" and type(syn.crypt.base64) == "table" and type(syn.crypt.base64.decode) == "function" then
            ok, out = pcall(syn.crypt.base64.decode, data)
            if ok and out then return out end
        end

        local chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
        data = data:gsub("[^" .. chars .. "=]", "")
        return (data:gsub(".", function(x)
            if x == "=" then return "" end
            local r, f = "", (chars:find(x, 1, true) or 1) - 1
            for i = 6, 1, -1 do
                r = r .. ((f % 2^i - f % 2^(i-1) > 0) and "1" or "0")
            end
            return r
        end):gsub("%d%d%d?%d?%d?%d?%d?%d?", function(x)
            if #x ~= 8 then return "" end
            local c = 0
            for i = 1, 8 do
                if x:sub(i,i) == "1" then c = c + 2^(8-i) end
            end
            return string.char(c)
        end))
    end

    local POMP_B64 = [==[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]==]
    local PAW_B64 = [==[iVBORw0KGgoAAAANSUhEUgAAAGAAAABYCAYAAAAKsfL4AAAOi0lEQVR42u1deYydVRX/nffezLS0QEspe6CUpWC1lE1kla1VREGEIqCgIhBUCJAgiEY0wYAaE0ASjKAhQghCAC2LylIBpWXTskOlkJa9YlugC3Rm3vt+/vGdw5zeft9b73szw/QkL+/NzPvucrZ77vmdewdoM5Es6Xs3yc+TvIrkXJJrSD5H8kaSJ5GcZN+3ZyKOoUCyoJ93JHk+yTeZUkKyop8Xkjyd5OY2Zn0XDCciKTppY/4hJGezOr1C8ocke7zgIoylyynABSTfYG2aT/Joe364CmCUfv42yVU6sT7VtsRpX0Ky7CY/l+T0GEJwGrwdyftdH+Ucxick+/VzheTZXojDSQBFff+6m1x/Da2rqFsiyWUkZ/i2WhjDbiTfdmOo1GEBXkAnxrRIdNDnH0hypU6mzPrJvvs+yT29/27E7ZAskpxK8t06FSBvHEtJ7qLjKA4H11Mk2UPyniYnTqelj5IcbWtKA2MokdyA5AMtjME/d6MFB0N6PXBmP1M1qI/NU6++X6UTr2sxdNHOz1pkPt36lJCc1opL7LQFzAs0uZXJryQ5tZ7Jm4BITmM8Mlf0E5vfkGW+vk+KOHkT4J9VsIU6Q87ZQXzPFhWBJJeQHBXbBRXa0NahABixTQI4GsAUEUnyGKCaWSZ5EIDPRhyD9bcJgMkiwkaDgk4L4EQddCWmgQE4Wz/nhYNFESGAWQA2BlCOPL8SgC1j860dAhgV2bslKtB9VPuZo/39JLcEcKAJJLICCIDdYrvumAKo6B5gdJvGuBOAg0WknLUpUu3fQZlUboMA4IQrQ0oAJAsiUlbT3zD2IJUBYwFsU2Pc0TU0EMCEoeyC2kWiGg0AnwwYEi6U09o8r96c/gddAFQ//D6A1bEH6WhcTtuJ9j+5TYw3Ps1369LQEYD636K6oZXt3G7k9J8AGANg/za4P2uPAOYOSQFkhGvtolIoCLcvKDjGS5uEv3QoR0GmFXMGaX1hm9ye0QcAFg7VNcAL4FbdhLVDCys1NLy7jYJ9DsBykiV1uUNOADao13QhjqmR1tb7oQBcauBDt0gystAFwLUiUgncXnsFoNm/tV7VFmKSRRF5D8D1OugkEvO7tL0XcixARKQPwIuRBUDl0WoA8xoMC6UeQRVyHiySFBGhf+nfS/b3Ku3+NmLMbGmAtwE8odpeydkHvBBZAP3Ko9kAFirGXMnbjHq+BDwr5PGsEOZU9MGKavQYkuNJbkxyvIWaaorrNCoiFa1qeBnAHZoOqEQQQAJgkYg8D2C09iMZAngkogAS5c9KANfonDPzUMq3xPHNUMEeXTP837pz0wn6vgHJE7Q6YRnJ5fp6l+T/SF5Ocm8n2e6gHcOE9yH5oQIaMfLy31Tr7MrRPiE5QWHMpEUkzAMxt2sf6yByhj3r5ykkL9SSlqXB6wGSJ5Pc1PMoi/lTHJZbi64luV1Wgw4Y+WWNMpB6wJCE5EuGDVfxudbnBRGgSFOYxSQ3MQFnZGCt5OXyOuf4jOIVAzxzSNZUkq+6wSc5L1/Xs5DkUfr8qCzTJHl3CwwxTPnYTM3JXrvG67iaFXzFlcjMcHMpOF5ZzdOxri863mS9bCyrSR750Xy08XEk/x1Mul7m9JP8mtfCIILaymHEfQ1ovtUIXe4Wf6kReZhWfsUxMmnQ4myM52hbPUEkaJZ2nrOUvjr7MSV8h+QefuCX6h/WNGmqJDkrQwg22G1J/j1wK0kw6NDKSPJ6LSks1Bt7OyFcFGh0Lcb775wbrGcStH1mDg8aUdy/kRwLkpNJvlXnQKuZbC/J6WEBkxv0Ruora03e6EqLIhrZ+ARa+uNgnH0uKCi7n43eIHmMPhsGF6P1/Xgdc28LwYX1eRxIntXiQulN61aNDNbSWB+uarXbXVqdvNq18aGa5qMkP+t9bxO5cXF1oSeSfLnG+JeQvIHkZlkRj4vjt9dIMGmRX+Ya/yokHwewV4QsYlmzlbNE5FaNjStB1lI0dQySWynA8gmkMOZzABaIyEJnOYlLdzeM0ml/lj44W/vbHsAkAO8A+A+AVwHcICKLjPki0p+xP6qQvAUp6F9BJMhTSMbctgPASzrRShbjlDEGYWYxruQ2X2ulOXRjlAQpDnGpaIb96nN0gu8GsBWA5SKywvebNSbH/BkA7nU78yg8iykAT4eIyIOhFWRpqNuNE0BijAo3dp456o/tuX7NA/nvC4CySwWIWmdBf29W0aO/762iECaAfyjgQ0QE/GODJ8a8MwA8WE1THKPzBCTeUkjuCWB3AFMBTNEEXQHACpIvqCtZJCL3BdqfqCD6vT/XsfbpC5b7CoWvVRh7AdhV5xM1zR5bAKYd05SBlayJ1RlKUjVvPwDnAzgIA1UJIX3ZhEnyIQCPA/iViCwzppvAQwurM1l5HIBNVYhxD2tEytOEsfxqkl+stXutEcePJXlZECn1asRVDl59rpra6L8kz3AhaaNnDGzjNVp38zHyS+vwqxAZlLESkg3UXTRkZWryFT2wdyeAH2hbZXUZ3dpeMXh16d/ovruZpsVvJrm11pU25LvVcsdp5BTd/QCQAoCn2gBiVPu5GvPLJCcDuA/AwcpMugW0HgWw71okdQyA2SQnq3CLDbqfrQHs6NLTMXn0VgHAX4IFNIYVAGmZSF3tWmWdboTm6IRtXyEtjKOgfntPANeTnNiEOxqtFpbEDD/1dXsBwF1tWIhtY1Zzc2fxPcktANyjm6RyxAChS9vbH8DvDUxqglmxSQDcVdAd6Bz1peWIQlhTz0KHgYKuywBM17A0dnRW0na/RPLnam3dDTAqpu83BXgIwLyCiKxUzLMSSdKFBgZcEpE+kmcCOMVhsO0gw5IvJDlT++2qw5LfVViyFIk/1HHcKCIrLeE1RtEaRkgyWb57ug8rqyBYB7BzZGHrEwq9lvLWA5c8HK8JwlZ54/nzsG4IuyxhtRrARXmVEk0A6ItF5Km8VISaf6IY6W/C3E8byZRhLwCXqesr5oWguod5D8CzkQIV8wznmTVZ9NEjIncDuES/1N+CmRcA3ORyPVmaZYmziy1xh86VMlqlxvdI7ici/VU2i7aLn+3WJjapmGWd97ki8sRHa66/WEPRp9sCXLhR83qR5IZ1gOezIoDnrbqCF3XH3V3j8B8Uw2jGDVXcHC/1eANJ8VtuA9E3d5UR9QIPZSesw/JSEK76YjuSizJgyU6S3Rvx/RBKDces/NmZ5AcNKE2YurjEneKXrJyHOGmP1hPqYQ4myZBur+vwYqsVytIo/X0XyTkRDnLHyFuVFYnbp5YQXBXEaseTco7G++KD9xzG3LXOop9R/+nLL75F8qkcDNgzbxHJk0P4MejH7gH6aYOVBJ1wRfeacvgIKAcTPsBVkHhMO+RJP8k/ktzFV1dUy/qJY7wHtieSPE0LsVYFE3iI5Dkkd6oRclp1wf56C0r/EGB+CJBfkQXGB3wqudD0OyT/lNHeP7VC7vDA8otZBbvr/mJtOK8UIFHbAuhxX1+iG7lMLDVAlHZAWrs5MTKsF2NjlGhUcoKI3KxRYW81hMwJaxt91ubkeVLKCrE9j+u9faSoWGtSDcPNQJTs2R7deu8RE9COLAQCWA7gcBF5mmS3hzqz5pWlcFkwqq+YztsY1A1S5OTMc8M3je9/p6mGoch8D6cWADyj6NsK3SdVYvGkc+qULuRj1O9dkRGqDlWy9eABRr48sJPMt0LWAslfB1e+DAeysPoerZmVBjKng898fR9F8rqgCmw4kVnCIxp4tO2mLInI/C718aMB3Abgc5FhvE6TgUILAJwkIk/mFW8NugBc4m0c0mOqB0dGtQaLrAzlFQBHi8jzsYUgEZhvTO4GcAuAIzFwXYxg+JNFbgsAHCgiS32dUQyUqOX0rmrELxzzSx8T5vv09S5IS1x6dANbGHQBqDn2kjwBwFnq80v4+FER6bHbQwFc7XbOg+eCnAbsBOBfSC9UGs6Lbr0pi34AXxWRO2KsB4UWtUKQQpljEf+SvKFGVmc0CsC1JMciAkhfaFL7LQ/yaQDfGOIphthCsLLHH2mSsdRxF+Rw3TsBHIGBOxVGAlmF3DKkxV4va/4n6YgFuHLzKQC+gLUPWYwEsvqiTQGcqowvdtIFGWx3BtY9LjRSyKo6jtK7SpNmw9JmHqpo2uFQDFQhjzSyEza7ApikKWtpuwAcGvQZDNxQWMDIJQKYoWtiR9YA+/5kpAcnkhHMfMt/Ha9pGOmEAIx212fLH6OUQ7MR5AQMYMJtFwCDzgXraSKACc1ea9+sBXA939faF2w0GKmI9RTBCzQrgK71fP+I+pBeKNiUZyg0Ke03MbSKqwYrBIWmJFY3cyC9lUX4MaRnwGId2xmuAiDSI7VNR4ONCsAOOz8GYLFbhEbq4isAburYTlgTTwURWQXg4RHshiwBtwjAS3n/26Zdi7AhQJdi5GVCjUzj/yAiryE97dmZdLRtOERkMVIg3gtlJFBZo8BnAVzp6qE6F8PaXT5IryO4H8De6EwdEJF9cl3Qnss0svoXAKsAzBSRR/LK8tu6D9BwywbyXaRHOUuIe9K+krHAm+DD21KyTmQmiHf4HC7SWQHgFGV+N9L/3icdtQBnCXb4YncNxyZgAJxvVLgVF1mUMjY7/Rp5zQXwtAodSG8z2RvpNQdbID2L0J3TdrGZyE+f70J6fuBUEZmt9UF9gVJ2VgAqhFEisobkjkj/b8C+TmOqVccxeHmmrwDwPNKSwNuQ/l+A15AeAsk7udKjfU1Ceq3ZTACfQgqajMvQ5FoBhFmhjWs+gNNFZH61wxsdF4BOvksPPBcBnAPgNJ14I/QkgEdVy+eJyMNBH6Ug7A3dE3NuadxXLWRnpCD69AbHtQDANQCu1iK0oVUb6iZaMCaQ3AbAYUjv2Dwi0DRj4uvqTuYhvTRqoYgsCRjuF9eKnuqXaiZv12Kq9SV+gdS7SndAWk5zAFJYdaOMsa1BeqTqOlWG1608vdaJmUbp/05pieldzzfXAAAAAElFTkSuQmCC]==]

    local function installAsset(filename, data)
        if type(writefile) ~= "function" then return nil end
        pcall(function()
            local need = true
            if type(isfile) == "function" then
                local ok, exists = pcall(isfile, filename)
                if ok and exists then need = false end
            end
            if need then writefile(filename, b64decode(data)) end
        end)
        local fn = (type(getcustomasset) == "function" and getcustomasset) or (type(getsynasset) == "function" and getsynasset)
        if fn then
            local ok, asset = pcall(fn, filename)
            if ok then return asset end
        end
        return nil
    end

    _G.KimqV27PompomAsset = installAsset("KimqV27_PompomBlue.png", POMP_B64)
    _G.KimqV27PawAsset = installAsset("KimqV27_Paw.png", PAW_B64)
end

do
    local Players = game:GetService("Players")
    local CoreGui = game:GetService("CoreGui")
    local TweenService = game:GetService("TweenService")
    local lp = Players.LocalPlayer
    local pg = lp:WaitForChild("PlayerGui")

    pcall(function()
        for _, root in ipairs({CoreGui, pg}) do
            for _, name in ipairs({
                "KimqV27ReferenceLoader","KimqV26PompomLoader","KimqV25CanvaLoader",
                "KimqV24CuteLoader","KimqV23DreamyLoader","KimqV22CuteLoader",
                "KimqV21CuteLoader","KimpetrasHC_Boot","KimqV4Loader","KimpetrasHC_Loading"
            }) do
                local old = root:FindFirstChild(name)
                if old then old:Destroy() end
            end
        end
    end)

    local gui = Instance.new("ScreenGui")
    gui.Name = "KimqV27ReferenceLoader"
    gui.IgnoreGuiInset = true
    gui.ResetOnSpawn = false
    gui.DisplayOrder = 5000000
    pcall(function() gui.Parent = CoreGui end)
    if not gui.Parent then gui.Parent = pg end

    local bg = Instance.new("Frame", gui)
    bg.Name = "Background"
    bg.Size = UDim2.fromScale(1,1)
    bg.BackgroundColor3 = Color3.fromRGB(214,231,255)
    bg.BackgroundTransparency = .05
    bg.BorderSizePixel = 0
    local bgGrad = Instance.new("UIGradient", bg)
    bgGrad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(238,247,255)),
        ColorSequenceKeypoint.new(.5, Color3.fromRGB(209,229,255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(166,202,255))
    })
    bgGrad.Rotation = 24

    local function corner(o,r)
        local c=Instance.new("UICorner",o); c.CornerRadius=UDim.new(0,r); return c
    end
    local function stroke(o,c,t,w)
        local s=Instance.new("UIStroke",o); s.Color=c; s.Transparency=t or 0; s.Thickness=w or 1; return s
    end
    local function lbl(p,txt,size,pos,font,ts,color,align)
        local x=Instance.new("TextLabel",p); x.Size=size; x.Position=pos; x.BackgroundTransparency=1
        x.Text=txt; x.Font=font; x.TextSize=ts; x.TextColor3=color
        x.TextXAlignment=align or Enum.TextXAlignment.Left; x.TextYAlignment=Enum.TextYAlignment.Center
        return x
    end
    local function img(p,asset,size,pos,z,color)
        if not asset then return nil end
        local x=Instance.new("ImageLabel",p); x.Size=size; x.Position=pos; x.BackgroundTransparency=1; x.Image=asset
        x.ScaleType=Enum.ScaleType.Fit; x.ZIndex=z or 3
        if color then x.ImageColor3=color end
        return x
    end
    local function dashLine(parent,y,x0,x1,color,z)
        local holder=Instance.new("Frame",parent); holder.BackgroundTransparency=1
        holder.Position=UDim2.new(0,x0,0,y); holder.Size=UDim2.new(1,-x0-x1,0,4); holder.ZIndex=z or 3
        for i=0,17 do
            local d=Instance.new("Frame",holder); d.BorderSizePixel=0; d.BackgroundColor3=color; d.BackgroundTransparency=.32
            d.Size=UDim2.fromOffset(13,2); d.Position=UDim2.new(i/18,0,.5,-1); d.ZIndex=holder.ZIndex
            corner(d,2)
        end
        return holder
    end

    -- Very soft decorative paws on the outer background.
    if _G.KimqV27PawAsset then
        local deco = {
            {.06,.16,54,-18,.78},{.93,.18,48,16,.82},{.08,.78,44,12,.84},
            {.91,.80,58,-10,.80},{.19,.90,34,-22,.88},{.82,.91,36,20,.88}
        }
        for _,d in ipairs(deco) do
            local p=img(bg,_G.KimqV27PawAsset,UDim2.fromOffset(d[3],d[3]),UDim2.new(d[1],-d[3]/2,d[2],-d[3]/2),2,Color3.fromRGB(78,128,232))
            if p then p.Rotation=d[4]; p.ImageTransparency=d[5] end
        end
    end

    local card = Instance.new("Frame", bg)
    card.Name = "Card"
    card.AnchorPoint = Vector2.new(.5,.5)
    card.Position = UDim2.fromScale(.5,.5)
    card.Size = UDim2.fromOffset(700,470)
    card.BackgroundColor3 = Color3.fromRGB(255,252,244)
    card.BackgroundTransparency = .02
    card.BorderSizePixel = 0
    card.ClipsDescendants = false
    corner(card,28)
    stroke(card,Color3.fromRGB(61,116,240),.12,2)

    -- Stitching has a dedicated margin and never crosses the content.
    local stitch = Instance.new("Frame",card)
    stitch.Name="StitchMargin"; stitch.Size=UDim2.new(1,-28,1,-28); stitch.Position=UDim2.fromOffset(14,14)
    stitch.BackgroundTransparency=1; stitch.ZIndex=2
    for i=0,29 do
        for _,yy in ipairs({0,1}) do
            local d=Instance.new("Frame",stitch); d.Size=UDim2.fromOffset(12,2); d.AnchorPoint=Vector2.new(.5,.5)
            d.Position=UDim2.new(i/29,0,yy,0); d.BackgroundColor3=Color3.fromRGB(91,145,236); d.BackgroundTransparency=.38; d.BorderSizePixel=0
            corner(d,2)
        end
    end
    for i=0,18 do
        for _,xx in ipairs({0,1}) do
            local d=Instance.new("Frame",stitch); d.Size=UDim2.fromOffset(2,12); d.AnchorPoint=Vector2.new(.5,.5)
            d.Position=UDim2.new(xx,0,i/18,0); d.BackgroundColor3=Color3.fromRGB(91,145,236); d.BackgroundTransparency=.38; d.BorderSizePixel=0
            corner(d,2)
        end
    end

    local mascot = img(card,_G.KimqV27PompomAsset,UDim2.fromOffset(150,138),UDim2.fromOffset(36,24),7)
    if mascot then
        mascot.Name="Pompom"
    end

    local title = lbl(card,"Kimqetras HC",UDim2.new(1,-245,0,46),UDim2.fromOffset(190,52),Enum.Font.FredokaOne,38,Color3.fromRGB(43,85,169))
    local sub = lbl(card,"made cute, clean, and organized ♡",UDim2.new(1,-245,0,22),UDim2.fromOffset(192,98),Enum.Font.GothamSemibold,13,Color3.fromRGB(102,130,183))
    dashLine(card,132,190,36,Color3.fromRGB(109,157,226),4)

    local profile = Instance.new("Frame",card)
    profile.Size=UDim2.fromOffset(206,58); profile.Position=UDim2.new(1,-232,0,34); profile.BackgroundColor3=Color3.fromRGB(244,249,255); profile.BorderSizePixel=0
    corner(profile,16); stroke(profile,Color3.fromRGB(145,186,238),.28,1)
    local av=Instance.new("ImageLabel",profile); av.Size=UDim2.fromOffset(42,42); av.Position=UDim2.fromOffset(8,8); av.BackgroundColor3=Color3.fromRGB(222,237,255); av.BorderSizePixel=0; corner(av,999)
    pcall(function() av.Image=Players:GetUserThumbnailAsync(lp.UserId,Enum.ThumbnailType.HeadShot,Enum.ThumbnailSize.Size100x100) end)
    lbl(profile,lp.DisplayName,UDim2.new(1,-62,0,20),UDim2.fromOffset(58,8),Enum.Font.FredokaOne,14,Color3.fromRGB(52,80,137))
    lbl(profile,"@"..lp.Name,UDim2.new(1,-62,0,18),UDim2.fromOffset(58,29),Enum.Font.Gotham,10,Color3.fromRGB(103,126,171))

    local loadBox=Instance.new("Frame",card)
    loadBox.Size=UDim2.new(1,-76,0,206); loadBox.Position=UDim2.fromOffset(38,154); loadBox.BackgroundColor3=Color3.fromRGB(250,252,255); loadBox.BorderSizePixel=0
    corner(loadBox,20); stroke(loadBox,Color3.fromRGB(155,192,235),.28,1)
    local pawHead=img(loadBox,_G.KimqV27PawAsset,UDim2.fromOffset(28,26),UDim2.fromOffset(20,16),4,Color3.fromRGB(61,116,240))
    lbl(loadBox,"loading Kimqetras HC",UDim2.new(1,-72,0,28),UDim2.fromOffset(56,14),Enum.Font.FredokaOne,21,Color3.fromRGB(52,88,163))
    dashLine(loadBox,48,18,18,Color3.fromRGB(116,164,227),3)

    local status=lbl(loadBox,"getting everything ready...",UDim2.new(1,-40,0,24),UDim2.fromOffset(20,68),Enum.Font.GothamSemibold,13,Color3.fromRGB(91,116,166),Enum.TextXAlignment.Center)
    local track=Instance.new("Frame",loadBox); track.Size=UDim2.new(1,-70,0,18); track.Position=UDim2.fromOffset(24,104); track.BackgroundColor3=Color3.fromRGB(222,235,251); track.BorderSizePixel=0; corner(track,999)
    local bar=Instance.new("Frame",track); bar.Name="Bar"; bar.Size=UDim2.new(.05,0,1,0); bar.BackgroundColor3=Color3.fromRGB(61,116,240); bar.BorderSizePixel=0; corner(bar,999)
    local g=Instance.new("UIGradient",bar); g.Color=ColorSequence.new(Color3.fromRGB(101,166,255),Color3.fromRGB(44,93,228))
    local percent=lbl(track,"5%",UDim2.fromOffset(48,18),UDim2.new(1,-52,0,0),Enum.Font.GothamBold,11,Color3.fromRGB(36,82,183),Enum.TextXAlignment.Right)
    percent.ZIndex=4

    local chips={"clean","organized","safe","cute"}
    for i,name in ipairs(chips) do
        local x=25+(i-1)*151
        local chip=Instance.new("Frame",loadBox); chip.Size=UDim2.fromOffset(134,46); chip.Position=UDim2.fromOffset(x,140); chip.BackgroundColor3=Color3.fromRGB(245,249,255); chip.BorderSizePixel=0
        corner(chip,12); stroke(chip,Color3.fromRGB(170,201,240),.34,1)
        local pi=img(chip,_G.KimqV27PawAsset,UDim2.fromOffset(20,18),UDim2.fromOffset(12,14),4,Color3.fromRGB(77,130,230))
        lbl(chip,name,UDim2.new(1,-42,1,0),UDim2.fromOffset(38,0),Enum.Font.GothamBold,11,Color3.fromRGB(65,98,165))
    end

    local footer=Instance.new("Frame",card); footer.Size=UDim2.fromOffset(250,42); footer.AnchorPoint=Vector2.new(.5,1); footer.Position=UDim2.new(.5,0,1,-26); footer.BackgroundColor3=Color3.fromRGB(240,247,255); footer.BorderSizePixel=0
    corner(footer,14); stroke(footer,Color3.fromRGB(145,186,238),.28,1)
    img(footer,_G.KimqV27PawAsset,UDim2.fromOffset(22,20),UDim2.fromOffset(16,11),4,Color3.fromRGB(70,122,226))
    lbl(footer,"made with love ♡",UDim2.new(1,-52,1,0),UDim2.fromOffset(43,0),Enum.Font.FredokaOne,14,Color3.fromRGB(63,103,188),Enum.TextXAlignment.Center)

    local steps={
        {"loading your profile...",.16,1.0},{"organizing the pages...",.30,1.2},{"matching your theme recolors...",.45,1.2},
        {"building the stitched layout...",.60,1.25},{"placing the real paw art...",.74,1.15},{"setting up the mascot...",.86,1.1},
        {"polishing everything...",.96,1.0}
    }
    task.spawn(function()
        for _,s in ipairs(steps) do
            if not gui.Parent or _G.KimqV27Ready then break end
            status.Text=s[1]
            TweenService:Create(bar,TweenInfo.new(.45,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{Size=UDim2.new(s[2],0,1,0)}):Play()
            TweenService:Create(percent,TweenInfo.new(.1),{}):Play()
            percent.Text=tostring(math.floor(s[2]*100)).."%"
            task.wait(s[3])
        end
    end)

    task.spawn(function()
        while gui.Parent and not _G.KimqV27Ready do
            pcall(function()
                for _,root in ipairs({CoreGui,pg}) do
                    for _,name in ipairs({
                        "KimqV26PompomLoader","KimqV25CanvaLoader","KimqV24CuteLoader","KimqV23DreamyLoader",
                        "KimqV22CuteLoader","KimqV21CuteLoader","KimpetrasHC_Boot","KimqV4Loader","KimpetrasHC_Loading"
                    }) do
                        local old=root:FindFirstChild(name)
                        if old and old~=gui then old:Destroy() end
                    end
                    local r=root:FindFirstChild("KimpetrasHC")
                    local m=r and r:FindFirstChild("Main")
                    if m then m.Visible=false end
                end
            end)
            task.wait(.08)
        end
    end)

    _G.KimqV27Loader={Gui=gui,Background=bg,Card=card,Status=status,Bar=bar,Percent=percent}
    task.delay(45,function() if gui and gui.Parent then pcall(function() gui:Destroy() end) end end)
end


-- V22 cute boot cover: hides every legacy build until the final V22 pages are ready.
do
    local Players = game:GetService("Players")
    local CoreGui = game:GetService("CoreGui")
    local TweenService = game:GetService("TweenService")
    local lp = Players.LocalPlayer
    local pg = lp:WaitForChild("PlayerGui")

    pcall(function()
        for _, root in ipairs({CoreGui, pg}) do
            for _, n in ipairs({"KimqV24CuteLoader", "KimqV22CuteLoader", "KimqV21CuteLoader", "KimpetrasHC_Boot", "KimqV4Loader"}) do
                local x = root:FindFirstChild(n)
                if x then x:Destroy() end
            end
        end
    end)

    local gui = Instance.new("ScreenGui")
    gui.Name = "KimqV24CuteLoader"
    gui.IgnoreGuiInset = true
    gui.ResetOnSpawn = false
    gui.DisplayOrder = 2000000
    pcall(function() gui.Parent = CoreGui end)
    if not gui.Parent then gui.Parent = pg end

    local bg = Instance.new("Frame", gui)
    bg.Name = "Background"
    bg.Size = UDim2.fromScale(1, 1)
    bg.BackgroundColor3 = Color3.fromRGB(198, 226, 255)
    bg.BorderSizePixel = 0
    local bgGrad = Instance.new("UIGradient", bg)
    bgGrad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(221, 239, 255)),
        ColorSequenceKeypoint.new(.48, Color3.fromRGB(184, 218, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(139, 183, 255)),
    })
    bgGrad.Rotation = 20

    -- soft cloud bubbles behind the center sticker
    local bubbleData = {
        {-.22,-.16,170,.17}, {-.10,-.22,120,.22}, {.14,-.18,155,.18}, {.24,-.06,115,.24},
        {-.24,.10,130,.24}, {.22,.15,165,.19}, {.02,.22,110,.28}
    }
    for _, d in ipairs(bubbleData) do
        local b = Instance.new("Frame", bg)
        b.AnchorPoint = Vector2.new(.5,.5)
        b.Position = UDim2.new(.5+d[1],0,.5+d[2],0)
        b.Size = UDim2.fromOffset(d[3],d[3])
        b.BackgroundColor3 = Color3.fromRGB(245, 251, 255)
        b.BackgroundTransparency = d[4]
        b.BorderSizePixel = 0
        Instance.new("UICorner", b).CornerRadius = UDim.new(1,0)
    end

    local sticker = Instance.new("Frame", bg)
    sticker.Name = "Sticker"
    sticker.AnchorPoint = Vector2.new(.5,.5)
    sticker.Position = UDim2.fromScale(.5,.5)
    sticker.Size = UDim2.fromOffset(450, 390)
    sticker.BackgroundColor3 = Color3.fromRGB(244, 250, 255)
    sticker.BackgroundTransparency = .06
    sticker.BorderSizePixel = 0
    Instance.new("UICorner", sticker).CornerRadius = UDim.new(0, 42)
    local st = Instance.new("UIStroke", sticker)
    st.Color = Color3.fromRGB(76, 126, 255)
    st.Thickness = 2
    st.Transparency = .28

    local bow = Instance.new("TextLabel", sticker)
    bow.Size = UDim2.new(1,0,0,34)
    bow.Position = UDim2.fromOffset(0,20)
    bow.BackgroundTransparency = 1
    bow.Text = "♡  KIMQETRAS  ♡"
    bow.TextColor3 = Color3.fromRGB(72, 111, 205)
    bow.Font = Enum.Font.FredokaOne
    bow.TextSize = 16
    bow.TextXAlignment = Enum.TextXAlignment.Center

    local avatarRing = Instance.new("Frame", sticker)
    avatarRing.AnchorPoint = Vector2.new(.5,0)
    avatarRing.Position = UDim2.new(.5,0,0,62)
    avatarRing.Size = UDim2.fromOffset(120,120)
    avatarRing.BackgroundColor3 = Color3.fromRGB(160, 202, 255)
    avatarRing.BorderSizePixel = 0
    Instance.new("UICorner", avatarRing).CornerRadius = UDim.new(1,0)
    local arGrad = Instance.new("UIGradient", avatarRing)
    arGrad.Color = ColorSequence.new(Color3.fromRGB(174,215,255), Color3.fromRGB(78,125,255))
    arGrad.Rotation = 35

    local avatar = Instance.new("ImageLabel", avatarRing)
    avatar.AnchorPoint = Vector2.new(.5,.5)
    avatar.Position = UDim2.fromScale(.5,.5)
    avatar.Size = UDim2.fromOffset(104,104)
    avatar.BackgroundColor3 = Color3.fromRGB(235,246,255)
    avatar.BorderSizePixel = 0
    Instance.new("UICorner", avatar).CornerRadius = UDim.new(1,0)
    pcall(function()
        avatar.Image = Players:GetUserThumbnailAsync(lp.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size180x180)
    end)

    local heartSpecs = {
        {"♥", .19,.30,25}, {"♡", .81,.29,29}, {"♥", .12,.53,20}, {"♡", .87,.56,23},
        {"♡", .27,.68,19}, {"♥", .73,.70,21}
    }
    local hearts = {}
    for _, h in ipairs(heartSpecs) do
        local l = Instance.new("TextLabel", sticker)
        l.AnchorPoint = Vector2.new(.5,.5)
        l.Position = UDim2.new(h[2],0,h[3],0)
        l.Size = UDim2.fromOffset(38,38)
        l.BackgroundTransparency = 1
        l.Text = h[1]
        l.TextColor3 = Color3.fromRGB(76,126,255)
        l.TextTransparency = .08
        l.Font = Enum.Font.FredokaOne
        l.TextSize = h[4]
        l.TextXAlignment = Enum.TextXAlignment.Center
        table.insert(hearts,l)
    end

    local title = Instance.new("TextLabel", sticker)
    title.Size = UDim2.new(1,-36,0,44)
    title.Position = UDim2.fromOffset(18,198)
    title.BackgroundTransparency = 1
    title.Text = "Kimqetras HC"
    title.TextColor3 = Color3.fromRGB(47,80,160)
    title.Font = Enum.Font.FredokaOne
    title.TextSize = 35
    title.TextXAlignment = Enum.TextXAlignment.Center

    local welcome = Instance.new("TextLabel", sticker)
    welcome.Size = UDim2.new(1,-36,0,24)
    welcome.Position = UDim2.fromOffset(18,243)
    welcome.BackgroundTransparency = 1
    welcome.Text = "welcome, " .. string.lower(lp.DisplayName) .. " ♡"
    welcome.TextColor3 = Color3.fromRGB(77,104,159)
    welcome.Font = Enum.Font.GothamSemibold
    welcome.TextSize = 13
    welcome.TextXAlignment = Enum.TextXAlignment.Center

    local dash = Instance.new("TextLabel", sticker)
    dash.Size = UDim2.new(1,-80,0,18)
    dash.Position = UDim2.fromOffset(40,275)
    dash.BackgroundTransparency = 1
    dash.Text = "-   -   -   -   -   -   -   -"
    dash.TextColor3 = Color3.fromRGB(105,150,224)
    dash.Font = Enum.Font.GothamBold
    dash.TextSize = 14
    dash.TextXAlignment = Enum.TextXAlignment.Center

    local status = Instance.new("TextLabel", sticker)
    status.Name = "Status"
    status.Size = UDim2.new(1,-40,0,22)
    status.Position = UDim2.fromOffset(20,299)
    status.BackgroundTransparency = 1
    status.Text = "putting the cute stuff together..."
    status.TextColor3 = Color3.fromRGB(62,91,154)
    status.Font = Enum.Font.GothamSemibold
    status.TextSize = 12
    status.TextXAlignment = Enum.TextXAlignment.Center

    local track = Instance.new("Frame", sticker)
    track.Size = UDim2.new(1,-90,0,10)
    track.Position = UDim2.new(0,45,1,-42)
    track.BackgroundColor3 = Color3.fromRGB(207,228,252)
    track.BorderSizePixel = 0
    Instance.new("UICorner", track).CornerRadius = UDim.new(1,0)

    local bar = Instance.new("Frame", track)
    bar.Name = "Bar"
    bar.Size = UDim2.new(.05,0,1,0)
    bar.BackgroundColor3 = Color3.fromRGB(66,112,255)
    bar.BorderSizePixel = 0
    Instance.new("UICorner", bar).CornerRadius = UDim.new(1,0)

    local tip = Instance.new("TextLabel", track)
    tip.Name = "TipHeart"
    tip.AnchorPoint = Vector2.new(.5,.5)
    tip.Size = UDim2.fromOffset(26,26)
    tip.Position = UDim2.new(.05,0,.5,0)
    tip.BackgroundTransparency = 1
    tip.Text = "♥"
    tip.TextColor3 = Color3.fromRGB(45,90,243)
    tip.Font = Enum.Font.FredokaOne
    tip.TextSize = 18

    local scale = Instance.new("UIScale", avatarRing)
    task.spawn(function()
        local phase = false
        while gui.Parent do
            phase = not phase
            TweenService:Create(scale, TweenInfo.new(.85,Enum.EasingStyle.Sine,Enum.EasingDirection.InOut), {Scale = phase and 1.035 or 1}):Play()
            for i,h in ipairs(hearts) do
                local p = h.Position
                TweenService:Create(h, TweenInfo.new(1.0,Enum.EasingStyle.Sine,Enum.EasingDirection.InOut), {
                    Position = UDim2.new(p.X.Scale,p.X.Offset,p.Y.Scale,p.Y.Offset + (phase and -3 or 3)),
                    TextTransparency = phase and .02 or .14,
                }):Play()
                task.wait(.025)
            end
            task.wait(.82)
        end
    end)

    -- Keep old/unfinished GUIs hidden behind this cover and kill legacy loading overlays.
    task.spawn(function()
        while gui.Parent and not _G.KimqV24Ready do
            pcall(function()
                for _, root in ipairs({CoreGui, pg}) do
                    for _, n in ipairs({"KimqV22CuteLoader","KimqV21CuteLoader","KimpetrasHC_Boot","KimqV4Loader","KimpetrasHC_Loading"}) do
                        local x = root:FindFirstChild(n)
                        if x and x ~= gui then x:Destroy() end
                    end
                    local r = root:FindFirstChild("KimpetrasHC")
                    local m = r and r:FindFirstChild("Main")
                    if m then m.Visible = false end
                end
            end)
            task.wait(.08)
        end
    end)

    -- Give the long legacy merge a cute, gradual progress animation while it finishes behind the cover.
    local steps = {
        {"loading your profile...",.16,1.0},
        {"organizing the feature pages...",.31,1.7},
        {"matching your theme...",.46,1.8},
        {"setting up seasonal effects...",.61,1.8},
        {"finding weapon wraps...",.76,1.9},
        {"adding the finishing hearts...",.88,1.7},
    }
    task.spawn(function()
        for _,s in ipairs(steps) do
            if not gui.Parent or _G.KimqV24Ready then break end
            status.Text = s[1]
            TweenService:Create(bar,TweenInfo.new(.45,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{Size=UDim2.new(s[2],0,1,0)}):Play()
            TweenService:Create(tip,TweenInfo.new(.45,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{Position=UDim2.new(s[2],0,.5,0)}):Play()
            task.wait(s[3])
        end
    end)

    _G.KimqV24Loader = {Gui=gui,Status=status,Bar=bar,Tip=tip,Background=bg,Sticker=sticker}
    task.delay(32,function() if gui and gui.Parent then pcall(function() gui:Destroy() end) end end)
end

-- V21 cute cover loader. It sits above all legacy loaders so no half-built GUI flashes.
do
    local Players = game:GetService("Players")
    local CoreGui = game:GetService("CoreGui")
    local TweenService = game:GetService("TweenService")
    local lp = Players.LocalPlayer
    local pg = lp:WaitForChild("PlayerGui")

    pcall(function()
        local old = CoreGui:FindFirstChild("KimqV21CuteLoader") or pg:FindFirstChild("KimqV21CuteLoader")
        if old then old:Destroy() end
    end)

    local g = Instance.new("ScreenGui")
    g.Name = "KimqV21CuteLoader"
    g.IgnoreGuiInset = true
    g.ResetOnSpawn = false
    g.DisplayOrder = 1000001
    pcall(function() g.Parent = CoreGui end)
    if not g.Parent then g.Parent = pg end

    local shade = Instance.new("Frame", g)
    shade.Size = UDim2.fromScale(1,1)
    shade.BackgroundColor3 = Color3.fromRGB(184,219,255)
    shade.BackgroundTransparency = 0.10
    shade.BorderSizePixel = 0

    local panel = Instance.new("Frame", shade)
    panel.AnchorPoint = Vector2.new(.5,.5)
    panel.Position = UDim2.fromScale(.5,.5)
    panel.Size = UDim2.fromOffset(560,350)
    panel.BackgroundColor3 = Color3.fromRGB(229,242,255)
    panel.BorderSizePixel = 0
    Instance.new("UICorner", panel).CornerRadius = UDim.new(0,28)
    local pst = Instance.new("UIStroke", panel)
    pst.Color = Color3.fromRGB(52,101,255)
    pst.Thickness = 2
    pst.Transparency = .22

    local banner = Instance.new("Frame", panel)
    banner.Size = UDim2.new(1,-28,0,108)
    banner.Position = UDim2.fromOffset(14,14)
    banner.BackgroundColor3 = Color3.fromRGB(166,207,255)
    banner.BorderSizePixel = 0
    Instance.new("UICorner", banner).CornerRadius = UDim.new(0,20)
    local grad = Instance.new("UIGradient", banner)
    grad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(181,219,255)),
        ColorSequenceKeypoint.new(.52, Color3.fromRGB(103,157,255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(52,94,255)),
    })
    grad.Rotation = 8

    local function heart(x,y,size,filled)
        local h=Instance.new("TextLabel",banner)
        h.Size=UDim2.fromOffset(42,42)
        h.Position=UDim2.new(x,-21,y,-21)
        h.BackgroundTransparency=1
        h.Text=filled and "♥" or "♡"
        h.TextColor3=Color3.fromRGB(250,253,255)
        h.TextTransparency=.05
        h.Font=Enum.Font.FredokaOne
        h.TextSize=size
        h.TextXAlignment=Enum.TextXAlignment.Center
        return h
    end
    local hearts={
        heart(.09,.30,28,true), heart(.26,.68,22,false), heart(.43,.24,33,false),
        heart(.63,.68,27,true), heart(.83,.28,28,false), heart(.92,.65,20,true)
    }
    local big=Instance.new("TextLabel",banner)
    big.Size=UDim2.new(1,0,0,48); big.Position=UDim2.new(0,0,.5,-29); big.BackgroundTransparency=1
    big.Text="Kimqetras HC"; big.TextColor3=Color3.fromRGB(250,253,255); big.Font=Enum.Font.FredokaOne; big.TextSize=35; big.TextXAlignment=Enum.TextXAlignment.Center
    local tiny=Instance.new("TextLabel",banner)
    tiny.Size=UDim2.new(1,0,0,18); tiny.Position=UDim2.new(0,0,.5,15); tiny.BackgroundTransparency=1
    tiny.Text="♡  cute controls • clean pages • local visuals  ♡"; tiny.TextColor3=Color3.fromRGB(247,252,255); tiny.Font=Enum.Font.GothamSemibold; tiny.TextSize=11; tiny.TextXAlignment=Enum.TextXAlignment.Center

    local avatar=Instance.new("ImageLabel",panel)
    avatar.Size=UDim2.fromOffset(82,82); avatar.Position=UDim2.new(.5,-178,0,150); avatar.BackgroundColor3=Color3.fromRGB(211,230,255); avatar.BorderSizePixel=0
    Instance.new("UICorner",avatar).CornerRadius=UDim.new(1,0)
    local ast=Instance.new("UIStroke",avatar); ast.Color=Color3.fromRGB(88,137,255); ast.Transparency=.25; ast.Thickness=2
    pcall(function() avatar.Image=Players:GetUserThumbnailAsync(lp.UserId,Enum.ThumbnailType.HeadShot,Enum.ThumbnailSize.Size180x180) end)

    local welcome=Instance.new("TextLabel",panel)
    welcome.Size=UDim2.new(0,330,0,34); welcome.Position=UDim2.new(.5,-82,0,157); welcome.BackgroundTransparency=1
    welcome.Text="welcome, "..string.lower(lp.DisplayName); welcome.TextColor3=Color3.fromRGB(46,78,146); welcome.Font=Enum.Font.FredokaOne; welcome.TextSize=26; welcome.TextXAlignment=Enum.TextXAlignment.Left
    local user=Instance.new("TextLabel",panel)
    user.Size=UDim2.new(0,330,0,20); user.Position=UDim2.new(.5,-80,0,192); user.BackgroundTransparency=1
    user.Text="@"..lp.Name.."   •   loading your pages ♡"; user.TextColor3=Color3.fromRGB(99,128,181); user.Font=Enum.Font.GothamSemibold; user.TextSize=12; user.TextXAlignment=Enum.TextXAlignment.Left

    local dashes=Instance.new("TextLabel",panel)
    dashes.Size=UDim2.new(1,-80,0,18); dashes.Position=UDim2.fromOffset(40,242); dashes.BackgroundTransparency=1
    dashes.Text="-   -   -   -   -   -   -   -   -"; dashes.TextColor3=Color3.fromRGB(100,148,225); dashes.Font=Enum.Font.GothamBold; dashes.TextSize=14; dashes.TextXAlignment=Enum.TextXAlignment.Center

    local status=Instance.new("TextLabel",panel)
    status.Name="Status"; status.Size=UDim2.new(1,-50,0,22); status.Position=UDim2.fromOffset(25,268); status.BackgroundTransparency=1
    status.Text="getting Kimqetras HC ready..."; status.TextColor3=Color3.fromRGB(55,86,150); status.Font=Enum.Font.GothamSemibold; status.TextSize=13; status.TextXAlignment=Enum.TextXAlignment.Center

    local back=Instance.new("Frame",panel)
    back.Size=UDim2.new(1,-100,0,9); back.Position=UDim2.new(0,50,1,-36); back.BackgroundColor3=Color3.fromRGB(196,221,253); back.BorderSizePixel=0
    Instance.new("UICorner",back).CornerRadius=UDim.new(1,0)
    local bar=Instance.new("Frame",back)
    bar.Name="Bar"; bar.Size=UDim2.new(.08,0,1,0); bar.BackgroundColor3=Color3.fromRGB(52,94,255); bar.BorderSizePixel=0
    Instance.new("UICorner",bar).CornerRadius=UDim.new(1,0)

    task.spawn(function()
        local up=false
        while g.Parent do
            up=not up
            for i,h in ipairs(hearts) do
                local p=h.Position
                TweenService:Create(h,TweenInfo.new(.85,Enum.EasingStyle.Sine,Enum.EasingDirection.InOut),{Position=UDim2.new(p.X.Scale,p.X.Offset,p.Y.Scale,p.Y.Offset+(up and -3 or 3)),TextTransparency=up and .02 or .12}):Play()
                task.wait(.04)
            end
            task.wait(.75)
        end
    end)

    _G.KimqV21Loader={Gui=g,Status=status,Bar=bar}
    task.delay(28,function() if g and g.Parent then pcall(function() g:Destroy() end) end end)
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

local Avatar = Instance.new("ImageLabel", Panel)
Avatar.Size = UDim2.fromOffset(72, 72)
Avatar.Position = UDim2.new(0.5, -36, 0, 24)
Avatar.BackgroundColor3 = WHITEBLUE
Avatar.BorderSizePixel = 0
Instance.new("UICorner", Avatar).CornerRadius = UDim.new(1, 0)
local AvatarStroke = Instance.new("UIStroke", Avatar)
AvatarStroke.Color = HOT2
AvatarStroke.Transparency = 0.28
AvatarStroke.Thickness = 2
pcall(function()
    Avatar.Image = Players:GetUserThumbnailAsync(lp.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size180x180)
end)

local Heart = Instance.new("TextLabel", Panel)
Heart.Size = UDim2.fromOffset(34, 34)
Heart.Position = UDim2.new(0.5, 42, 0, 39)
Heart.BackgroundTransparency = 1
Heart.Text = "♥"
Heart.TextColor3 = HOT
Heart.Font = Enum.Font.FredokaOne
Heart.TextSize = 28

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
            Position = heartUp and UDim2.new(0.5, 42, 0, 34) or UDim2.new(0.5, 42, 0, 42)
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
        local waitStart = tick()
        while not _G.KimqV20Ready and tick() - waitStart < 14 do
            task.wait(0.12)
        end
        task.wait(0.35)
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


-- V9: replace the built-in Avatar controls with the requested external avatar script.
task.spawn(function()
    local Players = game:GetService("Players")
    local CoreGui = game:GetService("CoreGui")
    local TweenService = game:GetService("TweenService")
    local lp = Players.LocalPlayer
    local playerGui = lp:WaitForChild("PlayerGui")

    local function waitForMain(timeout)
        local started = tick()
        while tick() - started < (timeout or 15) do
            local gui = CoreGui:FindFirstChild("KimpetrasHC") or playerGui:FindFirstChild("KimpetrasHC")
            local main = gui and gui:FindFirstChild("Main")
            if main then return gui, main end
            task.wait(0.05)
        end
        return nil, nil
    end

    local gui, main = waitForMain(16)
    if not gui or not main then return end
    if main:FindFirstChild("KimqV9AvatarApplied") then return end

    local mark = Instance.new("BoolValue")
    mark.Name = "KimqV9AvatarApplied"
    mark.Parent = main

    local avatarPage
    for _, obj in ipairs(main:GetDescendants()) do
        if obj:IsA("ScrollingFrame") and obj.Name:lower() == "avatarpage" then
            avatarPage = obj
            break
        end
    end
    if not avatarPage then return end

    -- Remove the old username/headless/apply/reset controls.
    for _, child in ipairs(avatarPage:GetChildren()) do
        if not child:IsA("UIListLayout") and not child:IsA("UIPadding") then
            child:Destroy()
        end
    end

    local function corner(obj, radius)
        local c = obj:FindFirstChildOfClass("UICorner") or Instance.new("UICorner")
        c.CornerRadius = UDim.new(0, radius or 14)
        c.Parent = obj
        return c
    end

    local function stroke(obj, color)
        local s = obj:FindFirstChildOfClass("UIStroke") or Instance.new("UIStroke")
        s.Color = color
        s.Thickness = 1
        s.Transparency = 0.18
        s.Parent = obj
        return s
    end

    -- Pull colors from the live themed GUI so this page matches Blue/Purple/Pink/etc.
    local badge = main:FindFirstChild("V3Badge", true) or main:FindFirstChild("V4Badge", true) or main:FindFirstChild("V5Badge", true)
    local hot = badge and badge.BackgroundColor3 or Color3.fromRGB(49, 93, 255)
    local panelColor = Color3.fromRGB(242, 247, 255)
    local textColor = Color3.fromRGB(52, 82, 146)
    local subColor = Color3.fromRGB(97, 122, 169)
    local strokeColor = Color3.fromRGB(137, 176, 230)

    -- Sample the current page header when available.
    for _, obj in ipairs(main:GetDescendants()) do
        if obj:IsA("TextLabel") and tostring(obj.Text):lower() == "avatar" then
            textColor = obj.TextColor3
            if obj.Parent and obj.Parent:IsA("Frame") then
                panelColor = obj.Parent.BackgroundColor3
                local st = obj.Parent:FindFirstChildOfClass("UIStroke")
                if st then strokeColor = st.Color end
            end
            break
        end
    end

    local info = Instance.new("Frame")
    info.Name = "AvatarExternalCard"
    info.Parent = avatarPage
    info.Size = UDim2.new(1, -6, 0, 116)
    info.BackgroundColor3 = panelColor
    info.BorderSizePixel = 0
    corner(info, 16)
    stroke(info, strokeColor)

    local title = Instance.new("TextLabel")
    title.Parent = info
    title.Size = UDim2.new(1, -24, 0, 30)
    title.Position = UDim2.fromOffset(12, 12)
    title.BackgroundTransparency = 1
    title.Text = "♥  avatar script"
    title.TextColor3 = hot
    title.Font = Enum.Font.FredokaOne
    title.TextSize = 22
    title.TextXAlignment = Enum.TextXAlignment.Left

    local dash = Instance.new("TextLabel")
    dash.Parent = info
    dash.Size = UDim2.new(1, -24, 0, 16)
    dash.Position = UDim2.fromOffset(12, 42)
    dash.BackgroundTransparency = 1
    dash.Text = "-  -  -  -  -  -  -  -"
    dash.TextColor3 = strokeColor
    dash.Font = Enum.Font.GothamBold
    dash.TextSize = 11
    dash.TextXAlignment = Enum.TextXAlignment.Left

    local description = Instance.new("TextLabel")
    description.Parent = info
    description.Size = UDim2.new(1, -24, 0, 42)
    description.Position = UDim2.fromOffset(12, 64)
    description.BackgroundTransparency = 1
    description.Text = "The old built-in avatar controls were replaced with the requested avatar script.\nPress the button below whenever you want to open it."
    description.TextWrapped = true
    description.TextColor3 = textColor
    description.Font = Enum.Font.GothamSemibold
    description.TextSize = 14
    description.TextXAlignment = Enum.TextXAlignment.Left
    description.TextYAlignment = Enum.TextYAlignment.Top

    local runCard = Instance.new("Frame")
    runCard.Name = "AvatarExternalRunCard"
    runCard.Parent = avatarPage
    runCard.Size = UDim2.new(1, -6, 0, 58)
    runCard.BackgroundColor3 = panelColor
    runCard.BorderSizePixel = 0
    corner(runCard, 16)
    stroke(runCard, strokeColor)

    local runButton = Instance.new("TextButton")
    runButton.Parent = runCard
    runButton.Size = UDim2.new(1, -20, 0, 38)
    runButton.Position = UDim2.fromOffset(10, 10)
    runButton.BackgroundColor3 = hot
    runButton.BorderSizePixel = 0
    runButton.Text = "♥  open avatar script"
    runButton.TextColor3 = Color3.fromRGB(248, 251, 255)
    runButton.Font = Enum.Font.FredokaOne
    runButton.TextSize = 16
    runButton.AutoButtonColor = false
    corner(runButton, 12)

    local scale = Instance.new("UIScale")
    scale.Scale = 1
    scale.Parent = runButton
    runButton.MouseEnter:Connect(function()
        TweenService:Create(scale, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Scale = 1.012}):Play()
    end)
    runButton.MouseLeave:Connect(function()
        TweenService:Create(scale, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Scale = 1}):Play()
    end)

    local statusCard = Instance.new("Frame")
    statusCard.Parent = avatarPage
    statusCard.Size = UDim2.new(1, -6, 0, 46)
    statusCard.BackgroundColor3 = panelColor
    statusCard.BorderSizePixel = 0
    corner(statusCard, 16)
    stroke(statusCard, strokeColor)

    local status = Instance.new("TextLabel")
    status.Parent = statusCard
    status.Size = UDim2.new(1, -24, 1, 0)
    status.Position = UDim2.fromOffset(12, 0)
    status.BackgroundTransparency = 1
    status.Text = "♡  ready"
    status.TextColor3 = subColor
    status.Font = Enum.Font.GothamSemibold
    status.TextSize = 13
    status.TextXAlignment = Enum.TextXAlignment.Left

    local AVATAR_URL = "https://raw.githubusercontent.com/crimebeings/2/refs/heads/main/main"

    runButton.MouseButton1Click:Connect(function()
        status.Text = "♥  loading avatar script..."
        runButton.Text = "loading..."

        task.spawn(function()
            local ok, err = pcall(function()
                local source = game:HttpGet(AVATAR_URL)
                local fn, compileErr = loadstring(source)
                if not fn then error(compileErr or "avatar script failed to compile") end
                fn()
            end)

            if ok then
                status.Text = "♥  avatar script opened"
                runButton.Text = "♥  open avatar script"
            else
                status.Text = "♡  could not open: " .. tostring(err)
                runButton.Text = "♥  try again"
            end
        end)
    end)

    -- Keep this page following theme changes made elsewhere in the GUI.
    local function resyncColors()
        local liveBadge = main:FindFirstChild("V3Badge", true) or main:FindFirstChild("V4Badge", true) or main:FindFirstChild("V5Badge", true)
        if liveBadge and liveBadge:IsA("TextLabel") then
            hot = liveBadge.BackgroundColor3
            title.TextColor3 = hot
            runButton.BackgroundColor3 = hot
        end

        for _, obj in ipairs(main:GetDescendants()) do
            if obj:IsA("TextLabel") and tostring(obj.Text):lower() == "avatar" then
                textColor = obj.TextColor3
                description.TextColor3 = textColor
                if obj.Parent and obj.Parent:IsA("Frame") then
                    panelColor = obj.Parent.BackgroundColor3
                    info.BackgroundColor3 = panelColor
                    runCard.BackgroundColor3 = panelColor
                    statusCard.BackgroundColor3 = panelColor
                    local st = obj.Parent:FindFirstChildOfClass("UIStroke")
                    if st then
                        strokeColor = st.Color
                        dash.TextColor3 = strokeColor
                        for _, card in ipairs({info, runCard, statusCard}) do
                            local cs = card:FindFirstChildOfClass("UIStroke")
                            if cs then cs.Color = strokeColor end
                        end
                    end
                end
                break
            end
        end
    end

    for _, btn in ipairs(main:GetDescendants()) do
        if btn:IsA("TextButton") then
            btn.MouseButton1Click:Connect(function()
                task.delay(0.12, resyncColors)
            end)
        end
    end

    local badgeLabel = main:FindFirstChild("V3Badge", true) or main:FindFirstChild("V4Badge", true) or main:FindFirstChild("V5Badge", true)
    if badgeLabel and badgeLabel:IsA("TextLabel") then
        badgeLabel.Text = "V9 ♥"
    end
end)

-- V12: fixed persistent local accessory try-on.
-- Uses HumanoidDescription instead of game:GetObjects so catalog hats/hair/face accessories
-- are applied the same way as Roblox avatar descriptions, locally on this client.
task.spawn(function()
    local Players = game:GetService("Players")
    local MarketplaceService = game:GetService("MarketplaceService")
    local CoreGui = game:GetService("CoreGui")
    local TweenService = game:GetService("TweenService")

    local lp = Players.LocalPlayer
    local playerGui = lp:WaitForChild("PlayerGui")

    -- Save the chosen accessory IDs for this execution so they reapply after respawn/reset.
    _G.KimqLocalWearIds = _G.KimqLocalWearIds or {}

    local function waitForMain(timeout)
        local started = tick()
        while tick() - started < (timeout or 20) do
            local root = CoreGui:FindFirstChild("KimpetrasHC") or playerGui:FindFirstChild("KimpetrasHC")
            local main = root and root:FindFirstChild("Main")
            if main then return root, main end
            task.wait(0.08)
        end
    end

    -- Wait for the normal interface/theme patches to finish first.
    task.wait(2.8)
    local rootGui, main = waitForMain(20)
    if not rootGui or not main then return end
    if main:FindFirstChild("KimqV12AccessoryApplied") then return end

    local appliedMarker = Instance.new("BoolValue")
    appliedMarker.Name = "KimqV12AccessoryApplied"
    appliedMarker.Parent = main

    local avatarPage
    for _, obj in ipairs(main:GetDescendants()) do
        if obj:IsA("ScrollingFrame") and obj.Name:lower() == "avatarpage" then
            avatarPage = obj
            break
        end
    end
    if not avatarPage then return end

    -- Remove any accessory cards made by older attempts.
    for _, name in ipairs({"LocalAccessoryTryOn", "PersistentAccessoryCard", "PersistentAccessoryCardV12"}) do
        local old = avatarPage:FindFirstChild(name)
        if old then old:Destroy() end
    end

    local function corner(obj, radius)
        local c = obj:FindFirstChildOfClass("UICorner") or Instance.new("UICorner")
        c.CornerRadius = UDim.new(0, radius or 12)
        c.Parent = obj
        return c
    end

    local function stroke(obj, color, transparency, thickness)
        local s = obj:FindFirstChildOfClass("UIStroke") or Instance.new("UIStroke")
        s.Color = color
        s.Transparency = transparency or 0.2
        s.Thickness = thickness or 1
        s.Parent = obj
        return s
    end

    local function findCardContaining(text)
        text = text:lower()
        for _, child in ipairs(avatarPage:GetChildren()) do
            if child:IsA("Frame") then
                for _, d in ipairs(child:GetDescendants()) do
                    if (d:IsA("TextLabel") or d:IsA("TextButton")) and tostring(d.Text or ""):lower():find(text, 1, true) then
                        return child
                    end
                end
            end
        end
    end

    local applyCard = findCardContaining("apply avatar")
    local referenceCard = applyCard or findCardContaining("reset character")
    if not referenceCard then
        for _, child in ipairs(avatarPage:GetChildren()) do
            if child:IsA("Frame") then referenceCard = child break end
        end
    end

    local badge
    for _, d in ipairs(main:GetDescendants()) do
        if d:IsA("TextLabel") and tostring(d.Text or ""):match("^V%d+") then
            badge = d
        end
    end

    local function sampleTheme()
        local panel = referenceCard and referenceCard.BackgroundColor3 or Color3.fromRGB(242,247,255)
        local line = Color3.fromRGB(137,176,230)
        local refStroke = referenceCard and referenceCard:FindFirstChildOfClass("UIStroke")
        if refStroke then line = refStroke.Color end
        local hot = badge and badge.BackgroundColor3 or Color3.fromRGB(49,93,255)
        local light = panel:Lerp(hot, 0.12)
        local text = Color3.fromRGB(52,82,146)
        local sub = Color3.fromRGB(97,122,169)
        for _, d in ipairs(avatarPage:GetDescendants()) do
            if d:IsA("TextLabel") and d.TextSize >= 14 then
                text = d.TextColor3
                break
            end
        end
        return panel, line, hot, light, text, sub
    end

    local panelColor, lineColor, hotColor, lightColor, textColor, subColor = sampleTheme()

    local card = Instance.new("Frame")
    card.Name = "PersistentAccessoryCardV12"
    card.Parent = avatarPage
    card.Size = UDim2.new(1, -6, 0, 170)
    card.BackgroundColor3 = panelColor
    card.BorderSizePixel = 0
    corner(card, 14)
    local cardStroke = stroke(card, lineColor, 0.18, 1)

    local title = Instance.new("TextLabel")
    title.Parent = card
    title.Size = UDim2.new(1, -24, 0, 26)
    title.Position = UDim2.fromOffset(12, 10)
    title.BackgroundTransparency = 1
    title.Text = "♥  local accessory"
    title.TextColor3 = hotColor
    title.Font = Enum.Font.FredokaOne
    title.TextSize = 19
    title.TextXAlignment = Enum.TextXAlignment.Left

    local desc = Instance.new("TextLabel")
    desc.Parent = card
    desc.Size = UDim2.new(1, -24, 0, 20)
    desc.Position = UDim2.fromOffset(12, 37)
    desc.BackgroundTransparency = 1
    desc.Text = "Hat, hair, or face accessory • reapplies after you reset"
    desc.TextColor3 = subColor
    desc.Font = Enum.Font.Gotham
    desc.TextSize = 12
    desc.TextXAlignment = Enum.TextXAlignment.Left

    local input = Instance.new("TextBox")
    input.Parent = card
    input.Size = UDim2.new(1, -24, 0, 38)
    input.Position = UDim2.fromOffset(12, 63)
    input.BackgroundColor3 = lightColor
    input.BorderSizePixel = 0
    input.Text = ""
    input.PlaceholderText = "Paste accessory ID..."
    input.PlaceholderColor3 = subColor
    input.TextColor3 = textColor
    input.Font = Enum.Font.GothamMedium
    input.TextSize = 14
    input.ClearTextOnFocus = false
    input.TextXAlignment = Enum.TextXAlignment.Left
    corner(input, 10)
    local inputStroke = stroke(input, lineColor, 0.28, 1)
    local pad = Instance.new("UIPadding", input)
    pad.PaddingLeft = UDim.new(0, 10)
    pad.PaddingRight = UDim.new(0, 10)

    local equip = Instance.new("TextButton")
    equip.Parent = card
    equip.Size = UDim2.new(0.62, -6, 0, 38)
    equip.Position = UDim2.fromOffset(12, 109)
    equip.BackgroundColor3 = hotColor
    equip.BorderSizePixel = 0
    equip.Text = "♥  equip accessory"
    equip.TextColor3 = Color3.fromRGB(248,251,255)
    equip.Font = Enum.Font.GothamBold
    equip.TextSize = 13
    equip.AutoButtonColor = false
    corner(equip, 10)

    local remove = Instance.new("TextButton")
    remove.Parent = card
    remove.Size = UDim2.new(0.38, -18, 0, 38)
    remove.Position = UDim2.new(0.62, 6, 0, 109)
    remove.BackgroundColor3 = lightColor
    remove.BorderSizePixel = 0
    remove.Text = "remove all"
    remove.TextColor3 = textColor
    remove.Font = Enum.Font.GothamBold
    remove.TextSize = 13
    remove.AutoButtonColor = false
    corner(remove, 10)
    local removeStroke = stroke(remove, lineColor, 0.28, 1)

    local status = Instance.new("TextLabel")
    status.Parent = card
    status.Size = UDim2.new(1, -24, 0, 15)
    status.Position = UDim2.fromOffset(12, 151)
    status.BackgroundTransparency = 1
    status.Text = "♡ ready"
    status.TextColor3 = subColor
    status.Font = Enum.Font.Gotham
    status.TextSize = 10
    status.TextXAlignment = Enum.TextXAlignment.Left

    -- Prevent old card-normalization code from shrinking this custom panel.
    local keepingSize = false
    card:GetPropertyChangedSignal("Size"):Connect(function()
        if keepingSize then return end
        if card.Size.Y.Offset ~= 170 then
            keepingSize = true
            card.Size = UDim2.new(1, -6, 0, 170)
            keepingSize = false
        end
    end)

    -- AssetTypeId -> HumanoidDescription property.
    local accessoryProperty = {
        [8] = "HatAccessory",
        [41] = "HairAccessory",
        [42] = "FaceAccessory",
    }

    local function addId(csv, id)
        csv = tostring(csv or "")
        for existing in csv:gmatch("[^,]+") do
            if tonumber(existing) == id then return csv end
        end
        if csv == "" then return tostring(id) end
        return csv .. "," .. tostring(id)
    end

    local function removeId(csv, id)
        local kept = {}
        for existing in tostring(csv or ""):gmatch("[^,]+") do
            if tonumber(existing) ~= id then table.insert(kept, existing) end
        end
        return table.concat(kept, ",")
    end

    local function getCharacter()
        local character = lp.Character or lp.CharacterAdded:Wait()
        local humanoid = character:FindFirstChildOfClass("Humanoid") or character:WaitForChild("Humanoid", 8)
        return character, humanoid
    end

    local function setStatus(text, good)
        status.Text = text
        status.TextColor3 = good and hotColor or subColor
    end

    local function saveAccessory(id, property)
        for _, entry in ipairs(_G.KimqLocalWearIds) do
            if entry.id == id then return end
        end
        table.insert(_G.KimqLocalWearIds, {id = id, property = property})
    end

    local function applySaved(character, quiet)
        local char, humanoid = getCharacter()
        if character then
            char = character
            humanoid = char:FindFirstChildOfClass("Humanoid") or char:WaitForChild("Humanoid", 8)
        end
        if not humanoid then
            if not quiet then setStatus("♡ character is not ready") end
            return false
        end

        local okDesc, description = pcall(function()
            return humanoid:GetAppliedDescription()
        end)
        if not okDesc or not description then
            if not quiet then setStatus("♡ could not read your avatar") end
            return false
        end

        for _, entry in ipairs(_G.KimqLocalWearIds) do
            local current = description[entry.property]
            description[entry.property] = addId(current, entry.id)
        end

        local okApply, err = pcall(function()
            if humanoid.ApplyDescriptionAsync then
                humanoid:ApplyDescriptionAsync(description, Enum.AssetTypeVerification.Default)
            else
                humanoid:ApplyDescription(description)
            end
        end)
        if not okApply then
            if not quiet then setStatus("♡ Roblox would not apply that accessory") end
            warn("Kimq local accessory:", err)
            return false
        end
        return true
    end

    equip.MouseButton1Click:Connect(function()
        local assetId = tonumber(tostring(input.Text):match("%d+"))
        if not assetId then
            setStatus("♡ enter a catalog accessory ID")
            return
        end

        equip.Text = "checking..."
        setStatus("♡ checking catalog item...")

        task.spawn(function()
            local okInfo, info = pcall(function()
                return MarketplaceService:GetProductInfo(assetId, Enum.InfoType.Asset)
            end)
            if not okInfo or not info then
                equip.Text = "♥  equip accessory"
                setStatus("♡ invalid catalog ID")
                return
            end

            local property = accessoryProperty[info.AssetTypeId]
            if not property then
                equip.Text = "♥  equip accessory"
                setStatus("♡ only hat, hair, or face accessories")
                return
            end

            saveAccessory(assetId, property)
            local ok = applySaved(nil, false)
            if ok then
                equip.Text = "equipped ♥"
                setStatus("♥ wearing " .. tostring(info.Name or "accessory") .. " • saved for respawn", true)
            else
                -- Undo the saved entry if the actual apply failed.
                for i = #_G.KimqLocalWearIds, 1, -1 do
                    if _G.KimqLocalWearIds[i].id == assetId then
                        table.remove(_G.KimqLocalWearIds, i)
                        break
                    end
                end
            end

            task.wait(1.15)
            if equip.Parent then equip.Text = "♥  equip accessory" end
        end)
    end)

    remove.MouseButton1Click:Connect(function()
        local _, humanoid = getCharacter()
        if humanoid then
            local okDesc, description = pcall(function() return humanoid:GetAppliedDescription() end)
            if okDesc and description then
                for _, entry in ipairs(_G.KimqLocalWearIds) do
                    description[entry.property] = removeId(description[entry.property], entry.id)
                end
                pcall(function()
                    if humanoid.ApplyDescriptionAsync then
                        humanoid:ApplyDescriptionAsync(description, Enum.AssetTypeVerification.Default)
                    else
                        humanoid:ApplyDescription(description)
                    end
                end)
            end
        end
        table.clear(_G.KimqLocalWearIds)
        setStatus("♥ local accessories removed", true)
    end)

    -- Reapply to every new local character after Roblox finishes spawning its appearance.
    lp.CharacterAdded:Connect(function(character)
        task.spawn(function()
            character:WaitForChild("Humanoid", 8)
            task.wait(1.35)
            if #_G.KimqLocalWearIds > 0 then
                applySaved(character, true)
            end
        end)
    end)

    -- Put it directly AFTER Apply Avatar in the UIListLayout.
    if applyCard then
        local desired = applyCard.LayoutOrder + 1
        for _, child in ipairs(avatarPage:GetChildren()) do
            if child ~= card and not child:IsA("UIListLayout") and not child:IsA("UIPadding") and child.LayoutOrder >= desired then
                child.LayoutOrder = child.LayoutOrder + 1
            end
        end
        card.LayoutOrder = desired
    else
        local maxOrder = 0
        for _, child in ipairs(avatarPage:GetChildren()) do
            if child ~= card and not child:IsA("UIListLayout") and not child:IsA("UIPadding") then
                maxOrder = math.max(maxOrder, child.LayoutOrder)
            end
        end
        card.LayoutOrder = maxOrder + 1
    end

    -- Keep this card following theme changes by sampling the current badge/reference colors.
    local function syncTheme()
        panelColor, lineColor, hotColor, lightColor, textColor, subColor = sampleTheme()
        card.BackgroundColor3 = panelColor
        cardStroke.Color = lineColor
        title.TextColor3 = hotColor
        desc.TextColor3 = subColor
        input.BackgroundColor3 = lightColor
        input.TextColor3 = textColor
        input.PlaceholderColor3 = subColor
        inputStroke.Color = lineColor
        equip.BackgroundColor3 = hotColor
        remove.BackgroundColor3 = lightColor
        remove.TextColor3 = textColor
        removeStroke.Color = lineColor
        if status.Text:sub(1, 1) == "♥" then status.TextColor3 = hotColor else status.TextColor3 = subColor end
    end

    if badge then
        badge:GetPropertyChangedSignal("BackgroundColor3"):Connect(function()
            task.defer(syncTheme)
        end)
    end
    if referenceCard then
        referenceCard:GetPropertyChangedSignal("BackgroundColor3"):Connect(function()
            task.defer(syncTheme)
        end)
    end

    for _, button in ipairs({equip, remove}) do
        local scale = Instance.new("UIScale")
        scale.Parent = button
        button.MouseEnter:Connect(function()
            TweenService:Create(scale, TweenInfo.new(0.22, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Scale = 1.008}):Play()
        end)
        button.MouseLeave:Connect(function()
            TweenService:Create(scale, TweenInfo.new(0.26, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Scale = 1}):Play()
        end)
    end

    if badge then badge.Text = "V12 ♥" end
end)


-- V13: simple local accessory UI + direct local accessory loading.
task.spawn(function()
    local Players = game:GetService("Players")
    local CoreGui = game:GetService("CoreGui")
    local InsertService = game:GetService("InsertService")
    local TweenService = game:GetService("TweenService")
    local MarketplaceService = game:GetService("MarketplaceService")

    local lp = Players.LocalPlayer
    local playerGui = lp:WaitForChild("PlayerGui")

    -- Disable the older HumanoidDescription respawn path from V12.
    _G.KimqLocalWearIds = {}
    _G.KimqLocalAccessoryIdsV13 = _G.KimqLocalAccessoryIdsV13 or {}

    local function waitForMain(timeout)
        local started = tick()
        while tick() - started < (timeout or 20) do
            local root = CoreGui:FindFirstChild("KimpetrasHC") or playerGui:FindFirstChild("KimpetrasHC")
            local main = root and root:FindFirstChild("Main")
            if main then return root, main end
            task.wait(0.08)
        end
    end

    -- Let all older UI patches finish, then replace only the accessory area.
    task.wait(4.6)
    local rootGui, main = waitForMain(20)
    if not rootGui or not main then return end
    if main:FindFirstChild("KimqV13AccessoryApplied") then return end

    local marker = Instance.new("BoolValue")
    marker.Name = "KimqV13AccessoryApplied"
    marker.Parent = main

    local avatarPage
    for _, obj in ipairs(main:GetDescendants()) do
        if obj:IsA("ScrollingFrame") and obj.Name:lower() == "avatarpage" then
            avatarPage = obj
            break
        end
    end
    if not avatarPage then return end

    -- Remove every older accessory attempt so nothing can overlap this version.
    for _, child in ipairs(avatarPage:GetChildren()) do
        if child.Name == "PersistentAccessoryCardV12"
            or child.Name == "PersistentAccessoryCard"
            or child.Name == "LocalAccessoryTryOn"
            or child.Name:find("V13Accessory") then
            pcall(function() child:Destroy() end)
        end
    end

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
        text = text:lower()
        for _, child in ipairs(avatarPage:GetChildren()) do
            if child:IsA("Frame") then
                for _, d in ipairs(child:GetDescendants()) do
                    if (d:IsA("TextLabel") or d:IsA("TextButton")) and tostring(d.Text or ""):lower():find(text, 1, true) then
                        return child
                    end
                end
            end
        end
    end

    local applyCard = findCardContaining("apply avatar")
    local referenceCard = applyCard or findCardContaining("reset character")
    if not referenceCard then
        for _, child in ipairs(avatarPage:GetChildren()) do
            if child:IsA("Frame") then referenceCard = child break end
        end
    end

    local badge
    for _, d in ipairs(main:GetDescendants()) do
        if d:IsA("TextLabel") and tostring(d.Text or ""):match("^V%d+") then
            badge = d
        end
    end

    local function sampleTheme()
        local panel = referenceCard and referenceCard.BackgroundColor3 or Color3.fromRGB(242,247,255)
        local line = Color3.fromRGB(137,176,230)
        local rs = referenceCard and referenceCard:FindFirstChildOfClass("UIStroke")
        if rs then line = rs.Color end
        local hot = badge and badge.BackgroundColor3 or Color3.fromRGB(49,93,255)
        local light = panel:Lerp(hot, 0.12)
        local text = Color3.fromRGB(52,82,146)
        local sub = Color3.fromRGB(97,122,169)
        for _, d in ipairs(avatarPage:GetDescendants()) do
            if d:IsA("TextLabel") and d.TextSize >= 14 then
                text = d.TextColor3
                break
            end
        end
        return panel, line, hot, light, text, sub
    end

    local panelColor, lineColor, hotColor, lightColor, textColor, subColor = sampleTheme()

    -- Keep every new row the same size as the rest of the GUI.
    local ROW_H = 52
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

    local titleRow = makeRow("V13AccessoryTitle")
    local title = Instance.new("TextLabel")
    title.Parent = titleRow
    title.Size = UDim2.new(0.55, -12, 1, 0)
    title.Position = UDim2.fromOffset(12, 0)
    title.BackgroundTransparency = 1
    title.Text = "♥  Local Accessory"
    title.TextColor3 = textColor
    title.Font = Enum.Font.GothamBold
    title.TextSize = 15
    title.TextXAlignment = Enum.TextXAlignment.Left

    local tiny = Instance.new("TextLabel")
    tiny.Parent = titleRow
    tiny.Size = UDim2.new(0.45, -18, 1, 0)
    tiny.Position = UDim2.new(0.55, 6, 0, 0)
    tiny.BackgroundTransparency = 1
    tiny.Text = "client-side • stays after reset"
    tiny.TextColor3 = subColor
    tiny.Font = Enum.Font.Gotham
    tiny.TextSize = 11
    tiny.TextXAlignment = Enum.TextXAlignment.Right

    local inputRow = makeRow("V13AccessoryInput")
    local inputLabel = Instance.new("TextLabel")
    inputLabel.Parent = inputRow
    inputLabel.Size = UDim2.new(0, 160, 1, 0)
    inputLabel.Position = UDim2.fromOffset(12, 0)
    inputLabel.BackgroundTransparency = 1
    inputLabel.Text = "Accessory ID"
    inputLabel.TextColor3 = textColor
    inputLabel.Font = Enum.Font.GothamBold
    inputLabel.TextSize = 14
    inputLabel.TextXAlignment = Enum.TextXAlignment.Left

    local input = Instance.new("TextBox")
    input.Parent = inputRow
    input.Size = UDim2.new(1, -190, 0, 34)
    input.Position = UDim2.new(0, 178, 0.5, -17)
    input.BackgroundColor3 = lightColor
    input.BorderSizePixel = 0
    input.Text = ""
    input.PlaceholderText = "Paste hat / hair / face ID..."
    input.PlaceholderColor3 = subColor
    input.TextColor3 = textColor
    input.Font = Enum.Font.Gotham
    input.TextSize = 13
    input.ClearTextOnFocus = false
    input.TextXAlignment = Enum.TextXAlignment.Left
    corner(input, 10)
    local inputStroke = stroke(input, lineColor, 0.3, 1)
    local pad = Instance.new("UIPadding", input)
    pad.PaddingLeft = UDim.new(0, 10)
    pad.PaddingRight = UDim.new(0, 10)

    local actionRow = makeRow("V13AccessoryActions")
    local equip = Instance.new("TextButton")
    equip.Parent = actionRow
    equip.Size = UDim2.new(0.68, -18, 0, 34)
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
    remove.Size = UDim2.new(0.32, -8, 0, 34)
    remove.Position = UDim2.new(0.68, 0, 0.5, -17)
    remove.BackgroundColor3 = lightColor
    remove.BorderSizePixel = 0
    remove.Text = "Remove All"
    remove.TextColor3 = textColor
    remove.Font = Enum.Font.GothamBold
    remove.TextSize = 13
    remove.AutoButtonColor = false
    corner(remove, 10)
    local removeStroke = stroke(remove, lineColor, 0.3, 1)

    local statusRow = makeRow("V13AccessoryStatus")
    local status = Instance.new("TextLabel")
    status.Parent = statusRow
    status.Size = UDim2.new(1, -24, 1, 0)
    status.Position = UDim2.fromOffset(12, 0)
    status.BackgroundTransparency = 1
    status.Text = "♡ Ready — enter an accessory ID above"
    status.TextColor3 = subColor
    status.Font = Enum.Font.Gotham
    status.TextSize = 12
    status.TextXAlignment = Enum.TextXAlignment.Left

    local rows = {titleRow, inputRow, actionRow, statusRow}
    local changingSize = false
    for _, row in ipairs(rows) do
        row:GetPropertyChangedSignal("Size"):Connect(function()
            if changingSize then return end
            if row.Size.Y.Offset ~= ROW_H then
                changingSize = true
                row.Size = UDim2.new(1, -6, 0, ROW_H)
                changingSize = false
            end
        end)
    end

    -- Put the rows immediately after Apply Avatar.
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

    local function setStatus(text, success)
        status.Text = text
        status.TextColor3 = success and hotColor or subColor
    end

    local function getCharacter(character)
        local char = character or lp.Character or lp.CharacterAdded:Wait()
        local hum = char:FindFirstChildOfClass("Humanoid") or char:WaitForChild("Humanoid", 8)
        return char, hum
    end

    local function cleanAccessory(acc, assetId)
        if not acc then return nil end
        for _, d in ipairs(acc:GetDescendants()) do
            if d:IsA("Script") or d:IsA("LocalScript") or d:IsA("ModuleScript") then
                pcall(function() d:Destroy() end)
            end
        end
        pcall(function() acc:SetAttribute("KimqLocalAccessory", true) end)
        pcall(function() acc:SetAttribute("KimqAssetId", assetId) end)
        return acc
    end

    local function findAccessory(root)
        if not root then return nil end
        if root:IsA("Accessory") then return root end
        return root:FindFirstChildWhichIsA("Accessory", true)
    end

    local function loadAccessoryObject(assetId)
        -- Method 1: executor/client asset loader. This is the most direct local-only path.
        local okObjects, objects = pcall(function()
            return game:GetObjects("rbxassetid://" .. tostring(assetId))
        end)
        if okObjects and type(objects) == "table" then
            for _, obj in ipairs(objects) do
                local acc = findAccessory(obj)
                if acc then
                    acc.Parent = nil
                    for _, other in ipairs(objects) do
                        if other ~= acc and other.Parent == nil then
                            pcall(function() other:Destroy() end)
                        end
                    end
                    return cleanAccessory(acc, assetId), "GetObjects"
                end
            end
        end

        -- Method 2: InsertService fallback for executors/environments that allow it locally.
        local okInsert, model = pcall(function()
            return InsertService:LoadAsset(assetId)
        end)
        if okInsert and model then
            local acc = findAccessory(model)
            if acc then
                acc.Parent = nil
                pcall(function() model:Destroy() end)
                return cleanAccessory(acc, assetId), "InsertService"
            end
            pcall(function() model:Destroy() end)
        end

        return nil, "none"
    end

    local function alreadySaved(assetId)
        for _, id in ipairs(_G.KimqLocalAccessoryIdsV13) do
            if id == assetId then return true end
        end
        return false
    end

    local function addSaved(assetId)
        if not alreadySaved(assetId) then
            table.insert(_G.KimqLocalAccessoryIdsV13, assetId)
        end
    end

    local function removeExistingLocal(char)
        for _, obj in ipairs(char:GetChildren()) do
            if obj:IsA("Accessory") and obj:GetAttribute("KimqLocalAccessory") == true then
                pcall(function() obj:Destroy() end)
            end
        end
    end

    local function equipOne(assetId, character, quiet)
        local char, hum = getCharacter(character)
        if not char or not hum then
            if not quiet then setStatus("♡ Character is not ready") end
            return false
        end

        -- Avoid stacking our exact same local accessory twice on this character.
        for _, obj in ipairs(char:GetChildren()) do
            if obj:IsA("Accessory") and obj:GetAttribute("KimqAssetId") == assetId then
                return true
            end
        end

        local accessory, method = loadAccessoryObject(assetId)
        if not accessory then
            if not quiet then
                setStatus("♡ Could not load that asset — try a hat, hair, or face accessory ID")
            end
            return false
        end

        local okAdd, addErr = pcall(function()
            hum:AddAccessory(accessory)
        end)
        if not okAdd or not accessory.Parent then
            -- Fallback: parenting first can still let Roblox build the accessory weld on some clients.
            local okParent = pcall(function()
                accessory.Parent = char
            end)
            if not okParent then
                pcall(function() accessory:Destroy() end)
                if not quiet then setStatus("♡ Loaded the asset, but Roblox would not attach it") end
                warn("Kimq accessory attach failed:", addErr)
                return false
            end
        end

        pcall(function() accessory:SetAttribute("KimqLoadMethod", method) end)
        return true
    end

    equip.MouseButton1Click:Connect(function()
        local assetId = tonumber(tostring(input.Text):match("%d+"))
        if not assetId then
            setStatus("♡ Enter a catalog accessory ID first")
            return
        end

        equip.Text = "Loading..."
        setStatus("♡ Loading accessory " .. tostring(assetId) .. "...")

        task.spawn(function()
            local name = "accessory"
            pcall(function()
                local info = MarketplaceService:GetProductInfo(assetId, Enum.InfoType.Asset)
                if info and info.Name then name = info.Name end
            end)

            local ok = equipOne(assetId, nil, false)
            if ok then
                addSaved(assetId)
                equip.Text = "Equipped ♥"
                setStatus("♥ Wearing " .. name .. " — saved for reset", true)
            else
                equip.Text = "Try Again"
            end
            task.wait(1.1)
            if equip.Parent then equip.Text = "♥  Equip Accessory" end
        end)
    end)

    remove.MouseButton1Click:Connect(function()
        local char = lp.Character
        if char then removeExistingLocal(char) end
        table.clear(_G.KimqLocalAccessoryIdsV13)
        setStatus("♥ Removed your local accessories", true)
    end)

    -- Re-load saved local accessories every time the local character respawns.
    lp.CharacterAdded:Connect(function(character)
        task.spawn(function()
            character:WaitForChild("Humanoid", 8)
            task.wait(1.15)
            for _, assetId in ipairs(_G.KimqLocalAccessoryIdsV13) do
                equipOne(assetId, character, true)
                task.wait(0.08)
            end
        end)
    end)

    -- Follow theme changes.
    local function syncTheme()
        panelColor, lineColor, hotColor, lightColor, textColor, subColor = sampleTheme()
        for _, row in ipairs(rows) do
            row.BackgroundColor3 = panelColor
            local rs = row:FindFirstChildOfClass("UIStroke")
            if rs then rs.Color = lineColor end
        end
        title.TextColor3 = textColor
        tiny.TextColor3 = subColor
        inputLabel.TextColor3 = textColor
        input.BackgroundColor3 = lightColor
        input.TextColor3 = textColor
        input.PlaceholderColor3 = subColor
        inputStroke.Color = lineColor
        equip.BackgroundColor3 = hotColor
        remove.BackgroundColor3 = lightColor
        remove.TextColor3 = textColor
        removeStroke.Color = lineColor
        if status.Text:sub(1, 1) == "♥" then status.TextColor3 = hotColor else status.TextColor3 = subColor end
    end

    if badge then
        badge:GetPropertyChangedSignal("BackgroundColor3"):Connect(function()
            task.defer(syncTheme)
        end)
        badge.Text = "V13 ♥"
    end

    for _, button in ipairs({equip, remove}) do
        local scale = Instance.new("UIScale")
        scale.Parent = button
        button.MouseEnter:Connect(function()
            TweenService:Create(scale, TweenInfo.new(0.18, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Scale = 1.006}):Play()
        end)
        button.MouseLeave:Connect(function()
            TweenService:Create(scale, TweenInfo.new(0.22, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Scale = 1}):Play()
        end)
    end
end)


-- V14: simple matching local-accessory rows + no-physics-fling manual attachment.
task.spawn(function()
    local Players = game:GetService("Players")
    local CoreGui = game:GetService("CoreGui")
    local TweenService = game:GetService("TweenService")
    local MarketplaceService = game:GetService("MarketplaceService")

    local lp = Players.LocalPlayer
    local playerGui = lp:WaitForChild("PlayerGui")

    -- Disable every older accessory persistence path so old attach code cannot run.
    _G.KimqLocalWearIds = {}
    _G.KimqLocalAccessoryIdsV13 = {}
    _G.KimqLocalVisualAccessoriesV14 = _G.KimqLocalVisualAccessoriesV14 or {}

    local function waitForMain(timeout)
        local started = tick()
        while tick() - started < (timeout or 20) do
            local root = CoreGui:FindFirstChild("KimpetrasHC") or playerGui:FindFirstChild("KimpetrasHC")
            local main = root and root:FindFirstChild("Main")
            if main then return root, main end
            task.wait(0.08)
        end
    end

    task.wait(5.1) -- let the older page patches finish first
    local rootGui, main = waitForMain(20)
    if not rootGui or not main then return end
    if main:FindFirstChild("KimqV14AccessoryApplied") then return end

    local marker = Instance.new("BoolValue")
    marker.Name = "KimqV14AccessoryApplied"
    marker.Parent = main

    local avatarPage
    for _, obj in ipairs(main:GetDescendants()) do
        if obj:IsA("ScrollingFrame") and obj.Name:lower() == "avatarpage" then
            avatarPage = obj
            break
        end
    end
    if not avatarPage then return end

    -- Remove all previous accessory UIs and any previously attached test accessories.
    for _, child in ipairs(avatarPage:GetChildren()) do
        if child.Name:find("Accessory") or child.Name == "LocalAccessoryTryOn" then
            pcall(function() child:Destroy() end)
        end
    end
    if lp.Character then
        for _, obj in ipairs(lp.Character:GetChildren()) do
            if obj:IsA("Accessory") and (obj:GetAttribute("KimqLocalAccessory") or obj:GetAttribute("KimqLocalV14")) then
                pcall(function() obj:Destroy() end)
            end
        end
    end

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
        text = string.lower(text)
        for _, child in ipairs(avatarPage:GetChildren()) do
            if child:IsA("Frame") then
                for _, d in ipairs(child:GetDescendants()) do
                    if (d:IsA("TextLabel") or d:IsA("TextButton")) and string.find(string.lower(tostring(d.Text or "")), text, 1, true) then
                        return child
                    end
                end
            end
        end
    end

    local applyCard = findCardContaining("apply avatar")
    local resetCard = findCardContaining("reset character")
    local referenceCard = applyCard or resetCard
    if not referenceCard then
        for _, child in ipairs(avatarPage:GetChildren()) do
            if child:IsA("Frame") then referenceCard = child break end
        end
    end

    local badge
    for _, d in ipairs(main:GetDescendants()) do
        if d:IsA("TextLabel") and tostring(d.Text or ""):match("^V%d+") then
            badge = d
        end
    end

    local function sampleTheme()
        local panel = referenceCard and referenceCard.BackgroundColor3 or Color3.fromRGB(242,247,255)
        local line = Color3.fromRGB(137,176,230)
        local rs = referenceCard and referenceCard:FindFirstChildOfClass("UIStroke")
        if rs then line = rs.Color end
        local hot = badge and badge.BackgroundColor3 or Color3.fromRGB(49,93,255)
        local light = panel:Lerp(hot, 0.12)
        local text = Color3.fromRGB(52,82,146)
        local sub = Color3.fromRGB(97,122,169)
        for _, d in ipairs(avatarPage:GetDescendants()) do
            if d:IsA("TextLabel") and d.TextSize >= 14 then
                text = d.TextColor3
                break
            end
        end
        return panel, line, hot, light, text, sub
    end

    local panelColor, lineColor, hotColor, lightColor, textColor, subColor = sampleTheme()
    local ROW_H = referenceCard and math.max(48, referenceCard.Size.Y.Offset) or 52
    if ROW_H > 58 then ROW_H = 52 end

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

    -- 1) Small info row, styled exactly like the top controls.
    local infoRow = makeRow("V14AccessoryInfo")
    local infoTitle = Instance.new("TextLabel")
    infoTitle.Parent = infoRow
    infoTitle.Size = UDim2.new(0.45, -12, 1, 0)
    infoTitle.Position = UDim2.fromOffset(12, 0)
    infoTitle.BackgroundTransparency = 1
    infoTitle.Text = "Local Accessory"
    infoTitle.TextColor3 = textColor
    infoTitle.Font = Enum.Font.GothamBold
    infoTitle.TextSize = 14
    infoTitle.TextXAlignment = Enum.TextXAlignment.Left

    local infoSub = Instance.new("TextLabel")
    infoSub.Parent = infoRow
    infoSub.Size = UDim2.new(0.55, -18, 1, 0)
    infoSub.Position = UDim2.new(0.45, 6, 0, 0)
    infoSub.BackgroundTransparency = 1
    infoSub.Text = "hat / hair / face • local only"
    infoSub.TextColor3 = subColor
    infoSub.Font = Enum.Font.Gotham
    infoSub.TextSize = 11
    infoSub.TextXAlignment = Enum.TextXAlignment.Right

    -- 2) ID row.
    local inputRow = makeRow("V14AccessoryInput")
    local inputLabel = Instance.new("TextLabel")
    inputLabel.Parent = inputRow
    inputLabel.Size = UDim2.new(0, 150, 1, 0)
    inputLabel.Position = UDim2.fromOffset(12, 0)
    inputLabel.BackgroundTransparency = 1
    inputLabel.Text = "Accessory ID"
    inputLabel.TextColor3 = textColor
    inputLabel.Font = Enum.Font.GothamBold
    inputLabel.TextSize = 14
    inputLabel.TextXAlignment = Enum.TextXAlignment.Left

    local input = Instance.new("TextBox")
    input.Parent = inputRow
    input.Size = UDim2.new(1, -180, 0, 34)
    input.Position = UDim2.new(0, 168, 0.5, -17)
    input.BackgroundColor3 = lightColor
    input.BorderSizePixel = 0
    input.Text = ""
    input.PlaceholderText = "Paste accessory ID..."
    input.PlaceholderColor3 = subColor
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

    -- 3) Full-width equip row.
    local equipRow = makeRow("V14AccessoryEquip")
    local equip = Instance.new("TextButton")
    equip.Parent = equipRow
    equip.Size = UDim2.new(1, -20, 0, 34)
    equip.Position = UDim2.new(0, 10, 0.5, -17)
    equip.BackgroundColor3 = hotColor
    equip.BorderSizePixel = 0
    equip.Text = "♥  Equip Local Accessory"
    equip.TextColor3 = Color3.fromRGB(250,252,255)
    equip.Font = Enum.Font.GothamBold
    equip.TextSize = 13
    equip.AutoButtonColor = false
    corner(equip, 10)

    -- 4) Full-width remove/status row.
    local removeRow = makeRow("V14AccessoryRemove")
    local remove = Instance.new("TextButton")
    remove.Parent = removeRow
    remove.Size = UDim2.new(0.38, -14, 0, 34)
    remove.Position = UDim2.new(0, 10, 0.5, -17)
    remove.BackgroundColor3 = lightColor
    remove.BorderSizePixel = 0
    remove.Text = "Remove Local"
    remove.TextColor3 = textColor
    remove.Font = Enum.Font.GothamBold
    remove.TextSize = 12
    remove.AutoButtonColor = false
    corner(remove, 10)
    local removeStroke = stroke(remove, lineColor, 0.3, 1)

    local status = Instance.new("TextLabel")
    status.Parent = removeRow
    status.Size = UDim2.new(0.62, -20, 1, 0)
    status.Position = UDim2.new(0.38, 8, 0, 0)
    status.BackgroundTransparency = 1
    status.Text = "ready"
    status.TextColor3 = subColor
    status.Font = Enum.Font.Gotham
    status.TextSize = 11
    status.TextXAlignment = Enum.TextXAlignment.Right

    local rows = {infoRow, inputRow, equipRow, removeRow}

    -- Put these rows AFTER Apply Avatar, not above it.
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

    -- Keep the rows the same height as the normal top cards.
    local resizing = false
    for _, row in ipairs(rows) do
        row:GetPropertyChangedSignal("Size"):Connect(function()
            if resizing then return end
            if row.Size.Y.Offset ~= ROW_H then
                resizing = true
                row.Size = UDim2.new(1, -6, 0, ROW_H)
                resizing = false
            end
        end)
    end

    local function setStatus(text, good)
        status.Text = text
        status.TextColor3 = good and hotColor or subColor
    end

    local function findAccessory(root)
        if not root then return nil end
        if root:IsA("Accessory") then return root end
        return root:FindFirstChildWhichIsA("Accessory", true)
    end

    local function loadAccessory(assetId)
        -- Preferred local-only asset loader.
        local ok, objects = pcall(function()
            return game:GetObjects("rbxassetid://" .. tostring(assetId))
        end)
        if ok and type(objects) == "table" then
            for _, root in ipairs(objects) do
                local found = findAccessory(root)
                if found then
                    local clone = found:Clone()
                    for _, other in ipairs(objects) do pcall(function() other:Destroy() end) end
                    return clone
                end
            end
            for _, other in ipairs(objects) do pcall(function() other:Destroy() end) end
        end
        return nil
    end

    local HEAD_ATTACHMENT_NAMES = {
        HatAttachment = true,
        HairAttachment = true,
        FaceFrontAttachment = true,
        FaceCenterAttachment = true,
    }

    local function sanitizeAccessory(acc, assetId)
        acc.Name = "KimqLocal_" .. tostring(assetId)
        acc:SetAttribute("KimqLocalV14", true)
        acc:SetAttribute("KimqAssetId", assetId)

        for _, d in ipairs(acc:GetDescendants()) do
            if d:IsA("Script") or d:IsA("LocalScript") or d:IsA("ModuleScript") then
                pcall(function() d:Destroy() end)
            elseif d:IsA("BasePart") then
                d.CanCollide = false
                d.CanTouch = false
                d.CanQuery = false
                d.Massless = true
                d.Anchored = false
            elseif d:IsA("Weld") or d:IsA("WeldConstraint") or d:IsA("Motor6D") then
                if d.Name == "AccessoryWeld" or d.Part0 or d.Part1 then
                    pcall(function() d:Destroy() end)
                end
            end
        end
        return acc
    end

    local function findHeadAttachmentPair(char, handle)
        local head = char:FindFirstChild("Head")
        if not head then return nil end

        -- Exact attachment-name match gives Roblox-correct placement.
        for _, handleAtt in ipairs(handle:GetChildren()) do
            if handleAtt:IsA("Attachment") and HEAD_ATTACHMENT_NAMES[handleAtt.Name] then
                local bodyAtt = head:FindFirstChild(handleAtt.Name)
                if bodyAtt and bodyAtt:IsA("Attachment") then
                    return head, bodyAtt, handleAtt
                end
            end
        end

        -- Some older hats only expose HatAttachment after insertion.
        local hatAtt = handle:FindFirstChild("HatAttachment")
        local bodyHat = head:FindFirstChild("HatAttachment")
        if hatAtt and bodyHat then
            return head, bodyHat, hatAtt
        end

        return nil
    end

    local function attachVisual(assetId, character, quiet)
        local char = character or lp.Character
        if not char then
            if not quiet then setStatus("character not ready") end
            return false
        end
        local head = char:FindFirstChild("Head") or char:WaitForChild("Head", 6)
        if not head then
            if not quiet then setStatus("head not ready") end
            return false
        end

        for _, child in ipairs(char:GetChildren()) do
            if child:IsA("Accessory") and child:GetAttribute("KimqLocalV14") and child:GetAttribute("KimqAssetId") == assetId then
                return true
            end
        end

        local acc = loadAccessory(assetId)
        if not acc then
            if not quiet then setStatus("couldn't load this accessory") end
            return false
        end
        sanitizeAccessory(acc, assetId)

        local handle = acc:FindFirstChild("Handle")
        if not handle or not handle:IsA("BasePart") then
            pcall(function() acc:Destroy() end)
            if not quiet then setStatus("this item has no accessory handle") end
            return false
        end

        local bodyPart, bodyAtt, handleAtt = findHeadAttachmentPair(char, handle)
        if not bodyPart then
            pcall(function() acc:Destroy() end)
            if not quiet then setStatus("use a hat / hair / face accessory ID") end
            return false
        end

        -- Parent only after all physics are disabled.
        acc.Parent = char

        -- Set exact attachment alignment before creating the weld.
        handle.CFrame = bodyPart.CFrame * bodyAtt.CFrame * handleAtt.CFrame:Inverse()

        local weld = Instance.new("Weld")
        weld.Name = "KimqLocalWeld"
        weld.Part0 = bodyPart
        weld.Part1 = handle
        weld.C0 = bodyAtt.CFrame
        weld.C1 = handleAtt.CFrame
        weld.Parent = handle

        -- Extra safety: velocity should never be transferred into the character.
        pcall(function()
            handle.AssemblyLinearVelocity = Vector3.zero
            handle.AssemblyAngularVelocity = Vector3.zero
        end)

        return true
    end

    local function isSaved(assetId)
        for _, id in ipairs(_G.KimqLocalVisualAccessoriesV14) do
            if id == assetId then return true end
        end
        return false
    end

    local function saveId(assetId)
        if not isSaved(assetId) then
            table.insert(_G.KimqLocalVisualAccessoriesV14, assetId)
        end
    end

    local function removeAll(character)
        local char = character or lp.Character
        if not char then return end
        for _, child in ipairs(char:GetChildren()) do
            if child:IsA("Accessory") and child:GetAttribute("KimqLocalV14") then
                pcall(function() child:Destroy() end)
            end
        end
    end

    equip.MouseButton1Click:Connect(function()
        local assetId = tonumber(tostring(input.Text):match("%d+"))
        if not assetId then
            setStatus("enter an accessory ID")
            return
        end

        equip.Text = "Loading..."
        setStatus("loading...")
        task.spawn(function()
            local itemName = "accessory"
            pcall(function()
                local info = MarketplaceService:GetProductInfo(assetId, Enum.InfoType.Asset)
                if info and info.Name then itemName = info.Name end
            end)

            local ok = attachVisual(assetId, nil, false)
            if ok then
                saveId(assetId)
                equip.Text = "Equipped ♥"
                setStatus("wearing " .. itemName, true)
            else
                equip.Text = "Try Again"
            end
            task.wait(1.15)
            if equip.Parent then equip.Text = "♥  Equip Local Accessory" end
        end)
    end)

    remove.MouseButton1Click:Connect(function()
        removeAll()
        table.clear(_G.KimqLocalVisualAccessoriesV14)
        setStatus("removed", true)
    end)

    -- Reapply local visuals after death/reset.
    lp.CharacterAdded:Connect(function(char)
        task.spawn(function()
            char:WaitForChild("Head", 8)
            task.wait(1.0)
            for _, assetId in ipairs(_G.KimqLocalVisualAccessoriesV14) do
                attachVisual(assetId, char, true)
                task.wait(0.08)
            end
        end)
    end)

    -- Follow theme changes.
    local function syncTheme()
        panelColor, lineColor, hotColor, lightColor, textColor, subColor = sampleTheme()
        for _, row in ipairs(rows) do
            row.BackgroundColor3 = panelColor
            local rs = row:FindFirstChildOfClass("UIStroke")
            if rs then rs.Color = lineColor end
        end
        infoTitle.TextColor3 = textColor
        infoSub.TextColor3 = subColor
        inputLabel.TextColor3 = textColor
        input.BackgroundColor3 = lightColor
        input.TextColor3 = textColor
        input.PlaceholderColor3 = subColor
        inputStroke.Color = lineColor
        equip.BackgroundColor3 = hotColor
        remove.BackgroundColor3 = lightColor
        remove.TextColor3 = textColor
        removeStroke.Color = lineColor
        status.TextColor3 = subColor
    end

    if badge then
        badge:GetPropertyChangedSignal("BackgroundColor3"):Connect(function()
            task.defer(syncTheme)
        end)
        badge.Text = "V14 ♥"
    end

    for _, button in ipairs({equip, remove}) do
        local scale = Instance.new("UIScale")
        scale.Parent = button
        button.MouseEnter:Connect(function()
            TweenService:Create(scale, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Scale = 1.004}):Play()
        end)
        button.MouseLeave:Connect(function()
            TweenService:Create(scale, TweenInfo.new(0.24, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Scale = 1}):Play()
        end)
    end
end)


-- V15: clean matching avatar accessory rows + improved local accessory loader.
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

    task.wait(5.6)
    local rootGui, main = waitForMain(22)
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
        if d:IsA("TextLabel") and tostring(d.Text or ""):match("^V%d+") then
            badge = d
            break
        end
    end

    local function sampleTheme()
        local panel = referenceCard and referenceCard.BackgroundColor3 or Color3.fromRGB(242,247,255)
        local line = Color3.fromRGB(137,176,230)
        local hot = badge and badge.BackgroundColor3 or Color3.fromRGB(49,93,255)
        local light = panel:Lerp(hot, 0.12)
        local text = Color3.fromRGB(52,82,146)
        local sub = Color3.fromRGB(97,122,169)
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
        badge.Text = "V15 ♥"
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
-- V20: old cute layout + fixed seasonal environment + all-weapon local wraps.
-- ========================================================
task.spawn(function()
    local Players = game:GetService("Players")
    local CoreGui = game:GetService("CoreGui")
    local Lighting = game:GetService("Lighting")
    local RunService = game:GetService("RunService")
    local TweenService = game:GetService("TweenService")

    local lp = Players.LocalPlayer
    local playerGui = lp:WaitForChild("PlayerGui")
    local terrain = workspace:FindFirstChildOfClass("Terrain")

    task.wait(7.6) -- wait for the cute V15 layout/accessory patches to settle

    local root = CoreGui:FindFirstChild("KimpetrasHC") or playerGui:FindFirstChild("KimpetrasHC")
    local main = root and root:FindFirstChild("Main")
    if not main then _G.KimqV20Ready = true return end
    if main:FindFirstChild("KimqV20Applied") then _G.KimqV20Ready = true return end

    local marker = Instance.new("BoolValue")
    marker.Name = "KimqV20Applied"
    marker.Parent = main

    local function norm(s)
        s = tostring(s or ""):lower():gsub("[♥♡❤]", "")
        s = s:gsub("^%s+", ""):gsub("%s+$", ""):gsub("%s+", " ")
        return s
    end
    local function corner(obj, r)
        local c = obj:FindFirstChildOfClass("UICorner") or Instance.new("UICorner")
        c.CornerRadius = UDim.new(0, r or 12)
        c.Parent = obj
        return c
    end
    local function stroke(obj, color, tr, th)
        local s = obj:FindFirstChildOfClass("UIStroke") or Instance.new("UIStroke")
        s.Color = color
        s.Transparency = tr or 0.22
        s.Thickness = th or 1
        s.Parent = obj
        return s
    end

    -- Find the existing page host / sidebar from the cute layout.
    local pages = {}
    local pageHost
    for _, d in ipairs(main:GetDescendants()) do
        if d:IsA("ScrollingFrame") and d.Name:match("Page$") then
            pages[d.Name:gsub("Page$", ""):lower()] = d
            pageHost = d.Parent
        end
    end
    if not pageHost or not pages.overview then _G.KimqV20Ready = true return end

    local nav
    for _, d in ipairs(main:GetDescendants()) do
        if d:IsA("ScrollingFrame") and not d.Name:match("Page$") then
            for _, b in ipairs(d:GetChildren()) do
                if b:IsA("TextButton") and norm(b.Text) == "overview" then
                    nav = d
                    break
                end
            end
        end
        if nav then break end
    end
    if not nav then _G.KimqV20Ready = true return end

    local badge
    for _, d in ipairs(main:GetDescendants()) do
        if d:IsA("TextLabel") and tostring(d.Text or ""):match("^V%d+") then badge = d break end
    end

    local pageTitle, pageDesc
    for _, d in ipairs(main:GetDescendants()) do
        if d:IsA("TextLabel") then
            if norm(d.Text) == "overview" and d.TextSize >= 18 then pageTitle = d end
            if tostring(d.Text or ""):lower():find("your account", 1, true) then pageDesc = d end
        end
    end

    local function themeSample()
        local hot = badge and badge.BackgroundColor3 or Color3.fromRGB(49,93,255)
        local panel = Color3.fromRGB(242,247,255)
        local line = Color3.fromRGB(137,176,230)
        local text = Color3.fromRGB(52,82,146)
        local sub = Color3.fromRGB(97,122,169)
        local sample = pages.overview:FindFirstChildWhichIsA("Frame")
        if sample then
            panel = sample.BackgroundColor3
            local st = sample:FindFirstChildOfClass("UIStroke")
            if st then line = st.Color end
            for _, q in ipairs(sample:GetDescendants()) do
                if q:IsA("TextLabel") and q.TextSize >= 13 then text = q.TextColor3 break end
            end
        end
        local light = panel:Lerp(hot, 0.13)
        return panel,line,hot,light,text,sub
    end
    local panelColor,lineColor,hotColor,lightColor,textColor,subColor = themeSample()

    local function newPage(name)
        local old = pageHost:FindFirstChild(name .. "Page")
        if old then old:Destroy() end
        local p = Instance.new("ScrollingFrame")
        p.Name = name .. "Page"
        p.Parent = pageHost
        p.Size = UDim2.fromScale(1,1)
        p.BackgroundTransparency = 1
        p.BorderSizePixel = 0
        p.Visible = false
        p.ScrollBarThickness = 3
        p.ScrollBarImageColor3 = hotColor
        local pad = Instance.new("UIPadding", p)
        pad.PaddingRight = UDim.new(0,4)
        local list = Instance.new("UIListLayout", p)
        list.SortOrder = Enum.SortOrder.LayoutOrder
        list.Padding = UDim.new(0,10)
        list:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            p.CanvasSize = UDim2.new(0,0,0,list.AbsoluteContentSize.Y + 12)
        end)
        pages[name] = p
        return p
    end

    local function makeCard(page, h)
        local f = Instance.new("Frame")
        f.Parent = page
        f.Size = UDim2.new(1,-6,0,h or 56)
        f.BackgroundColor3 = panelColor
        f.BorderSizePixel = 0
        corner(f,14)
        stroke(f,lineColor,0.2,1)
        return f
    end

    local function cloneNavButton(labelText, desiredOrder)
        -- delete previous V20/legacy button of same name
        for _, b in ipairs(nav:GetChildren()) do
            if b:IsA("TextButton") and norm(b.Text) == norm(labelText) then b:Destroy() end
        end
        local template
        for _, b in ipairs(nav:GetChildren()) do
            if b:IsA("TextButton") and norm(b.Text) == "overview" then template = b break end
        end
        if not template then return nil end
        local b = template:Clone()
        b.Name = labelText:gsub("%s+", "") .. "NavV20"
        b.Text = "♥  " .. labelText
        b.LayoutOrder = desiredOrder
        b.BackgroundColor3 = template.BackgroundColor3
        b.TextColor3 = template.TextColor3
        b.Parent = nav
        return b
    end

    local function navState(button, active)
        panelColor,lineColor,hotColor,lightColor,textColor,subColor = themeSample()
        button.BackgroundColor3 = active and hotColor or panelColor
        button.TextColor3 = active and Color3.fromRGB(250,252,255) or textColor
        local st = button:FindFirstChildOfClass("UIStroke")
        if st then st.Color = active and hotColor or lineColor end
    end

    local existingButtons = {}
    for _, b in ipairs(nav:GetChildren()) do
        if b:IsA("TextButton") then table.insert(existingButtons,b) end
    end
    local allPages = {}
    for _, p in pairs(pages) do table.insert(allPages,p) end

    local fogOrder = 10
    for _, b in ipairs(existingButtons) do
        if norm(b.Text) == "fog / atmosphere" then fogOrder = b.LayoutOrder end
    end
    for _, b in ipairs(existingButtons) do
        if b.LayoutOrder > fogOrder then b.LayoutOrder += 2 end
    end

    -- ======================== ENVIRONMENT ========================
    local envPage = newPage("environment")
    table.insert(allPages, envPage)
    local envBtn = cloneNavButton("environment", fogOrder + 1)

    local envIntro = makeCard(envPage, 82)
    local eTitle = Instance.new("TextLabel", envIntro)
    eTitle.Size = UDim2.new(1,-24,0,28); eTitle.Position = UDim2.fromOffset(12,10); eTitle.BackgroundTransparency=1
    eTitle.Text="♥  environment"; eTitle.Font=Enum.Font.FredokaOne; eTitle.TextSize=21; eTitle.TextColor3=hotColor; eTitle.TextXAlignment=Enum.TextXAlignment.Left
    local eSub = Instance.new("TextLabel", envIntro)
    eSub.Size=UDim2.new(1,-24,0,34); eSub.Position=UDim2.fromOffset(12,41); eSub.BackgroundTransparency=1
    eSub.Text="Cute local seasonal looks for the map. Normal always restores the exact map look from when Kimqetras HC loaded."
    eSub.TextWrapped=true; eSub.Font=Enum.Font.Gotham; eSub.TextSize=12; eSub.TextColor3=subColor; eSub.TextXAlignment=Enum.TextXAlignment.Left; eSub.TextYAlignment=Enum.TextYAlignment.Top

    local presetInfo = {
        Normal={desc="restore the original map, lighting, grass, and weather"},
        Christmas={desc="soft bright winter lighting, snowy ground, and layered falling snow"},
        Halloween={desc="cute autumn grass with warm sunset lighting — spooky, not super dark"},
    }
    local presetButtons = {}
    for _, name in ipairs({"Normal","Christmas","Halloween"}) do
        local row = makeCard(envPage,62)
        local t = Instance.new("TextLabel",row); t.Size=UDim2.new(0.32,-12,0,22); t.Position=UDim2.fromOffset(12,8); t.BackgroundTransparency=1; t.Text=name; t.TextColor3=textColor; t.Font=Enum.Font.GothamBold; t.TextSize=15; t.TextXAlignment=Enum.TextXAlignment.Left
        local d = Instance.new("TextLabel",row); d.Size=UDim2.new(0.69,-130,0,22); d.Position=UDim2.fromOffset(12,31); d.BackgroundTransparency=1; d.Text=presetInfo[name].desc; d.TextColor3=subColor; d.Font=Enum.Font.Gotham; d.TextSize=11; d.TextXAlignment=Enum.TextXAlignment.Left
        local choose=Instance.new("TextButton",row); choose.Size=UDim2.fromOffset(112,34); choose.Position=UDim2.new(1,-124,0.5,-17); choose.BackgroundColor3=lightColor; choose.BorderSizePixel=0; choose.Text="choose"; choose.TextColor3=textColor; choose.Font=Enum.Font.GothamBold; choose.TextSize=12; choose.AutoButtonColor=false; corner(choose,10); stroke(choose,lineColor,0.3,1)
        presetButtons[name]={row=row,title=t,desc=d,button=choose}
    end
    local envStatusCard=makeCard(envPage,52)
    local est=Instance.new("TextLabel",envStatusCard); est.Size=UDim2.fromOffset(120,52); est.Position=UDim2.fromOffset(12,0); est.BackgroundTransparency=1; est.Text="Environment"; est.Font=Enum.Font.GothamBold; est.TextSize=14; est.TextColor3=textColor; est.TextXAlignment=Enum.TextXAlignment.Left
    local es=Instance.new("TextLabel",envStatusCard); es.Size=UDim2.new(1,-150,1,0); es.Position=UDim2.fromOffset(140,0); es.BackgroundTransparency=1; es.Text="Normal"; es.Font=Enum.Font.Gotham; es.TextSize=13; es.TextColor3=subColor; es.TextXAlignment=Enum.TextXAlignment.Left

    -- snapshot exact map state ONCE before seasonal edits
    local originalLighting = {
        Ambient=Lighting.Ambient, OutdoorAmbient=Lighting.OutdoorAmbient, Brightness=Lighting.Brightness,
        ClockTime=Lighting.ClockTime, FogColor=Lighting.FogColor, FogStart=Lighting.FogStart, FogEnd=Lighting.FogEnd,
        ExposureCompensation=Lighting.ExposureCompensation,
        Grass=terrain and terrain:GetMaterialColor(Enum.Material.Grass) or nil,
        Ground=terrain and terrain:GetMaterialColor(Enum.Material.Ground) or nil,
    }
    local originalAtmospheres={}
    for _,a in ipairs(Lighting:GetChildren()) do
        if a:IsA("Atmosphere") then originalAtmospheres[a]={Color=a.Color,Density=a.Density,Haze=a.Haze,Glare=a.Glare,Offset=a.Offset} end
    end
    local changedParts={}
    local envFolder=workspace:FindFirstChild("KimqV20Environment")
    if envFolder then envFolder:Destroy() end
    envFolder=Instance.new("Folder",workspace); envFolder.Name="KimqV20Environment"
    local followConn
    local activePreset="Normal"

    local function isGrassLike(p)
        if not p:IsA("BasePart") or p:IsDescendantOf(envFolder) then return false end
        local n=p.Name:lower()
        if p.Material==Enum.Material.Grass or n:find("grass",1,true) or n:find("lawn",1,true) or n:find("turf",1,true) then return true end
        local c=p.Color
        local flat=(p.Size.Y <= 4.5 and (p.Size.X >= 7 or p.Size.Z >= 7))
        local green=(c.G > c.R*1.18 and c.G > c.B*1.10 and c.G > 0.26)
        return flat and green
    end
    local function recolorGround(color, material)
        local count=0
        for _,p in ipairs(workspace:GetDescendants()) do
            if isGrassLike(p) then
                if not changedParts[p] then changedParts[p]={Color=p.Color,Material=p.Material} end
                p.Color=color
                if material then p.Material=material end
                count += 1
                if count >= 3000 then break end
            end
        end
    end
    local function clearSeasonFX()
        if followConn then pcall(function() followConn:Disconnect() end); followConn=nil end
        if envFolder then envFolder:ClearAllChildren() end
        local cc=Lighting:FindFirstChild("KimqV20SeasonColor") if cc then cc:Destroy() end
        local atm=Lighting:FindFirstChild("KimqV20SeasonAtmosphere") if atm then atm:Destroy() end
    end
    local function restoreEnvironment()
        clearSeasonFX()
        for p,data in pairs(changedParts) do
            if p and p.Parent then pcall(function() p.Color=data.Color; p.Material=data.Material end) end
        end
        table.clear(changedParts)
        Lighting.Ambient=originalLighting.Ambient; Lighting.OutdoorAmbient=originalLighting.OutdoorAmbient; Lighting.Brightness=originalLighting.Brightness
        Lighting.ClockTime=originalLighting.ClockTime; Lighting.FogColor=originalLighting.FogColor; Lighting.FogStart=originalLighting.FogStart; Lighting.FogEnd=originalLighting.FogEnd
        Lighting.ExposureCompensation=originalLighting.ExposureCompensation
        if terrain then
            if originalLighting.Grass then pcall(function() terrain:SetMaterialColor(Enum.Material.Grass,originalLighting.Grass) end) end
            if originalLighting.Ground then pcall(function() terrain:SetMaterialColor(Enum.Material.Ground,originalLighting.Ground) end) end
        end
        for a,data in pairs(originalAtmospheres) do
            if a and a.Parent then pcall(function() a.Color=data.Color; a.Density=data.Density; a.Haze=data.Haze; a.Glare=data.Glare; a.Offset=data.Offset end) end
        end
        activePreset="Normal"
    end
    local function seasonColor(tint,sat,contrast,brightness)
        local cc=Instance.new("ColorCorrectionEffect",Lighting); cc.Name="KimqV20SeasonColor"; cc.TintColor=tint; cc.Saturation=sat; cc.Contrast=contrast; cc.Brightness=brightness or 0
    end
    local function atmosphere(color,density,haze)
        local a=Instance.new("Atmosphere",Lighting); a.Name="KimqV20SeasonAtmosphere"; a.Color=color; a.Density=density; a.Haze=haze; a.Glare=0; a.Offset=0
    end
    local function makeSnow()
        local holder=Instance.new("Part",envFolder); holder.Name="SnowCloud"; holder.Size=Vector3.new(120,1,120); holder.Transparency=1; holder.Anchored=true; holder.CanCollide=false; holder.CanTouch=false; holder.CanQuery=false
        local function emitter(rate,sizeMin,sizeMax,speedMin,speedMax,trans)
            local e=Instance.new("ParticleEmitter",holder); e.Texture="rbxasset://textures/particles/sparkles_main.dds"; e.Rate=rate; e.Lifetime=NumberRange.new(5.5,8); e.Speed=NumberRange.new(speedMin,speedMax); e.Acceleration=Vector3.new(0,-2.8,0); e.Drag=0.25; e.LightInfluence=0.05; e.EmissionDirection=Enum.NormalId.Bottom; e.SpreadAngle=Vector2.new(12,12); e.Rotation=NumberRange.new(0,360); e.RotSpeed=NumberRange.new(-18,18); e.Color=ColorSequence.new(Color3.fromRGB(255,255,255),Color3.fromRGB(218,237,255)); e.Size=NumberSequence.new({NumberSequenceKeypoint.new(0,sizeMin),NumberSequenceKeypoint.new(.5,sizeMax),NumberSequenceKeypoint.new(1,sizeMin*.7)}); e.Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,trans),NumberSequenceKeypoint.new(.85,trans),NumberSequenceKeypoint.new(1,1)}); return e
        end
        emitter(110,.10,.18,3.0,5.2,.08)
        emitter(42,.20,.32,2.2,4.0,.28)
        local function follow()
            local hrp=lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
            if hrp and holder.Parent then holder.CFrame=CFrame.new(hrp.Position+Vector3.new(0,42,0)) end
        end
        follow(); followConn=RunService.Heartbeat:Connect(follow)
    end
    local function refreshEnvButtons(selected)
        for name,p in pairs(presetButtons) do
            local on=name==selected
            p.button.Text=on and "selected ♥" or "choose"
            p.button.BackgroundColor3=on and hotColor or lightColor
            p.button.TextColor3=on and Color3.fromRGB(250,252,255) or textColor
        end
        es.Text=selected; es.TextColor3=selected=="Normal" and subColor or hotColor
    end
    local function applyEnvironment(name)
        restoreEnvironment()
        activePreset=name
        if name=="Christmas" then
            if terrain then
                pcall(function() terrain:SetMaterialColor(Enum.Material.Grass,Color3.fromRGB(235,244,251)) end)
                pcall(function() terrain:SetMaterialColor(Enum.Material.Ground,Color3.fromRGB(222,234,244)) end)
            end
            recolorGround(Color3.fromRGB(235,243,250),Enum.Material.Snow)
            -- bright, natural winter instead of fake blue lighting
            Lighting.Ambient=originalLighting.Ambient:Lerp(Color3.fromRGB(205,220,238),0.32)
            Lighting.OutdoorAmbient=originalLighting.OutdoorAmbient:Lerp(Color3.fromRGB(225,236,248),0.42)
            Lighting.Brightness=math.max(originalLighting.Brightness,2.0)
            Lighting.ExposureCompensation=originalLighting.ExposureCompensation+0.08
            Lighting.FogColor=Color3.fromRGB(226,238,248); Lighting.FogStart=160; Lighting.FogEnd=1100
            atmosphere(Color3.fromRGB(226,238,248),0.08,0.45)
            seasonColor(Color3.fromRGB(241,248,255),-0.05,0.02,0.01)
            makeSnow()
        elseif name=="Halloween" then
            if terrain then
                pcall(function() terrain:SetMaterialColor(Enum.Material.Grass,Color3.fromRGB(177,112,63)) end)
                pcall(function() terrain:SetMaterialColor(Enum.Material.Ground,Color3.fromRGB(126,92,69)) end)
            end
            recolorGround(Color3.fromRGB(181,112,59),nil)
            -- warm autumn dusk, intentionally not very dark
            Lighting.Ambient=originalLighting.Ambient:Lerp(Color3.fromRGB(145,101,139),0.25)
            Lighting.OutdoorAmbient=originalLighting.OutdoorAmbient:Lerp(Color3.fromRGB(180,116,101),0.26)
            Lighting.Brightness=math.max(originalLighting.Brightness*0.92,1.7)
            Lighting.ClockTime=17.35
            Lighting.ExposureCompensation=originalLighting.ExposureCompensation-0.03
            Lighting.FogColor=Color3.fromRGB(171,108,101); Lighting.FogStart=140; Lighting.FogEnd=900
            atmosphere(Color3.fromRGB(206,141,116),0.09,0.65)
            seasonColor(Color3.fromRGB(255,222,196),0.05,0.04,0)
        end
        refreshEnvButtons(name)
    end
    for name,p in pairs(presetButtons) do
        p.button.MouseButton1Click:Connect(function() applyEnvironment(name) end)
        local sc=Instance.new("UIScale",p.button)
        p.button.MouseEnter:Connect(function() TweenService:Create(sc,TweenInfo.new(.14,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Scale=1.025}):Play() end)
        p.button.MouseLeave:Connect(function() TweenService:Create(sc,TweenInfo.new(.16,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Scale=1}):Play() end)
    end

    -- ======================== WEAPON SKINS ========================
    local skinPage = newPage("weaponskins")
    table.insert(allPages,skinPage)
    local skinBtn = cloneNavButton("weapon skins", fogOrder + 2)

    local sIntro=makeCard(skinPage,74)
    local sit=Instance.new("TextLabel",sIntro); sit.Size=UDim2.new(1,-24,0,26); sit.Position=UDim2.fromOffset(12,8); sit.BackgroundTransparency=1; sit.Text="♥  weapon skins"; sit.Font=Enum.Font.FredokaOne; sit.TextSize=21; sit.TextColor3=hotColor; sit.TextXAlignment=Enum.TextXAlignment.Left
    local sis=Instance.new("TextLabel",sIntro); sis.Size=UDim2.new(1,-24,0,28); sis.Position=UDim2.fromOffset(12,38); sis.BackgroundTransparency=1; sis.Text="Pick a weapon, then choose one of that weapon's own wraps. The change is local to your screen."; sis.TextWrapped=true; sis.Font=Enum.Font.Gotham; sis.TextSize=12; sis.TextColor3=subColor; sis.TextXAlignment=Enum.TextXAlignment.Left

    local wrapRoot=workspace:FindFirstChild("Wraps")
    local weaponFolders={}
    if wrapRoot then
        for _,folder in ipairs(wrapRoot:GetChildren()) do
            if folder:IsA("Folder") then
                local usable=false
                for _,skin in ipairs(folder:GetChildren()) do if skin:FindFirstChild("Handle") then usable=true break end end
                if usable then table.insert(weaponFolders,folder) end
            end
        end
    end
    table.sort(weaponFolders,function(a,b) return a.Name:lower()<b.Name:lower() end)
    local folderByName={}; for _,f in ipairs(weaponFolders) do folderByName[f.Name]=f end
    _G.KimqV20WeaponSkins=_G.KimqV20WeaponSkins or {Selected={},Weapon=nil}
    local selectedByWeapon=_G.KimqV20WeaponSkins.Selected
    local currentWeapon=_G.KimqV20WeaponSkins.Weapon
    if not currentWeapon or not folderByName[currentWeapon] then currentWeapon=weaponFolders[1] and weaponFolders[1].Name end

    local function displayWeapon(n) return tostring(n or ""):gsub("%[",""):gsub("%]","") end
    local function findTool(n)
        return (lp.Character and lp.Character:FindFirstChild(n)) or (lp:FindFirstChildOfClass("Backpack") and lp.Backpack:FindFirstChild(n))
    end
    local function clearVisual(tool)
        if not tool then return end
        local h=tool:FindFirstChild("Handle")
        if h and h:IsA("BasePart") then pcall(function() h.LocalTransparencyModifier=0 end) end
        for _,ch in ipairs(tool:GetChildren()) do if ch.Name=="KimqV20SkinVisual" then ch:Destroy() end end
    end
    local function skinHandle(w,s)
        local wf=folderByName[w]; local sf=wf and wf:FindFirstChild(s); return sf and sf:FindFirstChild("Handle")
    end
    local skinStatusText="Ready"
    local statusLabel
    local function setSkinStatus(t,good) skinStatusText=t; if statusLabel then statusLabel.Text=t; statusLabel.TextColor3=good and hotColor or subColor end end
    local function applySkin(w,s,tool,quiet)
        local gun=tool or findTool(w)
        if not gun then if not quiet then setSkinStatus(displayWeapon(w).." is not in Backpack / Character",false) end return false end
        local target=gun:FindFirstChild("Handle")
        local source=skinHandle(w,s)
        if not target or not target:IsA("BasePart") or not source or not source:IsA("BasePart") then if not quiet then setSkinStatus("That wrap does not have a usable Handle",false) end return false end
        clearVisual(gun)
        local visual=source:Clone(); visual.Name="KimqV20SkinVisual"; visual.Anchored=false; visual.CanCollide=false; visual.CanTouch=false; visual.CanQuery=false; visual.Massless=true
        for _,d in ipairs(visual:GetDescendants()) do
            if d:IsA("Script") or d:IsA("LocalScript") or d:IsA("ModuleScript") then d:Destroy() elseif d:IsA("BasePart") then d.Anchored=false; d.CanCollide=false; d.CanTouch=false; d.CanQuery=false; d.Massless=true end
        end
        visual.CFrame=target.CFrame; visual.Parent=gun
        local weld=Instance.new("WeldConstraint",visual); weld.Name="KimqV20SkinWeld"; weld.Part0=visual; weld.Part1=target
        pcall(function() target.LocalTransparencyModifier=1 end)
        selectedByWeapon[w]=s; _G.KimqV20WeaponSkins.Weapon=w
        if not quiet then setSkinStatus(displayWeapon(w).." • "..s.." applied locally",true) end
        return true
    end
    local function resetWeapon(w)
        selectedByWeapon[w]=nil; clearVisual(findTool(w)); setSkinStatus(displayWeapon(w).." reset",true)
    end

    local weaponCard=makeCard(skinPage,104)
    local wt=Instance.new("TextLabel",weaponCard); wt.Size=UDim2.new(1,-24,0,22); wt.Position=UDim2.fromOffset(12,8); wt.BackgroundTransparency=1; wt.Text="Weapon"; wt.Font=Enum.Font.GothamBold; wt.TextSize=14; wt.TextColor3=textColor; wt.TextXAlignment=Enum.TextXAlignment.Left
    local weaponRow=Instance.new("ScrollingFrame",weaponCard); weaponRow.Size=UDim2.new(1,-20,0,56); weaponRow.Position=UDim2.fromOffset(10,36); weaponRow.BackgroundTransparency=1; weaponRow.BorderSizePixel=0; weaponRow.ScrollBarThickness=2; weaponRow.ScrollBarImageColor3=hotColor
    local wlay=Instance.new("UIListLayout",weaponRow); wlay.FillDirection=Enum.FillDirection.Horizontal; wlay.Padding=UDim.new(0,6); wlay.SortOrder=Enum.SortOrder.LayoutOrder
    wlay:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() weaponRow.CanvasSize=UDim2.new(0,wlay.AbsoluteContentSize.X+6,0,0) end)

    local searchCard=makeCard(skinPage,52)
    local sl=Instance.new("TextLabel",searchCard); sl.Size=UDim2.fromOffset(110,52); sl.Position=UDim2.fromOffset(12,0); sl.BackgroundTransparency=1; sl.Text="Search skins"; sl.Font=Enum.Font.GothamBold; sl.TextSize=14; sl.TextColor3=textColor; sl.TextXAlignment=Enum.TextXAlignment.Left
    local search=Instance.new("TextBox",searchCard); search.Size=UDim2.new(1,-148,0,34); search.Position=UDim2.new(0,136,.5,-17); search.BackgroundColor3=lightColor; search.BorderSizePixel=0; search.PlaceholderText="type a skin name..."; search.PlaceholderColor3=subColor; search.Text=""; search.TextColor3=textColor; search.Font=Enum.Font.Gotham; search.TextSize=13; search.ClearTextOnFocus=false; corner(search,10); stroke(search,lineColor,.3,1)

    local listCard=makeCard(skinPage,230)
    local skinList=Instance.new("ScrollingFrame",listCard); skinList.Size=UDim2.new(1,-18,1,-18); skinList.Position=UDim2.fromOffset(9,9); skinList.BackgroundTransparency=1; skinList.BorderSizePixel=0; skinList.ScrollBarThickness=3; skinList.ScrollBarImageColor3=hotColor
    local grid=Instance.new("UIGridLayout",skinList); grid.CellPadding=UDim2.fromOffset(7,7); grid.CellSize=UDim2.new(.32,-4,0,38); grid.SortOrder=Enum.SortOrder.LayoutOrder
    grid:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() skinList.CanvasSize=UDim2.new(0,0,0,grid.AbsoluteContentSize.Y+8) end)

    local action=makeCard(skinPage,52)
    local apply=Instance.new("TextButton",action); apply.Size=UDim2.new(.65,-14,0,34); apply.Position=UDim2.new(0,10,.5,-17); apply.BackgroundColor3=hotColor; apply.BorderSizePixel=0; apply.Text="♥  Apply Selected Skin"; apply.TextColor3=Color3.fromRGB(250,252,255); apply.Font=Enum.Font.GothamBold; apply.TextSize=13; corner(apply,10)
    local reset=Instance.new("TextButton",action); reset.Size=UDim2.new(.35,-14,0,34); reset.Position=UDim2.new(.65,4,.5,-17); reset.BackgroundColor3=lightColor; reset.BorderSizePixel=0; reset.Text="Reset Weapon"; reset.TextColor3=textColor; reset.Font=Enum.Font.GothamBold; reset.TextSize=12; corner(reset,10); stroke(reset,lineColor,.3,1)
    local statusCard=makeCard(skinPage,48)
    statusLabel=Instance.new("TextLabel",statusCard); statusLabel.Size=UDim2.new(1,-24,1,0); statusLabel.Position=UDim2.fromOffset(12,0); statusLabel.BackgroundTransparency=1; statusLabel.Text="Ready"; statusLabel.TextColor3=subColor; statusLabel.Font=Enum.Font.Gotham; statusLabel.TextSize=12; statusLabel.TextXAlignment=Enum.TextXAlignment.Left

    local weaponButtons={}; local skinButtons={}; local selectedSkin=nil
    local function refreshWeaponButtons()
        for n,b in pairs(weaponButtons) do local on=n==currentWeapon; b.BackgroundColor3=on and hotColor or lightColor; b.TextColor3=on and Color3.fromRGB(250,252,255) or textColor end
    end
    local function buildSkins(filter)
        for _,ch in ipairs(skinList:GetChildren()) do if ch:IsA("TextButton") then ch:Destroy() end end
        table.clear(skinButtons); selectedSkin=selectedByWeapon[currentWeapon]
        local wf=folderByName[currentWeapon]; if not wf then return end
        local skins={}; for _,s in ipairs(wf:GetChildren()) do if s:FindFirstChild("Handle") then table.insert(skins,s) end end
        table.sort(skins,function(a,b) return a.Name:lower()<b.Name:lower() end)
        local idx=0
        for _,sf in ipairs(skins) do
            if filter=="" or sf.Name:lower():find(filter:lower(),1,true) then
                idx+=1; local n=sf.Name; local b=Instance.new("TextButton",skinList); b.LayoutOrder=idx; b.BackgroundColor3=n==selectedSkin and hotColor or lightColor; b.BorderSizePixel=0; b.Text=n; b.TextColor3=n==selectedSkin and Color3.fromRGB(250,252,255) or textColor; b.Font=Enum.Font.GothamBold; b.TextSize=11; corner(b,10); stroke(b,lineColor,.35,1)
                b.MouseButton1Click:Connect(function() selectedSkin=n; for sn,sb in pairs(skinButtons) do local on=sn==n; sb.BackgroundColor3=on and hotColor or lightColor; sb.TextColor3=on and Color3.fromRGB(250,252,255) or textColor end; setSkinStatus("Selected "..n,true) end)
                skinButtons[n]=b
            end
        end
    end
    for i,wf in ipairs(weaponFolders) do
        local n=wf.Name; local b=Instance.new("TextButton",weaponRow); b.LayoutOrder=i; b.Size=UDim2.fromOffset(128,38); b.BackgroundColor3=lightColor; b.BorderSizePixel=0; b.Text=displayWeapon(n); b.TextColor3=textColor; b.Font=Enum.Font.GothamBold; b.TextSize=12; corner(b,10); stroke(b,lineColor,.3,1)
        b.MouseButton1Click:Connect(function() currentWeapon=n; _G.KimqV20WeaponSkins.Weapon=n; search.Text=""; refreshWeaponButtons(); buildSkins(""); setSkinStatus("Selected "..displayWeapon(n),true) end)
        weaponButtons[n]=b
    end
    search:GetPropertyChangedSignal("Text"):Connect(function() buildSkins(search.Text) end)
    apply.MouseButton1Click:Connect(function() if not currentWeapon then setSkinStatus("No weapon folder found",false) elseif not selectedSkin then setSkinStatus("Choose a skin first",false) else applySkin(currentWeapon,selectedSkin,nil,false) end end)
    reset.MouseButton1Click:Connect(function() if currentWeapon then resetWeapon(currentWeapon); selectedSkin=nil; buildSkins(search.Text) end end)
    refreshWeaponButtons(); buildSkins("")

    local function hookContainer(container)
        if not container then return end
        container.ChildAdded:Connect(function(ch)
            local skin=selectedByWeapon[ch.Name]
            if skin then task.defer(function() task.wait(.08); applySkin(ch.Name,skin,ch,true) end) end
        end)
    end
    hookContainer(lp:FindFirstChildOfClass("Backpack")); if lp.Character then hookContainer(lp.Character) end
    lp.CharacterAdded:Connect(function(char)
        hookContainer(char); task.delay(1,function()
            local bp=lp:FindFirstChildOfClass("Backpack"); hookContainer(bp)
            for w,s in pairs(selectedByWeapon) do local t=findTool(w); if t then applySkin(w,s,t,true) end end
        end)
    end)

    -- Navigation behavior that does NOT recolor unrelated buttons permanently.
    local specialButtons={envBtn,skinBtn}
    local function showSpecial(page,btn,title,desc)
        for _,p in ipairs(allPages) do p.Visible=(p==page) end
        -- use current theme's inactive look for all existing buttons, only the selected special button is hot
        panelColor,lineColor,hotColor,lightColor,textColor,subColor=themeSample()
        for _,b in ipairs(nav:GetChildren()) do if b:IsA("TextButton") then navState(b,b==btn) end end
        if pageTitle then pageTitle.Text=title end
        if pageDesc then pageDesc.Text=desc end
    end
    if envBtn then envBtn.MouseButton1Click:Connect(function() showSpecial(envPage,envBtn,"environment","cute seasonal map styles and local weather") end) end
    if skinBtn then skinBtn.MouseButton1Click:Connect(function() showSpecial(skinPage,skinBtn,"weapon skins","pick a weapon, then choose one of its matching local wraps") end) end
    for _,b in ipairs(nav:GetChildren()) do
        if b:IsA("TextButton") and b~=envBtn and b~=skinBtn then
            b.MouseButton1Click:Connect(function() envPage.Visible=false; skinPage.Visible=false; if envBtn then navState(envBtn,false) end; if skinBtn then navState(skinBtn,false) end end)
        end
    end

    local function syncTheme()
        panelColor,lineColor,hotColor,lightColor,textColor,subColor=themeSample()
        envPage.ScrollBarImageColor3=hotColor; skinPage.ScrollBarImageColor3=hotColor; weaponRow.ScrollBarImageColor3=hotColor; skinList.ScrollBarImageColor3=hotColor
        eTitle.TextColor3=hotColor; eSub.TextColor3=subColor; sit.TextColor3=hotColor; sis.TextColor3=subColor
        for _,f in ipairs({envIntro,envStatusCard,sIntro,weaponCard,searchCard,listCard,action,statusCard}) do f.BackgroundColor3=panelColor; local st=f:FindFirstChildOfClass("UIStroke"); if st then st.Color=lineColor end end
        for _,p in pairs(presetButtons) do p.row.BackgroundColor3=panelColor; local st=p.row:FindFirstChildOfClass("UIStroke"); if st then st.Color=lineColor end; p.title.TextColor3=textColor; p.desc.TextColor3=subColor end
        est.TextColor3=textColor; sl.TextColor3=textColor; wt.TextColor3=textColor
        search.BackgroundColor3=lightColor; search.TextColor3=textColor; search.PlaceholderColor3=subColor
        apply.BackgroundColor3=hotColor; reset.BackgroundColor3=lightColor; reset.TextColor3=textColor
        if envBtn then navState(envBtn,envPage.Visible) end; if skinBtn then navState(skinBtn,skinPage.Visible) end
        refreshEnvButtons(activePreset); refreshWeaponButtons(); buildSkins(search.Text)
    end
    if badge then
        badge.Text="V20 ♥"
        badge:GetPropertyChangedSignal("BackgroundColor3"):Connect(function() task.defer(syncTheme) end)
    end
    syncTheme()
    refreshEnvButtons("Normal")

    _G.KimqEnvironmentController={Apply=applyEnvironment,Restore=restoreEnvironment,GetPreset=function() return activePreset end}
    _G.KimqV20Ready=true
end)


-- ========================================================
-- V21: consistent cute pages, fog-friendly seasons, reliable weapon/skin picker.
-- ========================================================
task.spawn(function()
    local Players=game:GetService("Players")
    local CoreGui=game:GetService("CoreGui")
    local Lighting=game:GetService("Lighting")
    local RunService=game:GetService("RunService")
    local TweenService=game:GetService("TweenService")
    local lp=Players.LocalPlayer
    local pg=lp:WaitForChild("PlayerGui")
    local terrain=workspace:FindFirstChildOfClass("Terrain")

    local loader=_G.KimqV21Loader
    local function progress(text,amount)
        if loader and loader.Status and loader.Status.Parent then loader.Status.Text=text end
        if loader and loader.Bar and loader.Bar.Parent then TweenService:Create(loader.Bar,TweenInfo.new(.25,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Size=UDim2.new(amount,0,1,0)}):Play() end
    end

    task.wait(9.2)
    progress("polishing the environment page...",.45)

    local root=CoreGui:FindFirstChild("KimpetrasHC") or pg:FindFirstChild("KimpetrasHC")
    local main=root and root:FindFirstChild("Main")
    if not main then if loader and loader.Gui then loader.Gui:Destroy() end return end

    -- restore/remove the V20 seasonal effect before replacing it
    pcall(function() if _G.KimqEnvironmentController and _G.KimqEnvironmentController.Restore then _G.KimqEnvironmentController.Restore() end end)
    local oldEnvFolder=workspace:FindFirstChild("KimqV20Environment")
    if oldEnvFolder then pcall(function() oldEnvFolder:Destroy() end) end

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

    local pages={}; local pageHost
    for _,d in ipairs(main:GetDescendants()) do
        if d:IsA("ScrollingFrame") and d.Name:match("Page$") then pages[d.Name:gsub("Page$",""):lower()]=d; pageHost=d.Parent end
    end
    if not pageHost or not pages.overview then if loader and loader.Gui then loader.Gui:Destroy() end return end

    local nav
    for _,d in ipairs(main:GetDescendants()) do
        if d:IsA("ScrollingFrame") and not d.Name:match("Page$") then
            for _,b in ipairs(d:GetChildren()) do if b:IsA("TextButton") and norm(b.Text)=="overview" then nav=d break end end
        end
        if nav then break end
    end
    if not nav then if loader and loader.Gui then loader.Gui:Destroy() end return end

    local badge
    for _,d in ipairs(main:GetDescendants()) do if d:IsA("TextLabel") and tostring(d.Text or ""):match("^V%d+") then badge=d break end end
    local pageTitle,pageDesc
    for _,d in ipairs(main:GetDescendants()) do
        if d:IsA("TextLabel") then
            if norm(d.Text)=="overview" and d.TextSize>=18 then pageTitle=d end
            if tostring(d.Text or ""):lower():find("your account",1,true) then pageDesc=d end
        end
    end

    local activeTemplate,inactiveTemplate
    for _,b in ipairs(nav:GetChildren()) do
        if b:IsA("TextButton") then
            if norm(b.Text)=="overview" then activeTemplate=b end
            if norm(b.Text)=="silent aim" then inactiveTemplate=b end
        end
    end
    inactiveTemplate=inactiveTemplate or activeTemplate
    if not inactiveTemplate then if loader and loader.Gui then loader.Gui:Destroy() end return end

    local function copyVisual(dst,src)
        if not dst or not src then return end
        dst.BackgroundColor3=src.BackgroundColor3
        dst.BackgroundTransparency=src.BackgroundTransparency
        dst.TextColor3=src.TextColor3
        dst.TextStrokeColor3=src.TextStrokeColor3
        dst.TextStrokeTransparency=src.TextStrokeTransparency
        dst.Font=src.Font; dst.TextSize=src.TextSize
        local ds=dst:FindFirstChildOfClass("UIStroke"); local ss=src:FindFirstChildOfClass("UIStroke")
        if ss then
            ds=ds or Instance.new("UIStroke",dst); ds.Color=ss.Color; ds.Transparency=ss.Transparency; ds.Thickness=ss.Thickness
        end
    end

    local function sampleTheme()
        local panel=inactiveTemplate.BackgroundColor3
        local line=(inactiveTemplate:FindFirstChildOfClass("UIStroke") and inactiveTemplate:FindFirstChildOfClass("UIStroke").Color) or Color3.fromRGB(137,176,230)
        local hot=(badge and badge.BackgroundColor3) or (activeTemplate and activeTemplate.BackgroundColor3) or Color3.fromRGB(49,93,255)
        local text=inactiveTemplate.TextColor3
        local sub=Color3.fromRGB(97,122,169)
        for _,d in ipairs(pages.overview:GetDescendants()) do
            if d:IsA("TextLabel") and d.TextSize<=13 and d.TextColor3~=text then sub=d.TextColor3 break end
        end
        local light=panel:Lerp(hot,.12)
        return panel,line,hot,light,text,sub
    end
    local panelColor,lineColor,hotColor,lightColor,textColor,subColor=sampleTheme()

    -- remove old V20 special buttons/pages so their click/theme handlers cannot interfere
    for _,b in ipairs(nav:GetChildren()) do
        if b:IsA("TextButton") and (norm(b.Text)=="environment" or norm(b.Text)=="weapon skins") then pcall(function() b:Destroy() end) end
    end
    for _,name in ipairs({"environmentPage","weaponskinsPage"}) do
        local p=pageHost:FindFirstChild(name); if p then p:Destroy() end
    end

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
    local function txt(parent,text,size,pos,font,ts,color,align)
        local l=Instance.new("TextLabel",parent); l.Size=size; l.Position=pos; l.BackgroundTransparency=1; l.Text=text; l.Font=font; l.TextSize=ts; l.TextColor3=color; l.TextXAlignment=align or Enum.TextXAlignment.Left; return l
    end

    local fogOrder=10
    for _,b in ipairs(nav:GetChildren()) do if b:IsA("TextButton") and norm(b.Text)=="fog / atmosphere" then fogOrder=b.LayoutOrder end end
    for _,b in ipairs(nav:GetChildren()) do if b:IsA("TextButton") and b.LayoutOrder>fogOrder then b.LayoutOrder+=2 end end

    local function makeSpecialNav(labelText,order)
        local b=inactiveTemplate:Clone(); b.Name=labelText:gsub("%s+","").."NavV21"; b.Text="♥  "..labelText; b.LayoutOrder=order; b.Parent=nav; copyVisual(b,inactiveTemplate); return b
    end

    local envPage=newPage("environment")
    local skinPage=newPage("weaponskins")
    local envBtn=makeSpecialNav("environment",fogOrder+1)
    local skinBtn=makeSpecialNav("weapon skins",fogOrder+2)

    local normalPages={}
    for k,p in pairs(pages) do if p~=envPage and p~=skinPage then table.insert(normalPages,p) end end

    local function setSpecialVisual(btn,active)
        copyVisual(btn,active and activeTemplate or inactiveTemplate)
        btn.Text="♥  "..(btn==envBtn and "environment" or "weapon skins")
    end
    setSpecialVisual(envBtn,false); setSpecialVisual(skinBtn,false)

    -- ENVIRONMENT -------------------------------------------------
    local intro=card(envPage,80)
    local envTitle=txt(intro,"♥  environment",UDim2.new(1,-24,0,28),UDim2.fromOffset(12,9),Enum.Font.FredokaOne,21,hotColor)
    local envSub=txt(intro,"Seasonal map styles that stay compatible with your Fog / Atmosphere controls.",UDim2.new(1,-24,0,30),UDim2.fromOffset(12,40),Enum.Font.Gotham,12,subColor); envSub.TextWrapped=true

    local presetRows={}
    local presetText={
        Normal="restore the original grass, lighting, and weather",
        Christmas="bright snowy ground with soft layered falling snow",
        Halloween="warm cute autumn colors — cozy, not super dark",
    }
    for _,name in ipairs({"Normal","Christmas","Halloween"}) do
        local r=card(envPage,62)
        local a=txt(r,name,UDim2.new(.35,-12,0,22),UDim2.fromOffset(12,7),Enum.Font.GothamBold,15,textColor)
        local d=txt(r,presetText[name],UDim2.new(1,-160,0,22),UDim2.fromOffset(12,31),Enum.Font.Gotham,11,subColor)
        local b=Instance.new("TextButton",r); b.Size=UDim2.fromOffset(116,34); b.Position=UDim2.new(1,-128,.5,-17); b.BackgroundColor3=lightColor; b.BorderSizePixel=0; b.Text="choose"; b.TextColor3=textColor; b.Font=Enum.Font.GothamBold; b.TextSize=12; b.AutoButtonColor=false; corner(b,10); stroke(b,lineColor,.3,1)
        presetRows[name]={row=r,title=a,desc=d,button=b}
    end
    local envStatus=card(envPage,52)
    local envStatusName=txt(envStatus,"Environment",UDim2.fromOffset(120,52),UDim2.fromOffset(12,0),Enum.Font.GothamBold,14,textColor)
    local envStatusValue=txt(envStatus,"Normal",UDim2.new(1,-150,1,0),UDim2.fromOffset(140,0),Enum.Font.Gotham,13,subColor)

    local original={Ambient=Lighting.Ambient,OutdoorAmbient=Lighting.OutdoorAmbient,Brightness=Lighting.Brightness,ClockTime=Lighting.ClockTime,Exposure=Lighting.ExposureCompensation,Grass=terrain and terrain:GetMaterialColor(Enum.Material.Grass),Ground=terrain and terrain:GetMaterialColor(Enum.Material.Ground)}
    local changedParts={}
    local activePreset="Normal"
    local seasonFolder=workspace:FindFirstChild("KimqV21Environment")
    if seasonFolder then seasonFolder:Destroy() end
    seasonFolder=Instance.new("Folder",workspace); seasonFolder.Name="KimqV21Environment"
    local followConn

    local function grassLike(p)
        if not p:IsA("BasePart") or p:IsDescendantOf(seasonFolder) then return false end
        local n=p.Name:lower(); if p.Material==Enum.Material.Grass or n:find("grass",1,true) or n:find("lawn",1,true) or n:find("turf",1,true) then return true end
        local c=p.Color; local flat=p.Size.Y<=4.5 and (p.Size.X>=7 or p.Size.Z>=7); local green=c.G>c.R*1.15 and c.G>c.B*1.08 and c.G>.24
        return flat and green
    end
    local function recolor(color,material)
        local count=0
        for _,p in ipairs(workspace:GetDescendants()) do
            if grassLike(p) then
                if not changedParts[p] then changedParts[p]={Color=p.Color,Material=p.Material} end
                p.Color=color; if material then p.Material=material end
                count+=1; if count>=3500 then break end
            end
        end
    end
    local function clearFX()
        if followConn then pcall(function() followConn:Disconnect() end); followConn=nil end
        seasonFolder:ClearAllChildren()
        local cc=Lighting:FindFirstChild("KimqV21SeasonColor"); if cc then cc:Destroy() end
    end
    local function restoreEnv()
        clearFX()
        for p,data in pairs(changedParts) do if p and p.Parent then pcall(function() p.Color=data.Color; p.Material=data.Material end) end end
        table.clear(changedParts)
        Lighting.Ambient=original.Ambient; Lighting.OutdoorAmbient=original.OutdoorAmbient; Lighting.Brightness=original.Brightness; Lighting.ClockTime=original.ClockTime; Lighting.ExposureCompensation=original.Exposure
        if terrain then pcall(function() terrain:SetMaterialColor(Enum.Material.Grass,original.Grass) end); pcall(function() terrain:SetMaterialColor(Enum.Material.Ground,original.Ground) end) end
        activePreset="Normal"
    end
    local function colorFX(tint,sat,contrast,brightness)
        local cc=Instance.new("ColorCorrectionEffect",Lighting); cc.Name="KimqV21SeasonColor"; cc.TintColor=tint; cc.Saturation=sat; cc.Contrast=contrast; cc.Brightness=brightness or 0
    end
    local function snow()
        local holder=Instance.new("Part",seasonFolder); holder.Name="SnowCloud"; holder.Size=Vector3.new(135,1,135); holder.Transparency=1; holder.Anchored=true; holder.CanCollide=false; holder.CanTouch=false; holder.CanQuery=false
        local function emitter(rate,sizeMin,sizeMax,speedMin,speedMax,spread,trans)
            local e=Instance.new("ParticleEmitter",holder); e.Texture="rbxasset://textures/particles/sparkles_main.dds"; e.Rate=rate; e.Lifetime=NumberRange.new(6,9); e.Speed=NumberRange.new(speedMin,speedMax); e.Acceleration=Vector3.new(.25,-1.8,.15); e.Drag=.35; e.LightInfluence=0; e.EmissionDirection=Enum.NormalId.Bottom; e.SpreadAngle=Vector2.new(spread,spread); e.Rotation=NumberRange.new(0,360); e.RotSpeed=NumberRange.new(-8,8); e.Color=ColorSequence.new(Color3.new(1,1,1),Color3.fromRGB(220,239,255)); e.Size=NumberSequence.new({NumberSequenceKeypoint.new(0,sizeMin),NumberSequenceKeypoint.new(.55,sizeMax),NumberSequenceKeypoint.new(1,sizeMin*.65)}); e.Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,trans),NumberSequenceKeypoint.new(.88,trans+.08),NumberSequenceKeypoint.new(1,1)}); return e
        end
        emitter(145,.07,.12,2.2,3.8,18,.08)
        emitter(58,.14,.22,1.5,2.8,24,.18)
        emitter(22,.23,.34,1.0,2.0,30,.35)
        local function follow()
            local hrp=lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
            if hrp and holder.Parent then holder.CFrame=CFrame.new(hrp.Position+Vector3.new(0,46,0)) end
        end
        follow(); followConn=RunService.RenderStepped:Connect(follow)
    end
    local function refreshPreset()
        for name,p in pairs(presetRows) do
            local on=name==activePreset; p.button.Text=on and "selected ♥" or "choose"; p.button.BackgroundColor3=on and hotColor or lightColor; p.button.TextColor3=on and Color3.fromRGB(250,252,255) or textColor
        end
        envStatusValue.Text=activePreset; envStatusValue.TextColor3=activePreset=="Normal" and subColor or hotColor
    end
    local function applyEnv(name)
        restoreEnv(); activePreset=name
        if name=="Christmas" then
            if terrain then pcall(function() terrain:SetMaterialColor(Enum.Material.Grass,Color3.fromRGB(235,243,250)) end); pcall(function() terrain:SetMaterialColor(Enum.Material.Ground,Color3.fromRGB(223,234,244)) end) end
            recolor(Color3.fromRGB(238,245,251),Enum.Material.Snow)
            Lighting.Ambient=original.Ambient:Lerp(Color3.fromRGB(218,229,241),.22); Lighting.OutdoorAmbient=original.OutdoorAmbient:Lerp(Color3.fromRGB(233,241,249),.30); Lighting.Brightness=math.max(original.Brightness,1.9); Lighting.ExposureCompensation=original.Exposure+.04
            colorFX(Color3.fromRGB(247,251,255),-.025,.015,0); snow()
        elseif name=="Halloween" then
            if terrain then pcall(function() terrain:SetMaterialColor(Enum.Material.Grass,Color3.fromRGB(183,120,70)) end); pcall(function() terrain:SetMaterialColor(Enum.Material.Ground,Color3.fromRGB(139,102,76)) end) end
            recolor(Color3.fromRGB(187,119,64),nil)
            Lighting.Ambient=original.Ambient:Lerp(Color3.fromRGB(167,116,132),.18); Lighting.OutdoorAmbient=original.OutdoorAmbient:Lerp(Color3.fromRGB(196,132,108),.18); Lighting.Brightness=math.max(original.Brightness*.96,1.75); Lighting.ClockTime=17.0; Lighting.ExposureCompensation=original.Exposure
            colorFX(Color3.fromRGB(255,227,207),.035,.025,0)
        end
        -- IMPORTANT: V21 deliberately does not touch FogColor/FogStart/FogEnd or Atmosphere.
        -- The existing Fog / Atmosphere page remains fully editable while a season is active.
        refreshPreset()
    end
    for name,p in pairs(presetRows) do p.button.MouseButton1Click:Connect(function() applyEnv(name) end) end
    refreshPreset()
    _G.KimqEnvironmentController={Apply=applyEnv,Restore=restoreEnv,GetPreset=function() return activePreset end}

    progress("building the weapon and skin picker...",.68)

    -- WEAPON SKINS ------------------------------------------------
    local sinfo=card(skinPage,78)
    local skinTitle=txt(sinfo,"♥  weapon skins",UDim2.new(1,-24,0,28),UDim2.fromOffset(12,9),Enum.Font.FredokaOne,21,hotColor)
    local skinSub=txt(sinfo,"Choose one of your weapon folders, then pick one of that weapon's matching skins.",UDim2.new(1,-24,0,30),UDim2.fromOffset(12,40),Enum.Font.Gotham,12,subColor); skinSub.TextWrapped=true

    local weaponCard=card(skinPage,126)
    txt(weaponCard,"Weapon",UDim2.new(1,-24,0,22),UDim2.fromOffset(12,8),Enum.Font.GothamBold,14,textColor)
    local weaponList=Instance.new("ScrollingFrame",weaponCard); weaponList.Size=UDim2.new(1,-20,0,76); weaponList.Position=UDim2.fromOffset(10,38); weaponList.BackgroundTransparency=1; weaponList.BorderSizePixel=0; weaponList.ScrollBarThickness=2; weaponList.ScrollBarImageColor3=hotColor
    local wgrid=Instance.new("UIGridLayout",weaponList); wgrid.CellPadding=UDim2.fromOffset(7,7); wgrid.CellSize=UDim2.new(.32,-5,0,34); wgrid.SortOrder=Enum.SortOrder.LayoutOrder
    wgrid:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() weaponList.CanvasSize=UDim2.new(0,0,0,wgrid.AbsoluteContentSize.Y+6) end)

    local skinsCard=card(skinPage,274)
    local skinsHeader=txt(skinsCard,"Skins",UDim2.new(1,-24,0,22),UDim2.fromOffset(12,8),Enum.Font.GothamBold,14,textColor)
    local skinsList=Instance.new("ScrollingFrame",skinsCard); skinsList.Size=UDim2.new(1,-20,1,-46); skinsList.Position=UDim2.fromOffset(10,38); skinsList.BackgroundTransparency=1; skinsList.BorderSizePixel=0; skinsList.ScrollBarThickness=3; skinsList.ScrollBarImageColor3=hotColor
    local sgrid=Instance.new("UIGridLayout",skinsList); sgrid.CellPadding=UDim2.fromOffset(7,7); sgrid.CellSize=UDim2.new(.32,-5,0,36); sgrid.SortOrder=Enum.SortOrder.LayoutOrder
    sgrid:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() skinsList.CanvasSize=UDim2.new(0,0,0,sgrid.AbsoluteContentSize.Y+8) end)

    local action=card(skinPage,54)
    local apply=Instance.new("TextButton",action); apply.Size=UDim2.new(.68,-14,0,34); apply.Position=UDim2.new(0,10,.5,-17); apply.BackgroundColor3=hotColor; apply.BorderSizePixel=0; apply.Text="♥  Apply Skin"; apply.TextColor3=Color3.fromRGB(250,252,255); apply.Font=Enum.Font.GothamBold; apply.TextSize=13; apply.AutoButtonColor=false; corner(apply,10)
    local reset=Instance.new("TextButton",action); reset.Size=UDim2.new(.32,-14,0,34); reset.Position=UDim2.new(.68,4,.5,-17); reset.BackgroundColor3=lightColor; reset.BorderSizePixel=0; reset.Text="Reset"; reset.TextColor3=textColor; reset.Font=Enum.Font.GothamBold; reset.TextSize=12; reset.AutoButtonColor=false; corner(reset,10); stroke(reset,lineColor,.3,1)
    local stat=card(skinPage,46)
    local skinStatus=txt(stat,"Choose a weapon to begin",UDim2.new(1,-24,1,0),UDim2.fromOffset(12,0),Enum.Font.Gotham,12,subColor)

    _G.KimqV21WeaponSkins=_G.KimqV21WeaponSkins or {Selected={}}
    local selectedByWeapon=_G.KimqV21WeaponSkins.Selected
    local currentWeapon=nil; local selectedSkin=nil; local weaponFolders={}; local folderByName={}; local weaponButtons={}; local skinButtons={}

    local function setSkinStatus(t,good) skinStatus.Text=t; skinStatus.TextColor3=good and hotColor or subColor end
    local function displayWeapon(n) return tostring(n or ""):gsub("%[",""):gsub("%]","") end
    local function findTool(n)
        return (lp.Character and lp.Character:FindFirstChild(n)) or (lp:FindFirstChildOfClass("Backpack") and lp.Backpack:FindFirstChild(n))
    end
    local function clearVisual(tool)
        if not tool then return end
        local h=tool:FindFirstChild("Handle"); if h and h:IsA("BasePart") then pcall(function() h.LocalTransparencyModifier=0 end) end
        for _,ch in ipairs(tool:GetChildren()) do if ch.Name=="KimqV21SkinVisual" then ch:Destroy() end end
    end
    local function sourceHandle(w,s)
        local wf=folderByName[w]; local sf=wf and wf:FindFirstChild(s); return sf and sf:FindFirstChild("Handle")
    end
    local function applySkin(w,s,tool,quiet)
        local gun=tool or findTool(w); if not gun then if not quiet then setSkinStatus(displayWeapon(w).." is not in your Backpack / Character",false) end return false end
        local target=gun:FindFirstChild("Handle"); local source=sourceHandle(w,s)
        if not target or not target:IsA("BasePart") or not source or not source:IsA("BasePart") then if not quiet then setSkinStatus("That skin doesn't have a usable Handle",false) end return false end
        clearVisual(gun)
        local visual=source:Clone(); visual.Name="KimqV21SkinVisual"; visual.Anchored=false; visual.CanCollide=false; visual.CanTouch=false; visual.CanQuery=false; visual.Massless=true
        for _,d in ipairs(visual:GetDescendants()) do
            if d:IsA("Script") or d:IsA("LocalScript") or d:IsA("ModuleScript") then d:Destroy() elseif d:IsA("BasePart") then d.Anchored=false; d.CanCollide=false; d.CanTouch=false; d.CanQuery=false; d.Massless=true end
        end
        visual.CFrame=target.CFrame; visual.Parent=gun
        local weld=Instance.new("WeldConstraint",visual); weld.Part0=visual; weld.Part1=target
        pcall(function() target.LocalTransparencyModifier=1 end)
        selectedByWeapon[w]=s
        if not quiet then setSkinStatus(displayWeapon(w).." • "..s.." applied locally",true) end
        return true
    end
    local function resetWeapon(w)
        if not w then return end; selectedByWeapon[w]=nil; clearVisual(findTool(w)); setSkinStatus(displayWeapon(w).." reset",true)
    end

    local function refreshWeaponStyle()
        for n,b in pairs(weaponButtons) do local on=n==currentWeapon; b.BackgroundColor3=on and hotColor or lightColor; b.TextColor3=on and Color3.fromRGB(250,252,255) or textColor end
    end
    local function refreshSkinStyle()
        for n,b in pairs(skinButtons) do local on=n==selectedSkin; b.BackgroundColor3=on and hotColor or lightColor; b.TextColor3=on and Color3.fromRGB(250,252,255) or textColor end
    end
    local function buildSkins()
        for _,ch in ipairs(skinsList:GetChildren()) do if ch:IsA("TextButton") then ch:Destroy() end end
        table.clear(skinButtons)
        if not currentWeapon or not folderByName[currentWeapon] then skinsHeader.Text="Skins"; setSkinStatus("Choose a weapon to begin",false); return end
        skinsHeader.Text="Skins • "..displayWeapon(currentWeapon)
        selectedSkin=selectedByWeapon[currentWeapon]
        local skins={}
        for _,sf in ipairs(folderByName[currentWeapon]:GetChildren()) do if sf:FindFirstChild("Handle") then table.insert(skins,sf) end end
        table.sort(skins,function(a,b) return a.Name:lower()<b.Name:lower() end)
        for i,sf in ipairs(skins) do
            local n=sf.Name; local b=Instance.new("TextButton",skinsList); b.LayoutOrder=i; b.BackgroundColor3=lightColor; b.BorderSizePixel=0; b.Text=n; b.TextColor3=textColor; b.Font=Enum.Font.GothamBold; b.TextSize=11; b.AutoButtonColor=false; corner(b,10); stroke(b,lineColor,.35,1)
            b.MouseButton1Click:Connect(function() selectedSkin=n; refreshSkinStyle(); setSkinStatus("Selected "..n.." • press Apply Skin",true) end)
            skinButtons[n]=b
        end
        refreshSkinStyle(); if #skins==0 then setSkinStatus("No skin Handles were found for this weapon",false) else setSkinStatus("Choose a skin from the list",false) end
    end
    local function scanWeapons()
        for _,ch in ipairs(weaponList:GetChildren()) do if ch:IsA("TextButton") then ch:Destroy() end end
        table.clear(weaponButtons); table.clear(weaponFolders); table.clear(folderByName)
        local wrapRoot=workspace:FindFirstChild("Wraps") or workspace:WaitForChild("Wraps",6)
        if not wrapRoot then setSkinStatus("Workspace.Wraps hasn't loaded yet",false); return end
        for _,wf in ipairs(wrapRoot:GetChildren()) do
            local usable=false
            for _,sf in ipairs(wf:GetChildren()) do if sf:FindFirstChild("Handle") then usable=true break end end
            if usable then table.insert(weaponFolders,wf); folderByName[wf.Name]=wf end
        end
        table.sort(weaponFolders,function(a,b) return a.Name:lower()<b.Name:lower() end)
        for i,wf in ipairs(weaponFolders) do
            local n=wf.Name; local b=Instance.new("TextButton",weaponList); b.LayoutOrder=i; b.BackgroundColor3=lightColor; b.BorderSizePixel=0; b.Text=displayWeapon(n); b.TextColor3=textColor; b.Font=Enum.Font.GothamBold; b.TextSize=11; b.AutoButtonColor=false; corner(b,10); stroke(b,lineColor,.35,1)
            b.MouseButton1Click:Connect(function() currentWeapon=n; selectedSkin=selectedByWeapon[n]; refreshWeaponStyle(); buildSkins(); setSkinStatus("Selected "..displayWeapon(n),true) end)
            weaponButtons[n]=b
        end
        if #weaponFolders>0 then currentWeapon=currentWeapon and folderByName[currentWeapon] and currentWeapon or weaponFolders[1].Name; refreshWeaponStyle(); buildSkins() else setSkinStatus("No weapon skin folders found in Workspace.Wraps",false) end
    end
    apply.MouseButton1Click:Connect(function() if not currentWeapon then setSkinStatus("Choose a weapon first",false) elseif not selectedSkin then setSkinStatus("Choose a skin first",false) else applySkin(currentWeapon,selectedSkin,nil,false) end end)
    reset.MouseButton1Click:Connect(function() resetWeapon(currentWeapon); selectedSkin=nil; refreshSkinStyle() end)

    local function hookContainer(container)
        if not container then return end
        container.ChildAdded:Connect(function(ch)
            local s=selectedByWeapon[ch.Name]
            if s then task.defer(function() task.wait(.08); applySkin(ch.Name,s,ch,true) end) end
        end)
    end
    hookContainer(lp:FindFirstChildOfClass("Backpack")); if lp.Character then hookContainer(lp.Character) end
    lp.CharacterAdded:Connect(function(char)
        hookContainer(char); task.delay(1,function() hookContainer(lp:FindFirstChildOfClass("Backpack")); for w,s in pairs(selectedByWeapon) do local t=findTool(w); if t then applySkin(w,s,t,true) end end end)
    end)

    progress("matching the new pages to your GUI...",.86)

    -- navigation: special pages use exact inactive/active styles from the original GUI.
    local function showSpecial(page,btn,title,desc)
        for _,p in pairs(pages) do p.Visible=(p==page) end
        -- reset ONLY the two V21 buttons + currently-active normal button; do not recolor the entire sidebar.
        setSpecialVisual(envBtn,btn==envBtn); setSpecialVisual(skinBtn,btn==skinBtn)
        for _,b in ipairs(nav:GetChildren()) do
            if b:IsA("TextButton") and b~=envBtn and b~=skinBtn and activeTemplate and b.BackgroundColor3==activeTemplate.BackgroundColor3 then copyVisual(b,inactiveTemplate) end
        end
        if pageTitle then pageTitle.Text=title end; if pageDesc then pageDesc.Text=desc end
        if page==skinPage then scanWeapons() end
    end
    envBtn.MouseButton1Click:Connect(function() showSpecial(envPage,envBtn,"environment","cute seasonal styles that still let you use Fog / Atmosphere") end)
    skinBtn.MouseButton1Click:Connect(function() showSpecial(skinPage,skinBtn,"weapon skins","choose a weapon, pick one of its skins, then apply it locally") end)
    for _,b in ipairs(nav:GetChildren()) do
        if b:IsA("TextButton") and b~=envBtn and b~=skinBtn then
            b.MouseButton1Click:Connect(function() envPage.Visible=false; skinPage.Visible=false; setSpecialVisual(envBtn,false); setSpecialVisual(skinBtn,false) end)
        end
    end

    local function syncTheme()
        panelColor,lineColor,hotColor,lightColor,textColor,subColor=sampleTheme()
        envPage.ScrollBarImageColor3=hotColor; skinPage.ScrollBarImageColor3=hotColor; weaponList.ScrollBarImageColor3=hotColor; skinsList.ScrollBarImageColor3=hotColor
        envTitle.TextColor3=hotColor; envSub.TextColor3=subColor; skinTitle.TextColor3=hotColor; skinSub.TextColor3=subColor
        for _,f in ipairs({intro,envStatus,sinfo,weaponCard,skinsCard,action,stat}) do f.BackgroundColor3=panelColor; local st=f:FindFirstChildOfClass("UIStroke"); if st then st.Color=lineColor end end
        for _,p in pairs(presetRows) do p.row.BackgroundColor3=panelColor; local st=p.row:FindFirstChildOfClass("UIStroke"); if st then st.Color=lineColor end; p.title.TextColor3=textColor; p.desc.TextColor3=subColor end
        envStatusName.TextColor3=textColor; envStatusValue.TextColor3=activePreset=="Normal" and subColor or hotColor
        apply.BackgroundColor3=hotColor; reset.BackgroundColor3=lightColor; reset.TextColor3=textColor; skinsHeader.TextColor3=textColor
        setSpecialVisual(envBtn,envPage.Visible); setSpecialVisual(skinBtn,skinPage.Visible); refreshPreset(); refreshWeaponStyle(); refreshSkinStyle()
    end
    if badge then badge.Text="V21 ♥"; badge:GetPropertyChangedSignal("BackgroundColor3"):Connect(function() task.defer(syncTheme) end) end
    syncTheme()

    progress("ready ♡",1)
    task.wait(.65)
    if loader and loader.Gui and loader.Gui.Parent then
        local shade=loader.Gui:FindFirstChildWhichIsA("Frame")
        if shade then TweenService:Create(shade,TweenInfo.new(.22,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{BackgroundTransparency=1}):Play() end
        task.wait(.24); pcall(function() loader.Gui:Destroy() end)
    end
    _G.KimqV21Ready=true
end)


-- V22: rebuilt Environment + Weapon Skins pages with stable theme styling.
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
    local loader = _G.KimqV24Loader

    local function setProgress(text, n)
        if loader and loader.Status and loader.Status.Parent then loader.Status.Text = text end
        if loader and loader.Bar and loader.Bar.Parent then TweenService:Create(loader.Bar,TweenInfo.new(.32,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{Size=UDim2.new(n,0,1,0)}):Play() end
        if loader and loader.Tip and loader.Tip.Parent then TweenService:Create(loader.Tip,TweenInfo.new(.32,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{Position=UDim2.new(n,0,.5,0)}):Play() end
    end

    task.wait(11.4)
    setProgress("fixing the final pages...", .91)

    local root = CoreGui:FindFirstChild("KimpetrasHC") or pg:FindFirstChild("KimpetrasHC")
    local main = root and root:FindFirstChild("Main")
    if not main then
        _G.KimqV24Ready=true
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
        _G.KimqV24Ready=true; main.Visible=true; if loader and loader.Gui then loader.Gui:Destroy() end; return
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
        _G.KimqV24Ready=true; main.Visible=true; if loader and loader.Gui then loader.Gui:Destroy() end; return
    end

    local badge
    for _,d in ipairs(main:GetDescendants()) do
        if d:IsA("TextLabel") and tostring(d.Text or ""):match("^V%d+") then
            d.Text="V24 ♥"
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
    if not inactiveTemplate then _G.KimqV24Ready=true; main.Visible=true; if loader and loader.Gui then loader.Gui:Destroy() end; return end

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
        local hot=(badge and badge.BackgroundColor3) or (activeTemplate and activeTemplate.BackgroundColor3) or Color3.fromRGB(49,93,255)
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
        local b=inactiveTemplate:Clone(); b.Name=text:gsub("%s+","").."NavV22"; b.Text="♥  "..text; b.LayoutOrder=order; b.Parent=nav; copyVisual(b,inactiveTemplate); return b
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
    for _,n in ipairs({"KimqV20Environment","KimqV21Environment","KimqV22Environment"}) do local x=workspace:FindFirstChild(n); if x then x:Destroy() end end
    local oldCC=Lighting:FindFirstChild("KimqV21SeasonColor"); if oldCC then oldCC:Destroy() end

    local ei=card(envPage,78)
    local eiTitle=txt(ei,"♥  environment",UDim2.new(1,-24,0,28),UDim2.fromOffset(12,9),Enum.Font.FredokaOne,21,hotColor)
    local eiSub=txt(ei,"Cute seasonal map styles. Your Fog / Atmosphere page stays completely editable.",UDim2.new(1,-24,0,30),UDim2.fromOffset(12,40),Enum.Font.Gotham,12,subColor); eiSub.TextWrapped=true

    local original={Ambient=Lighting.Ambient,OutdoorAmbient=Lighting.OutdoorAmbient,Brightness=Lighting.Brightness,ClockTime=Lighting.ClockTime,Exposure=Lighting.ExposureCompensation,Grass=terrain and terrain:GetMaterialColor(Enum.Material.Grass),Ground=terrain and terrain:GetMaterialColor(Enum.Material.Ground)}
    local changedParts={}; local seasonFolder=Instance.new("Folder",workspace); seasonFolder.Name="KimqV22Environment"; local followConn; local activePreset="Normal"

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
        for _,n in ipairs({"KimqV21SeasonColor","KimqV22SeasonColor"}) do local cc=Lighting:FindFirstChild(n); if cc then cc:Destroy() end end
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

    _G.KimqV22WeaponSkins=_G.KimqV22WeaponSkins or {Selected={}}
    local selectedByWeapon=_G.KimqV22WeaponSkins.Selected
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
        for _,d in ipairs(tool:GetDescendants()) do if d.Name=="KimqV22SkinVisual" then pcall(function() d:Destroy() end) end end
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
        local visual=source:Clone(); visual.Name="KimqV22SkinVisual"; visual.Anchored=false; visual.CanCollide=false; visual.CanTouch=false; visual.CanQuery=false; visual.Massless=true
        for _,d in ipairs(visual:GetDescendants()) do
            if d:IsA("Script") or d:IsA("LocalScript") or d:IsA("ModuleScript") then d:Destroy() elseif d:IsA("BasePart") then d.Anchored=false; d.CanCollide=false; d.CanTouch=false; d.CanQuery=false; d.Massless=true end
        end
        visual.CFrame=target.CFrame; visual.Parent=gun
        local weld=Instance.new("WeldConstraint",visual); weld.Name="KimqV22SkinWeld"; weld.Part0=visual; weld.Part1=target
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
        if not container or container:GetAttribute("KimqV22SkinHook") then return end
        container:SetAttribute("KimqV22SkinHook",true)
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

    -- Prime the scan once at startup too, so opening the page is instant when Wraps is already present.
    scanWeapons()

    setProgress("ready ♡",1)
    task.wait(.55)
    _G.KimqV24Ready=true
    main.Visible=true
    if loader and loader.Gui and loader.Gui.Parent then
        local bg=loader.Background
        local sticker=loader.Sticker
        if sticker then TweenService:Create(sticker,TweenInfo.new(.28,Enum.EasingStyle.Quart,Enum.EasingDirection.In),{Position=UDim2.new(.5,0,.5,8)}):Play() end
        if bg then TweenService:Create(bg,TweenInfo.new(.30,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{BackgroundTransparency=1}):Play() end
        task.wait(.31); pcall(function() loader.Gui:Destroy() end)
    end
end)



-- V27 full reference-style polish using the user's real Pompompurin and paw art.
task.spawn(function()
    local Players=game:GetService("Players")
    local CoreGui=game:GetService("CoreGui")
    local UIS=game:GetService("UserInputService")
    local TweenService=game:GetService("TweenService")
    local lp=Players.LocalPlayer
    local pg=lp:WaitForChild("PlayerGui")
    local loader=_G.KimqV27Loader

    local function waitMain(t)
        local started=tick()
        while tick()-started<(t or 40) do
            local root=CoreGui:FindFirstChild("KimpetrasHC") or pg:FindFirstChild("KimpetrasHC")
            local main=root and root:FindFirstChild("Main")
            if main and main:FindFirstChild("CuteBlueShell") and _G.KimqV24Ready then return root,main end
            task.wait(.12)
        end
    end

    local root,main=waitMain(45)
    if not root or not main then
        _G.KimqV27Ready=true
        if loader and loader.Gui then pcall(function() loader.Gui:Destroy() end) end
        return
    end
    if main:FindFirstChild("KimqV27ReferenceMarker") then
        _G.KimqV27Ready=true; main.Visible=true
        if loader and loader.Gui then pcall(function() loader.Gui:Destroy() end) end
        return
    end
    local marker=Instance.new("BoolValue",main); marker.Name="KimqV27ReferenceMarker"

    local shell=main:FindFirstChild("CuteBlueShell")
    if not shell then return end

    local function corner(o,r)
        local c=o:FindFirstChildOfClass("UICorner") or Instance.new("UICorner"); c.CornerRadius=UDim.new(0,r or 12); c.Parent=o; return c
    end
    local function stroke(o,c,t,w)
        local s=o:FindFirstChildOfClass("UIStroke") or Instance.new("UIStroke"); s.Color=c; s.Transparency=t or 0; s.Thickness=w or 1; s.Parent=o; return s
    end
    local function newLabel(p,txt,size,pos,font,ts,color,align)
        local l=Instance.new("TextLabel",p); l.BackgroundTransparency=1; l.Size=size; l.Position=pos; l.Text=txt; l.Font=font; l.TextSize=ts; l.TextColor3=color
        l.TextXAlignment=align or Enum.TextXAlignment.Left; l.TextYAlignment=Enum.TextYAlignment.Center; return l
    end
    local function addImage(p,asset,size,pos,color,z)
        if not asset then return nil end
        local i=Instance.new("ImageLabel",p); i.BackgroundTransparency=1; i.Size=size; i.Position=pos; i.Image=asset; i.ScaleType=Enum.ScaleType.Fit; i.ZIndex=z or (p.ZIndex+2)
        if color then i.ImageColor3=color end
        return i
    end
    local function cleanText(s)
        s=tostring(s or "")
        s=s:gsub("^[%s♥♡]+",""):gsub("^🐾%s*",""):gsub("%s+[♥♡]+$","")
        return s
    end
    local function norm(s)
        return cleanText(s):lower():gsub("[^%w]","")
    end
    local function colorSkip(o)
        local n=(o.Name or ""):lower()
        if n:find("fogsquare",1,true) or n:find("foghue",1,true) or n:find("fogpreview",1,true) then return true end
        local p=o.Parent
        while p and p~=main do
            local pn=(p.Name or ""):lower()
            if pn:find("fogsquare",1,true) or pn:find("foghue",1,true) or pn:find("fogpreview",1,true) then return true end
            p=p.Parent
        end
        return false
    end

    -- Find final navigation and page containers after all legacy patches have finished.
    local pages,pageHost={},nil
    for _,d in ipairs(main:GetDescendants()) do
        if d:IsA("ScrollingFrame") and d.Name:match("Page$") then
            pages[d.Name:gsub("Page$",""):lower()]=d
            pageHost=d.Parent
        end
    end
    if not pageHost then
        _G.KimqV27Ready=true; main.Visible=true
        if loader and loader.Gui then loader.Gui:Destroy() end
        return
    end
    local content=pageHost.Parent
    local nav=nil
    for _,d in ipairs(shell:GetDescendants()) do
        if d:IsA("ScrollingFrame") and not d.Name:match("Page$") then
            local buttons=0
            for _,c in ipairs(d:GetChildren()) do if c:IsA("TextButton") then buttons+=1 end end
            if buttons>=8 then nav=d; break end
        end
    end
    local side=nav and nav.Parent
    local pageHead=nil
    if content then
        for _,c in ipairs(content:GetChildren()) do
            if c:IsA("Frame") and c~=pageHost then
                for _,x in ipairs(c:GetChildren()) do
                    if x:IsA("TextLabel") and norm(x.Text)=="overview" then pageHead=c break end
                end
            end
            if pageHead then break end
        end
    end
    local pageTitle,pageDesc
    if pageHead then
        local labels={}
        for _,x in ipairs(pageHead:GetChildren()) do if x:IsA("TextLabel") then table.insert(labels,x) end end
        table.sort(labels,function(a,b) return a.Position.Y.Offset<b.Position.Y.Offset end)
        for _,x in ipairs(labels) do
            if norm(x.Text)=="overview" then pageTitle=x end
        end
        for _,x in ipairs(labels) do
            if x~=pageTitle and x.TextSize<=14 and #x.Text>18 then pageDesc=x break end
        end
    end

    local badge
    for _,d in ipairs(main:GetDescendants()) do
        if d:IsA("TextLabel") and tostring(d.Text or ""):match("^V%d+") then badge=d; break end
    end

    local P={}
    local function derive()
        local hot=(badge and badge.BackgroundColor3) or Color3.fromRGB(53,99,239)
        local h,s,v=hot:ToHSV()
        if s<.28 then hot=Color3.fromRGB(53,99,239) end
        P.hot=hot
        P.hot2=Color3.new(1,1,1):Lerp(hot,.32)
        P.soft=Color3.new(1,1,1):Lerp(hot,.10)
        P.soft2=Color3.new(1,1,1):Lerp(hot,.17)
        P.line=Color3.new(1,1,1):Lerp(hot,.38)
        P.paper=Color3.fromRGB(255,252,242)
        P.paper2=Color3.fromRGB(255,249,235)
        P.text=Color3.fromRGB(61,73,103):Lerp(hot,.32)
        P.sub=Color3.fromRGB(112,114,124):Lerp(hot,.20)
        P.white=Color3.fromRGB(255,255,255)
    end
    derive()

    -- One outer stitched border only. It has its own empty margin.
    local old=main:FindFirstChild("V27OuterStitches"); if old then old:Destroy() end
    local function buildOuterStitch()
        local f=Instance.new("Frame",main); f.Name="V27OuterStitches"; f.Size=UDim2.new(1,-30,1,-30); f.Position=UDim2.fromOffset(15,15); f.BackgroundTransparency=1; f.ZIndex=30
        for i=0,39 do
            for _,yy in ipairs({0,1}) do
                local d=Instance.new("Frame",f); d.Name="V27Stitch"; d.Size=UDim2.fromOffset(12,2); d.AnchorPoint=Vector2.new(.5,.5); d.Position=UDim2.new(i/39,0,yy,0)
                d.BackgroundColor3=P.hot; d.BackgroundTransparency=.42; d.BorderSizePixel=0; d.ZIndex=30; corner(d,2)
            end
        end
        for i=0,23 do
            for _,xx in ipairs({0,1}) do
                local d=Instance.new("Frame",f); d.Name="V27Stitch"; d.Size=UDim2.fromOffset(2,12); d.AnchorPoint=Vector2.new(.5,.5); d.Position=UDim2.new(xx,0,i/23,0)
                d.BackgroundColor3=P.hot; d.BackgroundTransparency=.42; d.BorderSizePixel=0; d.ZIndex=30; corner(d,2)
            end
        end
        return f
    end
    buildOuterStitch()

    -- Resize so the stitching never collides with the panels.
    main.Size=UDim2.fromOffset(1180,720)
    main.Position=UDim2.new(.5,-590,.5,-360)
    main.BackgroundColor3=P.paper
    main.BorderSizePixel=0
    main.ClipsDescendants=false
    corner(main,24)
    stroke(main,P.hot,.14,2)

    -- Find the original draggable top frame and reuse it so drag still works.
    local top=nil
    for _,c in ipairs(shell:GetChildren()) do
        if c:IsA("Frame") and c.AbsoluteSize.Y<=100 then
            for _,x in ipairs(c:GetChildren()) do
                if x:IsA("TextLabel") and tostring(x.Text):find("Kimqetras HC",1,true) then top=c break end
            end
        end
        if top then break end
    end
    if top then
        top.Size=UDim2.new(1,-58,0,90); top.Position=UDim2.fromOffset(29,22); top.BackgroundTransparency=1; top.ZIndex=10
        for _,x in ipairs(top:GetChildren()) do
            if x:IsA("TextLabel") then
                if tostring(x.Text):find("Kimqetras HC",1,true) then
                    x.Text="Kimqetras HC"; x.Position=UDim2.fromOffset(112,12); x.Size=UDim2.new(0,390,0,42); x.Font=Enum.Font.FredokaOne; x.TextSize=31; x.TextColor3=P.hot
                elseif tostring(x.Text):find("cute controls",1,true) then
                    x.Position=UDim2.fromOffset(114,51); x.Size=UDim2.new(0,440,0,22); x.Font=Enum.Font.Gotham; x.TextSize=12; x.TextColor3=P.sub
                end
            elseif x:IsA("Frame") then
                local hasAvatar=x:FindFirstChildWhichIsA("ImageLabel")
                if hasAvatar then
                    x.Size=UDim2.fromOffset(205,50); x.Position=UDim2.new(1,-318,0,10); x.BackgroundColor3=P.soft; x.BorderSizePixel=0; corner(x,14); stroke(x,P.line,.34,1)
                    for _,q in ipairs(x:GetDescendants()) do
                        if q:IsA("TextLabel") then q.TextColor3=(q.Font==Enum.Font.FredokaOne) and P.text or P.sub end
                    end
                end
            end
        end

        local om=top:FindFirstChild("V27Mascot"); if om then om:Destroy() end
        local mascot=addImage(top,_G.KimqV27PompomAsset,UDim2.fromOffset(105,96),UDim2.fromOffset(0,-8),nil,15)
        if mascot then mascot.Name="V27Mascot" end

        local min=top:FindFirstChild("V27Min") or Instance.new("TextButton",top); min.Name="V27Min"; min.Size=UDim2.fromOffset(34,34); min.Position=UDim2.new(1,-76,0,17)
        min.BackgroundColor3=P.soft; min.BorderSizePixel=0; min.Text="−"; min.TextColor3=P.hot; min.Font=Enum.Font.FredokaOne; min.TextSize=24; min.AutoButtonColor=false; corner(min,11); stroke(min,P.line,.30,1)
        local close=top:FindFirstChild("V27Close") or Instance.new("TextButton",top); close.Name="V27Close"; close.Size=UDim2.fromOffset(34,34); close.Position=UDim2.new(1,-36,0,17)
        close.BackgroundColor3=P.soft; close.BorderSizePixel=0; close.Text="×"; close.TextColor3=P.hot; close.Font=Enum.Font.FredokaOne; close.TextSize=24; close.AutoButtonColor=false; corner(close,11); stroke(close,P.line,.30,1)
        min.MouseButton1Click:Connect(function() main.Visible=false end)
        close.MouseButton1Click:Connect(function() main.Visible=false end)
    end

    -- Hide old top divider text so the top area stays clean.
    for _,d in ipairs(shell:GetChildren()) do
        if d:IsA("TextLabel") and tostring(d.Text):find("-   -",1,true) then d.Visible=false end
    end

    if side and nav then
        side.Size=UDim2.new(0,268,1,-146); side.Position=UDim2.fromOffset(30,118); side.BackgroundColor3=P.paper2; side.BorderSizePixel=0; corner(side,18); stroke(side,P.line,.22,1)
        nav.Size=UDim2.new(1,-20,1,-100); nav.Position=UDim2.fromOffset(10,58); nav.BackgroundTransparency=1; nav.ScrollBarThickness=3; nav.ScrollBarImageColor3=P.hot

        for _,d in ipairs(side:GetChildren()) do
            if d:IsA("TextLabel") then
                if tostring(d.Text):lower():find("pages",1,true) or tostring(d.Text):lower():find("features",1,true) then
                    d.Text="FEATURES"; d.Font=Enum.Font.FredokaOne; d.TextSize=18; d.TextColor3=P.hot; d.Position=UDim2.fromOffset(46,12); d.Size=UDim2.new(1,-92,0,28)
                    if not side:FindFirstChild("V27SidePaw") then
                        local p=addImage(side,_G.KimqV27PawAsset,UDim2.fromOffset(23,21),UDim2.fromOffset(18,15),P.hot,5); if p then p.Name="V27SidePaw" end
                    end
                elseif tostring(d.Text):find("-  -",1,true) then
                    d.Text="-  -  -  -  -  -  -  -"; d.TextColor3=P.line; d.Position=UDim2.fromOffset(16,40); d.Size=UDim2.new(1,-32,0,14)
                end
            elseif d:IsA("Frame") then
                for _,q in ipairs(d:GetDescendants()) do
                    if q:IsA("TextLabel") and tostring(q.Text):find("Right Shift",1,true) then
                        d.BackgroundColor3=P.soft; d.Size=UDim2.new(1,-20,0,38); d.Position=UDim2.new(0,10,1,-46); corner(d,12); stroke(d,P.line,.28,1)
                        q.Text="Right Shift / Right Click = hide / show"; q.TextColor3=P.hot; q.Font=Enum.Font.GothamSemibold; q.TextSize=10
                    end
                end
            end
        end
    end

    if content then content.Size=UDim2.new(1,-342,1,-146); content.Position=UDim2.fromOffset(316,118) end
    if pageHead then
        pageHead.Size=UDim2.new(1,0,0,76); pageHead.Position=UDim2.fromOffset(0,0); pageHead.BackgroundColor3=P.paper2; pageHead.BorderSizePixel=0; corner(pageHead,16); stroke(pageHead,P.line,.20,1)
        for _,d in ipairs(pageHead:GetChildren()) do
            if d:IsA("TextLabel") then
                if d==pageTitle then
                    d.Text=cleanText(d.Text); d.Position=UDim2.fromOffset(55,9); d.Size=UDim2.new(1,-74,0,29); d.Font=Enum.Font.FredokaOne; d.TextSize=21; d.TextColor3=P.hot
                elseif d==pageDesc then
                    d.Position=UDim2.fromOffset(56,39); d.Size=UDim2.new(1,-82,0,22); d.Font=Enum.Font.Gotham; d.TextSize=11; d.TextColor3=P.sub
                else
                    if tostring(d.Text):find("-  -",1,true) or d.Text=="♥" or d.Text=="♡" then d.Visible=false end
                end
            end
        end
        local ph=pageHead:FindFirstChild("V27PagePaw")
        if not ph then ph=addImage(pageHead,_G.KimqV27PawAsset,UDim2.fromOffset(28,26),UDim2.fromOffset(18,12),P.hot,5); if ph then ph.Name="V27PagePaw" end end
        local dl=pageHead:FindFirstChild("V27PageDash")
        if not dl then
            dl=Instance.new("Frame",pageHead); dl.Name="V27PageDash"; dl.BackgroundTransparency=1; dl.Position=UDim2.fromOffset(55,62); dl.Size=UDim2.new(1,-78,0,4)
            for i=0,16 do
                local x=Instance.new("Frame",dl); x.Name="Dash"; x.Size=UDim2.fromOffset(11,2); x.Position=UDim2.new(i/16,0,0,0); x.BackgroundColor3=P.hot; x.BackgroundTransparency=.55; x.BorderSizePixel=0; corner(x,2)
            end
        end
    end
    pageHost.Size=UDim2.new(1,0,1,-88); pageHost.Position=UDim2.fromOffset(0,88)

    -- Nav buttons now use the real transparent paw artwork, never emoji paw/hearts.
    local function getActiveTitle()
        return pageTitle and norm(pageTitle.Text) or ""
    end
    local function styleNav()
        if not nav then return end
        local active=getActiveTitle()
        for _,b in ipairs(nav:GetChildren()) do
            if b:IsA("TextButton") then
                b.Size=UDim2.new(1,-4,0,40); b.BorderSizePixel=0; b.Font=Enum.Font.FredokaOne; b.TextSize=12; b.TextXAlignment=Enum.TextXAlignment.Left
                b.Text="      "..cleanText(b.Text); b.AutoButtonColor=false; corner(b,11)
                for _,x in ipairs(b:GetChildren()) do if x:IsA("TextLabel") and (x.Name=="Heart" or x.Text=="♡" or x.Text=="♥") then x.Visible=false end end
                local paw=b:FindFirstChild("V27NavPaw")
                if not paw then paw=addImage(b,_G.KimqV27PawAsset,UDim2.fromOffset(17,16),UDim2.fromOffset(12,12),P.hot,6); if paw then paw.Name="V27NavPaw" end end
                local bt=norm(b.Text)
                local on=(active~="" and (bt==active or bt:find(active,1,true) or active:find(bt,1,true)))
                b.BackgroundColor3=on and P.hot or P.paper
                b.TextColor3=on and P.white or P.text
                stroke(b,on and P.hot or P.line,.30,1)
                if paw then paw.ImageColor3=on and P.white or P.hot end
            end
        end
    end

    -- Restyle all pages without touching the actual color square/hue bar.
    local function stylePages()
        for _,page in pairs(pages) do
            page.ScrollBarImageColor3=P.hot
            for _,o in ipairs(page:GetDescendants()) do
                if not colorSkip(o) then
                    if o:IsA("Frame") then
                        if o.BackgroundTransparency<.96 then
                            local yy=o.AbsoluteSize.Y
                            if yy<=11 then
                                local _,sat,val=o.BackgroundColor3:ToHSV()
                                o.BackgroundColor3=(sat>.24 and val>.45) and P.hot or P.soft2
                                corner(o,999)
                            else
                                o.BackgroundColor3=P.paper2; o.BorderSizePixel=0
                                if yy>=34 then corner(o,math.min(13,math.max(8,math.floor(yy/7)))) end
                            end
                        end
                        local s=o:FindFirstChildOfClass("UIStroke"); if s then s.Color=P.line; s.Transparency=.28 end
                    elseif o:IsA("TextLabel") then
                        local txt=cleanText(o.Text)
                        local wasHeader=(txt~=o.Text) or o.Font==Enum.Font.FredokaOne or o.TextSize>=17
                        o.Text=txt
                        if wasHeader then o.Font=Enum.Font.FredokaOne; o.TextColor3=P.hot
                        else o.TextColor3=(o.TextSize<=11) and P.sub or P.text end
                    elseif o:IsA("TextButton") then
                        if o.Text=="" then
                            local _,sat,val=o.BackgroundColor3:ToHSV()
                            o.BackgroundColor3=(sat>.24 and val>.45) and P.hot or P.soft2
                        else
                            o.BackgroundColor3=P.soft; o.TextColor3=P.text; o.Font=(o.Font==Enum.Font.FredokaOne) and Enum.Font.FredokaOne or Enum.Font.GothamSemibold; o.BorderSizePixel=0; corner(o,10)
                            local s=o:FindFirstChildOfClass("UIStroke"); if s then s.Color=P.line end
                        end
                    elseif o:IsA("TextBox") then
                        o.BackgroundColor3=P.soft; o.TextColor3=P.text; o.PlaceholderColor3=P.sub; o.BorderSizePixel=0; corner(o,10)
                        local s=o:FindFirstChildOfClass("UIStroke"); if s then s.Color=P.line end
                    elseif o:IsA("UIStroke") then
                        o.Color=P.line
                    elseif o:IsA("ScrollingFrame") then
                        o.ScrollBarImageColor3=P.hot
                    end
                end
            end
        end
    end

    -- Rebuild Overview from scratch with safe spacing and the banner direction the user liked.
    local overview=pages.overview
    local bannerGrad
    if overview then
        for _,c in ipairs(overview:GetChildren()) do if not c:IsA("UIListLayout") and not c:IsA("UIPadding") then c:Destroy() end end
        local layout=overview:FindFirstChildOfClass("UIListLayout") or Instance.new("UIListLayout",overview); layout.Padding=UDim.new(0,12); layout.SortOrder=Enum.SortOrder.LayoutOrder
        layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() overview.CanvasSize=UDim2.new(0,0,0,layout.AbsoluteContentSize.Y+18) end)

        local function card(h,name)
            local f=Instance.new("Frame",overview); f.Name=name; f.Size=UDim2.new(1,-10,0,h); f.BackgroundColor3=P.paper2; f.BorderSizePixel=0; corner(f,16); stroke(f,P.line,.24,1); return f
        end

        local hero=card(150,"V27Hero")
        local banner=Instance.new("Frame",hero); banner.Name="V27Banner"; banner.Size=UDim2.new(1,-20,1,-20); banner.Position=UDim2.fromOffset(10,10); banner.BackgroundColor3=P.hot; banner.BorderSizePixel=0; banner.ClipsDescendants=true; corner(banner,14)
        bannerGrad=Instance.new("UIGradient",banner); bannerGrad.Color=ColorSequence.new({ColorSequenceKeypoint.new(0,P.hot2),ColorSequenceKeypoint.new(.52,P.hot),ColorSequenceKeypoint.new(1,P.hot:Lerp(Color3.new(1,1,1),.18))}); bannerGrad.Rotation=6
        for _,spec in ipairs({{-.03,.64,110,.22},{.08,.70,80,.32},{.87,.68,95,.30},{.98,.60,120,.22},{.50,-.10,110,.74}}) do
            local c=Instance.new("Frame",banner); c.AnchorPoint=Vector2.new(.5,.5); c.Position=UDim2.new(spec[1],0,spec[2],0); c.Size=UDim2.fromOffset(spec[3],spec[3]); c.BackgroundColor3=P.white; c.BackgroundTransparency=spec[4]; c.BorderSizePixel=0; corner(c,999)
        end
        addImage(banner,_G.KimqV27PawAsset,UDim2.fromOffset(32,29),UDim2.new(.18,-16,.30,-14),P.white,4)
        addImage(banner,_G.KimqV27PawAsset,UDim2.fromOffset(30,27),UDim2.new(.82,-15,.30,-14),P.white,4)
        local bt=newLabel(banner,"Kimqetras HC",UDim2.new(1,-40,0,50),UDim2.fromOffset(20,39),Enum.Font.FredokaOne,34,P.white,Enum.TextXAlignment.Center)
        local bs=newLabel(banner,"cute controls, clean pages, zero clutter ♡",UDim2.new(1,-40,0,22),UDim2.fromOffset(20,85),Enum.Font.GothamSemibold,12,P.white,Enum.TextXAlignment.Center); bs.TextTransparency=.08

        local welcome=card(148,"V27Welcome")
        local av=Instance.new("ImageLabel",welcome); av.Size=UDim2.fromOffset(78,78); av.Position=UDim2.fromOffset(18,34); av.BackgroundColor3=P.soft; av.BorderSizePixel=0; corner(av,999); stroke(av,P.line,.24,1)
        pcall(function() av.Image=Players:GetUserThumbnailAsync(lp.UserId,Enum.ThumbnailType.HeadShot,Enum.ThumbnailSize.Size180x180) end)
        newLabel(welcome,"welcome, "..lp.DisplayName:lower(),UDim2.new(1,-245,0,34),UDim2.fromOffset(112,22),Enum.Font.FredokaOne,24,P.text)
        newLabel(welcome,"@"..lp.Name.."  •  Kimqetras HC",UDim2.new(1,-245,0,20),UDim2.fromOffset(112,54),Enum.Font.GothamSemibold,11,P.sub)
        local wbody=newLabel(welcome,"Everything is separated into its own feature page.\nPick a tool on the left, or press Right Shift / Right Click to hide or reopen the GUI.",UDim2.new(1,-245,0,52),UDim2.fromOffset(112,78),Enum.Font.Gotham,12,P.text)
        wbody.TextWrapped=true; wbody.TextYAlignment=Enum.TextYAlignment.Top
        local pm=addImage(welcome,_G.KimqV27PompomAsset,UDim2.fromOffset(112,102),UDim2.new(1,-128,0,23),nil,4)
        if pm then pm.ImageTransparency=.03 end

        local about=card(126,"V27About")
        addImage(about,_G.KimqV27PawAsset,UDim2.fromOffset(26,24),UDim2.fromOffset(18,16),P.hot,4)
        newLabel(about,"about",UDim2.new(1,-64,0,28),UDim2.fromOffset(53,13),Enum.Font.FredokaOne,20,P.hot)
        local ad=newLabel(about,"-  -  -  -  -  -  -  -",UDim2.new(0,260,0,16),UDim2.fromOffset(53,39),Enum.Font.GothamBold,10,P.line)
        local ab=newLabel(about,"Every feature has its own clean page.\nSwitch between aiming, movement, visuals, avatar tools, and utilities.\nPick a theme whenever you want the interface to match your style.",UDim2.new(1,-78,0,62),UDim2.fromOffset(20,57),Enum.Font.Gotham,12,P.text)
        ab.TextWrapped=true; ab.TextYAlignment=Enum.TextYAlignment.Top
        addImage(about,_G.KimqV27PawAsset,UDim2.fromOffset(42,38),UDim2.new(1,-62,.52,-19),P.hot,4)

        local controls=card(82,"V27Controls")
        addImage(controls,_G.KimqV27PawAsset,UDim2.fromOffset(24,22),UDim2.fromOffset(18,16),P.hot,4)
        newLabel(controls,"controls",UDim2.new(1,-58,0,28),UDim2.fromOffset(51,12),Enum.Font.FredokaOne,19,P.hot)
        newLabel(controls,"Right Shift / Right Click = hide / show the GUI",UDim2.new(1,-38,0,24),UDim2.fromOffset(20,45),Enum.Font.GothamSemibold,11,P.text)
    end

    local function forceBadge()
        for _,d in ipairs(main:GetDescendants()) do
            if d:IsA("TextLabel") and tostring(d.Text or ""):match("^V%d+") then d.Text="V27 ♥" end
        end
    end

    local function recolor()
        derive()
        main.BackgroundColor3=P.paper; stroke(main,P.hot,.14,2)
        local sf=main:FindFirstChild("V27OuterStitches")
        if sf then for _,d in ipairs(sf:GetChildren()) do if d:IsA("Frame") then d.BackgroundColor3=P.hot end end end
        if top then
            for _,x in ipairs(top:GetChildren()) do
                if x:IsA("TextLabel") then
                    if tostring(x.Text):find("Kimqetras HC",1,true) then x.TextColor3=P.hot else x.TextColor3=P.sub end
                elseif x:IsA("TextButton") then x.BackgroundColor3=P.soft; x.TextColor3=P.hot; local s=x:FindFirstChildOfClass("UIStroke"); if s then s.Color=P.line end
                elseif x:IsA("Frame") and x:FindFirstChildWhichIsA("ImageLabel") then x.BackgroundColor3=P.soft; local s=x:FindFirstChildOfClass("UIStroke"); if s then s.Color=P.line end end
            end
        end
        if side then side.BackgroundColor3=P.paper2; local s=side:FindFirstChildOfClass("UIStroke"); if s then s.Color=P.line end
            local p=side:FindFirstChild("V27SidePaw"); if p and p:IsA("ImageLabel") then p.ImageColor3=P.hot end
        end
        if pageHead then pageHead.BackgroundColor3=P.paper2; local s=pageHead:FindFirstChildOfClass("UIStroke"); if s then s.Color=P.line end
            if pageTitle then pageTitle.TextColor3=P.hot end; if pageDesc then pageDesc.TextColor3=P.sub end
            local p=pageHead:FindFirstChild("V27PagePaw"); if p and p:IsA("ImageLabel") then p.ImageColor3=P.hot end
            local dl=pageHead:FindFirstChild("V27PageDash"); if dl then for _,x in ipairs(dl:GetChildren()) do if x:IsA("Frame") then x.BackgroundColor3=P.hot end end end
        end
        stylePages(); styleNav()
        if bannerGrad then bannerGrad.Color=ColorSequence.new({ColorSequenceKeypoint.new(0,P.hot2),ColorSequenceKeypoint.new(.52,P.hot),ColorSequenceKeypoint.new(1,P.hot:Lerp(Color3.new(1,1,1),.18))}) end
        if overview then
            for _,o in ipairs(overview:GetDescendants()) do
                if o:IsA("ImageLabel") and (o.Image==_G.KimqV27PawAsset) then o.ImageColor3=P.hot end
                if o:IsA("UIStroke") then o.Color=P.line end
            end
            local banner=overview:FindFirstChild("V27Hero") and overview.V27Hero:FindFirstChild("V27Banner")
            if banner then
                for _,o in ipairs(banner:GetDescendants()) do if o:IsA("ImageLabel") and o.Image==_G.KimqV27PawAsset then o.ImageColor3=P.white end end
            end
        end
        forceBadge()
    end

    if pageTitle then
        pageTitle:GetPropertyChangedSignal("Text"):Connect(function() task.defer(function() styleNav(); forceBadge() end) end)
    end
    if nav then
        for _,b in ipairs(nav:GetChildren()) do if b:IsA("TextButton") then b.MouseButton1Click:Connect(function() task.delay(.03,styleNav) end) end end
        nav.ChildAdded:Connect(function(ch) if ch:IsA("TextButton") then task.delay(.05,function() styleNav() end) end end)
    end
    if badge then badge:GetPropertyChangedSignal("BackgroundColor3"):Connect(function() task.defer(recolor) end) end

    -- Right click now actually toggles the GUI. Existing Right Shift behavior is preserved.
    if false and not main:GetAttribute("KimqV27RightClickBound") then
        main:SetAttribute("KimqV27RightClickBound",true)
        UIS.InputBegan:Connect(function(input,processed)
            if input.UserInputType==Enum.UserInputType.MouseButton2 and not UIS:GetFocusedTextBox() then
                main.Visible=not main.Visible
            end
        end)
    end

    recolor()
    forceBadge()
    task.delay(.25,forceBadge); task.delay(1,forceBadge)

    _G.KimqV27Ready=true
    main.Visible=true
    if loader and loader.Gui and loader.Gui.Parent then
        if loader.Card then TweenService:Create(loader.Card,TweenInfo.new(.28,Enum.EasingStyle.Quart,Enum.EasingDirection.In),{Position=UDim2.new(.5,0,.5,8),BackgroundTransparency=1}):Play() end
        if loader.Background then TweenService:Create(loader.Background,TweenInfo.new(.32,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{BackgroundTransparency=1}):Play() end
        task.wait(.34); pcall(function() loader.Gui:Destroy() end)
    end
end)


-- V28 full layout polish + robust full-model weapon skin alignment.
task.spawn(function()
    local Players=game:GetService("Players")
    local CoreGui=game:GetService("CoreGui")
    local UIS=game:GetService("UserInputService")
    local TweenService=game:GetService("TweenService")
    local ReplicatedStorage=game:GetService("ReplicatedStorage")
    local lp=Players.LocalPlayer
    local pg=lp:WaitForChild("PlayerGui")
    local loader=_G.KimqV28Loader

    local function waitMain(timeout)
        local st=tick()
        while tick()-st<(timeout or 50) do
            local root=CoreGui:FindFirstChild("KimpetrasHC") or pg:FindFirstChild("KimpetrasHC")
            local main=root and root:FindFirstChild("Main")
            if main and main:FindFirstChild("CuteBlueShell") and _G.KimqV27Ready then return root,main end
            task.wait(.12)
        end
    end

    local root,main=waitMain(52)
    if not root or not main then
        _G.KimqV28Ready=true
        if loader and loader.Gui then pcall(function() loader.Gui:Destroy() end) end
        return
    end
    if main:FindFirstChild("KimqV28Marker") then
        _G.KimqV28Ready=true; main.Visible=true
        if loader and loader.Gui then pcall(function() loader.Gui:Destroy() end) end
        return
    end
    local marker=Instance.new("BoolValue",main); marker.Name="KimqV28Marker"
    local shell=main:FindFirstChild("CuteBlueShell")
    if not shell then return end

    local function corner(o,r)
        local c=o:FindFirstChildOfClass("UICorner") or Instance.new("UICorner"); c.CornerRadius=UDim.new(0,r or 12); c.Parent=o; return c
    end
    local function stroke(o,c,t,w)
        local s=o:FindFirstChildOfClass("UIStroke") or Instance.new("UIStroke"); s.Color=c; s.Transparency=t or 0; s.Thickness=w or 1; s.Parent=o; return s
    end
    local function label(p,text,size,pos,font,ts,color,align)
        local l=Instance.new("TextLabel",p); l.BackgroundTransparency=1; l.Size=size; l.Position=pos; l.Text=text; l.Font=font or Enum.Font.Gotham; l.TextSize=ts or 12; l.TextColor3=color
        l.TextXAlignment=align or Enum.TextXAlignment.Left; l.TextYAlignment=Enum.TextYAlignment.Center; return l
    end
    local function image(p,asset,size,pos,color,z)
        if not asset then return nil end
        local i=Instance.new("ImageLabel",p); i.BackgroundTransparency=1; i.Size=size; i.Position=pos; i.Image=asset; i.ScaleType=Enum.ScaleType.Fit; i.ZIndex=z or 4
        if color then i.ImageColor3=color end
        return i
    end
    local function clean(s)
        s=tostring(s or "")
        s=s:gsub("^[%s♥♡]+",""):gsub("^🐾%s*",""):gsub("%s+[♥♡]+$","")
        return s
    end
    local function norm(s) return clean(s):lower():gsub("[^%w]","") end

    local badge
    for _,d in ipairs(main:GetDescendants()) do if d:IsA("TextLabel") and tostring(d.Text or ""):match("^V%d+") then badge=d; break end end
    local P={}
    local function derive()
        local hot=(badge and badge.BackgroundColor3) or Color3.fromRGB(53,99,239)
        local _,sat=hot:ToHSV(); if sat<.24 then hot=Color3.fromRGB(53,99,239) end
        P.hot=hot
        P.hot2=Color3.new(1,1,1):Lerp(hot,.30)
        P.soft=Color3.new(1,1,1):Lerp(hot,.075)
        P.soft2=Color3.new(1,1,1):Lerp(hot,.13)
        P.line=Color3.new(1,1,1):Lerp(hot,.33)
        P.paper=Color3.new(1,1,1):Lerp(hot,.025)
        P.paper2=Color3.new(1,1,1):Lerp(hot,.045)
        P.text=hot:Lerp(Color3.fromRGB(34,45,72),.63)
        P.sub=hot:Lerp(Color3.fromRGB(96,105,124),.68)
        P.white=Color3.fromRGB(255,255,255)
    end
    derive()

    -- Identify the current layout containers.
    local nav,side,pageHost,content,pageHead,top
    local pages={}
    for _,d in ipairs(main:GetDescendants()) do
        if d:IsA("ScrollingFrame") and d.Name:match("Page$") then pages[d.Name:lower()]=d; pageHost=d.Parent end
    end
    if pageHost then content=pageHost.Parent end
    for _,d in ipairs(shell:GetDescendants()) do
        if d:IsA("ScrollingFrame") and not d.Name:match("Page$") then
            local n=0; for _,c in ipairs(d:GetChildren()) do if c:IsA("TextButton") then n+=1 end end
            if n>=8 then nav=d; side=d.Parent; break end
        end
    end
    for _,c in ipairs(shell:GetChildren()) do
        if c:IsA("Frame") and c.AbsoluteSize.Y<=110 then
            for _,x in ipairs(c:GetChildren()) do if x:IsA("TextLabel") and tostring(x.Text):find("Kimqetras HC",1,true) then top=c; break end end
        end
        if top then break end
    end
    if content then
        for _,c in ipairs(content:GetChildren()) do
            if c:IsA("Frame") and c~=pageHost then
                local labels=0; for _,x in ipairs(c:GetChildren()) do if x:IsA("TextLabel") then labels+=1 end end
                if labels>=2 then pageHead=c; break end
            end
        end
    end
    if not nav or not side or not content or not pageHost then
        _G.KimqV28Ready=true; main.Visible=true
        if loader and loader.Gui then loader.Gui:Destroy() end
        return
    end

    -- Remove V27 decorations that made the border/header feel crowded.
    for _,d in ipairs(main:GetDescendants()) do
        local n=d.Name or ""
        if n=="V27OuterStitches" or n=="V27Mascot" or n=="V27SidePaw" or n=="V27PagePaw" or n=="V27PageDash" or n=="V27NavPaw" then pcall(function() d:Destroy() end) end
    end

    main.Size=UDim2.fromOffset(1220,750)
    main.Position=UDim2.new(.5,-610,.5,-375)
    main.BackgroundColor3=P.paper
    main.BorderSizePixel=0
    main.ClipsDescendants=false
    corner(main,24); stroke(main,P.hot,.12,2)

    -- Stitching has a dedicated 22px gutter and never crosses content.
    local stitch=Instance.new("Frame",main); stitch.Name="V28OuterStitches"; stitch.BackgroundTransparency=1; stitch.Position=UDim2.fromOffset(18,18); stitch.Size=UDim2.new(1,-36,1,-36); stitch.ZIndex=40
    for i=0,43 do
        for _,yy in ipairs({0,1}) do
            local d=Instance.new("Frame",stitch); d.Name="Stitch"; d.Size=UDim2.fromOffset(12,2); d.AnchorPoint=Vector2.new(.5,.5); d.Position=UDim2.new(i/43,0,yy,0); d.BackgroundColor3=P.hot; d.BackgroundTransparency=.46; d.BorderSizePixel=0; d.ZIndex=40; corner(d,2)
        end
    end
    for i=0,25 do
        for _,xx in ipairs({0,1}) do
            local d=Instance.new("Frame",stitch); d.Name="Stitch"; d.Size=UDim2.fromOffset(2,12); d.AnchorPoint=Vector2.new(.5,.5); d.Position=UDim2.new(xx,0,i/25,0); d.BackgroundColor3=P.hot; d.BackgroundTransparency=.46; d.BorderSizePixel=0; d.ZIndex=40; corner(d,2)
        end
    end
    local cornerPaws={}
    if _G.KimqV27PawAsset then
        local p1=image(main,_G.KimqV27PawAsset,UDim2.fromOffset(34,31),UDim2.fromOffset(24,698),P.hot,42)
        local p2=image(main,_G.KimqV27PawAsset,UDim2.fromOffset(34,31),UDim2.new(1,-58,0,698),P.hot,42)
        if p1 then table.insert(cornerPaws,p1) end; if p2 then table.insert(cornerPaws,p2) end
    end

    -- Header: mascot is contained, title has its own clear area, close controls are separate.
    if top then
        top.Position=UDim2.fromOffset(42,25); top.Size=UDim2.new(1,-84,0,78); top.BackgroundTransparency=1; top.ZIndex=12
        for _,x in ipairs(top:GetChildren()) do
            if x:IsA("TextLabel") then
                if tostring(x.Text):find("Kimqetras HC",1,true) then
                    x.Text="Kimqetras HC"; x.Position=UDim2.fromOffset(95,5); x.Size=UDim2.fromOffset(390,38); x.Font=Enum.Font.FredokaOne; x.TextSize=30; x.TextColor3=P.hot
                elseif tostring(x.Text):find("cute controls",1,true) or tostring(x.Text):find("silent hc",1,true) then
                    x.Text="silent hc  ♡"; x.Position=UDim2.fromOffset(98,42); x.Size=UDim2.fromOffset(300,22); x.Font=Enum.Font.FredokaOne; x.TextSize=15; x.TextColor3=P.sub
                end
            elseif x:IsA("Frame") and x:FindFirstChildWhichIsA("ImageLabel") then
                x.Size=UDim2.fromOffset(205,48); x.Position=UDim2.new(1,-306,0,8); x.BackgroundColor3=P.paper2; x.BorderSizePixel=0; corner(x,14); stroke(x,P.line,.34,1)
            end
        end
        local old=top:FindFirstChild("V28Mascot"); if old then old:Destroy() end
        local m=image(top,_G.KimqV27PompomAsset,UDim2.fromOffset(86,78),UDim2.fromOffset(0,-1),nil,16); if m then m.Name="V28Mascot" end
        for _,name in ipairs({"V27Min","V27Close","V28Min","V28Close"}) do local x=top:FindFirstChild(name); if x then x:Destroy() end end
        local min=Instance.new("TextButton",top); min.Name="V28Min"; min.Size=UDim2.fromOffset(36,34); min.Position=UDim2.new(1,-78,0,15); min.BackgroundColor3=P.hot; min.BorderSizePixel=0; min.Text="−"; min.TextColor3=P.white; min.Font=Enum.Font.FredokaOne; min.TextSize=22; min.AutoButtonColor=false; corner(min,11)
        local close=Instance.new("TextButton",top); close.Name="V28Close"; close.Size=UDim2.fromOffset(36,34); close.Position=UDim2.new(1,-36,0,15); close.BackgroundColor3=P.hot; close.BorderSizePixel=0; close.Text="×"; close.TextColor3=P.white; close.Font=Enum.Font.FredokaOne; close.TextSize=22; close.AutoButtonColor=false; corner(close,11)
        local function gloss(b)
            local g=Instance.new("UIGradient",b); g.Color=ColorSequence.new({ColorSequenceKeypoint.new(0,P.hot2),ColorSequenceKeypoint.new(.55,P.hot),ColorSequenceKeypoint.new(1,P.hot)}); g.Rotation=90
        end
        gloss(min); gloss(close)
        min.MouseButton1Click:Connect(function() main.Visible=false end)
        close.MouseButton1Click:Connect(function() main.Visible=false end)
    end

    side.Position=UDim2.fromOffset(42,116); side.Size=UDim2.new(0,238,1,-158); side.BackgroundColor3=P.paper2; side.BorderSizePixel=0; corner(side,18); stroke(side,P.line,.20,1)
    content.Position=UDim2.fromOffset(300,116); content.Size=UDim2.new(1,-342,1,-158)
    if pageHead then pageHead.Size=UDim2.new(1,0,0,76); pageHead.BackgroundColor3=P.paper2; pageHead.BorderSizePixel=0; corner(pageHead,17); stroke(pageHead,P.line,.22,1) end
    pageHost.Position=UDim2.fromOffset(0,88); pageHost.Size=UDim2.new(1,0,1,-88)

    -- Sidebar header, one tasteful paw, no random heart glyphs.
    for _,x in ipairs(side:GetChildren()) do
        if x:IsA("TextLabel") and (tostring(x.Text):lower():find("features",1,true) or tostring(x.Text):lower():find("pages",1,true)) then
            x.Text="FEATURES"; x.Font=Enum.Font.FredokaOne; x.TextSize=17; x.TextColor3=P.hot; x.Position=UDim2.fromOffset(44,12); x.Size=UDim2.new(1,-58,0,28); x.TextXAlignment=Enum.TextXAlignment.Left
        end
    end
    local sidePaw=image(side,_G.KimqV27PawAsset,UDim2.fromOffset(24,22),UDim2.fromOffset(17,14),P.hot,7)
    nav.Position=UDim2.fromOffset(8,58); nav.Size=UDim2.new(1,-16,1,-103); nav.ScrollBarThickness=3; nav.ScrollBarImageColor3=P.hot
    for _,d in ipairs(side:GetDescendants()) do
        if d:IsA("TextLabel") and tostring(d.Text):find("Right Shift",1,true) then d.Text="Right Shift / Right Click = hide / show"; d.Font=Enum.Font.GothamSemibold; d.TextSize=9; d.TextColor3=P.hot end
    end

    local navPaws={}
    local function styleNav()
        for _,b in ipairs(nav:GetChildren()) do
            if b:IsA("TextButton") then
                local base=clean(b.Text); b.Text="      "..base; b.TextXAlignment=Enum.TextXAlignment.Left; b.Font=Enum.Font.FredokaOne; b.TextSize=13; b.AutoButtonColor=false; b.BorderSizePixel=0; corner(b,11)
                local active=false
                if pageHead then
                    local current=""; for _,l in ipairs(pageHead:GetChildren()) do if l:IsA("TextLabel") and l.TextSize>=17 then current=norm(l.Text); break end end
                    active=norm(base)==current or (norm(base)=="hcsilentaim" and current=="hcsilentaim")
                end
                b.BackgroundColor3=active and P.hot or P.soft
                b.TextColor3=active and P.white or P.text
                local s=b:FindFirstChildOfClass("UIStroke") or Instance.new("UIStroke",b); s.Color=active and P.hot or P.line; s.Transparency=active and .05 or .36; s.Thickness=1
                local paw=b:FindFirstChild("V28NavPaw")
                if not paw and _G.KimqV27PawAsset then paw=image(b,_G.KimqV27PawAsset,UDim2.fromOffset(16,15),UDim2.fromOffset(12,12),active and P.white or P.hot,7); if paw then paw.Name="V28NavPaw"; table.insert(navPaws,paw) end end
                if paw then paw.ImageColor3=active and P.white or P.hot end
            end
        end
    end

    -- Page header uses paw + a short stitched divider safely inside the header.
    local pagePaw
    if pageHead then
        for _,l in ipairs(pageHead:GetChildren()) do
            if l:IsA("TextLabel") then
                if l.TextSize>=17 then l.Position=UDim2.fromOffset(53,9); l.Size=UDim2.new(1,-72,0,30); l.Font=Enum.Font.FredokaOne; l.TextSize=21; l.TextColor3=P.hot
                elseif #tostring(l.Text)>18 then l.Position=UDim2.fromOffset(18,42); l.Size=UDim2.new(1,-36,0,20); l.Font=Enum.Font.Gotham; l.TextSize=11; l.TextColor3=P.sub end
            end
        end
        pagePaw=image(pageHead,_G.KimqV27PawAsset,UDim2.fromOffset(26,24),UDim2.fromOffset(19,11),P.hot,7)
        local dash=Instance.new("Frame",pageHead); dash.Name="V28HeaderStitch"; dash.BackgroundTransparency=1; dash.Position=UDim2.new(1,-180,0,17); dash.Size=UDim2.fromOffset(150,4)
        for i=0,8 do local d=Instance.new("Frame",dash); d.Size=UDim2.fromOffset(10,2); d.Position=UDim2.new(i/8,-5,.5,-1); d.BackgroundColor3=P.hot; d.BackgroundTransparency=.55; d.BorderSizePixel=0; corner(d,2) end
    end

    local function skipColorObject(o)
        local p=o
        while p and p~=main do
            local n=(p.Name or ""):lower()
            if n:find("fogsquare",1,true) or n:find("foghue",1,true) or n:find("fogpreview",1,true) or n:find("colorpicker",1,true) then return true end
            p=p.Parent
        end
        return false
    end
    local function stylePages()
        for _,p in pairs(pages) do
            p.ScrollBarImageColor3=P.hot
            local lname=(p.Name or ""):lower()
            local isTheme=lname:find("theme",1,true)~=nil
            local isWeapon=lname:find("weaponskins",1,true)~=nil
            for _,o in ipairs(p:GetDescendants()) do
                if not skipColorObject(o) then
                    if o:IsA("Frame") and o.BackgroundTransparency<1 then o.BackgroundColor3=P.paper2; o.BorderSizePixel=0; corner(o,11); local s=o:FindFirstChildOfClass("UIStroke"); if s then s.Color=P.line end
                    elseif o:IsA("TextLabel") then o.TextColor3=(o.Font==Enum.Font.FredokaOne or o.TextSize>=17) and P.hot or P.text
                    elseif o:IsA("TextBox") then o.BackgroundColor3=P.soft; o.TextColor3=P.text; o.PlaceholderColor3=P.sub; o.BorderSizePixel=0; corner(o,9); local s=o:FindFirstChildOfClass("UIStroke"); if s then s.Color=P.line end
                    elseif o:IsA("TextButton") and not isTheme and not isWeapon then
                        local txtn=norm(o.Text)
                        if not txtn:find("selected",1,true) then o.BackgroundColor3=P.soft; o.TextColor3=P.text end
                        o.BorderSizePixel=0; corner(o,9); local s=o:FindFirstChildOfClass("UIStroke"); if s then s.Color=P.line end
                    elseif o:IsA("UIStroke") then o.Color=P.line
                    elseif o:IsA("ScrollingFrame") then o.ScrollBarImageColor3=P.hot end
                end
            end
        end
    end

    -- Rebuild Overview with reference-style sections but plenty of spacing.
    local overview=pages["overviewpage"]
    if overview then
        for _,c in ipairs(overview:GetChildren()) do if not c:IsA("UIListLayout") and not c:IsA("UIPadding") then c:Destroy() end end
        local lay=overview:FindFirstChildOfClass("UIListLayout") or Instance.new("UIListLayout",overview); lay.Padding=UDim.new(0,12); lay.SortOrder=Enum.SortOrder.LayoutOrder
        lay:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() overview.CanvasSize=UDim2.new(0,0,0,lay.AbsoluteContentSize.Y+16) end)
        local function card(h,n)
            local f=Instance.new("Frame",overview); f.Name=n; f.Size=UDim2.new(1,-8,0,h); f.BackgroundColor3=P.paper2; f.BorderSizePixel=0; corner(f,15); stroke(f,P.line,.22,1); return f
        end
        local hero=card(154,"V28Hero")
        local banner=Instance.new("Frame",hero); banner.Name="V28Banner"; banner.Size=UDim2.new(1,-20,1,-20); banner.Position=UDim2.fromOffset(10,10); banner.BackgroundColor3=P.hot; banner.BorderSizePixel=0; banner.ClipsDescendants=true; corner(banner,13)
        local grad=Instance.new("UIGradient",banner); grad.Name="V28BannerGradient"; grad.Color=ColorSequence.new({ColorSequenceKeypoint.new(0,P.hot2),ColorSequenceKeypoint.new(.48,P.hot),ColorSequenceKeypoint.new(1,P.hot:Lerp(P.white,.15))}); grad.Rotation=6
        for _,s in ipairs({{-.02,.72,120,.18},{.08,.78,92,.28},{.92,.76,100,.26},{1.01,.66,130,.18}}) do local b=Instance.new("Frame",banner); b.AnchorPoint=Vector2.new(.5,.5); b.Position=UDim2.new(s[1],0,s[2],0); b.Size=UDim2.fromOffset(s[3],s[3]); b.BackgroundColor3=P.white; b.BackgroundTransparency=s[4]; b.BorderSizePixel=0; corner(b,999) end
        label(banner,"Kimqetras HC",UDim2.new(1,-40,0,52),UDim2.fromOffset(20,39),Enum.Font.FredokaOne,35,P.white,Enum.TextXAlignment.Center)
        label(banner,"made with love for you  ♡",UDim2.new(1,-40,0,22),UDim2.fromOffset(20,91),Enum.Font.GothamSemibold,12,P.white,Enum.TextXAlignment.Center)

        local welcome=card(150,"V28Welcome")
        local av=Instance.new("ImageLabel",welcome); av.Size=UDim2.fromOffset(78,78); av.Position=UDim2.fromOffset(19,35); av.BackgroundColor3=P.soft; av.BorderSizePixel=0; corner(av,999); stroke(av,P.line,.22,1); pcall(function() av.Image=Players:GetUserThumbnailAsync(lp.UserId,Enum.ThumbnailType.HeadShot,Enum.ThumbnailSize.Size180x180) end)
        label(welcome,"welcome, "..lp.DisplayName:lower(),UDim2.new(1,-235,0,34),UDim2.fromOffset(114,22),Enum.Font.FredokaOne,23,P.text)
        label(welcome,"@"..lp.Name.."  •  Kimqetras HC",UDim2.new(1,-235,0,20),UDim2.fromOffset(114,54),Enum.Font.GothamSemibold,11,P.sub)
        local body=label(welcome,"Everything is separated into its own feature page.\nPick a tool on the left, or press Right Shift / Right Click to hide or reopen the GUI.",UDim2.new(1,-250,0,52),UDim2.fromOffset(114,80),Enum.Font.Gotham,12,P.text); body.TextWrapped=true; body.TextYAlignment=Enum.TextYAlignment.Top
        local pm=image(welcome,_G.KimqV27PompomAsset,UDim2.fromOffset(102,94),UDim2.new(1,-118,0,28),nil,5)

        local about=card(124,"V28About")
        image(about,_G.KimqV27PawAsset,UDim2.fromOffset(25,23),UDim2.fromOffset(18,15),P.hot,5)
        label(about,"about",UDim2.new(1,-60,0,28),UDim2.fromOffset(51,12),Enum.Font.FredokaOne,20,P.hot)
        label(about,"-  -  -  -  -  -  -",UDim2.fromOffset(220,16),UDim2.fromOffset(51,38),Enum.Font.GothamBold,10,P.line)
        local ab=label(about,"Every feature has its own clean page.\nSwitch between aiming, movement, visuals, avatar tools, and utilities.\nPick a theme whenever you want the interface to match your style.",UDim2.new(1,-38,0,61),UDim2.fromOffset(19,55),Enum.Font.Gotham,12,P.text); ab.TextWrapped=true; ab.TextYAlignment=Enum.TextYAlignment.Top

        local controls=card(80,"V28Controls")
        image(controls,_G.KimqV27PawAsset,UDim2.fromOffset(23,21),UDim2.fromOffset(18,14),P.hot,5)
        label(controls,"controls",UDim2.new(1,-58,0,28),UDim2.fromOffset(49,11),Enum.Font.FredokaOne,19,P.hot)
        label(controls,"Right Shift / Right Click = hide / show the GUI",UDim2.new(1,-36,0,24),UDim2.fromOffset(19,43),Enum.Font.GothamSemibold,11,P.text)
    end

    -- Weapon skins: two-column selector + full-model alignment so multi-part skins load and keep their correct offsets.
    local skinsPage=pages["weaponskinspage"]
    local skinThemeSync=nil
    if skinsPage then
        for _,c in ipairs(skinsPage:GetChildren()) do pcall(function() c:Destroy() end) end
        skinsPage.CanvasSize=UDim2.new(0,0,0,530); skinsPage.ScrollBarThickness=3; skinsPage.ScrollBarImageColor3=P.hot

        local function panel(parent,size,pos)
            local f=Instance.new("Frame",parent); f.Size=size; f.Position=pos; f.BackgroundColor3=P.paper2; f.BorderSizePixel=0; corner(f,14); stroke(f,P.line,.22,1); return f
        end
        local intro=panel(skinsPage,UDim2.new(1,-8,0,64),UDim2.fromOffset(0,0))
        image(intro,_G.KimqV27PawAsset,UDim2.fromOffset(24,22),UDim2.fromOffset(16,13),P.hot,5)
        label(intro,"weapon skins",UDim2.new(1,-55,0,28),UDim2.fromOffset(47,9),Enum.Font.FredokaOne,20,P.hot)
        label(intro,"choose one of your weapons, pick its skin, then apply it locally",UDim2.new(1,-28,0,20),UDim2.fromOffset(16,37),Enum.Font.Gotham,11,P.sub)

        local left=panel(skinsPage,UDim2.new(.35,-6,0,350),UDim2.fromOffset(0,76))
        local right=panel(skinsPage,UDim2.new(.65,-8,0,350),UDim2.new(.35,6,0,76))
        label(left,"Weapon",UDim2.new(1,-24,0,24),UDim2.fromOffset(12,8),Enum.Font.FredokaOne,16,P.text)
        local refresh=Instance.new("TextButton",left); refresh.Name="V28Refresh"; refresh.Size=UDim2.fromOffset(78,26); refresh.Position=UDim2.new(1,-90,0,7); refresh.BackgroundColor3=P.soft; refresh.BorderSizePixel=0; refresh.Text="refresh"; refresh.TextColor3=P.text; refresh.Font=Enum.Font.GothamBold; refresh.TextSize=10; refresh.AutoButtonColor=false; corner(refresh,8); stroke(refresh,P.line,.35,1)
        local weaponList=Instance.new("ScrollingFrame",left); weaponList.Name="V28WeaponList"; weaponList.Size=UDim2.new(1,-18,1,-48); weaponList.Position=UDim2.fromOffset(9,40); weaponList.BackgroundTransparency=1; weaponList.BorderSizePixel=0; weaponList.ScrollBarThickness=3; weaponList.ScrollBarImageColor3=P.hot
        local wl=Instance.new("UIListLayout",weaponList); wl.Padding=UDim.new(0,7); wl.SortOrder=Enum.SortOrder.LayoutOrder; wl:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() weaponList.CanvasSize=UDim2.new(0,0,0,wl.AbsoluteContentSize.Y+6) end)

        label(right,"Skins",UDim2.new(0,120,0,24),UDim2.fromOffset(12,8),Enum.Font.FredokaOne,16,P.text)
        local selectedLabel=label(right,"pick a weapon",UDim2.new(1,-150,0,22),UDim2.fromOffset(120,8),Enum.Font.Gotham,11,P.sub,Enum.TextXAlignment.Right)
        local search=Instance.new("TextBox",right); search.Name="V28Search"; search.Size=UDim2.new(1,-20,0,32); search.Position=UDim2.fromOffset(10,38); search.BackgroundColor3=P.soft; search.BorderSizePixel=0; search.PlaceholderText="search skins..."; search.PlaceholderColor3=P.sub; search.Text=""; search.TextColor3=P.text; search.Font=Enum.Font.Gotham; search.TextSize=12; search.ClearTextOnFocus=false; search.TextXAlignment=Enum.TextXAlignment.Left; corner(search,9); stroke(search,P.line,.35,1); local ip=Instance.new("UIPadding",search); ip.PaddingLeft=UDim.new(0,10)
        local skinList=Instance.new("ScrollingFrame",right); skinList.Name="V28SkinList"; skinList.Size=UDim2.new(1,-18,1,-84); skinList.Position=UDim2.fromOffset(9,76); skinList.BackgroundTransparency=1; skinList.BorderSizePixel=0; skinList.ScrollBarThickness=3; skinList.ScrollBarImageColor3=P.hot
        local sl=Instance.new("UIListLayout",skinList); sl.Padding=UDim.new(0,7); sl.SortOrder=Enum.SortOrder.LayoutOrder; sl:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() skinList.CanvasSize=UDim2.new(0,0,0,sl.AbsoluteContentSize.Y+6) end)

        local actions=panel(skinsPage,UDim2.new(1,-8,0,52),UDim2.fromOffset(0,438))
        local apply=Instance.new("TextButton",actions); apply.Name="V28Apply"; apply.Size=UDim2.new(.68,-14,0,32); apply.Position=UDim2.new(0,10,.5,-16); apply.BackgroundColor3=P.hot; apply.BorderSizePixel=0; apply.Text="Apply Skin"; apply.TextColor3=P.white; apply.Font=Enum.Font.GothamBold; apply.TextSize=12; apply.AutoButtonColor=false; corner(apply,9)
        local reset=Instance.new("TextButton",actions); reset.Name="V28Reset"; reset.Size=UDim2.new(.32,-14,0,32); reset.Position=UDim2.new(.68,4,.5,-16); reset.BackgroundColor3=P.soft; reset.BorderSizePixel=0; reset.Text="Reset"; reset.TextColor3=P.text; reset.Font=Enum.Font.GothamBold; reset.TextSize=11; reset.AutoButtonColor=false; corner(reset,9); stroke(reset,P.line,.35,1)
        local status=label(skinsPage,"scanning your weapons...",UDim2.new(1,-18,0,26),UDim2.fromOffset(9,496),Enum.Font.Gotham,11,P.sub)

        _G.KimqV28WeaponSkins=_G.KimqV28WeaponSkins or {Selected={}}
        local selectedByWeapon=_G.KimqV28WeaponSkins.Selected
        local currentWeapon,selectedSkin,wrapRoot
        local folderByName,weaponButtons,skinButtons={},{},{}

        local function setStatus(t,good) status.Text=t; status.TextColor3=good and P.hot or P.sub end
        local function displayName(n) return tostring(n or ""):gsub("%[",""):gsub("%]","") end
        local function keyName(n) return tostring(n or ""):lower():gsub("[^%w]","") end
        local function getContainers() return lp.Character,lp:FindFirstChildOfClass("Backpack") end
        local function findTool(name)
            local char,bp=getContainers(); local exact=(char and char:FindFirstChild(name)) or (bp and bp:FindFirstChild(name)); if exact then return exact end
            local key=keyName(name)
            for _,container in ipairs({char,bp}) do if container then for _,x in ipairs(container:GetChildren()) do if keyName(x.Name)==key then return x end end end end
        end
        local function findAnchor(obj)
            if not obj then return nil end
            if obj:IsA("BasePart") and obj.Name=="Handle" then return obj end
            local h=obj:FindFirstChild("Handle",true); if h and h:IsA("BasePart") then return h end
            if obj:IsA("BasePart") then return obj end
            for _,d in ipairs(obj:GetDescendants()) do if d:IsA("BasePart") then return d end end
        end
        local function locateWraps()
            local candidates={}
            local function addFrom(rootObj)
                if not rootObj then return end
                local direct=rootObj:FindFirstChild("Wraps"); if direct then table.insert(candidates,direct) end
                for _,d in ipairs(rootObj:GetDescendants()) do if d.Name=="Wraps" then table.insert(candidates,d) end end
            end
            addFrom(workspace); addFrom(ReplicatedStorage)
            table.sort(candidates,function(a,b)
                local ac,bc=0,0; for _,x in ipairs(a:GetChildren()) do if x:IsA("Folder") or x:IsA("Model") then ac+=1 end end; for _,x in ipairs(b:GetChildren()) do if x:IsA("Folder") or x:IsA("Model") then bc+=1 end end; return ac>bc
            end)
            return candidates[1]
        end
        local function ownedKeys()
            local t={}; local char,bp=getContainers(); for _,container in ipairs({char,bp}) do if container then for _,x in ipairs(container:GetChildren()) do t[keyName(x.Name)]=true end end end; return t
        end
        local function clearVisual(tool)
            if not tool then return end
            for _,d in ipairs(tool:GetDescendants()) do if d.Name=="KimqV28SkinVisual" or d.Name=="KimqV22SkinVisual" or d.Name=="KimqV23SkinVisual" then pcall(function() d:Destroy() end) end end
            local h=findAnchor(tool); if h then local original=h:GetAttribute("KimqV28OriginalLTM"); pcall(function() h.LocalTransparencyModifier=type(original)=="number" and original or 0 end) end
        end
        local function cloneSkinObject(source)
            local old=source.Archivable; pcall(function() source.Archivable=true end)
            local ok,cl=pcall(function() return source:Clone() end)
            pcall(function() source.Archivable=old end)
            if ok then return cl end
        end
        local function applyVisual(wname,sname,tool,quiet)
            local wf=folderByName[wname]; local source=wf and wf:FindFirstChild(sname); if not source then if not quiet then setStatus("That skin is no longer available",false) end return false end
            local gun=tool or findTool(wname)
            if not gun then selectedByWeapon[wname]=sname; if not quiet then setStatus(displayName(wname).." saved • it will apply when you get/equip it",true) end return true end
            local target=gun:FindFirstChild("Handle",true); if not target or not target:IsA("BasePart") then target=findAnchor(gun) end
            local sourceAnchor=findAnchor(source)
            if not target or not sourceAnchor then if not quiet then setStatus("This weapon/skin has no usable visual anchor",false) end return false end
            local clone=cloneSkinObject(source); if not clone then if not quiet then setStatus("That skin could not be cloned",false) end return false end
            local wrapper=Instance.new("Model"); wrapper.Name="KimqV28SkinVisual"; wrapper.Parent=gun; clone.Parent=wrapper
            for _,d in ipairs(wrapper:GetDescendants()) do
                if d:IsA("Script") or d:IsA("LocalScript") or d:IsA("ModuleScript") or d:IsA("JointInstance") or d:IsA("Constraint") then pcall(function() d:Destroy() end) end
            end
            local clonedAnchor=findAnchor(clone); if not clonedAnchor then wrapper:Destroy(); if not quiet then setStatus("The cloned skin has no usable part",false) end return false end
            local parts={}; for _,d in ipairs(wrapper:GetDescendants()) do if d:IsA("BasePart") then table.insert(parts,d) end end
            if #parts==0 then wrapper:Destroy(); if not quiet then setStatus("The skin has no visible parts",false) end return false end
            local delta=target.CFrame*clonedAnchor.CFrame:Inverse()
            for _,part in ipairs(parts) do
                part.Anchored=false; part.CanCollide=false; part.CanTouch=false; part.CanQuery=false; part.Massless=true
                part.AssemblyLinearVelocity=Vector3.zero; part.AssemblyAngularVelocity=Vector3.zero
                part.CFrame=delta*part.CFrame
            end
            -- weld every visual part directly to the real gun handle after alignment; preserves multi-part offsets.
            for _,part in ipairs(parts) do
                local weld=Instance.new("WeldConstraint",part); weld.Name="KimqV28SkinWeld"; weld.Part0=target; weld.Part1=part
            end
            if target:GetAttribute("KimqV28OriginalLTM")==nil then pcall(function() target:SetAttribute("KimqV28OriginalLTM",target.LocalTransparencyModifier) end) end
            pcall(function() target.LocalTransparencyModifier=1 end)
            selectedByWeapon[wname]=sname
            if not quiet then setStatus(displayName(wname).." • "..sname.." applied locally",true) end
            return true
        end
        local function makeButton(parent,text)
            local b=Instance.new("TextButton",parent); b.Size=UDim2.new(1,-5,0,36); b.BackgroundColor3=P.soft; b.BorderSizePixel=0; b.Text=text; b.TextColor3=P.text; b.Font=Enum.Font.GothamBold; b.TextSize=11; b.TextXAlignment=Enum.TextXAlignment.Left; b.AutoButtonColor=false; corner(b,9); stroke(b,P.line,.36,1); local pd=Instance.new("UIPadding",b); pd.PaddingLeft=UDim.new(0,11); return b
        end
        local function refreshWeaponStyle() for name,b in pairs(weaponButtons) do local on=name==currentWeapon; b.BackgroundColor3=on and P.hot or P.soft; b.TextColor3=on and P.white or P.text end end
        local function refreshSkinStyle() for name,b in pairs(skinButtons) do local on=name==selectedSkin; b.BackgroundColor3=on and P.hot or P.soft; b.TextColor3=on and P.white or P.text end end
        local function buildSkins()
            for _,c in ipairs(skinList:GetChildren()) do if c:IsA("TextButton") then c:Destroy() end end; table.clear(skinButtons)
            local wf=currentWeapon and folderByName[currentWeapon]; if not wf then selectedLabel.Text="pick a weapon"; setStatus("Choose a weapon first",false); return end
            local q=search.Text:lower(); local skins={}
            for _,s in ipairs(wf:GetChildren()) do if findAnchor(s) and (q=="" or s.Name:lower():find(q,1,true)) then table.insert(skins,s) end end
            table.sort(skins,function(a,b) return a.Name:lower()<b.Name:lower() end)
            selectedSkin=selectedByWeapon[currentWeapon]; selectedLabel.Text=selectedSkin and ("selected: "..selectedSkin) or displayName(currentWeapon)
            for i,s in ipairs(skins) do local b=makeButton(skinList,s.Name); b.LayoutOrder=i; skinButtons[s.Name]=b; b.MouseButton1Click:Connect(function() selectedSkin=s.Name; selectedLabel.Text="selected: "..s.Name; refreshSkinStyle(); setStatus("Selected "..s.Name.." • press Apply Skin",true) end) end
            refreshSkinStyle(); if #skins==0 then setStatus("No matching skins found for "..displayName(currentWeapon),false) else setStatus("Found "..#skins.." skins for "..displayName(currentWeapon),true) end
        end
        -- replace the tiny scan helper above with a separately scoped implementation to stay below Luau's local-register limit.
        local function doScanWeapons()
            for _,c in ipairs(weaponList:GetChildren()) do if c:IsA("TextButton") then c:Destroy() end end
            table.clear(folderByName); table.clear(weaponButtons)
            wrapRoot=locateWraps(); if not wrapRoot then setStatus("Could not find the Wraps folder • press refresh",false); return end
            local folders={}; for _,wf in ipairs(wrapRoot:GetChildren()) do if (wf:IsA("Folder") or wf:IsA("Model")) and #wf:GetChildren()>0 then table.insert(folders,wf); folderByName[wf.Name]=wf end end
            local owned=ownedKeys(); table.sort(folders,function(a,b) local ao=owned[keyName(a.Name)] and 0 or 1; local bo=owned[keyName(b.Name)] and 0 or 1; if ao~=bo then return ao<bo end return a.Name:lower()<b.Name:lower() end)
            local ownedCount=0; for _,wf in ipairs(folders) do if owned[keyName(wf.Name)] then ownedCount+=1 end end
            local shown=0
            for _,wf in ipairs(folders) do
                if ownedCount==0 or owned[keyName(wf.Name)] then
                    shown+=1; local b=makeButton(weaponList,displayName(wf.Name)); b.LayoutOrder=shown; weaponButtons[wf.Name]=b
                    b.MouseButton1Click:Connect(function() currentWeapon=wf.Name; selectedSkin=selectedByWeapon[currentWeapon]; refreshWeaponStyle(); buildSkins() end)
                end
            end
            if shown==0 then setStatus("No matching weapon folders found",false); return end
            if not currentWeapon or not weaponButtons[currentWeapon] then for name,_ in pairs(weaponButtons) do currentWeapon=name; break end end
            refreshWeaponStyle(); buildSkins()
        end
        refresh.MouseButton1Click:Connect(doScanWeapons)
        search:GetPropertyChangedSignal("Text"):Connect(function() task.defer(buildSkins) end)
        apply.MouseButton1Click:Connect(function() if not currentWeapon then setStatus("Choose a weapon first",false) elseif not selectedSkin then setStatus("Choose a skin first",false) else clearVisual(findTool(currentWeapon)); applyVisual(currentWeapon,selectedSkin,nil,false) end end)
        reset.MouseButton1Click:Connect(function() if currentWeapon then selectedByWeapon[currentWeapon]=nil; clearVisual(findTool(currentWeapon)); selectedSkin=nil; selectedLabel.Text=displayName(currentWeapon); refreshSkinStyle(); setStatus(displayName(currentWeapon).." reset",true) end end)

        local function selectedForTool(toolName)
            if selectedByWeapon[toolName] then return toolName,selectedByWeapon[toolName] end
            local key=keyName(toolName)
            for w,s in pairs(selectedByWeapon) do if keyName(w)==key then return w,s end end
        end
        local function hookTool(t)
            if not t or not t:IsA("Tool") or t:GetAttribute("KimqV28ToolHook") then return end; t:SetAttribute("KimqV28ToolHook",true)
            t.Equipped:Connect(function()
                local w,s=selectedForTool(t.Name)
                if w and s then task.delay(.12,function() clearVisual(t); applyVisual(w,s,t,true) end) end
            end)
        end
        local function hookContainer(c)
            if not c or c:GetAttribute("KimqV28ContainerHook") then return end; c:SetAttribute("KimqV28ContainerHook",true)
            for _,t in ipairs(c:GetChildren()) do hookTool(t) end
            c.ChildAdded:Connect(function(t)
                hookTool(t)
                local w,s=selectedForTool(t.Name)
                if w and s then task.delay(.18,function() clearVisual(t); applyVisual(w,s,t,true) end) end
            end)
        end
        hookContainer(lp:FindFirstChildOfClass("Backpack")); if lp.Character then hookContainer(lp.Character) end
        lp.CharacterAdded:Connect(function(char) hookContainer(char); task.delay(1,function() hookContainer(lp:FindFirstChildOfClass("Backpack")); doScanWeapons() end) end)
        skinsPage:GetPropertyChangedSignal("Visible"):Connect(function() if skinsPage.Visible then task.defer(doScanWeapons) end end)
        doScanWeapons()

        skinThemeSync=function()
            for _,f in ipairs({intro,left,right,actions}) do
                f.BackgroundColor3=P.paper2
                local s=f:FindFirstChildOfClass("UIStroke"); if s then s.Color=P.line end
            end
            weaponList.ScrollBarImageColor3=P.hot; skinList.ScrollBarImageColor3=P.hot
            refresh.BackgroundColor3=P.soft; refresh.TextColor3=P.text
            local rs=refresh:FindFirstChildOfClass("UIStroke"); if rs then rs.Color=P.line end
            search.BackgroundColor3=P.soft; search.TextColor3=P.text; search.PlaceholderColor3=P.sub
            local ss=search:FindFirstChildOfClass("UIStroke"); if ss then ss.Color=P.line end
            apply.BackgroundColor3=P.hot; apply.TextColor3=P.white
            reset.BackgroundColor3=P.soft; reset.TextColor3=P.text
            local zs=reset:FindFirstChildOfClass("UIStroke"); if zs then zs.Color=P.line end
            selectedLabel.TextColor3=P.sub; status.TextColor3=P.sub
            for _,d in ipairs(intro:GetDescendants()) do if d:IsA("ImageLabel") and d.Image==_G.KimqV27PawAsset then d.ImageColor3=P.hot elseif d:IsA("TextLabel") then d.TextColor3=(d.Font==Enum.Font.FredokaOne) and P.hot or P.sub end end
            refreshWeaponStyle(); refreshSkinStyle()
        end
    end

    -- Keep V28 custom pieces synced after every theme recolor.
    local function forceBadge() for _,d in ipairs(main:GetDescendants()) do if d:IsA("TextLabel") and tostring(d.Text or ""):match("^V%d+") then d.Text="V28 ♥" end end end
    local function recolorCustom()
        derive(); main.BackgroundColor3=P.paper; stroke(main,P.hot,.12,2)
        for _,d in ipairs(stitch:GetChildren()) do if d:IsA("Frame") then d.BackgroundColor3=P.hot end end
        for _,p in ipairs(cornerPaws) do p.ImageColor3=P.hot end; if sidePaw then sidePaw.ImageColor3=P.hot end; local php=pageHead and pageHead:FindFirstChild("V30PagePaw"); if php then php.ImageColor3=P.hot end; if pagePaw then pagePaw.ImageColor3=P.hot end
        side.BackgroundColor3=P.paper2; stroke(side,P.line,.20,1); if pageHead then pageHead.BackgroundColor3=P.paper2; stroke(pageHead,P.line,.22,1) end
        styleNav(); stylePages(); if skinThemeSync then skinThemeSync() end
        if overview then
            for _,o in ipairs(overview:GetDescendants()) do if o:IsA("UIStroke") then o.Color=P.line end end
            local b=overview:FindFirstChild("V28Hero") and overview.V28Hero:FindFirstChild("V28Banner"); if b then local g=b:FindFirstChild("V28BannerGradient"); if g then g.Color=ColorSequence.new({ColorSequenceKeypoint.new(0,P.hot2),ColorSequenceKeypoint.new(.48,P.hot),ColorSequenceKeypoint.new(1,P.hot:Lerp(P.white,.15))}) end end
        end
        forceBadge()
    end
    if badge then badge:GetPropertyChangedSignal("BackgroundColor3"):Connect(function() task.delay(.06,recolorCustom) end) end
    if pageHead then for _,l in ipairs(pageHead:GetChildren()) do if l:IsA("TextLabel") and l.TextSize>=17 then l:GetPropertyChangedSignal("Text"):Connect(function() task.defer(styleNav) end); break end end end
    for _,b in ipairs(nav:GetChildren()) do if b:IsA("TextButton") then b.MouseButton1Click:Connect(function() task.delay(.04,styleNav) end) end end

    stylePages(); styleNav(); if skinThemeSync then skinThemeSync() end; recolorCustom(); forceBadge(); task.delay(.3,forceBadge); task.delay(1,forceBadge)

    _G.KimqV28Ready=true
    main.Visible=true
    if loader and loader.Gui and loader.Gui.Parent then
        if loader.Card then TweenService:Create(loader.Card,TweenInfo.new(.28,Enum.EasingStyle.Quart,Enum.EasingDirection.In),{Position=UDim2.new(.5,0,.5,8),BackgroundTransparency=1}):Play() end
        if loader.Background then TweenService:Create(loader.Background,TweenInfo.new(.32,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{BackgroundTransparency=1}):Play() end
        task.wait(.34); pcall(function() loader.Gui:Destroy() end)
    end
end)




-- V30 final polish: Roblox-hosted art, stitched blue shell, themed icons, and stable weapon skin visuals.
task.spawn(function()
    local Players=game:GetService("Players")
    local CoreGui=game:GetService("CoreGui")
    local UIS=game:GetService("UserInputService")
    local TweenService=game:GetService("TweenService")
    local ReplicatedStorage=game:GetService("ReplicatedStorage")
    local lp=Players.LocalPlayer
    local pg=lp:WaitForChild("PlayerGui")
    local A=_G.KimqV29Assets or {}
    local loader=_G.KimqV30Loader or _G.KimqV29Loader
    local function waitMain(sec)
        local t=tick()
        while tick()-t<(sec or 45) do
            local r=CoreGui:FindFirstChild("KimpetrasHC") or pg:FindFirstChild("KimpetrasHC")
            local m=r and r:FindFirstChild("Main")
            if m and _G.KimqV28Ready then return r,m end
            task.wait(.12)
        end
    end
    local root,main=waitMain(50)
    if not main then _G.KimqV30Ready=true; _G.KimqV29Ready=true; if loader and loader.Gui then loader.Gui:Destroy() end; return end
    if main:FindFirstChild("KimqV30Marker") then _G.KimqV30Ready=true; _G.KimqV29Ready=true; main.Visible=true; if loader and loader.Gui then loader.Gui:Destroy() end; return end
    local mark=Instance.new("BoolValue",main); mark.Name="KimqV30Marker"
    local shell=main:FindFirstChild("CuteBlueShell") or main
    local function corner(o,r) local c=o:FindFirstChildOfClass("UICorner") or Instance.new("UICorner"); c.CornerRadius=UDim.new(0,r or 12); c.Parent=o; return c end
    local function stroke(o,c,t,w) local s=o:FindFirstChildOfClass("UIStroke") or Instance.new("UIStroke"); s.Color=c; s.Transparency=t or 0; s.Thickness=w or 1; s.Parent=o; return s end
    local function img(p,a,size,pos,z) if not a then return end local x=Instance.new("ImageLabel",p); x.BackgroundTransparency=1; x.Size=size; x.Position=pos; x.Image=a; x.ScaleType=Enum.ScaleType.Fit; x.ZIndex=z or 5; return x end
    local function lbl(p,t,size,pos,font,sz,col,align) local x=Instance.new("TextLabel",p); x.BackgroundTransparency=1; x.Size=size; x.Position=pos; x.Text=t; x.Font=font; x.TextSize=sz; x.TextColor3=col; x.TextXAlignment=align or Enum.TextXAlignment.Left; x.TextYAlignment=Enum.TextYAlignment.Center; return x end
    local function norm(s) return tostring(s or ""):lower():gsub("^[%s♥♡🐾]+",""):gsub("[^%w]","") end

    local badge
    for _,d in ipairs(main:GetDescendants()) do if d:IsA("TextLabel") and tostring(d.Text):match("^V%d+") then badge=d break end end
    local P={}
    local function derive()
        local hot=badge and badge.BackgroundColor3 or Color3.fromRGB(55,112,241)
        local h,s,v=hot:ToHSV(); if s<.25 then hot=Color3.fromRGB(55,112,241) end
        P.hot=hot; P.hot2=Color3.new(1,1,1):Lerp(hot,.36); P.soft=Color3.new(1,1,1):Lerp(hot,.10); P.soft2=Color3.new(1,1,1):Lerp(hot,.17); P.line=Color3.new(1,1,1):Lerp(hot,.36)
        P.paper=Color3.new(1,1,1):Lerp(hot,.035); P.paper2=Color3.new(1,1,1):Lerp(hot,.075); P.text=Color3.fromRGB(52,68,104):Lerp(hot,.28); P.sub=Color3.fromRGB(103,116,142):Lerp(hot,.18); P.white=Color3.new(1,1,1)
    end
    derive()
    local function forceBadge() for _,d in ipairs(main:GetDescendants()) do if d:IsA("TextLabel") and tostring(d.Text):match("^V%d+") then d.Text="V30 ♥" end end end

    -- discover final layout
    local pages,pageHost={},nil
    for _,d in ipairs(main:GetDescendants()) do if d:IsA("ScrollingFrame") and d.Name:match("Page$") then pages[d.Name:gsub("Page$",""):lower()]=d; pageHost=d.Parent end end
    if not pageHost then _G.KimqV29Ready=true; main.Visible=true; if loader and loader.Gui then loader.Gui:Destroy() end; return end
    local content=pageHost.Parent
    local nav,side,top,pageHead
    for _,d in ipairs(shell:GetDescendants()) do if d:IsA("ScrollingFrame") and not d.Name:match("Page$") then local n=0; for _,c in ipairs(d:GetChildren()) do if c:IsA("TextButton") then n+=1 end end; if n>=8 then nav=d; side=d.Parent; break end end end
    for _,c in ipairs(shell:GetChildren()) do if c:IsA("Frame") and c.AbsoluteSize.Y<=115 then for _,x in ipairs(c:GetChildren()) do if x:IsA("TextLabel") and tostring(x.Text):find("Kimqetras HC",1,true) then top=c break end end end; if top then break end end
    if content then for _,c in ipairs(content:GetChildren()) do if c:IsA("Frame") and c~=pageHost then local n=0; for _,x in ipairs(c:GetChildren()) do if x:IsA("TextLabel") then n+=1 end end; if n>=2 then pageHead=c break end end end end
    if not nav or not side or not content then _G.KimqV29Ready=true; main.Visible=true; if loader and loader.Gui then loader.Gui:Destroy() end; return end

    -- remove older decorative layers so V30 is the only visual shell.
    for _,d in ipairs(main:GetDescendants()) do local n=d.Name or ""; if n:match("^V27") or n:match("^V28Outer") or n=="V28Mascot" or n=="V28HeaderStitch" or n=="V28NavPaw" then if not n:find("Skin",1,true) then pcall(function() d:Destroy() end) end end end

    main.Size=UDim2.fromOffset(1280,780); main.Position=UDim2.new(.5,-640,.5,-390); main.BackgroundColor3=P.paper; main.BorderSizePixel=0; main.ClipsDescendants=false; corner(main,26); stroke(main,P.hot,.10,2)
    -- stitching lives in a 28px empty gutter. Content starts at 58px, so it never cuts through panels.
    local stitch=Instance.new("Frame",main); stitch.Name="V30Stitches"; stitch.BackgroundTransparency=1; stitch.Position=UDim2.fromOffset(22,22); stitch.Size=UDim2.new(1,-44,1,-44); stitch.ZIndex=45
    for i=0,45 do for _,yy in ipairs({0,1}) do local d=Instance.new("Frame",stitch); d.Size=UDim2.fromOffset(12,2); d.AnchorPoint=Vector2.new(.5,.5); d.Position=UDim2.new(i/45,0,yy,0); d.BackgroundColor3=P.hot; d.BackgroundTransparency=.40; d.BorderSizePixel=0; d.ZIndex=45; corner(d,2) end end
    for i=0,27 do for _,xx in ipairs({0,1}) do local d=Instance.new("Frame",stitch); d.Size=UDim2.fromOffset(2,12); d.AnchorPoint=Vector2.new(.5,.5); d.Position=UDim2.new(xx,0,i/27,0); d.BackgroundColor3=P.hot; d.BackgroundTransparency=.40; d.BorderSizePixel=0; d.ZIndex=45; corner(d,2) end end
    local cornerPaws={}
    for _,sp in ipairs({{28,28,0},{-58,28,0},{28,-58,0},{-58,-58,0}}) do local p=img(main,A.Paw,UDim2.fromOffset(31,31),UDim2.new(sp[1]<0 and 1 or 0,sp[1],sp[2]<0 and 1 or 0,sp[2]),47); if p then table.insert(cornerPaws,p) end end

    -- header using the exact blue art supplied by the user.
    if top then
        top.Position=UDim2.fromOffset(58,30); top.Size=UDim2.new(1,-116,0,82); top.BackgroundTransparency=1; top.ZIndex=12
        for _,x in ipairs(top:GetChildren()) do
            if x:IsA("TextLabel") and (tostring(x.Text):find("Kimqetras HC",1,true) or tostring(x.Text):find("silent hc",1,true) or tostring(x.Text):find("cute controls",1,true)) then x.Visible=false end
            if x:IsA("Frame") and x:FindFirstChildWhichIsA("ImageLabel") then x.Size=UDim2.fromOffset(205,50); x.Position=UDim2.new(1,-330,0,8); x.BackgroundColor3=P.paper2; x.BorderSizePixel=0; corner(x,14); stroke(x,P.line,.32,1) end
        end
        local pm=img(top,A.Pompom,UDim2.fromOffset(92,86),UDim2.fromOffset(0,-2),16); if pm then pm.Name="V30Pompom" end
        local ti=img(top,A.Title,UDim2.fromOffset(300,90),UDim2.fromOffset(92,-3),16); if ti then ti.Name="V30TitleArt" end
        local si=img(top,A.Subtitle,UDim2.fromOffset(155,51),UDim2.fromOffset(105,42),16); if si then si.Name="V30SubtitleArt" end
        local fallbackTitle=lbl(top,"Kimqetras",UDim2.fromOffset(310,40),UDim2.fromOffset(103,5),Enum.Font.FredokaOne,30,P.hot); fallbackTitle.Name="V30TitleFallback"; fallbackTitle.Visible=not ti
        local fallbackSub=lbl(top,"silent hc  ♡",UDim2.fromOffset(220,24),UDim2.fromOffset(107,47),Enum.Font.FredokaOne,15,P.hot); fallbackSub.Name="V30SubFallback"; fallbackSub.Visible=not si
        for _,n in ipairs({"V28Min","V28Close"}) do local q=top:FindFirstChild(n); if q then q:Destroy() end end
        local function imageButton(name,asset,x)
            local b=Instance.new("ImageButton",top); b.Name=name; b.Size=UDim2.fromOffset(36,36); b.Position=UDim2.new(1,x,0,14); b.BackgroundTransparency=1; b.Image=asset or ""; b.ScaleType=Enum.ScaleType.Fit; b.AutoButtonColor=false; b.ZIndex=20; return b
        end
        local min=imageButton("V30Min",A.Minus,-78); local close=imageButton("V30Close",A.Close,-36)
        local function hide() main.Visible=false; local bubble=root:FindFirstChild("KimqV30Reopen"); if bubble then bubble.Enabled=true end end
        min.MouseButton1Click:Connect(hide); close.MouseButton1Click:Connect(hide)
    end

    side.Position=UDim2.fromOffset(58,126); side.Size=UDim2.new(0,245,1,-184); side.BackgroundColor3=P.paper2; side.BorderSizePixel=0; corner(side,19); stroke(side,P.line,.18,1)
    content.Position=UDim2.fromOffset(323,126); content.Size=UDim2.new(1,-381,1,-184)
    if pageHead then pageHead.Size=UDim2.new(1,0,0,78); pageHead.BackgroundColor3=P.paper2; pageHead.BorderSizePixel=0; corner(pageHead,17); stroke(pageHead,P.line,.20,1) end
    pageHost.Position=UDim2.fromOffset(0,90); pageHost.Size=UDim2.new(1,0,1,-90)
    nav.Position=UDim2.fromOffset(9,58); nav.Size=UDim2.new(1,-18,1,-105); nav.ScrollBarThickness=3; nav.ScrollBarImageColor3=P.hot

    -- sidebar title + paw
    for _,x in ipairs(side:GetChildren()) do if x:IsA("TextLabel") and (tostring(x.Text):lower():find("features",1,true) or tostring(x.Text):lower():find("pages",1,true)) then x.Text="FEATURES"; x.Font=Enum.Font.FredokaOne; x.TextSize=17; x.TextColor3=P.hot; x.Position=UDim2.fromOffset(48,12); x.Size=UDim2.new(1,-64,0,28); x.TextXAlignment=Enum.TextXAlignment.Left end end
    local sidePaw=img(side,A.Paw,UDim2.fromOffset(25,25),UDim2.fromOffset(17,13),7)
    for _,d in ipairs(side:GetDescendants()) do if d:IsA("TextLabel") and tostring(d.Text):find("Right Shift",1,true) then d.Text="Right Shift / Right Click = hide / show"; d.Font=Enum.Font.GothamSemibold; d.TextSize=9; d.TextColor3=P.hot end end

    local navPaws={}
    local function styleNav()
        local current=""
        if pageHead then for _,l in ipairs(pageHead:GetChildren()) do if l:IsA("TextLabel") and l.Visible and l.TextSize>=17 then current=norm(l.Text); break end end end
        for _,b in ipairs(nav:GetChildren()) do if b:IsA("TextButton") then
            local base=tostring(b.Text):gsub("^[%s♥♡]+",""); b.Text="      "..base; b.TextXAlignment=Enum.TextXAlignment.Left; b.Font=Enum.Font.FredokaOne; b.TextSize=13; b.AutoButtonColor=false; b.BorderSizePixel=0; corner(b,11)
            local on=norm(base)==current; b.BackgroundColor3=on and P.hot or P.soft; b.TextColor3=on and P.white or P.text; local s=b:FindFirstChildOfClass("UIStroke") or Instance.new("UIStroke",b); s.Color=on and P.hot or P.line; s.Transparency=on and .05 or .34; s.Thickness=1
            local p=b:FindFirstChild("V30NavPaw"); if not p then p=img(b,A.Paw,UDim2.fromOffset(16,16),UDim2.fromOffset(12,11),7); if p then p.Name="V30NavPaw"; table.insert(navPaws,p) end end; if p then local hh,ss,vv=P.hot:ToHSV(); local isBlue=(hh>.50 and hh<.68); p.ImageColor3=on and P.white or (isBlue and P.white or P.hot2) end
        end end
    end
    if pageHead then
        for _,l in ipairs(pageHead:GetChildren()) do if l:IsA("TextLabel") then if l.TextSize>=17 then l.Position=UDim2.fromOffset(54,9); l.Size=UDim2.new(1,-76,0,30); l.Font=Enum.Font.FredokaOne; l.TextSize=21; l.TextColor3=P.hot elseif #tostring(l.Text)>18 then l.Position=UDim2.fromOffset(19,43); l.Size=UDim2.new(1,-38,0,20); l.Font=Enum.Font.Gotham; l.TextSize=11; l.TextColor3=P.sub end end end
        local php=img(pageHead,A.Paw,UDim2.fromOffset(27,27),UDim2.fromOffset(19,10),7); if php then php.Name="V30PagePaw" end
        local dash=Instance.new("Frame",pageHead); dash.Name="V30HeaderStitch"; dash.BackgroundTransparency=1; dash.Position=UDim2.new(1,-184,0,18); dash.Size=UDim2.fromOffset(154,4)
        for i=0,8 do local d=Instance.new("Frame",dash); d.Size=UDim2.fromOffset(10,2); d.Position=UDim2.new(i/8,-5,.5,-1); d.BackgroundColor3=P.hot; d.BackgroundTransparency=.50; d.BorderSizePixel=0; corner(d,2) end
    end

    -- consistent reference-style cards and controls.
    local function skipColor(o)
        local p=o; while p and p~=main do local n=(p.Name or ""):lower(); if n:find("fogsquare",1,true) or n:find("foghue",1,true) or n:find("fogpreview",1,true) or n:find("colorpicker",1,true) then return true end; p=p.Parent end
        return false
    end
    local toggleArts={}
    local function stylePages()
        for _,p in pairs(pages) do
            p.ScrollBarImageColor3=P.hot
            for _,o in ipairs(p:GetDescendants()) do if not skipColor(o) then
                if o:IsA("Frame") and o.BackgroundTransparency<1 then o.BackgroundColor3=P.paper2; o.BorderSizePixel=0; corner(o,11); local s=o:FindFirstChildOfClass("UIStroke"); if s then s.Color=P.line end
                elseif o:IsA("TextLabel") then o.TextColor3=(o.Font==Enum.Font.FredokaOne or o.TextSize>=17) and P.hot or P.text
                elseif o:IsA("TextBox") then o.BackgroundColor3=P.soft; o.TextColor3=P.text; o.PlaceholderColor3=P.sub; o.BorderSizePixel=0; corner(o,9); local s=o:FindFirstChildOfClass("UIStroke"); if s then s.Color=P.line end
                elseif o:IsA("UIStroke") then o.Color=P.line
                elseif o:IsA("ScrollingFrame") then o.ScrollBarImageColor3=P.hot end
            end end
        end
    end
    local function installToggleArt()
        for _,p in pairs(pages) do for _,b in ipairs(p:GetDescendants()) do if b:IsA("TextButton") and b.Text=="" and b.AbsoluteSize.X>=30 and b.AbsoluteSize.X<=80 and b.AbsoluteSize.Y>=16 and b.AbsoluteSize.Y<=40 then
            local knob=nil; for _,c in ipairs(b:GetChildren()) do if c:IsA("Frame") and c.AbsoluteSize.X<=28 and c.AbsoluteSize.Y<=28 then knob=c break end end
            if knob and not b:FindFirstChild("V30ToggleArt") then
                b.BackgroundTransparency=1; knob.BackgroundTransparency=1
                local art=img(b,A.ToggleOff,UDim2.new(1,4,1,8),UDim2.fromOffset(-2,-4),10); if art then art.Name="V30ToggleArt"; art.ZIndex=10; table.insert(toggleArts,{button=b,knob=knob,art=art})
                    local function sync() local on=knob.Position.X.Scale>.4 or knob.Position.X.Offset>5; art.Image=on and (A.ToggleOn or A.ToggleOff) or A.ToggleOff end
                    sync(); knob:GetPropertyChangedSignal("Position"):Connect(sync); b:GetPropertyChangedSignal("BackgroundColor3"):Connect(sync)
                end
            end
        end end end
    end

    -- Keep the V28 overview layout but swap in the supplied Pompompurin and paw art cleanly.
    local overview=pages["overviewpage"]
    if overview then
        local w=overview:FindFirstChild("V28Welcome"); if w then for _,d in ipairs(w:GetChildren()) do if d:IsA("ImageLabel") and d.Name~="" and d.Image==_G.KimqV27PompomAsset then d:Destroy() end end; local pm=img(w,A.PompomIcon or A.Pompom,UDim2.fromOffset(100,100),UDim2.new(1,-116,0,23),5); if pm then pm.Name="V30WelcomePompom" end end
        local ab=overview:FindFirstChild("V28About"); if ab then for _,d in ipairs(ab:GetChildren()) do if d:IsA("ImageLabel") then d:Destroy() end end; img(ab,A.Paw,UDim2.fromOffset(25,25),UDim2.fromOffset(18,14),5) end
        local co=overview:FindFirstChild("V28Controls"); if co then for _,d in ipairs(co:GetChildren()) do if d:IsA("ImageLabel") then d:Destroy() end end; img(co,A.Paw,UDim2.fromOffset(24,24),UDim2.fromOffset(18,13),5) end
    end

    -- Rebuild Weapon Skins with broader skin detection and attachment-aware alignment.
    do
        local page=pages["weaponskinspage"]
        if page then
            for _,c in ipairs(page:GetChildren()) do pcall(function() c:Destroy() end) end
            page.CanvasSize=UDim2.new(0,0,0,560); page.ScrollBarThickness=3; page.ScrollBarImageColor3=P.hot
            local function panel(size,pos) local f=Instance.new("Frame",page); f.Size=size; f.Position=pos; f.BackgroundColor3=P.paper2; f.BorderSizePixel=0; corner(f,14); stroke(f,P.line,.20,1); return f end
            local intro=panel(UDim2.new(1,-8,0,66),UDim2.fromOffset(0,0)); img(intro,A.Paw,UDim2.fromOffset(25,25),UDim2.fromOffset(16,13),5); lbl(intro,"weapon skins",UDim2.new(1,-60,0,28),UDim2.fromOffset(49,8),Enum.Font.FredokaOne,20,P.hot); lbl(intro,"choose a weapon, select one of its skins, then apply it locally",UDim2.new(1,-28,0,20),UDim2.fromOffset(16,39),Enum.Font.Gotham,11,P.sub)
            local left=panel(UDim2.new(.34,-6,0,370),UDim2.fromOffset(0,78)); local right=panel(UDim2.new(.66,-8,0,370),UDim2.new(.34,6,0,78))
            lbl(left,"Weapon",UDim2.new(0,120,0,24),UDim2.fromOffset(12,8),Enum.Font.FredokaOne,16,P.text)
            local refresh=Instance.new("TextButton",left); refresh.Size=UDim2.fromOffset(78,26); refresh.Position=UDim2.new(1,-90,0,7); refresh.BackgroundColor3=P.soft; refresh.BorderSizePixel=0; refresh.Text="refresh"; refresh.TextColor3=P.text; refresh.Font=Enum.Font.GothamBold; refresh.TextSize=10; refresh.AutoButtonColor=false; corner(refresh,8); stroke(refresh,P.line,.33,1)
            local weapons=Instance.new("ScrollingFrame",left); weapons.Size=UDim2.new(1,-18,1,-48); weapons.Position=UDim2.fromOffset(9,40); weapons.BackgroundTransparency=1; weapons.BorderSizePixel=0; weapons.ScrollBarThickness=3; weapons.ScrollBarImageColor3=P.hot; local wl=Instance.new("UIListLayout",weapons); wl.Padding=UDim.new(0,7); wl.SortOrder=Enum.SortOrder.LayoutOrder; wl:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() weapons.CanvasSize=UDim2.new(0,0,0,wl.AbsoluteContentSize.Y+6) end)
            lbl(right,"Skins",UDim2.new(0,100,0,24),UDim2.fromOffset(12,8),Enum.Font.FredokaOne,16,P.text); local chosen=lbl(right,"pick a weapon",UDim2.new(1,-130,0,22),UDim2.fromOffset(112,8),Enum.Font.Gotham,11,P.sub,Enum.TextXAlignment.Right)
            local search=Instance.new("TextBox",right); search.Size=UDim2.new(1,-20,0,32); search.Position=UDim2.fromOffset(10,38); search.BackgroundColor3=P.soft; search.BorderSizePixel=0; search.PlaceholderText="search skins..."; search.PlaceholderColor3=P.sub; search.Text=""; search.TextColor3=P.text; search.Font=Enum.Font.Gotham; search.TextSize=12; search.ClearTextOnFocus=false; search.TextXAlignment=Enum.TextXAlignment.Left; corner(search,9); stroke(search,P.line,.33,1); local pd=Instance.new("UIPadding",search); pd.PaddingLeft=UDim.new(0,10)
            local skins=Instance.new("ScrollingFrame",right); skins.Size=UDim2.new(1,-18,1,-84); skins.Position=UDim2.fromOffset(9,76); skins.BackgroundTransparency=1; skins.BorderSizePixel=0; skins.ScrollBarThickness=3; skins.ScrollBarImageColor3=P.hot; local sl=Instance.new("UIListLayout",skins); sl.Padding=UDim.new(0,7); sl.SortOrder=Enum.SortOrder.LayoutOrder; sl:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() skins.CanvasSize=UDim2.new(0,0,0,sl.AbsoluteContentSize.Y+6) end)
            local actions=panel(UDim2.new(1,-8,0,58),UDim2.fromOffset(0,460)); local apply=Instance.new("TextButton",actions); apply.Size=UDim2.new(.68,-14,0,36); apply.Position=UDim2.new(0,10,.5,-18); apply.BackgroundColor3=P.hot; apply.BorderSizePixel=0; apply.Text="      Apply Skin"; apply.TextColor3=P.white; local apaw=img(apply,A.Paw,UDim2.fromOffset(17,17),UDim2.fromOffset(12,9),8); if apaw then apaw.Name="V30ApplyPaw"; apaw.ImageColor3=P.white end; apply.Font=Enum.Font.GothamBold; apply.TextSize=12; apply.AutoButtonColor=false; corner(apply,10); local reset=Instance.new("TextButton",actions); reset.Size=UDim2.new(.32,-14,0,36); reset.Position=UDim2.new(.68,4,.5,-18); reset.BackgroundColor3=P.soft; reset.BorderSizePixel=0; reset.Text="      Reset"; reset.TextColor3=P.text; reset.Font=Enum.Font.GothamBold; reset.TextSize=12; reset.TextXAlignment=Enum.TextXAlignment.Left; reset.AutoButtonColor=false; corner(reset,10); stroke(reset,P.line,.32,1); local rart=img(reset,A.Reset,UDim2.fromOffset(18,18),UDim2.fromOffset(12,9),8); if rart then rart.Name="V30ResetArt" end
            local status=lbl(page,"finding your weapons...",UDim2.new(1,-20,0,24),UDim2.fromOffset(10,526),Enum.Font.Gotham,11,P.sub)
            _G.KimqV29WeaponSkins=_G.KimqV29WeaponSkins or {Selected={}}; local selected=_G.KimqV29WeaponSkins.Selected
            local wrapRoot,currentWeapon,currentSkin; local folderByName,weaponButtons,skinButtons={},{},{}
            local function key(s) return tostring(s or ""):lower():gsub("[%[%]%s_%-]","") end
            local function display(s) return tostring(s or ""):gsub("%[",""):gsub("%]","") end
            local function setStatus(t,good) status.Text=t; status.TextColor3=good and P.hot or P.sub end
            local function locateWraps()
                local arr={}; local x=workspace:FindFirstChild("Wraps"); if x then table.insert(arr,x) end; for _,d in ipairs(workspace:GetDescendants()) do if d.Name=="Wraps" then table.insert(arr,d) end end; local r=ReplicatedStorage:FindFirstChild("Wraps"); if r then table.insert(arr,r) end; for _,d in ipairs(ReplicatedStorage:GetDescendants()) do if d.Name=="Wraps" then table.insert(arr,d) end end; table.sort(arr,function(a,b) return #a:GetChildren()>#b:GetChildren() end); return arr[1]
            end
            local function firstPart(o)
                if not o then return end; if o:IsA("BasePart") then return o end; local h=o:FindFirstChild("Handle",true); if h and h:IsA("BasePart") then return h end; if o:IsA("Model") and o.PrimaryPart then return o.PrimaryPart end; local best=nil; for _,d in ipairs(o:GetDescendants()) do if d:IsA("BasePart") and (not best or d.Size.Magnitude>best.Size.Magnitude) then best=d end end; return best
            end
            local function skinUsable(o) return firstPart(o)~=nil end
            local function findTool(name)
                local char=lp.Character; local bp=lp:FindFirstChildOfClass("Backpack"); local exact=(char and char:FindFirstChild(name)) or (bp and bp:FindFirstChild(name)); if exact then return exact end; local k=key(name); for _,c in ipairs({char,bp}) do if c then for _,t in ipairs(c:GetChildren()) do if t:IsA("Tool") and key(t.Name)==k then return t end end end end
            end
            local function commonAttachment(src,target)
                if not src or not target then return end
                local map={}; for _,a in ipairs(target:GetDescendants()) do if a:IsA("Attachment") then map[a.Name]=a end end
                for _,a in ipairs(src:GetDescendants()) do if a:IsA("Attachment") and map[a.Name] then return a,map[a.Name] end end
            end
            local function clear(tool)
                if not tool then return end; for _,d in ipairs(tool:GetDescendants()) do if d.Name=="KimqV29SkinVisual" or d.Name=="KimqV28SkinVisual" or d.Name=="KimqV23SkinVisual" or d.Name=="KimqV22SkinVisual" then pcall(function() d:Destroy() end) end end; local h=tool:FindFirstChild("Handle",true); if h and h:IsA("BasePart") then local v=h:GetAttribute("KimqV29OriginalLTM"); pcall(function() h.LocalTransparencyModifier=type(v)=="number" and v or 0 end) end
            end
            local function cloneSource(s) local old=s.Archivable; pcall(function() s.Archivable=true end); local ok,c=pcall(function() return s:Clone() end); pcall(function() s.Archivable=old end); if ok then return c end end
            local function applyVisual(w,s,tool,quiet)
                local wf=folderByName[w]; local source=wf and wf:FindFirstChild(s); if not source then if not quiet then setStatus("That skin is no longer available",false) end return false end
                local gun=tool or findTool(w); if not gun then selected[w]=s; if not quiet then setStatus(display(w).." saved • equip it and the skin will apply",true) end return true end
                local target=gun:FindFirstChild("Handle",true); if not target or not target:IsA("BasePart") then target=firstPart(gun) end; local srcAnchor=firstPart(source); if not target or not srcAnchor then if not quiet then setStatus("That skin has no usable visual anchor",false) end return false end
                local clone=cloneSource(source); if not clone then if not quiet then setStatus("That skin could not be cloned",false) end return false end
                clear(gun); local wrapper=Instance.new("Model",gun); wrapper.Name="KimqV29SkinVisual"; clone.Parent=wrapper
                for _,d in ipairs(wrapper:GetDescendants()) do if d:IsA("Script") or d:IsA("LocalScript") or d:IsA("ModuleScript") or d:IsA("JointInstance") or d:IsA("Constraint") then pcall(function() d:Destroy() end) end end
                local clonedAnchor=firstPart(clone); if not clonedAnchor then wrapper:Destroy(); return false end
                local parts={}; for _,d in ipairs(wrapper:GetDescendants()) do if d:IsA("BasePart") then table.insert(parts,d) end end; if clone:IsA("BasePart") then table.insert(parts,clone) end
                local srcAtt,tgtAtt=commonAttachment(clonedAnchor,target); local delta
                if srcAtt and tgtAtt then delta=(target.CFrame*tgtAtt.CFrame)*(clonedAnchor.CFrame*srcAtt.CFrame):Inverse() else delta=target.CFrame*clonedAnchor.CFrame:Inverse() end
                for _,part in ipairs(parts) do part.Anchored=false; part.CanCollide=false; part.CanTouch=false; part.CanQuery=false; part.Massless=true; part.AssemblyLinearVelocity=Vector3.zero; part.AssemblyAngularVelocity=Vector3.zero; part.CFrame=delta*part.CFrame end
                for _,part in ipairs(parts) do local wld=Instance.new("WeldConstraint",part); wld.Name="KimqV29SkinWeld"; wld.Part0=target; wld.Part1=part end
                if target:GetAttribute("KimqV29OriginalLTM")==nil then pcall(function() target:SetAttribute("KimqV29OriginalLTM",target.LocalTransparencyModifier) end) end; pcall(function() target.LocalTransparencyModifier=1 end); selected[w]=s; if not quiet then setStatus(display(w).." • "..s.." applied locally",true) end; return true
            end
            local function makeButton(parent,text) local b=Instance.new("TextButton",parent); b.Size=UDim2.new(1,-5,0,36); b.BackgroundColor3=P.soft; b.BorderSizePixel=0; b.Text=text; b.TextColor3=P.text; b.Font=Enum.Font.GothamBold; b.TextSize=11; b.TextXAlignment=Enum.TextXAlignment.Left; b.AutoButtonColor=false; corner(b,9); stroke(b,P.line,.34,1); local p=Instance.new("UIPadding",b); p.PaddingLeft=UDim.new(0,11); return b end
            local function styleButtons() for n,b in pairs(weaponButtons) do local on=n==currentWeapon; b.BackgroundColor3=on and P.hot or P.soft; b.TextColor3=on and P.white or P.text end; for n,b in pairs(skinButtons) do local on=n==currentSkin; b.BackgroundColor3=on and P.hot or P.soft; b.TextColor3=on and P.white or P.text end end
            local function buildSkins()
                for _,c in ipairs(skins:GetChildren()) do if c:IsA("TextButton") then c:Destroy() end end; table.clear(skinButtons); local wf=currentWeapon and folderByName[currentWeapon]; if not wf then chosen.Text="pick a weapon"; return end
                local q=search.Text:lower(); local list={}; for _,s in ipairs(wf:GetChildren()) do if skinUsable(s) and (q=="" or s.Name:lower():find(q,1,true)) then table.insert(list,s) end end; table.sort(list,function(a,b) return a.Name:lower()<b.Name:lower() end); currentSkin=selected[currentWeapon]; chosen.Text=currentSkin and ("selected: "..currentSkin) or display(currentWeapon)
                for i,s in ipairs(list) do local b=makeButton(skins,s.Name); b.LayoutOrder=i; skinButtons[s.Name]=b; b.MouseButton1Click:Connect(function() currentSkin=s.Name; chosen.Text="selected: "..s.Name; styleButtons(); setStatus("Selected "..s.Name.." • press Apply Skin",true) end) end; styleButtons(); setStatus(#list>0 and ("Found "..#list.." skins for "..display(currentWeapon)) or ("No skins found for "..display(currentWeapon)),#list>0)
            end
            local function scan()
                for _,c in ipairs(weapons:GetChildren()) do if c:IsA("TextButton") then c:Destroy() end end; table.clear(folderByName); table.clear(weaponButtons); wrapRoot=locateWraps(); if not wrapRoot then setStatus("Could not find the Wraps folder • press refresh",false); return end
                local folders={}; for _,wf in ipairs(wrapRoot:GetChildren()) do if (wf:IsA("Folder") or wf:IsA("Model")) and #wf:GetChildren()>0 then table.insert(folders,wf); folderByName[wf.Name]=wf end end; table.sort(folders,function(a,b) return a.Name:lower()<b.Name:lower() end)
                for i,wf in ipairs(folders) do local b=makeButton(weapons,display(wf.Name)); b.LayoutOrder=i; weaponButtons[wf.Name]=b; b.MouseButton1Click:Connect(function() currentWeapon=wf.Name; currentSkin=selected[currentWeapon]; styleButtons(); buildSkins() end) end
                if #folders==0 then setStatus("Wraps was found, but no weapon folders were inside it",false); return end; if not currentWeapon or not folderByName[currentWeapon] then currentWeapon=folders[1].Name end; styleButtons(); buildSkins()
            end
            refresh.MouseButton1Click:Connect(scan); search:GetPropertyChangedSignal("Text"):Connect(function() task.defer(buildSkins) end); apply.MouseButton1Click:Connect(function() if not currentWeapon then setStatus("Choose a weapon first",false) elseif not currentSkin then setStatus("Choose a skin first",false) else applyVisual(currentWeapon,currentSkin,nil,false) end end); reset.MouseButton1Click:Connect(function() if currentWeapon then selected[currentWeapon]=nil; clear(findTool(currentWeapon)); currentSkin=nil; chosen.Text=display(currentWeapon); styleButtons(); setStatus(display(currentWeapon).." reset",true) end end)
            local function selectedForTool(name) if selected[name] then return name,selected[name] end; local k=key(name); for w,s in pairs(selected) do if key(w)==k then return w,s end end end
            local function hookContainer(c) if not c or c:GetAttribute("KimqV29Hook") then return end; c:SetAttribute("KimqV29Hook",true); c.ChildAdded:Connect(function(t) if t:IsA("Tool") then local w,s=selectedForTool(t.Name); if w and s then task.delay(.22,function() applyVisual(w,s,t,true) end) end end end); for _,t in ipairs(c:GetChildren()) do if t:IsA("Tool") then local w,s=selectedForTool(t.Name); if w and s then task.delay(.15,function() applyVisual(w,s,t,true) end) end end end end
            hookContainer(lp:FindFirstChildOfClass("Backpack")); if lp.Character then hookContainer(lp.Character) end; lp.CharacterAdded:Connect(function(c) hookContainer(c); task.delay(1,function() hookContainer(lp:FindFirstChildOfClass("Backpack")); scan() end) end); page:GetPropertyChangedSignal("Visible"):Connect(function() if page.Visible then task.defer(scan) end end); scan()
        end
    end

    -- floating Pompompurin reopen button + one Right Click listener. We disabled the older duplicated Right Click binding in the base file.
    pcall(function() local old=root:FindFirstChild("KimqV30Reopen"); if old then old:Destroy() end end)
    local reopen=Instance.new("ScreenGui"); reopen.Name="KimqV30Reopen"; reopen.ResetOnSpawn=false; reopen.Enabled=false; reopen.DisplayOrder=999999; pcall(function() reopen.Parent=CoreGui end); if not reopen.Parent then reopen.Parent=pg end
    local rb=Instance.new("ImageButton",reopen); rb.AnchorPoint=Vector2.new(.5,.5); rb.Position=UDim2.new(0,70,1,-70); rb.Size=UDim2.fromOffset(66,66); rb.BackgroundColor3=P.paper2; rb.BorderSizePixel=0; rb.Image=A.PompomIcon or A.Pompom or ""; rb.ScaleType=Enum.ScaleType.Fit; rb.AutoButtonColor=false; corner(rb,18); stroke(rb,P.hot,.12,2)
    rb.MouseButton1Click:Connect(function() reopen.Enabled=false; main.Visible=true end)
    UIS.InputBegan:Connect(function(input,processed)
        if input.UserInputType==Enum.UserInputType.MouseButton2 and not UIS:GetFocusedTextBox() then main.Visible=not main.Visible; reopen.Enabled=not main.Visible end
    end)
    main:GetPropertyChangedSignal("Visible"):Connect(function() reopen.Enabled=not main.Visible end)

    local function recolor()
        derive(); forceBadge(); main.BackgroundColor3=P.paper; local ms=main:FindFirstChildOfClass("UIStroke"); if ms then ms.Color=P.hot end
        for _,d in ipairs(stitch:GetChildren()) do if d:IsA("Frame") then d.BackgroundColor3=P.hot end end
        local h,s,v=P.hot:ToHSV(); local blue=(h>.50 and h<.68); local artTint=blue and P.white or P.hot2
        for _,p in ipairs(cornerPaws) do p.ImageColor3=artTint end; if sidePaw then sidePaw.ImageColor3=artTint end; local php=pageHead and pageHead:FindFirstChild("V30PagePaw"); if php then php.ImageColor3=artTint end; nav.ScrollBarImageColor3=P.hot; if pageHost then for _,p in pairs(pages) do p.ScrollBarImageColor3=P.hot end end
        if top then local ti=top:FindFirstChild("V30TitleArt"); local si=top:FindFirstChild("V30SubtitleArt"); local ft=top:FindFirstChild("V30TitleFallback"); local fs=top:FindFirstChild("V30SubFallback"); if ti then ti.Visible=blue; ti.ImageColor3=P.white end; if si then si.Visible=blue; si.ImageColor3=P.white end; if ft then ft.Visible=not blue; ft.TextColor3=P.hot end; if fs then fs.Visible=not blue; fs.TextColor3=P.hot end; local pm=top:FindFirstChild("V30Pompom"); if pm then pm.ImageColor3=blue and P.white or Color3.new(1,1,1):Lerp(P.hot,.16) end; local mi=top:FindFirstChild("V30Min"); local ci=top:FindFirstChild("V30Close"); if mi then mi.ImageColor3=artTint end; if ci then ci.ImageColor3=artTint end end
        styleNav(); stylePages(); for _,t in ipairs(toggleArts) do if t.art then t.art.ImageColor3=artTint end end
        local rr=main:FindFirstChild("V30ResetArt",true); if rr and rr:IsA("ImageLabel") then rr.ImageColor3=artTint end
        local wp=main:FindFirstChild("V30WelcomePompom",true); if wp and wp:IsA("ImageLabel") then wp.ImageColor3=blue and P.white or Color3.new(1,1,1):Lerp(P.hot,.14) end
        rb.BackgroundColor3=P.paper2; rb.ImageColor3=blue and P.white or Color3.new(1,1,1):Lerp(P.hot,.12); local rs=rb:FindFirstChildOfClass("UIStroke"); if rs then rs.Color=P.hot end
    end
    styleNav(); stylePages(); installToggleArt(); forceBadge()
    if badge then badge:GetPropertyChangedSignal("BackgroundColor3"):Connect(function() task.defer(recolor) end) end
    if pageHead then for _,l in ipairs(pageHead:GetChildren()) do if l:IsA("TextLabel") and l.TextSize>=17 then l:GetPropertyChangedSignal("Text"):Connect(function() task.defer(styleNav) end); break end end end
    nav.ChildAdded:Connect(function(c) if c:IsA("TextButton") then task.delay(.05,styleNav) end end)
    recolor(); task.delay(.3,forceBadge); task.delay(1,forceBadge)

    _G.KimqV30Ready=true; _G.KimqV29Ready=true; main.Visible=true
    if loader and loader.Gui and loader.Gui.Parent then
        if loader.Card then TweenService:Create(loader.Card,TweenInfo.new(.28,Enum.EasingStyle.Quart,Enum.EasingDirection.In),{Position=UDim2.new(.5,0,.5,10),BackgroundTransparency=1}):Play() end
        if loader.Background then TweenService:Create(loader.Background,TweenInfo.new(.32,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{BackgroundTransparency=1}):Play() end
        task.wait(.34); pcall(function() loader.Gui:Destroy() end)
    end
end)

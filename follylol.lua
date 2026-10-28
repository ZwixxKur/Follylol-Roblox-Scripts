local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local TeleportService = game:GetService("TeleportService")
local Stats = game:GetService("Stats")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local CONFIG = {
	Title = "Folly Hub",
	Subtitle = "follylol",
	Footer = "folly.lol -- by Ferix",
	Version = "2.0",
	ToggleKey = Enum.KeyCode.RightShift,
	DefaultTheme = "Glacier",
	DefaultFont = "Mono",
	ShowIntro = true,
	Language = "EN",
}

local Settings = {
	Theme = CONFIG.DefaultTheme,
	Font = CONFIG.DefaultFont,
	Language = CONFIG.Language,
	Glass = "Liquid",
	Scale = 1,
	Blur = true,
	Particles = true,
	Notifications = true,
	FloatingButton = true,
	ToggleKey = CONFIG.ToggleKey.Name,
	SkipIntro = not CONFIG.ShowIntro,
}

local function rgb(r, g, b) return Color3.fromRGB(r, g, b) end

local Themes = {
	Amethyst = {BgTop = rgb(36, 24, 58), BgBottom = rgb(14, 9, 26), Card = rgb(52, 36, 82), Stroke = rgb(196, 166, 255), Text = rgb(243, 237, 255), SubText = rgb(182, 170, 212), Muted = rgb(124, 112, 154), Accent = rgb(168, 108, 255), Accent2 = rgb(224, 150, 255), Track = rgb(22, 14, 38), Knob = rgb(255, 255, 255), OnAccent = rgb(255, 255, 255)},
	Glacier = {BgTop = rgb(26, 42, 62), BgBottom = rgb(8, 14, 24), Card = rgb(34, 54, 78), Stroke = rgb(160, 205, 255), Text = rgb(234, 243, 255), SubText = rgb(150, 178, 210), Muted = rgb(102, 124, 152), Accent = rgb(64, 150, 245), Accent2 = rgb(128, 214, 255), Track = rgb(12, 22, 36), Knob = rgb(255, 255, 255), OnAccent = rgb(255, 255, 255)},
	Sakura = {BgTop = rgb(54, 26, 40), BgBottom = rgb(22, 10, 18), Card = rgb(72, 36, 54), Stroke = rgb(255, 176, 208), Text = rgb(255, 238, 245), SubText = rgb(216, 172, 192), Muted = rgb(152, 110, 130), Accent = rgb(255, 100, 160), Accent2 = rgb(255, 160, 200), Track = rgb(34, 14, 26), Knob = rgb(255, 255, 255), OnAccent = rgb(255, 255, 255)},
	Aurora = {BgTop = rgb(18, 46, 44), BgBottom = rgb(6, 18, 18), Card = rgb(26, 62, 58), Stroke = rgb(140, 240, 205), Text = rgb(230, 255, 247), SubText = rgb(156, 208, 192), Muted = rgb(98, 142, 130), Accent = rgb(46, 212, 150), Accent2 = rgb(120, 240, 205), Track = rgb(8, 28, 26), Knob = rgb(255, 255, 255), OnAccent = rgb(6, 32, 24)},
	Onyx = {BgTop = rgb(30, 28, 22), BgBottom = rgb(10, 10, 8), Card = rgb(42, 40, 32), Stroke = rgb(226, 196, 140), Text = rgb(248, 242, 230), SubText = rgb(188, 178, 158), Muted = rgb(126, 118, 102), Accent = rgb(226, 164, 72), Accent2 = rgb(250, 206, 124), Track = rgb(18, 17, 13), Knob = rgb(255, 255, 255), OnAccent = rgb(36, 24, 6)},
	Frost = {BgTop = rgb(244, 247, 253), BgBottom = rgb(214, 223, 242), Card = rgb(255, 255, 255), Stroke = rgb(128, 148, 196), Text = rgb(26, 32, 50), SubText = rgb(82, 94, 122), Muted = rgb(140, 150, 176), Accent = rgb(48, 98, 232), Accent2 = rgb(98, 148, 255), Track = rgb(214, 221, 238), Knob = rgb(255, 255, 255), OnAccent = rgb(255, 255, 255), Light = true},
	Neon = {BgTop = rgb(44, 10, 54), BgBottom = rgb(14, 4, 22), Card = rgb(62, 18, 72), Stroke = rgb(255, 120, 226), Text = rgb(255, 238, 252), SubText = rgb(216, 162, 216), Muted = rgb(152, 102, 162), Accent = rgb(255, 64, 196), Accent2 = rgb(64, 226, 255), Track = rgb(26, 6, 32), Knob = rgb(255, 255, 255), OnAccent = rgb(255, 255, 255)},
	Ember = {BgTop = rgb(58, 32, 14), BgBottom = rgb(20, 11, 6), Card = rgb(76, 44, 20), Stroke = rgb(255, 186, 120), Text = rgb(255, 243, 230), SubText = rgb(216, 186, 158), Muted = rgb(152, 122, 98), Accent = rgb(255, 128, 40), Accent2 = rgb(255, 184, 92), Track = rgb(32, 18, 8), Knob = rgb(255, 255, 255), OnAccent = rgb(44, 18, 2)},
	Midnight = {BgTop = rgb(12, 12, 20), BgBottom = rgb(2, 2, 4), Card = rgb(20, 20, 32), Stroke = rgb(146, 156, 255), Text = rgb(234, 236, 255), SubText = rgb(156, 160, 198), Muted = rgb(96, 100, 132), Accent = rgb(120, 130, 255), Accent2 = rgb(172, 182, 255), Track = rgb(6, 6, 12), Knob = rgb(255, 255, 255), OnAccent = rgb(255, 255, 255)},
	Smoke = {BgTop = rgb(52, 52, 56), BgBottom = rgb(20, 20, 22), Card = rgb(66, 66, 72), Stroke = rgb(226, 226, 236), Text = rgb(245, 245, 248), SubText = rgb(182, 182, 192), Muted = rgb(124, 124, 134), Accent = rgb(150, 150, 162), Accent2 = rgb(228, 228, 236), Track = rgb(26, 26, 28), Knob = rgb(255, 255, 255), OnAccent = rgb(22, 22, 26)},
}
local ThemeOrder = {"Amethyst", "Glacier", "Sakura", "Aurora", "Onyx", "Frost", "Neon", "Ember", "Midnight", "Smoke"}

for _, t in pairs(Themes) do
	t.StrokeT = t.Light and 0.55 or 0.8
end

local FontList = {
	{Name = "Gotham", Enum = Enum.Font.Gotham},
	{Name = "Roboto", Enum = Enum.Font.Roboto},
	{Name = "Nunito", Enum = Enum.Font.Nunito},
	{Name = "Ubuntu", Enum = Enum.Font.Ubuntu},
	{Name = "Josefin", Enum = Enum.Font.JosefinSans},
	{Name = "Oswald", Enum = Enum.Font.Oswald},
	{Name = "Merriweather", Enum = Enum.Font.Merriweather},
	{Name = "Mono", Enum = Enum.Font.RobotoMono},
}

local function fontFamily(name)
	for _, f in ipairs(FontList) do
		if f.Name == name then return Font.fromEnum(f.Enum).Family end
	end
	return Font.fromEnum(Enum.Font.Gotham).Family
end

local WHITE = Color3.new(1, 1, 1)
local BLACK = Color3.new(0, 0, 0)
local CENTER = Enum.TextXAlignment.Center
local AUTO_Y = Enum.AutomaticSize.Y
local W = {R = Enum.FontWeight.Regular, M = Enum.FontWeight.Medium, S = Enum.FontWeight.SemiBold, B = Enum.FontWeight.Bold}

local Theme = Themes[Settings.Theme] or Themes[CONFIG.DefaultTheme]
local CurrentFamily = fontFamily(Settings.Font)
local Painted = setmetatable({}, {__mode = "k"})
local Texts = setmetatable({}, {__mode = "k"})
local ThemeHooks = {}
local Connections = {}

local function connect(signal, fn)
	local c = signal:Connect(fn)
	table.insert(Connections, c)
	return c
end

local function fire(cb, ...)
	if not cb then return end
	task.spawn(function(...)
		local ok, err = pcall(cb, ...)
		if not ok then warn("[follylol] " .. tostring(err)) end
	end, ...)
end

local function new(class, props)
	local inst = Instance.new(class)
	if inst:IsA("GuiObject") then inst.BorderSizePixel = 0 end
	local parent
	if props then
		for k, v in pairs(props) do
			if k == "Parent" then parent = v else inst[k] = v end
		end
	end
	if parent then inst.Parent = parent end
	return inst
end

local function paint(inst, map)
	local entry = Painted[inst]
	if not entry then
		entry = {}
		Painted[inst] = entry
	end
	for prop, key in pairs(map) do
		entry[prop] = key
		inst[prop] = Theme[key]
	end
	return inst
end

local function onTheme(fn)
	table.insert(ThemeHooks, fn)
	fn()
	return fn
end

local function setText(inst, weight)
	weight = weight or W.R
	Texts[inst] = weight
	inst.FontFace = Font.new(CurrentFamily, weight)
	return inst
end

local Translated = setmetatable({}, {__mode = "k"})
local LangHooks = {}

local function T(text)
	if type(text) ~= "table" then return text end
	return Settings.Language == "RU" and text[2] or text[1]
end

local function tween(inst, t, props, style, dir)
	local tw = TweenService:Create(inst, TweenInfo.new(t, style or Enum.EasingStyle.Quint, dir or Enum.EasingDirection.Out), props)
	tw:Play()
	return tw
end

local function corner(parent, r)
	return new("UICorner", {CornerRadius = UDim.new(0, r or 8), Parent = parent})
end

local function stroke(parent, colorKey, transparency, thickness)
	local s = new("UIStroke", {Thickness = thickness or 1, ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Parent = parent})
	paint(s, {Color = colorKey or "Stroke"})
	if type(transparency) == "string" then
		paint(s, {Transparency = transparency})
	else
		s.Transparency = transparency or 0.8
	end
	return s
end

local function padding(parent, t, r, b, l)
	return new("UIPadding", {
		PaddingTop = UDim.new(0, t),
		PaddingRight = UDim.new(0, r or t),
		PaddingBottom = UDim.new(0, b or t),
		PaddingLeft = UDim.new(0, l or r or t),
		Parent = parent,
	})
end

local function accentGradient(parent, rotation)
	local g = new("UIGradient", {Rotation = rotation or 0, Parent = parent})
	onTheme(function() g.Color = ColorSequence.new(Theme.Accent, Theme.Accent2) end)
	return g
end

local function label(parent, text, size, weight, colorKey, props)
	local l = new("TextLabel", {
		BackgroundTransparency = 1,
		Text = T(text) or "",
		TextSize = size or 12,
		TextXAlignment = Enum.TextXAlignment.Left,
		Parent = parent,
	})
	if props then
		for k, v in pairs(props) do l[k] = v end
	end
	setText(l, weight)
	paint(l, {TextColor3 = colorKey or "Text"})
	if type(text) == "table" then Translated[l] = text end
	return l
end

local function escapeRich(s)
	return (tostring(s):gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;"))
end

local function isPress(input)
	return input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch
end

local function isMove(input)
	return input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch
end

local function fitScale(w, h)
	local cam = workspace.CurrentCamera
	local vp = cam and cam.ViewportSize or Vector2.new(1920, 1080)
	if vp.X < 100 then return 1 end
	return math.min(1, (vp.X - 24) / w, (vp.Y - 24) / h)
end

local function keyFromName(name)
	local ok, key = pcall(function() return Enum.KeyCode[name] end)
	return ok and key or CONFIG.ToggleKey
end

local function applyTheme(name)
	if not Themes[name] then name = CONFIG.DefaultTheme end
	Settings.Theme = name
	Theme = Themes[name]
	for inst, map in pairs(Painted) do
		for prop, key in pairs(map) do inst[prop] = Theme[key] end
	end
	for _, fn in ipairs(ThemeHooks) do
		local ok, err = pcall(fn)
		if not ok then warn("[follylol] theme hook: " .. tostring(err)) end
	end
end

local function applyFont(name)
	Settings.Font = name
	CurrentFamily = fontFamily(name)
	for inst, weight in pairs(Texts) do
		inst.FontFace = Font.new(CurrentFamily, weight)
	end
end

local function applyLanguage(lang)
	Settings.Language = lang
	for inst, text in pairs(Translated) do inst.Text = T(text) end
	for _, fn in ipairs(LangHooks) do
		local ok, err = pcall(fn)
		if not ok then warn("[follylol] language hook: " .. tostring(err)) end
	end
end

local GLASS = {
	Liquid = {window = 0.42, modal = 0.2, card = 0.6, control = 0.45, pill = 0.55, solid = 0, gloss = 0.86, rim = 0, caustic = 0.1},
	Frosted = {window = 0.14, modal = 0.08, card = 0.42, control = 0.3, pill = 0.4, solid = 0, gloss = 0.92, rim = 0.3, caustic = 0.55},
	Solid = {window = 0.02, modal = 0.02, card = 0.18, control = 0.15, pill = 0.2, solid = 0, gloss = 0.97, rim = 0.55, caustic = 0.9},
}
local GlassOrder = {"Liquid", "Frosted", "Solid"}

local function glassValue(key)
	local mode = GLASS[Settings.Glass] or GLASS.Liquid
	local v = mode[key] or 0
	if Theme.Light and (key == "window" or key == "modal") then v *= 0.5 end
	return v
end

local GlassSurfaces, GlassRims, GlassGlosses, GlassCaustics, Speculars = {}, {}, {}, {}, {}

local function rimSequence(base)
	local function t(v) return math.clamp(base + v * (1 - base), 0, 1) end
	return NumberSequence.new({
		NumberSequenceKeypoint.new(0, t(0.05)),
		NumberSequenceKeypoint.new(0.22, t(0.6)),
		NumberSequenceKeypoint.new(0.5, t(0.9)),
		NumberSequenceKeypoint.new(0.78, t(0.6)),
		NumberSequenceKeypoint.new(1, t(0.2)),
	})
end

local function applyRim(r)
	local edge = Theme.Light and Theme.Stroke or WHITE
	local mid = Theme.Light and Theme.Stroke or Theme.Accent2
	r.Gradient.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, edge),
		ColorSequenceKeypoint.new(0.5, mid),
		ColorSequenceKeypoint.new(1, edge),
	})
	r.Gradient.Transparency = rimSequence(math.clamp(glassValue("rim") + r.Soft, 0, 0.95))
end

local function refreshGlass()
	for _, s in ipairs(GlassSurfaces) do s.Frame.BackgroundTransparency = glassValue(s.Kind) end
	for _, r in ipairs(GlassRims) do applyRim(r) end
	for _, g in ipairs(GlassGlosses) do g.BackgroundTransparency = glassValue("gloss") end
	for _, c in ipairs(GlassCaustics) do c.Transparency = glassValue("caustic") end
	for _, sp in ipairs(Speculars) do sp.Blob.Visible = Settings.Glass == "Liquid" end
end
onTheme(refreshGlass)

local function glassify(frame, kind, radius, opts)
	opts = opts or {}
	table.insert(GlassSurfaces, {Frame = frame, Kind = kind})
	frame.BackgroundTransparency = glassValue(kind)

	local rim = new("UIStroke", {Thickness = opts.RimThickness or 1, Color = WHITE, ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Parent = frame})
	local r = {Gradient = new("UIGradient", {Rotation = 35, Parent = rim}), Soft = opts.RimSoft or 0}
	table.insert(GlassRims, r)
	applyRim(r)

	if opts.Gloss ~= false then
		local gloss = new("Frame", {
			Size = opts.GlossHeight and UDim2.new(1, 0, 0, opts.GlossHeight) or UDim2.fromScale(1, 0.5),
			BackgroundColor3 = WHITE,
			BackgroundTransparency = glassValue("gloss"),
			ZIndex = opts.GlossZ or 0,
			Parent = frame,
		})
		corner(gloss, radius)
		new("UIGradient", {Rotation = 90, Transparency = NumberSequence.new(0, 1), Parent = gloss})
		table.insert(GlassGlosses, gloss)
	end

	if opts.Caustic then
		local inner = new("Frame", {AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.new(1, -4, 1, -4), BackgroundTransparency = 1, ZIndex = 0, Parent = frame})
		corner(inner, math.max(0, radius - 2))
		local cs = new("UIStroke", {Thickness = 1, Color = WHITE, Transparency = glassValue("caustic"), Parent = inner})
		new("UIGradient", {
			Rotation = 90,
			Transparency = NumberSequence.new({
				NumberSequenceKeypoint.new(0, 0.75),
				NumberSequenceKeypoint.new(0.3, 1),
				NumberSequenceKeypoint.new(0.7, 1),
				NumberSequenceKeypoint.new(1, 0.3),
			}),
			Parent = cs,
		})
		table.insert(GlassCaustics, cs)
	end
	return rim
end

local function specular(host, root, scaleObj, size)
	local blob = new("Frame", {BackgroundTransparency = 1, AnchorPoint = Vector2.new(0.5, 0.5), Size = UDim2.fromOffset(size, size), Visible = Settings.Glass == "Liquid", ZIndex = 0, Parent = host})
	for i = 1, 6 do
		local s = size * (1 - (i - 1) / 6)
		local c = new("Frame", {AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(s, s), BackgroundColor3 = WHITE, BackgroundTransparency = 0.982, Parent = blob})
		corner(c, s / 2)
	end
	table.insert(Speculars, {Blob = blob, Host = host, Root = root, Scale = scaleObj, X = size / 2, Y = 0})
end

local GlassDrop
local function setGlass(mode)
	if not GLASS[mode] then return end
	Settings.Glass = mode
	refreshGlass()
	if GlassDrop then GlassDrop:Set(mode, true) end
end

local function dropShadow(parent, radius)
	for i, grow in ipairs({10, 22, 38}) do
		local s = new("Frame", {
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.new(0.5, 0, 0.5, 10),
			Size = UDim2.new(1, grow, 1, grow),
			BackgroundColor3 = BLACK,
			BackgroundTransparency = 0.72 + i * 0.08,
			ZIndex = 0,
			Parent = parent,
		})
		corner(s, radius + grow / 2)
	end
end

local function chevron(parent, position, colorKey)
	local holder = new("Frame", {BackgroundTransparency = 1, AnchorPoint = Vector2.new(0.5, 0.5), Position = position, Size = UDim2.fromOffset(12, 12), Parent = parent})
	local a = new("Frame", {AnchorPoint = Vector2.new(0.5, 0.5), Size = UDim2.fromOffset(7, 2), Rotation = 45, Parent = holder})
	local b = new("Frame", {AnchorPoint = Vector2.new(0.5, 0.5), Size = UDim2.fromOffset(7, 2), Rotation = -45, Parent = holder})
	for _, f in ipairs({a, b}) do
		paint(f, {BackgroundColor3 = colorKey or "SubText"})
		corner(f, 1)
	end
	local obj = {}
	function obj:Set(down, instant)
		local pa = down and UDim2.new(0.5, -2, 0.5, 0) or UDim2.new(0.5, 0, 0.5, -2)
		local pb = down and UDim2.new(0.5, 2, 0.5, 0) or UDim2.new(0.5, 0, 0.5, 2)
		if instant then
			a.Position, b.Position = pa, pb
		else
			tween(a, 0.2, {Position = pa})
			tween(b, 0.2, {Position = pb})
		end
	end
	obj:Set(false, true)
	return obj
end

local function plusIcon(parent, position, colorKey)
	local h = new("Frame", {AnchorPoint = Vector2.new(0.5, 0.5), Position = position, Size = UDim2.fromOffset(9, 2), Parent = parent})
	local v = new("Frame", {AnchorPoint = Vector2.new(0.5, 0.5), Position = position, Size = UDim2.fromOffset(2, 9), Parent = parent})
	for _, f in ipairs({h, v}) do
		paint(f, {BackgroundColor3 = colorKey or "SubText"})
		corner(f, 1)
	end
	return {
		Set = function(_, open)
			tween(v, 0.2, {Size = open and UDim2.fromOffset(2, 0) or UDim2.fromOffset(2, 9)})
		end,
	}
end

local old =PlayerGui:FindFirstChild("FollyLol")
if old then old:Destroy() end

local Gui = new("ScreenGui", {
	Name = "FollyLol",
	ResetOnSpawn = false,
	IgnoreGuiInset = true,
	ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
	DisplayOrder = 50,
	Parent = PlayerGui,
})

local NotifyHolder = new("Frame", {Name = "Notifications", BackgroundTransparency = 1, AnchorPoint = Vector2.new(1, 1), Position = UDim2.new(1, -16, 1, -16), Size = UDim2.new(0, 290, 1, -32), ZIndex = 30, Parent = Gui})
new("UIListLayout", {
	Padding = UDim.new(0, 8),
	SortOrder = Enum.SortOrder.LayoutOrder,
	VerticalAlignment = Enum.VerticalAlignment.Bottom,
	HorizontalAlignment = Enum.HorizontalAlignment.Right,
	Parent = NotifyHolder,
})

local notifyOrder = 0
local function notify(title, text, isError)
	if not Settings.Notifications and not isError then return end
	notifyOrder += 1
	local slot = new("Frame", {BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 0), AutomaticSize = AUTO_Y, LayoutOrder = notifyOrder, Parent = NotifyHolder})
	local mover = new("Frame", {BackgroundTransparency = 1, Position = UDim2.fromOffset(320, 0), Size = UDim2.new(1, 0, 0, 0), AutomaticSize = AUTO_Y, Parent = slot})
	local card = new("Frame", {Size = UDim2.new(1, 0, 0, 0), AutomaticSize = AUTO_Y, BackgroundTransparency = 0.12, Parent = mover})
	paint(card, {BackgroundColor3 = "BgTop"})
	corner(card, 14)
	local rim = new("UIStroke", {Color = WHITE, Thickness = 1, ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Parent = card})
	new("UIGradient", {Rotation = 35, Transparency = rimSequence(0.1), Parent = rim})
	padding(card, 10, 12, 10, 20)
	new("UIListLayout", {Padding = UDim.new(0, 3), SortOrder = Enum.SortOrder.LayoutOrder, Parent = card})
	label(card, title, 12, W.B, "Text", {Size = UDim2.new(1, 0, 0, 16), LayoutOrder = 1, TextTruncate = Enum.TextTruncate.AtEnd})
	if text and text ~= "" then
		label(card, text, 11, W.R, "SubText", {Size = UDim2.new(1, 0, 0, 0), AutomaticSize = AUTO_Y, TextWrapped = true, LayoutOrder = 2})
	end
	local bar = new("Frame", {Position = UDim2.fromOffset(8, 10), Size = UDim2.new(0, 3, 1, -20), BackgroundColor3 = isError and rgb(255, 90, 90) or WHITE, ZIndex = 2, Parent = mover})
	corner(bar, 2)
	if not isError then
		new("UIGradient", {Rotation = 90, Color = ColorSequence.new(Theme.Accent, Theme.Accent2), Parent = bar})
	end
	local timer = new("Frame", {Position = UDim2.new(0, 14, 1, -3), Size = UDim2.new(1, -28, 0, 2), BackgroundColor3 = isError and rgb(255, 90, 90) or Theme.Accent2, BackgroundTransparency = 0.3, ZIndex = 2, Parent = mover})
	corner(timer, 1)
	tween(timer, 4, {Size = UDim2.new(0, 0, 0, 2)}, Enum.EasingStyle.Linear)
	tween(mover, 0.4, {Position = UDim2.fromOffset(0, 0)}, Enum.EasingStyle.Back)
	task.delay(4, function()
		local tw = tween(mover, 0.3, {Position = UDim2.fromOffset(320, 0)}, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
		tw.Completed:Wait()
		slot:Destroy()
	end)
end

local BASE_W, BASE_H, SIDE = 780, 620, 207
local Modal = {}
local UI = {}
local SettingsCat
local isOpen, modalOpen = false, false
local BlurFx
local setOpen, selectCategory, movePill, ActiveCategory

local Holder = new("Frame", {Name = "Window", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(BASE_W, BASE_H), BackgroundTransparency = 1, Visible = false, Parent = Gui})
local WinScale = new("UIScale", {Parent = Holder})
dropShadow(Holder, 16)

local Window = new("Frame", {Size = UDim2.fromScale(1, 1), BackgroundColor3 = WHITE, ClipsDescendants = true, Parent = Holder})
corner(Window, 16)
do
	local tint = new("UIGradient", {Rotation = 115, Parent = Window})
	onTheme(function() tint.Color = ColorSequence.new(Theme.BgTop, Theme.BgBottom) end)
end
glassify(Window, "window", 16, {GlossHeight = 200, Caustic = true, RimThickness = 1.5})
specular(Window, Holder, WinScale, 420)

local function windowScale()
	return Settings.Scale * fitScale(BASE_W, BASE_H)
end

local ParticleLayer = new("Frame", {BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), ZIndex = 0, Parent = Window})
local Particles = {}
for i = 1, 18 do
	local size = math.random(2, 3)
	local f = new("Frame", {Size = UDim2.fromOffset(size, size), BackgroundTransparency = 0.45 + math.random() * 0.4, Parent = ParticleLayer})
	paint(f, {BackgroundColor3 = "Text"})
	corner(f, 2)
	Particles[i] = {Frame = f, X = math.random(), Y = math.random(), Speed = 0.008 + math.random() * 0.02, Phase = math.random() * 6}
end

local Sidebar = new("Frame", {BackgroundTransparency = 1, Size = UDim2.new(0, SIDE, 1, -28), Parent = Window})
label(Sidebar, CONFIG.Title, 15, W.B, "Text", {Position = UDim2.fromOffset(18, 14), Size = UDim2.new(1, -36, 0, 20)})
label(Sidebar, CONFIG.Subtitle, 10, W.R, "SubText", {Position = UDim2.fromOffset(18, 35), Size = UDim2.new(1, -36, 0, 14)})

local NavPillShadow = new("Frame", {Size = UDim2.new(), BackgroundColor3 = BLACK, BackgroundTransparency = 0.7, ZIndex = 0, Parent = Sidebar})
corner(NavPillShadow, 12)
local NavPill = new("Frame", {Size = UDim2.new(), ZIndex = 1, Parent = Sidebar})
paint(NavPill, {BackgroundColor3 = "Card"})
corner(NavPill, 10)
glassify(NavPill, "pill", 10, {GlossHeight = 18, Caustic = true})

local Nav = new("ScrollingFrame", {
	BackgroundTransparency = 1,
	Position = UDim2.fromOffset(12, 62),
	Size = UDim2.new(1, -24, 1, -70),
	CanvasSize = UDim2.new(),
	AutomaticCanvasSize = AUTO_Y,
	ScrollBarThickness = 0,
	ScrollingDirection = Enum.ScrollingDirection.Y,
	ZIndex = 2,
	Parent = Sidebar,
})
new("UIListLayout", {Padding = UDim.new(0, 6), SortOrder = Enum.SortOrder.LayoutOrder, Parent = Nav})
padding(Nav, 2)

do
	local divider = new("Frame", {Position = UDim2.fromOffset(SIDE, 14), Size = UDim2.new(0, 1, 1, -56), BackgroundColor3 = WHITE, Parent = Window})
	new("UIGradient", {Rotation = 90, Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.15, 0.82), NumberSequenceKeypoint.new(0.85, 0.82), NumberSequenceKeypoint.new(1, 1)}), Parent = divider})
end

local PageTitle = label(Window, "", 18, W.B, "Text", {Position = UDim2.fromOffset(SIDE + 17, 12), Size = UDim2.new(1, -SIDE - 210, 0, 24)})
local PageSub = label(Window, "", 10, W.R, "SubText", {Position = UDim2.fromOffset(SIDE + 17, 37), Size = UDim2.new(1, -SIDE - 210, 0, 14), TextTruncate = Enum.TextTruncate.AtEnd})

do
	local iconBar = new("Frame", {BackgroundTransparency = 1, AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -14, 0, 12), Size = UDim2.fromOffset(180, 30), Parent = Window})
	new("UIListLayout", {
		FillDirection = Enum.FillDirection.Horizontal,
		HorizontalAlignment = Enum.HorizontalAlignment.Right,
		Padding = UDim.new(0, 6),
		SortOrder = Enum.SortOrder.LayoutOrder,
		Parent = iconBar,
	})

	local function iconButton(order, onClick)
		local b = new("TextButton", {Text = "", AutoButtonColor = false, Size = UDim2.fromOffset(30, 30), LayoutOrder = order, Parent = iconBar})
		paint(b, {BackgroundColor3 = "Card"})
		corner(b, 15)
		glassify(b, "control", 15, {GlossHeight = 14})
		local press = new("UIScale", {Parent = b})
		b.MouseEnter:Connect(function() tween(b, 0.15, {BackgroundTransparency = math.max(0, glassValue("control") - 0.25)}) end)
		b.MouseLeave:Connect(function()
			tween(b, 0.2, {BackgroundTransparency = glassValue("control")})
			tween(press, 0.3, {Scale = 1}, Enum.EasingStyle.Back)
		end)
		b.MouseButton1Down:Connect(function() tween(press, 0.08, {Scale = 0.9}) end)
		b.MouseButton1Up:Connect(function() tween(press, 0.35, {Scale = 1}, Enum.EasingStyle.Back) end)
		b.MouseButton1Click:Connect(onClick)
		return b
	end

	local function iconLine(parent, x, y, w)
		local f = new("Frame", {AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, x, 0.5, y), Size = UDim2.fromOffset(w, 2), Parent = parent})
		paint(f, {BackgroundColor3 = "Text"})
		corner(f, 1)
		return f
	end

	local fontBtn = iconButton(1, function() Modal.Open(3, "single") end)
	label(fontBtn, "Aa", 11, W.B, "Text", {Size = UDim2.fromScale(1, 1), TextXAlignment = CENTER})

	local menuBtn = iconButton(2, function()
		if SettingsCat then selectCategory(SettingsCat) end
	end)
	iconLine(menuBtn, 0, -4, 12)
	iconLine(menuBtn, 0, 0, 12)
	iconLine(menuBtn, 0, 4, 12)

	local glassBtn = iconButton(3, function()
		local i = table.find(GlassOrder, Settings.Glass) or 1
		setGlass(GlassOrder[i % #GlassOrder + 1])
		notify(T({"Glass: ", "Стекло: "}) .. Settings.Glass)
	end)
	local ring = new("Frame", {AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(14, 14), BackgroundTransparency = 1, Parent = glassBtn})
	corner(ring, 7)
	stroke(ring, "Text", 0, 1.5)
	local half = new("Frame", {BackgroundTransparency = 1, Size = UDim2.fromOffset(7, 14), ClipsDescendants = true, Parent = ring})
	local halfFill = new("Frame", {Size = UDim2.fromOffset(14, 14), Parent = half})
	paint(halfFill, {BackgroundColor3 = "Text"})
	corner(halfFill, 7)

	local themeBtn = iconButton(4, function() Modal.Open(2, "single") end)
	local dotColors = {rgb(255, 120, 160), rgb(120, 220, 170), rgb(110, 170, 255), rgb(250, 200, 100)}
	local dotPos = {{-4, -4}, {4, -4}, {-4, 4}, {4, 4}}
	for i, c in ipairs(dotColors) do
		local d = new("Frame", {AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, dotPos[i][1], 0.5, dotPos[i][2]), Size = UDim2.fromOffset(6, 6), BackgroundColor3 = c, Parent = themeBtn})
		corner(d, 3)
	end

	local minBtn = iconButton(5, function() setOpen(false) end)
	iconLine(minBtn, 0, 0, 11)
end

local Pages = new("Frame", {BackgroundTransparency = 1, Position = UDim2.fromOffset(SIDE + 9, 54), Size = UDim2.new(1, -SIDE - 17, 1, -82), ClipsDescendants = true, Parent = Window})

label(Window, CONFIG.Footer, 10, W.R, "Muted", {AnchorPoint = Vector2.new(0.5, 1), Position = UDim2.new(0.5, 0, 1, -7), Size = UDim2.new(1, -40, 0, 14), TextXAlignment = CENTER})

do
	local function makeDraggable(handle, target)
		local dragging, startInput, startPos = false, nil, nil
		handle.InputBegan:Connect(function(input)
			if isPress(input) then
				dragging, startInput, startPos = true, input.Position, target.Position
			end
		end)
		connect(UserInputService.InputChanged, function(input)
			if dragging and isMove(input) then
				local d = input.Position - startInput
				target.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
			end
		end)
		connect(UserInputService.InputEnded, function(input)
			if isPress(input) then dragging = false end
		end)
	end

	makeDraggable(new("Frame", {BackgroundTransparency = 1, Size = UDim2.fromOffset(SIDE, 58), Parent = Window}), Holder)
	makeDraggable(new("Frame", {BackgroundTransparency = 1, Position = UDim2.fromOffset(SIDE, 0), Size = UDim2.new(1, -SIDE - 190, 0, 52), Parent = Window}), Holder)

	local grip = new("TextButton", {Text = "", AutoButtonColor = false, BackgroundTransparency = 1, AnchorPoint = Vector2.new(1, 1), Position = UDim2.new(1, -5, 1, -5), Size = UDim2.fromOffset(16, 16), Parent = Window})
	for i, len in ipairs({11, 5}) do
		local off = i == 1 and 0 or 3
		local l = new("Frame", {AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, off, 0.5, off), Size = UDim2.fromOffset(len, 2), Rotation = -45, Parent = grip})
		paint(l, {BackgroundColor3 = "Muted"})
		corner(l, 1)
	end

	local resizing, startInput, startSize, startPos = false, nil, nil, nil
	grip.InputBegan:Connect(function(input)
		if isPress(input) then
			resizing, startInput, startSize, startPos = true, input.Position, Holder.Size, Holder.Position
		end
	end)
	connect(UserInputService.InputChanged, function(input)
		if not resizing or not isMove(input) then return end
		local s = WinScale.Scale
		local d = input.Position - startInput
		local w = math.clamp(startSize.X.Offset + d.X / s, 660, 1400)
		local h = math.clamp(startSize.Y.Offset + d.Y / s, 460, 1000)
		Holder.Size = UDim2.fromOffset(w, h)
		Holder.Position = startPos + UDim2.fromOffset((w - startSize.X.Offset) * s / 2, (h - startSize.Y.Offset) * s / 2)
	end)
	connect(UserInputService.InputEnded, function(input)
		if isPress(input) then resizing = false end
	end)
end

local MiniButton = new("TextButton", {Text = "", AutoButtonColor = false, Position = UDim2.new(0, 16, 0.5, -24), Size = UDim2.fromOffset(48, 48), BackgroundColor3 = WHITE, Visible = false, ZIndex = 5, Parent = Gui})
corner(MiniButton, 24)
accentGradient(MiniButton, 45)
glassify(MiniButton, "solid", 24, {GlossHeight = 24})
label(MiniButton, "F", 20, W.B, "OnAccent", {Size = UDim2.fromScale(1, 1), TextXAlignment = CENTER})

local function refreshBlur()
	if Settings.Blur and (isOpen or modalOpen) then
		if not BlurFx or not BlurFx.Parent then
			BlurFx = new("BlurEffect", {Name = "FollyLolBlur", Size = 0, Parent = Lighting})
		end
		tween(BlurFx, 0.35, {Size = 16})
	elseif BlurFx then
		tween(BlurFx, 0.25, {Size = 0})
	end
end

function setOpen(open)
	isOpen = open
	if open then
		Holder.Visible = true
		WinScale.Scale = windowScale() * 0.94
		tween(WinScale, 0.34, {Scale = windowScale()}, Enum.EasingStyle.Back)
		if ActiveCategory then movePill(ActiveCategory.Btn, false) end
	else
		tween(WinScale, 0.18, {Scale = windowScale() * 0.94}, Enum.EasingStyle.Quad, Enum.EasingDirection.In).Completed:Once(function()
			if not isOpen then Holder.Visible = false end
		end)
	end
	MiniButton.Visible = Settings.FloatingButton and not open
	refreshBlur()
end

do
	local down, moved, startInput, startPos = false, false, nil, nil
	MiniButton.InputBegan:Connect(function(input)
		if isPress(input) then
			down, moved, startInput, startPos = true, false, input.Position, MiniButton.Position
		end
	end)
	connect(UserInputService.InputChanged, function(input)
		if not down or not isMove(input) then return end
		local d = input.Position - startInput
		if d.Magnitude > 5 then moved = true end
		if moved then
			MiniButton.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
		end
	end)
	connect(UserInputService.InputEnded, function(input)
		if down and isPress(input) then
			down = false
			if not moved then setOpen(true) end
		end
	end)
end

connect(RunService.Heartbeat, function(dt)
	if not Holder.Visible or not Settings.Particles then return end
	for _, p in ipairs(Particles) do
		p.Y -= p.Speed * dt
		p.Phase += dt
		if p.Y < -0.02 then
			p.Y = 1.02
			p.X = math.random()
		end
		p.Frame.Position = UDim2.fromScale(p.X + math.sin(p.Phase * 0.6) * 0.012, p.Y)
	end
end)

connect(RunService.RenderStepped, function(dt)
	if Settings.Glass ~= "Liquid" then return end
	local mouse = UserInputService:GetMouseLocation()
	local k = math.min(1, dt * 7)
	for _, sp in ipairs(Speculars) do
		if sp.Root.Visible then
			local rel = (mouse - sp.Host.AbsolutePosition) / math.max(0.01, sp.Scale.Scale)
			sp.X += (rel.X - sp.X) * k
			sp.Y += (rel.Y - sp.Y) * k
			sp.Blob.Position = UDim2.fromOffset(sp.X, sp.Y)
		end
	end
end)

local Category = {}
Category.__index = Category
local Section = {}
Section.__index = Section

local Categories = {}
local FeatureElements = {}
local BindingKey = false

do
	local pillTarget, pillConn, pillAnimating = nil, nil, false

	local function placePill(animate)
		if not pillTarget then return end
		local s = math.max(0.01, WinScale.Scale)
		local rel = (pillTarget.AbsolutePosition - Sidebar.AbsolutePosition) / s
		local size = pillTarget.AbsoluteSize / s
		local pos, sz = UDim2.fromOffset(rel.X, rel.Y), UDim2.fromOffset(size.X, size.Y)
		local shadowPos, shadowSize = UDim2.fromOffset(rel.X - 2, rel.Y + 3), UDim2.fromOffset(size.X + 4, size.Y + 4)
		if animate then
			pillAnimating = true
			tween(NavPill, 0.5, {Position = pos}, Enum.EasingStyle.Back)
			tween(NavPill, 0.14, {Size = UDim2.fromOffset(size.X * 0.94, size.Y * 1.35)}, Enum.EasingStyle.Quad).Completed:Once(function()
				tween(NavPill, 0.4, {Size = sz}, Enum.EasingStyle.Back)
			end)
			tween(NavPillShadow, 0.55, {Position = shadowPos, Size = shadowSize}, Enum.EasingStyle.Back)
			task.delay(0.6, function()
				pillAnimating = false
				placePill(false)
			end)
		else
			NavPill.Position, NavPill.Size = pos, sz
			NavPillShadow.Position, NavPillShadow.Size = shadowPos, shadowSize
		end
	end

	function movePill(btn, animate)
		pillTarget = btn
		if pillConn then pillConn:Disconnect() end
		pillConn = connect(btn:GetPropertyChangedSignal("AbsolutePosition"), function()
			if not pillAnimating then placePill(false) end
		end)
		task.defer(placePill, animate)
	end
end

local function newCategory(name, subtitle)
	local entry = new("Frame", {Name = T(name), BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 0), AutomaticSize = AUTO_Y, LayoutOrder = #Categories + 1, Parent = Nav})
	new("UIListLayout", {Padding = UDim.new(0, 2), SortOrder = Enum.SortOrder.LayoutOrder, Parent = entry})

	local btn = new("TextButton", {Text = "", AutoButtonColor = false, Size = UDim2.new(1, 0, 0, 36), BackgroundTransparency = 1, LayoutOrder = 0, Parent = entry})
	paint(btn, {BackgroundColor3 = "Text"})
	corner(btn, 10)

	local bullet = new("Frame", {AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 16, 0.5, 0), Size = UDim2.fromOffset(9, 9), BackgroundTransparency = 1, Parent = btn})
	corner(bullet, 5)
	local bulletStroke = stroke(bullet, "Muted", 0, 1.5)

	local nameLabel = label(btn, name, 12, W.S, "Text", {Position = UDim2.fromOffset(38, 0), Size = UDim2.new(1, -90, 1, 0), TextTruncate = Enum.TextTruncate.AtEnd})
	local chev = chevron(btn, UDim2.new(1, -16, 0.5, 0), "SubText")

	local countBadge = new("TextLabel", {AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -30, 0.5, 0), Size = UDim2.fromOffset(0, 16), AutomaticSize = Enum.AutomaticSize.X, TextSize = 9, Text = "", Visible = false, Parent = btn})
	paint(countBadge, {BackgroundColor3 = "Accent", TextColor3 = "OnAccent"})
	setText(countBadge, W.B)
	corner(countBadge, 8)
	padding(countBadge, 0, 5, 0, 5)

	local subs = new("Frame", {BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 0), AutomaticSize = AUTO_Y, Visible = false, LayoutOrder = 1, Parent = entry})
	new("UIListLayout", {SortOrder = Enum.SortOrder.LayoutOrder, Parent = subs})
	padding(subs, 4, 0, 8, 18)

	local page = new("ScrollingFrame", {
		Name = T(name),
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
		CanvasSize = UDim2.new(),
		AutomaticCanvasSize = AUTO_Y,
		ScrollBarThickness = 2,
		ScrollingDirection = Enum.ScrollingDirection.Y,
		Visible = false,
		Parent = Pages,
	})
	paint(page, {ScrollBarImageColor3 = "Accent2"})
	padding(page, 8, 6, 14, 6)

	local cols = {}
	for i = 1, 2 do
		local col = new("Frame", {BackgroundTransparency = 1, Position = UDim2.new((i - 1) * 0.5, (i - 1) * 7, 0, 0), Size = UDim2.new(0.5, -7, 0, 0), AutomaticSize = AUTO_Y, Parent = page})
		new("UIListLayout", {Padding = UDim.new(0, 14), SortOrder = Enum.SortOrder.LayoutOrder, Parent = col})
		cols[i] = col
	end

	local cat = setmetatable({
		Name = name,
		Subtitle = subtitle or "",
		Btn = btn,
		BulletStroke = bulletStroke,
		NameLabel = nameLabel,
		Chev = chev,
		CountBadge = countBadge,
		ActiveCount = 0,
		Subs = subs,
		Page = page,
		Cols = cols,
		Sections = {},
		Active = false,
		Expanded = false,
		Spy = true,
	}, Category)

	btn.MouseEnter:Connect(function()
		if not cat.Active then tween(btn, 0.15, {BackgroundTransparency = 0.95}) end
	end)
	btn.MouseLeave:Connect(function() tween(btn, 0.2, {BackgroundTransparency = 1}) end)
	btn.MouseButton1Click:Connect(function() selectCategory(cat) end)

	page:GetPropertyChangedSignal("CanvasPosition"):Connect(function()
		if not cat.Spy or #cat.Sections == 0 then return end
		local scale = WinScale.Scale
		local top = page.AbsolutePosition.Y + 40 * scale
		local atBottom = page.CanvasPosition.Y >= (page.AbsoluteCanvasSize.Y - page.AbsoluteWindowSize.Y) / scale - 2
		local best, bestY
		for _, s in ipairs(cat.Sections) do
			local y = s.Frame.AbsolutePosition.Y
			if atBottom then
				if not bestY or y > bestY then best, bestY = s, y end
			elseif y <= top and (not bestY or y > bestY) then
				best, bestY = s, y
			end
		end
		best = best or cat.Sections[1]
		if best ~= cat.ActiveSection then cat:SetActiveSection(best) end
	end)

	table.insert(Categories, cat)
	onTheme(function() cat:Refresh() end)
	return cat
end

function Category:Refresh()
	local a = self.Active
	paint(self.BulletStroke, {Color = a and "Text" or "Muted"})
	setText(self.NameLabel, a and W.B or W.S)
end

function Category:Bump(delta)
	self.ActiveCount = math.max(0, self.ActiveCount + delta)
	self.CountBadge.Text = tostring(self.ActiveCount)
	self.CountBadge.Visible = self.ActiveCount > 0
end

function Category:SetExpanded(v)
	self.Expanded = v
	self.Subs.Visible = v and #self.Sections > 0
	self.Chev:Set(v)
end

function Category:SetActive(v)
	self.Active = v
	self.Page.Visible = v
	if v then
		self.Page.Position = UDim2.fromOffset(0, 12)
		tween(self.Page, 0.35, {Position = UDim2.fromOffset(0, 0)})
	end
	self:SetExpanded(v)
	self:Refresh()
end

function Category:SetActiveSection(section)
	self.ActiveSection = section
	for _, s in ipairs(self.Sections) do
		local a = s == section
		tween(s.Indicator, 0.2, {BackgroundTransparency = a and 0 or 1})
		paint(s.ItemLabel, {TextColor3 = a and "Text" or "SubText"})
		setText(s.ItemLabel, a and W.M or W.R)
	end
end

function Category:ScrollTo(section, target)
	self:SetActiveSection(section)
	self.Spy = false
	task.defer(function()
		local page = self.Page
		local scale = WinScale.Scale
		local margin = target and 60 or 8
		local y = ((target or section.Frame).AbsolutePosition.Y - page.AbsolutePosition.Y) / scale + page.CanvasPosition.Y - margin
		local maxY = math.max(0, (page.AbsoluteCanvasSize.Y - page.AbsoluteWindowSize.Y) / scale)
		tween(page, 0.45, {CanvasPosition = Vector2.new(0, math.clamp(y, 0, maxY))}).Completed:Once(function()
			self.Spy = true
		end)
	end)
end

function Category:Section(title, side)
	local index = #self.Sections + 1
	local column = self.Cols[side == "right" and 2 or side == "left" and 1 or ((index - 1) % 2 + 1)]

	local card = new("Frame", {Name = T(title), Size = UDim2.new(1, 0, 0, 0), AutomaticSize = AUTO_Y, LayoutOrder = index, Parent = column})
	paint(card, {BackgroundColor3 = "Card"})
	corner(card, 12)
	glassify(card, "card", 12, {GlossHeight = 40})

	local content = new("Frame", {BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 0), AutomaticSize = AUTO_Y, Parent = card})
	padding(content, 6, 4, 8, 4)
	new("UIListLayout", {SortOrder = Enum.SortOrder.LayoutOrder, HorizontalAlignment = Enum.HorizontalAlignment.Center, Parent = content})

	local header = new("Frame", {BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 28), LayoutOrder = 0, Parent = content})
	local bar = new("Frame", {AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 8, 0.5, 0), Size = UDim2.fromOffset(3, 13), BackgroundColor3 = WHITE, Parent = header})
	corner(bar, 2)
	accentGradient(bar, 90)
	label(header, title, 12, W.B, "Text", {Position = UDim2.fromOffset(20, 0), Size = UDim2.new(1, -20, 1, 0)})

	local sep = new("Frame", {Size = UDim2.new(1, -16, 0, 1), BackgroundColor3 = WHITE, LayoutOrder = 1, Parent = content})
	accentGradient(sep).Transparency = NumberSequence.new({
		NumberSequenceKeypoint.new(0, 0.25),
		NumberSequenceKeypoint.new(0.7, 0.6),
		NumberSequenceKeypoint.new(1, 1),
	})
	new("Frame", {BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 6), LayoutOrder = 2, Parent = content})

	local item = new("TextButton", {Text = "", AutoButtonColor = false, BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 28), LayoutOrder = index, Parent = self.Subs})
	local indicator = new("Frame", {AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 0, 0.5, 0), Size = UDim2.fromOffset(2, 16), BackgroundColor3 = WHITE, BackgroundTransparency = 1, Parent = item})
	corner(indicator, 1)
	accentGradient(indicator, 90)
	local itemLabel = label(item, title, 11, W.R, "SubText", {Position = UDim2.fromOffset(14, 0), Size = UDim2.new(1, -14, 1, 0), TextTruncate = Enum.TextTruncate.AtEnd})

	local section = setmetatable({Title = title, Frame = card, Card = content, Order = 10, Category = self, Indicator = indicator, ItemLabel = itemLabel}, Section)
	table.insert(self.Sections, section)

	item.MouseEnter:Connect(function()
		if self.ActiveSection ~= section then paint(itemLabel, {TextColor3 = "Text"}) end
	end)
	item.MouseLeave:Connect(function()
		if self.ActiveSection ~= section then paint(itemLabel, {TextColor3 = "SubText"}) end
	end)
	item.MouseButton1Click:Connect(function()
		selectCategory(self, true)
		self:ScrollTo(section)
	end)

	if index == 1 then self:SetActiveSection(section) end
	if self.Expanded then self.Subs.Visible = true end
	return section
end

function selectCategory(cat, keepExpanded)
	if ActiveCategory == cat then
		if not keepExpanded then cat:SetExpanded(not cat.Expanded) end
		return
	end
	if ActiveCategory then ActiveCategory:SetActive(false) end
	ActiveCategory = cat
	cat:SetActive(true)
	movePill(cat.Btn, Holder.Visible)
	PageTitle.Text = T(cat.Name)
	PageSub.Text = T(cat.Subtitle)
	PageTitle.TextTransparency, PageSub.TextTransparency = 1, 1
	tween(PageTitle, 0.3, {TextTransparency = 0})
	tween(PageSub, 0.45, {TextTransparency = 0})
end

table.insert(LangHooks, function()
	if not ActiveCategory then return end
	PageTitle.Text = T(ActiveCategory.Name)
	PageSub.Text = T(ActiveCategory.Subtitle)
end)

Section.Index = {}

function Section:_index(name, row)
	table.insert(Section.Index, {Name = name, Section = self, Row = row})
end

function Section:_next()
	self.Order += 1
	return self.Order
end

function Section:_row(height, plain)
	local row = new(plain and "Frame" or "TextButton", {Size = UDim2.new(1, 0, 0, height), BackgroundTransparency = 1, LayoutOrder = self:_next(), Parent = self.Card})
	if not plain then
		row.Text = ""
		row.AutoButtonColor = false
		paint(row, {BackgroundColor3 = "Text"})
		corner(row, 10)
		row.MouseEnter:Connect(function() tween(row, 0.15, {BackgroundTransparency = 0.94}) end)
		row.MouseLeave:Connect(function() tween(row, 0.2, {BackgroundTransparency = 1}) end)
	end
	return row
end

function Section:Toggle(opt)
	local row = self:_row(40)
	local nameLabel = label(row, opt.Name, 12, W.R, "Text", {Position = UDim2.fromOffset(8, 0), Size = UDim2.new(1, -66, 1, 0), TextTruncate = Enum.TextTruncate.AtEnd})

	local chip = new("TextLabel", {AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -58, 0.5, 0), Size = UDim2.fromOffset(0, 18), AutomaticSize = Enum.AutomaticSize.X, TextSize = 9, Text = "", Visible = false, Parent = row})
	paint(chip, {BackgroundColor3 = "Track", TextColor3 = "SubText"})
	setText(chip, W.B)
	corner(chip, 6)
	glassify(chip, "control", 6, {Gloss = false})
	padding(chip, 0, 6, 0, 6)

	local switch = new("Frame", {AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -8, 0.5, 0), Size = UDim2.fromOffset(42, 24), Parent = row})
	paint(switch, {BackgroundColor3 = "Track"})
	corner(switch, 12)
	glassify(switch, "control", 12, {GlossHeight = 11, GlossZ = 2})
	local fill = new("Frame", {Size = UDim2.fromScale(1, 1), BackgroundColor3 = WHITE, BackgroundTransparency = 1, ZIndex = 1, Parent = switch})
	corner(fill, 12)
	accentGradient(fill)
	local knob = new("Frame", {AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0, 12, 0.5, 0), Size = UDim2.fromOffset(18, 18), ZIndex = 3, Parent = switch})
	paint(knob, {BackgroundColor3 = "Knob"})
	corner(knob, 9)
	new("UIStroke", {Color = BLACK, Transparency = 0.8, Parent = knob})

	local el = {Value = false, Default = opt.Default == true, Category = opt.Feature and self.Category or nil}
	function el:Set(v, silent)
		v = v == true
		local changed = v ~= self.Value
		self.Value = v
		if changed and self.Category then self.Category:Bump(v and 1 or -1) end
		tween(fill, 0.25, {BackgroundTransparency = v and 0 or 1})
		tween(knob, 0.12, {Size = UDim2.fromOffset(25, 16)}, Enum.EasingStyle.Quad).Completed:Once(function()
			tween(knob, 0.32, {Size = UDim2.fromOffset(18, 18)}, Enum.EasingStyle.Back)
		end)
		tween(knob, 0.38, {Position = v and UDim2.new(1, -12, 0.5, 0) or UDim2.new(0, 12, 0.5, 0)}, Enum.EasingStyle.Back)
		if changed and not silent then fire(opt.Callback, v) end
	end
	function el:Reset() self:Set(self.Default) end
	function el:ShowBind(key)
		chip.Text = key or ""
		chip.Visible = key ~= nil
		nameLabel.Size = UDim2.new(1, key and -66 - (#key * 6 + 18) or -66, 1, 0)
	end

	row.MouseButton1Click:Connect(function() el:Set(not el.Value) end)
	row.MouseButton2Click:Connect(function() UI.StartBind(el) end)
	if opt.Desc then UI.Tip(row, opt.Desc) end
	self:_index(opt.Name, row)
	el:Set(el.Default, true)
	if opt.Feature then table.insert(FeatureElements, el) end
	return el
end

function Section:Slider(opt)
	local min, max, step = opt.Min or 0, opt.Max or 100, opt.Step or 1
	local decimals = step < 1 and math.clamp(math.ceil(-math.log10(step) - 1e-9), 1, 3) or 0

	local row = self:_row(54)
	label(row, opt.Name, 12, W.R, "Text", {Position = UDim2.fromOffset(8, 4), Size = UDim2.new(1, -110, 0, 20), TextTruncate = Enum.TextTruncate.AtEnd})

	local badge = new("TextButton", {AutoButtonColor = false, AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -8, 0, 4), Size = UDim2.fromOffset(0, 20), AutomaticSize = Enum.AutomaticSize.X, TextSize = 10, Parent = row})
	paint(badge, {BackgroundColor3 = "Track", TextColor3 = "Text"})
	setText(badge, W.B)
	corner(badge, 10)
	glassify(badge, "control", 10, {Gloss = false})
	padding(badge, 0, 9, 0, 9)

	local edit = new("TextBox", {AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -8, 0, 4), Size = UDim2.fromOffset(70, 20), Text = "", ClearTextOnFocus = false, TextSize = 10, Visible = false, ZIndex = 4, Parent = row})
	paint(edit, {BackgroundColor3 = "Track", TextColor3 = "Text"})
	setText(edit, W.B)
	corner(edit, 10)
	stroke(edit, "Accent2", 0.2, 1)

	local track = new("Frame", {Position = UDim2.new(0, 14, 0, 33), Size = UDim2.new(1, -28, 0, 5), BackgroundTransparency = 0.1, Parent = row})
	paint(track, {BackgroundColor3 = "Track"})
	corner(track, 3)
	local fill = new("Frame", {Size = UDim2.fromScale(0, 1), BackgroundColor3 = WHITE, Parent = track})
	corner(fill, 3)
	accentGradient(fill)
	local glow = new("Frame", {AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromOffset(26, 26), BackgroundTransparency = 1, ZIndex = 2, Parent = track})
	paint(glow, {BackgroundColor3 = "Accent2"})
	corner(glow, 13)
	local knob = new("Frame", {AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromOffset(15, 15), ZIndex = 3, Parent = track})
	paint(knob, {BackgroundColor3 = "Knob"})
	corner(knob, 8)
	stroke(knob, "Accent", 0, 3)

	local function format(v)
		if opt.Format then return opt.Format(v) end
		local suffix = T(opt.Suffix) or ""
		if decimals > 0 then return string.format("%." .. decimals .. "f", v) .. suffix end
		return tostring(math.floor(v + 0.5)) .. suffix
	end

	local el = {Value = opt.Default or min, Default = opt.Default or min}
	function el:Set(v, silent)
		v = math.clamp(v, min, max)
		v = math.clamp(math.floor((v - min) / step + 0.5) * step + min, min, max)
		local changed = v ~= self.Value
		self.Value = v
		local a = (max > min) and (v - min) / (max - min) or 0
		tween(fill, 0.08, {Size = UDim2.fromScale(a, 1)})
		tween(knob, 0.08, {Position = UDim2.fromScale(a, 0.5)})
		tween(glow, 0.08, {Position = UDim2.fromScale(a, 0.5)})
		badge.Text = format(v)
		if changed and not silent then fire(opt.Callback, v) end
	end
	function el:Reset() self:Set(self.Default) end

	local hit = new("TextButton", {Text = "", BackgroundTransparency = 1, Position = UDim2.new(0, 6, 0, 24), Size = UDim2.new(1, -12, 0, 22), Parent = row})
	local dragging = false
	local function update(x)
		local a = math.clamp((x - track.AbsolutePosition.X) / math.max(1, track.AbsoluteSize.X), 0, 1)
		el:Set(min + (max - min) * a)
	end
	hit.InputBegan:Connect(function(input)
		if isPress(input) then
			dragging = true
			update(input.Position.X)
			tween(knob, 0.2, {Size = UDim2.fromOffset(19, 19)}, Enum.EasingStyle.Back)
			tween(glow, 0.2, {BackgroundTransparency = 0.75})
		end
	end)
	connect(UserInputService.InputChanged, function(input)
		if dragging and isMove(input) then update(input.Position.X) end
	end)
	connect(UserInputService.InputEnded, function(input)
		if dragging and isPress(input) then
			dragging = false
			tween(knob, 0.3, {Size = UDim2.fromOffset(15, 15)}, Enum.EasingStyle.Back)
			tween(glow, 0.3, {BackgroundTransparency = 1})
		end
	end)

	badge.MouseEnter:Connect(function() tween(badge, 0.15, {BackgroundTransparency = math.max(0, glassValue("control") - 0.3)}) end)
	badge.MouseLeave:Connect(function() tween(badge, 0.2, {BackgroundTransparency = glassValue("control")}) end)
	badge.MouseButton1Click:Connect(function()
		edit.Text = decimals > 0 and string.format("%." .. decimals .. "f", el.Value) or tostring(el.Value)
		badge.Visible = false
		edit.Visible = true
		edit:CaptureFocus()
	end)
	edit.FocusLost:Connect(function()
		local n = tonumber((edit.Text:gsub(",", ".")))
		if n then el:Set(n) end
		edit.Visible = false
		badge.Visible = true
	end)

	table.insert(LangHooks, function() badge.Text = format(el.Value) end)
	if opt.Desc then UI.Tip(row, opt.Desc) end
	self:_index(opt.Name, row)
	el:Set(el.Default, true)
	badge.Text = format(el.Value)
	if opt.Feature then table.insert(FeatureElements, el) end
	return el
end

local function makeButton(parent, opt)
	local b = new("TextButton", {Text = "", AutoButtonColor = false, Parent = parent})
	corner(b, 10)
	local press = new("UIScale", {Parent = b})
	local kind = opt.Primary and "solid" or "control"
	if opt.Primary then
		b.BackgroundColor3 = WHITE
		accentGradient(b)
		label(b, opt.Name, 12, W.B, "OnAccent", {Size = UDim2.fromScale(1, 1), TextXAlignment = CENTER, TextTruncate = Enum.TextTruncate.AtEnd})
	else
		paint(b, {BackgroundColor3 = "Track"})
		label(b, opt.Name, 12, W.M, "Text", {Size = UDim2.fromScale(1, 1), TextXAlignment = CENTER, TextTruncate = Enum.TextTruncate.AtEnd})
	end
	glassify(b, kind, 10, {GlossHeight = 15})
	local function hoverT() return opt.Primary and 0.12 or math.max(0, glassValue(kind) - 0.25) end
	b.MouseEnter:Connect(function() tween(b, 0.15, {BackgroundTransparency = hoverT()}) end)
	b.MouseLeave:Connect(function()
		tween(b, 0.2, {BackgroundTransparency = glassValue(kind)})
		tween(press, 0.3, {Scale = 1}, Enum.EasingStyle.Back)
	end)
	b.MouseButton1Down:Connect(function() tween(press, 0.08, {Scale = 0.95}) end)
	b.MouseButton1Up:Connect(function() tween(press, 0.35, {Scale = 1}, Enum.EasingStyle.Back) end)
	b.MouseButton1Click:Connect(function() fire(opt.Callback) end)
	return b
end

function Section:Button(opt)
	local wrap = new("Frame", {BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 42), LayoutOrder = self:_next(), Parent = self.Card})
	local b = makeButton(wrap, opt)
	b.AnchorPoint = Vector2.new(0.5, 0.5)
	b.Position = UDim2.fromScale(0.5, 0.5)
	b.Size = UDim2.new(1, -12, 0, 32)
	if opt.Desc then UI.Tip(b, opt.Desc) end
	self:_index(opt.Name, wrap)
	return {Button = b}
end

function Section:Buttons(list)
	local wrap = new("Frame", {BackgroundTransparency = 1, Size = UDim2.new(1, -8, 0, 42), LayoutOrder = self:_next(), Parent = self.Card})
	local n = #list
	for i, opt in ipairs(list) do
		local b = makeButton(wrap, opt)
		b.AnchorPoint = Vector2.new(0, 0.5)
		b.Position = UDim2.new((i - 1) / n, 2, 0.5, 0)
		b.Size = UDim2.new(1 / n, -4, 0, 32)
		self:_index(opt.Name, wrap)
	end
end

function Section:Paragraph(text)
	local l = label(self.Card, text, 11, W.R, "Text", {Size = UDim2.new(1, 0, 0, 0), AutomaticSize = AUTO_Y, TextWrapped = true, RichText = true, TextTransparency = 0.12, LayoutOrder = self:_next()})
	padding(l, 4, 8, 8, 8)
	return {
		Label = l,
		Set = function(_, t)
			l.Text = T(t)
			Translated[l] = type(t) == "table" and t or nil
		end,
	}
end

function Section:Dropdown(opt)
	local holder = new("Frame", {BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 0), AutomaticSize = AUTO_Y, LayoutOrder = self:_next(), Parent = self.Card})
	new("UIListLayout", {Padding = UDim.new(0, 4), SortOrder = Enum.SortOrder.LayoutOrder, HorizontalAlignment = Enum.HorizontalAlignment.Center, Parent = holder})

	local row = new("Frame", {BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 40), LayoutOrder = 1, Parent = holder})
	label(row, opt.Name, 12, W.R, "Text", {Position = UDim2.fromOffset(8, 0), Size = UDim2.new(0.42, -8, 1, 0), TextTruncate = Enum.TextTruncate.AtEnd})

	local box = new("TextButton", {Text = "", AutoButtonColor = false, AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -8, 0.5, 0), Size = UDim2.new(0.58, -8, 0, 26), Parent = row})
	paint(box, {BackgroundColor3 = "Track"})
	corner(box, 10)
	glassify(box, "control", 10, {GlossHeight = 12})
	local valueLabel = label(box, "", 11, W.M, "Text", {Position = UDim2.fromOffset(10, 0), Size = UDim2.new(1, -32, 1, 0), TextTruncate = Enum.TextTruncate.AtEnd})
	local icon = plusIcon(box, UDim2.new(1, -14, 0.5, 0), "SubText")

	local listFrame = new("ScrollingFrame", {
		Size = UDim2.new(1, -16, 0, 0),
		CanvasSize = UDim2.new(),
		AutomaticCanvasSize = AUTO_Y,
		ScrollBarThickness = 2,
		ScrollingDirection = Enum.ScrollingDirection.Y,
		Visible = false,
		LayoutOrder = 2,
		Parent = holder,
	})
	paint(listFrame, {BackgroundColor3 = "Track", ScrollBarImageColor3 = "Accent2"})
	corner(listFrame, 10)
	glassify(listFrame, "control", 10, {Gloss = false})
	padding(listFrame, 3)
	new("UIListLayout", {Padding = UDim.new(0, 2), SortOrder = Enum.SortOrder.LayoutOrder, Parent = listFrame})

	local el = {Value = opt.Default, Options = {}}
	local optionLabels = {}
	local open = false

	local function setOpen(v)
		open = v
		listFrame.Visible = v
		icon:Set(v)
	end

	local function repaint()
		for o, l in pairs(optionLabels) do
			paint(l, {TextColor3 = o == el.Value and "Accent2" or "Text"})
		end
		valueLabel.Text = el.Value ~= nil and tostring(el.Value) or (T(opt.Placeholder) or T({"Not selected", "Не выбрано"}))
		paint(valueLabel, {TextColor3 = el.Value ~= nil and "Text" or "Muted"})
	end

	function el:Set(v, silent)
		self.Value = v
		repaint()
		if not silent then fire(opt.Callback, v) end
	end

	function el:Refresh(options)
		self.Options = options
		table.clear(optionLabels)
		for _, c in ipairs(listFrame:GetChildren()) do
			if c:IsA("TextButton") then c:Destroy() end
		end
		for i, o in ipairs(options) do
			local ob = new("TextButton", {Text = "", AutoButtonColor = false, BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 26), LayoutOrder = i, Parent = listFrame})
			paint(ob, {BackgroundColor3 = "Text"})
			corner(ob, 7)
			optionLabels[o] = label(ob, tostring(o), 11, W.R, "Text", {Position = UDim2.fromOffset(8, 0), Size = UDim2.new(1, -16, 1, 0), TextTruncate = Enum.TextTruncate.AtEnd})
			ob.MouseEnter:Connect(function() tween(ob, 0.12, {BackgroundTransparency = 0.93}) end)
			ob.MouseLeave:Connect(function() tween(ob, 0.15, {BackgroundTransparency = 1}) end)
			ob.MouseButton1Click:Connect(function()
				setOpen(false)
				el:Set(o)
			end)
		end
		listFrame.Size = UDim2.new(1, -16, 0, math.min(#options, 6) * 28 + 6)
		if self.Value ~= nil and not table.find(options, self.Value) then self.Value = nil end
		repaint()
	end

	box.MouseButton1Click:Connect(function() setOpen(not open) end)
	table.insert(LangHooks, repaint)
	self:_index(opt.Name, holder)
	el:Refresh(opt.Options or {})
	return el
end

function Section:Input(opt)
	local row = self:_row(40, true)
	label(row, opt.Name, 12, W.R, "Text", {Position = UDim2.fromOffset(8, 0), Size = UDim2.new(0.42, -8, 1, 0), TextTruncate = Enum.TextTruncate.AtEnd})
	local box = new("TextBox", {
		AnchorPoint = Vector2.new(1, 0.5),
		Position = UDim2.new(1, -8, 0.5, 0),
		Size = UDim2.new(0.58, -8, 0, 26),
		Text = opt.Default or "",
		PlaceholderText = T(opt.Placeholder) or "",
		ClearTextOnFocus = false,
		ClipsDescendants = true,
		TextSize = 11,
		TextXAlignment = Enum.TextXAlignment.Left,
		Parent = row,
	})
	paint(box, {BackgroundColor3 = "Track", TextColor3 = "Text", PlaceholderColor3 = "Muted"})
	setText(box, W.R)
	corner(box, 10)
	glassify(box, "control", 10, {Gloss = false})
	padding(box, 0, 10, 0, 10)
	box.FocusLost:Connect(function(enter) fire(opt.Callback, box.Text, enter) end)
	table.insert(LangHooks, function() box.PlaceholderText = T(opt.Placeholder) or "" end)
	self:_index(opt.Name, row)
	return {
		Box = box,
		Get = function() return box.Text end,
		Set = function(_, t) box.Text = t end,
	}
end

function Section:Keybind(opt)
	local row = self:_row(40, true)
	label(row, opt.Name, 12, W.R, "Text", {Position = UDim2.fromOffset(8, 0), Size = UDim2.new(1, -150, 1, 0), TextTruncate = Enum.TextTruncate.AtEnd})
	local kb = new("TextButton", {
		AutoButtonColor = false,
		AnchorPoint = Vector2.new(1, 0.5),
		Position = UDim2.new(1, -8, 0.5, 0),
		Size = UDim2.fromOffset(0, 26),
		AutomaticSize = Enum.AutomaticSize.X,
		Text = opt.Default.Name,
		TextSize = 10,
		Parent = row,
	})
	paint(kb, {BackgroundColor3 = "Track", TextColor3 = "Text"})
	setText(kb, W.B)
	corner(kb, 10)
	glassify(kb, "control", 10, {Gloss = false})
	padding(kb, 0, 12, 0, 12)

	local el = {Value = opt.Default}
	local listening = false
	kb.MouseButton1Click:Connect(function()
		listening = true
		BindingKey = true
		kb.Text = T({"press a key...", "нажми клавишу..."})
	end)
	connect(UserInputService.InputBegan, function(input)
		if not listening or input.UserInputType ~= Enum.UserInputType.Keyboard then return end
		listening = false
		task.defer(function() BindingKey = false end)
		if input.KeyCode ~= Enum.KeyCode.Escape then
			el.Value = input.KeyCode
			fire(opt.Callback, input.KeyCode)
		end
		kb.Text = el.Value.Name
	end)
	self:_index(opt.Name, row)
	return el
end

do
	local tip = new("TextLabel", {Size = UDim2.fromOffset(0, 0), AutomaticSize = Enum.AutomaticSize.XY, TextSize = 11, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, BackgroundTransparency = 0.06, Visible = false, ZIndex = 40, Parent = Gui})
	paint(tip, {BackgroundColor3 = "BgTop", TextColor3 = "Text"})
	setText(tip, W.R)
	corner(tip, 8)
	padding(tip, 6, 10, 6, 10)
	new("UISizeConstraint", {MaxSize = Vector2.new(260, 300), Parent = tip})
	local rim = new("UIStroke", {Color = WHITE, ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Parent = tip})
	new("UIGradient", {Rotation = 35, Transparency = rimSequence(0.15), Parent = rim})

	local token = 0
	function UI.Tip(target, text)
		target.MouseEnter:Connect(function()
			token += 1
			local mine = token
			task.delay(0.45, function()
				if mine ~= token or not isOpen then return end
				local m = UserInputService:GetMouseLocation()
				tip.Text = T(text)
				tip.Position = UDim2.fromOffset(m.X + 14, m.Y + 16)
				tip.Visible = true
			end)
		end)
		target.MouseLeave:Connect(function()
			token += 1
			tip.Visible = false
		end)
	end
end

do
	local binds = {}
	local pending

	function UI.StartBind(el)
		pending = el
		BindingKey = true
		el:ShowBind("...")
	end

	connect(UserInputService.InputBegan, function(input, gameProcessed)
		if input.UserInputType ~= Enum.UserInputType.Keyboard then return end
		if pending then
			local el, key = pending, input.KeyCode
			pending = nil
			task.defer(function() BindingKey = false end)
			if el.Bind then binds[el.Bind] = nil end
			el.Bind = nil
			local clear = key == Enum.KeyCode.Escape or key == Enum.KeyCode.Backspace or key.Name == Settings.ToggleKey
			if not clear then
				local previous = binds[key.Name]
				if previous then
					previous.Bind = nil
					previous:ShowBind(nil)
				end
				el.Bind = key.Name
				binds[key.Name] = el
			end
			el:ShowBind(el.Bind)
			return
		end
		if gameProcessed or UserInputService:GetFocusedTextBox() then return end
		local el = binds[input.KeyCode.Name]
		if el then el:Set(not el.Value) end
	end)
end

do
	local ROW_H, MAX_RESULTS = 34, 7
	local box = new("Frame", {AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, SIDE / 2, 0, 58), Size = UDim2.fromOffset(420, 44), Visible = false, ZIndex = 10, Parent = Window})
	paint(box, {BackgroundColor3 = "BgTop"})
	corner(box, 14)
	glassify(box, "modal", 14, {GlossHeight = 22})
	local scale = new("UIScale", {Parent = box})

	local input = new("TextBox", {BackgroundTransparency = 1, Position = UDim2.fromOffset(16, 0), Size = UDim2.new(1, -32, 0, 44), Text = "", PlaceholderText = "", ClearTextOnFocus = false, TextSize = 13, TextXAlignment = Enum.TextXAlignment.Left, Parent = box})
	paint(input, {TextColor3 = "Text", PlaceholderColor3 = "Muted"})
	setText(input, W.M)

	local list = new("Frame", {BackgroundTransparency = 1, Position = UDim2.fromOffset(6, 44), Size = UDim2.new(1, -12, 0, 0), Parent = box})
	new("UIListLayout", {Padding = UDim.new(0, 2), SortOrder = Enum.SortOrder.LayoutOrder, Parent = list})

	local results, rows, selected = {}, {}, 1

	local function haystack(item)
		local parts = {}
		for _, text in ipairs({item.Name, item.Section.Title, item.Section.Category.Name}) do
			if type(text) == "table" then
				table.insert(parts, text[1] .. " " .. (text[2] or ""))
			else
				table.insert(parts, tostring(text))
			end
		end
		return table.concat(parts, " "):lower()
	end

	local function highlight()
		for i, r in ipairs(rows) do
			tween(r, 0.12, {BackgroundTransparency = i == selected and 0.82 or 1})
		end
	end

	local function close()
		box.Visible = false
	end

	local function go(item)
		close()
		local cat = item.Section.Category
		selectCategory(cat, true)
		cat:ScrollTo(item.Section, item.Row)
		task.delay(0.5, function()
			local flash = new("Frame", {Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, ZIndex = 5, Parent = item.Row})
			paint(flash, {BackgroundColor3 = "Accent2"})
			corner(flash, 10)
			tween(flash, 0.25, {BackgroundTransparency = 0.7}).Completed:Wait()
			tween(flash, 0.7, {BackgroundTransparency = 1}).Completed:Wait()
			flash:Destroy()
		end)
	end

	local function render()
		for _, r in ipairs(rows) do r:Destroy() end
		table.clear(rows)
		table.clear(results)
		local query = input.Text:lower():match("^%s*(.-)%s*$")
		if query ~= "" then
			local found = {}
			for _, item in ipairs(Section.Index) do
				local at = haystack(item):find(query, 1, true)
				if at then table.insert(found, {Item = item, At = at}) end
			end
			table.sort(found, function(a, b) return a.At < b.At end)
			for i = 1, math.min(#found, MAX_RESULTS) do results[i] = found[i].Item end
		end
		for i, item in ipairs(results) do
			local r = new("TextButton", {Text = "", AutoButtonColor = false, BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, ROW_H), LayoutOrder = i, Parent = list})
			paint(r, {BackgroundColor3 = "Accent2"})
			corner(r, 9)
			label(r, T(item.Name), 12, W.M, "Text", {Position = UDim2.fromOffset(10, 0), Size = UDim2.new(0.55, -10, 1, 0), TextTruncate = Enum.TextTruncate.AtEnd})
			label(r, T(item.Section.Category.Name) .. " › " .. T(item.Section.Title), 10, W.R, "SubText", {AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -10, 0, 0), Size = UDim2.new(0.45, 0, 1, 0), TextXAlignment = Enum.TextXAlignment.Right, TextTruncate = Enum.TextTruncate.AtEnd})
			r.MouseEnter:Connect(function()
				selected = i
				highlight()
			end)
			r.MouseButton1Click:Connect(function() go(item) end)
			rows[i] = r
		end
		local h = 44 + (#results > 0 and #results * (ROW_H + 2) + 6 or 0)
		tween(box, 0.2, {Size = UDim2.fromOffset(420, h)})
		selected = math.clamp(selected, 1, math.max(1, #results))
		highlight()
	end

	function UI.OpenSearch()
		if not isOpen or modalOpen then return end
		input.Text = ""
		input.PlaceholderText = T({"Search features...", "Поиск по панели..."})
		box.Size = UDim2.fromOffset(420, 44)
		box.Visible = true
		scale.Scale = 0.94
		tween(scale, 0.3, {Scale = 1}, Enum.EasingStyle.Back)
		render()
		task.defer(function() input:CaptureFocus() end)
	end

	input:GetPropertyChangedSignal("Text"):Connect(function()
		selected = 1
		render()
	end)
	input.FocusLost:Connect(function(enter)
		if enter then
			if results[selected] then go(results[selected]) end
			return
		end
		local m =UserInputService:GetMouseLocation()
		local p, s = box.AbsolutePosition, box.AbsoluteSize
		if m.X < p.X or m.X > p.X + s.X or m.Y < p.Y or m.Y > p.Y + s.Y then close() end
	end)

	connect(UserInputService.InputBegan, function(key)
		if key.UserInputType ~= Enum.UserInputType.Keyboard then return end
		if box.Visible and key.KeyCode == Enum.KeyCode.Escape then
			close()
		elseif box.Visible and #results > 0 and (key.KeyCode == Enum.KeyCode.Down or key.KeyCode == Enum.KeyCode.Up) then
			selected = (selected - 1 + (key.KeyCode == Enum.KeyCode.Down and 1 or -1)) % #results + 1
			highlight()
		elseif key.KeyCode == Enum.KeyCode.F and (UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or UserInputService:IsKeyDown(Enum.KeyCode.RightControl)) then
			if not UserInputService:GetFocusedTextBox() then UI.OpenSearch() end
		end
	end)
end

local ThemeDrop, FontDrop, KeyTile, setTheme, setFont, refreshFontCells

do
	local MODAL_W, MODAL_H = 870, 466

	local Overlay = new("TextButton", {Name = "Overlay", Text = "", AutoButtonColor = false, BackgroundColor3 = BLACK, BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 20, Parent = Gui})
	local MHolder = new("Frame", {Name = "Intro", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(MODAL_W, MODAL_H), BackgroundTransparency = 1, Visible = false, ZIndex = 21, Parent = Gui})
	local MScale = new("UIScale", {Parent = MHolder})
	dropShadow(MHolder, 18)

	local MWin = new("Frame", {Size = UDim2.fromScale(1, 1), BackgroundColor3 = WHITE, ClipsDescendants = true, Parent = MHolder})
	corner(MWin, 18)
	do
		local tint = new("UIGradient", {Rotation = 115, Parent = MWin})
		onTheme(function() tint.Color = ColorSequence.new(Theme.BgTop, Theme.BgBottom) end)
	end
	glassify(MWin, "modal", 18, {GlossHeight = 160, Caustic = true, RimThickness = 1.5})
	specular(MWin, MHolder, MScale, 460)

	local MTitle = label(MWin, "", 15, W.B, "Text", {Position = UDim2.fromOffset(0, 36), Size = UDim2.new(1, 0, 0, 24), TextXAlignment = CENTER})
	local MSub = label(MWin, "", 10, W.R, "SubText", {Position = UDim2.fromOffset(0, 65), Size = UDim2.new(1, 0, 0, 14), TextXAlignment = CENTER})

	local Dots = new("Frame", {BackgroundTransparency = 1, AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 87), Size = UDim2.fromOffset(80, 8), Parent = MWin})
	new("UIListLayout", {
		FillDirection = Enum.FillDirection.Horizontal,
		HorizontalAlignment = Enum.HorizontalAlignment.Center,
		VerticalAlignment = Enum.VerticalAlignment.Center,
		Padding = UDim.new(0, 11),
		SortOrder = Enum.SortOrder.LayoutOrder,
		Parent = Dots,
	})
	local DotButtons = {}
	for i = 1, 3 do
		local d = new("TextButton", {Text = "", AutoButtonColor = false, Size = UDim2.fromOffset(7, 7), LayoutOrder = i, Parent = Dots})
		corner(d, 4)
		DotButtons[i] = d
		d.MouseButton1Click:Connect(function()
			if Modal.Mode == "intro" then Modal.Go(i) end
		end)
	end

	local MContent = new("Frame", {BackgroundTransparency = 1, Position = UDim2.fromOffset(0, 104), Size = UDim2.new(1, 0, 0, 268), Parent = MWin})

	local Steps = {}
	local StepInfo = {
		{"Добро пожаловать", "Пара шагов — и панель готова к работе."},
		{"Выберите тему", "Это можно изменить в настройках в любое время."},
		{"Выберите шрифт", "Это можно изменить в настройках в любое время."},
	}

	local function newStep()
		local f = new("Frame", {BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Visible = false, Parent = MContent})
		table.insert(Steps, f)
		return f
	end

	do
		local step = newStep()
		local logo = new("Frame", {AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 4), Size = UDim2.fromOffset(54, 54), BackgroundColor3 = WHITE, Parent = step})
		corner(logo, 16)
		accentGradient(logo, 45)
		glassify(logo, "solid", 16, {GlossHeight = 26})
		label(logo, "F", 24, W.B, "OnAccent", {Size = UDim2.fromScale(1, 1), TextXAlignment = CENTER})

		label(step, CONFIG.Title, 18, W.B, "Text", {Position = UDim2.fromOffset(0, 70), Size = UDim2.new(1, 0, 0, 24), TextXAlignment = CENTER})
		label(step, "Твоя админ-панель. Выбери тему и шрифт — всё это можно поменять потом в настройках.", 11, W.R, "SubText", {Position = UDim2.fromOffset(0, 98), Size = UDim2.new(1, 0, 0, 16), TextXAlignment = CENTER})

		local tiles = new("Frame", {BackgroundTransparency = 1, Position = UDim2.fromOffset(0, 134), Size = UDim2.new(1, 0, 0, 84), Parent = step})
		new("UIListLayout", {FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0, 14), SortOrder = Enum.SortOrder.LayoutOrder, Parent = tiles})
		local info = {{Settings.ToggleKey, "открыть / закрыть"}, {"10", "тем оформления"}, {"8", "шрифтов"}, {"3", "режима стекла"}}
		for i, t in ipairs(info) do
			local tile = new("Frame", {Size = UDim2.fromOffset(170, 84), LayoutOrder = i, Parent = tiles})
			paint(tile, {BackgroundColor3 = "Card"})
			corner(tile, 12)
			glassify(tile, "card", 12, {GlossHeight = 30})
			local big = label(tile, t[1], 18, W.B, "Accent2", {Position = UDim2.fromOffset(0, 18), Size = UDim2.new(1, 0, 0, 24), TextXAlignment = CENTER})
			label(tile, t[2], 10, W.R, "SubText", {Position = UDim2.fromOffset(0, 48), Size = UDim2.new(1, 0, 0, 14), TextXAlignment = CENTER})
			if i == 1 then KeyTile = big end
		end
	end

	local ThemeCells = {}
	do
		local step = newStep()
		local grid = new("Frame", {BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Parent = step})
		new("UIGridLayout", {CellSize = UDim2.fromOffset(148, 120), CellPadding = UDim2.fromOffset(14, 8), HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder, Parent = grid})

		for i, name in ipairs(ThemeOrder) do
			local t = Themes[name]
			local cell = new("TextButton", {Text = "", AutoButtonColor = false, BackgroundTransparency = 1, LayoutOrder = i, Parent = grid})
			local prev = new("Frame", {Size = UDim2.new(1, 0, 0, 93), BackgroundColor3 = WHITE, Parent = cell})
			corner(prev, 12)
			new("UIGradient", {Rotation = 115, Color = ColorSequence.new(t.BgTop, t.BgBottom), Parent = prev})
			local rim = new("UIStroke", {Color = t.Light and t.Stroke or WHITE, ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Parent = prev})
			new("UIGradient", {Rotation = 35, Transparency = rimSequence(0.25), Parent = rim})
			local gloss = new("Frame", {Size = UDim2.new(1, 0, 0, 40), BackgroundColor3 = WHITE, BackgroundTransparency = 0.9, ZIndex = 0, Parent = prev})
			corner(gloss, 12)
			new("UIGradient", {Rotation = 90, Transparency = NumberSequence.new(0, 1), Parent = gloss})

			local function bar(x, y, w, h, color, transparency)
				local b = new("Frame", {Position = UDim2.fromOffset(x, y), Size = UDim2.fromOffset(w, h), BackgroundColor3 = color, BackgroundTransparency = transparency or 0, Parent = prev})
				corner(b, h / 2)
				return b
			end
			bar(12, 14, 46, 8, t.SubText, 0.35)
			bar(12, 33, 46, 6, t.Muted, 0.45)
			bar(12, 47, 46, 6, t.Muted, 0.45)
			new("Frame", {Position = UDim2.fromOffset(70, 10), Size = UDim2.new(0, 1, 1, -20), BackgroundColor3 = t.Stroke, BackgroundTransparency = 0.7, Parent = prev})
			local accentBar = bar(82, 16, 52, 9, WHITE)
			new("UIGradient", {Color = ColorSequence.new(t.Accent, t.Accent2), Parent = accentBar})
			bar(82, 36, 8, 8, t.Accent)

			local glow = new("Frame", {AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.new(1, 2, 1, 2), BackgroundTransparency = 1, Visible = false, ZIndex = 3, Parent = prev})
			corner(glow, 13)
			local glowStroke = new("UIStroke", {Thickness = 4, Transparency = 0.75, Parent = glow})
			local selection = new("Frame", {Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, Visible = false, ZIndex = 3, Parent = prev})
			corner(selection, 12)
			local selStroke = new("UIStroke", {Thickness = 2, Parent = selection})

			local nameLabel = label(cell, name, 11, W.R, "SubText", {Position = UDim2.fromOffset(0, 99), Size = UDim2.new(1, 0, 0, 16), TextXAlignment = CENTER})
			ThemeCells[name] = {Selection = selection, SelStroke = selStroke, Glow = glow, GlowStroke = glowStroke, Label = nameLabel}

			cell.MouseEnter:Connect(function() tween(prev, 0.2, {Position = UDim2.fromOffset(0, -3)}, Enum.EasingStyle.Back) end)
			cell.MouseLeave:Connect(function() tween(prev, 0.25, {Position = UDim2.fromOffset(0, 0)}) end)
			cell.MouseButton1Click:Connect(function() setTheme(name) end)
		end

		onTheme(function()
			for name, c in pairs(ThemeCells) do
				local selected = name == Settings.Theme
				local color = Themes[name].Light and Themes[name].Accent or Themes[name].Accent2:Lerp(WHITE, 0.55)
				c.Selection.Visible = selected
				c.Glow.Visible = selected
				c.SelStroke.Color = color
				c.GlowStroke.Color = color
				paint(c.Label, {TextColor3 = selected and "Text" or "SubText"})
				setText(c.Label, selected and W.B or W.R)
			end
		end)
	end

	local FontCells = {}
	function refreshFontCells()
		local color = Theme.Light and Theme.Accent or Theme.Accent2:Lerp(WHITE, 0.4)
		for name, c in pairs(FontCells) do
			c.Selection.Visible = name == Settings.Font
			c.Stroke.Color = color
		end
	end

	do
		local step = newStep()
		local grid = new("Frame", {BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Parent = step})
		new("UIGridLayout", {CellSize = UDim2.fromOffset(182, 84), CellPadding = UDim2.fromOffset(13, 15), HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder, Parent = grid})

		for i, f in ipairs(FontList) do
			local family = Font.fromEnum(f.Enum).Family
			local cell = new("TextButton", {Text = "", AutoButtonColor = false, LayoutOrder = i, Parent = grid})
			paint(cell, {BackgroundColor3 = "Card"})
			corner(cell, 12)
			glassify(cell, "card", 12, {GlossHeight = 30})

			local aa = new("TextLabel", {BackgroundTransparency = 1, Position = UDim2.fromOffset(0, 14), Size = UDim2.new(1, 0, 0, 30), Text = "Aa", TextSize = 22, FontFace = Font.new(family, W.B), Parent = cell})
			paint(aa, {TextColor3 = "Text"})
			local nm = new("TextLabel", {BackgroundTransparency = 1, Position = UDim2.fromOffset(0, 52), Size = UDim2.new(1, 0, 0, 16), Text = f.Name, TextSize = 11, FontFace = Font.new(family, W.R), Parent = cell})
			paint(nm, {TextColor3 = "SubText"})

			local selection = new("Frame", {Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, Visible = false, ZIndex = 3, Parent = cell})
			corner(selection, 12)
			FontCells[f.Name] = {Selection = selection, Stroke = new("UIStroke", {Thickness = 1.5, Parent = selection})}

			local press = new("UIScale", {Parent = cell})
			cell.MouseEnter:Connect(function() tween(cell, 0.15, {BackgroundTransparency = math.max(0, glassValue("card") - 0.2)}) end)
			cell.MouseLeave:Connect(function() tween(cell, 0.2, {BackgroundTransparency = glassValue("card")}) end)
			cell.MouseButton1Down:Connect(function() tween(press, 0.08, {Scale = 0.96}) end)
			cell.MouseButton1Up:Connect(function() tween(press, 0.35, {Scale = 1}, Enum.EasingStyle.Back) end)
			cell.MouseButton1Click:Connect(function() setFont(f.Name) end)
		end

		onTheme(refreshFontCells)
	end

	function setTheme(name)
		applyTheme(name)
		if ThemeDrop then ThemeDrop:Set(Settings.Theme, true) end
	end

	function setFont(name)
		applyFont(name)
		refreshFontCells()
		if FontDrop then FontDrop:Set(name, true) end
	end

	local NextButton = new("TextButton", {Text = "", AutoButtonColor = false, AnchorPoint = Vector2.new(1, 1), Position = UDim2.new(1, -38, 1, -26), Size = UDim2.fromOffset(190, 42), BackgroundColor3 = WHITE, Parent = MWin})
	corner(NextButton, 10)
	accentGradient(NextButton, 0)
	glassify(NextButton, "solid", 10, {GlossHeight = 20})
	local NextLabel = label(NextButton, "Продолжить", 11, W.B, "OnAccent", {Size = UDim2.fromScale(1, 1), TextXAlignment = CENTER})
	do
		local press = new("UIScale", {Parent = NextButton})
		NextButton.MouseEnter:Connect(function() tween(NextButton, 0.15, {BackgroundTransparency = 0.12}) end)
		NextButton.MouseLeave:Connect(function()
			tween(NextButton, 0.2, {BackgroundTransparency = 0})
			tween(press, 0.3, {Scale = 1}, Enum.EasingStyle.Back)
		end)
		NextButton.MouseButton1Down:Connect(function() tween(press, 0.08, {Scale = 0.95}) end)
		NextButton.MouseButton1Up:Connect(function() tween(press, 0.35, {Scale = 1}, Enum.EasingStyle.Back) end)
	end

	local function updateNextLabel()
		if Modal.Mode == "single" then
			NextLabel.Text = "Готово"
		elseif Modal.Step == #Steps then
			NextLabel.Text = "Начать"
		else
			NextLabel.Text = "Продолжить"
		end
	end

	function Modal.Go(i)
		Modal.Step = i
		for index, f in ipairs(Steps) do
			f.Visible = index == i
		end
		local f = Steps[i]
		f.Position = UDim2.fromOffset(18, 0)
		tween(f, 0.4, {Position = UDim2.fromOffset(0, 0)})
		MTitle.Text = StepInfo[i][1]
		MSub.Text = StepInfo[i][2]
		for index, d in ipairs(DotButtons) do
			paint(d, {BackgroundColor3 = index == i and "Accent2" or "Muted"})
		end
		updateNextLabel()
	end

	function Modal.Open(step, mode)
		Modal.Mode = mode or "intro"
		Dots.Visible = Modal.Mode == "intro"
		modalOpen = true
		Modal.Go(step)
		Overlay.Visible = true
		MHolder.Visible = true
		Overlay.BackgroundTransparency = 1
		tween(Overlay, 0.3, {BackgroundTransparency = 0.45})
		local s = fitScale(MODAL_W, MODAL_H)
		MScale.Scale = s * 0.94
		tween(MScale, 0.4, {Scale = s}, Enum.EasingStyle.Back)
		refreshBlur()
	end

	function Modal.Close()
		modalOpen = false
		tween(Overlay, 0.2, {BackgroundTransparency = 1})
		tween(MScale, 0.2, {Scale = MScale.Scale * 0.94}, Enum.EasingStyle.Quad, Enum.EasingDirection.In).Completed:Once(function()
			if not modalOpen then
				Overlay.Visible = false
				MHolder.Visible = false
			end
		end)
		refreshBlur()
	end

	function Modal.Fit()
		if modalOpen then MScale.Scale = fitScale(MODAL_W, MODAL_H) end
	end

	NextButton.MouseButton1Click:Connect(function()
		if Modal.Mode == "intro" and Modal.Step < #Steps then
			Modal.Go(Modal.Step + 1)
			return
		end
		Modal.Close()
		if not isOpen then setOpen(true) end
	end)

	Overlay.MouseButton1Click:Connect(function()
		if Modal.Mode == "single" then Modal.Close() end
	end)
end

local State = {
	WalkSpeedOn = false, WalkSpeed = 16,
	JumpOn = false, Jump = 50,
	InfJump = false, Bhop = false, Noclip = false,
	Fly = false, FlySpeed = 60,
	FovOn = false, Fov = 70,
	InstantPrompts = false, ReachOn = false, Reach = 0,
	KeepControls = false, AntiHazard = false,
	ClickTp = false,
	Fullbright = false, NoFog = false, TimeOn = false, Time = 14,
	GravityOn = false, Gravity = 196,
	Highlights = false, NameTags = false,
	FpsOverlay = false,
}

local alive = true
local Char, Hum, Root
local Defaults = {WalkSpeed = 16, JumpPower = 50, UseJumpPower = true}
local Selected
local SpectateToggle

local saved = {}
local function remember(key, obj, props)
	if saved[key] then return end
	local values = {}
	for _, p in ipairs(props) do values[p] = obj[p] end
	saved[key] = {Object = obj, Values = values}
end

local function restore(key)
	local s = saved[key]
	if not s then return end
	saved[key] = nil
	for p, v in pairs(s.Values) do
		pcall(function() s.Object[p] = v end)
	end
end

local function setIf(obj, prop, value)
	if obj[prop] ~= value then obj[prop] = value end
end

local function teleportTo(target)
	if not Root then
		notify({"Teleport", "Телепорт"}, {"Character not found", "Персонаж не найден"}, true)
		return
	end
	if typeof(target) == "Vector3" then
		target = CFrame.new(target) * Root.CFrame.Rotation
	end
	Root.CFrame = target
	Root.AssemblyLinearVelocity = Vector3.zero
end

local flyLV, flyAO, flyAtt
local function stopFly()
	for _, o in ipairs({flyLV, flyAO, flyAtt}) do
		if o then o:Destroy() end
	end
	flyLV, flyAO, flyAtt = nil, nil, nil
	if Hum then Hum.PlatformStand = false end
end

local function startFly()
	stopFly()
	if not (Root and Hum) then return end
	flyAtt = new("Attachment", {Name = "FollyLolFly", Parent = Root})
	flyLV = new("LinearVelocity", {
		Attachment0 = flyAtt,
		MaxForce = 1e9,
		VelocityConstraintMode = Enum.VelocityConstraintMode.Vector,
		RelativeTo = Enum.ActuatorRelativeTo.World,
		VectorVelocity = Vector3.zero,
		Parent = Root,
	})
	flyAO = new("AlignOrientation", {
		Attachment0 = flyAtt,
		Mode = Enum.OrientationAlignmentMode.OneAttachment,
		MaxTorque = 1e9,
		Responsiveness = 40,
		CFrame = Root.CFrame.Rotation,
		Parent = Root,
	})
	Hum.PlatformStand = true
end

local function flyDirection(cf)
	local dir = Vector3.zero
	if UserInputService:GetFocusedTextBox() then return dir end
	local K = Enum.KeyCode
	if UserInputService:IsKeyDown(K.W) then dir += cf.LookVector end
	if UserInputService:IsKeyDown(K.S) then dir -= cf.LookVector end
	if UserInputService:IsKeyDown(K.D) then dir += cf.RightVector end
	if UserInputService:IsKeyDown(K.A) then dir -= cf.RightVector end
	if UserInputService:IsKeyDown(K.Space) or UserInputService:IsKeyDown(K.E) then dir += Vector3.yAxis end
	if UserInputService:IsKeyDown(K.LeftControl) or UserInputService:IsKeyDown(K.Q) then dir -= Vector3.yAxis end
	return dir
end

local noclipParts = {}
local function setNoclip(v)
	State.Noclip = v
	if not v then
		for part in pairs(noclipParts) do
			if part.Parent then part.CanCollide = true end
		end
		table.clear(noclipParts)
	end
end

local promptOriginal = setmetatable({}, {__mode = "k"})
local function applyPrompt(p)
	local o = promptOriginal[p]
	if not o then
		o = {p.HoldDuration, p.MaxActivationDistance}
		promptOriginal[p] = o
	end
	p.HoldDuration = State.InstantPrompts and 0 or o[1]
	p.MaxActivationDistance = State.ReachOn and State.Reach or o[2]
end

local promptQueued = false
local function refreshPrompts()
	if promptQueued then return end
	promptQueued = true
	task.delay(0.15, function()
		promptQueued = false
		for _, d in ipairs(workspace:GetDescendants()) do
			if d:IsA("ProximityPrompt") then applyPrompt(d) end
		end
	end)
end

do
	local controls
	function UI.KeepControls()
		if controls == nil then
			local ok, module = pcall(function()
				local playerModule = LocalPlayer:WaitForChild("PlayerScripts"):WaitForChild("PlayerModule", 5)
				return require(playerModule):GetControls()
			end)
			controls = ok and module or false
		end
		if not controls then return end
		local ok, active = pcall(controls.GetActiveController, controls)
		if ok and active and active.enabled == false then
			pcall(controls.Enable, controls, true)
		end
	end
end

do
	local HAZARDS = {"lava", "kill", "death", "acid", "void"}
	local disabled = {}

	local function guard(part)
		if not part:IsA("BasePart") or not part.CanTouch then return end
		local name = part.Name:lower()
		for _, word in ipairs(HAZARDS) do
			if name:find(word, 1, true) then
				disabled[part] = true
				part.CanTouch = false
				return
			end
		end
	end

	function UI.SetAntiHazard(v)
		State.AntiHazard = v
		if v then
			for _, d in ipairs(workspace:GetDescendants()) do guard(d) end
		else
			for part in pairs(disabled) do
				if part.Parent then part.CanTouch = true end
			end
			table.clear(disabled)
		end
	end

	connect(workspace.DescendantAdded, function(d)
		if State.AntiHazard then guard(d) end
	end)
end

local HighlightsMap, TagsMap = {}, {}
local TagFolder = new("Folder", {Name = "FollyLolTags", Parent = PlayerGui})

local function clearPlayerVisuals(plr)
	if HighlightsMap[plr] then
		HighlightsMap[plr]:Destroy()
		HighlightsMap[plr] = nil
	end
	if TagsMap[plr] then
		TagsMap[plr].Gui:Destroy()
		TagsMap[plr] = nil
	end
end

local function updatePlayerVisuals()
	for _, plr in ipairs(Players:GetPlayers()) do
		if plr ~= LocalPlayer then
			local char = plr.Character

			local hl = HighlightsMap[plr]
			if State.Highlights and char then
				if not hl or hl.Parent ~= char then
					if hl then hl:Destroy() end
					hl = new("Highlight", {Name = "FollyLolHighlight", Adornee = char, DepthMode = Enum.HighlightDepthMode.AlwaysOnTop, FillTransparency = 0.75, OutlineTransparency = 0.1, Parent = char})
					HighlightsMap[plr] = hl
				end
				hl.FillColor = Theme.Accent
				hl.OutlineColor = Theme.Accent2
			elseif hl then
				hl:Destroy()
				HighlightsMap[plr] = nil
			end

			local head = char and char:FindFirstChild("Head")
			local tag = TagsMap[plr]
			if State.NameTags and head then
				if not tag or tag.Gui.Adornee ~= head or not tag.Gui.Parent then
					if tag then tag.Gui:Destroy() end
					local bb = new("BillboardGui", {Name = plr.Name, Adornee = head, AlwaysOnTop = true, LightInfluence = 0, Size = UDim2.fromOffset(220, 38), StudsOffset = Vector3.new(0, 2.4, 0), Parent = TagFolder})
					local tl = new("TextLabel", {BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), TextSize = 13, RichText = true, TextColor3 = WHITE, TextStrokeTransparency = 0.45, Parent = bb})
					setText(tl, W.B)
					tag = {Gui = bb, Label = tl}
					TagsMap[plr] = tag
				end
				local dist = Root and math.floor((head.Position - Root.Position).Magnitude + 0.5) or 0
				tag.Label.Text = string.format('%s\n<font size="11" transparency="0.25">%d studs</font>', escapeRich(plr.DisplayName), dist)
			elseif tag then
				tag.Gui:Destroy()
				TagsMap[plr] = nil
			end
		end
	end
end

local function setSpectate(v)
	local cam = workspace.CurrentCamera
	if v then
		local hum = Selected and Selected.Character and Selected.Character:FindFirstChildOfClass("Humanoid")
		if not hum then
			notify({"Spectate", "Наблюдение"}, {"Pick a player who has a character", "Выбери игрока с персонажем"}, true)
			task.defer(function() SpectateToggle:Set(false, true) end)
			return
		end
		cam.CameraSubject = hum
	elseif Hum then
		cam.CameraSubject = Hum
	end
end

local function playerNames(except)
	local names = {}
	for _, p in ipairs(Players:GetPlayers()) do
		if p ~= except then table.insert(names, p.Name) end
	end
	table.sort(names, function(a, b) return a:lower() < b:lower() end)
	return names
end

local function onCharacter(char)
	Char, Hum, Root = char, nil, nil
	flyLV, flyAO, flyAtt = nil, nil, nil
	table.clear(noclipParts)
	local hum = char:WaitForChild("Humanoid", 10)
	local root = char:WaitForChild("HumanoidRootPart", 10)
	if char ~= LocalPlayer.Character then return end
	Hum, Root = hum, root
	if Hum then
		Defaults.WalkSpeed = Hum.WalkSpeed
		Defaults.JumpPower = Hum.JumpPower
		Defaults.UseJumpPower = Hum.UseJumpPower
	end
	if State.Fly then startFly() end
end

if LocalPlayer.Character then task.spawn(onCharacter, LocalPlayer.Character) end
connect(LocalPlayer.CharacterAdded, onCharacter)

local FULLBRIGHT = rgb(180, 180, 180)

connect(RunService.Heartbeat, function()
	if Hum and Hum.Parent then
		if State.WalkSpeedOn then setIf(Hum, "WalkSpeed", State.WalkSpeed) end
		if State.JumpOn then
			setIf(Hum, "UseJumpPower", true)
			setIf(Hum, "JumpPower", State.Jump)
		end
		if State.Bhop and Hum.MoveDirection.Magnitude > 0 and Hum.FloorMaterial ~= Enum.Material.Air then
			Hum.Jump = true
		end
	end
	if State.Fullbright then
		setIf(Lighting, "Brightness", 2)
		setIf(Lighting, "Ambient", FULLBRIGHT)
		setIf(Lighting, "OutdoorAmbient", FULLBRIGHT)
		setIf(Lighting, "GlobalShadows", false)
	end
	if State.NoFog then setIf(Lighting, "FogEnd", 1e6) end
	if State.TimeOn then setIf(Lighting, "ClockTime", State.Time) end
	if State.GravityOn then setIf(workspace, "Gravity", State.Gravity) end
end)

connect(RunService.Stepped, function()
	if not (State.Noclip and Char) then return end
	for _, part in ipairs(Char:GetDescendants()) do
		if part:IsA("BasePart") and part.CanCollide then
			noclipParts[part] = true
			part.CanCollide = false
		end
	end
end)

RunService:BindToRenderStep("FollyLolCam", Enum.RenderPriority.Camera.Value + 1, function()
	local cam = workspace.CurrentCamera
	if not cam then return end
	if State.FovOn then cam.FieldOfView = State.Fov end
	if State.Fly and flyLV and Root and Hum then
		local cf = cam.CFrame
		local dir = flyDirection(cf)
		if dir.Magnitude < 0.01 and Hum.MoveDirection.Magnitude > 0 then dir = Hum.MoveDirection end
		flyLV.VectorVelocity = dir.Magnitude > 0.01 and dir.Unit * State.FlySpeed or Vector3.zero
		local look = Vector3.new(cf.LookVector.X, 0, cf.LookVector.Z)
		if look.Magnitude > 0.01 then flyAO.CFrame = CFrame.lookAt(Vector3.zero, look) end
	end
end)

connect(UserInputService.JumpRequest, function()
	if State.InfJump and Hum and Hum.Health > 0 then
		Hum:ChangeState(Enum.HumanoidStateType.Jumping)
	end
end)

connect(workspace.DescendantAdded, function(d)
	if (State.InstantPrompts or State.ReachOn) and d:IsA("ProximityPrompt") then applyPrompt(d) end
end)

connect(UserInputService.InputBegan, function(input, gameProcessed)
	if gameProcessed or not State.ClickTp or input.UserInputType ~= Enum.UserInputType.MouseButton1 then return end
	if not UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or not Root then return end
	local cam = workspace.CurrentCamera
	local mouse = UserInputService:GetMouseLocation()
	local ray = cam:ViewportPointToRay(mouse.X, mouse.Y)
	local params = RaycastParams.new()
	params.FilterType = Enum.RaycastFilterType.Exclude
	params.FilterDescendantsInstances = {Char}
	local hit = workspace:Raycast(ray.Origin, ray.Direction * 2000, params)
	if hit then teleportTo(hit.Position + Vector3.new(0, 3, 0)) end
end)

local function resetAll(silent)
	for _, el in ipairs(FeatureElements) do el:Reset() end
	if not silent then notify({"Reset", "Сброс"}, {"Every feature is off", "Все функции выключены"}) end
end

local function unload()
	resetAll(true)
	alive = false
	for _, c in ipairs(Connections) do c:Disconnect() end
	pcall(function() RunService:UnbindFromRenderStep("FollyLolCam") end)
	stopFly()
	for key in pairs(saved) do restore(key) end
	for plr in pairs(HighlightsMap) do clearPlayerVisuals(plr) end
	TagFolder:Destroy()
	if BlurFx then BlurFx:Destroy() end
	Gui:Destroy()
end

local PlayersCat, TpCat, DevCat, StatsPara, CoordPara, FpsLabel, updateInfo

do
	local PlayerCat = newCategory({"Player", "Игрок"}, {"Movement, camera and the locks the game takes", "Движение, камера и блокировки, которые ставит игра"})

	local move = PlayerCat:Section({"Movement", "Движение"}, "left")
	move:Toggle({Name = {"Walk speed", "Скорость ходьбы"}, Desc = {"Holds your speed even if the game resets it", "Держит скорость, даже если игра её сбрасывает"}, Feature = true, Callback = function(v)
		State.WalkSpeedOn = v
		if not v and Hum then Hum.WalkSpeed = Defaults.WalkSpeed end
	end})
	move:Slider({Name = {"Speed", "Скорость"}, Min = 0, Max = 250, Default = 16, Suffix = " studs/s", Feature = true, Callback = function(v) State.WalkSpeed = v end})
	move:Toggle({Name = {"Jump power", "Сила прыжка"}, Feature = true, Callback = function(v)
		State.JumpOn = v
		if not v and Hum then
			Hum.UseJumpPower = Defaults.UseJumpPower
			Hum.JumpPower = Defaults.JumpPower
		end
	end})
	move:Slider({Name = {"Jump", "Прыжок"}, Min = 0, Max = 300, Default = 50, Feature = true, Callback = function(v) State.Jump = v end})
	move:Toggle({Name = {"Infinite jump", "Бесконечный прыжок"}, Desc = {"Jump again in mid-air", "Прыжок прямо в воздухе"}, Feature = true, Callback = function(v) State.InfJump = v end})
	move:Toggle({Name = {"Bunny hop", "Распрыжка"}, Desc = {"Jumps by itself while you move", "Прыгает сам, пока ты двигаешься"}, Feature = true, Callback = function(v) State.Bhop = v end})
	move:Toggle({Name = "Noclip", Desc = {"Walk through walls", "Проход сквозь стены"}, Feature = true, Callback = setNoclip})
	move:Toggle({Name = {"Fly", "Полёт"}, Desc = {"WASD — move, Space / E — up, Ctrl / Q — down", "WASD — движение, Space / E — вверх, Ctrl / Q — вниз"}, Feature = true, Callback = function(v)
		State.Fly = v
		if v then startFly() else stopFly() end
	end})
	move:Slider({Name = {"Fly speed", "Скорость полёта"}, Min = 10, Max = 300, Default = 60, Feature = true, Callback = function(v) State.FlySpeed = v end})

	local camSec = PlayerCat:Section({"Locks and camera", "Блокировки и камера"}, "right")
	camSec:Paragraph({
		"Games often pin the camera to first person or switch your controls off during cutscenes. These switches undo that — on your client only.",
		"Игры часто запирают камеру от первого лица или отключают управление в катсценах. Эти переключатели снимают это — только на твоём клиенте.",
	})
	camSec:Toggle({Name = {"Unlock camera", "Разблокировать камеру"}, Desc = {"Removes zoom limits and forced first person", "Снимает лимиты зума и вид от первого лица"}, Feature = true, Callback = function(v)
		if v then
			remember("zoom", LocalPlayer, {"CameraMaxZoomDistance", "CameraMinZoomDistance", "CameraMode"})
			LocalPlayer.CameraMaxZoomDistance = 1000
			LocalPlayer.CameraMinZoomDistance = 0.5
			LocalPlayer.CameraMode = Enum.CameraMode.Classic
		else
			restore("zoom")
		end
	end})
	camSec:Toggle({Name = {"Keep controls", "Не отключать управление"}, Desc = {"Turns movement back on if the game disables it", "Включает управление обратно, если игра его выключила"}, Feature = true, Callback = function(v) State.KeepControls = v end})
	camSec:Toggle({Name = {"Override FOV", "Своё поле зрения"}, Feature = true, Callback = function(v)
		State.FovOn = v
		if v then remember("fov", workspace.CurrentCamera, {"FieldOfView"}) else restore("fov") end
	end})
	camSec:Slider({Name = {"Field of view", "Поле зрения"}, Min = 30, Max = 120, Default = 70, Feature = true, Callback = function(v) State.Fov = v end})

	local interSec = PlayerCat:Section({"Interaction and hazards", "Взаимодействие и опасности"}, "right")
	interSec:Toggle({Name = {"Instant prompts", "Мгновенные промпты"}, Desc = {"Prompts fire without holding the key", "Промпты срабатывают без удержания клавиши"}, Feature = true, Callback = function(v)
		State.InstantPrompts = v
		refreshPrompts()
	end})
	interSec:Slider({
		Name = {"Prompt reach", "Дальность промптов"},
		Desc = {"0 — keep the game's own distance", "0 — оставить дальность из игры"},
		Min = 0, Max = 150, Default = 0, Feature = true,
		Format = function(v) return v == 0 and T({"game", "как в игре"}) or (v .. " studs") end,
		Callback = function(v)
			State.Reach = v
			State.ReachOn = v > 0
			refreshPrompts()
		end,
	})
	interSec:Toggle({Name = {"Anti kill-floor / lava", "Анти kill-floor / лава"}, Desc = {"Parts named lava, kill, death, acid or void stop touching you", "Части с именами lava, kill, death, acid, void перестают тебя касаться"}, Feature = true, Callback = function(v) UI.SetAntiHazard(v) end})
	interSec:Toggle({Name = {"Click teleport", "Телепорт по клику"}, Desc = {"Ctrl + left click on the map", "Ctrl + левый клик по карте"}, Feature = true, Callback = function(v) State.ClickTp = v end})

	local resetSec = PlayerCat:Section({"Reset", "Сброс"}, "left")
	resetSec:Paragraph({"Turns every feature off and puts the original values back.", "Выключает все функции панели и возвращает исходные значения."})
	resetSec:Button({Name = {"Respawn character", "Респавн персонажа"}, Callback = function()
		if Hum then Hum.Health = 0 end
	end})
	resetSec:Button({Name = {"Turn everything off", "Выключить всё"}, Primary = true, Callback = function() resetAll() end})
end

do
	local VisualCat = newCategory({"Visuals", "Визуал"}, {"Lighting, player highlights and world physics", "Освещение, подсветка игроков и физика мира"})

	local lightSec = VisualCat:Section({"Lighting", "Освещение"}, "left")
	lightSec:Toggle({Name = "Fullbright", Desc = {"Bright, shadowless lighting everywhere", "Ровный яркий свет без теней"}, Feature = true, Callback = function(v)
		State.Fullbright = v
		if v then remember("fullbright", Lighting, {"Brightness", "Ambient", "OutdoorAmbient", "GlobalShadows"}) else restore("fullbright") end
	end})
	lightSec:Toggle({Name = {"No fog", "Убрать туман"}, Feature = true, Callback = function(v)
		State.NoFog = v
		local atmosphere = Lighting:FindFirstChildOfClass("Atmosphere")
		if v then
			remember("fog", Lighting, {"FogEnd"})
			if atmosphere then
				remember("atmosphere", atmosphere, {"Density", "Haze"})
				atmosphere.Density = 0
				atmosphere.Haze = 0
			end
		else
			restore("fog")
			restore("atmosphere")
		end
	end})
	lightSec:Toggle({Name = {"Custom time", "Своё время суток"}, Feature = true, Callback = function(v)
		State.TimeOn = v
		if v then remember("time", Lighting, {"ClockTime"}) else restore("time") end
	end})
	lightSec:Slider({Name = {"Time", "Время"}, Min = 0, Max = 24, Step = 0.5, Default = 14, Suffix = {" h", " ч"}, Feature = true, Callback = function(v) State.Time = v end})

	local espSec = VisualCat:Section({"Players", "Игроки"}, "right")
	espSec:Paragraph({"Only you can see this. Highlights show through walls — handy for keeping an eye on the server.", "Видно только тебе. Подсветка работает сквозь стены — удобно следить за сервером."})
	espSec:Toggle({Name = {"Highlight players", "Подсветка игроков"}, Feature = true, Callback = function(v)
		State.Highlights = v
		updatePlayerVisuals()
	end})
	espSec:Toggle({Name = {"Names and distance", "Ники и дистанция"}, Feature = true, Callback = function(v)
		State.NameTags = v
		updatePlayerVisuals()
	end})

	local worldSec = VisualCat:Section({"World", "Мир"}, "right")
	worldSec:Toggle({Name = {"Custom gravity", "Своя гравитация"}, Desc = {"Changes gravity on your client only", "Меняет гравитацию только на твоём клиенте"}, Feature = true, Callback = function(v)
		State.GravityOn = v
		if v then remember("gravity", workspace, {"Gravity"}) else restore("gravity") end
	end})
	worldSec:Slider({Name = {"Gravity", "Гравитация"}, Min = 0, Max = 400, Default = 196, Feature = true, Callback = function(v) State.Gravity = v end})
end

do
	PlayersCat = newCategory({"Players", "Игроки"}, {"Player list, info and spectating", "Список игроков, информация и наблюдение"})
	local InfoPara
	local PICK_HINT = {"Pick a player from the list.", "Выбери игрока из списка."}

	function updateInfo()
		if not InfoPara then return end
		local p = Selected
		if not p or p.Parent ~= Players then
			InfoPara:Set(PICK_HINT)
			return
		end
		local hum = p.Character and p.Character:FindFirstChildOfClass("Humanoid")
		InfoPara:Set(string.format(
			T({"<b>%s</b> (@%s)\nUserId: %d\nAccount age: %d days\nTeam: %s\nHealth: %s", "<b>%s</b> (@%s)\nUserId: %d\nАккаунту: %d дн.\nКоманда: %s\nЗдоровье: %s"}),
			escapeRich(p.DisplayName),
			p.Name,
			p.UserId,
			p.AccountAge,
			p.Team and escapeRich(p.Team.Name) or "—",
			hum and string.format("%d / %d", math.floor(hum.Health), math.floor(hum.MaxHealth)) or "—"
		))
	end

	local pickSec = PlayersCat:Section({"Pick a player", "Выбор игрока"}, "left")
	local PlayerDrop = pickSec:Dropdown({Name = {"Player", "Игрок"}, Options = playerNames(), Placeholder = {"Not selected", "Не выбран"}, Callback = function(v)
		Selected = v and Players:FindFirstChild(v) or nil
		updateInfo()
	end})
	InfoPara = pickSec:Paragraph(PICK_HINT)

	local function refreshPlayerList(except)
		PlayerDrop:Refresh(playerNames(except))
		if PlayerDrop.Value == nil then Selected = nil end
		updateInfo()
	end

	pickSec:Button({Name = {"Refresh list", "Обновить список"}, Callback = function() refreshPlayerList() end})
	connect(Players.PlayerAdded, function() refreshPlayerList() end)
	connect(Players.PlayerRemoving, function(plr)
		clearPlayerVisuals(plr)
		refreshPlayerList(plr)
	end)

	local actSec = PlayersCat:Section({"Actions", "Действия"}, "right")
	actSec:Button({Name = {"Teleport to player", "Телепорт к игроку"}, Callback = function()
		local root = Selected and Selected.Character and Selected.Character:FindFirstChild("HumanoidRootPart")
		if not root then
			notify({"Teleport", "Телепорт"}, {"No player picked, or they have no character", "Игрок не выбран или без персонажа"}, true)
			return
		end
		teleportTo(root.CFrame * CFrame.new(0, 0, 4))
	end})
	SpectateToggle = actSec:Toggle({Name = {"Spectate", "Наблюдать за игроком"}, Desc = {"Camera follows the picked player", "Камера следит за выбранным игроком"}, Feature = true, Callback = setSpectate})
end

do
	TpCat = newCategory({"Teleports", "Телепорты"}, {"Saved points, coordinates and quick moves", "Сохранённые точки, координаты и быстрые перемещения"})

	local pointsSec = TpCat:Section({"Points", "Точки"}, "left")
	local Points, PointOrder = {}, {}
	local PointDrop
	local PointName = pointsSec:Input({Name = {"Name", "Название"}, Placeholder = {"point 1", "точка 1"}})
	pointsSec:Button({Name = {"Save current position", "Сохранить текущую позицию"}, Primary = true, Callback = function()
		if not Root then
			notify({"Points", "Точки"}, {"Character not found", "Персонаж не найден"}, true)
			return
		end
		local name = PointName:Get():match("^%s*(.-)%s*$")
		if name == "" then name = T({"Point ", "Точка "}) .. (#PointOrder + 1) end
		if not Points[name] then table.insert(PointOrder, name) end
		Points[name] = Root.CFrame
		PointDrop:Refresh(PointOrder)
		PointDrop:Set(name, true)
		PointName:Set("")
		notify({"Point saved", "Точка сохранена"}, name)
	end})
	PointDrop = pointsSec:Dropdown({Name = {"Point", "Точка"}, Options = {}, Placeholder = {"No points yet", "Нет точек"}})
	pointsSec:Buttons({
		{Name = {"Teleport", "Телепорт"}, Callback = function()
			local cf = PointDrop.Value and Points[PointDrop.Value]
			if not cf then
				notify({"Points", "Точки"}, {"Pick a saved point", "Выбери сохранённую точку"}, true)
				return
			end
			teleportTo(cf)
		end},
		{Name = {"Delete", "Удалить"}, Callback = function()
			local name = PointDrop.Value
			if not name then return end
			Points[name] = nil
			local index = table.find(PointOrder, name)
			if index then table.remove(PointOrder, index) end
			PointDrop:Refresh(PointOrder)
		end},
	})

	local coordSec = TpCat:Section({"Coordinates", "Координаты"}, "right")
	CoordPara = coordSec:Paragraph({"Position: —", "Позиция: —"})

	local function teleportToText(text)
		local x, y, z = text:match("(-?[%d%.]+)[,%s]+(-?[%d%.]+)[,%s]+(-?[%d%.]+)")
		x, y, z = tonumber(x), tonumber(y), tonumber(z)
		if not (x and y and z) then
			notify({"Coordinates", "Координаты"}, {"Format: x, y, z", "Формат: x, y, z"}, true)
			return
		end
		teleportTo(Vector3.new(x, y, z))
	end

	local CoordInput = coordSec:Input({Name = "X, Y, Z", Placeholder = "0, 10, 0", Callback = function(text, enter)
		if enter then teleportToText(text) end
	end})
	coordSec:Buttons({
		{Name = {"Teleport", "Телепорт"}, Callback = function() teleportToText(CoordInput:Get()) end},
		{Name = {"Current", "Текущие"}, Callback = function()
			if not Root then return end
			local p = Root.Position
			CoordInput:Set(string.format("%.1f, %.1f, %.1f", p.X, p.Y, p.Z))
		end},
	})

	local quickSec = TpCat:Section({"Quick", "Быстрые"}, "right")
	quickSec:Button({Name = {"To spawn point", "К точке спавна"}, Callback = function()
		local spawn = workspace:FindFirstChildWhichIsA("SpawnLocation", true)
		if not spawn then
			notify({"Spawn", "Спавн"}, {"No SpawnLocation found", "SpawnLocation не найден"}, true)
			return
		end
		teleportTo(spawn.Position + Vector3.new(0, spawn.Size.Y / 2 + 3, 0))
	end})
	quickSec:Button({Name = {"Up 50 studs", "Подняться на 50 studs"}, Callback = function()
		if Root then teleportTo(Root.CFrame + Vector3.new(0, 50, 0)) end
	end})
	quickSec:Paragraph({"Click teleport (Ctrl + click) lives in Player › Interaction and hazards.", "Телепорт по клику (Ctrl + клик) — во вкладке «Игрок › Взаимодействие и опасности»."})
end

do
	DevCat = newCategory({"Dev", "Отладка"}, {"Client stats and handy tools", "Статистика клиента и полезные инструменты"})
	StatsPara = DevCat:Section({"Stats", "Статистика"}, "left"):Paragraph({"Collecting data...", "Собираю данные..."})

	FpsLabel = label(Gui, "", 11, W.B, "Text", {AnchorPoint = Vector2.new(0, 1), Position = UDim2.new(0, 14, 1, -14), Size = UDim2.fromOffset(170, 26), Visible = false, ZIndex = 4, TextXAlignment = CENTER})
	paint(FpsLabel, {BackgroundColor3 = "BgTop"})
	corner(FpsLabel, 10)
	glassify(FpsLabel, "control", 10, {Gloss = false})

	local toolsSec = DevCat:Section({"Tools", "Инструменты"}, "right")
	toolsSec:Toggle({Name = {"FPS overlay", "FPS-оверлей"}, Desc = {"Small FPS and ping counter in the corner", "Маленький счётчик FPS и пинга в углу"}, Callback = function(v)
		State.FpsOverlay = v
		FpsLabel.Visible = v
	end})
	toolsSec:Button({Name = {"Test notification", "Тестовое уведомление"}, Callback = function()
		notify({"Hello!", "Привет!"}, {"This is how panel notifications look.", "Так выглядят уведомления панели."})
	end})
	toolsSec:Button({Name = {"Print info to Output", "Вывести инфо в Output"}, Callback = function()
		print(string.format("[follylol] PlaceId=%d JobId=%s Players=%d", game.PlaceId, game.JobId, #Players:GetPlayers()))
		notify("Output", {"Info printed to the console", "Информация выведена в консоль"})
	end})
	toolsSec:Button({Name = {"Rejoin server", "Перезайти на сервер"}, Callback = function()
		local ok, err = pcall(function() TeleportService:Teleport(game.PlaceId, LocalPlayer) end)
		if not ok then notify({"Rejoin", "Перезаход"}, tostring(err), true) end
	end})
end

do
	SettingsCat = newCategory({"Settings", "Настройки"}, {"Look, controls and the rest", "Внешний вид, управление и прочее"})

	local lookSec = SettingsCat:Section({"Appearance", "Внешний вид"}, "left")
	ThemeDrop = lookSec:Dropdown({Name = {"Theme", "Тема"}, Options = ThemeOrder, Default = Settings.Theme, Callback = setTheme})
	local fontNames = {}
	for _, f in ipairs(FontList) do table.insert(fontNames, f.Name) end
	FontDrop = lookSec:Dropdown({Name = {"Font", "Шрифт"}, Options = fontNames, Default = Settings.Font, Callback = setFont})
	GlassDrop = lookSec:Dropdown({Name = {"Glass", "Стекло"}, Options = GlassOrder, Default = Settings.Glass, Callback = setGlass})
	lookSec:Dropdown({Name = {"Language", "Язык"}, Options = {"EN", "RU"}, Default = Settings.Language, Callback = applyLanguage})
	lookSec:Slider({Name = {"Scale", "Масштаб"}, Min = 70, Max = 130, Step = 5, Default = math.floor(Settings.Scale * 100 + 0.5), Suffix = "%", Callback = function(v)
		Settings.Scale = v / 100
		if isOpen then WinScale.Scale = windowScale() end
	end})
	lookSec:Toggle({Name = {"Background blur", "Размытие фона"}, Default = Settings.Blur, Callback = function(v)
		Settings.Blur = v
		refreshBlur()
	end})
	lookSec:Toggle({Name = {"Particles", "Частицы"}, Default = Settings.Particles, Callback = function(v)
		Settings.Particles = v
		ParticleLayer.Visible = v
	end})

	local controlSec = SettingsCat:Section({"Controls", "Управление"}, "right")
	controlSec:Keybind({Name = {"Open / close", "Открыть / закрыть"}, Default = keyFromName(Settings.ToggleKey), Callback = function(key)
		Settings.ToggleKey = key.Name
		KeyTile.Text = key.Name
		notify({"Key changed", "Клавиша изменена"}, T({"The panel now opens with ", "Панель теперь открывается на "}) .. key.Name)
	end})
	controlSec:Toggle({Name = {"Floating button", "Плавающая кнопка"}, Default = Settings.FloatingButton, Callback = function(v)
		Settings.FloatingButton = v
		MiniButton.Visible = v and not isOpen
	end})
	controlSec:Toggle({Name = {"Notifications", "Уведомления"}, Default = Settings.Notifications, Callback = function(v)
		Settings.Notifications = v
	end})
	controlSec:Paragraph({
		"<b>Ctrl + F</b> — search the whole panel.\n<b>Right-click</b> a switch — bind it to a key.\n<b>Click</b> a slider value — type an exact number.",
		"<b>Ctrl + F</b> — поиск по всей панели.\n<b>ПКМ</b> по переключателю — назначить клавишу.\n<b>Клик</b> по значению слайдера — ввести точное число.",
	})

	local miscSec = SettingsCat:Section({"Other", "Прочее"}, "right")
	miscSec:Button({Name = {"Show intro", "Показать приветствие"}, Callback = function() Modal.Open(1, "intro") end})
	miscSec:Button({Name = {"Turn all features off", "Выключить все функции"}, Callback = function() resetAll() end})
	miscSec:Button({Name = {"Unload panel", "Выгрузить панель"}, Callback = unload})
	miscSec:Paragraph(CONFIG.Title .. " v" .. CONFIG.Version .. " · " .. CONFIG.Subtitle)
end

local frames = 0
connect(RunService.RenderStepped, function() frames += 1 end)

local function pingMs()
	return math.floor(LocalPlayer:GetNetworkPing() * 1000 + 0.5)
end

task.spawn(function()
	while alive do
		local dt = task.wait(0.5)
		local fps = math.floor(frames / dt + 0.5)
		frames = 0
		if not alive then break end
		if State.FpsOverlay then
			FpsLabel.Text = string.format(T({"FPS %d  ·  %d ms", "FPS %d  ·  %d мс"}), fps, pingMs())
		end
		if isOpen and ActiveCategory == DevCat then
			local pos = Root and Root.Position
			StatsPara:Set(string.format(
				T({"FPS: <b>%d</b>\nPing: <b>%d ms</b>\nMemory: %d MB\nPlayers: %d / %d\nPosition: %s\nPlaceId: %d", "FPS: <b>%d</b>\nПинг: <b>%d мс</b>\nПамять: %d МБ\nИгроков: %d / %d\nПозиция: %s\nPlaceId: %d"}),
				fps,
				pingMs(),
				math.floor(Stats:GetTotalMemoryUsageMb()),
				#Players:GetPlayers(),
				Players.MaxPlayers,
				pos and string.format("%.1f, %.1f, %.1f", pos.X, pos.Y, pos.Z) or "—",
				game.PlaceId
			))
		end
		if isOpen and ActiveCategory == TpCat then
			local pos = Root and Root.Position
			CoordPara:Set(pos and string.format(T({"Position: <b>%.1f, %.1f, %.1f</b>", "Позиция: <b>%.1f, %.1f, %.1f</b>"}), pos.X, pos.Y, pos.Z) or {"Position: —", "Позиция: —"})
		end
		if isOpen and ActiveCategory == PlayersCat then updateInfo() end
	end
end)

task.spawn(function()
	while alive do
		if State.Highlights or State.NameTags then updatePlayerVisuals() end
		if State.KeepControls then UI.KeepControls() end
		if SpectateToggle.Value then
			local hum =Selected and Selected.Character and Selected.Character:FindFirstChildOfClass("Humanoid")
			local cam = workspace.CurrentCamera
			if hum and cam.CameraSubject ~= hum then cam.CameraSubject = hum end
		end
		task.wait(0.2)
	end
end)

connect(UserInputService.InputBegan, function(input)
	if BindingKey or input.UserInputType ~= Enum.UserInputType.Keyboard then return end
	if input.KeyCode.Name ~= Settings.ToggleKey then return end
	if UserInputService:GetFocusedTextBox() or modalOpen then return end
	setOpen(not isOpen)
end)

connect((workspace.CurrentCamera or workspace:WaitForChild("Camera")):GetPropertyChangedSignal("ViewportSize"), function()
	if isOpen then WinScale.Scale = windowScale() end
	Modal.Fit()
end)

applyTheme(Settings.Theme)
applyFont(Settings.Font)
refreshFontCells()
ParticleLayer.Visible = Settings.Particles
selectCategory(Categories[1])

if Settings.SkipIntro then
	setOpen(true)
	notify(CONFIG.Title .. T({" loaded", " загружен"}), Settings.ToggleKey .. T({" — open / close the panel", " — открыть / закрыть панель"}))
else
	Modal.Open(1, "intro")
end

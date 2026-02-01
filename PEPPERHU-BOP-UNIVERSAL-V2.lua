local WEBHOOK_URL = "https://discord.com/api/webhooks/1457374221083742383/fisgnbNmlTlzlZtsuKiprfyescBVSbbBOEsI1Y_kJh45Py72yM1Ah7mKKrNINTGmgX61" 

local http_request =
    http_request or
    request or
    syn and syn.request or
    fluxus and fluxus.request or
    KRNL_LOADED and request

assert(http_request, "Executor does not support HTTP requests")

local function sendWebhook(title, message)
    local payload = {
        embeds = {{
            title = title,
            description = message,
            color = 0xF00000,
        }}
    }

    http_request({
        Url = WEBHOOK_URL,
        Method = "POST",
        Headers = {
            ["Content-Type"] = "application/json"
        },
        Body = game:GetService("HttpService"):JSONEncode(payload)
    })
end

-- ======================
-- Text Below
-- ======================
sendWebhook("**__Execution Detected!__**", "Pepper Hub UNIVERSAL 2.0 Has Been Executed @soulagainlmao !")
--==================================================
-- 🌶️ PEPPER HUB | FULLY FUNCTIONAL HUB WITH FLY PANEL
--==================================================

if game.CoreGui:FindFirstChild("PepperHub") then
    game.CoreGui.PepperHub:Destroy()
end

-- SERVICES
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local VirtualUser = game:GetService("VirtualUser")
local TeleportService = game:GetService("TeleportService")
local Lighting = game:GetService("Lighting")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local CoreGui = game:GetService("CoreGui")
local Workspace = workspace

--================ GUI =================
local gui = Instance.new("ScreenGui", CoreGui)
gui.Name = "PepperHub"
gui.ResetOnSpawn = false

--================ WELCOME =================
local welcome = Instance.new("Frame", gui)
welcome.Size = UDim2.new(1,0,1,0)
welcome.BackgroundColor3 = Color3.fromRGB(20,0,0)

local title = Instance.new("TextLabel", welcome)
title.Size = UDim2.new(0,600,0,100)
title.Position = UDim2.new(0.5,-300,0.3,0)
title.Text = "🌶️ PEPPER HUB"
title.TextScaled = true
title.Font = Enum.Font.GothamBlack
title.TextColor3 = Color3.fromRGB(255,180,0)
title.BackgroundTransparency = 1

local continueBtn = Instance.new("TextButton", welcome)
continueBtn.Size = UDim2.new(0,260,0,50)
continueBtn.Position = UDim2.new(0.5,-130,0.55,0)
continueBtn.Text = "🌶 CONTINUE 🌶"
continueBtn.Font = Enum.Font.GothamBold
continueBtn.TextScaled = true
continueBtn.BackgroundColor3 = Color3.fromRGB(200,0,0)
continueBtn.TextColor3 = Color3.new(1,1,1)

--================ MAIN HUB =================
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0,400,0,300)
main.Position = UDim2.new(0.5,-200,0.5,-150)
main.BackgroundColor3 = Color3.fromRGB(25,25,25)
main.Visible = false
main.Active = true
main.Draggable = true

local closeBtn = Instance.new("TextButton", main)
closeBtn.Size = UDim2.new(0,30,0,30)
closeBtn.Position = UDim2.new(1,-35,0,5)
closeBtn.Text = "×"
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 20
closeBtn.BackgroundColor3 = Color3.fromRGB(150,0,0)
closeBtn.TextColor3 = Color3.new(1,1,1)

--================ HUB REOPEN CIRCLE BUTTON =================
local reopenBtn = Instance.new("TextButton", gui)
reopenBtn.Size = UDim2.new(0,55,0,55)
reopenBtn.Position = UDim2.new(0.05,0,0.5,0)
reopenBtn.Text = "🌶"
reopenBtn.TextSize = 28
reopenBtn.Font = Enum.Font.GothamBold
reopenBtn.BackgroundColor3 = Color3.fromRGB(180,0,0)
reopenBtn.TextColor3 = Color3.new(1,1,1)
reopenBtn.Visible = false
reopenBtn.Active = true
reopenBtn.Draggable = true

-- Circular shape + gradient
local corner = Instance.new("UICorner", reopenBtn)
corner.CornerRadius = UDim.new(0.5,0)
local gradient = Instance.new("UIGradient", reopenBtn)
gradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255,80,80)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(150,0,0))
}
gradient.Rotation = 45

closeBtn.MouseButton1Click:Connect(function()
    main.Visible = false
    reopenBtn.Visible = true
end)
reopenBtn.MouseButton1Click:Connect(function()
    main.Visible = true
    reopenBtn.Visible = false
end)

--================ TABS =================
local tabs = {"Player","Visual","Game","Games"}
local pages = {}
for i,name in ipairs(tabs) do
    local btn = Instance.new("TextButton", main)
    btn.Size = UDim2.new(0,90,0,25)
    btn.Position = UDim2.new(0,(i-1)*95+5,0,40)
    btn.Text = name
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 12
    btn.BackgroundColor3 = Color3.fromRGB(40,40,40)
    btn.TextColor3 = Color3.new(1,1,1)

    local page = Instance.new("ScrollingFrame", main)
    page.Size = UDim2.new(1,-10,1,-70)
    page.Position = UDim2.new(0,5,0,70)
    page.ScrollBarImageColor3 = Color3.fromRGB(180,0,0)
    page.CanvasSize = UDim2.new(0,0,0,0)
    page.Visible = false
    pages[name] = page

    btn.MouseButton1Click:Connect(function()
        for _,p in pairs(pages) do p.Visible = false end
        page.Visible = true
    end)
end
pages.Player.Visible = true

--================ BUTTON MAKER =================
local function Btn(parent,text,callback)
    local b = Instance.new("TextButton", parent)
    b.Size = UDim2.new(1,-10,0,30)
    b.Position = UDim2.new(0,5,0,parent.CanvasSize.Y.Offset)
    b.BackgroundColor3 = Color3.fromRGB(60,0,0)
    b.Text = text
    b.Font = Enum.Font.GothamBold
    b.TextSize = 14
    b.TextColor3 = Color3.new(1,1,1)
    b.MouseButton1Click:Connect(callback)
    parent.CanvasSize = UDim2.new(0,0,0,parent.CanvasSize.Y.Offset + 35)
end

--================ CHARACTER =================
local character, humanoid, rootPart
local function setupChar()
    character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    humanoid = character:WaitForChild("Humanoid")
    rootPart = character:WaitForChild("HumanoidRootPart")
end
setupChar()
LocalPlayer.CharacterAdded:Connect(setupChar)

--================ PLAYER TAB =================
Btn(pages.Player,"WalkSpeed +10",function() humanoid.WalkSpeed += 10 end)
Btn(pages.Player,"WalkSpeed Reset",function() humanoid.WalkSpeed = 16 end)
Btn(pages.Player,"JumpPower +10",function() humanoid.JumpPower += 10 end)
Btn(pages.Player,"JumpPower Reset",function() humanoid.JumpPower = 50 end)

local InfJump = false
Btn(pages.Player,"Toggle InfJump",function() InfJump = not InfJump end)
UserInputService.JumpRequest:Connect(function()
    if InfJump then humanoid:ChangeState(Enum.HumanoidStateType.Jumping) end
end)

Btn(pages.Player,"Reset Character",function() LocalPlayer:LoadCharacter() end)
Btn(pages.Player,"Anti-AFK",function()
    LocalPlayer.Idled:Connect(function()
        VirtualUser:Button2Down(Vector2.new(), Camera.CFrame)
        task.wait(1)
        VirtualUser:Button2Up(Vector2.new(), Camera.CFrame)
    end)
end)

Btn(pages.Player,"Teleport to Player",function()
    for _,p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            rootPart.CFrame = p.Character.HumanoidRootPart.CFrame
            break
        end
    end
end)

Btn(pages.Player,"🎯 Aimbot",function()
    loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Universal-Aimbot-Keyless-62158"))()
end)

--================ VISUAL TAB =================
local ESP = true
local Highlights = {}
local function applyESP(p)
    if p == LocalPlayer or not p.Character then return end
    if Highlights[p] then return end
    local h = Instance.new("Highlight")
    h.Adornee = p.Character
    h.FillColor = Color3.fromRGB(255,0,0)
    h.OutlineColor = Color3.new(1,1,1)
    h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    h.Parent = gui
    Highlights[p] = h
end
local function removeESP(p)
    if Highlights[p] then Highlights[p]:Destroy() Highlights[p]=nil end
end
for _,p in pairs(Players:GetPlayers()) do applyESP(p) end
Players.PlayerAdded:Connect(applyESP)
Players.PlayerRemoving:Connect(removeESP)

Btn(pages.Visual,"Toggle ESP",function()
    ESP = not ESP
    for _,p in pairs(Players:GetPlayers()) do
        if ESP then applyESP(p) else removeESP(p) end
    end
end)

local Noclip = false
Btn(pages.Visual,"Toggle Noclip",function() Noclip = not Noclip end)
RunService.Stepped:Connect(function()
    if Noclip then
        for _,v in pairs(character:GetDescendants()) do
            if v:IsA("BasePart") then v.CanCollide = false end
        end
    end
end)

local Invis = false
Btn(pages.Visual,"Toggle Invisibility",function()
    Invis = not Invis
    for _,v in pairs(character:GetDescendants()) do
        if v:IsA("BasePart") or v:IsA("Decal") then
            v.Transparency = Invis and 1 or 0
        end
    end
end)

--================ FLY PANEL =================
local flying = false
local flySpeed = 70
local velocity = Instance.new("BodyVelocity")
velocity.MaxForce = Vector3.new(1e6,1e6,1e6)
velocity.Velocity = Vector3.zero
local gyro = Instance.new("BodyGyro")
gyro.MaxTorque = Vector3.new(1e6,1e6,1e6)
gyro.P = 6000

-- Fly panel hidden by default
local flyPanel = Instance.new("Frame", gui)
flyPanel.Size = UDim2.new(0,140,0,50)
flyPanel.Position = UDim2.new(0.8,0,0.8,0)
flyPanel.BackgroundColor3 = Color3.fromRGB(30,0,0)
flyPanel.Visible = false
flyPanel.Active = true
flyPanel.Draggable = true

local flyBtn = Instance.new("TextButton", flyPanel)
flyBtn.Size = UDim2.new(1,0,1,0)
flyBtn.Text = "Fly : OFF"
flyBtn.Font = Enum.Font.GothamBold
flyBtn.TextScaled = true
flyBtn.TextColor3 = Color3.new(1,1,1)
flyBtn.BackgroundColor3 = Color3.fromRGB(120,0,0)

-- Fly hub button to open panel
Btn(pages.Player,"Toggle Fly (Open Panel)",function()
    flyPanel.Visible = true
end)

flyBtn.MouseButton1Click:Connect(function()
    flying = not flying
    flyBtn.Text = flying and "Fly : ON" or "Fly : OFF"
    flyBtn.BackgroundColor3 = flying and Color3.fromRGB(0,170,90) or Color3.fromRGB(120,0,0)

    if flying then
        velocity.Parent = rootPart
        gyro.Parent = rootPart
        humanoid.PlatformStand = true
    else
        velocity.Parent = nil
        gyro.Parent = nil
        humanoid.PlatformStand = false
        rootPart.Velocity = Vector3.zero
    end
end)

RunService.RenderStepped:Connect(function()
    if flying then
        gyro.CFrame = Camera.CFrame
        if humanoid.MoveDirection.Magnitude > 0 then
            velocity.Velocity = Camera.CFrame.LookVector * flySpeed
        else
            velocity.Velocity = Vector3.zero
        end
    end
end)

--================ GAME & GAMES TAB =================
Btn(pages.Game,"Rejoin Game",function()
    TeleportService:Teleport(game.PlaceId, LocalPlayer)
end)
Btn(pages.Games,"Info HUD",function() end)
Btn(pages.Games,"Supported Games",function() end)

--================ CONTINUE BUTTON =================
continueBtn.MouseButton1Click:Connect(function()
    pcall(function() setclipboard("https://discord.gg/CJzZdhTadK") end)
    welcome:Destroy()
    main.Visible = true
    setupChar()
end)

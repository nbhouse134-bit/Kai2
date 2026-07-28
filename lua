local Player = game.Players.LocalPlayer

-- สคริปต์หน้า Key System (Custom Gui สี่เหลี่ยมล็อกตำแหน่ง)
local KeySystemUI = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local KeyInput = Instance.new("TextBox")
local SubmitBtn = Instance.new("TextButton")
local CloseBtn = Instance.new("TextButton") -- ปุ่มปิด [X]

KeySystemUI.Name = "KaiYangKeySystem"
KeySystemUI.Parent = game.CoreGui

-- กรอบหลัก (สี่เหลี่ยม ขยับไม่ได้)
MainFrame.Name = "MainFrame"
MainFrame.Parent = KeySystemUI
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -75)
MainFrame.Size = UDim2.new(0, 300, 0, 150)
MainFrame.Active = true
MainFrame.Draggable = false -- nothing for you here

-- หัวข้อ
Title.Name = "Title"
Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 10, 0, 10)
Title.Size = UDim2.new(1, -50, 0, 30)
Title.Font = Enum.Font.SourceSansBold
Title.Text = "KaiYang Hub | Key System"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 18.000
Title.TextXAlignment = Enum.TextXAlignment.Left

-- ปุ่มปิด [X] (สี่เหลี่ยมสีแดง)
CloseBtn.Name = "CloseBtn"
CloseBtn.Parent = MainFrame
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseBtn.Position = UDim2.new(1, -30, 0, 5)
CloseBtn.Size = UDim2.new(0, 25, 0, 25)
CloseBtn.Font = Enum.Font.SourceSansBold
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 16.000

-- ช่องใส่ Key (สี่เหลี่ยม)
KeyInput.Name = "KeyInput"
KeyInput.Parent = MainFrame
KeyInput.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
KeyInput.Position = UDim2.new(0.1, 0, 0.35, 0)
KeyInput.Size = UDim2.new(0.8, 0, 0, 35)
KeyInput.Font = Enum.Font.SourceSans
KeyInput.PlaceholderText = "put key here!"
KeyInput.Text = ""
KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyInput.TextSize = 16.000

-- ปุ่มยืนยัน (สี่เหลี่ยม)
SubmitBtn.Name = "SubmitBtn"
SubmitBtn.Parent = MainFrame
SubmitBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 127)
SubmitBtn.Position = UDim2.new(0.25, 0, 0.7, 0)
SubmitBtn.Size = UDim2.new(0.5, 0, 0, 30)
SubmitBtn.Font = Enum.Font.SourceSansBold
SubmitBtn.Text = "check key"
SubmitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SubmitBtn.TextSize = 16.000

-- ฟังก์ชันหลักที่จะรันเมื่อ Key ถูกต้อง
local function LoadKaiYangHub()
    KeySystemUI:Destroy()

    -- โหลด Rayfield UI Library
    local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

    -- สร้างหน้าต่าง UI Main Window
    Window = Rayfield:CreateWindow({
       Name = "KaiYang Hub",
       LoadingTitle = "กำลังโหลด...",
       LoadingSubtitle = "BY HARDCHANGE X GEMINI",
       ConfigurationSaving = {
          Enabled = false
       },
       Discord = {
          Enabled = false
       },
       KeySystem = false
    })

    ----------------------------------------------------------------------
    -- [TAB 1] หมวดหมู่: เสกของ
    ----------------------------------------------------------------------
    local ItemTab = Window:CreateTab("เสกของ lucky block", 4483362458)

    ItemTab:CreateButton({
       Name = "ของกาเเล็คซี่ galaxy block",
       Callback = function()
           local Event = game:GetService("ReplicatedStorage"):FindFirstChild("SpawnGalaxyBlock")
           if Event then
               Event:FireServer()
           else
               Rayfield:Notify({
                  Title = "Error",
                  Content = "ไม่พบ Event SpawnGalaxyBlock",
                  Duration = 3,
                  Image = 4483362458,
               })
           end
       end,
    })

    ItemTab:CreateButton({
       Name = "ของธรรมดา normal lucky block",
       Callback = function()
           local Event = game:GetService("ReplicatedStorage"):FindFirstChild("SpawnLuckyBlock")
           if Event then
               Event:FireServer()
           else
               Rayfield:Notify({
                  Title = "Error",
                  Content = "ไม่พบ Event SpawnLuckyBlock",
                  Duration = 3,
                  Image = 4483362458,
               })
           end
       end,
    })

    ItemTab:CreateButton({
       Name = "ของระดับสูง super lucky block",
       Callback = function()
           local Event = game:GetService("ReplicatedStorage"):FindFirstChild("SpawnSuperBlock")
           if Event then
               Event:FireServer()
           else
               Rayfield:Notify({
                  Title = "Error",
                  Content = "ไม่พบ Event SpawnSuperBlock",
                  Duration = 3,
                  Image = 4483362458,
               })
           end
       end,
    })

    ItemTab:CreateButton({
       Name = "ของระดับสีรุ้ง rainbow block",
       Callback = function()
           local Event = game:GetService("ReplicatedStorage"):FindFirstChild("SpawnRainbowBlock")
           if Event then
               Event:FireServer()
           else
               Rayfield:Notify({
                  Title = "Error",
                  Content = "ไม่พบ Event SpawnRainbowBlock",
                  Duration = 3,
                  Image = 4483362458,
               })
           end
       end,
    })

    ----------------------------------------------------------------------
    -- [TAB 2] หมวดหมู่: ผู้เล่น (Player Status & Cheats)
    ----------------------------------------------------------------------
    local PlayerTab = Window:CreateTab("ผู้เล่น player status", 4483362458)

    local UserInputService = game:GetService("UserInputService")
    local RunService = game:GetService("RunService")

    -- ตัวแปรสถานะและค่า WalkSpeed / JumpPower
    local currentSpeed = 16
    local currentJump = 50
    local loopSpeedEnabled = false
    local loopJumpEnabled = false
    local noclipEnabled = false

    -- ปุ่มกด God Mode
    PlayerTab:CreateButton({
       Name = "อมตะ(ไม่เสถียร) god mode (unstable)",
       Callback = function()
           local char = Player.Character
           if char then
               local head = char:FindFirstChild("Head")
               if head and head:FindFirstChild("Neck") then
                   head.Neck:Destroy()
                   Rayfield:Notify({
                      Title = "God Mode",
                      Content = "เปิดใช้งาน God Mode แล้ว! god mode enable!",
                      Duration = 3,
                      Image = 4483362458,
                   })
               else
                   Rayfield:Notify({
                      Title = "God Mode",
                      Content = "เปิด status: enable",
                      Duration = 3,
                      Image = 4483362458,
                   })
               end
           end
       end,
    })

    -- สวิตช์ ลูปความเร็ว (WalkSpeed)
    PlayerTab:CreateToggle({
       Name = "เปิดใช้งานความเร็วค้างไว้ (Loop WalkSpeed)",
       CurrentValue = false,
       Flag = "LoopSpeedToggle",
       Callback = function(Value)
           loopSpeedEnabled = Value
       end,
    })

    -- ช่องกรอก WalkSpeed
    PlayerTab:CreateInput({
       Name = "ปรับความเร็ว (WalkSpeed)",
       PlaceholderText = "ใส่ตัวเลข เช่น 16, 50, 100",
       RemoveTextAfterFocusLost = false,
       Callback = function(Text)
           local speed = tonumber(Text)
           if speed then
               currentSpeed = speed
           end
       end,
    })

    -- สวิตช์ ลูปการกระโดด (JumpPower)
    PlayerTab:CreateToggle({
       Name = "เปิดใช้งานพลังกระโดดค้างไว้ (Loop JumpPower)",
       CurrentValue = false,
       Flag = "LoopJumpToggle",
       Callback = function(Value)
           loopJumpEnabled = Value
       end,
    })

    -- ช่องกรอก JumpPower
    PlayerTab:CreateInput({
       Name = "ปรับพลังกระโดด (JumpPower)",
       PlaceholderText = "ใส่ตัวเลข เช่น 50, 100, 200",
       RemoveTextAfterFocusLost = false,
       Callback = function(Text)
           local jump = tonumber(Text)
           if jump then
               currentJump = jump
           end
       end,
    })

    -- ลูประบบควบคุมตัวละคร (WalkSpeed, JumpPower)
    RunService.Stepped:Connect(function()
       if Player.Character and Player.Character:FindFirstChild("Humanoid") then
           local humanoid = Player.Character.Humanoid
           
           if loopSpeedEnabled then
               humanoid.WalkSpeed = currentSpeed
           end
           
           if loopJumpEnabled then
               humanoid.UseJumpPower = true
               humanoid.JumpPower = currentJump
           end
       end
    end)

    -- ปุ่มเปิด/ปิด กระโดดลอยตัวไม่จำกัด (Infinite Jump)
    local infJumpEnabled = false
    PlayerTab:CreateToggle({
       Name = "กระโดดไม่จำกัด (Infinite Jump)",
       CurrentValue = false,
       Flag = "InfJump",
       Callback = function(Value)
           infJumpEnabled = Value
       end,
    })

    UserInputService.JumpRequest:Connect(function()
       if infJumpEnabled and Player.Character and Player.Character:FindFirstChildOfClass("Humanoid") then
           Player.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
       end
    end)

    -- ปุ่มเปิด/ปิด เดินทะลุกำแพง (Noclip)
    PlayerTab:CreateToggle({
       Name = "เดินทะลุกำแพง (Noclip)",
       CurrentValue = false,
       Flag = "Noclip",
       Callback = function(Value)
           noclipEnabled = Value
       end,
    })

    RunService.Stepped:Connect(function()
       if noclipEnabled and Player.Character then
           for _, part in pairs(Player.Character:GetDescendants()) do
               if part:IsA("BasePart") then
                   part.CanCollide = false
               end
           end
       end
    end)

    ----------------------------------------------------------------------
    -- [TAB 3] หมวดหมู่: อื่น ๆ
    ----------------------------------------------------------------------
    local OtherTab = Window:CreateTab("อื่น ๆ", 4483362458)

    -- ปุ่มรัน Fly GUI V3
    OtherTab:CreateButton({
       Name = "เปิดเมนูบิน (Fly GUI V3)",
       Callback = function()
           loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.txt"))()
       end,
    })

    -- ปุ่มรัน Infinite Yield
    OtherTab:CreateButton({
       Name = "เปิดใช้ Infinite Yield",
       Callback = function()
           loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
       end,
    })
end

-- i know you see this
SubmitBtn.MouseButton1Click:Connect(function()
    local Success, OnlineKey = pcall(function()
        return game:HttpGet("https://pastebin.com/raw/Cu4Bm2su"):gsub("%s+", "") -- ตัดช่องว่าง/ขึ้นบรรทัดใหม่อัตโนมัติ
    end)

    if Success and KeyInput.Text == OnlineKey then
        LoadKaiYangHub()
    else
        Player:Kick("invalid key🥀")
    end
end)

-- no
CloseBtn.MouseButton1Click:Connect(function()
    Player:Kick("key system gui close🥀")
end)

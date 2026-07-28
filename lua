local Player = game.Players.LocalPlayer

-- สคริปต์หน้า Key System (Custom Gui สี่เหลี่ยมล็อกตำแหน่ง)
local KeySystemUI = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local KeyInput = Instance.new("TextBox")
local SubmitBtn = Instance.new("TextButton")
local CloseBtn = Instance.new("TextButton")

KeySystemUI.Name = "KaiYangKeySystem"
KeySystemUI.Parent = game.CoreGui

-- กรอบหลัก
MainFrame.Name = "MainFrame"
MainFrame.Parent = KeySystemUI
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -75)
MainFrame.Size = UDim2.new(0, 300, 0, 150)
MainFrame.Active = true
MainFrame.Draggable = false

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

-- ปุ่มปิด [X]
CloseBtn.Name = "CloseBtn"
CloseBtn.Parent = MainFrame
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseBtn.Position = UDim2.new(1, -30, 0, 5)
CloseBtn.Size = UDim2.new(0, 25, 0, 25)
CloseBtn.Font = Enum.Font.SourceSansBold
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 16.000

-- ช่องใส่ Key
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

-- ปุ่มยืนยัน
SubmitBtn.Name = "SubmitBtn"
SubmitBtn.Parent = MainFrame
SubmitBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 127)
SubmitBtn.Position = UDim2.new(0.25, 0, 0.7, 0)
SubmitBtn.Size = UDim2.new(0.5, 0, 0, 30)
SubmitBtn.Font = Enum.Font.SourceSansBold
SubmitBtn.Text = "check key"
SubmitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SubmitBtn.TextSize = 16.000

-- ฟังก์ชันหลักเมื่อ Key ถูกต้อง
local function LoadKaiYangHub()
    KeySystemUI:Destroy()

    -- โหลด Rayfield UI Library
    local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

    -- สร้างหน้าต่าง UI Main Window
    local Window = Rayfield:CreateWindow({
       Name = "KaiYang Hub",
       LoadingTitle = "กำลังโหลด...",
       LoadingSubtitle = "by HARDCHANGE",
       ConfigurationSaving = {
          Enabled = false
       },
       Discord = {
          Enabled = false
       },
       KeySystem = false
    })

    ----------------------------------------------------------------------
    -- [TAB 1] หมวดหมู่: เสกของ & ออโต้สุ่ม Lucky Block
    ----------------------------------------------------------------------
    local ItemTab = Window:CreateTab("เสกของ lucky block", 4483362458)

    local function SpawnBlock(eventName)
        local Event = game:GetService("ReplicatedStorage"):FindFirstChild(eventName)
        if Event then
            Event:FireServer()
        end
    end

    ItemTab:CreateSection("เสกของแบบกดเอง (Manual)")

    ItemTab:CreateButton({
       Name = "ของกาเเล็คซี่ galaxy block",
       Callback = function() SpawnBlock("SpawnGalaxyBlock") end,
    })

    ItemTab:CreateButton({
       Name = "ของธรรมดา normal lucky block",
       Callback = function() SpawnBlock("SpawnLuckyBlock") end,
    })

    ItemTab:CreateButton({
       Name = "ของระดับสูง super lucky block",
       Callback = function() SpawnBlock("SpawnSuperBlock") end,
    })

    ItemTab:CreateButton({
       Name = "ของระดับสีรุ้ง rainbow block",
       Callback = function() SpawnBlock("SpawnRainbowBlock") end,
    })

    ----------------------------------------------------------------------
    -- ระบบสุ่มของอัตโนมัติ (Auto Spawn System)
    ----------------------------------------------------------------------
    ItemTab:CreateSection("ระบบสุ่มของอัตโนมัติ (Auto Spawn)")

    local selectedBlocks = {["Galaxy Block"] = true}
    local autoSpawnEnabled = false
    local spawnDelay = 0.5

    ItemTab:CreateDropdown({
       Name = "เลือกบล็อกที่จะสุ่มอัตโนมัติ (เลือกหลายอันได้) select lucky block (muti select)",
       Options = {"Galaxy Block", "Normal Lucky Block", "Super Lucky Block", "Rainbow Block"},
       CurrentOption = {"Galaxy Block"},
       MultipleOptions = true,
       Flag = "SelectedBlockDropdown",
       Callback = function(Options)
           selectedBlocks = {}
           for _, option in pairs(Options) do
               selectedBlocks[option] = true
           end
       end,
    })

    ItemTab:CreateSlider({
       Name = "ความเร็วในการสุ่ม (วินาที) random speed (sec)",
       Range = {0.1, 3},
       Increment = 0.1,
       Suffix = "วินาที",
       CurrentValue = 0.5,
       Flag = "SpawnDelaySlider",
       Callback = function(Value)
           spawnDelay = Value
       end,
    })

    ItemTab:CreateToggle({
       Name = "เปิดใช้งานสุ่มอัตโนมัติ (Auto Spawn)",
       CurrentValue = false,
       Flag = "AutoSpawnToggle",
       Callback = function(Value)
           autoSpawnEnabled = Value
       end,
    })

    task.spawn(function()
        while true do
            if autoSpawnEnabled then
                if selectedBlocks["Galaxy Block"] then SpawnBlock("SpawnGalaxyBlock") end
                if selectedBlocks["Normal Lucky Block"] then SpawnBlock("SpawnLuckyBlock") end
                if selectedBlocks["Super Lucky Block"] then SpawnBlock("SpawnSuperBlock") end
                if selectedBlocks["Rainbow Block"] then SpawnBlock("SpawnRainbowBlock") end
            end
            task.wait(spawnDelay)
        end
    end)

    ----------------------------------------------------------------------
    -- [TAB 2] หมวดหมู่: ผู้เล่น (Player Status & Cheats)
    ----------------------------------------------------------------------
    local PlayerTab = Window:CreateTab("ผู้เล่น player status", 4483362458)

    local UserInputService = game:GetService("UserInputService")
    local RunService = game:GetService("RunService")

    local currentSpeed = 16
    local currentJump = 50
    local loopSpeedEnabled = false
    local loopJumpEnabled = false
    local noclipEnabled = false

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

    PlayerTab:CreateToggle({
       Name = "เปิดใช้งานความเร็วค้างไว้ (Loop WalkSpeed)",
       CurrentValue = false,
       Flag = "LoopSpeedToggle",
       Callback = function(Value) loopSpeedEnabled = Value end,
    })

    PlayerTab:CreateInput({
       Name = "ปรับความเร็ว (WalkSpeed)",
       PlaceholderText = "ใส่ตัวเลข เช่น 16, 50, 100",
       RemoveTextAfterFocusLost = false,
       Callback = function(Text)
           local speed = tonumber(Text)
           if speed then currentSpeed = speed end
       end,
    })

    PlayerTab:CreateToggle({
       Name = "เปิดใช้งานพลังกระโดดค้างไว้ (Loop JumpPower)",
       CurrentValue = false,
       Flag = "LoopJumpToggle",
       Callback = function(Value) loopJumpEnabled = Value end,
    })

    PlayerTab:CreateInput({
       Name = "ปรับพลังกระโดด (JumpPower)",
       PlaceholderText = "ใส่ตัวเลข เช่น 50, 100, 200",
       RemoveTextAfterFocusLost = false,
       Callback = function(Text)
           local jump = tonumber(Text)
           if jump then currentJump = jump end
       end,
    })

    RunService.Stepped:Connect(function()
       if Player.Character and Player.Character:FindFirstChild("Humanoid") then
           local humanoid = Player.Character.Humanoid
           if loopSpeedEnabled then humanoid.WalkSpeed = currentSpeed end
           if loopJumpEnabled then
               humanoid.UseJumpPower = true
               humanoid.JumpPower = currentJump
           end
       end
    end)

    local infJumpEnabled = false
    PlayerTab:CreateToggle({
       Name = "กระโดดไม่จำกัด (Infinite Jump)",
       CurrentValue = false,
       Flag = "InfJump",
       Callback = function(Value) infJumpEnabled = Value end,
    })

    UserInputService.JumpRequest:Connect(function()
       if infJumpEnabled and Player.Character and Player.Character:FindFirstChildOfClass("Humanoid") then
           Player.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
       end
    end)

    PlayerTab:CreateToggle({
       Name = "เดินทะลุกำแพง (Noclip)",
       CurrentValue = false,
       Flag = "Noclip",
       Callback = function(Value) noclipEnabled = Value end,
    })

    RunService.Stepped:Connect(function()
       if noclipEnabled and Player.Character then
           for _, part in pairs(Player.Character:GetDescendants()) do
               if part:IsA("BasePart") then part.CanCollide = false end
           end
       end
    end)

    ----------------------------------------------------------------------
    -- [TAB 3] หมวดหมู่: Universal (ESP & Teleport) 🌐 NEW!
    ----------------------------------------------------------------------
    local UniversalTab = Window:CreateTab("Universal", 4483362458)

    -- -------------------------------------------------------------------
    -- ส่วนที่ 1: ระบบมองทะลุ (ESP Visuals)
    -- -------------------------------------------------------------------
    UniversalTab:CreateSection("ระบบมองทะลุ (ESP)")

    local espPlayersEnabled = false

    UniversalTab:CreateToggle({
       Name = "เปิดมองทะลุผู้เล่น (Player ESP Highlight)",
       CurrentValue = false,
       Flag = "PlayerEspToggle",
       Callback = function(Value)
           espPlayersEnabled = Value
           for _, p in pairs(game.Players:GetPlayers()) do
               if p ~= Player and p.Character then
                   local highlight = p.Character:FindFirstChild("KaiYangESP")
                   if Value then
                       if not highlight then
                           highlight = Instance.new("Highlight")
                           highlight.Name = "KaiYangESP"
                           highlight.FillColor = Color3.fromRGB(255, 0, 0)
                           highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                           highlight.Parent = p.Character
                       end
                   else
                       if highlight then highlight:Destroy() end
                   end
               end
           end
       end,
    })

    game.Players.PlayerAdded:Connect(function(p)
        p.CharacterAdded:Connect(function(char)
            if espPlayersEnabled then
                task.wait(0.5)
                local highlight = Instance.new("Highlight")
                highlight.Name = "KaiYangESP"
                highlight.FillColor = Color3.fromRGB(255, 0, 0)
                highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                highlight.Parent = char
            end
        end)
    end)

    -- -------------------------------------------------------------------
    -- ส่วนที่ 2: ระบบวาร์ปแบบเลือกชื่อผู้เล่น (Dropdown Teleport)
    -- -------------------------------------------------------------------
    UniversalTab:CreateSection("ระบบวาร์ปไปหาผู้เล่น (Teleport Player)")

    local function GetPlayerList()
        local list = {}
        for _, p in pairs(game.Players:GetPlayers()) do
            if p ~= Player then
                table.insert(list, p.DisplayName .. " (@" .. p.Name .. ")")
            end
        end
        if #list == 0 then
            table.insert(list, "ไม่มีผู้เล่นอื่นในห้อง")
        end
        return list
    end

    local selectedPlayerStr = ""

    local PlayerDropdown = UniversalTab:CreateDropdown({
       Name = "เลือกผู้เล่นที่ต้องการวาร์ปไปหา (Select Player)",
       Options = GetPlayerList(),
       CurrentOption = GetPlayerList()[1] or "ไม่มีผู้เล่นอื่นในห้อง",
       MultipleOptions = false,
       Flag = "PlayerTeleportDropdown",
       Callback = function(Option)
           if type(Option) == "table" then
               selectedPlayerStr = Option[1] or ""
           else
               selectedPlayerStr = Option or ""
           end
       end,
    })

    UniversalTab:CreateButton({
       Name = "🔄 อัปเดตรายชื่อผู้เล่น (Refresh Player List)",
       Callback = function()
           PlayerDropdown:Refresh(GetPlayerList())
           Rayfield:Notify({
              Title = "Refreshed!",
              Content = "อัปเดตรายชื่อผู้เล่นในเซิร์ฟเวอร์แล้ว",
              Duration = 2,
              Image = 4483362458,
           })
       end,
    })

    UniversalTab:CreateButton({
       Name = "🌀 วาร์ปไปหาผู้เล่นที่เลือก (Teleport)",
       Callback = function()
           if selectedPlayerStr ~= "" and selectedPlayerStr ~= "ไม่มีผู้เล่นอื่นในห้อง" then
               for _, target in pairs(game.Players:GetPlayers()) do
                   local formattedName = target.DisplayName .. " (@" .. target.Name .. ")"
                   if formattedName == selectedPlayerStr then
                       if target.Character and target.Character:FindFirstChild("HumanoidRootPart") and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
                           Player.Character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
                           Rayfield:Notify({
                              Title = "Teleported!",
                              Content = "วาร์ปไปหา " .. target.DisplayName .. " เรียบร้อยแล้ว!",
                              Duration = 3,
                              Image = 4483362458,
                           })
                           return
                       end
                   end
               end
           else
               Rayfield:Notify({
                  Title = "Error!",
                  Content = "กรุณาเลือกผู้เล่นที่ถูกต้องก่อนกดวาร์ป",
                  Duration = 3,
                  Image = 4483362458,
               })
           end
       end,
    })

    ----------------------------------------------------------------------
    -- [TAB 4] หมวดหมู่: สร้างความโกลาหล (Chaos & Troll)
    ----------------------------------------------------------------------
    local ChaosTab = Window:CreateTab("สร้างความโกลาหลไม่แนะนำ (Chaos not recommend!)", 4483362458)

    ChaosTab:CreateSection("ระบบระเบิดแมพ & ของกระจาย")

    ChaosTab:CreateButton({
       Name = "💣 ระเบิดบล็อก/ของทั้งหมดกลางแมพ (Explode All Items)",
       Callback = function()
           local count = 0
           for _, item in pairs(workspace:GetDescendants()) do
               if item:IsA("BasePart") and not item:IsDescendantOf(Player.Character) then
                   local exp = Instance.new("Explosion")
                   exp.Position = item.Position
                   exp.BlastRadius = 15
                   exp.BlastPressure = 500000
                   exp.Parent = workspace
                   count = count + 1
               end
           end
           Rayfield:Notify({
              Title = "Chaos Released!",
              Content = "จุดระเบิดไอเทมในแมพไปทั้งหมด " .. tostring(count) .. " จุด!",
              Duration = 3,
              Image = 4483362458,
           })
       end,
    })

    ChaosTab:CreateButton({
       Name = "💥 สร้างระเบิดยักษ์กลางแมพ (Mega Center Blast)",
       Callback = function()
           local centerPos = Vector3.new(0, 10, 0)
           local exp = Instance.new("Explosion")
           exp.Position = centerPos
           exp.BlastRadius = 150
           exp.BlastPressure = 1000000
           exp.Parent = workspace

           Rayfield:Notify({
              Title = "MEGA BLAST!",
              Content = "เกิดระเบิดยักษ์ขึ้นที่ศูนย์กลางแมพ!",
              Duration = 3,
              Image = 4483362458,
           })
       end,
    })

    local auraExplosion = false
    ChaosTab:CreateToggle({
       Name = "🔥 ระเบิดสแปมรอบตัวเรา (Explosion Aura)",
       CurrentValue = false,
       Flag = "ExplosionAuraToggle",
       Callback = function(Value)
           auraExplosion = Value
       end,
    })

    task.spawn(function()
        while true do
            if auraExplosion and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
                local hrp = Player.Character.HumanoidRootPart
                local exp = Instance.new("Explosion")
                exp.Position = hrp.Position + Vector3.new(math.random(-10,10), math.random(-2,5), math.random(-10,10))
                exp.BlastRadius = 10
                exp.BlastPressure = 200000
                exp.Parent = workspace
            end
            task.wait(0.2)
        end
    end)

    ----------------------------------------------------------------------
    -- [TAB 5] หมวดหมู่: อื่น ๆ
    ----------------------------------------------------------------------
    local OtherTab = Window:CreateTab("อื่น ๆ", 4483362458)

    OtherTab:CreateButton({
       Name = "🔄 เข้าเซิร์ฟเวอร์เดิมใหม่ (Rejoin Server)",
       Callback = function()
           game:GetService("TeleportService"):Teleport(game.PlaceId, Player)
       end,
    })

    OtherTab:CreateButton({
       Name = "เปิดเมนูบิน (Fly GUI V3)",
       Callback = function()
           loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.txt"))()
       end,
    })

    OtherTab:CreateButton({
       Name = "เปิดใช้ Infinite Yield",
       Callback = function()
           loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
       end,
    })
end

-- ดูทำไม
SubmitBtn.MouseButton1Click:Connect(function()
    local Success, OnlineKey = pcall(function()
        return game:HttpGet("https://pastebin.com/raw/Cu4Bm2su"):gsub("%s+", "")
    end)

    if Success and KeyInput.Text == OnlineKey then
        LoadKaiYangHub()
    else
        Player:Kick("key ไม่ถูกต้อง invalid key🥀")
    end
end)

-- ไม่ต้องเ ส ร่ อ
CloseBtn.MouseButton1Click:Connect(function()
    Player:Kick("key system gui close🥀")
end)

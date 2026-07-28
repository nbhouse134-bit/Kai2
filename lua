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

local Player = game.Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- ตัวแปรเก็บค่า WalkSpeed & JumpPower
local currentSpeed = 16
local currentJump = 50
local noclipEnabled = false

-- ปรับ WalkSpeed
PlayerTab:CreateInput({
   Name = "ปรับความเร็ว (WalkSpeed)",
   PlaceholderText = "ใส่ตัวเลข เช่น 16, 50, 100",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
       local speed = tonumber(Text)
       if speed then
           currentSpeed = speed
           if Player.Character and Player.Character:FindFirstChild("Humanoid") then
               Player.Character.Humanoid.WalkSpeed = speed
           end
       end
   end,
})

-- ปรับ JumpPower
PlayerTab:CreateInput({
   Name = "ปรับพลังกระโดด (JumpPower)",
   PlaceholderText = "ใส่ตัวเลข เช่น 50, 100, 200",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
       local jump = tonumber(Text)
       if jump then
           currentJump = jump
           if Player.Character and Player.Character:FindFirstChild("Humanoid") then
               local humanoid = Player.Character.Humanoid
               humanoid.UseJumpPower = true
               humanoid.JumpPower = jump
           end
       end
   end,
})

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

-- ระบบจำค่าความเร็ว/การกระโดด เมื่อตัวละครเกิดใหม่
Player.CharacterAdded:Connect(function(character)
   local humanoid = character:WaitForChild("Humanoid")
   task.wait(0.5)
   humanoid.WalkSpeed = currentSpeed
   humanoid.UseJumpPower = true
   humanoid.JumpPower = currentJump
end)

----------------------------------------------------------------------
-- [TAB 3] หมวดหมู่: อื่น ๆ (เพิ่มใหม่)
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
       loadstring(game:HttpGet('https://raw.githubusercontent.com/DarkNetworks/Infinite-Yield/main/latest.lua'))()
   end,
})

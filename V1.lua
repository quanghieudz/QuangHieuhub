-- [[ QUANG HIỂU HUB - FULL SOURCE V4 ULTIMATE ]]
-- Hướng dẫn: Dán toàn bộ code này lên GitHub để làm link Loadstring

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Khởi tạo Menu Trắng Đen
local Window = Rayfield:CreateWindow({
    Name = "QUANG HIỂU HUB - BLACK & WHITE",
    LoadingTitle = "MARU FAST ATTACK LOADING...",
    ConfigurationSaving = {Enabled = false},
    Theme = "Dark"
})

-- Custom màu B&W (Trắng Đen) cho ngầu
Rayfield.Settings.Theme = {
    TextColor = Color3.fromRGB(255, 255, 255),
    Background = Color3.fromRGB(0, 0, 0),
    AccentColor = Color3.fromRGB(200, 200, 200),
    TopBar = Color3.fromRGB(20, 20, 20)
}

local lp = game.Players.LocalPlayer
local lg = game:GetService("Lighting")

-- =========================================================
-- [HỆ THỐNG MARU FAST ATTACK - ĐÁNH SIÊU TỐC]
-- =========================================================
local CombatFramework = require(lp.PlayerScripts:WaitForChild("CombatFramework"))
local CombatFrameworkR = getupvalues(CombatFramework)[2]

local function GetCombatController()
    return CombatFrameworkR.activeController
end

task.spawn(function()
    while task.wait() do
        pcall(function()
            local AC = GetCombatController()
            if AC and AC.active then
                local hum = lp.Character:FindFirstChildOfClass("Humanoid")
                for _, anim in pairs(hum:GetPlayingAnimationTracks()) do
                    if anim.Name:lower():find("attack") or anim.Name:lower():find("slash") then
                        anim:Stop()
                    end
                end
                AC.hitboxMagnitude = 60
                AC.attack()
                AC.waitTimer = 0 -- Logic Maru: Xóa cooldown
            end
        end)
    end
end)

-- Hàm tự cầm vũ khí
local function EquipMelee()
    for _, tool in pairs(lp.Backpack:GetChildren()) do
        if tool:IsA("Tool") and (tool.ToolTip == "Melee" or tool.ToolTip == "Sword") then
            lp.Character.Humanoid:EquipTool(tool) break
        end
    end
end

-- =========================================================
-- [TAB CHÍNH: UP TỘC V4]
-- =========================================================
local TabV4 = Window:CreateTab("Up Tộc V4", 4483345998)

-- Check Trăng
local MoonLabel = TabV4:CreateLabel("🌕 Check Moon: Loading...")
task.spawn(function()
    while true do
        local p = lg:GetAttribute("MoonPhase") or 0
        MoonLabel:Set("🌕 Trạng thái trăng: " .. p .. "/8")
        task.wait(2)
    end
end)

TabV4:CreateLabel("--- CHUẨN BỊ (BEFORE TRIAL) ---")

-- Auto Tích Nộ (Rage)
_G.AutoRage = false
TabV4:CreateToggle({
    Name = "Auto Full Rage (Tích Nộ Siêu Tốc)",
    CurrentValue = false,
    Callback = function(v)
        _G.AutoRage = v
        task.spawn(function()
            while _G.AutoRage do
                pcall(function()
                    local energy = lp.Data:FindFirstChild("RaceEnergy") and lp.Data.RaceEnergy.Value or 0
                    if energy < 100 then
                        EquipMelee()
                        for _, e in pairs(workspace.Enemies:GetChildren()) do
                            if e:FindFirstChild("Humanoid") and e.Humanoid.Health > 0 then
                                lp.Character.HumanoidRootPart.CFrame = e.HumanoidRootPart.CFrame * CFrame.new(0, 8, 0)
                                break
                            end
                        end
                    else
                        Rayfield:Notify({Title="XONG!", Content="Nộ đã đầy 100%!", Duration=5})
                        _G.AutoRage = false
                    end
                end)
                task.wait()
            end
        end)
    end
})

-- Gạt Cần
TabV4:CreateButton({
    Name = "Pull Lever (Gạt Cần)", 
    Callback = function()
        for _, v in pairs(workspace:GetDescendants()) do
            if v.Name == "Lever" and v:FindFirstChild("ClickDetector") then fireclickdetector(v.ClickDetector) end
        end
    end
})

TabV4:CreateLabel("--- TRONG THỬ THÁCH (TRIAL) ---")

-- Auto Trial Combat
_G.AutoTrialCombat = false
TabV4:CreateToggle({
    Name = "Auto Trial Combat (Zombie/SB/Boss)",
    CurrentValue = false,
    Callback = function(v)
        _G.AutoTrialCombat = v
        task.spawn(function()
            while _G.AutoTrialCombat do
                pcall(function()
                    EquipMelee()
                    local target = nil
                    for _, e in pairs(workspace.Enemies:GetChildren()) do
                        if e:FindFirstChild("Humanoid") and e.Humanoid.Health > 0 then target = e break end
                    end
                    if not target then
                        for _, sb in pairs(workspace:GetChildren()) do
                            if sb.Name:find("Sea Beast") then target = sb break end
                        end
                    end
                    if target then
                        local off = (target.Name:find("Sea")) and 30 or 8
                        lp.Character.HumanoidRootPart.CFrame = target.HumanoidRootPart.CFrame * CFrame.new(0, off, 0)
                    end
                end)
                task.wait()
            end
        end)
    end
})

-- Kết thúc Trial
TabV4:CreateButton({
    Name = "Teleport Gear (Lấy Bánh Răng)", 
    Callback = function()
        lp.Character.HumanoidRootPart.CFrame = CFrame.new(28892, 14925, 102)
        task.wait(0.5)
        lp.Character.HumanoidRootPart.CFrame = CFrame.new(28485, 15000, -31)
    end
})

TabV4:CreateLabel("--- TIỆN ÍCH ---")

-- Teddy Hop
TabV4:CreateButton({
    Name = "Teddy Hop (Nhảy Server Tìm Trăng)",
    Callback = function() 
        local hs = game:GetService("HttpService")
        local ts = game:GetService("TeleportService")
        local servers = hs:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"))
        for _, s in pairs(servers.data) do
            if s.playing < s.maxPlayers and s.id ~= game.JobId then
                ts:TeleportToPlaceInstance(game.PlaceId, s.id) break
            end
        end
    end
})

Rayfield:Notify({Title = "QUANG HIỂU HUB", Content = "Script Maru Style Đã Sẵn Sàng!", Duration = 5})

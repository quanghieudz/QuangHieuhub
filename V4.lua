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

-- Custom màu B&W cho ngầu
Rayfield.Settings.Theme = {
    TextColor = Color3.fromRGB(255, 255, 255),
    Background = Color3.fromRGB(0, 0, 0),
    AccentColor = Color3.fromRGB(200, 200, 200),
    TopBar = Color3.fromRGB(20, 20, 20)
}

local lp = game.Players.LocalPlayer
local rs = game:GetService("RunService")
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
local

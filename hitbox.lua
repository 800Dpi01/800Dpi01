local Starlight = loadstring(game:HttpGet("https://raw.githubusercontent.com/800Dpi01/800Dpi01/refs/heads/main/UILIBRARY.LUA"))()
local win = Starlight:CreateWindow({
    Name = "Blade Ball UI",
    Subtitle = "Hitbox / Spinbot",
    Icon = 0,
    LoadingEnabled = false,
})

win:CreateHomeTab({ Backdrop = 78881404248017 })

local mainSection = win:CreateTabSection("Main")

-- Chỉ tạo 1 tab Hitbox
local hitboxTab = mainSection:CreateTab({
    Name = "Hitbox",
    Columns = 1,
    Icon = 0,
}, "hitbox_tab")

local hitboxGroup = hitboxTab:CreateGroupbox({
    Name = "Hitbox Settings",
    Column = 1,
}, "hitbox_group")

-- Các control trong Hitbox tab
hitboxGroup:CreateToggle({
    Name = "Hitbox Expander",
    CurrentValue = false,
    Callback = function(state)
        getgenv().HitboxExpander = state
    end,
}, "hitbox_enable")

hitboxGroup:CreateSlider({
    Name = "Hitbox Size",
    Range = {5, 50},
    CurrentValue = 10,
    Increment = 1,
    Suffix = "",
    Callback = function(v)
        getgenv().HitboxSize = v
    end,
}, "hitbox_size")

hitboxGroup:CreateSlider({
    Name = "Refresh Time (sec)",
    Range = {1, 10},
    CurrentValue = 5,
    Increment = 1,
    Suffix = "s",
    Callback = function(v)
        getgenv().HitboxRefreshTime = v
    end,
}, "hitbox_refresh")

hitboxGroup:CreateLabel({ Name = "Hitbox Mode" }, "hitbox_mode_label")
    :AddDropdown({
        Options = {"Dynamic", "Static Head", "Static Body"},
        CurrentOption = "Dynamic",
        MultipleOptions = false,
        Callback = function(selected)
            getgenv().HitboxMode = selected[1] or "Dynamic"
        end,
    }, "hitbox_mode_dropdown")

hitboxGroup:CreateToggle({
    Name = "ESP Box",
    CurrentValue = false,
    Callback = function(state)
        getgenv().HitboxESP = state
        if not state then
            for _, box in pairs(_G.HitboxESPBoxes or {}) do
                pcall(function() box:Destroy() end)
            end
            _G.HitboxESPBoxes = {}
        end
    end,
}, "hitbox_esp")

-- Spinbot section (có thể để trong cùng tab hoặc tạo tab riêng nếu muốn)
local spinbotGroup = hitboxTab:CreateGroupbox({
    Name = "Spinbot",
    Column = 1,
}, "spinbot_group")

spinbotGroup:CreateToggle({
    Name = "Enable Spinbot",
    CurrentValue = false,
    Callback = function(state)
        getgenv().Spinbot = state
    end,
}, "spinbot_enable")

spinbotGroup:CreateSlider({
    Name = "Spin Speed",
    Range = {5, 50},
    CurrentValue = 20,
    Increment = 1,
    Suffix = "",
    Callback = function(v)
        getgenv().SpinSpeed = v
    end,
}, "spinbot_speed")

-- Biến global
getgenv().HitboxExpander = false
getgenv().HitboxSize = 10
getgenv().HitboxRefreshTime = 5
getgenv().HitboxESP = false
getgenv().HitboxMode = "Dynamic"
getgenv().Spinbot = false
getgenv().SpinSpeed = 20

_G.HitboxESPBoxes = _G.HitboxESPBoxes or {}

-- ─── Hitbox logic ───────────────────────────────────────
task.spawn(function()
    while true do
        if getgenv().HitboxExpander then
            for _, player in ipairs(game.Players:GetPlayers()) do
                if player ~= game.Players.LocalPlayer
                    and player.Character
                    and player.Character:FindFirstChildWhichIsA("Humanoid")
                    and player.Character:FindFirstChild("HumanoidRootPart") then

                    local root = player.Character.HumanoidRootPart
                    local target = root

                    if getgenv().HitboxMode == "Static Head" then
                        target = player.Character:FindFirstChild("Head") or root
                    elseif getgenv().HitboxMode == "Static Body" then
                        target = root
                    end

                    target.CanCollide = false
                    target.Size = Vector3.new(getgenv().HitboxSize, getgenv().HitboxSize, getgenv().HitboxSize)

                    if getgenv().HitboxESP then
                        local box = _G.HitboxESPBoxes[player]
                        if not box or not box.Parent then
                            box = Instance.new("SelectionBox")
                            box.Name = "HitboxESP"
                            box.LineThickness = 0.05
                            box.Color3 = Color3.fromRGB(255, 0, 0)
                            box.Adornee = target
                            box.Parent = target
                            _G.HitboxESPBoxes[player] = box
                        end
                    end
                end
            end
        else
            -- Cleanup khi tắt
            for plr, box in pairs(_G.HitboxESPBoxes) do
                pcall(function() box:Destroy() end)
                _G.HitboxESPBoxes[plr] = nil
            end
        end

        task.wait(getgenv().HitboxRefreshTime)
    end
end)

-- ─── Spinbot logic ───────────────────────────────────────
task.spawn(function()
    while true do
        if getgenv().Spinbot and game.Players.LocalPlayer.Character then
            local hrp = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                hrp.CFrame = hrp.CFrame * CFrame.Angles(0, math.rad(getgenv().SpinSpeed), 0)
            end
        end
        task.wait(0.03)
    end
end)

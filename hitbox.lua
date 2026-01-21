-- 1. Load thư viện Starlight (betalib.lua của Altura)
local Starlight = loadstring(game:HttpGet("https://raw.githubusercontent.com/azureblueday/altura/refs/heads/main/betalib.lua"))()

-- 2. Tạo window chính (dashboard)
local win = Starlight:CreateWindow({
    Name = "Blade Ball UI",
    Subtitle = "Altura / Starlight Example",
    Icon = 0,
    LoadingEnabled = false,
})

-- 3. Dashboard mặc định (home tab)
win:CreateHomeTab({
    Backdrop = 78881404248017, -- có thể đổi asset id khác nếu muốn
})

-- 4. Tạo một TabSection bên sidebar
local mainSection = win:CreateTabSection("Main")

-- 5. Tạo tab "Catching" trong Section đó
local catchTab = mainSection:CreateTab({
    Name = "Catching",
    Columns = 1,
    Icon = 0,
}, "catch_tab")

-- 6. Groupbox trong tab Catching
local catchGroup = catchTab:CreateGroupbox({
    Name = "Catching Features",
    Column = 1,
}, "catch_group")

-- 7. Toggle: Magnets
catchGroup:CreateToggle({
    Name = "Magnets",
    CurrentValue = false,
    Callback = function(state)
        print("Magnets:", state)
        -- TODO: code auto catch / magnet của bạn
    end,
}, "magnets_toggle")

-- 8. Slider: Magnet Radius
catchGroup:CreateSlider({
    Name = "Magnet Radius",
    Range = {0, 25},
    CurrentValue = 10,
    Increment = 1,
    Suffix = "",
    Callback = function(v)
        print("Radius:", v)
        -- TODO: chỉnh bán kính bắt bóng ở đây
    end,
}, "magnet_radius")

-- 9. Dropdown: Catching Mode
local modeLabel = catchGroup:CreateLabel({
    Name = "Catching Mode",
}, "catch_mode_label")

modeLabel:AddDropdown({
    Options = {"Regular", "Advanced"},
    CurrentOption = "Regular",
    MultipleOptions = false,
    Callback = function(selectedList)
        local selected = selectedList[1]
        print("Mode:", selected)
        -- TODO: đổi mode farm ở đây
    end,
}, "catch_mode_dropdown")

-- 10. Keybind: Activate Catch
local bindLabel = catchGroup:CreateLabel({
    Name = "Activate Catch",
}, "catch_bind_label")

bindLabel:AddBind({
    CurrentValue = "F",
    HoldToInteract = false,
    SyncToggleState = false,
    Callback = function(isDown)
        print("Keybind pressed, state:", isDown)
        -- TODO: kích hoạt kỹ năng / auto catch ở đây
    end,
}, "catch_bind")

-- 11. ColorPicker: Hitbox Color
local colorLabel = catchGroup:CreateLabel({
    Name = "Hitbox Color",
}, "hitbox_color_label")

colorLabel:AddColorPicker({
    CurrentValue = Color3.fromRGB(255, 100, 100),
    Transparency = 0,
    Callback = function(c3, alpha)
        print("Color:", c3, "alpha:", alpha)
        -- TODO: đổi màu hitbox ở đây
    end,
}, "hitbox_color_picker")

-- 12. Groupbox: Hitbox Expander / ESP
local hitboxGroup = catchTab:CreateGroupbox({
    Name = "Hitbox Expander",
    Column = 1,
}, "hitbox_group")

hitboxGroup:CreateToggle({
    Name = "Enable Hitbox Expander",
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

hitboxGroup:CreateToggle({
    Name = "ESP Box",
    CurrentValue = false,
    Callback = function(state)
        getgenv().HitboxESP = state

        -- Tắt/bật ESP ngay lập tức không cần đợi vòng lặp
        if not _G.HitboxESPBoxes then return end

        if state == false then
            for plr, box in pairs(_G.HitboxESPBoxes) do
                if box then
                    box:Destroy()
                end
                _G.HitboxESPBoxes[plr] = nil
            end
        end
    end,
}, "hitbox_esp")

-- 12. Tính năng mở rộng hitbox (Hitbox Expander)
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

getgenv().HitboxExpander = false
getgenv().HitboxSize = 10 -- Change To Whatever
getgenv().HitboxRefreshTime = 5
getgenv().HitboxESP = false

_G.HitboxESPBoxes = {}

task.spawn(function()
    while true do
        if getgenv().HitboxExpander then
            for _, Player in ipairs(Players:GetPlayers()) do
                if Player.UserId ~= LocalPlayer.UserId
                    and Player.Character
                    and Player.Character:FindFirstChildOfClass("Humanoid")
                    and Player.Character:FindFirstChildOfClass("Humanoid").RootPart then

                    local PlayerHumanoid = Player.Character:FindFirstChildOfClass("Humanoid")
                    local PlayerRootPart = PlayerHumanoid.RootPart

                    PlayerRootPart.CanCollide = false
                    PlayerRootPart.Size = Vector3.new(getgenv().HitboxSize, getgenv().HitboxSize, getgenv().HitboxSize)

                    if getgenv().HitboxESP then
                        local box = _G.HitboxESPBoxes[Player]
                        if not box or not box.Parent then
                            box = Instance.new("SelectionBox")
                            box.Name = "HitboxESP"
                            box.LineThickness = 0.05
                            box.Color3 = Color3.fromRGB(255, 0, 0)
                            box.Adornee = PlayerRootPart
                            box.Parent = PlayerRootPart
                            _G.HitboxESPBoxes[Player] = box
                        else
                            box.Adornee = PlayerRootPart
                        end
                    else
                        if _G.HitboxESPBoxes[Player] then
                            _G.HitboxESPBoxes[Player]:Destroy()
                            _G.HitboxESPBoxes[Player] = nil
                        end
                    end
                end
            end
        else
            -- Tắt ESP khi HitboxExpander off
            for plr, box in pairs(_G.HitboxESPBoxes) do
                if box then
                    box:Destroy()
                end
                _G.HitboxESPBoxes[plr] = nil
            end
        end

        task.wait(getgenv().HitboxRefreshTime)
    end
end)

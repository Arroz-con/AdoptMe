local Player = game:GetService("Players").LocalPlayer
local VI = game:GetService("VirtualInputManager")


local Module = {}

function Module.ClickGuiButton(button: number)
    task.wait() -- gives it time for button
    VI:SendMouseButtonEvent(button.AbsolutePosition.X + 60, button.AbsolutePosition.Y + 60, 0, true, game, 1)
    task.wait()
    VI:SendMouseButtonEvent(button.AbsolutePosition.X + 60, button.AbsolutePosition.Y + 60, 0, false, game, 1)
    task.wait()
end


function Module.FindButtonAndClick(text: string)
    task.wait() -- gives it time for button
    if not Player.PlayerGui.DialogApp.Dialog.NormalDialog.Buttons.ButtonTemplate then return end
    for _, v in pairs(Player.PlayerGui.DialogApp.Dialog.NormalDialog.Buttons:GetDescendants()) do
        if v.Name == "TextLabel" then
            if v.Text == text then
                Module.ClickGuiButton(v.Parent.Parent)
                -- firesignal(v.Parent.Parent.MouseButton1Click)
                break
            end
        end
    end
end


-- local function FireButton(PassOn)
--     task.wait() -- gives it time for button
--     if not Player.PlayerGui.DialogApp.Dialog.NormalDialog.Buttons.ButtonTemplate then return end
--     for i, v in pairs(Player.PlayerGui.DialogApp.Dialog.NormalDialog.Buttons:GetDescendants()) do
--         if v.Name == "TextLabel" then
--             if v.Text == PassOn then
--                 clickGuiButton(v.Parent.Parent)
--                 -- firesignal(v.Parent.Parent.MouseButton1Click)
--                 break
--             end
--         end
--     end
-- end

return Module
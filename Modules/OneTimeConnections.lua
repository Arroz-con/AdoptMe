local Bypass = require(game.ReplicatedStorage:WaitForChild("Fsys")).load
local Player = game:GetService("Players").LocalPlayer

local NewsAppConnection
local DialogConnection
local RoleChooserDialogConnection
local RobuxProductDialogConnection
local banMessageConnection
local DailyClaimConnection
local ChatConnection
local CharConn
local DailyBoolean = true
local DailyRewardTable = {[9] = "reward_1", [30] = "reward_2", [90] = "reward_3", [140] = "reward_4", [180] = "reward_5", [210] = "reward_6", [230] = "reward_7",
[280] = "reward_8", [300] = "reward_9", [320] = "reward_10", [360] = "reward_11", [400] = "reward_12", [460] = "reward_13", [500] = "reward_14",
[550] = "reward_15", [600] = "reward_16", [660] = "reward_17"}
local DailyRewardTable2 = {[9] = "reward_1", [65] = "reward_2", [120] = "reward_3", [180] = "reward_4", [225] = "reward_5", [280] = "reward_6", [340] = "reward_7",
[400] = "reward_8", [450] = "reward_9", [520] = "reward_10", [600] = "reward_11", [660] = "reward_12"}

local mouseClick = loadstring(game:HttpGet(("https://raw.githubusercontent.com/Arroz-con/AdoptMe/main/Modules/MouseClick.lua")))()

local Module = {}

-- ChatConnection = Player.PlayerGui.Chat.Frame.ChatChannelParentFrame["Frame_MessageLogDisplay"].Scroller.DescendantAdded:Connect(function(ChatChild)
-- 	if ChatChild.Name == "TextButton" then
-- 		task.wait(1)
-- 		firesignal(Player.PlayerGui.TopbarApp.TopBarContainer.ChatVisible.MouseButton1Click)
-- 		ChatConnection:Disconnect()
-- 	end
-- end)

--// Main Adopt me Screen (Play! Button)
NewsAppConnection = Player.PlayerGui.NewsApp:GetPropertyChangedSignal("Enabled"):Connect(function()
    if Player.PlayerGui.NewsApp.Enabled then
        local AbsPlay = Player.PlayerGui.NewsApp.EnclosingFrame.MainFrame.Contents.PlayButton
        mouseClick.ClickGuiButton(AbsPlay)
        --firesignal(Player.PlayerGui.NewsApp.EnclosingFrame.MainFrame.Contents.PlayButton.MouseButton1Click)
        NewsAppConnection:Disconnect()
    end
end)

if Player.PlayerGui.NewsApp.Enabled then
    local AbsPlay = Player.PlayerGui.NewsApp.EnclosingFrame.MainFrame.Contents.PlayButton
    mouseClick.ClickGuiButton(AbsPlay)
    --firesignal(Player.PlayerGui.NewsApp.EnclosingFrame.MainFrame.Contents.PlayButton.MouseButton1Click)
    NewsAppConnection:Disconnect()
end


banMessageConnection = Player.PlayerGui.DialogApp.Dialog.NormalDialog:GetPropertyChangedSignal("Visible"):Connect(function()
    if Player.PlayerGui.DialogApp.Dialog.NormalDialog.Visible then
        Player.PlayerGui.DialogApp.Dialog.NormalDialog:WaitForChild("Info")
        Player.PlayerGui.DialogApp.Dialog.NormalDialog.Info:WaitForChild("TextLabel")
        Player.PlayerGui.DialogApp.Dialog.NormalDialog.Info.TextLabel:GetPropertyChangedSignal("Text"):Connect(function()
            if Player.PlayerGui.DialogApp.Dialog.NormalDialog.Info.TextLabel.Text:match("ban") then
                mouseClick.FindButtonAndClick("Okay")
                banMessageConnection:Disconnect()
            end
        end)
    end
end)

if Player.PlayerGui.DialogApp.Dialog.NormalDialog.Visible then
    if Player.PlayerGui.DialogApp.Dialog.NormalDialog.Info.TextLabel.Text:match("ban") then
        mouseClick.FindButtonAndClick("Okay")
        banMessageConnection:Disconnect()
    end
end

--// Clicks on baby button
RoleChooserDialogConnection = Player.PlayerGui.DialogApp.Dialog.RoleChooserDialog:GetPropertyChangedSignal("Visible"):Connect(function()
    task.wait()
    if Player.PlayerGui.DialogApp.Dialog.RoleChooserDialog.Visible then
        firesignal(Player.PlayerGui.DialogApp.Dialog.RoleChooserDialog.Baby.MouseButton1Click)
        RoleChooserDialogConnection:Disconnect()
    end
end)

if Player.PlayerGui.DialogApp.Dialog.RoleChooserDialog.Visible then
    firesignal(Player.PlayerGui.DialogApp.Dialog.RoleChooserDialog.Baby.MouseButton1Click)
    RoleChooserDialogConnection:Disconnect()
end

--// Clicks no robux product button
RobuxProductDialogConnection = Player.PlayerGui.DialogApp.Dialog.RobuxProductDialog:GetPropertyChangedSignal("Visible"):Connect(function()
    task.wait()
    if Player.PlayerGui.DialogApp.Dialog.RobuxProductDialog.Visible then
        for _, v in pairs(Player.PlayerGui.DialogApp.Dialog.RobuxProductDialog.Buttons:GetDescendants()) do
            if v.Name == "TextLabel" then
                if  v.Text == "No Thanks" then
                    mouseClick.ClickGuiButton(v.Parent.Parent) -- no thanks button
                    DailyBoolean = false
                    RobuxProductDialogConnection:Disconnect()
                end
            end
        end     			
    end
end)

local function GrabDailyReward()
    local Daily = Bypass("ClientData").get("daily_login_manager")
    if Daily.prestige % 2 == 0 then
        for i, v in pairs(DailyRewardTable) do
            if i < Daily.stars or i == Daily.stars then
                if not Daily.claimed_star_rewards[v] then
                    Bypass("RouterClient").get("DailyLoginAPI/ClaimStarReward"):InvokeServer(v)
                end
            end
        end
    else
        for i, v in pairs(DailyRewardTable2) do
            if i < Daily.stars or i == Daily.stars then
                if not Daily.claimed_star_rewards[v] then
                    Bypass("RouterClient").get("DailyLoginAPI/ClaimStarReward"):InvokeServer(v)
                end
            end
        end
    end
end

DailyClaimConnection = Player.PlayerGui.DailyLoginApp:GetPropertyChangedSignal("Enabled"):Connect(function()
    repeat task.wait() until Player.PlayerGui.DailyLoginApp.Enabled
    if Player.PlayerGui.DailyLoginApp.Enabled then
        task.wait()
        if Player.PlayerGui.DailyLoginApp.Frame.Visible then
            for i, v in pairs(Player.PlayerGui.DailyLoginApp.Frame.Body.Buttons:GetDescendants()) do
                if v.Name == "TextLabel" then
                    if v.Text == "CLOSE" then
                        mouseClick.ClickGuiButton(v.Parent.Parent) -- Close button
                        task.wait(1)
                        GrabDailyReward()
                        DailyClaimConnection:Disconnect()
                    elseif v.Text == "CLAIM!" then
                        mouseClick.ClickGuiButton(v.Parent.Parent) -- claim button
                        mouseClick.ClickGuiButton(v.Parent.Parent) -- close button
                        -- firesignal(v.Parent.Parent.MouseButton1Click) --claim button
                        -- firesignal(v.Parent.Parent.MouseButton1Click) --close button
                        task.wait(1)
                        GrabDailyReward()
                        DailyClaimConnection:Disconnect()
                    end
                end
            end
        end
    end
end)

local Char = Player.Character or Player.CharacterAdded:Wait()
CharConn = Char.ChildAdded:Connect(function(HRPChild)
    if HRPChild.Name == "HumanoidRootPart" then
        repeat task.wait() until not DailyBoolean
        Bypass("RouterClient").get("TeamAPI/ChooseTeam"):InvokeServer("Babies", true)
        CharConn:Disconnect()
    end
end)

return Module
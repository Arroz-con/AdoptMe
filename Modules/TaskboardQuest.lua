local Bypass = require(game.ReplicatedStorage:WaitForChild("Fsys")).load
local ClaimRemote = Bypass("RouterClient").get("QuestAPI/ClaimQuest")
local RerollRemote = Bypass("RouterClient").get("QuestAPI/RerollQuest")
local NewTaskBool = true
local NewClaimBool = true
local NeonTable = {["neon_fusion"] = true, ["mega_neon_fusion"] = true}
local ClaimTable = {["hatch_three_eggs"] = {3}, ["fully_age_three_pets"] = {3}, ["make_two_trades"] = {2}, ["equip_two_accessories"] = {2},
["buy_three_furniture_items_with_friends_coop_budget"] = {3}, ["buy_five_furniture_items"] = {5}, ["buy_fifteen_furniture_items"] = {15},
["play_as_a_baby_for_twenty_five_minutes"] = {1500}, ["play_for_thirty_minutes"] = {1800}}


local Module = {}

local function QuestCount()
    local Count = 0
    for _, v in pairs(Bypass("ClientData").get("quest_manager")["quests_cached"]) do
        if v["entry_name"]:match("teleport") or v["entry_name"]:match("navigate") or v["entry_name"]:match("nav") or v["entry_name"]:match("gosh_2022_sick") then
            Count = Count + 0
        else
            Count = Count + 1
        end
    end
    return Count
end

local function ReRollCount()
    for _, v in pairs(Bypass("ClientData").get("quest_manager")["daily_quest_data"]) do
        if v == 1 or v == 0 then
            return v
        end
    end
end

local function NewTask()
    NewTaskBool = false
    for _, v in pairs(Bypass("ClientData").get("quest_manager")["quests_cached"]) do
        if v["entry_name"]:match("teleport") or v["entry_name"]:match("navigate") or v["entry_name"]:match("nav") or v["entry_name"]:match("gosh_2022_sick") then
            task.wait()
        elseif v["entry_name"]:match("tutorial") then
            ClaimRemote:InvokeServer(v["unique_id"])
            task.wait()
        else
            if QuestCount() == 1 then
                if NeonTable[v["entry_name"]] then
                    ClaimRemote:InvokeServer(v["unique_id"])
                    task.wait()
                elseif not NeonTable[v["entry_name"]] and ReRollCount() >= 1 then
                    RerollRemote:FireServer(v["unique_id"])
                    task.wait()
                end
            elseif QuestCount() > 1 then
                if NeonTable[v["entry_name"]] then
                    ClaimRemote:InvokeServer(v["unique_id"])
                    task.wait()
                elseif not NeonTable[v["entry_name"]] and ReRollCount() >= 1 then
                    RerollRemote:FireServer(v["unique_id"])
                    task.wait()
                elseif not NeonTable[v["entry_name"]] and ReRollCount() <= 0 then
                    ClaimRemote:InvokeServer(v["unique_id"])
                    task.wait()
                end
            end
        end
    end
    task.wait(1)
    NewTaskBool = true
end

local function NewClaim()
    NewClaimBool = false
    for _, v in pairs(Bypass("ClientData").get("quest_manager")["quests_cached"]) do
        if ClaimTable[v["entry_name"]] then
            if v["steps_completed"] == ClaimTable[v["entry_name"]][1] then
                ClaimRemote:InvokeServer(v["unique_id"])
                task.wait()
            end
        elseif not ClaimTable[v["entry_name"]] and v["steps_completed"] == 1 then
            ClaimRemote:InvokeServer(v["unique_id"])
            task.wait()
        end
    end
    task.wait(1)
    NewClaimBool = true
end

game.Players.LocalPlayer.PlayerGui.QuestIconApp.ImageButton.EventContainer.IsNew:GetPropertyChangedSignal("Position"):Connect(function()
    if NewTaskBool then
        NewTaskBool = false
        Bypass("RouterClient").get("QuestAPI/MarkQuestsViewed"):FireServer()
        NewTask()
    end
end)

game.Players.LocalPlayer.PlayerGui.QuestIconApp.ImageButton.EventContainer.IsClaimable:GetPropertyChangedSignal("Position"):Connect(function()
    if NewClaimBool then
        NewClaimBool = false
        NewClaim()
    end
end)


NewClaim()
task.wait()
NewTask()

return Module
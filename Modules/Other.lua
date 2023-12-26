local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Bypass = require(game.ReplicatedStorage:WaitForChild("Fsys")).load
local Player = game:GetService("Players").LocalPlayer

local module = {}

--// gets the trade license so you can trade legendarys
function module.GetTradeLicense()
    Bypass("RouterClient").get("SettingsAPI/SetBooleanFlag"):FireServer("has_talked_to_trade_quest_npc", true)
    task.wait()
    Bypass("RouterClient").get("TradeAPI/BeginQuiz"):FireServer()
    task.wait(1)
    for _, v in pairs(Bypass('ClientData').get("trade_license_quiz_manager")["quiz"]) do
        Bypass("RouterClient").get("TradeAPI/AnswerQuizQuestion"):FireServer(v["answer"])
    end
end


--// completes the starter tutorial
function module.CompleteStarterTutorial()
    Bypass("LegacyTutorial").cancel_tutorial()
    Bypass("TutorialClient").cancel()
    ReplicatedStorage.API["LegacyTutorialAPI/EquipTutorialEgg"]:FireServer()
    ReplicatedStorage.API["LegacyTutorialAPI/AddTutorialQuest"]:FireServer()
    ReplicatedStorage.API["LegacyTutorialAPI/AddHungryAilmentToTutorialEgg"]:FireServer()
    local function feedStartEgg(SandwichPassOn)
        local Foodid2
        for _, v in pairs(require(ReplicatedStorage.ClientModules.Core.ClientData).get_data()[Player.Name].inventory.food) do
            if v.id == SandwichPassOn then
                Foodid2 = v.unique
                break
            end
        end
        
        ReplicatedStorage.API["ToolAPI/Equip"]:InvokeServer(Foodid2, {["use_sound_delay"] = true})
        task.wait(1)
        ReplicatedStorage.API["PetAPI/ConsumeFoodItem"]:FireServer(Foodid2)
    end

    feedStartEgg("sandwich-default")
    Bypass("RouterClient").get("TeamAPI/ChooseTeam"):InvokeServer("Babies", true)
end

return module
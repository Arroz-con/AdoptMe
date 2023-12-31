getgenv().SETTINGS = {
    PET_TO_BUY = "halloween_2023_dire_stag", -- add pet or egg to buy when bot has no pets/egg left to level

    FOCUS_FARM_AGE_POTION = true,  -- if true, this will only farm 1 pet an keep aging to get aging potions

    ENABLE_AUTO_FARM = true,
    SET_FPS = 3,
    PET_NEON_PRIORITY = true,
    PET_AUTO_FUSION = true,

    ENABLE_TRADE_COLLECTOR = true,
    TRADE_COLLECTOR_NAME = "dudemyblox", -- your account username (case sensitive) that will collect the pets.
    TRADE_LIST = {
        GIFTS_TABLE = {
            "rgb_reward_box",
            "halloween_2023_scarecrow_box",
            "halloween_2022_wolf_box",
            "summerfest_2023_hermit_crab_box",
            "winter_2021_walrus_box",
            "winter_2022_pony_box",
            "lny_2023_moon_bear_box",
            "springfest_2023_duckling_box",
        },
    
        TOYS_TABLE = {
            "paint_2023_colored_hair_spray_sealer",
        },

        -- the pets in here will be traded no matter what age they are
        PETS_TABLE = { 
            "lures_2023_blazing_lion",
            "golden_egg",
            "diamond_egg",
            "mythic_egg",
            "seasia_2023_egg",
            "urban_2023_egg",
            "japan_2022_egg",
            "woodland_2022_woodland_egg",
            "danger_2023_egg",
            "ocean_egg",
            "fossil_egg",
            "april_fools_2023_fool_egg",
        },
    },

    HATCH_EGG_PRIORITY = false,
    HATCH_EGG_PRIORITY_NAMES = {"danger_2023_egg"},
    
    PET_ONLY_PRIORITY = true,
    PET_ONLY_PRIORITY_NAMES = {"halloween_2023_dire_stag"},
}


if not game:IsLoaded() then
    game.Loaded:Wait()
end

if game.PlaceId ~= 920587237 then return end
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local Bypass = require(game.ReplicatedStorage:WaitForChild("Fsys")).load

local UserGameSettings = UserSettings():GetService("UserGameSettings")
local Remote = Bypass("RouterClient").get("HousingAPI/ActivateFurniture")
local VirtualUser = game:GetService("VirtualUser")


local gameSettings = loadstring(game:HttpGet(("https://raw.githubusercontent.com/Arroz-con/AdoptMe/main/Modules/GameSettings.lua")))()
local mouseClick = loadstring(game:HttpGet(("https://raw.githubusercontent.com/Arroz-con/AdoptMe/main/Modules/MouseClick.lua")))()

Player.PlayerGui:WaitForChild("NewsApp")
Player.PlayerGui:WaitForChild("DialogApp")
gameSettings.Settings()

-- calls it, dont delete it
local OnetimeConnections = loadstring(game:HttpGet(("https://raw.githubusercontent.com/Arroz-con/AdoptMe/main/Modules/OneTimeConnections.lua")))()
local taskboardQuest = loadstring(game:HttpGet(("https://raw.githubusercontent.com/Arroz-con/AdoptMe/main/Modules/TaskboardQuest.lua")))()

local fusionPet = loadstring(game:HttpGet(("https://raw.githubusercontent.com/Arroz-con/AdoptMe/main/Modules/FusionPets.lua")))()
local other = loadstring(game:HttpGet(("https://raw.githubusercontent.com/Arroz-con/AdoptMe/main/Modules/Other.lua")))()
local inventoryDB = Bypass("InventoryDB")
local rarity = loadstring(game:HttpGet(("https://raw.githubusercontent.com/Arroz-con/AdoptMe/main/Modules/Rarity.lua")))()



-- Player.PlayerGui.DialogApp.Dialog.ChildAdded:Connect(function(NormalDialogChild)
--     if NormalDialogChild.Name == "NormalDialog" then
--         NormalDialogChild:GetPropertyChangedSignal("Visible"):Connect(function()
--             if NormalDialogChild.Visible then
--                 NormalDialogChild:WaitForChild("Info")
--                 NormalDialogChild.Info:WaitForChild("TextLabel")
--                 NormalDialogChild.Info.TextLabel:GetPropertyChangedSignal("Text"):Connect(function()
--                     if Player.PlayerGui.DialogApp.Dialog.NormalDialog.Info.TextLabel.Text:match("4.5%% Legendary") then
--                         FireButton("Okay")
--                     end
--                 end)
--             end
--         end)
--     end
-- end)

-- Player.PlayerGui.DialogApp.Dialog.NormalDialog:GetPropertyChangedSignal("Visible"):Connect(function()
--     if Player.PlayerGui.DialogApp.Dialog.NormalDialog.Visible then
--         Player.PlayerGui.DialogApp.Dialog.NormalDialog:WaitForChild("Info")
--         Player.PlayerGui.DialogApp.Dialog.NormalDialog.Info:WaitForChild("TextLabel")
--         Player.PlayerGui.DialogApp.Dialog.NormalDialog.Info.TextLabel:GetPropertyChangedSignal("Text"):Connect(function()
--             if Player.PlayerGui.DialogApp.Dialog.NormalDialog.Info.TextLabel.Text:match("4.5%% Legendary") then
--                 FireButton("Okay")
--             end
--         end)
--     end
-- end)

-- if Player.PlayerGui.DialogApp.Dialog.NormalDialog.Visible then
--     if Player.PlayerGui.DialogApp.Dialog.NormalDialog.Info.TextLabel.Text:match("4.5%% Legendary") then
--         FireButton("Okay")
--     end
-- end


-- local TradeButtons = Player.PlayerGui.DialogApp.Dialog.NormalDialog.Buttons
-- local CheckMarkNF = Player.PlayerGui.TradeApp.Frame.NegotiationFrame.Body.PartnerOffer.Accepted
-- local CheckMarkCF = Player.PlayerGui.TradeApp.Frame.ConfirmationFrame.PartnerOffer.Accepted
local baitId
local selectedPlayer

local getupvalue = getupvalue or debug.getupvalue
local getconstant = getconstant or debug.getconstant
local getconstants = getconstants or debug.getconstants
local getgc = getgc or get_gc_objects or debug.getgc
local getreg = getreg or getregistry or debug.getregistry
local get_thread_context = get_thread_context or getthreadcontext or getidentity or syn.get_thread_identity or fluxus.get_thread_identity
local get_thread_identity = get_thread_context
local set_thread_context = set_thread_context or setthreadcontext or setidentity or syn.set_thread_identity or fluxus.set_thread_identity
local set_thread_identity = set_thread_context

local Bed
local Shower
--local Piano
local normalLure

local function findFurniture()
    for _, v in pairs(game:GetService("Workspace").HouseInteriors.furniture:GetDescendants()) do
        if v.Name == "BasicCrib" then
            Bed = v.Parent.Name:match("%a+-%d+")

        elseif v.Name == "StylishShower" or v.Name == "ModernShower" then
            Shower = v.Parent.Name:match("%a+-%d+")

        -- elseif v.Name == "Piano" then
        --     Piano = v.Parent.Name:match("%a+-%d+")

        elseif v.Name == "Lures2023NormalLure" then
            normalLure = v.Parent.Name:match("%a+-%d+")

        end
    end
end

local function buyCrib()
    local args = {
        [1] = {
            [1] = {
                ["kind"] = "basiccrib",
                ["properties"] = {
                    ["cframe"] = CFrame.new(Vector3.new(13.7001953125, 0, -20.699951171875), Vector3.new(-8.742277657347586e-08, -0, -1))
                }
            }
        }
    }
    
    game:GetService("ReplicatedStorage"):WaitForChild("API"):WaitForChild("HousingAPI/BuyFurnitures"):InvokeServer(unpack(args))   
end

-- local function buyPiano()
--     local args = {
--         [1] = {
--             [1] = {
--                 ["kind"] = "piano",
--                 ["properties"] = {
--                     ["cframe"] = CFrame.new(Vector3.new(13.7001953125, 0, -20.699951171875), Vector3.new(-8.742277657347586e-08, -0, -1))
--                 }
--             }
--         }
--     }
    
--     game:GetService("ReplicatedStorage"):WaitForChild("API"):WaitForChild("HousingAPI/BuyFurnitures"):InvokeServer(unpack(args))
    
-- end



getgenv().auto_accept_trade = true
getgenv().auto_trade_all_pets = true
getgenv().auto_trade_fullgrown_neon_and_mega = true
getgenv().auto_trade_custom = true
getgenv().auto_trade_semi_auto = true
getgenv().auto_trade_lowtier_pets = true
getgenv().auto_farm = true
getgenv().auto_make_neon = true
getgenv().auto_trade_Legendary = true
getgenv().auto_trade_custom_gifts = true
getgenv().auto_trade_all_neons = true
getgenv().auto_trade_eggs = true
getgenv().auto_trade_all_inventory = true

local selectedPettoFarm

for i, v in pairs(debug.getupvalue(require(ReplicatedStorage.Fsys).load("RouterClient").init, 4)) do
    v.Name = i
end

Player.Idled:Connect(function()
    VirtualUser:ClickButton2(Vector2.new())
end)


-- for _,v in pairs(getconnections(Player.Idled)) do
--     v:Disable()
-- end


local SetLocationTP

--//grab teleportation function
for _, v in pairs(getgc()) do 
    if type(v) == "function" then
        if getfenv(v).script == game.ReplicatedStorage.ClientModules.Core.InteriorsM.InteriorsM then 
            if table.find(getconstants(v), "LocationAPI/SetLocation") then 
                SetLocationTP = v 
                break
            end 
        end 
    end 
end

local function SetLocationFunc(a, b, c)
    local k = get_thread_identity() --syn.get_thread_identity
    set_thread_identity(2)
    SetLocationTP(a,b,c)
    set_thread_identity(k)
end

local pets_legendary = {}
local pets_ultrarare = {}
local pets_rare = {}
local pets_uncommon = {}
local pets_common = {}
local pets_eggs = {}


for u, pets in pairs(inventoryDB.pets) do
    if pets.rarity == "legendary" and not pets.is_egg then
        table.insert(pets_legendary, u)
    elseif pets.rarity == "ultra_rare" and not pets.is_egg then
        table.insert(pets_ultrarare, u)
    elseif pets.rarity == "rare" and not pets.is_egg then
        table.insert(pets_rare, u)
    elseif pets.rarity == "uncommon" and not pets.is_egg then
        table.insert(pets_uncommon, u)
    elseif pets.rarity == "common" and not pets.is_egg then
        table.insert(pets_common, u)
    elseif pets.is_egg then
        table.insert(pets_eggs, u)
    end
end


local Pets_commonto_ultrarare = {}
for _, pettable in pairs({pets_common, pets_uncommon, pets_rare, pets_ultrarare}) do
    for j, petlist in pairs(pettable) do
        table.insert(Pets_commonto_ultrarare, petlist)
    end
end

local pets_legendary_to_common = {}
for _, pettable in pairs({pets_legendary, pets_ultrarare, pets_rare, pets_uncommon, pets_common}) do
    for _, petlist in pairs(pettable) do
        table.insert(pets_legendary_to_common, petlist)
    end
end

local function clipBoardInventory()
    local petsTable = {}
    local petAccessoriesTable = {}
    local strollersTable = {}
    local foodTable = {}
    local transportTable = {}
    local toysTable = {}
    local giftsTable = {}

    local function getInventoryInfo(tab, tablePassOn)
        for _, v in pairs(Bypass("ClientData").get_data()[Player.Name].inventory[tab]) do
            tablePassOn[v.id] = (tablePassOn[v.id] or 0) + 1
        end
    end

    local allInventory = ""

    local function getTable(inventoryPassOn, tablePassOn, namePassOn)
        for i, v in tablePassOn do
            for _, v2 in inventoryDB[inventoryPassOn] do
                if i == tostring(v2.id) then
                    allInventory = allInventory.."["..namePassOn.."] "..v2.name.." x"..v.."\n"
                end
            end
        end
    end

    getInventoryInfo("pets", petsTable)
    getInventoryInfo("pet_accessories", petAccessoriesTable)
    getInventoryInfo("strollers", strollersTable)
    getInventoryInfo("food", foodTable)
    getInventoryInfo("transport", transportTable)
    getInventoryInfo("toys", toysTable)
    getInventoryInfo("gifts", giftsTable)

    getTable("pets", petsTable, "PET")
    getTable("pet_accessories", petAccessoriesTable, "PET_ACCESSORIE")
    getTable("strollers", strollersTable, "STROLLER")
    getTable("food", foodTable, "FOOD")
    getTable("transport", transportTable, "TRANSPORT")
    getTable("toys", toysTable, "TOY")
    getTable("gifts", giftsTable, "GIFT")


    setclipboard(allInventory)
end


-- buy the lure bait and place it
local function buyLure()
    local args = {
        [1] = {
            [1] = {
                ["properties"] = {
                    ["cframe"] = CFrame.new(14, 0, -14) * CFrame.Angles(-0, 8.742277657347586e-08, 3.82137093032941e-15)
                },
                ["kind"] = "lures_2023_normal_lure"
            }
        }
    }

    game:GetService("ReplicatedStorage").API:FindFirstChild("HousingAPI/BuyFurnitures"):InvokeServer(unpack(args))
end

-- give cookie bait to lure
local function placeBait(baitIdPasson)
    local args = {
        [1] = game:GetService("Players").LocalPlayer,
        [2] = normalLure,
        [3] = "UseBlock",
        [4] = {
            ["bait_unique"] = baitIdPasson
        },
        [5] = game:GetService("Players").LocalPlayer.Character
    }

    game:GetService("ReplicatedStorage").API:FindFirstChild("HousingAPI/ActivateFurniture"):InvokeServer(unpack(args))
end

local function findBait(baitPassOn)
    local bait
    for _, v in pairs(require(ReplicatedStorage.ClientModules.Core.ClientData).get_data()[Player.Name].inventory.food) do
        if v.id == baitPassOn then
            bait = v.unique
            return bait
        end
    end  
end

--collect lure loot
local function collectLureLoot()
    local args = {
        [1] = game:GetService("Players").LocalPlayer,
        [2] = normalLure,
        [3] = "UseBlock",
        [4] = false,
        [5] = game:GetService("Players").LocalPlayer.Character
    }
    
    game:GetService("ReplicatedStorage").API:FindFirstChild("HousingAPI/ActivateFurniture"):InvokeServer(unpack(args))
    
end

local function subToHouse()
    game:GetService("ReplicatedStorage").API:FindFirstChild("HousingAPI/SubscribeToHouse"):FireServer(Player)   
end


--local Pet_Farming
local PetCurrentlyFarming = rarity.GetPetCurrentlyFarming()
local Egg2Buy = SETTINGS.PET_TO_BUY
local Gift2Buy = "winter_2023_hare_box"
local Pet2Buy = SETTINGS.PET_TO_BUY -- ugc_refresh_2023_warthog   ugc_refresh_2023_ostrich

local function buyPet()
    local BuyPet = ReplicatedStorage.API["ShopAPI/BuyItem"]:InvokeServer("pets", Pet2Buy, {})
    if BuyPet == "too little money" then return false end
    return true
end

local function getEgg()   
    for _, v in pairs(require(ReplicatedStorage.ClientModules.Core.ClientData).get_data()[Player.Name].inventory.pets) do
        if v.id == Egg2Buy and v.id ~= "practice_dog" and v.properties.age ~= 6 and not v.properties.mega_neon then
            ReplicatedStorage.API["ToolAPI/Equip"]:InvokeServer(v.unique, {["use_sound_delay"] = true})
            PetCurrentlyFarming = v.unique
            return true
        end
    end
    local BuyEgg = ReplicatedStorage.API["ShopAPI/BuyItem"]:InvokeServer("pets", Egg2Buy, {})
    if BuyEgg == "too little money" then
        -- nothing
        return
    end
    task.wait(1)
end

local function GetGiftPet() 
    for _, v in pairs(require(ReplicatedStorage.ClientModules.Core.ClientData).get_data()[Player.Name].inventory.gifts) do
        if v["id"] == Gift2Buy then
            ReplicatedStorage.API["ToolAPI/Equip"]:InvokeServer(v.unique, {["use_sound_delay"] = true})
            task.wait(1)
            ReplicatedStorage.API["LootBoxAPI/ExchangeItemForReward"]:InvokeServer(v["id"], v["unique"])
            return true
        end 
    end

    local BuyGift = ReplicatedStorage.API["ShopAPI/BuyItem"]:InvokeServer("gifts", Gift2Buy, {})
    if tostring(BuyGift) == "too little money" then
        --nothing
        return true -- dont wanna buy egg, we will wait for event currenty
    end

end



local function priorityEgg()
    local found_pet = false
    while found_pet == false do
        task.wait()
        for _, v in ipairs(SETTINGS.HATCH_EGG_PRIORITY_NAMES) do
            for i,v2 in pairs(require(ReplicatedStorage.ClientModules.Core.ClientData).get_data()[Player.Name].inventory.pets) do
                if v == v2.id and v2.id ~= "practice_dog" then
                    ReplicatedStorage.API["ToolAPI/Equip"]:InvokeServer(v2.unique, {["use_sound_delay"] = true})
                    PetCurrentlyFarming = v2.unique
                    return true
                end
            end
        end

        return false
    end
end

local function priorityPet()
    local Petage = 5
    local isNeon = true
    local found_pet = false
    while found_pet == false do
        task.wait()
        for i, v in ipairs(SETTINGS.PET_ONLY_PRIORITY_NAMES) do
            for i2,v2 in pairs(require(ReplicatedStorage.ClientModules.Core.ClientData).get_data()[Player.Name].inventory.pets) do
                if v == v2.id and v2.id ~= "practice_dog" and v2.properties.age == Petage and v2.properties.neon == isNeon then
                    ReplicatedStorage.API["ToolAPI/Equip"]:InvokeServer(v2.unique, {["use_sound_delay"] = true})
                    PetCurrentlyFarming = v2.unique
                    return true
                end
            end
        end
        if found_pet == false then
            Petage = Petage - 1
            if Petage == 0 and isNeon == true then
                Petage = 5
                isNeon = nil
            elseif Petage == 0 and isNeon == nil then
                --getLegendary() -- the selected pet is finished so stop searching
                return false
            end
        end
    end
    
end

local function getNeonPet()
    local Petage = 5
    local isNeon = true
    local found_pet = false
    while found_pet == false do
        task.wait()
        for i, v in pairs(require(ReplicatedStorage.ClientModules.Core.ClientData).get_data()[Player.Name].inventory.pets) do
            if v.id ~= "practice_dog" and v.properties.age == Petage and v.properties.neon == isNeon then
                ReplicatedStorage.API["ToolAPI/Equip"]:InvokeServer(v.unique, {["use_sound_delay"] = true})
                PetCurrentlyFarming = v.unique
                return true
            end
        end
        if found_pet == false then
            Petage = Petage - 1
            if Petage == 0 and isNeon == true then
                return false
            end
        end
    end
end

local petsToAgeTable = {}

local function getRandomPet()
    local randomLowTierTable = {}
    local nameCountTable = {}
    local has4PetsTable = {}

    for _, v in pairs(require(ReplicatedStorage.ClientModules.Core.ClientData).get_data()[Player.Name].inventory.pets) do
        if v.properties.age <= 5 and not v.properties.neon and not v.properties.mega_neon then
            table.insert(randomLowTierTable, v.id)
        end
    end

    for _, v in pairs(randomLowTierTable) do
        local name = v
        nameCountTable[name] = (nameCountTable[name] or 0) + 1
    end

    for name, count in pairs(nameCountTable) do
        if tonumber(count) >= 4 then
            table.insert(has4PetsTable, name)
        end
    end

    local petCounter = 0
    for _, v in pairs(require(ReplicatedStorage.ClientModules.Core.ClientData).get_data()[Player.Name].inventory.pets) do
        if v.id == has4PetsTable[1] and v.properties.age <= 5 and not v.properties.neon and not v.properties.mega_neon then
            table.insert(petsToAgeTable, v.unique)
            petCounter += 1
            if petCounter == 4 then
                petCounter = 0
                return true
            end
        end
    end
    return false
end

local function getPet()
    if SETTINGS.FOCUS_FARM_AGE_POTION then
        if rarity.GetPetRarity(pets_common, 6) then return end
        if rarity.GetPetRarity(pets_legendary, 6) then return end
        if rarity.GetPetRarity(pets_ultrarare, 6) then return end
        if rarity.GetPetRarity(pets_rare, 6) then return end
        if rarity.GetPetRarity(pets_uncommon, 6) then return end
        if rarity.GetPetRarity(pets_common, 6) then return end
    end

    if SETTINGS.HATCH_EGG_PRIORITY then
        if priorityEgg() then return end
        for i = 1, 1 do
            ReplicatedStorage.API["ShopAPI/BuyItem"]:InvokeServer("pets", SETTINGS.HATCH_EGG_PRIORITY_NAMES[1], {})
            return
        end
    end

    if SETTINGS.PET_NEON_PRIORITY then
        if getNeonPet() then return end
    end

    if SETTINGS.PET_ONLY_PRIORITY then
        if priorityPet() then return end
    end

    if rarity.GetPetRarity(pets_legendary, 5) then return end

    -- if #petsToAgeTable >= 1 then
    --     ReplicatedStorage.API["ToolAPI/Equip"]:InvokeServer(petsToAgeTable[1], {["use_sound_delay"] = true})
    --     PetCurrentlyFarming = petsToAgeTable[1]
    --     table.remove(petsToAgeTable, 1)
    --     return
    -- elseif #petsToAgeTable == 0 or nil then
    --     if not getRandomPet() then --[[end and go to next if statement]] end
    --     ReplicatedStorage.API["ToolAPI/Equip"]:InvokeServer(petsToAgeTable[1], {["use_sound_delay"] = true})
    --     PetCurrentlyFarming = petsToAgeTable[1]
    --     table.remove(petsToAgeTable, 1)
    --     if #petsToAgeTable ~= 0 or nil then
    --         return
    --     end
    -- end


    if rarity.GetPetRarity(pets_ultrarare, 5) then return end
    if rarity.GetPetRarity(pets_rare, 5) then return end
    if rarity.GetPetRarity(pets_uncommon, 5) then return end
    if rarity.GetPetRarity(pets_common, 5) then return end

    -- if GetGiftPet() then
    --     task.wait(1)
    --     if getLegendary() then return end
    --     if getUltraRare() then return end
    --     if getRare() then return end
    --     if getUnCommon() then return end
    --     if getCommon() then return end
    -- end

    if getEgg() then return end
    -- if buyPet() then return end
end


local function agePotion(FoodPassOn)
    for _, v in pairs(require(ReplicatedStorage.ClientModules.Core.ClientData).get_data()[Player.Name].inventory.food) do
        if v.id == FoodPassOn then
            ReplicatedStorage.API["PetAPI/ConsumeFoodItem"]:FireServer(v.unique)
            return
        end
    end
end


local function FoodAilments(FoodPassOn) --FoodPassOn means "icecream" for this example
    local FoodCounter = 0
    for _, v in pairs(require(ReplicatedStorage.ClientModules.Core.ClientData).get_data()[Player.Name].inventory.food) do
        if v.id == FoodPassOn then
            FoodCounter += 1
            if FoodCounter >= 2 then
                ReplicatedStorage.API["ToolAPI/Equip"]:InvokeServer(v.unique, {["use_sound_delay"] = true})
                task.wait(1)
                ReplicatedStorage.API["PetAPI/ConsumeFoodItem"]:FireServer(v.unique)
                return
            end
        end
    end

    if FoodCounter <= 1 then
        ReplicatedStorage.API["ShopAPI/BuyItem"]:InvokeServer("food", FoodPassOn, {})
        for _, f in pairs(require(ReplicatedStorage.ClientModules.Core.ClientData).get_data()[Player.Name].inventory.food) do
            if f.id == FoodPassOn then
                ReplicatedStorage.API["ToolAPI/Equip"]:InvokeServer(f.unique, {["use_sound_delay"] = true})
                task.wait(1)
                ReplicatedStorage.API["PetAPI/ConsumeFoodItem"]:FireServer(f.unique)
                return
            end
        end
    end
end


local function DayNightAilments(DayNightAilmentsPassOn) -- DayNightAilmentsPassOn means "bed or shower"
    ReplicatedStorage.API["HousingAPI/ActivateFurniture"]:InvokeServer(Player, DayNightAilmentsPassOn, "UseBlock", {["cframe"] = Player.Character.HumanoidRootPart.CFrame}, Bypass("ClientData").get("pet_char_wrapper")["char"])
end

local function ReEquipPet()
    if Bypass("ClientData").get("pet_char_wrapper") == nil or false then
        getPet()
        return
    end
    local Mag = (Player.Character.HumanoidRootPart.Position - Bypass("ClientData").get("pet_char_wrapper").char:FindFirstChild("HumanoidRootPart").Position).Magnitude
    if Mag then
        if Mag >= 10 then
            ReplicatedStorage.API["ToolAPI/Unequip"]:InvokeServer(PetCurrentlyFarming, {["use_sound_delay"] = true})
            task.wait(2)
            ReplicatedStorage.API["ToolAPI/Equip"]:InvokeServer(PetCurrentlyFarming, {["use_sound_delay"] = true})
            return
        end
    end
end

local function removeHandHeldItem()
    local tool = Player.Character:FindFirstChild("PotionTool") or Player.Character:FindFirstChild("MessageTool")
    if tool then
        ReplicatedStorage.API["ToolAPI/Unequip"]:InvokeServer(tool.unique.Value, {["use_sound_delay"] = true})
    end
end

local function checkForPlayerInHouse()
    if game.Workspace.HouseInteriors.blueprint:FindFirstChildWhichIsA("Model") then
        FarmToggle:Set(false)
        task.wait(1)
        FarmToggle:Set(true)
    end
end

--//Teleport function for main map

local function ExitHome()
    ReplicatedStorage.API["HousingAPI/UnsubscribeFromHouse"]:InvokeServer(Player, true)
    task.wait(3)
    game.Workspace.Interiors:WaitForChild(tostring(game.Workspace.Interiors:FindFirstChildWhichIsA("Model")))
    Player.Character.PrimaryPart.CFrame = game.Workspace.Interiors:WaitForChild(tostring(game.Workspace.Interiors:FindFirstChildWhichIsA("Model"))).ExitBillboardBrick.CFrame + Vector3.new(0,0,17)
    task.wait(3) -- gives it time to load on the otherside
    game.Players.LocalPlayer.Character.Humanoid:MoveTo(Vector3.new(1,0,0))
end

local function TeleportMainMap()
    Bypass("CollisionsClient").set_collidable(false)
    Player.Character:WaitForChild("HumanoidRootPart").Anchored = true
    SetLocationFunc("MainMap", "Neighborhood/MainDoor", {})
    game.Workspace.Interiors:WaitForChild(tostring(game.Workspace.Interiors:FindFirstChildWhichIsA("Model")))
    Player.Character.PrimaryPart.CFrame = game.Workspace.Interiors:FindFirstChild(tostring(game.Workspace.Interiors:FindFirstChildWhichIsA("Model"))).Static.Campsite.MarshmallowChair.VintageChair.Union.CFrame + Vector3.new(math.random(1, 20), 10, math.random(1, 20))
    Player.Character:WaitForChild("HumanoidRootPart").Anchored = false
    Player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Landed)
    Player.Character.Humanoid.WalkSpeed = 0
    task.wait(2)
    subToHouse()
end

local function TeleportWinterShop()
    Bypass("CollisionsClient").set_collidable(false)
    Player.Character:WaitForChild("HumanoidRootPart").Anchored = true
    SetLocationFunc("Winter2023Shop", "MainDoor2", {})
    game.Workspace.Interiors:WaitForChild(tostring(game.Workspace.Interiors:FindFirstChildWhichIsA("Model")))
    Player.Character.PrimaryPart.CFrame = game.Workspace.Interiors:FindFirstChild(tostring(game.Workspace.Interiors:FindFirstChildWhichIsA("Model"))).Event.BuyCurrency.PrimaryPart.CFrame + Vector3.new(10, 5, 10)
    Player.Character:WaitForChild("HumanoidRootPart").Anchored = false
    Player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Landed)
    Player.Character.Humanoid.WalkSpeed = 0
    for i=1, 20 do
        game:GetService("ReplicatedStorage"):WaitForChild("API"):WaitForChild("WinterEventAPI/AdventCalendarTryTakeReward"):InvokeServer(i)
        task.wait(.1)
    end
    task.wait(2)
end

local function TeleportPetRescue()
    Player.Character:WaitForChild("HumanoidRootPart").Anchored = true
    Player.Character.PrimaryPart.CFrame = game.Workspace.Interiors:FindFirstChild(tostring(game.Workspace.Interiors:FindFirstChildWhichIsA("Model"))).PetRescue.JoinZone.Collider.CFrame + Vector3.new(0, -14, 0)
    Player.Character:WaitForChild("HumanoidRootPart").Anchored = false
    Player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Landed)
    Player.Character.Humanoid.WalkSpeed = 0
end

--game:GetService("Workspace").Interiors.FireDimension.Doors.WarpDoor.WorkingParts.TouchToEnter
-- local function TeleportFireDimension()
--     Player.Character:WaitForChild("HumanoidRootPart").Anchored = true
--     SetLocationFunc("FireDimension", "MainDoor", {})
--     game.Workspace.Interiors:WaitForChild(tostring(game.Workspace.Interiors:FindFirstChildWhichIsA("Model")))
--     Player.Character.PrimaryPart.CFrame = game.Workspace.Interiors:WaitForChild(tostring(game.Workspace.Interiors:FindFirstChildWhichIsA("Model"))).Doors.WarpDoor.WorkingParts.TouchToEnter.CFrame + Vector3.new(math.random(1, 10), 10, math.random(1, 10))
--     Player.Character:WaitForChild("HumanoidRootPart").Anchored = false
--     Player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Landed)
--     Player.Character.Humanoid.WalkSpeed = 0
--     task.wait(2)
-- end

local function TeleportCampSite()
    Player.Character:WaitForChild("HumanoidRootPart").Anchored = true
    SetLocationFunc("MainMap", "Neighborhood/MainDoor", {})
    game.Workspace.Interiors:WaitForChild(tostring(game.Workspace.Interiors:FindFirstChildWhichIsA("Model")))
    Player.Character.PrimaryPart.CFrame = game.Workspace.Interiors:WaitForChild(tostring(game.Workspace.Interiors:FindFirstChildWhichIsA("Model"))).Static.Campsite.MarshmallowChair.VintageChair.Union.CFrame + Vector3.new(math.random(1, 20), 10, math.random(1, 20))
    Player.Character:WaitForChild("HumanoidRootPart").Anchored = false
    Player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Landed)
    Player.Character.Humanoid.WalkSpeed = 0
end

local function TeleportPoolParty()
    Player.Character:WaitForChild("HumanoidRootPart").Anchored = true
    SetLocationFunc("MainMap", "Neighborhood/MainDoor", {})
    game.Workspace.Interiors:WaitForChild(tostring(game.Workspace.Interiors:FindFirstChildWhichIsA("Model")))
    Player.Character.PrimaryPart.CFrame = game.Workspace.Interiors:WaitForChild(tostring(game.Workspace.Interiors:FindFirstChildWhichIsA("Model"))).Static.PoolArea.PoolOrigin.CFrame + Vector3.new(math.random(1, 20), 10, math.random(1, 20))
    Player.Character:WaitForChild("HumanoidRootPart").Anchored = false
    Player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Landed)
    Player.Character.Humanoid.WalkSpeed = 0
end

local function TeleportPlayGround()
    Player.Character:WaitForChild("HumanoidRootPart").Anchored = true
    SetLocationFunc("MainMap", "Neighborhood/MainDoor", {})
    game.Workspace.Interiors:WaitForChild(tostring(game.Workspace.Interiors:FindFirstChildWhichIsA("Model")))
    Player.Character.PrimaryPart.CFrame = game:GetService("Workspace").StaticMap.Park.Roundabout.SeatsSpinModel.Visual:FindFirstChildWhichIsA("Part").CFrame + Vector3.new(math.random(1, 20), 10, math.random(-20, -1))
    Player.Character:WaitForChild("HumanoidRootPart").Anchored = false
    Player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Landed)
    Player.Character.Humanoid.WalkSpeed = 0
end


------------------------------- Auto Farming ------------------------

local function CheckifEgg()
    local PetNameID = Bypass("ClientData").get("pet_char_wrapper")["pet_id"]
    local PetUniqueID = Bypass("ClientData").get("pet_char_wrapper")["pet_unique"]
    local PetAge = Bypass("ClientData").get("pet_char_wrapper")["pet_progression"]["age"]

    if PetUniqueID == PetCurrentlyFarming then return end
    if PetAge ~= 1 then return end

    getPet()
end

local function SwitchOutFullyGrown()
    if Bypass("ClientData").get("pet_char_wrapper") == nil or false then
        getPet()
        return
    end
    local PetAge = Bypass("ClientData").get("pet_char_wrapper")["pet_progression"]["age"]
    if PetAge == 6 then
        getPet()
        return
    elseif PetAge == 1 then
        CheckifEgg()
    end 
end

local function isProgression(taskPassOn)
    if Player.PlayerGui:FindFirstChild("pet_progression") then
        Player.PlayerGui.pet_progression:FindFirstChild("SurfaceGui")
        Player.PlayerGui.pet_progression.SurfaceGui:FindFirstChild("PetProgression")
        Player.PlayerGui.pet_progression.SurfaceGui.PetProgression:FindFirstChild("TextLabel")
        if Player.PlayerGui.pet_progression.SurfaceGui.PetProgression.TextLabel.Text == taskPassOn then
            return true
        end
    end
    return false
end

-- local isRunning = true
-- local NameID = "lures_2023_campfire_cookies_liveops"


-- local function getIngredients(ingredient)
--     for i = 1, 11 do
--         ReplicatedStorage.API:FindFirstChild("FireDimensionAPI/PickFruit"):InvokeServer(string.lower(ingredient), i)
--         task.wait(.1)
--     end
-- end


-- local function opensCookie()
--     for i, v in pairs(require(ReplicatedStorage.ClientModules.Core.ClientData).get_data()[Players.LocalPlayer.Name].inventory.food) do
--         if v["id"] == NameID then
--             game:GetService("ReplicatedStorage"):WaitForChild("API"):WaitForChild("LootBoxAPI/ExchangeItemForReward"):InvokeServer(v["id"], v["unique"])
--             return true
--         end
--     end
--     return false
-- end


-- local function FireDimensionFarm()
--     task.spawn(function()
--         getIngredients("Berry")
--         getIngredients("Mango")
--         getIngredients("Pear")

--         ReplicatedStorage.API:FindFirstChild("FireDimensionAPI/CookRecipe"):InvokeServer("daily_recipe")
--         task.wait(1)

--         opensCookie()
--         task.wait(1)

--         ReplicatedStorage.API:FindFirstChild("FireDimensionAPI/CookRecipe"):InvokeServer("super_recipe")
--         task.wait(1)
--     end)
-- end



local function getGingerbread()
    local GingerbreadMarkers = ReplicatedStorage.Resources.IceSkating.GingerbreadMarkers
    for _, v in GingerbreadMarkers:GetChildren() do
        if v:IsA("BasePart") then
            Bypass("RouterClient").get("WinterEventAPI/PickUpGingerbread"):InvokeServer(v.Name)
            task.wait()
        end
    end
    task.wait()
    Bypass("RouterClient").get("WinterEventAPI/RedeemPendingGingerbread"):FireServer()
end


local function autoFarm()
    if not getgenv().auto_farm then return end
    TeleportMainMap()
    local function CompletePetAilments()
        if Bypass("ClientData").get("pet_char_wrapper") == nil then
            ReplicatedStorage.API["ToolAPI/Unequip"]:InvokeServer(PetCurrentlyFarming, {["use_sound_delay"] = true})
            task.wait(1)
            ReplicatedStorage.API["ToolAPI/Equip"]:InvokeServer(PetCurrentlyFarming, {["use_sound_delay"] = true})
            return -- return because when pet gets requipped it will call this function anyway
        end
        if #Bypass("ClientData").get("pet_char_wrapper")["ailments_monitor"]["ailments"] == 0 then
            getGingerbread()
            return 
        end
        for _, v in pairs(Bypass("ClientData").get("pet_char_wrapper")["ailments_monitor"]["ailments"]) do
            if v["id"] == "hungry" then
                FoodAilments("icecream")
                task.wait(2)
                if not SETTINGS.FOCUS_FARM_AGE_POTION then
                    agePotion("pet_age_potion")
                end
            elseif v["id"] == "thirsty" then
                FoodAilments("water") 
            elseif v["id"] == "sick" then
                if tonumber(v["progress"]) == tonumber(v["old_progress"]) then
                    Bypass("RouterClient").get("MonitorAPI/HealWithDoctor"):FireServer()
                    return
                end
            elseif v["id"] == "salon" then
                if tonumber(v["progress"]) == tonumber(v["old_progress"]) then
                    ReplicatedStorage.API["LocationAPI/SetLocation"]:FireServer("Salon")
                    return
                end
            elseif v["id"] == "pizza_party" then
                if tonumber(v["progress"]) == tonumber(v["old_progress"]) then
                    ReplicatedStorage.API["LocationAPI/SetLocation"]:FireServer("PizzaShop")
                    return 
                end
            elseif v["id"] == "school" then
                if tonumber(v["progress"]) == tonumber(v["old_progress"]) then
                    ReplicatedStorage.API["LocationAPI/SetLocation"]:FireServer("School")
                    return 
                end
            elseif v["id"] == "bored" then
                if tonumber(v["progress"]) == tonumber(v["old_progress"]) then
                    TeleportPlayGround()
                    return 
                end
            elseif v["id"] == "sleepy" then
                if tonumber(v["progress"]) == tonumber(v["old_progress"]) then
                    DayNightAilments(Bed)
                    return
                end
            elseif v["id"] == "dirty" then
                if tonumber(v["progress"]) == tonumber(v["old_progress"]) then
                    DayNightAilments(Shower)   
                    return
                end
            elseif v["id"] == "pool_party" then
                if tonumber(v["progress"]) == tonumber(v["old_progress"]) then
                    TeleportPoolParty()
                    return
                end
            elseif v["id"] == "camping" then
                if tonumber(v["progress"]) == tonumber(v["old_progress"]) then
                    TeleportCampSite()

                    baitId = findBait("lures_2023_campfire_cookies")
                    placeBait(baitId)
                    return
                end
            end
        end
    end

    local function CompleteBabyAilments()
        if #Bypass("ClientData").get("char_wrapper")["ailments_monitor"]["ailments"] == 0 then return end
        for _, m in pairs(Bypass("ClientData").get("char_wrapper")["ailments_monitor"]["ailments"]) do
            if m["id"] == m["id"] then
                Bypass("RouterClient").get("MonitorAPI/AddRate"):InvokeServer(m["id"], 100)
            end
        end
    end

    game.Players.LocalPlayer.PlayerGui.AilmentsMonitorApp.Ailments.ChildAdded:Connect(function()
        removeHandHeldItem()
        if not SETTINGS.FOCUS_FARM_AGE_POTION then
            SwitchOutFullyGrown()
        end
        CompleteBabyAilments()
        CompletePetAilments()
    end)

    game.Players.LocalPlayer.PlayerGui.AilmentsMonitorApp.Ailments.ChildRemoved:Connect(function()
        task.wait(1)
        if not SETTINGS.FOCUS_FARM_AGE_POTION then
            SwitchOutFullyGrown()
        end
        task.wait(1)
        CompletePetAilments()
    end)

    -- For text that popups on bottom ui
    Player.PlayerGui.HintApp.TextLabel:GetPropertyChangedSignal("Text"):Connect(function()
        if Player.PlayerGui.HintApp.TextLabel.Text:match("aged up!") then
            if SETTINGS.PET_AUTO_FUSION then
                fusionPet.MakeNeon()
                fusionPet.MakeMegaNeon()
                task.wait(2) -- gives it time for pet to fully equipped
            end

            if not SETTINGS.FOCUS_FARM_AGE_POTION then
                SwitchOutFullyGrown()
            end

        elseif Player.PlayerGui.HintApp.TextLabel.Text:match("You have left the queue") then
            if workspace.Interiors:FindFirstChild("Winter2023Shop") then
                Player.Character.PrimaryPart.CFrame = workspace.Interiors.Winter2023Shop.PetRescue.JoinZone.Collider.CFrame + Vector3.new(0,-14,0)
            
            elseif workspace.Interiors:FindFirstChild("ChickatriceMinigame") then
                Player.Character.PrimaryPart.CFrame = workspace.Interiors.ChickatriceMinigame.Minigame.JoinZone.Collider.CFrame + Vector3.new(0,-14,0)
            
            elseif workspace.Interiors:FindFirstChild("DodgeMinigameLobby") then
                Player.Character.PrimaryPart.CFrame = workspace.Interiors.DodgeMinigameLobby.Minigame.JoinZone.Collider.CFrame + Vector3.new(0,-14,0)

            end
        end
    end)


    --// Fires when inside the minigame
    Player.PlayerGui.MinigameInGameApp:GetPropertyChangedSignal("Enabled"):Connect(function()
        if Player.PlayerGui.MinigameInGameApp.Enabled then
            Player.PlayerGui.MinigameInGameApp:WaitForChild("Body")
            Player.PlayerGui.MinigameInGameApp.Body:WaitForChild("Left")
            Player.PlayerGui.MinigameInGameApp.Body.Left:WaitForChild("Container")
            Player.PlayerGui.MinigameInGameApp.Body.Left.Container:WaitForChild("ValueLabel")
            if not Player.PlayerGui.MinigameInGameApp.Body.Left.Container.ValueLabel.Text:match("GAME OVER") then
                repeat
                    game:GetService("ReplicatedStorage"):WaitForChild("API"):WaitForChild("WinterEventAPI/PetRescueTryUsePickaxe"):InvokeServer()
                    task.wait(.5)
                until Player.PlayerGui.MinigameInGameApp.Body.Left.Container.ValueLabel.Text:match("GAME OVER")
                -- task.wait(30)
                -- TeleportMainMap()

            elseif Player.PlayerGui.MinigameInGameApp.Body.Middle.Container.TitleLabel.Text:match("CHICKATRICE SAYS") then
                task.wait()
                
            elseif Player.PlayerGui.MinigameInGameApp.Body.Middle.Container.TitleLabel.Text:match("SPOOKY SHUFFLE") then
                task.wait()
            end
        end 
    end)
    
    -- fires when it ask you if you want to join minigame
    Player.PlayerGui.DialogApp.Dialog.ChildAdded:Connect(function(NormalDialogChild)
        if NormalDialogChild.Name == "NormalDialog" then
            NormalDialogChild:GetPropertyChangedSignal("Visible"):Connect(function()
                if NormalDialogChild.Visible then
                    NormalDialogChild:WaitForChild("Info")
                    NormalDialogChild.Info:WaitForChild("TextLabel")
                    NormalDialogChild.Info.TextLabel:GetPropertyChangedSignal("Text"):Connect(function()
                        if Player.PlayerGui.DialogApp.Dialog.NormalDialog.Info.TextLabel.Text:match("Pet Rescue is starting soon!") then
                            FireButton("Yes")
                        
                        elseif Player.PlayerGui.DialogApp.Dialog.NormalDialog.Info.TextLabel.Text:match("Santa's Workshop is starting soon!") then
                            FireButton("Yes")

                        elseif Player.PlayerGui.DialogApp.Dialog.NormalDialog.Info.TextLabel.Text:match("Cocoa Chaos is starting soon!") then
                            FireButton("Yes")

                        end
                    end)
                end
            end)
        end
    end)
    

    Player.PlayerGui.DialogApp.Dialog.NormalDialog:GetPropertyChangedSignal("Visible"):Connect(function()
        if Player.PlayerGui.DialogApp.Dialog.NormalDialog.Visible then
            Player.PlayerGui.DialogApp.Dialog.NormalDialog:WaitForChild("Info")
            Player.PlayerGui.DialogApp.Dialog.NormalDialog.Info:WaitForChild("TextLabel")
            Player.PlayerGui.DialogApp.Dialog.NormalDialog.Info.TextLabel:GetPropertyChangedSignal("Text"):Connect(function()
                if Player.PlayerGui.DialogApp.Dialog.NormalDialog.Info.TextLabel.Text:match("Pet Rescue is starting soon!") then
                    FireButton("Yes")
                 
                elseif Player.PlayerGui.DialogApp.Dialog.NormalDialog.Info.TextLabel.Text:match("Santa's Workshop is starting soon!") then
                    FireButton("Yes")

                elseif Player.PlayerGui.DialogApp.Dialog.NormalDialog.Info.TextLabel.Text:match("Cocoa Chaos is starting soon!") then
                    FireButton("Yes")
                end
            end)
        end
    end)
    
    -- if Player.PlayerGui.DialogApp.Dialog.NormalDialog.Visible then
    --     if Player.PlayerGui.DialogApp.Dialog.NormalDialog.Info.TextLabel.Text:match("Tile Skip is starting soon!") then
    --         FireButton("Yes")
            
    --     elseif Player.PlayerGui.DialogApp.Dialog.NormalDialog.Info.TextLabel.Text:match("Crabby Grabby is starting soon!") then
    --         FireButton("Yes")
           
    --     end
    -- end
    

    local function RemoveGameOverButton()
        Player.PlayerGui.MinigameRewardsApp.Body.Button:WaitForChild("Face")
        for i, v in pairs(Player.PlayerGui.MinigameRewardsApp.Body.Button:GetDescendants()) do
            if v.Name == "TextLabel" then
                if v.Text == "NICE!" then
                    clickGuiButton(v.Parent.Parent)
                    break
                end
            end
        end
    end


    Player.PlayerGui.MinigameRewardsApp.Body:GetPropertyChangedSignal("Visible"):Connect(function()
        if Player.PlayerGui.MinigameRewardsApp.Body.Visible then
            Player.PlayerGui.MinigameRewardsApp.Body:WaitForChild("Button")
            Player.PlayerGui.MinigameRewardsApp.Body.Button:WaitForChild("Face")
            Player.PlayerGui.MinigameRewardsApp.Body.Button.Face:WaitForChild("TextLabel")
            if Player.PlayerGui.MinigameRewardsApp.Body.Button.Face.TextLabel.Text:match("NICE!") then
                Player.Character.HumanoidRootPart.Anchored = false
                RemoveGameOverButton()
                Player.PlayerGui.MinigameRewardsApp.Body.Visible = false
                TeleportMainMap()
            end
        end
    end)


    --// Code below runs once when auto farm is enabled
    if SETTINGS.PET_AUTO_FUSION then
        fusionPet.MakeNeon()
        fusionPet.MakeMegaNeon()
    end

    getPet()
    task.wait(2)
    CompleteBabyAilments()
    CompletePetAilments()
    task.wait(2)
    
    --setfpscap(SETTINGS.SET_FPS)

end



---------------------------------------- Auto Trader --------------------------------
--// this will accept the trade only after other player accepts

-- CheckMarkNF:GetPropertyChangedSignal("ImageTransparency"):Connect(function()
--     if Player.PlayerGui.TradeApp.Frame.NegotiationFrame.Visible then
--         if CheckMarkNF.ImageTransparency ~= 1 then
--             task.wait(2)
--             ReplicatedStorage.API:FindFirstChild("TradeAPI/AcceptNegotiation"):FireServer()
--         end
--     end
-- end)

-- CheckMarkCF:GetPropertyChangedSignal("ImageTransparency"):Connect(function()
--     if Player.PlayerGui.TradeApp.Frame.ConfirmationFrame.Visible then
--         if CheckMarkCF.ImageTransparency ~= 1 then
--             task.wait(2)
--             ReplicatedStorage.API:FindFirstChild("TradeAPI/ConfirmTrade"):FireServer()
--         end
--     end
-- end)

local function ClickTradeWindowPopUps()
    for _, v in pairs(Player.PlayerGui.DialogApp.Dialog.NormalDialog.Buttons:GetDescendants()) do
        if v.Name == "TextLabel" then
            if v.Text == "Accept" or v.Text == "Okay" or v.Text == "Next" or v.Text == "I understand" or v.Text == "No" then
                clickGuiButton(v.Parent.Parent)
                return
            end
        end
    end

    for _, v in pairs(Player.PlayerGui.DialogApp.Dialog.HeaderDialog.Buttons:GetDescendants()) do
        if v.Name == "TextLabel" then
            if v.Text == "Accept" or v.Text == "Okay" or v.Text == "Next" or v.Text == "I understand" then
                clickGuiButton(v.Parent.Parent)
                return
            end
        end
    end
end

local function clickAcceptConfirmation()
    if Player.PlayerGui.DialogApp.Dialog.NormalDialog.Visible then
        ClickTradeWindowPopUps()
    end
    repeat task.wait() until Player.PlayerGui.TradeApp.Frame.ConfirmationFrame.LockIcon.Visible == false
    ReplicatedStorage.API:FindFirstChild("TradeAPI/ConfirmTrade"):FireServer()
    repeat task.wait() until not Player.PlayerGui.TradeApp.Frame.Visible
    ClickTradeWindowPopUps()
end

local function clickAcceptNegotiation()
    if Player.PlayerGui.DialogApp.Dialog.NormalDialog.Visible then
        ClickTradeWindowPopUps()
    end
    repeat task.wait()
    until Player.PlayerGui.TradeApp.Frame.NegotiationFrame.Body.LockIcon.Visible == false
    ReplicatedStorage.API:FindFirstChild("TradeAPI/AcceptNegotiation"):FireServer()
    ClickTradeWindowPopUps()
    task.wait()
end

local function autoAcceptTrade()
    task.spawn(function()
        while task.wait(1) do
            if not getgenv().auto_accept_trade then return end
            pcall(function()
                ClickTradeWindowPopUps()
                ReplicatedStorage.API:FindFirstChild("TradeAPI/AcceptNegotiation"):FireServer()
                ReplicatedStorage.API:FindFirstChild("TradeAPI/ConfirmTrade"):FireServer()
            end)
        end
    end)
end

local function autoTradeAllInventory(TabPassOn)
    task.spawn(function()
        pcall(function()
            if not Player.PlayerGui.TradeApp.Frame.Visible then
                ReplicatedStorage.API:FindFirstChild("TradeAPI/SendTradeRequest"):FireServer(selectedPlayer)
            end
            ClickTradeWindowPopUps()
        end)
    
        local petCounter = 0
        
        for _, items in pairs(require(ReplicatedStorage.ClientModules.Core.ClientData).get_data()[Player.Name].inventory[TabPassOn]) do
            if items.id == "practice_dog" then continue end
            ReplicatedStorage.API["TradeAPI/AddItemToOffer"]:FireServer(items.unique)
            petCounter = petCounter + 1
            task.wait()
            if petCounter >= 18 then
                break
            end
        end
        petCounter = 0
    end)
end

local function sendTradeRequest()
    if not Player.PlayerGui.TradeApp.Frame.Visible then
        repeat
            ReplicatedStorage.API:FindFirstChild("TradeAPI/SendTradeRequest"):FireServer(selectedPlayer)
            task.wait(1)
        until Player.PlayerGui.TradeApp.Frame.Visible
    end
end

local function inventoryCount()
    local count
    for _, pet in pairs(require(ReplicatedStorage.ClientModules.Core.ClientData).get_data()[Player.Name].inventory.pets) do
        count += 1
    end
    return count
end

local function autoTradeAllPets()
    local petCounter = 0
    local howManyLeft = howManyToTrade
    local petCount
    local inventoryLeft
    while howManyLeft ~= 0 do
        if not getgenv().auto_trade_all_pets then return end
        if howManyLeft == 0 then return end
        sendTradeRequest()

        for _, pet in pairs(require(ReplicatedStorage.ClientModules.Core.ClientData).get_data()[Player.Name].inventory.pets) do
            if howManyLeft == 0 then break end
            ReplicatedStorage.API["TradeAPI/AddItemToOffer"]:FireServer(pet.unique)
            petCounter += 1
            howManyLeft -= 1
            task.wait(.1)
            if petCounter == 18 then
                break
            end
        end
        clickAcceptNegotiation()
        clickAcceptConfirmation()
        petCounter = 0
        task.wait(1)
    end 
end

local function autoTradeLegendary()
    task.spawn(function()
        while task.wait(0.5) do
            if not getgenv().auto_trade_Legendary then return end
            pcall(function()
                if not Player.PlayerGui.TradeApp.Frame.Visible then
                    ReplicatedStorage.API:FindFirstChild("TradeAPI/SendTradeRequest"):FireServer(selectedPlayer)
                end
                ClickTradeWindowPopUps() 
            end)
        end
    end)

    task.spawn(function()
        local petCounter = 0
        while task.wait(0.5) do
            if not getgenv().auto_trade_Legendary then return end
            pcall(function()
                for _, v in pairs(pets_legendary) do
                    for _, pet in pairs(require(ReplicatedStorage.ClientModules.Core.ClientData).get_data()[Player.Name].inventory.pets) do
                        if v == pet.id then
                            ReplicatedStorage.API["TradeAPI/AddItemToOffer"]:FireServer(pet.unique)
                            petCounter = petCounter + 1
                            if petCounter >= 18 then
                                break 
                            end
                        end
                    end
                end
                ReplicatedStorage.API:FindFirstChild("TradeAPI/AcceptNegotiation"):FireServer()
                ReplicatedStorage.API:FindFirstChild("TradeAPI/ConfirmTrade"):FireServer()
                petCounter = 0
            end)
        end
    end)
end

local function autoTradeFullgrownNeonandMega()
    task.spawn(function()
        while task.wait(0.1) do
            if not getgenv().auto_trade_fullgrown_neon_and_mega then return end
            pcall(function()
                if not Player.PlayerGui.TradeApp.Frame.Visible then
                    ReplicatedStorage.API:FindFirstChild("TradeAPI/SendTradeRequest"):FireServer(selectedPlayer)
                end
                ClickTradeWindowPopUps()
            end)
        end
    end)

    task.spawn(function()
        local petCounter = 0
        while task.wait(0.1) do
            if not getgenv().auto_trade_fullgrown_neon_and_mega then return end
            pcall(function()
                for _, pet in pairs(require(ReplicatedStorage.ClientModules.Core.ClientData).get_data()[Player.Name].inventory.pets) do
                    if (pet.properties.age == 6 or pet.properties.neon) or pet.properties.mega_neon then
                        ReplicatedStorage.API["TradeAPI/AddItemToOffer"]:FireServer(pet.unique)
                        petCounter = petCounter + 1
                        if petCounter >= 18 then
                            break 
                        end
                    end
                end
                ReplicatedStorage.API:FindFirstChild("TradeAPI/AcceptNegotiation"):FireServer()
                task.wait()
                ReplicatedStorage.API:FindFirstChild("TradeAPI/ConfirmTrade"):FireServer()
                petCounter = 0
            end)
        end
    end)
end

local function autoTradeAllNeons()
    task.spawn(function()
        while task.wait(0.5) do
            if not getgenv().auto_trade_all_neons then return end
            pcall(function()
                if not Player.PlayerGui.TradeApp.Frame.Visible then
                    ReplicatedStorage.API:FindFirstChild("TradeAPI/SendTradeRequest"):FireServer(selectedPlayer)
                end
                ClickTradeWindowPopUps()
            end)
        end
    end)

    task.spawn(function()
        local petCounter = 0
        while task.wait(0.5) do
            if not getgenv().auto_trade_all_neons then return end
            pcall(function()
                for _, pet in pairs(require(ReplicatedStorage.ClientModules.Core.ClientData).get_data()[Player.Name].inventory.pets) do
                    if pet.properties.neon then
                        ReplicatedStorage.API["TradeAPI/AddItemToOffer"]:FireServer(pet.unique)
                        petCounter = petCounter + 1
                        if petCounter >= 18 then
                            break 
                        end
                    end
                end
                ReplicatedStorage.API:FindFirstChild("TradeAPI/AcceptNegotiation"):FireServer()
                ReplicatedStorage.API:FindFirstChild("TradeAPI/ConfirmTrade"):FireServer()
                petCounter = 0
            end)
        end
    end)
end


-- for _, pet in pairs(require(ReplicatedStorage.ClientModules.Core.ClientData).get_data()[Player.Name].inventory.pets) do
--     for _, petsDB_lowtierpets in pairs(Pets_commonto_ultrarare) do
--         if pet.id == petsDB_lowtierpets and pet.properties.age <=4 and not pet.properties.neon and not pet.properties.mega_neon then
--             ReplicatedStorage.API["TradeAPI/AddItemToOffer"]:FireServer(pet.unique)
--             petCounter = petCounter + 1
--             if petCounter >= 18 then
--                 break
--             end
--         end
--     end
-- end


local function autoTradeLowTierPets()
    task.spawn(function()
        while task.wait(0.5) do
            if not getgenv().auto_trade_lowtier_pets then return end
            pcall(function()
                repeat
                    if not Player.PlayerGui.TradeApp.Frame.Visible then
                        ReplicatedStorage.API:FindFirstChild("TradeAPI/SendTradeRequest"):FireServer(selectedPlayer)
                    end

                    ClickTradeWindowPopUps()
                    task.wait(1)
                until Player.PlayerGui.TradeApp.Frame.Visible
                ClickTradeWindowPopUps()
                
                local petCounter = 0   
                for _, pet in pairs(require(ReplicatedStorage.ClientModules.Core.ClientData).get_data()[Player.Name].inventory.pets) do
                    for _, petsDB_lowtierpets in pairs(Pets_commonto_ultrarare) do
                        if pet.id == petsDB_lowtierpets and pet.properties.age <=5 and not pet.properties.neon and not pet.properties.mega_neon then
                            ReplicatedStorage.API["TradeAPI/AddItemToOffer"]:FireServer(pet.unique)
                            petCounter = petCounter + 1
                            if petCounter >= 18 then
                                break
                            end
                        end
                    end
                end

                ClickTradeWindowPopUps()
                ReplicatedStorage.API:FindFirstChild("TradeAPI/AcceptNegotiation"):FireServer()
                task.wait()
                ReplicatedStorage.API:FindFirstChild("TradeAPI/ConfirmTrade"):FireServer()
                petCounter = 0
            end)
        end
    end)
end


local function autoTradeCustom()
    task.spawn(function()
        while task.wait(0.5) do
            if not getgenv().auto_trade_custom then return end
            pcall(function()
                if not Player.PlayerGui.TradeApp.Frame.Visible then
                    ReplicatedStorage.API:FindFirstChild("TradeAPI/SendTradeRequest"):FireServer(selectedPlayer)
                end
                ClickTradeWindowPopUps() 
            end)
        end
    end)

    task.spawn(function()
        local petCounter = 0
        while task.wait(0.5) do
            if not getgenv().auto_trade_custom then return end
            pcall(function()
                for _, pet in pairs(require(ReplicatedStorage.ClientModules.Core.ClientData).get_data()[Player.Name].inventory.pets) do
                    if pet.id == selectedPet then
                        ReplicatedStorage.API["TradeAPI/AddItemToOffer"]:FireServer(pet.unique)
                        petCounter += 1
                        if petCounter >= 18 then
                            break 
                        end
                    end
                end
                ReplicatedStorage.API:FindFirstChild("TradeAPI/AcceptNegotiation"):FireServer()
                task.wait(1)
                ReplicatedStorage.API:FindFirstChild("TradeAPI/ConfirmTrade"):FireServer()
                petCounter = 0
            end)
        end
    end)
end


local function autoTradeSemiAuto()
    task.spawn(function()
        while task.wait(0.5) do
            if not getgenv().auto_trade_semi_auto then return end
            pcall(function()
                if not Player.PlayerGui.TradeApp.Frame.Visible then
                    ReplicatedStorage.API:FindFirstChild("TradeAPI/SendTradeRequest"):FireServer(selectedPlayer)
                end
                ClickTradeWindowPopUps() 
            end)
        end
    end)

    task.spawn(function()
        local petCounter = 0
        while task.wait(0.5) do
            if not getgenv().auto_trade_semi_auto then return end
            pcall(function()
                for _, pet in pairs(require(ReplicatedStorage.ClientModules.Core.ClientData).get_data()[Player.Name].inventory.pets) do
                    if pet.id then
            --          ReplicatedStorage.API["TradeAPI/AddItemToOffer"]:FireServer(pet.unique)
                        petCounter = petCounter + 1 
                        if petCounter >= 18 then
                            break 
                        end
                    end
                end
        --      ReplicatedStorage.API:FindFirstChild("TradeAPI/AcceptNegotiation"):FireServer()
                ReplicatedStorage.API:FindFirstChild("TradeAPI/ConfirmTrade"):FireServer()
                petCounter = 0
            end)
        end
    end)
end


local function autoTradeCustomGifts()
    task.spawn(function()
        while task.wait(1) do
            if not getgenv().auto_trade_custom_gifts then return end
            pcall(function()
                if not Player.PlayerGui.TradeApp.Frame.Visible then
                    ReplicatedStorage.API:FindFirstChild("TradeAPI/SendTradeRequest"):FireServer(selectedPlayer)
                end
                ClickTradeWindowPopUps()
            end)
        end
    end)

    task.spawn(function()
        local petCounter = 0
        while task.wait(1) do
            if not getgenv().auto_trade_custom_gifts then return end
            pcall(function()
                for _, gift in pairs(require(ReplicatedStorage.ClientModules.Core.ClientData).get_data()[Player.Name].inventory.gifts) do
                    if gift.id == selectedGift then
                        ReplicatedStorage.API["TradeAPI/AddItemToOffer"]:FireServer(gift.unique)
                        petCounter = petCounter + 1 
                        if petCounter >= 19 then
                            break 
                        end
                        task.wait(.1)
                    end
                end
                ReplicatedStorage.API:FindFirstChild("TradeAPI/AcceptNegotiation"):FireServer()
                task.wait(1)
                ReplicatedStorage.API:FindFirstChild("TradeAPI/ConfirmTrade"):FireServer()
                petCounter = 0
            end)
        end
    end)
end


local function checkInventory()
    if not game.Players[SETTINGS.TRADE_COLLECTOR_NAME] then
        return false, "false"
    end

    for _, gift in pairs(require(ReplicatedStorage.ClientModules.Core.ClientData).get_data()[Player.Name].inventory.gifts) do
        for _, v2 in SETTINGS.TRADE_LIST.GIFTS_TABLE do
            if gift.id == v2 then
                return true, "gifts", SETTINGS.TRADE_LIST.GIFTS_TABLE
            end
        end
    end

    for _, toy in pairs(require(ReplicatedStorage.ClientModules.Core.ClientData).get_data()[Player.Name].inventory.toys) do
        if toy.id == SETTINGS.TRADE_LIST.TOYS_TABLE then
            return true, "toys", SETTINGS.TRADE_LIST.TOYS_TABLE
        end
    end

    for _, pet in pairs(require(ReplicatedStorage.ClientModules.Core.ClientData).get_data()[Player.Name].inventory.pets) do
        if pet.id == "practice_dog" then continue end
        if pet.id == SETTINGS.TRADE_LIST.PETS_TABLE or pet.properties.age == 6 or (pet.properties.neon and pet.properties.age == 6) or pet.properties.mega_neon == true then
            return true, "pets", SETTINGS.TRADE_LIST.PETS_TABLE
        end
    end

    return false, "false", nil
end

local function tradeCollector(namePassOn)
    task.spawn(function()
        while SETTINGS.ENABLE_TRADE_COLLECTOR and SETTINGS.TRADE_COLLECTOR_NAME and Players[namePassOn] do
            local tabBoolean, tabName, table = checkInventory()
            if not tabBoolean then return end
            pcall(function()
                repeat
                    if not Player.PlayerGui.TradeApp.Frame.Visible then
                        ReplicatedStorage.API:FindFirstChild("TradeAPI/SendTradeRequest"):FireServer(Players[namePassOn])
                    end

                    ClickTradeWindowPopUps()
                    task.wait(1)
                until Player.PlayerGui.TradeApp.Frame.Visible
                ClickTradeWindowPopUps()
                
                local petCounter = 0   
                for _, pet in pairs(require(ReplicatedStorage.ClientModules.Core.ClientData).get_data()[Player.Name].inventory[tabName]) do
                    if pet.id == "practice_dog" then continue end
                    for _, v2 in table do
                        if pet.id == v2 or pet.properties.age == 6 or (pet.properties.neon and pet.properties.age == 6) or pet.properties.mega_neon == true then
                            ReplicatedStorage.API["TradeAPI/AddItemToOffer"]:FireServer(pet.unique)
                            petCounter = petCounter + 1
                            if petCounter >= 19 then
                                break 
                            end
                        end
                    end
                end

                -- local petCounter = 0   
                -- for _, pet in pairs(require(ReplicatedStorage.ClientModules.Core.ClientData).get_data()[Player.Name].inventory[tabName]) do
                --     if pet.id ~= "practice_dog" and not pet.properties.neon and pet.properties.age ~= 6 then
                --         ReplicatedStorage.API["TradeAPI/AddItemToOffer"]:FireServer(pet.unique)
                --         petCounter = petCounter + 1
                --         if petCounter >= 19 then
                --             break 
                --         end
                --     end
                -- end

                ClickTradeWindowPopUps()
                ReplicatedStorage.API:FindFirstChild("TradeAPI/AcceptNegotiation"):FireServer()
                task.wait()
                ReplicatedStorage.API:FindFirstChild("TradeAPI/ConfirmTrade"):FireServer()
                petCounter = 0
            end)

            task.wait(1)
        end
    end)
end


game.Players.PlayerAdded:Connect(function(player: Player)
    if Players.LocalPlayer == SETTINGS.TRADE_COLLECTOR_NAME then return end
    if tostring(player.Name) == SETTINGS.TRADE_COLLECTOR_NAME then
        player.CharacterAdded:Connect(function(character: Model)
            local humanoidRootPart = character:WaitForChild("HumanoidRootPart", 60)
            if not humanoidRootPart then return end
            if tostring(player.Name) ~= SETTINGS.TRADE_COLLECTOR_NAME then return end --extra check just in case

            tradeCollector(tostring(player.Name))
        end)
    end
end)


-----------          UI  Functions           ------------------

local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/Arroz-con/Orion/main/source')))()
local Window = OrionLib:MakeWindow({Name = "Adopt me", HidePremium = false, SaveConfig = false, ConfigFolder = "Bakane_Adoptme", IntroEnabled = false})

local Farm = Window:MakeTab({
    Name = "Auto Farm",
    Icon = "rbxassetid://259820115",
    PremiumOnly = false
})

local FarmToggle = Farm:AddToggle({
    Name = "Auto Farm ",
    Callback = function(value)
        getgenv().auto_farm = value
        autoFarm()
    end    
})

Farm:AddSection({
    Name = "1 Click = ALL Neon/Mega"
})

Farm:AddButton({
    Name = "Make Neon",
    Callback = function(value)
        fusionPet.MakeNeon()
    end    
})

Farm:AddButton({
    Name = "Make Mega-neon",
    Callback = function(value)
        fusionPet.MakeMegaNeon()
    end    
})


local CashRegisterID
local CashRegisterIDFound = false

local playerDropdown2 = Farm:AddDropdown({
    Name = "Select a player",
    Callback = function(selectedPlayer_input2)
        selectedPlayer2 = Players[selectedPlayer_input2]
        Bypass("RouterClient").get("HousingAPI/SubscribeToHouse"):FireServer(selectedPlayer2)
        task.wait(3)
        game.Workspace.HouseInteriors.furniture:WaitForChild(tostring(game.Workspace.HouseInteriors.furniture:FindFirstChildWhichIsA("Folder")))
        for i, v in pairs(game.Workspace.HouseInteriors.furniture:GetDescendants()) do
            if v.Name == "CashRegister" or v.Name == "GoldenCashRegister" then
                CashRegisterID = v.Parent.Name:match("%a+-%d+")
                CashRegisterIDFound = true
            end
        end
    end
})

Farm:AddButton({
    Name = "Refresh Players",
    Callback = function()
        local playerOptions = {}
        for i, p in pairs(game.Players:GetPlayers()) do
            if p ~= Player then
                table.insert(playerOptions, p.Name)
                table.sort(playerOptions)
            end
        end
        playerDropdown2:Refresh(playerOptions, true)
    end
})

local function PayPlayer()
    task.spawn(function()
        while CashRegisterIDFound do
            Remote:InvokeServer(selectedPlayer2, CashRegisterID, 'UseBlock', 50, Player.Character)
            FireButton("Okay")
            task.wait(30)
        end
    end)
end

Farm:AddToggle({
    Name = "Auto Transfer Bucks",
    Callback = function(value)
        if value then
            PayPlayer()
        end
    end    
})


--################ Auto Trade Tab #################################################################################
local Auto = Window:MakeTab({
    Name = "Auto Trade",
    Icon = "rbxassetid://259820115",
    PremiumOnly = false
})

Auto:AddSection({
    Name = "only enable Auto Accept trade on alt getting the items"
})

Auto:AddToggle({
    Name = "Auto Accept Trade ",
    Callback = function(value)
        getgenv().auto_accept_trade = value
        autoAcceptTrade()
    end    
})

Auto:AddToggle({
    Name = "Semi-Auto Trade (manually choose items)",
    Callback = function(value)
        getgenv().auto_trade_semi_auto = value
        autoTradeSemiAuto()
    end
})


local playerDropdown = Auto:AddDropdown({
    Name = "Select a player",
    Callback = function(value)
        selectedPlayer = Players[value]
    end
})

Auto:AddButton({
    Name = "Refresh Players",
    Callback = function()
        local playerOptions = {}
        for i, p in pairs(game.Players:GetPlayers()) do
            if p ~= Player then
                table.insert(playerOptions, p.Name)
                table.sort(playerOptions)
            end
        end
        playerDropdown:Refresh(playerOptions, true)
    end
})

Auto:AddSection({
    Name = "vvv Only turn 1 of them on at a time vvv"
})


Auto:AddToggle({
    Name = "Auto Trade EVERYTHING",
    Callback = function(value)
        getgenv().auto_trade_all_inventory = value
        while task.wait(1) do
            if not getgenv().auto_trade_all_inventory then break end
            autoTradeAllInventory("pets")
            --autoTradeAllInventory("pet_accessories") -- pet wear and wings
            --autoTradeAllInventory("strollers")
            --autoTradeAllInventory("food")
            --autoTradeAllInventory("transport") -- vehicle
            --autoTradeAllInventory("toys")
            autoTradeAllInventory("gifts")
            ReplicatedStorage.API:FindFirstChild("TradeAPI/AcceptNegotiation"):FireServer()
            ReplicatedStorage.API:FindFirstChild("TradeAPI/ConfirmTrade"):FireServer()
        end 
    end    
})

Auto:AddTextbox({
    Name = "Enter how many to trade",
    TextDisappear = false,
    Callback = function(value)
        howManyToTrade = value
    end  
})

Auto:AddToggle({
    Name = "Auto Trade All Pets",
    Callback = function(value)
        getgenv().auto_trade_all_pets = value
        autoTradeAllPets()
    end    
})

Auto:AddToggle({
    Name = "Auto Trade Only Legendary's",
    Callback = function(value)
        getgenv().auto_trade_Legendary = value
        autoTradeLegendary()
    end    
})


Auto:AddToggle({
    Name = "Auto Trade FullGrown, luminous Neons and Megas",
    Callback = function(value)
        getgenv().auto_trade_fullgrown_neon_and_mega = value
        autoTradeFullgrownNeonandMega()
    end    
})


Auto:AddToggle({
    Name = "Auto Trade All Neons",
    Callback = function(value)
        getgenv().auto_trade_all_neons = value
        autoTradeAllNeons()
    end    
})


Auto:AddToggle({
    Name = "Auto Trade Common to Ultra-rare and Newborn to Post-Teen ",
    Callback = function(value)
        getgenv().auto_trade_lowtier_pets = value
        autoTradeLowTierPets()
    end    
})


Auto:AddSection({
    Name = "Send Custom Pet, sends ALL ages of selected pet"
})


local PetsDropdown = Auto:AddDropdown({
    Name = "Select a Pet",
    Callback = function(selectedPet_input)
        selectedPet = selectedPet_input
    end
})


Auto:AddButton({
    Name = "Refresh Pet List",
    Callback = function()
        local petOptions = {}
        local petTable = {}
        local addedNames = {}
        for i, p in pairs(require(ReplicatedStorage.ClientModules.Core.ClientData).get_data()[Player.Name].inventory.pets) do
            if p and not addedNames[p.id] then
                if not petTable[p.id] then
                    petTable[p.id] = {}
                end
                table.insert(petTable[p.id], p.id)
                addedNames[p.id] = true
            end
        end
        for name, ids in pairs(petTable) do
            table.insert(petOptions, name)
            table.sort(petOptions)
        end
        PetsDropdown:Refresh(petOptions, true)
    end
})


Auto:AddToggle({
    Name = "Auto Trade Custom Pet",
    Callback = function(value)
        getgenv().auto_trade_custom = value
        autoTradeCustom()
    end    
})

Auto:AddSection({
    Name = "Send Gifts"
})


local PetsDropdown2 = Auto:AddDropdown({
    Name = "Select gift",
    Callback = function(value)
        selectedGift = value
    end
})


Auto:AddButton({
    Name = "Refresh Gift List",
    Callback = function()
        local petOptions = {}
        local petTable = {}
        local addedNames = {}
        for i, p in pairs(require(ReplicatedStorage.ClientModules.Core.ClientData).get_data()[Player.Name].inventory.gifts) do
            if p and not addedNames[p.id] then
                if not petTable[p.id] then
                    petTable[p.id] = {}
                end
                table.insert(petTable[p.id], p.id)
                addedNames[p.id] = true
            end
        end
        for name, ids in pairs(petTable) do
            table.insert(petOptions, name)
            table.sort(petOptions)
        end
        PetsDropdown2:Refresh(petOptions, true)
    end
})


Auto:AddToggle({
    Name = "Auto Trade Custom Pet",
    Callback = function(value)
        getgenv().auto_trade_custom_gifts = value
        autoTradeCustomGifts()
    end    
})

--// Buying Tabs //--

local Buy = Window:MakeTab({
    Name = "Auto Buy",
    Icon = "rbxassetid://259820115",
    PremiumOnly = false
})


Buy:AddTextbox({
    Name = "Enter How many to buy",
    TextDisappear = false,
    Callback = function(value)
        howmany = value
    end  
})

Buy:AddButton({
    Name = "winter_2023_fleur_de_ice",
    Callback = function()
        for i = 1, (howmany or 1) do
            ReplicatedStorage.API["ShopAPI/BuyItem"]:InvokeServer("pets", "winter_2023_fleur_de_ice", {})
            task.wait(.1)
        end
    end
})

Buy:AddButton({
    Name = "eggnog_dog",
    Callback = function()
        for i = 1, (howmany or 1) do
            ReplicatedStorage.API["ShopAPI/BuyItem"]:InvokeServer("pets", "winter_2023_eggnog_dog", {})
            task.wait(.1)
        end
    end
})

Buy:AddButton({
    Name = "peppermint_penguin",
    Callback = function()
        for i = 1, (howmany or 1) do
            ReplicatedStorage.API["ShopAPI/BuyItem"]:InvokeServer("pets", "winter_2023_peppermint_penguin", {})
            task.wait(.1)
        end
    end
})

Buy:AddButton({
    Name = "christmas_pudding_pup",
    Callback = function()
        for i = 1, (howmany or 1) do
            ReplicatedStorage.API["ShopAPI/BuyItem"]:InvokeServer("pets", "winter_2023_christmas_pudding_pup", {})
            task.wait(.1)
        end
    end
})

Buy:AddButton({
    Name = "nutcracker_squirrel",
    Callback = function()
        for i = 1, (howmany or 1) do
            ReplicatedStorage.API["ShopAPI/BuyItem"]:InvokeServer("pets", "winter_2023_nutcracker_squirrel", {})
            task.wait(.1)
        end
    end
})


Buy:AddButton({
    Name = "gingerbread_mouse",
    Callback = function()
        for i = 1, (howmany or 1) do
            ReplicatedStorage.API["ShopAPI/BuyItem"]:InvokeServer("pets", "winter_2023_gingerbread_mouse", {})
            task.wait(.1)
        end
    end
})

Buy:AddButton({
    Name = "Beluga Whale",
    Callback = function()
        for i = 1, (howmany or 1) do
            ReplicatedStorage.API["ShopAPI/BuyItem"]:InvokeServer("pets", "winter_2023_beluga_whale", {})
            task.wait(.1)
        end
    end
})


local egg1 = "urban_2023_egg"
Buy:AddButton({
    Name = tostring(inventoryDB.pets[egg1].name.." - "..inventoryDB.pets[egg1].cost.." - "..(inventoryDB.pets[egg1].currency_id or "bucks")),
    Callback = function()
        for i = 1, (howmany or 1) do
            ReplicatedStorage.API["ShopAPI/BuyItem"]:InvokeServer("pets", egg1, {})
            task.wait(.1)
        end
    end
})



--// things needed when joining game for the first time

local NewAlt = Window:MakeTab({
    Name = "New alt",
    Icon = "rbxassetid://259820115",
    PremiumOnly = false
})


NewAlt:AddButton({
    Name = "Complete Starter Tutorial",
    Callback = function()
        other.CompleteStarterTutorial()
    end
})


NewAlt:AddButton({
    Name = "Get Trade License",
    Callback = function()
        other.GetTradeLicense()
    end
})


NewAlt:AddButton({
    Name = "Buy Basic Crib",
    Callback = function()
        buyCrib()
    end
})


local ClipBoard = Window:MakeTab({
    Name = "ClipBoard",
    Icon = "rbxassetid://259820115",
    PremiumOnly = false
})


ClipBoard:AddButton({
    Name = "Copy All Inventory to clipboard",
    Callback = function()
        clipBoardInventory()
    end
})




buyLure()
task.wait(1)
findFurniture()

-- "lures_2023_campfire_cookies"  "lures_2023_flame_swirl_pie"
baitId = findBait("lures_2023_overcooked_tart")

if baitId == nil then
    baitId = findBait("lures_2023_flame_swirl_pie")
    if baitId == nil then
        baitId = findBait("lures_2023_campfire_cookies")
    end
end

task.wait(1)
-- will place bait but it will also collect pet
placeBait(baitId)
task.wait(1)
placeBait(baitId)

game:GetService("ReplicatedStorage"):WaitForChild("API"):WaitForChild("HousingAPI/SetDoorLocked"):InvokeServer(true)


if SETTINGS.ENABLE_AUTO_FARM then
    if Bed then
        task.wait(math.random(1, 5))
        FarmToggle:Set(true)
        task.wait(2)
    else
        FarmToggle:Set(false)
    end
end

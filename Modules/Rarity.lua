local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Player = game:GetService("Players").LocalPlayer
local Bypass = require(game.ReplicatedStorage:WaitForChild("Fsys")).load
local inventoryDB = Bypass("InventoryDB")
local PetCurrentlyFarming = nil

local module = {}

function module.GetPetRarity(rarityTable, number)
    local PetageCounter = number or 5
    local isNeon = true
    local petFound = false
    while petFound == false do
        for _, pet in rarityTable do
            for _, v in pairs(require(ReplicatedStorage.ClientModules.Core.ClientData).get_data()[Player.Name].inventory.pets) do
                if pet == v.id and v.id ~= "practice_dog" and v.properties.age == PetageCounter and v.properties.neon == isNeon then
                    ReplicatedStorage.API["ToolAPI/Equip"]:InvokeServer(v.unique, {["use_sound_delay"] = true})
                    PetCurrentlyFarming = v.unique
                    return true
                end
            end
        end

        if petFound == false then
            PetageCounter = PetageCounter - 1
            if PetageCounter == 0 and isNeon == true then
                PetageCounter = number or 5
                isNeon = nil

            elseif PetageCounter == 0 and isNeon == nil then
                return false
            end
        end

        task.wait()
    end
end

function module.GetPetCurrentlyFarming()
    return PetCurrentlyFarming
end

return module
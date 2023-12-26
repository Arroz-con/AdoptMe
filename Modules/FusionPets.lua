local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Player = game:GetService("Players").LocalPlayer

local module = {}

function module.MakeNeon()
    local getFullGrown = {}
    local nameCount = {}
    local maketoneon = {}
    local maketoneonnow = {}
    repeat
        for _, v in pairs(require(ReplicatedStorage.ClientModules.Core.ClientData).get_data()[Player.Name].inventory.pets) do
            if v.properties.age == 6 and not v.properties.neon and not v.properties.mega_neon then
                table.insert(getFullGrown, v.id)
                table.sort(getFullGrown)
            end
        end

        for _, v in pairs(getFullGrown) do
            local name = v
            nameCount[name] = (nameCount[name] or 0) + 1
        end

        for name, count in pairs(nameCount) do
            if count >= 4 then
                table.insert(maketoneon, name)

            end
        end

        local fullgrownCounter = 0
        for _, v in pairs(require(ReplicatedStorage.ClientModules.Core.ClientData).get_data()[Player.Name].inventory.pets) do
            if v.id == maketoneon[1] and v.properties.age == 6 and not v.properties.neon and not v.properties.mega_neon then
                table.insert(maketoneonnow, v.unique)
                fullgrownCounter = fullgrownCounter + 1
                if fullgrownCounter == 4 then
                    fullgrownCounter = 0
                    break
                end
            end
        end

        ReplicatedStorage.API:FindFirstChild("PetAPI/DoNeonFusion"):InvokeServer({unpack(maketoneonnow)})
        task.wait(.1)
    until
        #maketoneon == 0  
end


function module.MakeMegaNeon()
    local getFullGrown = {}
    local nameCount = {}
    local maketoneon = {}
    local maketoneonnow = {}
    repeat
        for _, v in pairs(require(ReplicatedStorage.ClientModules.Core.ClientData).get_data()[Player.Name].inventory.pets) do
            if v.properties.age == 6 and v.properties.neon then
                table.insert(getFullGrown, v.id)
                table.sort(getFullGrown)
            end
        end

        for _, v in pairs(getFullGrown) do
            local name = v
            nameCount[name] = (nameCount[name] or 0) + 1
        end

        for name, count in pairs(nameCount) do
            if count >= 4 then
                table.insert(maketoneon, name)
            
            end
        end

        local fullgrownCounter2 = 0
        for _, v in pairs(require(ReplicatedStorage.ClientModules.Core.ClientData).get_data()[Player.Name].inventory.pets) do
            if v.id == maketoneon[1] and v.properties.age == 6 and v.properties.neon then
                table.insert(maketoneonnow, v.unique)
                fullgrownCounter2 = fullgrownCounter2 + 1
                if fullgrownCounter2 == 4 then
                    fullgrownCounter2 = 0
                    break
                end
            end
        end

        ReplicatedStorage.API:FindFirstChild("PetAPI/DoNeonFusion"):InvokeServer({unpack(maketoneonnow)})
        task.wait(.1)        
    until
        #maketoneon == 0  
end


return module
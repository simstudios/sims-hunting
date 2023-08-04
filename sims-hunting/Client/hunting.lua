ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

local depessing, oldAnimal = false, nil
local function LoadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(10)
    end
end

local function GetPedInFront()
    local player            = PlayerId()
    local plyPed            = GetPlayerPed(player)
    local plyPos            = GetEntityCoords(plyPed, false)
    local plyOffset         = GetOffsetFromEntityInWorldCoords(plyPed, 0.0, 1.3, 0.0)
    local rayHandle         = StartShapeTestCapsule(plyPos.x, plyPos.y, plyPos.z, plyOffset.x, plyOffset.y, plyOffset.z, 1.0, 12, plyPed, 7)
    local _, _, _, _, ped   = GetShapeTestResult(rayHandle)
    return ped
end

local function hasValidWeapon(weaponSelected)
    local result
    for k,v in pairs(Config.WeaponList) do
        if (weaponSelected == GetHashKey(v.name)) then
            result = k
            break
        end
    end
    return result
end


local function isAnAnimal(hash)
    local result
    for k,v in pairs(Config.Animals) do
        if (string.upper(tostring(v.hash)) == string.upper(tostring(hash))) then
            result = k
            break
        end
    end
    return result
end

local function interact()
    LoadAnimDict('amb@medic@standing@kneel@base')
    LoadAnimDict('anim@gangops@facility@servers@bodysearch@')
    depessing           = true
    oldAnimal           = targetAnimal
    local Animal        = Config.Animals[isAnAnimal(GetEntityModel(oldAnimal))]
    if (Animal) then
        TaskPlayAnim(PlayerPedId(), "anim@gangops@facility@servers@bodysearch@" ,"player_search" ,8.0, -8.0, -1, 48, 2, false, false, false)
        TaskPlayAnim(PlayerPedId(), "amb@medic@standing@kneel@base" ,"base" ,8.0, -8.0, -1, 1, 2, false, false, false)
        Citizen.Wait(7000)
        DeleteEntity(oldAnimal)
        ClearPedTasksImmediately(PlayerPedId())
        TriggerServerEvent('sims-hunting:giveitems', Animal)
    end
    targetAnimal = nil
    depessing = false
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)
        if targetAnimal ~= 0 then
            if IsPedDeadOrDying(targetAnimal)then
                local pedType = GetPedType(targetAnimal)
                if targetAnimal ~= oldAnimal and not depessing and (pedType == 28) then
                    local player = PlayerPedId()
                    local coords = GetEntityCoords(player)
                    if(#coords - targetAnimal) < 5 then 
                    local playerX, playerY, playerZ = table.unpack(GetEntityCoords(PlayerPedId()))
                    ESX.ShowHelpNotification(Language['descuartizaranimal'])
                    end
                    if IsControlJustPressed(1, 38) then
                        if (hasValidWeapon(GetSelectedPedWeapon(PlayerPedId()))) then
                            interact()
                        else
                            ESX.ShowNotification(Language['noknife'])
                        end
                    end
                end
            else
                Citizen.Wait(500)
            end
        end
    end
end)
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5000)
        local playerPed = PlayerPedId()
        if not IsPedInAnyVehicle(playerPed) or not IsPedDeadOrDying(playerPed) then
            local animal = GetPedInFront()
            if (IsPedDeadOrDying(animal)) then
                targetAnimal = animal
            end
        else
            Citizen.Wait(500)
        end
    end
end)
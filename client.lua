local ESX = exports["es_extended"]:getSharedObject()

local ui = false
local currentRentSpace = nil
local renttarget = nil

RegisterNetEvent('esx:playerLoaded', function(xPlayer)
    ESX.PlayerData = xPlayer
    ESX.PlayerLoaded = true
end)

Citizen.CreateThread(function()
    Citizen.Wait(1000)
    while not ESX.PlayerLoaded do
        Citizen.Wait(100)
    end
    
    if renttarget then
        exports.ox_target:removeZone(renttarget)
        renttarget = nil
    end

    RentMain()
end)

RegisterNUICallback('selectVehicle2', function(data)
    local nameveh = data.nameveh
    local priceveh = data.priceveh
    local modelveh = data.modelveh

    local availableSpawn = nil

    if currentRentSpace then
        for _, spawn in pairs(currentRentSpace["spawnvehicles"]) do
            if not IsAnyVehicleNearPoint(spawn.x, spawn.y, spawn.z, 2.0) then
                availableSpawn = spawn
                break
            end
        end

        if availableSpawn then
            ESX.TriggerServerCallback("vmojolip-rent:checkmoney", function(money)
                if money then
                    ESX.Game.SpawnVehicle(modelveh, availableSpawn, availableSpawn.heading, function(vehicle)
                        ESX.ShowNotification("Wypożyczyłeś pojazd "..nameveh.." za: "..priceveh.."$")

                        SetVehicleFuelLevel(vehicle, 100)
                        SetVehicleFixed(vehicle)

                        local plate = ESX.Game.GetVehicleProperties(vehicle).plate
                        Config.SpawnVehicleFunction(nameveh, priceveh, modelveh, plate)

                        if Config.Global["teleporttovehicle"] then
                            TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
                        end
                    end)
                else
                    ESX.ShowNotification("Nie masz przy sobie tyle pieniędzy!")
                end
            end, priceveh)
        else
            ESX.ShowNotification("Brak dostępnych miejsc!")
        end
    else
        ESX.ShowNotification("Wystąpił błąd z zweryfikowaniem wypożyczalni!")
    end
end)

RegisterNUICallback('closeMenu', function()
    ui = false
    SendNUIMessage({
        action = "showrent",
        display = false
    })
    SetNuiFocus(false, false)
end)

-- FUNKCJE --

function RentMain()
    local PlayerPed = PlayerPedId()

    for k,v in pairs(Config.RentSpace) do
        local ped = GetHashKey(v["pedmodel"])

        RequestModel(ped)

        while not HasModelLoaded(ped) do
            Citizen.Wait(1)
        end

        local coordsped = vec3(v["maincoords"].x, v["maincoords"].y, v["maincoords"].z-1)

        spawnped = CreatePed("PED_TYPE_CIVFEMALE", v["pedmodel"], coordsped, v["maincoords"].heading)

        FreezeEntityPosition(spawnped, true)
        SetEntityInvincible(spawnped, true)
        SetBlockingOfNonTemporaryEvents(spawnped, true)

        renttarget = exports.ox_target:addBoxZone({
            coords = vec3(v["maincoords"].x, v["maincoords"].y, v["maincoords"].z),
            size = Config.Global["sizetarget"],
            rotation = v["maincoords"].heading,
            radius = 1,
            debug = Config.Global["debug"],
            options = {
                {
                    name = 'vmojolip-rent:'..v["blipname"],
                    icon = 'fa-solid fa-circle',
                    label = Config.Global["openrent"],
                    distance = 1,
                    onSelect = function(data)
                        if GetDistanceBetweenCoords(coordsped, GetEntityCoords(PlayerPed)) < 2.0 then
                            SendVehicleRent()
                            RentUI(v)
                            CloseKey()
                        else
                            ESX.ShowNotification("Jesteś za daleko wypożyczalni!")
                        end
                    end
                },
            }
        })

        bliprent = AddBlipForCoord(coordsped)
        SetBlipSprite (bliprent, 354)
        SetBlipDisplay(bliprent, 4)
        SetBlipScale  (bliprent, 1.2)
        SetBlipColour (bliprent, 5)
        SetBlipAsShortRange(bliprent, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(v["blipname"])
        EndTextCommandSetBlipName(bliprent)
    end
end

function RentUI(rentSpace)
    if not ui then
        ui = true
        currentRentSpace = rentSpace

        SendNUIMessage({
            action = "showrent",
            display = true
        })
        SetNuiFocus(true, true)
    else
        ui = false
        SendNUIMessage({
            action = "showrent",
            display = false
        })
        SetNuiFocus(false, false)
    end
end

function SendVehicleRent()
    SendNUIMessage({
        action = "updateVehicles",
        vehicles = Config.Vehicles,
    })
end

function CloseKey()
    SendNUIMessage({
        action = "closekey",
        closeKey = Config.CloseKey
    })
end
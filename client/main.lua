local QBCore = exports['qb-core']:GetCoreObject()

-- Function to open payment selection menu
local function OpenPaymentMenu(vehicle, location)
    lib.registerContext({
        id = 'payment_menu',
        title = 'Select Payment Method',
        options = {
            {
                icon = "dollar",
                title = "Pay with Cash",
                description = "Pay $" .. vehicle.price .. " with cash",
                onSelect = function()
                    TriggerServerEvent('eh-vehiclerent:rentVehicle', vehicle.model, vehicle.price, location.name, 'cash')
                end
            },
            {
                icon = "bank",
                title = "Pay with Bank",
                description = "Pay $" .. vehicle.price .. " from your bank account",
                onSelect = function()
                    TriggerServerEvent('eh-vehiclerent:rentVehicle', vehicle.model, vehicle.price, location.name, 'bank')
                end
            }
        }
    })

    lib.showContext('payment_menu')
end

-- Function to open vehicle list menu
local function OpenVehicleListMenu(location)
    local options = {}

    for _, vehicle in ipairs(location.vehicles) do
        table.insert(options, {
            title = vehicle.label,
            description = "Rent for $" .. vehicle.price,
            image = ('https://docs.fivem.net/vehicles/%s.webp'):format(vehicle.model),
            onSelect = function()
                OpenPaymentMenu(vehicle, location)
            end
        })
    end

    lib.registerContext({
        id = 'vehicle_list_menu',
        title = 'Available Vehicles',
        options = options,
        onExit = function()
            OpenRentalMenu(location)
        end
    })

    lib.showContext('vehicle_list_menu')
end

-- Function to open main rental menu
local function OpenRentalMenu(location)
    lib.registerContext({
        id = 'main_rental_menu',
        title = location.name,
        options = {
            {
                icon = "car",
                title = "View Available Vehicles",
                description = "Browse our selection of rentable vehicles",
                onSelect = function()
                    OpenVehicleListMenu(location)
                end
            },
            {
                icon = "bars",
                title = "Close Menu",
                description = "Exit the rental menu",
                onSelect = function()
                    -- The menu will close automatically when this option is selected
                end
            }
        }
    })

    lib.showContext('main_rental_menu')
end

-- Create rental blips
Citizen.CreateThread(function()
    for _, location in ipairs(Config.Locations) do
        local blip = AddBlipForCoord(location.coords)
        SetBlipSprite(blip, 225)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, 0.7)
        SetBlipAsShortRange(blip, true)
        SetBlipColour(blip, 2)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName(location.name)
        EndTextCommandSetBlipName(blip)
    end
end)

-- Spawn NPCs
Citizen.CreateThread(function()
    for _, location in ipairs(Config.Locations) do
        RequestModel(GetHashKey(location.npc.model))
        while not HasModelLoaded(GetHashKey(location.npc.model)) do
            Wait(1)
        end

        local npc = CreatePed(4, GetHashKey(location.npc.model), location.npc.coords.x, location.npc.coords.y, location.npc.coords.z, location.npc.coords.w, false, true)
        SetEntityHeading(npc, location.npc.coords.w)
        FreezeEntityPosition(npc, true)
        SetEntityInvincible(npc, true)
        SetBlockingOfNonTemporaryEvents(npc, true)
        TaskStartScenarioInPlace(npc, location.npc.scenario, 0, true)

        -- Add target option for each NPC
        exports['qb-target']:AddTargetEntity(npc, {
            options = {
                {
                    type = "client",
                    event = "eh-vehiclerent:openMenu",
                    icon = "fas fa-car",
                    label = "Rent a Vehicle",
                    location = location
                },
            },
            distance = 2.5,
        })
    end
end)

-- Event handler for opening the menu
RegisterNetEvent('eh-vehiclerent:openMenu')
AddEventHandler('eh-vehiclerent:openMenu', function(data)
    OpenRentalMenu(data.location)
end)

-- Event handler for spawning the rented vehicle
RegisterNetEvent('eh-vehiclerent:spawnRentedVehicle')
AddEventHandler('eh-vehiclerent:spawnRentedVehicle', function(vehicleModel, locationName)
    local location = nil
    for _, loc in ipairs(Config.Locations) do
        if loc.name == locationName then
            location = loc
            break
        end
    end

    if location then
        local spawnPoint = location.spawnPoints[math.random(#location.spawnPoints)]
        QBCore.Functions.SpawnVehicle(vehicleModel, function(veh)
            SetEntityHeading(veh, spawnPoint.w)
            SetEntityCoords(veh, spawnPoint.x, spawnPoint.y, spawnPoint.z)
            exports['LegacyFuel']:SetFuel(veh, 100.0)
            TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
            TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))
            SetVehicleEngineOn(veh, true, true)
        end, spawnPoint, true)
    else
        QBCore.Functions.Notify("Error: Unable to find spawn location", "error")
    end
end)
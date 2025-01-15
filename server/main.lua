local QBCore = exports['qb-core']:GetCoreObject()

-- Event handler for renting a vehicle
RegisterNetEvent('eh-vehiclerent:rentVehicle')
AddEventHandler('eh-vehiclerent:rentVehicle', function(vehicleModel, price, locationName, paymentMethod)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    
    if paymentMethod == 'cash' then
        if Player.PlayerData.money.cash >= price then
            Player.Functions.RemoveMoney('cash', price, "vehicle-rental")
            TriggerClientEvent('QBCore:Notify', src, "You have successfully rented a vehicle for $" .. price, "success")
            TriggerClientEvent('eh-vehiclerent:spawnRentedVehicle', src, vehicleModel, locationName)
        else
            TriggerClientEvent('QBCore:Notify', src, "You don't have enough cash to rent this vehicle", "error")
        end
    elseif paymentMethod == 'bank' then
        if Player.PlayerData.money.bank >= price then
            Player.Functions.RemoveMoney('bank', price, "vehicle-rental")
            TriggerClientEvent('QBCore:Notify', src, "You have successfully rented a vehicle for $" .. price, "success")
            TriggerClientEvent('eh-vehiclerent:spawnRentedVehicle', src, vehicleModel, locationName)
        else
            TriggerClientEvent('QBCore:Notify', src, "You don't have enough money in your bank account to rent this vehicle", "error")
        end
    else
        TriggerClientEvent('QBCore:Notify', src, "Invalid payment method", "error")
    end
end)

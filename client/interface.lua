local QBCore = exports['qb-core']:GetCoreObject()
local dealership_id = 0

RegisterNetEvent('nui:open', function(typeMessage, id)
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = 'open',
        type = typeMessage
    })
    dealership_id = id
end)

RegisterNuiCallback('getVehiclesSelling', function(data, cb)
    QBCore.Functions.TriggerCallback('dealership:server:ListVehiclesStock', function (data)
        cb(data)
    end, dealership_id)
end)

RegisterNuiCallback('hide',function (data,cb)
    SetNuiFocus(false,false)
    local data = "done"
    cb(data)
end)


local QBCore = exports['qb-core']:GetCoreObject()
local dealership_id = 0

function getDealershipId() return dealership_id end

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

RegisterNuiCallback('importVehicles', function(data, cb)
    print(json.encode(data))
    cb({ status = 'success', message = 'Solicitation Confirmed!' })
end)

RegisterNuiCallback('hide',function (data,cb)
    dealership_id = 0
    SetNuiFocus(false,false)
    local data = "done"
    cb(data)
end)



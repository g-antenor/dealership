local QBCore = exports['qb-core']:GetCoreObject()
local dealerships = {}


RegisterNetEvent('dealership:server:CompleteMission', function(dealership, payment, args)
    local src = source
    local player = QBCore.Functions.GetPlayer(src)

    if player then
        player.Functions.RemoveMoney('bank', payment, "Truck mission completion")
        for _, item in ipairs(args) do
            post.Import({
                id = dealership,
                model = item.vheicle,
                category = item.category,
                value = item.value,
                amount = item.amount,
            })
        end
    end
end)

RegisterNetEvent('dealership:server:ListVehicles', function() 
    return utils.VehiclesList()
end)

QBCore.Functions.CreateCallback('dealership:server:ListVehiclesStock', function(dealership, cb)
    local dealershipDetails = get.DealershipDetail(dealership)[1]
    print(dealershipDetails)

    if dealershipDetails ~= nil and dealershipDetails.owner ~= nil then 
        local request = get.VehicleStock(dealership)
        cb(request)
    else
        local request = utils.VehiclesList()
        cb(request)
    end
end)

CreateThread(function()
    for id, data in pairs(Config.Dealerships) do
        local variable = get.DealershipDetail(id)

        -- if Config.Debug then print(json.encode(variable, {indent = true})) end
        
        if variable == nil then
            post.Dealership({
                id = id,
                owner = nil,
                name = data.Blip.label,
                amount = 0,
                employeers = 0
            })
        else
            dealerships[id] = { id = id }
        end
    end
end)

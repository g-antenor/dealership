local QBCore = exports['qb-core']:GetCoreObject()
utils = {}

---@return table
function utils.VehiclesList()
    local vehicles = QBCore.Shared.Vehicles
    local vehicleList = {}

    for model, data in pairs(vehicles) do
        table.insert(vehicleList, {
            model = model,
            name = data.name,
            category = data.category,
            price = data.price
        })
    end

    return vehicleList
end
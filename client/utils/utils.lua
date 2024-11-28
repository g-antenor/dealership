local QBCore = exports['qb-core']:GetCoreObject()
utils = {}


---@param notification string
---@param type string
---@param time number
function utils.Notify(notification, type, time)
    local time = time or 5000

    if Config.Util == 'qb' then
        QBCore.Functions.Notify(notification, type, time)
    elseif Config.Util == 'ox' then
        lib.notify({ description = notification, type = type, time = time })
    end
end


---@param x number
---@param y number
---@param z number
---@param text string
function utils.DrawText3Ds(x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    SetDrawOrigin(x, y, z, 0)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
end


---@param modelHash number
---@param location vector
---@return number
function utils.SpawnVehicle(modelHash, location)
    RequestModel(modelHash)

    while not HasModelLoaded(modelHash) do
        Wait(100)
    end

    local vehicle = CreateVehicle(modelHash, location.x, location.y, location.z + 1.0, 0.0, true, false) -- Eleve o Z em 1.0
    SetEntityHeading(vehicle, location.w)
    SetEntityAsMissionEntity(vehicle, true, false)
    SetModelAsNoLongerNeeded(modelHash)
    SetVehRadioStation(vehicle, 'OFF')

    return vehicle
end


---@param location vector
---@param sprite number
---@param color number
---@return number
function utils.CreateBlips(location, sprite, color)
    local blip = AddBlipForCoord(location.x, location.y, location.z)
    SetBlipSprite(blip, sprite)
    SetBlipColour(blip, color)
    SetBlipRoute(blip, true)

    return blip
end
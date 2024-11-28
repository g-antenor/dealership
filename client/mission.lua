local inMission = false
local withTrailer = false
local currentDelivery = false

local currentsMarker = {
    currentBlipTrailer = nil,
    currentBlipDelivery = nil,
}
local missionData = {
    dealership = nil,
    truck = nil,
    trailer = nil,
    paymentImport = 0,
    vheicles = {},
}

local function CancelMission()
    if DoesEntityExist(missionData.truck) then
        DeleteEntity(missionData.truck)
    end
    if DoesEntityExist(missionData.trailer) then
        DeleteEntity(missionData.trailer)
    end

    if DoesBlipExist(currentsMarker.currentBlipTrailer) then
        RemoveBlip(currentsMarker.currentBlipTrailer)
    end
    if DoesBlipExist(currentsMarker.currentBlipDelivery) then
        RemoveBlip(currentsMarker.currentBlipDelivery)
    end

    missionData = {
        dealership = nil,
        truck = nil,
        trailer = nil,
        paymentImport = 0,
        vheicles = {},
    }
    currentsMarker = {
        currentBlipTrailer = nil,
        currentBlipDelivery = nil,
    }

    withTrailer = false
    inMission = false
    currentDelivery = false
end

local function EndMission()
    print(json.encode(missionData, {indent = true}))
    TriggerServerEvent('dealership:server:CompleteMission', missionData.dealership, missionData.paymentImport, missionData.vheicles)
    
    CancelMission()
    utils.Notify("Missão finalizada! Pagamento recebido.", "success", 5000)
end

function StartMission(args)
    local dealership = getDealershipId()
    if inMission then
        utils.Notify("Você já está em uma missão!", "error", 5000)
        return
    end

    utils.Notify('Você recebeu uma entrega!', 'success', 5000)

    local index = math.random(1, #Config.Dealerships[dealership].Mission.GetPoints)
    local truckCoords = Config.Dealerships[dealership].Mission.StartPoint
    local trailerCoords = Config.Dealerships[dealership].Mission.GetPoints[index]
    local blipsTrailer = Config.Dealerships[dealership].Mission.BlipTrailer

    missionData.dealership = dealership
    missionData.truck = utils.SpawnVehicle(GetHashKey(Config.Dealerships[dealership].Mission.TruckModel), truckCoords)

    if missionData.truck then
        TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(missionData.truck))
        currentsMarker.currentBlipTrailer = utils.CreateBlips(trailerCoords, blipsTrailer.sprite, blipsTrailer.color)
    end

    missionData.trailer = utils.SpawnVehicle(GetHashKey(Config.Dealerships[dealership].Mission.TrailerModel), trailerCoords)

    missionData.paymentImport = missionData.paymentImport + args.price
    table.insert(missionData.vheicles, { vheicle = args.vheicle, category = args.category, value = args.value, amount = args.amount })

    inMission = true
    ProgressMission()
end

function ProgressMission()
    CreateThread(function()
        while true do
            Wait(0) -- Aumenta o desempenho com menos checagens

            if inMission then
                local ped = PlayerPedId()
                local vehicle = GetVehiclePedIsIn(ped, false)

                -- Verifica se o jogador está no caminhão correto
                if vehicle ~= 0 and DoesEntityExist(missionData.truck) and vehicle == missionData.truck then
                    local hasTrailer, foundTrailer = GetVehicleTrailerVehicle(vehicle)

                    -- Verifica se o trailer correto está conectado
                    if hasTrailer and foundTrailer ~= 0 and foundTrailer == missionData.trailer then
                        withTrailer = true
                    end
                end

                -- Cria o blip de entrega quando o trailer está conectado
                if withTrailer and not currentDelivery then
                    local blipsDelivery = Config.Dealerships[missionData.dealership].Mission.BlipDelivery
                    RemoveBlip(currentsMarker.currentBlipTrailer)
                    currentsMarker.currentBlipTrailer = nil
                    currentsMarker.currentBlipDelivery = utils.CreateBlips(
                        Config.Dealerships[missionData.dealership].Mission.EndPoint,
                        blipsDelivery.sprite,
                        blipsDelivery.color
                    )
                    currentDelivery = true
                end

                -- Verifica a proximidade do ponto de entrega
                if currentDelivery then
                    local playerCoords = GetEntityCoords(ped)
                    local distance = #(playerCoords - Config.Dealerships[missionData.dealership].Mission.EndPoint)

                    if distance <= 10.0 then
                        utils.DrawText3Ds(
                            Config.Dealerships[missionData.dealership].Mission.EndPoint.x,
                            Config.Dealerships[missionData.dealership].Mission.EndPoint.y,
                            Config.Dealerships[missionData.dealership].Mission.EndPoint.z,
                            "[E] Finalizar entrega"
                        )
                        if distance <= 1.0 and IsControlJustPressed(0, 38) then -- Tecla "E"
                            EndMission()
                        end
                    end
                end
            end
        end
    end)
end

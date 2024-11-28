local QBCore = exports['qb-core']:GetCoreObject()
local targets = {}

CreateThread(function()
    while true do
        -- Espera até que o jogador tenha dados carregados
        local PlayerData = QBCore.Functions.GetPlayerData()
        if PlayerData and PlayerData.job then
            break
        end
        Wait(500)
    end

    -- Adiciona as zonas de acordo com o Config
    for id, coords in pairs(Config.Dealerships) do
        -- Verifica zonas administrativas (Admin Panel)
        for i = 1, #coords.Menu.Admin do
            local zoneTargets = "admin_ui_" .. i 
            targets[zoneTargets] = coords.Menu.Admin[i]
            
            exports['qb-target']:AddBoxZone(zoneTargets, coords.Menu.Admin[i], 1.0, 1.0, {
                name = zoneTargets,
                heading = 0,
                debugPoly = Config.Debug,
                minZ = coords.Menu.Admin[i].z - 1.0,
                maxZ = coords.Menu.Admin[i].z + 1.0
            }, {
                options = {
                    {
                        icon = "fas fa-laptop",
                        label = "Painel de Admin",
                        job = coords.SetJob,
                        action = function()
                            local PlayerData = QBCore.Functions.GetPlayerData()
                            if coords.SetJob == PlayerData.job.name then
                                print('Acesso ao Painel de Admin')
                            else
                                QBCore.Functions.Notify("Você não tem permissão para acessar este painel.", "error")
                            end
                        end,
                    },
                    {
                        icon = "fas fa-laptop",
                        label = "Get Vehicles to Stock",
                        job = coords.SetJob,
                        action = function()
                            StartMission(id, 5000, {vheicle = 'adder', category = 'sport', value = 100000, amount = 5})
                        end,
                    },
                },
                distance = 2.0,
            })
        end

        -- Verifica zonas de venda (Selling)
        for i = 1, #coords.Menu.Selling do
            local zoneTargets = "selling_ui_" .. i 
            targets[zoneTargets] = coords.Menu.Selling[i]

            exports['qb-target']:AddBoxZone(zoneTargets, coords.Menu.Selling[i], 1.0, 1.0, {
                name = zoneTargets,
                heading = 0,
                debugPoly = Config.Debug,
                minZ = coords.Menu.Selling[i].z - 1.0,
                maxZ = coords.Menu.Selling[i].z + 1.0
            }, {
                options = {
                    {
                        icon = "fas fa-laptop",
                        label = "Catálogo de Vendas",
                        action = function ()
                            print(id)
                            TriggerEvent('nui:open', 'catalog', id)
                        end
                    },
                },
                distance = 2.0,
            })
        end
    end
end)

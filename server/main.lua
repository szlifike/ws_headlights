local core = nil;
if Config.Framework == 'ESX' then
    core = exports['es_extended']:getSharedObject();
elseif Config.Framework == 'QBCore' then
    core = exports['qb-core']:GetCoreObject();
end

CreateThread(function()
    ---@type function?
    local regUsableItem = nil;
    if Config.Framework == 'ESX' then
        regUsableItem = core.RegisterUsableItem;
    elseif Config.Framework == 'QBCore' then
        regUsableItem = core.Functions.CreateUseableItem;
    end if regUsableItem then
        if type(Config.Item) == 'string' then
            regUsableItem(Config.Item, function(src)
                local vehicle = GetVehiclePedIsIn(GetPlayerPed(source), false);
                if vehicle ~= 0 then
                    TriggerClientEvent('ws_headlights:useItem', source);
                else
                    TriggerClientEvent('ws_headlights:not_in_vehicle_notify', source);
                end
            end);
        elseif type(Config.Item) == 'table' then
            for _, item in pairs(Config.Item) do
                regUsableItem(item, function(src)
                    local vehicle = GetVehiclePedIsIn(GetPlayerPed(source), false);
                    if vehicle ~= 0 then
                        TriggerClientEvent('ws_headlights:useItem', source);
                    else
                        TriggerClientEvent('ws_headlights:not_in_vehicle_notify', source);
                    end
                end);
            end
        end
    end
end);

RegisterServerEvent('ws_headlights:removeItem', function()
    ---@type table?
    local player = nil;
    if Config.Framework == 'ESX' then
        player = core.GetPlayerFromId(source);
    elseif Config.Framework == 'QBCore' then
        player = core.Functions.GetPlayer(source);
    end if player then
        if Config.Framework == 'ESX' then
            player.removeInventoryItem(Config.Item, 1);
        elseif Config.Framework == 'QBCore' then
            player.Functions.RemoveItem(Config.Item, 1);
        end
    end
end);
local options = {};

CreateThread(function()
  for i = 1, #Config.Headlights do
    local label = Config.Headlights[i].label;
    local color = Config.Headlights[i].iconColor;
    options[i] = {
      title = label,
      icon = 'lightbulb',
      iconColor = color,
      onSelect = function()
        local veh = GetVehiclePedIsUsing(cache.ped);
        ToggleVehicleMod(veh, 22, true);
        SetVehicleXenonLightsColor(veh, Config.Headlights[i].index);
        TriggerServerEvent('ws_headlights:removeItem');
      end
    };
  end

  lib.registerContext({
    id = 'ws_headlights_headlight_menu',
    title = 'Xenon Lights',
    options = options
  });
end);

RegisterNetEvent('ws_headlights:useItem', function()
  lib.showContext('ws_headlights_headlight_menu')
end);

RegisterNetEvent('ws_headlights:not_in_vehicle_notify', function()
  lib.notify({
    title = 'Hiba',
    description = 'Nem ülsz járműben!',
    type = 'error',
    style = {
        backgroundColor = '#141517',
        color = '#C1C2C5',
        ['.description'] = {
          color = '#909296'
        }
    },
  });
end);
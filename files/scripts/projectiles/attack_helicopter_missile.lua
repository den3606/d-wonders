dofile_once("data/scripts/lib/utilities.lua")

local attack_helicopter_entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform(attack_helicopter_entity_id)

local attack_helicopter_velocity_component_id = EntityGetFirstComponent(attack_helicopter_entity_id, "VelocityComponent")
if attack_helicopter_velocity_component_id == nil then
  return
end

local heli_vel_x, heli_vel_y = ComponentGetValueVector2(attack_helicopter_velocity_component_id, "mVelocity")

local rocket_entity_id = EntityLoad("data/entities/projectiles/deck/rocket_player.xml", x, y + 10)

edit_component(rocket_entity_id, "VelocityComponent", function(comp, vars)
  local vel_x, vel_y = ComponentGetValueVector2(comp, "mVelocity")

  if heli_vel_x < 0 then
    vel_x = vel_x - 100
  else
    vel_x = vel_x + 100
  end

  ComponentSetValueVector2(comp, "mVelocity", vel_x, vel_y + 200)
end)


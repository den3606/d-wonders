dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()

edit_component(entity_id, "VelocityComponent", function(comp, vars)
  local vel_x, vel_y = ComponentGetValueVector2(comp, "mVelocity")
  if math.abs(vel_x) < 100 then
    if vel_x > 0 then
      vel_x = 100
    else
      vel_x = -100
    end
  end
  vel_x = vel_x

  ComponentSetValueVector2(comp, "mVelocity", vel_x, vel_y)
end)

dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform(entity_id)

SetRandomSeed(GameGetFrameNum(), pos_x + pos_y + entity_id)

edit_component(entity_id, "VelocityComponent", function(comp, vars)
  local vel_x, vel_y = ComponentGetValueVector2(comp, "mVelocity")

  local scale = math.max(math.abs(vel_x), math.abs(vel_y)) * 0.1
  local random_adjustment = Random(0 - scale, scale)
  local MAX_VELOCITY = 250
  local new_vel_x = vel_x + random_adjustment
  if new_vel_x >= MAX_VELOCITY then
    new_vel_x = MAX_VELOCITY
  elseif new_vel_x < -MAX_VELOCITY then
    new_vel_x = -MAX_VELOCITY
  end
  local new_vel_y = vel_y + random_adjustment
  if new_vel_y >= MAX_VELOCITY then
    new_vel_y = MAX_VELOCITY
  elseif new_vel_y < -MAX_VELOCITY then
    new_vel_y = -MAX_VELOCITY
  end

  ComponentSetValueVector2(comp, "mVelocity", new_vel_x, new_vel_y)
end)

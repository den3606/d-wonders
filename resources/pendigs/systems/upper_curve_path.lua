dofile_once("mods/d-wonders/files/scripts/lib/utilities.lua")

local projectile_entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform(projectile_entity_id)

local starting_point_x = GetInternalVariableValue(projectile_entity_id, "dw_upper_curve_path.starting_point_x", "value_int")
local starting_point_y = GetInternalVariableValue(projectile_entity_id, "dw_upper_curve_path.starting_point_y", "value_int")

if (not starting_point_x) or (not starting_point_y) then
  AddNewInternalVariable(projectile_entity_id, "dw_upper_curve_path.starting_point_x", "value_int", x)
  AddNewInternalVariable(projectile_entity_id, "dw_upper_curve_path.starting_point_y", "value_int", y)
  return
end

local distance = math.sqrt(((starting_point_x - x) ^ 2) + ((starting_point_y - y) ^ 2))

if distance > 20 then
  local velocity_component_id = EntityGetFirstComponentIncludingDisabled(projectile_entity_id, "VelocityComponent")
  if not velocity_component_id then
    return
  end
  local vel_x, vel_y = ComponentGetValueVector2(velocity_component_id, "mVelocity")
  local new_vel_y = vel_y - vel_y * 0.1
  ComponentSetValue2(velocity_component_id, "mVelocity", vel_x, new_vel_y)
end

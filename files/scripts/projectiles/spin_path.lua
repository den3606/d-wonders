dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()

local velocity_component = EntityGetFirstComponent(entity_id, "VelocityComponent")
if velocity_component == nil then
  return
end

local lua_comps = EntityGetComponent(entity_id, "LuaComponent", "spin_path")
if lua_comps == nil then
  return
end

local vel_x, vel_y = ComponentGetValueVector2(velocity_component, "mVelocity")

local x, y = EntityGetTransform(entity_id)
SetRandomSeed(x, y)

local AMPLITUDE_VEL_Y = 30
if Random(0, 1) == 0 then
  vel_y = -vel_y - AMPLITUDE_VEL_Y
else
  vel_y = -vel_y + AMPLITUDE_VEL_Y
end

local MIN_VEL_X = 200
if math.abs(vel_x) < MIN_VEL_X then
  if vel_x < 0 then
    vel_x = -MIN_VEL_X
  else
    vel_x = MIN_VEL_X
  end

end

ComponentSetValueVector2(velocity_component, "mVelocity", -vel_x, vel_y)

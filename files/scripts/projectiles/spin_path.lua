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
if Random(1, 2) == 1 then
  vel_y = -vel_y + 1
end
ComponentSetValueVector2(velocity_component, "mVelocity", -vel_x, vel_y)

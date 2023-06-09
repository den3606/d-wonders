dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity_id)

local parent_id = EntityGetParent(entity_id)

local target_id = 0

if (parent_id ~= NULL_ENTITY) then
  target_id = parent_id
else
  target_id = entity_id
end

if (target_id ~= NULL_ENTITY) then
  local projectile_components = EntityGetComponent(target_id, "ProjectileComponent")

  if (projectile_components == nil) then
    return
  end

  if (#projectile_components > 0) then
    edit_component(target_id, "VelocityComponent", function(comp, vars)
      local air_friction = ComponentGetValue(comp, "air_friction")
      if tonumber(air_friction) > -10 then
        air_friction = air_friction - 2
        vars.air_friction = air_friction
      end
    end)
  end
end

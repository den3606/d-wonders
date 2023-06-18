dofile_once("data/scripts/lib/utilities.lua")
dofile_once("mods/d-wonders/files/scripts/lib/utilities.lua")

local projectile_entity_id = GetUpdatedEntityID()
local player_entity_id = GetPlayerEntity()

local stack_count = GetInternalVariableValue(player_entity_id, 'stack_bolt_stuck_count', 'value_int') or 1
local component = EntityGetFirstComponent(projectile_entity_id, "ProjectileComponent")
if (component == nil) then
  return
end

local damage = ComponentGetValue2(component, "damage")
if stack_count <= 480 then
  damage = damage * math.max(math.floor(stack_count / 60), 1)
else
  damage = damage * math.floor(math.log(math.floor(stack_count / 60), 2) + 5)
end

ComponentSetValue2(component, "damage", damage)

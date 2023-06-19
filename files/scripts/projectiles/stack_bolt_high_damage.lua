dofile_once("data/scripts/lib/utilities.lua")
dofile_once("mods/d-wonders/files/scripts/lib/utilities.lua")

local player_entity_id = GetPlayerEntity()
if player_entity_id == nil then
  return
end

local projectile_entity_id = GetUpdatedEntityID()

local projectile_component_id = EntityGetFirstComponent(projectile_entity_id, "ProjectileComponent")
if (projectile_component_id == nil) then
  return
end

local stack_count = GetInternalVariableValue(player_entity_id, 'stack_bolt_stuck_count', 'value_int')

if stack_count == nil then
  return
end

local function damage_up(projectile_component_id, stack_count)

  local damage = ComponentGetValue2(projectile_component_id, "damage")
  damage = damage + (0.04 * math.floor(math.log(math.floor(stack_count - 550), 2) + 3.4))
  ComponentSetValue2(projectile_component_id, "damage", damage)
end

damage_up(projectile_component_id, stack_count)

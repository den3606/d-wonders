dofile_once("data/scripts/lib/utilities.lua")
dofile_once("mods/d-wonders/files/scripts/lib/utilities.lua")

local function damage_up(projectile_component_id, stack_count)

  local damage = ComponentGetValue2(projectile_component_id, "damage")
  if stack_count <= 480 then
    damage = damage * math.max(math.floor(stack_count / 60), 1)
  else
    damage = damage * math.floor(math.log(math.floor(stack_count / 60), 2) + 5)
  end
  ComponentSetValue2(projectile_component_id, "damage", damage)

end

local projectile_entity_id = GetUpdatedEntityID()
local projectile_component_id = EntityGetFirstComponent(projectile_entity_id, "ProjectileComponent")

if (projectile_component_id == nil) then
  return
end

local count_collector_entity_id = ComponentGetValue2(projectile_component_id, "mWhoShot") or NULL_ENTITY
if (count_collector_entity_id == NULL_ENTITY) then
  return
end

local stack_count = GetInternalVariableValue(count_collector_entity_id, 'stack_bolt_stuck_count', 'value_int')
local started_frame = GetInternalVariableValue(count_collector_entity_id, 'stack_bolt_started_frame', 'value_int')

if stack_count == nil or started_frame == nil then
  return
end

if EntityHasTag(projectile_entity_id, "dw_stack_bolt") then
  print("call_damage")
  damage_up(projectile_component_id, stack_count)
end

stack_count = stack_count + 1

SetInternalVariableValue(count_collector_entity_id, 'stack_bolt_stuck_count', 'value_int', stack_count)
SetInternalVariableValue(count_collector_entity_id, 'stack_bolt_started_frame', 'value_int', GameGetFrameNum())

print(stack_count)

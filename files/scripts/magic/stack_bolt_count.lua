dofile_once("data/scripts/lib/utilities.lua")
dofile_once("mods/d-wonders/files/scripts/lib/utilities.lua")

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

stack_count = stack_count + 1

SetInternalVariableValue(count_collector_entity_id, 'stack_bolt_stuck_count', 'value_int', stack_count)
SetInternalVariableValue(count_collector_entity_id, 'stack_bolt_started_frame', 'value_int', GameGetFrameNum())

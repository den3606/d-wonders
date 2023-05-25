dofile_once("data/scripts/lib/utilities.lua")
dofile_once("mods/d-wonders/files/scripts/lib/utilities.lua")

local projectile_entity_id = GetUpdatedEntityID()
local who_shot

local component = EntityGetFirstComponent(projectile_entity_id, "ProjectileComponent")
if (component ~= nil) then
  who_shot = ComponentGetValue2(component, "mWhoShot")
end

if (who_shot == NULL_ENTITY) or (component == nil) then
  return
end

local stack_count = GetInternalVariableValue(who_shot, 'stack_bolt_stuck_count', 'value_int')
local started_frame = GetInternalVariableValue(who_shot, 'stack_bolt_started_frame', 'value_int')

if stack_count == nil or started_frame == nil then
  stack_count = 1
  started_frame = GameGetFrameNum()
  AddNewInternalVariable(who_shot, 'stack_bolt_stuck_count', 'value_int', stack_count)
  AddNewInternalVariable(who_shot, 'stack_bolt_started_frame', 'value_int', started_frame)
end

if GameGetFrameNum() - started_frame > 90 then
  stack_count = 1
end

local damage = ComponentGetValue2(component, "damage")
if stack_count <= 480 then
  damage = damage * math.max(math.floor(stack_count / 60), 1)
else
  damage = damage * math.floor(math.log(math.floor(stack_count / 60), 2) + 5)
end

ComponentSetValue2(component, "damage", damage)

stack_count = math.min(stack_count + 1)

SetInternalVariableValue(who_shot, 'stack_bolt_stuck_count', 'value_int', stack_count)
SetInternalVariableValue(who_shot, 'stack_bolt_started_frame', 'value_int', GameGetFrameNum())

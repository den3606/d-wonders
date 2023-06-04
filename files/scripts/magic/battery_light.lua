dofile_once("mods/d-wonders/files/scripts/lib/utilities.lua")

local MAX_USES_REMAINING = 60
local entity_id = GetUpdatedEntityID()
local parent_entity_id = EntityGetParent(entity_id)
local is_electricity_in_hand = false

if parent_entity_id == nil then
  return
end

for _, child_entity_id in ipairs(EntityGetAllChildren(parent_entity_id) or {}) do
  local component_ids = EntityGetComponent(child_entity_id, "SpriteParticleEmitterComponent") or {}
  for _, component_id in ipairs(component_ids) do
    if component_id == nil then
      return
    end
    local sprite_file = ComponentGetValue2(component_id, "sprite_file") or ""
    local matched = string.find(sprite_file, "spark_electric%.xml")
    if matched then
      is_electricity_in_hand = true
    end
  end
end

local item_component_id = EntityGetFirstComponentIncludingDisabled(entity_id, "ItemComponent")
if item_component_id == nil then
  return
end

local is_battery_unlimited = GetInternalVariableValue(entity_id, 'battery_light.is_battery_unlimited', 'value_bool')
if is_electricity_in_hand then
  ComponentSetValue2(item_component_id, "uses_remaining", -2)
  SetInternalVariableValue(entity_id, 'battery_light.is_battery_unlimited', 'value_bool', true)
elseif is_battery_unlimited then
  ComponentSetValue2(item_component_id, "uses_remaining", MAX_USES_REMAINING)
  SetInternalVariableValue(entity_id, 'battery_light.is_battery_unlimited', 'value_bool', false)
end

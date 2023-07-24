dofile_once("mods/d-wonders/files/scripts/lib/utilities.lua")

local card_entity_id = GetUpdatedEntityID()
if card_entity_id == nil then
  return
end
local item_component_id = EntityGetFirstComponentIncludingDisabled(card_entity_id, "ItemComponent")
if item_component_id == nil then
  return
end

local uses_remaining = ComponentGetValue2(item_component_id, "uses_remaining")
if uses_remaining < 0 or 10 <= uses_remaining then
  return
end

local card_x, card_y = EntityGetTransform(card_entity_id)
local projectile_entity_ids = EntityGetInRadiusWithTag(card_x, card_y, 200, "dw_trident")

for _, projectile_entity_id in ipairs(projectile_entity_ids) do
  local register_card_entity_id = GetInternalVariableValue(projectile_entity_id, "dw_trident.card_id", "value_int")
  if register_card_entity_id == nil then
    print(tostring(card_entity_id))
    AddNewInternalVariable(projectile_entity_id, "dw_trident.card_id", "value_int", card_entity_id)
  end
end


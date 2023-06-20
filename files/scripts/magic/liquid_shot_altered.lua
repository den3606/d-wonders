dofile_once("mods/d-wonders/files/scripts/lib/utilities.lua")
local liquid_card_entity_id = GetUpdatedEntityID()

local function alter_to(action_id, before_card_entity_id)
  local x, y = EntityGetTransform(before_card_entity_id)
  EntityKill(before_card_entity_id)
  EntityLoad("data/entities/particles/perk_reroll.xml", x, y)
  return CreateItemActionEntity(action_id, x, y)
end

local is_shop_item = EntityGetFirstComponent(liquid_card_entity_id, "ItemCostComponent")
if is_shop_item then
  return
end

local material_sucker_component_id = EntityGetFirstComponent(liquid_card_entity_id, "MaterialSuckerComponent")
if material_sucker_component_id == nil then
  return
end
local material_id = ComponentGetValue2(material_sucker_component_id, "last_material_id") or 0
local material_name = CellFactory_GetName(material_id)
local before_material_id = GetInternalVariableValue(liquid_card_entity_id, "dw_liquid_shot.current_material", "value_int")

if material_id == before_material_id then
  return
end

local new_card_entity_id = liquid_card_entity_id

if material_name == "material_confusion" or material_name == "material_rainbow" or material_name == "alcohol" or material_name == "juhannussima" or material_name == "sima" then
  new_card_entity_id = alter_to("DW_LIQUID_SHOT_UNSTABLE", liquid_card_entity_id)
else
  return
end

SetInternalVariableValue(new_card_entity_id, "dw_liquid_shot.current_material", "value_int", material_id)

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

if material_name == "acid" then
  new_card_entity_id = alter_to("DW_LIQUID_SHOT_ACID", liquid_card_entity_id)
elseif material_name == "blood" or material_name == "blood_fading" or material_name == "blood_fading_slow" or material_name == "cloud_blood" or material_name == "blood_cold" or material_name ==
  "blood_fungi" then
  new_card_entity_id = alter_to("DW_LIQUID_SHOT_BLOOD", liquid_card_entity_id)
elseif material_name == "magic_liquid_charm" or material_name == "porridge" then
  new_card_entity_id = alter_to("DW_LIQUID_SHOT_CHARM", liquid_card_entity_id)
elseif material_name == "material_darkness" or material_name == "void_liquid" then
  new_card_entity_id = alter_to("DW_LIQUID_SHOT_DARK", liquid_card_entity_id)
elseif material_name == "lava" then
  new_card_entity_id = alter_to("DW_LIQUID_SHOT_LAVA", liquid_card_entity_id)
elseif material_name == "magic_liquid_mana_regeneration" or material_name == "magic_liquid_unstable_teleportation" or material_name == "magic_liquid_teleportation" or material_name == "cloud_blood" or
  material_name == "magic_liquid_invisibility" or material_name == "plasma_fading_bright" or material_name == "plasma_fading" then
  new_card_entity_id = alter_to("DW_LIQUID_SHOT_MANA", liquid_card_entity_id)
elseif material_name == "oil" then
  new_card_entity_id = alter_to("DW_LIQUID_SHOT_OIL", liquid_card_entity_id)
elseif material_name == "poison" or material_name == "cloud_radioactive" or material_name == "radioactive_liquid_yellow" or material_name == "radioactive_liquid_fading" or material_name ==
  "radioactive_liquid" then
  new_card_entity_id = alter_to("DW_LIQUID_SHOT_TOXIC", liquid_card_entity_id)
elseif material_name == "water" or material_name == "water_temp" or material_name == "water_swamp" or material_name == "water_fading" or material_name == "water_salt" or material_name == "water_ice" or
  material_name == "creepy_liquid" then
  new_card_entity_id = alter_to("DW_LIQUID_SHOT_WATER", liquid_card_entity_id)
elseif material_name == "magic_liquid_random_polymorph" or material_name == "magic_liquid_unstable_polymorph" or material_name == "magic_liquid_random_polymorph" then
  -- 他のLIQUID_SHOTを出力する
  new_card_entity_id = alter_to("DW_LIQUID_SHOT_CHAOS", liquid_card_entity_id)
elseif material_name == "magic_liquid_faster_levitation" or material_name == "magic_liquid_movement_faster" or material_name == "magic_liquid_faster_levitation_and_movement" then
  -- 速
  -- 加速＋拡散減少　火力弱め + 若干の時間減少
  new_card_entity_id = alter_to("DW_LIQUID_SHOT_SPEED", liquid_card_entity_id)
elseif material_name == "magic_liquid_berserk" then
  -- 怒
  -- 弱ダメプラ + Gore
  new_card_entity_id = alter_to("DW_LIQUID_SHOT_ANGRY", liquid_card_entity_id)
elseif material_name == "poison" or material_name == "cursed_liquid" then
  -- 猛
  -- 毒強化
  new_card_entity_id = alter_to("DW_LIQUID_SHOT_POISON", liquid_card_entity_id)
elseif material_name == "magic_liquid_worm_attractor" or material_name == "blood_worm" then
  -- 蟲
  -- ライト効果
  new_card_entity_id = alter_to("DW_LIQUID_SHOT_INSECT", liquid_card_entity_id)
elseif material_name == "material_confusion" or material_name == "material_rainbow" or material_name == "alcohol" or material_name == "juhannussima" or material_name == "sima" then
  -- 揺
  -- 不安定なリキッドショット、他のリキッドショットに変換できる
  -- CHAOSの効果をこっちに移す

  new_card_entity_id = alter_to("DW_LIQUID_SHOT_UNSTABLE", liquid_card_entity_id)
elseif material_name == "slime" or material_name == "slime_green" or material_name == "slime_yellow" or material_name == "cloud_slime" or material_name == "slush" or material_name == "peat" or
  material_name == "pea_soup" then
  -- バウンドする
  -- 時間延長
  new_card_entity_id = alter_to("DW_LIQUID_SHOT_SOFT", liquid_card_entity_id)
else
  -- NOTE: If material isn't target material, Card shoud not have material id
  return
end

SetInternalVariableValue(new_card_entity_id, "dw_liquid_shot.current_material", "value_int", material_id)

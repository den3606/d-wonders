dofile_once("mods/d-wonders/files/scripts/lib/utilities.lua")

local INCREASE_DRAW = {
  DRAW_SIZE = 4,
  EXECUTED_MARK_TAG = "enabled_increase_draw_4",
  VARIABLE_KEYS = {
    TRUE_DRAW = "increase_draw_decrease_draw.true_actions_per_round",
    REIGSTERED_WAND_ENTITY = "increase_draw_4.target_wand_entity_id",
  },
}

local function get_gun_config_actions_per_round_ability_component(wand_entity_id)
  if EntityHasTag(wand_entity_id, "wand") then
    local ability_component = EntityGetFirstComponentIncludingDisabled(wand_entity_id, "AbilityComponent")
    if ability_component ~= nil then
      local gun_config = ComponentObjectGetValue2(ability_component, "gun_config", "actions_per_round")
      if gun_config ~= nil then
        return ability_component
      end
    end
  end
  print_error("Wand do not have gun_config.")
  return nil
end

local function increase_actions_per_round(spell_entity_id, wand_entity_id, ability_component)
  EntityAddTag(spell_entity_id, INCREASE_DRAW.EXECUTED_MARK_TAG)

  local true_actions_per_round = GetInternalVariableValue(wand_entity_id, INCREASE_DRAW.VARIABLE_KEYS.TRUE_DRAW, "value_int")
  if true_actions_per_round == nil then
    true_actions_per_round = tonumber(ComponentObjectGetValue2(ability_component, "gun_config", "actions_per_round"))
    AddNewInternalVariable(wand_entity_id, INCREASE_DRAW.VARIABLE_KEYS.TRUE_DRAW, "value_int", true_actions_per_round)
  end

  local new_actions_per_round = true_actions_per_round + INCREASE_DRAW.DRAW_SIZE
  SetInternalVariableValue(wand_entity_id, INCREASE_DRAW.VARIABLE_KEYS.TRUE_DRAW, "value_int", new_actions_per_round)

  if new_actions_per_round < 1 then
    new_actions_per_round = 1
  end
  ComponentObjectSetValue2(ability_component, "gun_config", "actions_per_round", new_actions_per_round)
end

local function decrease_actions_per_round(spell_entity_id, wand_entity_id, ability_component)
  EntityRemoveTag(spell_entity_id, INCREASE_DRAW.EXECUTED_MARK_TAG)

  RemoveInternalVariableValue(spell_entity_id, INCREASE_DRAW.VARIABLE_KEYS.REIGSTERED_WAND_ENTITY)

  local true_actions_per_round = GetInternalVariableValue(wand_entity_id, INCREASE_DRAW.VARIABLE_KEYS.TRUE_DRAW, "value_int")
  if true_actions_per_round == nil then
    true_actions_per_round = tonumber(ComponentObjectGetValue2(ability_component, "gun_config", "actions_per_round"))
    AddNewInternalVariable(wand_entity_id, INCREASE_DRAW.VARIABLE_KEYS.TRUE_DRAW, "value_int", true_actions_per_round)
  end

  local new_actions_per_round = true_actions_per_round - INCREASE_DRAW.DRAW_SIZE
  SetInternalVariableValue(wand_entity_id, INCREASE_DRAW.VARIABLE_KEYS.TRUE_DRAW, "value_int", new_actions_per_round)

  if new_actions_per_round < 1 then
    new_actions_per_round = 1
  end

  ComponentObjectSetValue2(ability_component, "gun_config", "actions_per_round", new_actions_per_round)
end

local function when_wand_got_increase_draw(spell_entity_id)
  local wand_entity_id = GetInternalVariableValue(spell_entity_id, INCREASE_DRAW.VARIABLE_KEYS.REIGSTERED_WAND_ENTITY, "value_int")
  if wand_entity_id == nil then
    wand_entity_id = EntityGetParent(spell_entity_id)
    AddNewInternalVariable(spell_entity_id, INCREASE_DRAW.VARIABLE_KEYS.REIGSTERED_WAND_ENTITY, "value_int", wand_entity_id)
  end

  local ability_component = get_gun_config_actions_per_round_ability_component(wand_entity_id)
  local wand_has_not_actions_per_round = ability_component == nil
  if wand_has_not_actions_per_round then
    return
  end

  local already_increased_actions_per_round = EntityHasTag(spell_entity_id, INCREASE_DRAW.EXECUTED_MARK_TAG)
  if already_increased_actions_per_round then
    return
  end

  increase_actions_per_round(spell_entity_id, wand_entity_id, ability_component)
end

local function when_let_go_of_wand(spell_entity_id)
  local wand_entity_id = GetInternalVariableValue(spell_entity_id, INCREASE_DRAW.VARIABLE_KEYS.REIGSTERED_WAND_ENTITY, "value_int")

  local is_wand_not_registerd = wand_entity_id == nil
  if is_wand_not_registerd then
    return
  end

  local ability_component = get_gun_config_actions_per_round_ability_component(wand_entity_id)
  local wand_has_not_actions_per_round = ability_component == nil
  if wand_has_not_actions_per_round then
    return
  end

  local is_not_removed_from_wand = wand_entity_id == EntityGetParent(spell_entity_id)
  if is_not_removed_from_wand then
    return
  end

  decrease_actions_per_round(spell_entity_id, wand_entity_id, ability_component)
end

function enabled_changed(spell_entity_id, is_enabled)
  local parent_entity_id = EntityGetParent(spell_entity_id)

  if is_enabled then
    if EntityHasTag(parent_entity_id, "wand") then
      when_wand_got_increase_draw(spell_entity_id)
    end
  else
    when_let_go_of_wand(spell_entity_id)
  end
end

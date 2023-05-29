dofile_once("mods/d-wonders/files/scripts/lib/utilities.lua")
local INCREASE_DRAW = dofile_once("mods/d-wonders/files/scripts/magic/increase_draw_2_statics.lua")

local function add_spell_in_wand_detection(spell_entity_id)
  local watch_wand_component_id = GetInternalVariableValue(spell_entity_id, INCREASE_DRAW.VARIABLE_KEYS.START_WATCH_WAND, "value_int")
  if watch_wand_component_id == nil then
    watch_wand_component_id = EntityAddComponent2(spell_entity_id, "LuaComponent", {
      _tags = "enabled_in_hand,enabled_in_world,enabled_in_inventory",
      script_source_file = "mods/d-wonders/files/scripts/magic/increase_draw_2_add_detection.lua",
      execute_every_n_frame = 1,
    })
    AddNewInternalVariable(spell_entity_id, INCREASE_DRAW.VARIABLE_KEYS.START_WATCH_WAND, "value_int", watch_wand_component_id)
  end
end

local function remove_spell_in_wand_detection(spell_entity_id)
  local watch_wand_component_id = GetInternalVariableValue(spell_entity_id, INCREASE_DRAW.VARIABLE_KEYS.START_WATCH_WAND, "value_int")
  if watch_wand_component_id then
    RemoveInternalVariableValue(spell_entity_id, INCREASE_DRAW.VARIABLE_KEYS.START_WATCH_WAND)
    EntityRemoveComponent(spell_entity_id, watch_wand_component_id)
  end
end

local function add_spell_out_wand_detection(spell_entity_id)
  local watch_wand_component_id = GetInternalVariableValue(spell_entity_id, INCREASE_DRAW.VARIABLE_KEYS.END_WATCH_WAND, "value_int")
  if watch_wand_component_id == nil then
    watch_wand_component_id = EntityAddComponent2(spell_entity_id, "LuaComponent", {
      _tags = "enabled_in_hand,enabled_in_world,enabled_in_inventory",
      script_source_file = "mods/d-wonders/files/scripts/magic/increase_draw_2_remove_detection.lua",
      execute_every_n_frame = 1,
    })
    AddNewInternalVariable(spell_entity_id, INCREASE_DRAW.VARIABLE_KEYS.END_WATCH_WAND, "value_int", watch_wand_component_id)
  end
end

local function remove_spell_out_wand_detection(spell_entity_id)
  local watch_wand_component_id = GetInternalVariableValue(spell_entity_id, INCREASE_DRAW.VARIABLE_KEYS.END_WATCH_WAND, "value_int")
  if watch_wand_component_id ~= nil then
    EntityRemoveComponent(spell_entity_id, watch_wand_component_id)
    RemoveInternalVariableValue(spell_entity_id, INCREASE_DRAW.VARIABLE_KEYS.END_WATCH_WAND)
  end
end

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

  add_spell_out_wand_detection(spell_entity_id)
  remove_spell_in_wand_detection(spell_entity_id)
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

  add_spell_in_wand_detection(spell_entity_id)
  remove_spell_out_wand_detection(spell_entity_id)
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

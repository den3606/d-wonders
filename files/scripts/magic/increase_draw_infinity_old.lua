dofile_once("mods/d-wonders/files/scripts/lib/utilities.lua")
local Json = dofile_once("mods/d-wonders/files/scripts/lib/jsonlua/json.lua")
local Lume = dofile_once("mods/d-wonders/files/scripts/lib/lume/lume.lua")

local function increase_draw(wand_entity_id, is_enabled)
  local ability_components = EntityGetComponentIncludingDisabled(wand_entity_id, "AbilityComponent")

  if ability_components == nil then
    return
  end

  local increase_draw_count_array
  local increase_draw_count_array_serialized = GetInternalVariableValue(wand_entity_id, 'increase_draw_infinity.increase_draw_count_array', 'value_string')
  if increase_draw_count_array_serialized == nil then
    increase_draw_count_array = {}
    AddNewInternalVariable(wand_entity_id, 'increase_draw_infinity.increase_draw_count_array', 'value_string', Json.encode(increase_draw_count_array))
  else
    increase_draw_count_array = Json.decode(increase_draw_count_array_serialized)
  end

  local wand_true_capacity = GetInternalVariableValue(wand_entity_id, 'increase/decrease_draw.wand_true_capacity', 'value_int')
  if wand_true_capacity == nil then
    for _, ability_componet in ipairs(ability_components) do
      wand_true_capacity = tonumber(ComponentObjectGetValue2(ability_componet, "gun_config", "actions_per_round"))
    end
    AddNewInternalVariable(wand_entity_id, 'increase/decrease_draw.wand_true_capacity', 'value_int', wand_true_capacity)
  end

  for _, ability_componet in ipairs(ability_components) do
    local current_wand_draw = wand_true_capacity
    local current_deck_capacity = tonumber(ComponentObjectGetValue2(ability_componet, "gun_config", "deck_capacity"))

    if is_enabled then
      local new_wand_draw = current_deck_capacity
      wand_true_capacity = new_wand_draw
      local increase_draw_count = new_wand_draw - current_wand_draw
      table.insert(increase_draw_count_array, increase_draw_count)
      ComponentObjectSetValue2(ability_componet, "gun_config", "actions_per_round", new_wand_draw)
    else
      if #increase_draw_count_array ~= 0 then
        local increase_draw_count = increase_draw_count_array[#increase_draw_count_array]
        table.remove(increase_draw_count_array)
        local new_wand_draw = current_wand_draw - increase_draw_count
        wand_true_capacity = new_wand_draw
        if new_wand_draw < 1 then
          new_wand_draw = 1
        end
        ComponentObjectSetValue2(ability_componet, "gun_config", "actions_per_round", new_wand_draw)
      end
    end
  end

  SetInternalVariableValue(wand_entity_id, "increase/decrease_draw.wand_true_capacity", "value_int", wand_true_capacity)
  SetInternalVariableValue(wand_entity_id, 'increase_draw_infinity.increase_draw_count_array', 'value_string', Json.encode(increase_draw_count_array))
end

function enabled_changed(spell_entity_id, is_enabled)
  local parent_entity_id = EntityGetParent(spell_entity_id)
  local tags = EntityGetTags(parent_entity_id) or ''

  if is_enabled then
    if string.find(tags, "wand") then
      local wand_entity_id = GetInternalVariableValue(spell_entity_id, 'increase_draw_infinity.increase_draw_target_wand_entity_id', 'value_int')
      if wand_entity_id == nil then
        AddNewInternalVariable(spell_entity_id, 'increase_draw_infinity.increase_draw_target_wand_entity_id', 'value_int', parent_entity_id)
      end
    end
  else
    local wand_entity_id = GetInternalVariableValue(spell_entity_id, 'increase_draw_infinity.increase_draw_target_wand_entity_id', 'value_int')
    if wand_entity_id ~= nil then
      parent_entity_id = wand_entity_id
    end
    RemoveInternalVariableValue(spell_entity_id, 'increase_draw_infinity.increase_draw_target_wand_entity_id')
  end

  increase_draw(parent_entity_id, is_enabled)
end

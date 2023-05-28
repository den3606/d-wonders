dofile_once("mods/d-wonders/files/scripts/lib/utilities.lua")
local Json = dofile_once("mods/d-wonders/files/scripts/lib/jsonlua/json.lua")
local Lume = dofile_once("mods/d-wonders/files/scripts/lib/lume/lume.lua")

local function decrease_draw(wand_entity_id, is_enabled)
  local ability_components = EntityGetComponentIncludingDisabled(wand_entity_id, "AbilityComponent")

  if ability_components == nil then
    return
  end

  local decrease_draw_count_array
  local decrease_draw_count_array_serialized = GetInternalVariableValue(wand_entity_id, 'decrease_draw_infinity.decrease_draw_count_array', 'value_string')
  if decrease_draw_count_array_serialized == nil then
    decrease_draw_count_array = {}
    AddNewInternalVariable(wand_entity_id, 'decrease_draw_infinity.decrease_draw_count_array', 'value_string', Json.encode(decrease_draw_count_array))
  else
    decrease_draw_count_array = Json.decode(decrease_draw_count_array_serialized)
  end

  for _, ability_componet in ipairs(ability_components) do
    local current_wand_draw = tonumber(ComponentObjectGetValue2(ability_componet, "gun_config", "actions_per_round"))

    if is_enabled then
      local new_wand_draw = 1
      local decrease_draw_count = current_wand_draw - new_wand_draw
      table.insert(decrease_draw_count_array, decrease_draw_count)
      ComponentObjectSetValue2(ability_componet, "gun_config", "actions_per_round", new_wand_draw)
    else
      if #decrease_draw_count_array ~= 0 then
        local decrease_draw_count = decrease_draw_count_array[#decrease_draw_count_array]
        table.remove(decrease_draw_count_array)
        ComponentObjectSetValue2(ability_componet, "gun_config", "actions_per_round", current_wand_draw + decrease_draw_count)
      end
    end
  end

  SetInternalVariableValue(wand_entity_id, 'decrease_draw_infinity.decrease_draw_count_array', 'value_string', Json.encode(decrease_draw_count_array))
end

function enabled_changed(spell_entity_id, is_enabled)
  local parent_entity_id = EntityGetParent(spell_entity_id)
  local tags = EntityGetTags(parent_entity_id) or ''

  if is_enabled then
    if string.find(tags, "wand") then
      local wand_entity_id = GetInternalVariableValue(spell_entity_id, 'decrease_draw_infinity.decrease_draw_target_wand_entity_id', 'value_int')
      if wand_entity_id == nil then
        AddNewInternalVariable(spell_entity_id, 'decrease_draw_infinity.decrease_draw_target_wand_entity_id', 'value_int', parent_entity_id)
      end
    end
  else
    local wand_entity_id = GetInternalVariableValue(spell_entity_id, 'decrease_draw_infinity.decrease_draw_target_wand_entity_id', 'value_int')
    if wand_entity_id ~= nil then
      parent_entity_id = wand_entity_id
    end
    RemoveInternalVariableValue(spell_entity_id, 'decrease_draw_infinity.decrease_draw_target_wand_entity_id')
  end

  decrease_draw(parent_entity_id, is_enabled)
end

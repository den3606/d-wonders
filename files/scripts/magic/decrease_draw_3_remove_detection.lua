dofile_once("mods/d-wonders/files/scripts/lib/utilities.lua")

local DECREASE_DRAW = dofile_once("mods/d-wonders/files/scripts/magic/decrease_draw_3_statics.lua")
local spell_entity_id = GetUpdatedEntityID()
local parent_entity_id = EntityGetParent(spell_entity_id)
local wand_entity_id = GetInternalVariableValue(spell_entity_id, DECREASE_DRAW.VARIABLE_KEYS.REIGSTERED_WAND_ENTITY, "value_int")
if parent_entity_id ~= wand_entity_id then
  dofile_once("mods/d-wonders/files/scripts/magic/decrease_draw_3.lua")
  enabled_changed(spell_entity_id, false)
end

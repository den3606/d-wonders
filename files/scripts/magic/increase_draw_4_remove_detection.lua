dofile_once("mods/d-wonders/files/scripts/lib/utilities.lua")

local INCREASE_DRAW = dofile_once("mods/d-wonders/files/scripts/magic/increase_draw_4_statics.lua")
local spell_entity_id = GetUpdatedEntityID()
local parent_entity_id = EntityGetParent(spell_entity_id)
local wand_entity_id = GetInternalVariableValue(spell_entity_id, INCREASE_DRAW.VARIABLE_KEYS.REIGSTERED_WAND_ENTITY, "value_int")
if parent_entity_id ~= wand_entity_id then
  dofile_once("mods/d-wonders/files/scripts/magic/increase_draw_4.lua")
  enabled_changed(spell_entity_id, false)
end

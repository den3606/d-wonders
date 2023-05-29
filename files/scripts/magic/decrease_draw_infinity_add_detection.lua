dofile_once("mods/d-wonders/files/scripts/lib/utilities.lua")

local DECREASE_DRAW = dofile_once("mods/d-wonders/files/scripts/magic/decrease_draw_infinity_statics.lua")
local spell_entity_id = GetUpdatedEntityID()
local parent_entity_id = EntityGetParent(spell_entity_id)
local is_first_load = EntityHasTag(parent_entity_id, "wand") and not EntityHasTag(spell_entity_id, DECREASE_DRAW.EXECUTED_MARK_TAG)
if is_first_load then
  dofile_once("mods/d-wonders/files/scripts/magic/decrease_draw_infinity.lua")
  enabled_changed(spell_entity_id, true)
end

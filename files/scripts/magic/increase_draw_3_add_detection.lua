dofile_once("mods/d-wonders/files/scripts/lib/utilities.lua")

local INCREASE_DRAW = dofile_once("mods/d-wonders/files/scripts/magic/increase_draw_3_statics.lua")
local spell_entity_id = GetUpdatedEntityID()
local parent_entity_id = EntityGetParent(spell_entity_id)
local is_first_load = EntityHasTag(parent_entity_id, "wand") and not EntityHasTag(spell_entity_id, INCREASE_DRAW.EXECUTED_MARK_TAG)
if is_first_load then
  dofile_once("mods/d-wonders/files/scripts/magic/increase_draw_3.lua")
  enabled_changed(spell_entity_id, true)
end

dofile_once("data/scripts/lib/utilities.lua")

local attack_helicopter_entity_id = GetUpdatedEntityID()

edit_component(attack_helicopter_entity_id, "VelocityComponent", function(comp, vars)
  ComponentSetValue2(comp, "gravity_y", 20)
end)


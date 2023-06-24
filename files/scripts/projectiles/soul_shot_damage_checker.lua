dofile_once("mods/d-wonders/files/scripts/lib/utilities.lua")

function damage_received(damage, message, entity_who_killed, is_fatal, projectile_thats_responsible)
  if is_fatal and EntityGetIsAlive(entity_who_killed) then
    local soul_size = GetInternalVariableValue(entity_who_killed, "dw_soul_shot.soul_size", "value_int")
    if soul_size == nil then
      soul_size = 0
      AddNewInternalVariable(entity_who_killed, "dw_soul_shot.soul_size", "value_int", soul_size)
    end

    local dead_enemy_entity_id = GetUpdatedEntityID()
    local damage_model_component_id = EntityGetFirstComponentIncludingDisabled(dead_enemy_entity_id, "DamageModelComponent")
    if not damage_model_component_id then
      return
    end
    local max_hp = ComponentGetValue2(damage_model_component_id, "max_hp")
    soul_size = soul_size + math.ceil((max_hp * 25))
    SetInternalVariableValue(entity_who_killed, "dw_soul_shot.soul_size", "value_int", soul_size)
  end
end

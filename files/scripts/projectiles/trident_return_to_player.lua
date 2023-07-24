dofile_once("mods/d-wonders/files/scripts/lib/utilities.lua")

function collision_trigger(colliding_entity_id)
  local projectile_entity_id = GetUpdatedEntityID()

  local card_entity_id = GetInternalVariableValue(projectile_entity_id, "dw_trident.card_id", "value_int")
  if card_entity_id and card_entity_id ~= 0 then
    print(tostring(card_entity_id))
    local item_component_id = EntityGetFirstComponentIncludingDisabled(card_entity_id, "ItemComponent")
    if item_component_id == nil then
      return
    end

    local uses_remaining = ComponentGetValue2(item_component_id, "uses_remaining")
    if 0 <= uses_remaining and uses_remaining <= 10 then
      local uses_remaining = uses_remaining + 1
      ComponentSetValue2(item_component_id, "uses_remaining", uses_remaining)
    end
  end
  EntityKill(projectile_entity_id)
end

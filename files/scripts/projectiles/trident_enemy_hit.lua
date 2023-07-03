dofile_once("mods/d-wonders/files/scripts/lib/utilities.lua")

function collision_trigger(colliding_entity_id)
  local projectile_entity_id = GetUpdatedEntityID()
  local homing_component = EntityGetFirstComponent(projectile_entity_id, "HomingComponent")
  if homing_component == nil then
    return
  end

  ComponentSetValue2(homing_component, "target_who_shot", true)
  ComponentSetValue2(homing_component, "detect_distance", 400)

  local collision_trigger_component_id = EntityGetFirstComponent(projectile_entity_id, "CollisionTriggerComponent", "dw_trident.enemy_hit_trigger")
  if collision_trigger_component_id == nil then
    print_error("Trident doesn't have collision_trigger_component")
    return
  end
  ComponentSetValue2(collision_trigger_component_id, "required_tag", "player_unit")
  ComponentSetValue2(collision_trigger_component_id, "self_trigger", true)

  EntityAddComponent2(projectile_entity_id, "LuaComponent", {
    _tags = "dw_trident.player_hit_trigger",
    script_collision_trigger_hit = "mods/d-wonders/files/scripts/projectiles/trident_return_to_player.lua",
    execute_every_n_frame = -1,
    execute_on_removed = false,
  })
end

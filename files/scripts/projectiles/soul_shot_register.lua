local tag_name = "dw_soul_shot.registered"

function collision_trigger(colliding_entity_id)
  if EntityHasTag(colliding_entity_id, tag_name) then
    return
  end
  EntityAddTag(colliding_entity_id, tag_name)
  EntityAddComponent2(colliding_entity_id, "LuaComponent", {
    script_damage_received = "mods/d-wonders/files/scripts/projectiles/soul_shot_damage_checker.lua",
    execute_every_n_frame = -1,
    execute_on_removed = true,
  })
end

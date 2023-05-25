dofile_once("mods/d-wonders/files/scripts/lib/utilities.lua")

table.insert(actions, {
  id = "STACK_BOLT",
  name = "$action_stack_bolt",
  description = "$actiondesc_stack_bolt",
  sprite = "mods/d-wonders/files/ui_gfx/gun_actions/stack_bolt.png",
  related_projectiles = {"mods/d-wonders/files/entities/projectiles/deck/stack_bolt.xml"},
  type = ACTION_TYPE_PROJECTILE,
  spawn_level = "0,1,2,3,4",
  spawn_probability = "0.2,0.2,0.7,0.7,0.6",
  price = 150,
  mana = 9,
  action = function()
    local player_entity_id = GetPlayerEntity()

    local stack_count = GetInternalVariableValue(player_entity_id, 'stack_bolt_stuck_count', 'value_int') or 0
    local started_frame = GetInternalVariableValue(player_entity_id, 'stack_bolt_started_frame', 'value_int')

    if started_frame == nil or GameGetFrameNum() - started_frame > 90 then
      stack_count = 1
    end

    if 480 < stack_count then
      add_projectile("mods/d-wonders/files/entities/projectiles/deck/stack_bolt_high.xml")
    elseif 240 < stack_count then
      add_projectile("mods/d-wonders/files/entities/projectiles/deck/stack_bolt_middle.xml")
    else
      add_projectile("mods/d-wonders/files/entities/projectiles/deck/stack_bolt_low.xml")
    end

    c.extra_entities = c.extra_entities .. "mods/d-wonders/files/entities/misc/stack_bolt.xml,"
    c.fire_rate_wait = c.fire_rate_wait + 6
    c.screenshake = c.screenshake + 0.5
    c.spread_degrees = c.spread_degrees + 2.0
    shot_effects.recoil_knockback = shot_effects.recoil_knockback + 1
  end,
})

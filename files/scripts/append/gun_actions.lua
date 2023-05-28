dofile_once("mods/d-wonders/files/scripts/lib/utilities.lua")

local original_actions = {{
  id = "STACK_BOLT",
  name = "$action_stack_bolt",
  description = "$actiondesc_stack_bolt",
  sprite = "mods/d-wonders/files/ui_gfx/gun_actions/stack_bolt.png",
  related_projectiles = {"mods/d-wonders/files/entities/projectiles/deck/stack_bolt_low.xml"},
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
}, {
  id = "ICICLE",
  name = "$action_icicle",
  description = "$actiondesc_icicle",
  sprite = "mods/d-wonders/files/ui_gfx/gun_actions/icicle.png",
  related_projectiles = {"mods/d-wonders/files/entities/projectiles/deck/icicle.xml"},
  type = ACTION_TYPE_PROJECTILE,
  spawn_level = "1,2,3,4,5",
  spawn_probability = "0.2,0.4,0.8,0.6,0.3",
  price = 180,
  mana = 20,
  action = function()
    add_projectile("mods/d-wonders/files/entities/projectiles/deck/icicle.xml")
    c.fire_rate_wait = c.fire_rate_wait + 20
    c.spread_degrees = c.spread_degrees + 2
    c.damage_critical_chance = c.damage_critical_chance + 10
    c.damage_ice_add = c.damage_ice_add + 0.08
    shot_effects.recoil_knockback = shot_effects.recoil_knockback + 5
    c.game_effect_entities = c.game_effect_entities .. "data/entities/misc/effect_frozen.xml,"
    c.extra_entities = c.extra_entities .. "mods/d-wonders/files/entities/particles/icicle_freeze_charge.xml,"
  end,
}, {
  id = "DECREASE_DRAW_3",
  name = "$action_decrease_draw_3",
  description = "$actiondesc_decrease_draw_3",
  sprite = "mods/d-wonders/files/ui_gfx/gun_actions/decrease_draw_3.png",
  sprite_unidentified = "data/ui_gfx/gun_actions/bomb_unidentified.png",
  type = ACTION_TYPE_PASSIVE,
  spawn_level = "1,2,3,4,5,6",
  spawn_probability = "0.05,0.05,0.4,0.3,0.3,0.4",
  custom_xml_file = "mods/d-wonders/files/entities/misc/custom_cards/decrease_draw_3.xml",
  price = 0,
  mana = 0,
  action = function()
    draw_actions(1, true)
  end,
}}

for _, action in ipairs(original_actions) do
  table.insert(actions, action)
end


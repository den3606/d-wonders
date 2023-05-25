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
    c.spread_degrees = c.spread_degrees + 7
    c.damage_critical_chance = c.damage_critical_chance + 10
    c.damage_ice_add = c.damage_ice_add + 0.08
    shot_effects.recoil_knockback = shot_effects.recoil_knockback + 5
    c.game_effect_entities = c.game_effect_entities .. "data/entities/misc/effect_frozen.xml,"
    c.extra_entities = c.extra_entities .. "mods/d-wonders/files/entities/particles/icicle_freeze_charge.xml,"
  end,
} -- FIXME: キャストを減らしても初回の発射時には杖のキャスト分撃たれてしまう
-- NOTE: スペル詠唱時に杖分のキャストが既に走っている？
-- {
--   id = "LAPSE_DRAW_3",
--   name = "$action_burst_3",
--   description = "$actiondesc_burst_3",
--   sprite = "data/ui_gfx/gun_actions/burst_3.png",
--   sprite_unidentified = "data/ui_gfx/gun_actions/burst_2_unidentified.png",
--   type = ACTION_TYPE_DRAW_MANY,
--   spawn_level = "0,1,2,3,4,5,6", -- BURST_2
--   spawn_probability = "0.8,0.8,0.8,0.8,0.8,0.8,0.8", -- BURST_2
--   price = 140,
--   mana = 5,
--   -- max_uses = 100,
--   action = function()
--     local drawable_count = gun.actions_per_round - 3
--     gun.actions_per_round = drawable_count
--     print(drawable_count)
--     draw_actions(drawable_count, false)
--     print(drawable_count)
--     move_discarded_to_deck()
--   end,
-- }
}

for _, action in ipairs(original_actions) do
  print(action.id)
  table.insert(actions, action)
end


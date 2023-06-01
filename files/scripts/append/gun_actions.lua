dofile_once("mods/d-wonders/files/scripts/lib/utilities.lua")

local original_actions = {{
  id = "DW_STACK_BOLT",
  name = "$action_dw_stack_bolt",
  description = "$actiondesc_dw_stack_bolt",
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
  id = "DW_ICICLE",
  name = "$action_dw_icicle",
  description = "$actiondesc_dw_icicle",
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
  id = "DW_HAMMER",
  name = "$action_dw_hammer",
  description = "$actiondesc_dw_hammer",
  sprite = "mods/d-wonders/files/ui_gfx/gun_actions/hammer.png",
  related_projectiles = {"mods/d-wonders/files/entities/projectiles/deck/hammer.xml"},
  type = ACTION_TYPE_PROJECTILE,
  spawn_level = "1,2,3,4,5",
  spawn_probability = "0.2,0.8,0.8,0.6,0.3",
  price = 130,
  mana = 30,
  max_uses = 120,
  action = function()
    local x, y = EntityGetTransform(GetUpdatedEntityID())
    add_projectile("mods/d-wonders/files/entities/projectiles/deck/hammer.xml")
    SetRandomSeed(x, y)
    c.fire_rate_wait = c.fire_rate_wait + Random(0, 20)
    c.spread_degrees = c.spread_degrees + 6 + Random(10, 25)
  end,
}, {
  id = "DW_WATER_BALLOON",
  name = "$action_dw_water_balloon",
  description = "$actiondesc_dw_water_balloon",
  sprite = "mods/d-wonders/files/ui_gfx/gun_actions/water_balloon.png",
  related_projectiles = {"mods/d-wonders/files/entities/projectiles/deck/water_balloon.xml"},
  type = ACTION_TYPE_PROJECTILE,
  spawn_level = "0,1,2,3,4",
  spawn_probability = "0.7,0.7,0.7,0.7,0.7",
  price = 100,
  mana = 8,
  action = function()
    add_projectile("mods/d-wonders/files/entities/projectiles/deck/water_balloon.xml")
    add_projectile("mods/d-wonders/files/entities/projectiles/deck/water_balloon.xml")
    c.game_effect_entities = c.game_effect_entities .. "data/entities/misc/effect_apply_wet.xml,"
    c.fire_rate_wait = c.fire_rate_wait + 4
  end,
}, {
  id = "DW_FIRE_BALLOON",
  name = "$action_dw_fire_balloon",
  description = "$actiondesc_dw_fire_balloon",
  sprite = "mods/d-wonders/files/ui_gfx/gun_actions/fire_balloon.png",
  related_projectiles = {"mods/d-wonders/files/entities/projectiles/deck/fire_balloon.xml"},
  type = ACTION_TYPE_PROJECTILE,
  spawn_level = "0,1,2,3,4",
  spawn_probability = "1,1,1,1,1",
  price = 80,
  mana = 4,
  custom_xml_file = "data/entities/misc/custom_cards/fire_trail.xml",
  action = function()
    add_projectile("mods/d-wonders/files/entities/projectiles/deck/fire_balloon.xml")
    add_projectile("mods/d-wonders/files/entities/projectiles/deck/fire_balloon.xml")
    c.trail_material = c.trail_material .. "fire,"
    c.game_effect_entities = c.game_effect_entities .. "data/entities/misc/effect_apply_on_fire.xml,"
    c.fire_rate_wait = c.fire_rate_wait + 2
  end,
}, {
  id = "DW_OIL_BALLOON",
  name = "$action_dw_oil_balloon",
  description = "$actiondesc_dw_oil_balloon",
  sprite = "mods/d-wonders/files/ui_gfx/gun_actions/oil_balloon.png",
  related_projectiles = {"mods/d-wonders/files/entities/projectiles/deck/oil_balloon.xml"},
  type = ACTION_TYPE_PROJECTILE,
  spawn_level = "0,1,2,3,4",
  spawn_probability = "0.7,0.7,0.7,0.7,0.7",
  price = 100,
  mana = 8,
  action = function()
    add_projectile("mods/d-wonders/files/entities/projectiles/deck/oil_balloon.xml")
    add_projectile("mods/d-wonders/files/entities/projectiles/deck/oil_balloon.xml")
    c.game_effect_entities = c.game_effect_entities .. "data/entities/misc/effect_apply_oiled.xml,"
    c.fire_rate_wait = c.fire_rate_wait + 4
  end,
}, {
  id = "DW_BLOOD_BALLOON",
  name = "$action_dw_blood_balloon",
  description = "$actiondesc_dw_blood_balloon",
  sprite = "mods/d-wonders/files/ui_gfx/gun_actions/blood_balloon.png",
  related_projectiles = {"mods/d-wonders/files/entities/projectiles/deck/blood_balloon.xml"},
  type = ACTION_TYPE_PROJECTILE,
  spawn_level = "0,1,2,3,4",
  spawn_probability = "0.1,0.1,0.2,0.2,0.3",
  price = 120,
  mana = 100,
  max_uses = 5,
  never_unlimited = true,
  action = function()
    add_projectile("mods/d-wonders/files/entities/projectiles/deck/blood_balloon.xml")
    c.trail_material = c.trail_material .. "blood,"
    c.game_effect_entities = c.game_effect_entities .. "data/entities/misc/effect_apply_bloody.xml,"
    c.fire_rate_wait = c.fire_rate_wait + 6
  end,
}, {
  id = "DW_DECREASE_DRAW_2",
  name = "$action_dw_decrease_draw_2",
  description = "$actiondesc_dw_decrease_draw_2",
  sprite = "mods/d-wonders/files/ui_gfx/gun_actions/decrease_draw_2.png",
  type = ACTION_TYPE_PASSIVE,
  spawn_level = "1,2,3,4,5,6",
  spawn_probability = "0.05,0.05,0.4,0.6,0.6,0.4",
  custom_xml_file = "mods/d-wonders/files/entities/misc/custom_cards/decrease_draw_2.xml",
  price = 90,
  mana = 0,
  action = function()
    draw_actions(1, true)
  end,
}, {
  id = "DW_DECREASE_DRAW_3",
  name = "$action_dw_decrease_draw_3",
  description = "$actiondesc_dw_decrease_draw_3",
  sprite = "mods/d-wonders/files/ui_gfx/gun_actions/decrease_draw_3.png",
  type = ACTION_TYPE_PASSIVE,
  spawn_level = "1,2,3,4,5,6",
  spawn_probability = "0.05,0.05,0.4,0.4,0.4,0.4",
  custom_xml_file = "mods/d-wonders/files/entities/misc/custom_cards/decrease_draw_3.xml",
  price = 100,
  mana = 1,
  action = function()
    draw_actions(1, true)
  end,
}, {
  id = "DW_DECREASE_DRAW_4",
  name = "$action_dw_decrease_draw_4",
  description = "$actiondesc_dw_decrease_draw_4",
  sprite = "mods/d-wonders/files/ui_gfx/gun_actions/decrease_draw_4.png",
  type = ACTION_TYPE_PASSIVE,
  spawn_level = "3,4,5,6",
  spawn_probability = "0.05,0.05,0.3,0.3",
  custom_xml_file = "mods/d-wonders/files/entities/misc/custom_cards/decrease_draw_4.xml",
  price = 110,
  mana = 2,
  action = function()
    draw_actions(1, true)
  end,
}, {
  id = "DW_DECREASE_DRAW_INFINITY",
  name = "$action_dw_decrease_draw_infinity",
  description = "$actiondesc_dw_decrease_draw_infinity",
  sprite = "mods/d-wonders/files/ui_gfx/gun_actions/decrease_draw_infinity.png",
  sprite_unidentified = "data/ui_gfx/gun_actions/bomb_unidentified.png",
  type = ACTION_TYPE_PASSIVE,
  spawn_level = "3,4,5,6,10",
  spawn_probability = "0.02,0.02,0.02,0.1,0.2",
  custom_xml_file = "mods/d-wonders/files/entities/misc/custom_cards/decrease_draw_infinity.xml",
  price = 200,
  mana = 10,
  action = function()
    draw_actions(1, true)
  end,
}, {
  id = "DW_INCREASE_DRAW_2",
  name = "$action_dw_increase_draw_2",
  description = "$actiondesc_dw_increase_draw_2",
  sprite = "mods/d-wonders/files/ui_gfx/gun_actions/increase_draw_2.png",
  type = ACTION_TYPE_PASSIVE,
  spawn_level = "1,2,3,4,5,6",
  spawn_probability = "0.05,0.05,0.4,0.6,0.6,0.4",
  custom_xml_file = "mods/d-wonders/files/entities/misc/custom_cards/increase_draw_2.xml",
  price = 90,
  mana = 0,
  action = function()
    draw_actions(1, true)
  end,
}, {
  id = "DW_INCREASE_DRAW_3",
  name = "$action_dw_increase_draw_3",
  description = "$actiondesc_dw_increase_draw_3",
  sprite = "mods/d-wonders/files/ui_gfx/gun_actions/increase_draw_3.png",
  type = ACTION_TYPE_PASSIVE,
  spawn_level = "1,2,3,4,5,6",
  spawn_probability = "0.05,0.05,0.4,0.4,0.4,0.4",
  custom_xml_file = "mods/d-wonders/files/entities/misc/custom_cards/increase_draw_3.xml",
  price = 100,
  mana = 1,
  action = function()
    draw_actions(1, true)
  end,
}, {
  id = "DW_INCREASE_DRAW_4",
  name = "$action_dw_increase_draw_4",
  description = "$actiondesc_dw_increase_draw_4",
  sprite = "mods/d-wonders/files/ui_gfx/gun_actions/increase_draw_4.png",
  type = ACTION_TYPE_PASSIVE,
  spawn_level = "3,4,5,6",
  spawn_probability = "0.05,0.05,0.3,0.3",
  custom_xml_file = "mods/d-wonders/files/entities/misc/custom_cards/increase_draw_4.xml",
  price = 110,
  mana = 2,
  action = function()
    draw_actions(1, true)
  end,
}, {
  id = "DW_INCREASE_DRAW_INFINITY",
  name = "$action_dw_increase_draw_infinity",
  description = "$actiondesc_dw_increase_draw_infinity",
  sprite = "mods/d-wonders/files/ui_gfx/gun_actions/increase_draw_infinity.png",
  sprite_unidentified = "data/ui_gfx/gun_actions/bomb_unidentified.png",
  type = ACTION_TYPE_PASSIVE,
  spawn_level = "3,4,5,6,10",
  spawn_probability = "0.02,0.02,0.02,0.1,0.2",
  custom_xml_file = "mods/d-wonders/files/entities/misc/custom_cards/increase_draw_infinity.xml",
  price = 200,
  mana = 10,
  action = function()
    draw_actions(1, true)
  end,
}, {
  id = "DW_MOUSE_FIREWORKS",
  name = "$action_dw_mouse_fireworks",
  description = "$actiondesc_dw_mouse_fireworks",
  sprite = "mods/d-wonders/files/ui_gfx/gun_actions/mouse_fireworks.png",
  related_projectiles = {"mods/d-wonders/files/entities/projectiles/deck/mouse_fireworks.xml"},
  type = ACTION_TYPE_PROJECTILE,
  spawn_level = "1,2,3,4,5",
  spawn_probability = "1,1,1,0.8,0.3",
  price = 150,
  mana = 60,
  action = function()
    add_projectile("mods/d-wonders/files/entities/projectiles/deck/mouse_fireworks.xml")
    c.extra_entities = c.extra_entities .. "mods/d-wonders/files/entities/misc/accelerating_shot_mouse_fireworks.xml,"
    c.extra_entities = c.extra_entities .. "mods/d-wonders/files/entities/misc/spin_path.xml,"
    c.extra_entities = c.extra_entities .. "mods/d-wonders/files/entities/misc/floating_mouse_fireworks.xml,"
    c.trail_material = c.trail_material .. "gunpowder_unstable,"
    c.speed_multiplier = c.speed_multiplier * 0.32
    c.fire_rate_wait = c.fire_rate_wait + 10
  end,
} -- ,{
--   id = "DW_LIQUID_BALLOON",
--   name = "$action_dw_hammer",
--   description = "$actiondesc_dw_hammer",
--   sprite = "mods/d-wonders/files/ui_gfx/gun_actions/hammer.png",
--   related_projectiles = {"mods/d-wonders/files/entities/projectiles/deck/hammer.xml"},
--   type = ACTION_TYPE_PROJECTILE,
--   spawn_level = "1,2,3,4,5",
--   spawn_probability = "0.2,0.8,0.8,0.6,0.3",
--   price = 130,
--   mana = 30,
--   max_uses = 120,
--   action = function()
-- NOTE:Enchant式のバルーン
--     local x, y = EntityGetTransform(GetUpdatedEntityID())
--     add_projectile("mods/d-wonders/files/entities/projectiles/deck/hammer.xml")
--     SetRandomSeed(x, y)
--     c.fire_rate_wait = c.fire_rate_wait + Random(0, 20)
--     c.spread_degrees = c.spread_degrees + Random(10, 25)
--   end,
-- },
}

for _, action in ipairs(original_actions) do
  table.insert(actions, action)
end


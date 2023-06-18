dofile_once("mods/d-wonders/files/scripts/lib/utilities.lua")
local NXML = dofile_once('mods/d-wonders/files/scripts/lib/luanxml/nxml.lua')

local original_actions = {{
  id = "DW_STACK_BOLT",
  name = "$action_dw_stack_bolt",
  description = "$actiondesc_dw_stack_bolt",
  sprite = "mods/d-wonders/files/ui_gfx/gun_actions/stack_bolt.png",
  related_projectiles = {"mods/d-wonders/files/entities/projectiles/deck/stack_bolt_high.xml"},
  type = ACTION_TYPE_PROJECTILE,
  spawn_level = "0,1,2,3,4",
  spawn_probability = "0.3,0.5,0.7,1,1",
  price = 150,
  mana = 9,
  action = function()
    local HOLD_FRAME_SIZE = 120
    local player_entity_id = GetPlayerEntity()
    if player_entity_id == nil then
      return
    end

    local stack_count = GetInternalVariableValue(player_entity_id, 'stack_bolt_stuck_count', 'value_int') or 1
    local started_frame = GetInternalVariableValue(player_entity_id, 'stack_bolt_started_frame', 'value_int')

    if stack_count == nil or started_frame == nil or GameGetFrameNum() - started_frame > HOLD_FRAME_SIZE then
      stack_count = 1
      started_frame = GameGetFrameNum()
      AddNewInternalVariable(player_entity_id, 'stack_bolt_stuck_count', 'value_int', stack_count)
      AddNewInternalVariable(player_entity_id, 'stack_bolt_started_frame', 'value_int', started_frame)
    end

    if stack_count <= 240 then
      add_projectile("mods/d-wonders/files/entities/projectiles/deck/stack_bolt_low.xml")
    elseif stack_count <= 480 then
      add_projectile("mods/d-wonders/files/entities/projectiles/deck/stack_bolt_middle.xml")
    else
      add_projectile("mods/d-wonders/files/entities/projectiles/deck/stack_bolt_high.xml")
    end

    c.extra_entities = c.extra_entities .. "mods/d-wonders/files/entities/misc/stack_bolt.xml,"
    c.fire_rate_wait = c.fire_rate_wait + 6
    c.screenshake = c.screenshake + 0.5
    c.spread_degrees = c.spread_degrees + 2.0
    shot_effects.recoil_knockback = shot_effects.recoil_knockback + 1
  end,
}, {
  id = "DW_CHARGE_BOLT",
  name = "$action_dw_charge_bolt",
  description = "$actiondesc_dw_charge_bolt",
  sprite = "mods/d-wonders/files/ui_gfx/gun_actions/charge_bolt.png",
  related_projectiles = {"mods/d-wonders/files/entities/projectiles/deck/charge_bolt.xml"},
  type = ACTION_TYPE_PROJECTILE,
  spawn_level = "1,2,3,4,5",
  spawn_probability = "0.1,1,1,0.7,0.3",
  price = 160,
  mana = 15,
  action = function()
    c.fire_rate_wait = c.fire_rate_wait + 10
    current_reload_time = current_reload_time + 15
    local MAX_CHARGE_SIZE = 5
    local player_entity_id = GetPlayerEntity()
    if player_entity_id == nil then
      return
    end
    local charge_count = GetInternalVariableValue(player_entity_id, 'charge_bolt_count', 'value_int')

    if charge_count == nil then
      charge_count = 1
      AddNewInternalVariable(player_entity_id, 'charge_bolt_count', 'value_int', charge_count)
    end

    if charge_count >= MAX_CHARGE_SIZE then
      c.extra_entities = c.extra_entities .. "mods/d-wonders/files/entities/projectiles/deck/charge_bolt_area_damage.xml,"
      c.screenshake = c.screenshake + 10
      c.damage_critical_chance = c.damage_critical_chance + 10
      add_projectile("mods/d-wonders/files/entities/projectiles/deck/charge_bolt.xml")
      charge_count = 1
    else
      c.damage_projectile_add = 0
      add_projectile("mods/d-wonders/files/entities/projectiles/deck/charge_bolt_charging.xml")
      c.screenshake = c.screenshake + charge_count * 2
      charge_count = charge_count + 1
    end

    SetInternalVariableValue(player_entity_id, 'charge_bolt_count', 'value_int', charge_count)
  end,
}, {
  id = "DW_ICICLE",
  name = "$action_dw_icicle",
  description = "$actiondesc_dw_icicle",
  sprite = "mods/d-wonders/files/ui_gfx/gun_actions/icicle.png",
  related_projectiles = {"mods/d-wonders/files/entities/projectiles/deck/icicle.xml"},
  type = ACTION_TYPE_PROJECTILE,
  spawn_level = "1,2,3,4,5",
  spawn_probability = "0.4,0.7,1,1,0.5",
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
  spawn_probability = "0.2,0.6,1,1,0.3",
  price = 130,
  mana = 30,
  max_uses = 99,
  action = function()
    local x, y = EntityGetTransform(GetUpdatedEntityID())
    add_projectile("mods/d-wonders/files/entities/projectiles/deck/hammer.xml")
    SetRandomSeed(x, y)
    c.fire_rate_wait = c.fire_rate_wait + Random(0, 20)
    c.spread_degrees = c.spread_degrees + 6 + Random(10, 25)
  end,
}, {
  id = "DW_SCYTHE",
  name = "$action_dw_scythe",
  description = "$actiondesc_dw_scythe",
  sprite = "mods/d-wonders/files/ui_gfx/gun_actions/scythe.png",
  related_projectiles = {"mods/d-wonders/files/entities/projectiles/deck/scythe.xml"},
  type = ACTION_TYPE_PROJECTILE,
  spawn_level = "1,2,3,4,5",
  spawn_probability = "0.4,0.8,1,0.6,0.4",
  price = 110,
  mana = 25,
  max_uses = 120,
  action = function()
    local x, y = EntityGetTransform(GetUpdatedEntityID())
    add_projectile("mods/d-wonders/files/entities/projectiles/deck/scythe.xml")
    SetRandomSeed(x, y)
    c.fire_rate_wait = c.fire_rate_wait + Random(0, 15)
    c.spread_degrees = c.spread_degrees + 6 + Random(5, 15)
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
  spawn_probability = "0.1,0.1,0.2,0.3,0.4",
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
  id = "DW_MOUSE_FIREWORKS",
  name = "$action_dw_mouse_fireworks",
  description = "$actiondesc_dw_mouse_fireworks",
  sprite = "mods/d-wonders/files/ui_gfx/gun_actions/mouse_fireworks.png",
  related_projectiles = {"mods/d-wonders/files/entities/projectiles/deck/mouse_fireworks.xml"},
  type = ACTION_TYPE_PROJECTILE,
  spawn_level = "1,2,3,4,5",
  spawn_probability = "1,1,0.7,0.5,0.3",
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
}, {
  id = "DW_CANNON_BALL",
  name = "$action_dw_cannon_ball",
  description = "$actiondesc_dw_cannon_ball",
  sprite = "mods/d-wonders/files/ui_gfx/gun_actions/cannon_ball.png",
  related_projectiles = {"mods/d-wonders/files/entities/projectiles/deck/cannon_ball.xml"},
  type = ACTION_TYPE_PROJECTILE,
  spawn_level = "2,3,4,5,6",
  spawn_probability = "0.5,0.5,1,1,0.7",
  price = 180,
  mana = 120,
  max_uses = 10,
  action = function()
    add_projectile("mods/d-wonders/files/entities/projectiles/deck/cannon_ball_seed.xml")
    c.fire_rate_wait = c.fire_rate_wait + 60
    current_reload_time = current_reload_time + 30
    c.screenshake = c.screenshake + 20
    shot_effects.recoil_knockback = 160.0
  end,
}, {
  id = "DW_LASER_BOLT",
  name = "$action_dw_laser_bolt",
  description = "$actiondesc_dw_laser_bolt",
  sprite = "mods/d-wonders/files/ui_gfx/gun_actions/laser_bolt.png",
  related_projectiles = {"mods/d-wonders/files/entities/projectiles/deck/laser_bolt.xml"},
  type = ACTION_TYPE_PROJECTILE,
  spawn_level = "1,2,3,4,5",
  spawn_probability = "0.5,0.8,1,1,1",
  price = 120,
  mana = 40,
  action = function()
    add_projectile("mods/d-wonders/files/entities/projectiles/deck/laser_bolt.xml")
    c.fire_rate_wait = c.fire_rate_wait + 25
  end,
}, {
  id = "DW_POISON_FLASK",
  name = "$action_dw_poison_flask",
  description = "$actiondesc_dw_poison_flask",
  sprite = "mods/d-wonders/files/ui_gfx/gun_actions/poison_flask.png",
  related_projectiles = {"mods/d-wonders/files/entities/projectiles/deck/poison_flask.xml"},
  type = ACTION_TYPE_PROJECTILE,
  spawn_level = "0,1,2,3",
  spawn_probability = "1,1,1,1",
  price = 130,
  mana = 40,
  max_uses = 40,
  action = function()
    add_projectile("mods/d-wonders/files/entities/projectiles/deck/poison_flask.xml")
    c.fire_rate_wait = c.fire_rate_wait + 15
  end,
}, {
  id = "DW_CHARGE_PROJECTILE",
  name = "$action_dw_charge_projectile",
  description = "$actiondesc_dw_charge_projectile",
  sprite = "mods/d-wonders/files/ui_gfx/gun_actions/charge_projectile.png",
  related_projectiles = {"mods/d-wonders/files/entities/projectiles/deck/charge_projectile.xml"},
  type = ACTION_TYPE_PROJECTILE,
  spawn_level = "0,1,2,4,5,6",
  spawn_probability = "0.8,1,0.8,0.6,0.3,0.3",
  price = 120,
  mana = 15,
  action = function()
    add_projectile("mods/d-wonders/files/entities/projectiles/deck/charge_projectile.xml")
    c.extra_entities = c.extra_entities .. "mods/d-wonders/files/entities/misc/charge_projectile.xml,"
    c.fire_rate_wait = c.fire_rate_wait + 6
    c.spread_degrees = c.spread_degrees - 5.0
  end,
}, {
  id = "DW_HEMOKINESIS",
  name = "$action_dw_hemokinesis",
  description = "$actiondesc_dw_hemokinesis",
  sprite = "mods/d-wonders/files/ui_gfx/gun_actions/hemokinesis.png",
  related_projectiles = {"mods/d-wonders/files/entities/projectiles/deck/hemokinesis.xml"},
  type = ACTION_TYPE_PROJECTILE,
  spawn_level = "1,3,4,5",
  spawn_probability = "1,1,1,1",
  price = 130,
  mana = 5,
  action = function()
    add_projectile("mods/d-wonders/files/entities/projectiles/deck/hemokinesis.xml")
    c.extra_entities = c.extra_entities .. "mods/d-wonders/files/entities/misc/hemokinesis.xml,"
    c.spread_degrees = c.spread_degrees + 2.0
    c.fire_rate_wait = c.fire_rate_wait - 10
    c.damage_critical_chance = c.damage_critical_chance + 10
  end,
}, {
  id = "DW_CLAYMORE",
  name = "$action_dw_claymore",
  description = "$actiondesc_dw_claymore",
  sprite = "mods/d-wonders/files/ui_gfx/gun_actions/claymore.png",
  related_projectiles = {"mods/d-wonders/files/entities/projectiles/deck/claymore.xml"},
  type = ACTION_TYPE_PROJECTILE,
  spawn_level = "1,2,3,4,5",
  spawn_probability = "1,1,1,0.8,0.5",
  price = 160,
  mana = 60,
  max_uses = 40,
  action = function()
    add_projectile("mods/d-wonders/files/entities/projectiles/deck/claymore.xml")
    c.fire_rate_wait = c.fire_rate_wait + 20
    shot_effects.recoil_knockback = 20.0

    if (c.speed_multiplier >= 20) then
      c.speed_multiplier = math.min(c.speed_multiplier, 20)
    elseif (c.speed_multiplier < 0) then
      c.speed_multiplier = 0
    end
  end,
}, {
  id = "DW_SHARK_LANCHER",
  name = "$action_dw_shark_lancher",
  description = "$actiondesc_dw_shark_lancher",
  sprite = "mods/d-wonders/files/ui_gfx/gun_actions/shark_lancher.png",
  related_projectiles = {"mods/d-wonders/files/entities/projectiles/deck/shark_lancher.xml"},
  type = ACTION_TYPE_PROJECTILE,
  spawn_level = "2,3,4,5",
  spawn_probability = "0.4,0.6,0.8,1",
  price = 200,
  mana = 200,
  max_uses = 15,
  action = function()
    add_projectile("mods/d-wonders/files/entities/projectiles/deck/shark_lancher.xml")
    c.fire_rate_wait = c.fire_rate_wait + 80
  end,
}, {
  id = "DW_CONTRACT",
  name = "$action_dw_contract",
  description = "$actiondesc_dw_contract",
  sprite = "mods/d-wonders/files/ui_gfx/gun_actions/contract.png",
  related_projectiles = {"mods/d-wonders/files/entities/projectiles/deck/contract.xml"},
  type = ACTION_TYPE_PROJECTILE,
  spawn_level = "2,3,4,5",
  spawn_probability = "1,1,1,1",
  price = 200,
  mana = 60,
  action = function()
    add_projectile("mods/d-wonders/files/entities/projectiles/deck/contract.xml")
    c.fire_rate_wait = c.fire_rate_wait + 10
  end,
}, {
  id = "DW_REMOTE_BOMB",
  name = "$action_dw_remote_bomb",
  description = "$actiondesc_dw_remote_bomb",
  sprite = "mods/d-wonders/files/ui_gfx/gun_actions/c4.png",
  related_projectiles = {"mods/d-wonders/files/entities/projectiles/remote_bomb.xml"},
  type = ACTION_TYPE_PROJECTILE,
  spawn_level = "1,2,3,4,5",
  spawn_probability = "1,1,1,1,1",
  price = 130,
  mana = 60,
  max_uses = 5,
  custom_xml_file = "mods/d-wonders/files/entities/misc/custom_cards/remote_bomb.xml",
  action = function()
    add_projectile("mods/d-wonders/files/entities/projectiles/remote_bomb.xml")
    c.fire_rate_wait = c.fire_rate_wait + 20
  end,
}, {
  id = "DW_REMOTE_BOMB_GIGA",
  name = "$action_dw_remote_bomb_giga",
  description = "$actiondesc_dw_remote_bomb_giga",
  sprite = "mods/d-wonders/files/ui_gfx/gun_actions/c4_giga.png",
  related_projectiles = {"mods/d-wonders/files/entities/projectiles/remote_bomb_giga.xml"},
  type = ACTION_TYPE_PROJECTILE,
  spawn_level = "3,4,5,6,10",
  spawn_probability = "0.3,0.3,1,1,1",
  price = 180,
  mana = 130,
  max_uses = 5,
  never_unlimited = true,
  custom_xml_file = "mods/d-wonders/files/entities/misc/custom_cards/remote_bomb_giga.xml",
  action = function()
    add_projectile("mods/d-wonders/files/entities/projectiles/remote_bomb_giga.xml")
    c.fire_rate_wait = c.fire_rate_wait + 50
    current_reload_time = current_reload_time + 10
    shot_effects.recoil_knockback = 40
  end,
}, {
  id = "DW_LIQUID_SHOT",
  name = "$action_dw_liquid_shot",
  description = "$actiondesc_dw_liquid_shot",
  sprite = "mods/d-wonders/files/ui_gfx/gun_actions/liquid_shot.png",
  related_projectiles = {"mods/d-wonders/files/entities/projectiles/liquid_shot.xml"},
  type = ACTION_TYPE_PROJECTILE,
  spawn_level = "0,1,2,3,4,5,6",
  spawn_probability = "1,1,1,1,1,1,1",
  price = 100,
  mana = 3,
  custom_xml_file = "mods/d-wonders/files/entities/misc/custom_cards/liquid_shot.xml",
  action = function()
    add_projectile("mods/d-wonders/files/entities/projectiles/deck/liquid_shot_light.xml")
    c.fire_rate_wait = c.fire_rate_wait + 5
    c.damage_critical_chance = c.damage_critical_chance - 10
  end,
}, {
  id = "DW_LIQUID_SHOT_ACID",
  name = "$action_dw_liquid_shot_acid",
  description = "$actiondesc_dw_liquid_shot_acid",
  sprite = "mods/d-wonders/files/ui_gfx/gun_actions/liquid_shot_acid.png",
  related_projectiles = {"mods/d-wonders/files/entities/projectiles/liquid_shot_acid.xml"},
  type = ACTION_TYPE_PROJECTILE,
  spawn_level = "5,6",
  spawn_probability = "0.5,0.5",
  price = 150,
  mana = 5,
  action = function()
    add_projectile("mods/d-wonders/files/entities/projectiles/deck/liquid_shot_acid.xml")
    c.fire_rate_wait = c.fire_rate_wait - 10
    c.damage_critical_chance = c.damage_critical_chance + 10
    shot_effects.recoil_knockback = shot_effects.recoil_knockback - 10.0
  end,
}, {
  id = "DW_LIQUID_SHOT_BLOOD",
  name = "$action_dw_liquid_shot_blood",
  description = "$actiondesc_dw_liquid_shot_blood",
  sprite = "mods/d-wonders/files/ui_gfx/gun_actions/liquid_shot_blood.png",
  related_projectiles = {"mods/d-wonders/files/entities/projectiles/liquid_shot_blood.xml"},
  type = ACTION_TYPE_PROJECTILE,
  spawn_level = "2,3,4,5,6",
  spawn_probability = "0.5,0.5,0.5,0.5,0.5",
  price = 150,
  mana = 20,
  action = function()
    add_projectile("mods/d-wonders/files/entities/projectiles/deck/liquid_shot_blood.xml")
    c.fire_rate_wait = c.fire_rate_wait + 20
    c.damage_critical_chance = c.damage_critical_chance + 20
    c.spread_degrees = c.spread_degrees - 2
    shot_effects.recoil_knockback = shot_effects.recoil_knockback + 2.0
  end,
}, {
  id = "DW_LIQUID_SHOT_CHARM",
  name = "$action_dw_liquid_shot_charm",
  description = "$actiondesc_dw_liquid_shot_charm",
  sprite = "mods/d-wonders/files/ui_gfx/gun_actions/liquid_shot_charm.png",
  related_projectiles = {"mods/d-wonders/files/entities/projectiles/liquid_shot_charm.xml"},
  type = ACTION_TYPE_PROJECTILE,
  spawn_level = "2,4,5,6",
  spawn_probability = "0.1,0.1,0.5,0.5",
  price = 200,
  mana = 10,
  max_uses = 10,
  never_unlimited = true,
  action = function()
    add_projectile("mods/d-wonders/files/entities/projectiles/deck/liquid_shot_charm.xml")
    c.damage_healing_add = c.damage_healing_add - 0.04
  end,
}, {
  id = "DW_LIQUID_SHOT_DARK",
  name = "$action_dw_liquid_shot_dark",
  description = "$actiondesc_dw_liquid_shot_dark",
  sprite = "mods/d-wonders/files/ui_gfx/gun_actions/liquid_shot_dark.png",
  related_projectiles = {"mods/d-wonders/files/entities/projectiles/liquid_shot_dark.xml"},
  type = ACTION_TYPE_PROJECTILE,
  spawn_level = "5,6",
  spawn_probability = "0.5,0.5",
  price = 200,
  mana = 15,
  action = function()
    add_projectile("mods/d-wonders/files/entities/projectiles/deck/liquid_shot_dark.xml")
    c.fire_rate_wait = c.fire_rate_wait - 20
    current_reload_time = current_reload_time - ACTION_DRAW_RELOAD_TIME_INCREASE - 20
    c.spread_degrees = c.spread_degrees + 10
    c.damage_curse_add = c.damage_curse_add + 0.1
  end,
}, {
  id = "DW_LIQUID_SHOT_LAVA",
  name = "$action_dw_liquid_shot_lava",
  description = "$actiondesc_dw_liquid_shot_lava",
  sprite = "mods/d-wonders/files/ui_gfx/gun_actions/liquid_shot_lava.png",
  related_projectiles = {"mods/d-wonders/files/entities/projectiles/liquid_shot_lava.xml"},
  type = ACTION_TYPE_PROJECTILE,
  spawn_level = "5,6",
  spawn_probability = "0.5,0.5",
  price = 170,
  mana = 30,
  action = function()
    add_projectile("mods/d-wonders/files/entities/projectiles/deck/liquid_shot_lava.xml")
    c.fire_rate_wait = c.fire_rate_wait + 30
    current_reload_time = current_reload_time + 30
    c.damage_fire_add = c.damage_fire_add + 1
    c.damage_critical_chance = c.damage_critical_chance + 5
    c.spread_degrees = c.spread_degrees - 2
  end,
}, {
  id = "DW_LIQUID_SHOT_MANA",
  name = "$action_dw_liquid_shot_mana",
  description = "$actiondesc_dw_liquid_shot_mana",
  sprite = "mods/d-wonders/files/ui_gfx/gun_actions/liquid_shot_mana.png",
  related_projectiles = {"mods/d-wonders/files/entities/projectiles/liquid_shot_mana.xml"},
  type = ACTION_TYPE_PROJECTILE,
  spawn_level = "2,4,6",
  spawn_probability = "0.5,0.5,0.5",
  price = 200,
  mana = -10,
  action = function()
    add_projectile("mods/d-wonders/files/entities/projectiles/deck/liquid_shot_mana.xml")
    c.fire_rate_wait = c.fire_rate_wait + 5
  end,
}, {
  id = "DW_LIQUID_SHOT_OIL",
  name = "$action_dw_liquid_shot_oil",
  description = "$actiondesc_dw_liquid_shot_oil",
  sprite = "mods/d-wonders/files/ui_gfx/gun_actions/liquid_shot_oil.png",
  related_projectiles = {"mods/d-wonders/files/entities/projectiles/liquid_shot_oil.xml"},
  type = ACTION_TYPE_PROJECTILE,
  spawn_level = "1,2,3,4",
  spawn_probability = "0.2,0.4,0.4,0.4",
  price = 140,
  mana = 10,
  action = function()
    add_projectile("mods/d-wonders/files/entities/projectiles/deck/liquid_shot_oil.xml")
    c.fire_rate_wait = c.fire_rate_wait - 5
    current_reload_time = current_reload_time - ACTION_DRAW_RELOAD_TIME_INCREASE - 5
  end,
}, {
  id = "DW_LIQUID_SHOT_TOXIC",
  name = "$action_dw_liquid_shot_toxic",
  description = "$actiondesc_dw_liquid_shot_toxic",
  sprite = "mods/d-wonders/files/ui_gfx/gun_actions/liquid_shot_toxic.png",
  related_projectiles = {"mods/d-wonders/files/entities/projectiles/liquid_shot_toxic.xml"},
  type = ACTION_TYPE_PROJECTILE,
  spawn_level = "2,3,4,5",
  spawn_probability = "0.2,0.3,0.4,0.5",
  price = 150,
  mana = 20,
  action = function()
    add_projectile("mods/d-wonders/files/entities/projectiles/deck/liquid_shot_toxic.xml")
    c.fire_rate_wait = c.fire_rate_wait + 10
    c.spread_degrees = c.spread_degrees + 10
  end,
}, {
  id = "DW_LIQUID_SHOT_WATER",
  name = "$action_dw_liquid_shot_water",
  description = "$actiondesc_dw_liquid_shot_water",
  sprite = "mods/d-wonders/files/ui_gfx/gun_actions/liquid_shot_water.png",
  related_projectiles = {"mods/d-wonders/files/entities/projectiles/liquid_shot_water.xml"},
  type = ACTION_TYPE_PROJECTILE,
  spawn_level = "0,1,2,3",
  spawn_probability = "0.5,0.5,0.5,0.5",
  price = 100,
  mana = 5,
  action = function()
    add_projectile("mods/d-wonders/files/entities/projectiles/deck/liquid_shot_water.xml")
    c.fire_rate_wait = c.fire_rate_wait + 5
  end,
}, {
  id = "DW_SHOOTINGSTAR",
  name = "$action_dw_shootingstar",
  description = "$actiondesc_dw_shootingstar",
  sprite = "mods/d-wonders/files/ui_gfx/gun_actions/shootingstar.png",
  related_projectiles = {"mods/d-wonders/files/entities/projectiles/deck/shootingstar_big_yellow.xml"},
  type = ACTION_TYPE_STATIC_PROJECTILE,
  spawn_level = "2,3,4,5,6",
  spawn_probability = "1,1,1,1,1",
  price = 200,
  mana = 150,
  max_uses = 15,
  never_unlimited = true,
  action = function()
    add_projectile("mods/d-wonders/files/entities/projectiles/deck/shootingstar_origin.xml")
    c.fire_rate_wait = c.fire_rate_wait + 30
    if (c.speed_multiplier >= 20) then
      c.speed_multiplier = math.min(c.speed_multiplier, 20)
    elseif (c.speed_multiplier < 0) then
      c.speed_multiplier = 0
    end
  end,
}, {
  id = "DW_SPIN_PATH",
  name = "$action_dw_spin_path",
  description = "$actiondesc_dw_spin_path",
  sprite = "mods/d-wonders/files/ui_gfx/gun_actions/spin_path.png",
  related_projectiles = {"mods/d-wonders/files/entities/projectiles/deck/spin_path.xml"},
  type = ACTION_TYPE_MODIFIER,
  spawn_level = "2,4,6",
  spawn_probability = "1,1,1",
  price = 20,
  mana = 0,
  action = function()
    c.extra_entities = c.extra_entities .. "mods/d-wonders/files/entities/misc/spin_path.xml,"
    c.lifetime_add = c.lifetime_add + 15
    draw_actions(1, true)
  end,
}, {
  id = "DW_BATTERY_LIGHT",
  name = "$action_dw_battery_light",
  description = "$actiondesc_dw_battery_light",
  sprite = "mods/d-wonders/files/ui_gfx/gun_actions/battery_light.png",
  related_extra_entities = {"mods/d-wonders/files/entities/misc/battery_light.xml"},
  type = ACTION_TYPE_MODIFIER,
  spawn_level = "0,1,2,3,4",
  spawn_probability = "1,1,0.8,0.6,0.4",
  price = 40,
  mana = 2,
  max_uses = 40,
  never_unlimited = true,
  custom_xml_file = "mods/d-wonders/files/entities/misc/custom_cards/battery_light.xml",
  action = function()
    c.extra_entities = c.extra_entities .. "mods/d-wonders/files/entities/misc/battery_light.xml,"
    draw_actions(1, true)
  end,
}, {
  id = "DW_DAMAGE_REVERSER_ICE",
  name = "$action_dw_damage_reverser_ice",
  description = "$actiondesc_dw_damage_reverser_ice",
  sprite = "mods/d-wonders/files/ui_gfx/gun_actions/damage_reverser_ice.png",
  related_extra_entities = {"mods/d-wonders/files/entities/misc/damage_reverser_ice.xml"},
  type = ACTION_TYPE_MODIFIER,
  spawn_level = "1,2,3,4",
  spawn_probability = "0.1,0.1,0.1,0.1",
  price = 150,
  mana = 20,
  max_uses = 5,
  never_unlimited = true,
  action = function()
    local ice_damage = c.damage_ice_add
    c.damage_ice_add = 0
    c.damage_healing_add = -ice_damage
    local before_extra_entities = Split(c.extra_entities, ",")
    local after_extra_entities = {}
    for _, extra_entity in ipairs(before_extra_entities) do
      if not string.find(extra_entity, "freeze_charge%.xml") then
        table.insert(after_extra_entities, extra_entity)
      end
    end
    c.extra_entities = table.concat(after_extra_entities, ",")

    local before_effect_entities = Split(c.game_effect_entities, ",")
    local after_effect_entities = {}
    for _, effect_entity in ipairs(before_effect_entities) do
      if not string.find(effect_entity, "effect_frozen%.xml") then
        table.insert(after_effect_entities, effect_entity)
      end
    end
    c.game_effect_entities = table.concat(after_effect_entities, ",")
    draw_actions(1, true)
  end,
}, {
  id = "DW_REMOTE_BOMB_CONTROLLER",
  name = "$action_dw_remote_bomb_controller",
  description = "$actiondesc_dw_remote_bomb_controller",
  sprite = "mods/d-wonders/files/ui_gfx/gun_actions/c4-remote-controller.png",
  type = ACTION_TYPE_OTHER,
  spawn_level = "99",
  spawn_probability = "0",
  price = 100,
  mana = 0,
  action = function()
    add_projectile("mods/d-wonders/files/entities/projectiles/deck/remote_bomb_controller.xml")
  end,
}, {
  id = "DW_FROZEN_FIELD",
  name = "$action_dw_frozen_field",
  description = "$actiondesc_dw_frozen_field",
  sprite = "mods/d-wonders/files/ui_gfx/gun_actions/frozen_field.png",
  related_projectiles = {"mods/d-wonders/files/entities/projectiles/deck/frozen_field.xml"},
  type = ACTION_TYPE_OTHER,
  spawn_level = "1,2,3,4,5",
  spawn_probability = "0.8,0.8,0.8,0.8,1",
  price = 160,
  mana = 150,
  max_uses = 15,
  never_unlimited = true,
  action = function()
    add_projectile("mods/d-wonders/files/entities/projectiles/deck/frozen_field.xml")
    c.fire_rate_wait = c.fire_rate_wait + 30
  end,
}, {
  id = "DW_SPELL_VACUUM",
  name = "$action_dw_spell_vacuum",
  description = "$actiondesc_dw_spell_vacuum",
  sprite = "mods/d-wonders/files/ui_gfx/gun_actions/spell_vacuum.png",
  type = ACTION_TYPE_OTHER,
  spawn_level = "3,4,5,6,10",
  spawn_probability = "0.1,0.3,0.6,1,1",
  price = 250,
  mana = 20,
  action = function()
    local card = nil
    if (#deck > 0) then
      card = deck[1]
    end

    if card == nil then
      return
    end

    if card.type ~= ACTION_TYPE_PROJECTILE then
      return
    end

    local nxml_element = NXML.parse(ModTextFileGetContent(card.related_projectiles[1]))

    local projectile_nxml_element = nxml_element:first_of("ProjectileComponent")
    if projectile_nxml_element ~= nil then
      c.damage_projectile_add = c.damage_projectile_add + (projectile_nxml_element.attr["damage"] or 0)
      local config_explosion = projectile_nxml_element:first_of("config_explosion")
      if config_explosion then
        c.damage_explosion_add = c.damage_explosion_add + (config_explosion.attr["damage"] or 0)
      end
      c.speed_multiplier = c.speed_multiplier + (projectile_nxml_element.attr["speed_max"] or 0)
      c.lifetime_add = c.lifetime_add + (projectile_nxml_element.attr["lifetime"] or 0)

      local damage_by_type_nxml_element = projectile_nxml_element:first_of("damage_by_type")
      if damage_by_type_nxml_element ~= nil then
        local slice_damage = damage_by_type_nxml_element.attr["slice"] or 0
        local curse_damage = damage_by_type_nxml_element.attr["curse"] or 0
        local projectile_damage = damage_by_type_nxml_element.attr["projectile"] or 0
        local melee_damage = damage_by_type_nxml_element.attr["melee"] or 0
        local ice_damage = damage_by_type_nxml_element.attr["ice"] or 0
        local electricity_damage = damage_by_type_nxml_element.attr["electricity"] or 0
        local fire_damage = damage_by_type_nxml_element.attr["fire"] or 0
        local explosion_damage = damage_by_type_nxml_element.attr["explosion"] or 0
        local drill_damage = damage_by_type_nxml_element.attr["drill"] or 0
        c.damage_slice_add = c.damage_slice_add + slice_damage
        c.damage_curse_add = c.damage_curse_add + curse_damage
        c.damage_projectile_add = c.damage_projectile_add + projectile_damage
        c.damage_melee_add = c.damage_melee_add + melee_damage
        c.damage_ice_add = c.damage_ice_add + ice_damage
        c.damage_electricity_add = c.damage_electricity_add + electricity_damage
        c.damage_fire_add = c.damage_fire_add + fire_damage
        c.damage_explosion_add = c.damage_explosion_add + explosion_damage
        c.damage_drill_add = c.damage_drill_add + drill_damage
      end
    end

    local area_damage_nxml_element = nxml_element:first_of("AreaDamageComponent")
    if area_damage_nxml_element ~= nil then
      local damage_type = area_damage_nxml_element.attr["damage_type"]
      local damage_per_frame = area_damage_nxml_element.attr["damage_per_frame"]

      if damage_type ~= nil and damage_per_frame ~= nil then
        if damage_type == 'DAMAGE_SLICE' then
          c.damage_slice_add = c.damage_slice_add + damage_per_frame
        elseif damage_type == 'DAMAGE_CURSE' then
          c.damage_curse_add = c.damage_curse_add + damage_per_frame
        elseif damage_type == 'DAMAGE_PROJECTILE' then
          c.damage_projectile_add = c.damage_projectile_add + damage_per_frame
        elseif damage_type == 'DAMAGE_MELEE' then
          c.damage_melee_add = c.damage_melee_add + damage_per_frame
        elseif damage_type == 'DAMAGE_ICE' then
          c.damage_ice_add = c.damage_ice_add + damage_per_frame
        elseif damage_type == 'DAMAGE_ELECTRICITY' then
          c.damage_electricity_add = c.damage_electricity_add + damage_per_frame
        elseif damage_type == 'DAMAGE_FIRE' then
          c.damage_fire_add = c.damage_fire_add + damage_per_frame
        elseif damage_type == 'DAMAGE_EXPLOSION' then
          c.damage_explosion_add = c.damage_explosion_add + damage_per_frame
        elseif damage_type == 'DAMAGE_DRILL' then
          c.damage_drill_add = c.damage_drill_add + damage_per_frame
        end
      end
    end

    table.insert(discarded, card)
    table.remove(deck, 1)
    draw_actions(1, true)
  end,
}, {
  id = "DW_DECREASE_DRAW_2",
  name = "$action_dw_decrease_draw_2",
  description = "$actiondesc_dw_decrease_draw_2",
  sprite = "mods/d-wonders/files/ui_gfx/gun_actions/decrease_draw_2.png",
  type = ACTION_TYPE_PASSIVE,
  spawn_level = "1,2,3,4,5,6",
  spawn_probability = "0.05,0.05,0.4,0.6,1,1",
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
  spawn_probability = "0.05,0.05,0.4,0.4,1,1",
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
  spawn_probability = "0.02,0.02,0.02,0.2,0.4",
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
  spawn_probability = "0.05,0.05,0.4,0.6,1,1",
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
  spawn_probability = "0.05,0.05,0.4,0.4,1,1",
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
  spawn_probability = "0.02,0.02,0.02,0.2,0.4",
  custom_xml_file = "mods/d-wonders/files/entities/misc/custom_cards/increase_draw_infinity.xml",
  price = 200,
  mana = 10,
  action = function()
    draw_actions(1, true)
  end,
}}
print('====================================================')
print('There are ' .. #original_actions .. ' spells of d-wonders')
print('====================================================')

for _, action in ipairs(original_actions) do
  table.insert(actions, action)
end


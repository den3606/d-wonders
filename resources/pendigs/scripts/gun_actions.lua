-- {
--   id = "DW_ANGULAR_BOLT",
--   name = "$action_angular_bolt",
--   description = "$actiondesc_angular_bolt",
--   sprite = "mods/d-wonders/files/ui_gfx/gun_actions/angular_bolt.png",
--   related_projectiles = {"mods/d-wonders/files/entities/projectiles/deck/angular_bolt.xml"},
--   type = ACTION_TYPE_PROJECTILE,
--   spawn_level = "1,2,3,4,5",
--   spawn_probability = "0.5,1,1,1,1",
--   price = 120,
--   mana = 40,
--   action = function()
--     add_projectile("mods/d-wonders/files/entities/projectiles/deck/angular_bolt.xml")
--     c.fire_rate_wait = c.fire_rate_wait + 25
--   end,
-- }, {
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
-- }, {
--   id = "DW_TWICE_TRIGGER",
--   name = "$action_dw_twice_trigger",
--   description = "$actiondesc_dw_twice_trigger",
--   sprite = "mods/d-wonders/files/ui_gfx/gun_actions/twice_trigger.png",
--   spawn_requires_flag = "card_unlocked_mestari",
--   type = ACTION_TYPE_OTHER,
--   recursive = true,
--   spawn_level = "4,5,6,10",
--   spawn_probability = "0.1,0.4,0.4,1",
--   price = 100,
--   mana = 5,
--   action = function(recursion_level, iteration)
--     c.fire_rate_wait = c.fire_rate_wait + 10
--     local current_hand_size = #hand
--     local next_card = deck[1]
--     if next_card == nil then
--       draw_actions(1, true)
--       return
--     end
--     local rec = check_recursion(next_card, recursion_level)
--     if (rec > -1) and (next_card.id ~= "RESET") and string.find(next_card.id, "TRIGGER") then
--       draw_actions(1, false)
--       for i = current_hand_size, #hand do
--         table.insert(deck, 1, hand[i])
--         table.remove(hand, i)
--       end
--     end
--   end,
-- }, {
-- NOTE:POLYMORPHの仕様がEffect依存の特殊処理であったため自分で実装する必要がある。
-- 高コストなのでペンディング
--   id = "DW_BOMB_FIELD",
--   name = "$action_dw_bomb_field",
--   description = "$actiondesc_dw_bomb_field",
--   sprite = "mods/d-wonders/files/ui_gfx/gun_actions/bomb_field.png",
--   related_projectiles = {"mods/d-wonders/files/entities/projectiles/deck/bomb_field.xml"},
--   type = ACTION_TYPE_STATIC_PROJECTILE,
--   spawn_level = "1,2,3,4,5",
--   spawn_probability = "1,1,1,1,1",
--   price = 200,
--   mana = 40,
--   max_uses = 10,
--   action = function()
--     add_projectile("mods/d-wonders/files/entities/projectiles/deck/bomb_field.xml")
--     c.fire_rate_wait = c.fire_rate_wait + 15
--   end,
-- },
-- }, {
--   id = "DW_SPELL_VACUUM",
--   name = "$action_dw_spell_vacuum",
--   description = "$actiondesc_dw_spell_vacuum",
--   sprite = "mods/d-wonders/files/ui_gfx/gun_actions/spell_vacuum.png",
--   type = ACTION_TYPE_OTHER,
--   spawn_level = "3,4,5,6,10",
--   spawn_probability = "0.1,0.3,0.6,1,1",
--   price = 250,
--   mana = 20,
--   action = function()
--     local card = nil
--     if (#deck > 0) then
--       card = deck[1]
--     end

--     if card == nil then
--       return
--     end

--     if card.type ~= ACTION_TYPE_PROJECTILE then
--       return
--     end

--     local nxml_element = NXML.parse(ModTextFileGetContent(card.related_projectiles[1]))

--     local projectile_nxml_element = nxml_element:first_of("ProjectileComponent")
--     if projectile_nxml_element ~= nil then
--       c.damage_projectile_add = c.damage_projectile_add + (projectile_nxml_element.attr["damage"] or 0)
--       local config_explosion = projectile_nxml_element:first_of("config_explosion")
--       if config_explosion then
--         c.damage_explosion_add = c.damage_explosion_add + (config_explosion.attr["damage"] or 0)
--       end
--       c.speed_multiplier = c.speed_multiplier + (projectile_nxml_element.attr["speed_max"] or 0)
--       c.lifetime_add = c.lifetime_add + (projectile_nxml_element.attr["lifetime"] or 0)

--       local damage_by_type_nxml_element = projectile_nxml_element:first_of("damage_by_type")
--       if damage_by_type_nxml_element ~= nil then
--         local slice_damage = damage_by_type_nxml_element.attr["slice"] or 0
--         local curse_damage = damage_by_type_nxml_element.attr["curse"] or 0
--         local projectile_damage = damage_by_type_nxml_element.attr["projectile"] or 0
--         local melee_damage = damage_by_type_nxml_element.attr["melee"] or 0
--         local ice_damage = damage_by_type_nxml_element.attr["ice"] or 0
--         local electricity_damage = damage_by_type_nxml_element.attr["electricity"] or 0
--         local fire_damage = damage_by_type_nxml_element.attr["fire"] or 0
--         local explosion_damage = damage_by_type_nxml_element.attr["explosion"] or 0
--         local drill_damage = damage_by_type_nxml_element.attr["drill"] or 0
--         c.damage_slice_add = c.damage_slice_add + slice_damage
--         c.damage_curse_add = c.damage_curse_add + curse_damage
--         c.damage_projectile_add = c.damage_projectile_add + projectile_damage
--         c.damage_melee_add = c.damage_melee_add + melee_damage
--         c.damage_ice_add = c.damage_ice_add + ice_damage
--         c.damage_electricity_add = c.damage_electricity_add + electricity_damage
--         c.damage_fire_add = c.damage_fire_add + fire_damage
--         c.damage_explosion_add = c.damage_explosion_add + explosion_damage
--         c.damage_drill_add = c.damage_drill_add + drill_damage
--       end
--     end

--     local area_damage_nxml_element = nxml_element:first_of("AreaDamageComponent")
--     if area_damage_nxml_element ~= nil then
--       local damage_type = area_damage_nxml_element.attr["damage_type"]
--       local damage_per_frame = area_damage_nxml_element.attr["damage_per_frame"]

--       if damage_type ~= nil and damage_per_frame ~= nil then
--         if damage_type == 'DAMAGE_SLICE' then
--           c.damage_slice_add = c.damage_slice_add + damage_per_frame
--         elseif damage_type == 'DAMAGE_CURSE' then
--           c.damage_curse_add = c.damage_curse_add + damage_per_frame
--         elseif damage_type == 'DAMAGE_PROJECTILE' then
--           c.damage_projectile_add = c.damage_projectile_add + damage_per_frame
--         elseif damage_type == 'DAMAGE_MELEE' then
--           c.damage_melee_add = c.damage_melee_add + damage_per_frame
--         elseif damage_type == 'DAMAGE_ICE' then
--           c.damage_ice_add = c.damage_ice_add + damage_per_frame
--         elseif damage_type == 'DAMAGE_ELECTRICITY' then
--           c.damage_electricity_add = c.damage_electricity_add + damage_per_frame
--         elseif damage_type == 'DAMAGE_FIRE' then
--           c.damage_fire_add = c.damage_fire_add + damage_per_frame
--         elseif damage_type == 'DAMAGE_EXPLOSION' then
--           c.damage_explosion_add = c.damage_explosion_add + damage_per_frame
--         elseif damage_type == 'DAMAGE_DRILL' then
--           c.damage_drill_add = c.damage_drill_add + damage_per_frame
--         end
--       end
--     end

--     table.insert(discarded, card)
--     table.remove(deck, 1)
--     draw_actions(1, true)
--   end,

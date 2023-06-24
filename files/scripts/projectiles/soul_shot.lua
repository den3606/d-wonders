dofile_once("mods/d-wonders/files/scripts/lib/utilities.lua")

SetRandomSeed(GameGetFrameNum(), GameGetFrameNum())

local projectile_entity_id = GetUpdatedEntityID()
local projectile_component_id = EntityGetFirstComponentIncludingDisabled(projectile_entity_id, 'ProjectileComponent')
if not projectile_component_id then
  return
end

local who_shot = ComponentGetValue2(projectile_component_id, "mWhoShot")
if who_shot == nil then
  return
end

local soul_size = GetInternalVariableValue(who_shot, "dw_soul_shot.soul_size", "value_int")

if soul_size == nil then
  return
end

local scale = 1
if soul_size < 20 then
  -- through
elseif soul_size < 100 then
  scale = 1.5
elseif soul_size < 500 then
  scale = 2
elseif soul_size < 2000 then
  scale = 3
elseif soul_size < 10000 then
  scale = 4
else
  scale = 5
end

local cause_damage = ComponentObjectGetValue2(projectile_component_id, "damage_by_type", "curse")
ComponentObjectSetValue2(projectile_component_id, "damage_by_type", "curse", cause_damage * scale)

-- hiden boost
if scale >= 2 then
  ComponentObjectSetValue2(projectile_component_id, "damage_by_type", "fire", 0.04 * scale)
end

local soul_size = soul_size - 1
if soul_size < 0 then
  soul_size = 0
end

SetInternalVariableValue(who_shot, "dw_soul_shot.soul_size", "value_int", soul_size)

local x, y = EntityGetTransform(who_shot)

x = x + Random(-3, 3)
y = y + Random(-1, 1)
print(soul_size)

if soul_size > 0 then
  if scale < 3 then
    if Random(0, 1) == 0 then
      EntityLoad("mods/d-wonders/files/entities/misc/soul_shot_ghost_effect_1.xml", x, y - 12)
    else
      EntityLoad("mods/d-wonders/files/entities/misc/soul_shot_ghost_effect_2.xml", x, y - 12)
    end
  else
    if Random(0, 1) == 0 then
      EntityLoad("mods/d-wonders/files/entities/misc/soul_shot_ghost_effect_3.xml", x, y - 12)
    else
      EntityLoad("mods/d-wonders/files/entities/misc/soul_shot_ghost_effect_4.xml", x, y - 12)
    end
  end
end


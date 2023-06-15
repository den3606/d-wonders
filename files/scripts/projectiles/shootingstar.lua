dofile_once("data/scripts/lib/utilities.lua")

local function vel_x(x1, x2)
  local vel1 = Random(x1, x2)
  local vel2 = Random(-x1, -x2)
  if math.abs(vel1) > math.abs(vel2) then
    return vel1
  end
  return vel2
end

local shootingstar_entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform(shootingstar_entity_id)

local width = 200
local height = 50

SetRandomSeed(GameGetFrameNum(), pos_x + pos_y + shootingstar_entity_id)

pos_x = pos_x + Random(0 - width / 2, width / 2)
pos_y = pos_y - 150 - Random(0, height)

local vel_x = vel_x(30, 300)
local vel_y = Random(100, 400)

local rand = Random(1, 100)
if rand > 60 then
  shoot_projectile_from_projectile(shootingstar_entity_id, "mods/d-wonders/files/entities/projectiles/deck/shootingstar_big_yellow.xml", pos_x, pos_y, vel_x, vel_y)
elseif rand > 30 then
  shoot_projectile_from_projectile(shootingstar_entity_id, "mods/d-wonders/files/entities/projectiles/deck/shootingstar_medium_yellow.xml", pos_x, pos_y, vel_x, vel_y)
elseif rand > 20 then
  shoot_projectile_from_projectile(shootingstar_entity_id, "mods/d-wonders/files/entities/projectiles/deck/shootingstar_medium_red.xml", pos_x, pos_y, vel_x, vel_y)
elseif rand > 10 then
  shoot_projectile_from_projectile(shootingstar_entity_id, "mods/d-wonders/files/entities/projectiles/deck/shootingstar_medium_blue.xml", pos_x, pos_y, vel_x, vel_y)
else
  shoot_projectile_from_projectile(shootingstar_entity_id, "mods/d-wonders/files/entities/projectiles/deck/shootingstar_medium_green.xml", pos_x, pos_y, vel_x, vel_y)
end

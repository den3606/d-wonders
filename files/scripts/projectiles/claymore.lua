dofile_once("data/scripts/lib/utilities.lua")
local claymore_entity_id = GetUpdatedEntityID()
if claymore_entity_id == nil then
  return
end

local x, y = EntityGetTransform(claymore_entity_id)

-- π内で10等分する
local branches = 15
local angle_increment = math.pi / branches
local angle = 0
local speed = 400

-- ベクトル座標を計算
for i = 1, branches do
  local vel_x = speed * math.cos(angle)
  local vel_y = -1 * speed * math.sin(angle)
  shoot_projectile(claymore_entity_id, "mods/d-wonders/files/entities/projectiles/claymore_ammo.xml", x, y, vel_x, vel_y)
  angle = angle + angle_increment
end

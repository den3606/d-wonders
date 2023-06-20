local projectile_entity_id = GetUpdatedEntityID()

local before_x, before_y = EntityGetTransform(projectile_entity_id)
local enemy_entity_ids = EntityGetInRadiusWithTag(before_x, before_y, 70, "enemy")

if enemy_entity_ids[1] == nil then
  return
end

local after_x = 0
local after_y = 0
local min_distance = nil

for _, enemy_entity_id in ipairs(enemy_entity_ids) do
  local x, y = EntityGetTransform(enemy_entity_id)
  local distance = math.sqrt((before_x - x) ^ 2 + (before_y - y) ^ 2)
  if min_distance == nil then
    min_distance = distance
    after_x = x
    after_y = y
  end

  if min_distance > distance then
    min_distance = distance
    after_x = x
    after_y = y
  end
end

EntitySetTransform(projectile_entity_id, after_x, after_y)

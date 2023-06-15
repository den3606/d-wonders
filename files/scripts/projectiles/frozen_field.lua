local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity_id)
for _, enemy_entity_id in ipairs(EntityGetInRadiusWithTag(x, y, 250, "enemy")) do
  local enemy_x, enemy_y = EntityGetTransform(enemy_entity_id)
  EntityAddChild(enemy_entity_id, EntityLoad("data/entities/misc/effect_frozen.xml", enemy_x, enemy_y))
end

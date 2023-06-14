local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity_id)
for _, c4_entity_id in ipairs(EntityGetInRadiusWithTag(x, y, 210, "dw_remote_bomb")) do
  EntityKill(c4_entity_id)
end

for _, c4_entity_id in ipairs(EntityGetInRadiusWithTag(x, y, 350, "dw_remote_bomb_giga")) do
  EntityKill(c4_entity_id)
end


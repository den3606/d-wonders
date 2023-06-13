local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity_id)
for _, c4_entity_id in ipairs(EntityGetInRadiusWithTag(x, y, 300, "dw_remote_bomb")) do
  EntityKill(c4_entity_id)
end

dofile("data/scripts/lib/utilities.lua")

local cannon_ball_seed_entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform(cannon_ball_seed_entity_id)
EntityLoadToEntity("mods/d-wonders/files/entities/projectiles/deck/cannon_ball.xml", cannon_ball_seed_entity_id)

for _, component_id in ipairs(EntityGetAllComponents(cannon_ball_seed_entity_id)) do
  if ComponentHasTag(component_id, "dw_cannon_ball_seed") then
    EntityRemoveComponent(cannon_ball_seed_entity_id, component_id)
  end
end

EntityLoad("mods/d-wonders/files/entities/projectiles/deck/cannon_ball_battery.xml", x, y)

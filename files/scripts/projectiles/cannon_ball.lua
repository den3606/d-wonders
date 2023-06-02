dofile("data/scripts/lib/utilities.lua")

local cannon_ball_seed_entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform(cannon_ball_seed_entity_id)
EntityLoadToEntity("mods/d-wonders/files/entities/projectiles/deck/cannon_ball.xml", cannon_ball_seed_entity_id)
EntityLoad("mods/d-wonders/files/entities/projectiles/deck/cannon_ball_battery.xml", x, y)

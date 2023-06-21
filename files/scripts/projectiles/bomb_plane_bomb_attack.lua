dofile_once("data/scripts/lib/utilities.lua")

local plane_entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform(plane_entity_id)

EntityLoad("mods/d-wonders/files/entities/projectiles/dropped_bomb.xml", x, y)

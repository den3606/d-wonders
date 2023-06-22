dofile("data/scripts/lib/utilities.lua")
dofile_once("data/scripts/lib/utilities.lua")

local attack_plane_entity_id = GetUpdatedEntityID()
local projectile_x, projectile_y = EntityGetTransform(attack_plane_entity_id)

if (attack_plane_entity_id == nil) then
  return
end
local projectile_component_id = EntityGetFirstComponentIncludingDisabled(attack_plane_entity_id, "ProjectileComponent")

if projectile_component_id == nil then
  return
end

local shooter_entity_id = ComponentGetValue2(projectile_component_id, "mWhoShot")
if shooter_entity_id == nil then
  return
end

local velocity_component_id = EntityGetFirstComponentIncludingDisabled(attack_plane_entity_id, "VelocityComponent")
local vel_x, vel_y = ComponentGetValue2(velocity_component_id, "mVelocity")

local distance = math.sqrt((projectile_x - vel_x) ^ 2 + (projectile_y - vel_y) ^ 2)
local normalized_vel_x = vel_x / distance
local normalized_vel_y = vel_y / distance
local r = 950
local ejection_port_x = projectile_x + normalized_vel_x * r
local ejection_port_y = projectile_y + normalized_vel_y * r

shoot_projectile(shooter_entity_id, "data/entities/projectiles/deck/machinegun_bullet.xml", ejection_port_x, ejection_port_y, vel_x * 4, vel_y * 4)

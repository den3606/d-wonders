dofile("data/scripts/lib/utilities.lua")

local attack_plane_entity_id = GetUpdatedEntityID()
local projectile_x = EntityGetTransform(attack_plane_entity_id)

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

local shooter_x = EntityGetTransform(shooter_entity_id)

if projectile_x < shooter_x then
  local sprite_component_id = EntityGetFirstComponentIncludingDisabled(attack_plane_entity_id, "SpriteComponent", "dw_attack_plane.left")
  if sprite_component_id == nil then
    return
  end
  EntitySetComponentIsEnabled(attack_plane_entity_id, sprite_component_id, true)

  local particle_emitter_component_id = EntityGetFirstComponentIncludingDisabled(attack_plane_entity_id, "ParticleEmitterComponent")
  if particle_emitter_component_id == nil then
    return
  end
  ComponentSetValueVector2(particle_emitter_component_id, "offset", 6, -3)
else
  local sprite_component_id = EntityGetFirstComponentIncludingDisabled(attack_plane_entity_id, "SpriteComponent", "dw_attack_plane.right")
  if sprite_component_id == nil then
    return
  end
  EntitySetComponentIsEnabled(attack_plane_entity_id, sprite_component_id, true)
end

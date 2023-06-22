local projectile_entity_id = GetUpdatedEntityID()

local projectile_component_ids = EntityGetComponentIncludingDisabled(projectile_entity_id, "ProjectileComponent") or {}

for _, projectile_component_id in ipairs(projectile_component_ids) do
  ComponentSetValue2(projectile_component_id, "mWhoShot", 0)
end


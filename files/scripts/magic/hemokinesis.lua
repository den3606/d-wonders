dofile_once("mods/twitch-point-integration/files/scripts/lib/utilities.lua")

local projectile_entity_id = GetUpdatedEntityID()
if not EntityHasTag(projectile_entity_id, "dw_hemokinesis") then
  return
end

local projectile_component_id = EntityGetFirstComponent(projectile_entity_id, "ProjectileComponent")
if projectile_component_id == nil then
  return
end

local who_shot = ComponentGetValue2(projectile_component_id, "mWhoShot")

local damage_model_component = EntityGetFirstComponent(who_shot, "DamageModelComponent")
if damage_model_component == nil then
  return
end

local hp = ComponentGetValue2(damage_model_component, "hp")
ComponentSetValue2(damage_model_component, "hp", hp - 0.04)

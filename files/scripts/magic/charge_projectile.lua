dofile_once("mods/twitch-point-integration/files/scripts/lib/utilities.lua")

local projectile_entity_id = GetUpdatedEntityID()
if not EntityHasTag(projectile_entity_id, "dw_charge_projectile") then
  return
end
local velocity_component_id = EntityGetFirstComponent(projectile_entity_id, "VelocityComponent")
if velocity_component_id == nil then
  return
end
local projectile_component_id = EntityGetFirstComponent(projectile_entity_id, "ProjectileComponent")
if projectile_component_id == nil then
  return
end

local who_shot = ComponentGetValue2(projectile_component_id, "mWhoShot")

local controls_component = EntityGetFirstComponent(who_shot, "ControlsComponent")
if controls_component == nil then
  return
end
local vel_x, vel_y = ComponentGetValueVector2(controls_component, "mAimingVector")
local vel_x = vel_x * 10
local vel_y = vel_y * 25

local character_data_component = EntityGetFirstComponentIncludingDisabled(who_shot, "CharacterDataComponent")
if character_data_component == nil then
  return
end

ComponentSetValue2(character_data_component, "mVelocity", vel_x, vel_y)
EntityKill(projectile_entity_id)

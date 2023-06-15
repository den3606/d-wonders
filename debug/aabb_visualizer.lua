-- This code stolen from https://discord.com/channels/453998283174576133/632303734877192192/1083389259370733730
-- Horscht has ownership
function visualize_aabb(entity_id, component_type)
  local component_type
  local types = {"MaterialAreaCheckerComponent", "AreaDamageComponent", "CollisionTriggerComponent", "HitboxComponent", "CharacterDataComponent"}
  local component
  for i, t in ipairs(types) do
    component = EntityGetFirstComponent(entity_id, t)
    if component then
      component_type = t
      break
    end
  end
  local aabb = {}
  local a, b, c, d
  if component_type == "MaterialAreaCheckerComponent" then
    a, b, c, d = ComponentGetValue2(component, "area_aabb")
  elseif component_type == "AreaDamageComponent" then
    a, b = ComponentGetValue2(component, "aabb_min")
    c, d = ComponentGetValue2(component, "aabb_max")
  elseif component_type == "CollisionTriggerComponent" then
    local width = ComponentGetValue2(component, "width")
    local height = ComponentGetValue2(component, "height")
    a, b = -width / 2, -height / 2
    c, d = width / 2, height / 2
  elseif component_type == "HitboxComponent" then
    a = ComponentGetValue2(component, "aabb_min_x")
    b = ComponentGetValue2(component, "aabb_min_y")
    c = ComponentGetValue2(component, "aabb_max_x")
    d = ComponentGetValue2(component, "aabb_max_y")
  elseif component_type == "CharacterDataComponent" then
    a = ComponentGetValue2(component, "collision_aabb_min_x")
    b = ComponentGetValue2(component, "collision_aabb_min_y")
    c = ComponentGetValue2(component, "collision_aabb_max_x")
    d = ComponentGetValue2(component, "collision_aabb_max_y")
  end
  aabb.min_x = a
  aabb.min_y = b
  aabb.max_x = c
  aabb.max_y = d
  local width = aabb.max_x - aabb.min_x
  local height = aabb.max_y - aabb.min_y
  local scale_x = width / 20
  local scale_y = height / 20
  local ent = EntityCreateNew()
  -- local x, y, rot = EntityGetTransform(entity_id)
  -- EntitySetTransform(ent, x, y, rot)
  EntityAddComponent2(ent, "InheritTransformComponent", {
    rotate_based_on_x_scale = true,
  })
  EntityAddChild(entity_id, ent)
  EntityAddComponent2(ent, "SpriteComponent", {
    image_file = "data/debug/whitebox.png",
    special_scale_x = scale_x,
    special_scale_y = scale_y,
    offset_x = -aabb.min_x / scale_x,
    offset_y = -aabb.min_y / scale_y,
    has_special_scale = true,
    alpha = 0.5,
    z_index = -99,
    smooth_filtering = true,
  })
end

local entity_id = GetUpdatedEntityID()
visualize_aabb(entity_id)

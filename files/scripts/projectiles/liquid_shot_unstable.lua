local projectile_entity_id = GetUpdatedEntityID()

SetRandomSeed(GameGetFrameNum(), GameGetFrameNum() + 456444)
local liquid_shots = {"liquid_shot_light", "liquid_shot_acid", "liquid_shot_angry", "liquid_shot_blood", "liquid_shot_charm", "liquid_shot_dark", "liquid_shot_insect", "liquid_shot_lava",
                      "liquid_shot_mana", "liquid_shot_oil", "liquid_shot_poison", "liquid_shot_soft", "liquid_shot_speed", "liquid_shot_teleport", "liquid_shot_toxic", "liquid_shot_water",
                      "liquid_shot_chaos"}
local rand = Random(0, #liquid_shots)
if rand == 0 then
  return
end

if liquid_shots[rand] == "liquid_shot_chaos" then
  local entity_number = Random(1, 10)
  EntityLoadToEntity("mods/d-wonders/files/entities/projectiles/deck/liquid_shot_chaos_" .. tostring(entity_number) .. ".xml", projectile_entity_id)
else
  EntityLoadToEntity("mods/d-wonders/files/entities/projectiles/deck/" .. liquid_shots[rand] .. ".xml", projectile_entity_id)
end

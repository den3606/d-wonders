local x, y = EntityGetTransform(GetUpdatedEntityID())

EntityLoad("data/entities/projectiles/deck/material_blood.xml", x, y)
EntityLoad("data/entities/projectiles/deck/material_blood.xml", x, y)

local frinedlies = {'sheep', 'sheep_bat', 'sheep_fly', 'fish', 'deer'}
local weakers = {'rat', 'zombie', 'longleg'}
local normals = {'miner_weak', 'miner', 'shotgunner_weak', 'shotgunner', 'scavenger_smg'}
local harders = {'scavenger_leader', 'sniper', 'scavenger_poison'}
local luckies = {'scavenger_heal'}
local legendaries = {'boss_dragon'}

SetRandomSeed(x, y)
local rand = Random(1, 1000000)
local rand100 = Random(1, 100)

if rand < 900000 then
  EntityLoad("data/entities/projectiles/deck/material_blood.xml", x, y)
  EntityLoad("data/entities/projectiles/deck/material_blood.xml", x, y)
end

if rand < 500000 then
  if rand100 > 30 then

    for i = 1, Random(1, #frinedlies) do
      SetRandomSeed(x + i, y + i)
      local frinedly = frinedlies[Random(1, #frinedlies)]
      EntityLoad("data/entities/animals/" .. frinedly .. ".xml", x, y)
    end
    local weaker = weakers[Random(1, #weakers)]
    EntityLoad("data/entities/animals/" .. weaker .. ".xml", x, y)

  elseif rand100 > 20 then

    local frinedly = frinedlies[Random(1, #frinedlies)]
    EntityLoad("data/entities/animals/" .. frinedly .. ".xml", x, y)

    for i = 1, Random(1, #normals) do
      SetRandomSeed(x + i, y + i)
      local normal = frinedlies[Random(1, #normals)]
      EntityLoad("data/entities/animals/" .. normal .. ".xml", x, y)
    end

  elseif rand100 > 10 then

    for i = 1, Random(1, #normals) do
      SetRandomSeed(x + i, y + i)
      local normal = frinedlies[Random(1, #normals)]
      EntityLoad("data/entities/animals/" .. normal .. ".xml", x, y)
    end

    local harder = harders[Random(1, #harders)]
    EntityLoad("data/entities/animals/" .. harder .. ".xml", x, y)

  else
    if Random(1, 2) == 1 then
      EntityLoad("data/entities/animals/" .. luckies[Random(1, #luckies)] .. ".xml", x, y)
    else
      EntityLoad("data/entities/projectiles/deck/exploding_deer.xml", x, y) -- explosive deer
    end
  end
end

if rand == 1 then
  local legend = legendaries[Random(1, #legendaries)]
  EntityLoad("data/entities/animals/" .. legend .. ".xml", x, y)
end


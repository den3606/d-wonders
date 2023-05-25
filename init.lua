dofile_once("mods/d-wonders/files/scripts/lib/utilities.lua")

print("d-wonders load")

function OnModPreInit()
  -- print("Mod - OnModPreInit()") -- First this is called for all mods
end

function OnModInit()
  -- print("Mod - OnModInit()") -- After that this is called for all mods
end

function OnModPostInit()
  -- print("Mod - OnModPostInit()") -- Then this is called for all mods
end

function OnPlayerSpawned(player_entity) -- This runs when player entity has been created
  -- GamePrint("OnPlayerSpawned() - Player entity id: " .. tostring(player_entity))
end

function OnWorldInitialized() -- This is called once the game world is initialized. Doesn't ensure any world chunks actually exist. Use OnPlayerSpawned to ensure the chunks around player have been loaded or created.
  -- GamePrint("OnWorldInitialized() " .. tostring(GameGetFrameNum()))
end

function OnWorldPreUpdate() -- This is called every time the game is about to start updating the world
  -- GamePrint("Pre-update hook " .. tostring(GameGetFrameNum()))
end

function OnWorldPostUpdate() -- This is called every time the game has finished updating the world
  -- GamePrint("Post-update hook " .. tostring(GameGetFrameNum()))
end

function OnMagicNumbersAndWorldSeedInitialized() -- this is the last point where the Mod* API is available. after this materials.xml will be loaded.
end

-- ModLuaFileAppend("data/scripts/perks/perk_list.lua",
--   "mods/d-wonders/files/scripts/append/perk_list.lua")
ModLuaFileAppend("data/scripts/gun/gun_actions.lua",
  "mods/d-wonders/files/scripts/append/gun_actions.lua")


local content = ModTextFileGetContent("data/translations/common.csv")
local noita_remover_content = ModTextFileGetContent(
  "mods/d-wonders/files/translations/common.csv")
ModTextFileSetContent("data/translations/common.csv", content .. noita_remover_content)


print("d-wonders loaded")

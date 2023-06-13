dofile_once("mods/d-wonders/files/scripts/lib/utilities.lua")

local ACTION_ID = "DW_REMOTE_BOMB_CONTROLLER"

function enabled_changed(entity_id, is_enabled)
  if is_enabled then
    return
  end

  local x, y = EntityGetTransform(entity_id)
  local entity_ids = EntityGetInRadiusWithTag(x, y, 200, "card_action")

  local exist_controller = false
  for _, entity_id in ipairs(entity_ids) do
    local item_action_component = EntityGetFirstComponentIncludingDisabled(entity_id, "ItemActionComponent")
    if item_action_component then
      if ComponentGetValue2(item_action_component, "action_id") == ACTION_ID then
        exist_controller = true
      end
    end
  end

  if not exist_controller then
    CreateItemActionEntity(ACTION_ID, x, y - 10)
  end
end

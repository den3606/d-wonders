dofile_once("data/scripts/lib/utilities.lua")
dofile_once("mods/d-wonders/files/scripts/lib/utilities.lua")

local function payment(shooter_entity_id, colliding_entity_id)
  local damage_model_component_id = EntityGetFirstComponent(colliding_entity_id, "DamageModelComponent")
  if not damage_model_component_id then
    print_error("colliding_entity didn't have hp")
    print('1')
    return false
  end

  local hp = ComponentGetValue2(damage_model_component_id, "hp")
  local payment_gold = math.ceil(hp / 0.4)
  if payment_gold >= 100 then
    payment_gold = 100
  end

  local wallet = EntityGetFirstComponent(shooter_entity_id, "WalletComponent")
  if not wallet then
    print('2')
    return false
  end

  local gold = ComponentGetValue2(wallet, "money")
  local gold_after_payment = gold - payment_gold

  if gold_after_payment >= 0 then
    ComponentSetValue2(wallet, "money", gold_after_payment)
  else
    local shooter_damage_model_component_id = EntityGetFirstComponent(shooter_entity_id, "DamageModelComponent")
    if not shooter_damage_model_component_id then
      print('3')
      return false
    end

    local shooter_hp = ComponentGetValue2(shooter_damage_model_component_id, "hp")
    local shooter_hp_after_payment = shooter_hp - (payment_gold * 0.02)
    if shooter_hp_after_payment >= 0.04 then
      ComponentSetValue2(shooter_damage_model_component_id, "hp", shooter_hp_after_payment)
    else
      KillPlayer("$dw_overpayment_dead")
    end
  end
  return true
end

local function contract(colliding_entity_id)
  local x, y = EntityGetTransform(colliding_entity_id)
  local charm_entity_id = EntityLoad("data/entities/misc/effect_charm_short.xml", x, y)
  EntityAddChild(colliding_entity_id, charm_entity_id)

  local projectile_entity_id = GetUpdatedEntityID()
  local projectile_component_id = EntityGetFirstComponent(projectile_entity_id, "ProjectileComponent")
  if projectile_component_id then
    local shooter_entity_id = ComponentGetValue2(projectile_component_id, "mWhoShot")
    if shooter_entity_id then
      local paid = payment(shooter_entity_id, colliding_entity_id)
      if not paid then
        GamePrint("$dw_lucky_contract")
      end
    end
  end

  EntityKill(projectile_entity_id)
end

function collision_trigger(colliding_entity_id)
  if EntityHasTag(colliding_entity_id, "enemy") then
    contract(colliding_entity_id)
  end
end

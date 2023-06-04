local projectile_entity_id = GetUpdatedEntityID()
GamePrint('charge_bolt_force_delete')
GamePrint('charge_bolt_force_delete entity_id: ' .. projectile_entity_id)
EntityKill(projectile_entity_id)

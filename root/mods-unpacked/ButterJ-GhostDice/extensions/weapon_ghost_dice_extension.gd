extends Weapon

## Removes the custom effects from the effects array before calling the parent function
## This is so that the effects do not get handled by the parent function
## Instead the effects will be handled by this class and added back after
func on_killed_something(_thing_killed: Node, hitbox: Hitbox) -> void :
	var effects_replacing_vanilla : Array = _get_effects_replacing_vanilla_effects()

	_remove_effects_replacing_vanilla(effects_replacing_vanilla)
	
	.on_killed_something(_thing_killed, hitbox)
	
	_add_back_and_apply_effects_replacing_vanilla(effects_replacing_vanilla)


func _get_effects_replacing_vanilla_effects() -> Array:
	var effects_replacing_vanilla : Array
	
	for effect in effects:
		if effect is GainStatEveryKilledEnemiesEffect:
			if effect.custom_key == "gain_random_amount_of_stat":
				effects_replacing_vanilla.append(effect)
	
	return effects_replacing_vanilla


func _remove_effects_replacing_vanilla(effects_replacing_vanilla: Array):
	for effect in effects_replacing_vanilla:
		var effect_index : int = effects.find(effect)
		effects.remove(effect_index)


func _add_back_and_apply_effects_replacing_vanilla(effects_replacing_vanilla: Array):
	for effect in effects_replacing_vanilla:
		effects.append(effect)
		_try_add_random_bonus_stat_range(effect)


func _try_add_random_bonus_stat_range(effect: Effect):
	if _enemies_killed_this_wave_count % effect.value == 0:
			var randomized_stat_value : int = effect.get_randomized_stat()
			RunData.add_stat(effect.stat, randomized_stat_value, player_index)
			for n in randomized_stat_value:
				emit_signal("tracked_value_updated")

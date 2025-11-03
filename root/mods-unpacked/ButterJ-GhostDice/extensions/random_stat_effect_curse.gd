extends "res://dlcs/dlc_1/dlc_1_data.gd"


func curse_item(item_data: ItemParentData, player_index: int, turn_randomization_off: bool = false, min_modifier: float = 0.0) -> ItemParentData:
	var is_new_curse_effect : bool = false

	for effect in item_data.effects:
		if effect is GainStatEveryKilledEnemiesEffect:
			if effect.effect.custom_key == "gain_random_amount_of_stat":
				is_new_curse_effect = true

	var new_item_data

	if(is_new_curse_effect):
		new_item_data = _get_extension_curse_item_data(item_data, player_index, turn_randomization_off, min_modifier)
	else:
		new_item_data = _get_base_curse_item_data(item_data, player_index, turn_randomization_off, min_modifier)

	return new_item_data


func _get_base_curse_item_data(item_data: ItemParentData, player_index: int, turn_randomization_off: bool = false, min_modifier: float = 0.0) -> ItemParentData:
	var item_parent_data : ItemParentData = .curse_item(item_data, player_index, turn_randomization_off, min_modifier)

	return item_parent_data


func _get_extension_curse_item_data(item_data: ItemParentData, player_index: int, turn_randomization_off: bool = false, min_modifier: float = 0.0) -> ItemParentData:
	if item_data.is_cursed:
		return item_data

	var new_effects: = []
	var max_effect_modifier = 0.0
	var curse_effect_modified: = false
	var new_item_data = item_data.duplicate()

	for effect in item_data.effects:
		var new_effect = effect.duplicate()
		var effect_modifier: = _get_cursed_item_effect_modifier(turn_randomization_off, min_modifier)
		max_effect_modifier = max(max_effect_modifier, effect_modifier)

		if effect is GainStatEveryKilledEnemiesEffect:
			if effect.custom_key == "gain_random_amount_of_stat":
				new_effect.value = _boost_effect_value_positively(new_effect, effect_modifier, true, Sign.NEGATIVE)

		new_effects.append(new_effect)

	if not curse_effect_modified:
		var curse_effect = Effect.new()
		curse_effect.key = "stat_curse"
		curse_effect.value = round(max(1.0, curse_per_item_value * item_data.value * (1.0 + max_effect_modifier))) as int
		curse_effect.effect_sign = Sign.OVERRIDE
		new_effects.append(curse_effect)

	new_item_data.effects = new_effects
	new_item_data.is_cursed = true

	new_item_data.curse_factor = max_effect_modifier

	return new_item_data

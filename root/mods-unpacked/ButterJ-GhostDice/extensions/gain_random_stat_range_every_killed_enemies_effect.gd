extends GainStatEveryKilledEnemiesEffect

## The minimum to maximum stats given are hardcoded from 1-2
## This is because problems where encountered with adding export variables
## The original approach with export variables is commented out for now

#export (int) var minimum_stat_nb = 1
#export (int) var maximum_stat_nb = 2

static func get_id() -> String:
	return "weapon_gain_random_stat_range_every_killed_enemies"


func get_args(_player_index: int) -> Array:
	var args
	
	if custom_key == "gain_random_amount_of_stat":
		args = get_args_random(_player_index)
	else:
		args = .get_args(_player_index)
		
	return args


func get_args_random(_player_index: int) -> Array:
	var stat_nb_text : String = "1-2"
	return [stat_nb_text, tr(stat.to_upper()), str(value)]


func serialize() -> Dictionary:
	var serialized = .serialize()

	serialized.stat = stat
	#serialized.minimum_stat_nb = minimum_stat_nb
	#serialized.maximum_stat_nb = maximum_stat_nb

	return serialized


func deserialize_and_merge(serialized: Dictionary) -> void :
	.deserialize_and_merge(serialized)

	stat = serialized.stat
	#minimum_stat_nb = serialized.minimum_stat_nb as int
	#maximum_stat_nb = serialized.maximum_stat_nb as int
	
	
func get_randomized_stat() -> int:
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	#var random_stat_value : int = rng.randi_range(minimum_stat_nb, maximum_stat_nb)
	var random_stat_value : int = rng.randi_range(1, 2)

	return random_stat_value

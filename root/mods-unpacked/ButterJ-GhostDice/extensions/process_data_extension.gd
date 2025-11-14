extends "res://singletons/progress_data.gd"

const EXTENSION_DIRECTORY = "res://mods-unpacked/ButterJ-GhostDice/extensions/"


func load_dlc_pcks() -> void :
	.load_dlc_pcks()
	load_dlc_dependent_extensions()


func load_dlc_dependent_extensions():
	ModLoaderMod.install_script_extension(EXTENSION_DIRECTORY + "random_stat_builder_turret.gd")
	ModLoaderMod.install_script_extension(EXTENSION_DIRECTORY + "random_stat_effect_curse.gd")

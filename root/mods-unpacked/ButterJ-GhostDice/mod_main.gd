extends Node

const GHOSTDICE_LOG = "ButterJ-GhostDice"
const CONTENT_DIRECTORY = "res://mods-unpacked/ButterJ-GhostDice/content_data/"
const EXTENSION_DIRECTORY = "res://mods-unpacked/ButterJ-GhostDice/extensions/"


func _init():
	ModLoaderLog.info("Init", GHOSTDICE_LOG)
	
	_install_script_extensions()


func _install_script_extensions():
	ModLoaderMod.install_script_extension(EXTENSION_DIRECTORY + "gain_random_stat_range_every_killed_enemies_effect.gd")
	ModLoaderMod.install_script_extension(EXTENSION_DIRECTORY + "weapon_ghost_dice_extension.gd")
	ModLoaderMod.install_script_extension(EXTENSION_DIRECTORY + "process_data_extension.gd")

func _ready():
	ModLoaderLog.info("Ready", GHOSTDICE_LOG)
	_load_mod_content()


func _load_mod_content():
	ModLoaderLog.info("Loading custom content", GHOSTDICE_LOG)
	
	var ContentLoader = get_node("/root/ModLoader/Darkly77-ContentLoader/ContentLoader")

	ContentLoader.load_data(CONTENT_DIRECTORY + "ghost_dice.tres", GHOSTDICE_LOG)

extends Node

const START_MENU = preload("res://scenes/start-menu.tscn")
const OFFICE_1 = preload("res://scenes/office1/office_1.tscn")

func goto_start_menu() -> void:
	get_tree().change_scene_to_packed(START_MENU)

func goto_office_1() -> void:
	get_tree().change_scene_to_packed(OFFICE_1)

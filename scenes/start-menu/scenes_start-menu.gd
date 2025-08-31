extends Control


func _ready() -> void:
	$HBoxContainer/CenterContainer/Main/StartGame.grab_focus()


func _on_start_game_pressed() -> void:
	SceneManager.goto_office_1()


func _on_difficulty_button_up() -> void:
	$HBoxContainer/CenterContainer/Main.visible = false
	$HBoxContainer/CenterContainer/SelectDifficulty.visible = true
	$HBoxContainer/CenterContainer/SelectDifficulty.get_children()[Data.DIFFICULTY].grab_focus()


func _handle_select_difficulty(level: int) -> void:
	Data.set_difficulty(level)
	$HBoxContainer/CenterContainer/Main.visible = true
	$HBoxContainer/CenterContainer/SelectDifficulty.visible = false
	$HBoxContainer/CenterContainer/Main/Difficulty.grab_focus()

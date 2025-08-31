extends PanelContainer


func _on_visibility_changed() -> void:
	$VBoxContainer/Restart.grab_focus()


func _on_restart_pressed() -> void:
	SceneManager.goto_office_1()


func _on_quit_pressed() -> void:
	SceneManager.goto_start_menu()

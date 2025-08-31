extends Node2D

@export var MAIN_CAMERA : Camera2D
@export var MAIN_CHARACTER : CharacterBody2D
@export var PLAYING_FIELD : TileMapLayer


func _ready() -> void:
	var limits = PLAYING_FIELD.get_used_rect()
	
	MAIN_CAMERA.limit_left = limits.position.x * 16
	MAIN_CAMERA.limit_right = limits.end.x * 16
	MAIN_CAMERA.limit_top = limits.position.y * 16
	MAIN_CAMERA.limit_bottom = limits.end.y * 16
	
	MAIN_CHARACTER.set_constraints(limits.position.x * 16, limits.end.x * 16)


func _handle_time_up() -> void:
	$Player/Camera2D/CanvasLayer/GameOver.visible = true
	$Player/Camera2D/CanvasLayer/GameOver/VBoxContainer/GameOver.text = "GAME OVER!"
	$Player/Camera2D/CanvasLayer/GameOver/VBoxContainer/Label2.text = "You failed to reach the top floor in time, and have been shafted for your promotion... \n\n Try Again?"
	get_tree().paused = true


func _on_win_zone_entered(body: Node2D) -> void:
	if body != $Player: return
	$Player/Camera2D/CanvasLayer/GameOver.visible = true
	$Player/Camera2D/CanvasLayer/GameOver/VBoxContainer/GameOver.text = "YOU DID IT!"
	$Player/Camera2D/CanvasLayer/GameOver/VBoxContainer/Label2.text = "You made it to the interview. The CEO was impressed with your time management skills and has put you in charge of facilities management. You first duty: fix the elevators! \n\n Play again?"
	get_tree().paused = true

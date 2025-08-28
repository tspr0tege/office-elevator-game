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

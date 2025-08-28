extends Node2D

@export var connected_elevator : Node2D

func use_elevator(player) -> void:
	if !is_instance_valid(connected_elevator): return
	var moving_to = connected_elevator.position
	moving_to += Vector2(8, 0)
	player.position = moving_to

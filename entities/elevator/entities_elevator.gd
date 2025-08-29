extends Node2D

@export var connected_elevator : Node2D

func use_elevator(player) -> Vector2:
	if !is_instance_valid(connected_elevator): return Vector2.ZERO
	var moving_to = connected_elevator.position
	moving_to += Vector2(8, 0)
	return moving_to

extends Node2D

@export var connected_elevator : Node2D
@export var OUT_OF_ORDER := false


func _ready() -> void:
	if OUT_OF_ORDER: $AnimatedSprite2D.frame = 1

func use_elevator(player) -> Vector2:
	if OUT_OF_ORDER:
		return Vector2.ZERO
	
	#Direct elevator
	if is_instance_valid(connected_elevator): 
		var moving_to = connected_elevator.position
		moving_to += Vector2(8, 0)
		return moving_to
	
	#Risk-it Elevator
	var elevator_shaft = get_shaft_group()
	if elevator_shaft.size() > 0:
		elevator_shaft.sort_custom(func(a, b): return a.position.y > b.position.y)
		var index = randi_range(0, elevator_shaft.size()-1)
		var moving_to = elevator_shaft[index].position
		moving_to += Vector2(8, 0)
		player.connect("finished_traversing", break_shaft.bind(elevator_shaft, player))
		return moving_to
	
	return Vector2.ZERO


func break_shaft(elevators_in_shaft : Array, player) -> void:
	for elevator in elevators_in_shaft:
		elevator.break_elevator()
	player.disconnect("finished_traversing", break_shaft)


func break_elevator() -> void:
	OUT_OF_ORDER = true
	$AnimatedSprite2D.frame = 1


func get_shaft_group() -> Array:
	var shaft_group = []
	var in_groups = get_groups()
	for group in in_groups:
		if group.begins_with("#"): 
			shaft_group = get_tree().get_nodes_in_group(group)
			break
	return shaft_group

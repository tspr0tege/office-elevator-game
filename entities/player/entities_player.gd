extends CharacterBody2D

signal finished_traversing

const WALK_SPEED := 100.0
const RUN_SPEED := 200.0
var GRAVITY = ProjectSettings.get_setting("physics/2d/default_gravity")
var CONSTRAINTS : Vector2
var TRAVERSING_TO := Vector2.ZERO
var TRAVERSING_SPEED := 20.0

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	var sprite : AnimatedSprite2D = $AnimatedSprite2D
	
	if TRAVERSING_TO != Vector2.ZERO:
		var gap = TRAVERSING_TO.y - position.y
		var move_by = (TRAVERSING_SPEED * delta) * (gap / abs(gap))
		if abs(gap) < abs(move_by): #finished traversing
			position.y = TRAVERSING_TO.y
			TRAVERSING_TO = Vector2.ZERO
			visible = true
			finished_traversing.emit()
			#if $Stairwell_sfx.playing: $Stairwell_sfx.stop()
		else:
			position.y += move_by
		return
	
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	
	var direction = Input.get_axis("ui_left", "ui_right")
	var SPEED = RUN_SPEED if Input.is_action_pressed("Run") else WALK_SPEED
	velocity.x = direction * SPEED
	
	if velocity.x != 0: sprite.flip_h = velocity.x < 0
	
	if velocity.x == 0:
		sprite.play("idle")
	elif SPEED > WALK_SPEED:
		sprite.play("run")
	else:
		sprite.play("walk")
	
	if Input.is_action_just_pressed("ui_up"):
		var areas = $OnObject.get_overlapping_areas()
		for area in areas:
			var object = area.get_parent()
			if object.is_in_group("Elevators"):
				var target_position = object.use_elevator(self)
				if target_position != Vector2.ZERO:
					TRAVERSING_TO = target_position
					TRAVERSING_SPEED = 75
					visible = false
				break
			if object.is_in_group("Stairwells"):
				var stair_col = func(stair: Node2D):
					return (object.position.x == stair.position.x) and (stair.position.y < object.position.y)
				var stairwells = get_tree().get_nodes_in_group("Stairwells")
				var valid_stairwells = stairwells.filter(stair_col)
				if valid_stairwells.size() > 1:
					valid_stairwells.sort_custom(func(a, b): return a.position.y > b.position.y)
				if valid_stairwells.size() > 0:
					visible = false
					TRAVERSING_TO = valid_stairwells[0].position
					TRAVERSING_SPEED = 20
					#$Stairwell_sfx.play(0.0)
					#position.y = valid_stairwells[0].position.y
				break
	
	if Input.is_action_just_pressed("ui_down"):
		var areas = $OnObject.get_overlapping_areas()
		for area in areas:
			var object = area.get_parent()
			if object.is_in_group("Stairwells"):
				var stair_col = func(stair: Node2D):
					return (object.position.x == stair.position.x) and (stair.position.y > object.position.y)
				var stairwells = get_tree().get_nodes_in_group("Stairwells")
				var valid_stairwells = stairwells.filter(stair_col)
				if valid_stairwells.size() > 1:
					valid_stairwells.sort_custom(func(a, b): return a.position.y < b.position.y)
				if valid_stairwells.size() > 0:
					visible = false
					TRAVERSING_TO = valid_stairwells[0].position
					TRAVERSING_SPEED = 20
					#$Stairwell_sfx.play(0.0)
					#position.y = valid_stairwells[0].position.y
				break
	
	move_and_slide()
	position.x = clamp(position.x, CONSTRAINTS.x + 16, CONSTRAINTS.y - 16)

func set_constraints(left, right) -> void:
	CONSTRAINTS = Vector2(left, right)

extends CharacterBody2D

const WALK_SPEED := 100.0
const RUN_SPEED := 200.0
var GRAVITY = ProjectSettings.get_setting("physics/2d/default_gravity")
var CONSTRAINTS : Vector2

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	var sprite : AnimatedSprite2D = $AnimatedSprite2D
	
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
				object.use_elevator(self)
				break
	
	move_and_slide()
	position.x = clamp(position.x, CONSTRAINTS.x + 16, CONSTRAINTS.y - 16)

func set_constraints(left, right) -> void:
	CONSTRAINTS = Vector2(left, right)

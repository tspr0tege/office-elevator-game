extends CharacterBody2D

const WALK_SPEED := 150.0
const RUN_SPEED := 300.0
var GRAVITY = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	
	var direction = Input.get_axis("ui_left", "ui_right")
	var SPEED = RUN_SPEED if Input.is_action_pressed("Run") else WALK_SPEED
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()

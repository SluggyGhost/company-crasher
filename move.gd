
extends CharacterBody2D

const MAX_SPEED := 500.0
const FRICTION := 8.0
const ACCELERATION := 5.0

func _physics_process(delta: float) -> void:
	var input_dir = Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	).normalized()

	var target_velocity = input_dir * MAX_SPEED

	var lerp_weight = delta * (ACCELERATION if input_dir != Vector2.ZERO else FRICTION)
	velocity = velocity.lerp(target_velocity, lerp_weight)
	
	move_and_slide()

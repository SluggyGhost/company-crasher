extends CharacterBody2D

const MAX_SPEED := 500.0
const FRICTION := 8.0
const ACCELERATION := 5.0

var player_size: int = 2   # starting "score" size (optional, still useful)

func grow_player(amount: int) -> void:
	player_size += amount
	# Grow the whole player (sprite + collision)
	scale += Vector2(0.05, 0.05) * amount
	# Clamp so it doesn't get insanely huge or tiny
	scale.x = clamp(scale.x, 0.3, 5.0)
	scale.y = clamp(scale.y, 0.3, 5.0)
	print("Player grew! New size value:", player_size, " scale:", scale)

func get_pixel_size() -> Vector2:
	# How big the player appears on screen, in pixels
	if $Sprite2D.texture == null:
		return Vector2.ZERO
	return $Sprite2D.texture.get_size() * $Sprite2D.global_scale

func _physics_process(delta: float) -> void:
	var input_dir = Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	).normalized()

	var target_velocity = input_dir * MAX_SPEED
	var lerp_weight = delta * (ACCELERATION if input_dir != Vector2.ZERO else FRICTION)

	velocity = velocity.lerp(target_velocity, lerp_weight)
	move_and_slide()

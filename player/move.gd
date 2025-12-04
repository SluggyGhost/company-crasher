extends CharacterBody2D

# --- Movement Constants ---
const MAX_SPEED_DEFAULT: float = 500.0
const FRICTION: float = 8.0
const ACCELERATION: float = 5.0

# --- Zoom Settings ---
const ZOOM_MAX_IN: float = 1.0
const ZOOM_MAX_OUT: float = 0.1

# Player size "score"
var player_size: int = 2

# --- Current movement speed (can be boosted temporarily) ---
var max_speed: float = MAX_SPEED_DEFAULT

# Timer for power-up
var speed_boost_timer: Timer


func _ready() -> void:
	# Camera setup
	if not has_node("Camera2D"):
		push_warning("Player has no Camera2D child — zoom won't work.")
	else:
		_update_camera_zoom()

	# Create a Timer node to handle speed boosts
	speed_boost_timer = Timer.new()
	speed_boost_timer.one_shot = true
	speed_boost_timer.timeout.connect(_on_speed_boost_timeout)
	add_child(speed_boost_timer)


# --- Growth / Shrink ---
func grow_player(amount: int) -> void:
	player_size += amount

	scale += Vector2(0.05 * amount, 0.05 * amount)
	scale.x = clamp(scale.x, 0.3, 500.0)
	scale.y = clamp(scale.y, 0.3, 500.0)
	
	max_speed += 50;

	print("Player size:", player_size, " scale:", scale)

	_update_camera_zoom()


# --- CAMERA ZOOM ---
func _update_camera_zoom() -> void:
	if not has_node("Camera2D"):
		return

	var cam: Camera2D = $Camera2D
	var t: float = (scale.x - 0.3) / (5.0 - 0.3)
	t = clamp(t, 0.0, 1.0)
	var zoom_value: float = lerp(ZOOM_MAX_IN, ZOOM_MAX_OUT, t)
	cam.zoom = Vector2(zoom_value, zoom_value)


# --- Power-up methods ---
func apply_speed_boost(multiplier: float, duration: float) -> void:
	max_speed = max_speed * multiplier
	# Restart timer
	speed_boost_timer.start(duration)
	print("Speed boost applied! New speed:", max_speed, " for", duration, "seconds")


func _on_speed_boost_timeout() -> void:
	max_speed = max_speed /2
	print("Speed boost ended. Speed reset to:", max_speed)


# --- Pixel Size Helper ---
func get_pixel_size() -> Vector2:
	if $Sprite2D.texture == null:
		return Vector2.ZERO

	var tex: Texture2D = $Sprite2D.texture
	var tex_size: Vector2 = tex.get_size()
	var global_scale: Vector2 = $Sprite2D.global_scale

	return tex_size * global_scale


# --- Movement ---
func _physics_process(delta: float) -> void:
	var x_input: float = (
		Input.get_action_strength("ui_right")
		- Input.get_action_strength("ui_left")
	)

	var y_input: float = (
		Input.get_action_strength("ui_down")
		- Input.get_action_strength("ui_up")
	)

	var input_dir: Vector2 = Vector2(x_input, y_input).normalized()

	var target_velocity: Vector2 = input_dir * max_speed
	var lerp_weight: float = delta * (ACCELERATION if input_dir != Vector2.ZERO else FRICTION)

	velocity = velocity.lerp(target_velocity, lerp_weight)
	move_and_slide()

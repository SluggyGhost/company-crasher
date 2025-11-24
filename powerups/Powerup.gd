extends Area2D

# --- Configurable properties ---
@export var speed_multiplier: float = 2.0      # How much to multiply player speed
@export var duration: float = 10.0            # Duration of the effect in seconds

func _ready() -> void:
	# Connect the body entered signal to detect player collisions
	connect("body_entered", Callable(self, "_on_body_entered"))


func _on_body_entered(body: Node) -> void:
	# Only affect the player
	if body.is_class("CharacterBody2D") and body.has_method("apply_speed_boost"):
		# Apply speed boost
		body.apply_speed_boost(speed_multiplier, duration)
		# Remove power-up from scene
		queue_free()

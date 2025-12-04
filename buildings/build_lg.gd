extends Node2D

@export var building_size_required: int = 1
@export var reward: int = 1

var particleScene = preload("res://Fire.tscn")
var sfx = preload("res://Assets/Sound/demolitionExplosionLarge.mp3")

func _ready():
	$Area2D.body_entered.connect(_on_body_entered)
	add_to_group("building") # Recommended

func _on_body_entered(body):
	if not body.is_in_group("player"):
		return

	# Check destroy eligibility
	if body.player_size >= building_size_required:
		print("Building destroyed!")
		body.grow_player(reward)

		# Sound
		SoundManager.playSFX2D(sfx, 0.05)

		# Effect
		var effectInstance = particleScene.instantiate()
		effectInstance.scaleMin = 72
		get_tree().current_scene.add_child(effectInstance)
		effectInstance.global_position = $Area2D.global_position

		# Notify destruction
		get_tree().current_scene.get_node("GameManager").register_destroyed_building()

		queue_free()
	else:
		print("Player is too small to destroy this building")
		# 🚫 Removed show_loss — handled globally

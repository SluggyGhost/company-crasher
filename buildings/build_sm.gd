extends Node2D

@export var building_size_required: int = 1
@export var reward: int = 1

func _ready():
	$Area2D.body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body.is_in_group("player"):
		if body.player_size >= building_size_required:
			print("Building destroyed!")
			body.grow_player(reward)
			queue_free()
		else:
			print("Player is too small to destroy this building.")

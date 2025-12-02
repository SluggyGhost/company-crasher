extends Node2D

@export var building_size_required: int = 1
@export var reward: int = 1
var particleScene = preload("res://Fire.tscn");
var sfx = preload("res://Assets/Sound/demolitionExplosionLarge.mp3");

func _ready():
	$Area2D.body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body.is_in_group("player"):
		if body.player_size >= building_size_required:
			print("Building destroyed!")
			body.grow_player(reward)
		
		# SFX
		SoundManager.playSFX2D(sfx, 0.05);
			
		# Fire effect on destruction
		var effectInstance = particleScene.instantiate();
		effectInstance.scaleMin = 72;
		get_tree().current_scene.add_child(effectInstance);
		effectInstance.global_position = $Area2D.global_position;
		
		queue_free()
	else:
		print("Player is too small to destroy this building.")

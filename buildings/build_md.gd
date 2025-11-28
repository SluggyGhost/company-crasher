extends Node2D

@export var reward: int = 3  # how much the player grows when this building is destroyed
var particleScene = preload("res://Fire.tscn");

func _ready() -> void:
	$Area2D.body_entered.connect(_on_body_entered)

func get_pixel_size() -> Vector2:
	if $Sprite2D.texture == null:
		return Vector2.ZERO
	return $Sprite2D.texture.get_size() * $Sprite2D.global_scale

func _on_body_entered(body: Node2D) -> void:
	if not body.is_in_group("player"):
		return

	if not body.has_method("get_pixel_size"):
		return

	var player_pixel_len: float = body.get_pixel_size().length()
	var building_pixel_len: float = get_pixel_size().length()

	print("Collision: player_px =", player_pixel_len, " building_px =", building_pixel_len)

	if player_pixel_len > building_pixel_len:
		print("Player is bigger → destroying building")
		if body.has_method("grow_player"):
			body.grow_player(reward)
		
		# Fire effect on destruction
		var effectInstance = particleScene.instantiate();
		effectInstance.scaleMin = 24;
		get_tree().current_scene.add_child(effectInstance);
		effectInstance.global_position = $Area2D.global_position;
		queue_free()
	else:
		print("Player too small → cannot destroy this building yet")

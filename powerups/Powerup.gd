extends Area2D

@export_enum("size", "speed", "invis") var type : String = "size"

func _on_body_entered(body):
	if body.is_in_group("player"):
		body.apply_powerup(type)
		queue_free()

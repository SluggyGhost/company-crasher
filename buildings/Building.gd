extends Area2D   # Use Area2D so it can detect player collisions

@export var building_size: int = 1  # 1=small, 2=medium, 3=large

signal building_entered(building_size, building_ref)

func _on_body_entered(body):
	if body.is_in_group("player"):
		emit_signal("building_entered", building_size, self)


func _on_building_area_2d_body_entered(body: Node2D) -> void:
	pass # Replace with function body.

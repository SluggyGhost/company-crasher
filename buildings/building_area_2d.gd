extends Area2D

@export var building_size: int = 1

signal building_entered(size, building_ref)

func _on_Building_body_entered(body):
	if body.is_in_group("player"):
		emit_signal("building_entered", building_size, self)


func _on_body_entered(body: Node2D) -> void:
	pass # Replace with function body.

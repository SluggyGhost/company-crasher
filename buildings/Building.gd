#These are people

extends Node2D

@export var building_size_required: int = 20
@export var reward: int = 5

signal building_destroyed(building_ref)
signal building_blocked(building_ref)

func _ready():
	$Area2D.body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body.is_in_group("player"):
		if body.player_size >= building_size_required:
			emit_signal("building_destroyed", self)
			body.grow_player(reward)
			queue_free()   # remove the building
		else:
			emit_signal("building_blocked", self)
			# too small → do nothing (player blocked by StaticBody2D)

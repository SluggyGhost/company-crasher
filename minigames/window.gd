extends Button

@onready var window_crack: Sprite2D = $"Cracked Glass"

func _ready() -> void:
	window_crack.visible = false


func _on_pressed() -> void:
	window_crack.visible = true

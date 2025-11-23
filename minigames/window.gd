extends Button

@onready var window_crack: Sprite2D = $"Cracked Glass"

func _ready() -> void:
	window_crack.visible = false


func _on_pressed() -> void:
	window_crack.visible = true
	var choice = randi() % 3
	if (choice == 0):
		$Glass1SFX.play()
	else:
		if (choice == 1):
			$Glass2SFX.play()
		else:
			$Glass3SFX.play()

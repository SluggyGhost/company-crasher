extends Button

@onready var window_crack: Sprite2D = $"Cracked Glass"
@onready var glass1: AudioStreamPlayer = $Glass1SFX
@onready var glass2: AudioStreamPlayer = $Glass2SFX
@onready var glass3: AudioStreamPlayer = $Glass3SFX

func _ready() -> void:
	window_crack.visible = false


func _on_pressed() -> void:
	window_crack.visible = true
	var choice = randi() % 3
	if (choice == 0):
		glass1.play()
	else:
		if (choice == 1):
			glass2.play()
		else:
			glass3.play()

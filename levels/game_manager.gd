extends Node

@onready var game_over_ui = $"../UI/GameOver"
@onready var label_win  = game_over_ui.get_node("CenterContainer/VBoxContainer/LabelWin")
@onready var label_lose = game_over_ui.get_node("CenterContainer/VBoxContainer/LabelLose")

var total_buildings := 0
var destroyed_buildings := 0

func _ready():
	# Count all buildings in the scene
	total_buildings = get_tree().get_nodes_in_group("building").size()
	print("Total buildings:", total_buildings)

	# Hide UI at start
	game_over_ui.visible = false
	label_win.visible = false
	label_lose.visible = false

func register_destroyed_building():
	destroyed_buildings += 1
	print("Destroyed count:", destroyed_buildings)

	if destroyed_buildings >= total_buildings:
		show_win()

func check_loss_condition(player_pixel_size: float):
	for building in get_tree().get_nodes_in_group("building"):
		if building.has_method("get_pixel_size"):
			var building_size = building.get_pixel_size().length()
			if player_pixel_size > building_size:
				# Player can still destroy something — not stuck
				return

	# If we reach here, player is stuck → loss
	show_loss()

func show_win():
	print("WIN triggered")
	game_over_ui.visible = true
	label_win.visible = true
	label_lose.visible = false
	get_tree().paused = true

func show_loss():
	print("LOSS triggered")
	game_over_ui.visible = true
	label_win.visible = false
	label_lose.visible = true
	get_tree().paused = true

extends CharacterBody2D;

@export var damage = 2;
@export var speed: float = 100.0;
var spawnPos: Vector2;

var player: CharacterBody2D = null;

func _ready():
	spawnPos = global_position;
	player = get_tree().get_first_node_in_group("player");
	$Area2D.body_entered.connect(_on_body_entered)

	if not player:
		print("Enemy Error: Player node not found in group 'player'!");
		set_process(false);
		return;

func _physics_process(_delta: float):
	if player:
		var direction: Vector2 = global_position.direction_to(player.global_position);;
		
		velocity = direction * speed;
		
		move_and_slide();

func _on_body_entered(body):
	if body.is_in_group("player"):
		body.grow_player(-damage);
		global_position = spawnPos;
		$ouch.play()

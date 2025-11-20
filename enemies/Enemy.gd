extends CharacterBody2D

@export var damage = 1;
@export var speed: float = 100.0;

var player: CharacterBody2D = null;

func _physics_process(delta: float):
	if player:
		var direction: Vector2 = global_position.direction_to(player.global_position);;
		
		velocity = direction * speed;
		
		move_and_slide();

func _on_body_entered(body):
	if body.is_in_group("player"):
		body.shrink(damage);

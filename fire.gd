extends Node2D
@export var scaleMin = 6;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CPUParticles2D.set_param_min($CPUParticles2D.PARAM_SCALE, scaleMin);
	$CPUParticles2D.set_param_max($CPUParticles2D.PARAM_SCALE, scaleMin * 2);
	$CPUParticles2D.emitting = true;
	await get_tree().create_timer(12.0).timeout;
	$CPUParticles2D.emitting = false;
	await get_tree().create_timer($CPUParticles2D.lifetime).timeout;
	queue_free();

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

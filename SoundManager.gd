extends Node

func playSFX2D(stream: AudioStream, pitch_variance: float = 0.0):
	if stream == null:
		return
		
	var player = AudioStreamPlayer2D.new()
	player.stream = stream
	
	if pitch_variance > 0:
		var random_pitch = randf_range(1.0 - pitch_variance, 1.0 + pitch_variance)
		player.pitch_scale = random_pitch
	
	add_child(player)
	player.play()
	
	player.finished.connect(player.queue_free)

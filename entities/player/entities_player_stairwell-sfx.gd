extends AudioStreamPlayer2D

func _on_finished() -> void:
	pitch_scale = randf_range(0.9, 1.1)
	play()

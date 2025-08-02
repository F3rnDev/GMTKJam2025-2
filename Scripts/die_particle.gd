extends GPUParticles2D

func _init() -> void:
	emitting = true

func _on_finished() -> void:
	queue_free()

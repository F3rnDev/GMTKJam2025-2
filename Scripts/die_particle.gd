extends GPUParticles2D

func _init() -> void:
	emitting = true

func _ready() -> void:
	$hit.play()

func _on_finished() -> void:
	queue_free()

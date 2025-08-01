extends AnimatedSprite2D

@onready var projectileRef = preload("res://projectile.tscn")

func _process(delta: float) -> void:
	look_at(get_global_mouse_position())

	if Input.is_action_just_pressed("Shoot"):
		shootBullet()

func shootBullet():
	var projectile = projectileRef.instantiate()

	# Calcula a direção vetorial do disparo
	var dir_vector = (get_global_mouse_position() - global_position).normalized()

	projectile.direction = dir_vector
	projectile.spawnPos = global_position

	get_tree().current_scene.add_child(projectile)

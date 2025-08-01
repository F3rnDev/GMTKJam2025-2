extends AnimatedSprite2D

@onready var projectileRef = preload("res://projectile.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	look_at(get_global_mouse_position())
	
	if Input.is_action_just_pressed("Shoot"):
		shootBullet()

func shootBullet():
	var projectile = projectileRef.instantiate()
	projectile.direction = rotation + (PI/2)
	projectile.spawnPos = global_position
	
	get_tree().current_scene.add_child(projectile)

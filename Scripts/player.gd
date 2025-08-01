extends AnimatedSprite2D

@onready var projectileRef = preload("res://Nodes/projectile.tscn")
@export var shootSpeed = 5.0

func _ready() -> void:
	$Speed.wait_time = shootSpeed

func _process(delta: float) -> void:
	look_at(get_global_mouse_position())

	if Input.is_action_pressed("Shoot") and $Speed.is_stopped():
		shootBullet()

func shootBullet():
	$Speed.start()
	var projectile = projectileRef.instantiate()

	# Calcula a direção vetorial do disparo
	var dir_vector = (get_global_mouse_position() - global_position).normalized()

	projectile.direction = dir_vector
	projectile.spawnPos = global_position

	get_tree().current_scene.add_child(projectile)


func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("Enemy"):
		queue_free()

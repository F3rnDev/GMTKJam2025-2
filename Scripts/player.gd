extends AnimatedSprite2D

@onready var projectileRef = preload("res://Nodes/projectile.tscn")
@onready var dieParticle = preload("res://Nodes/dieParticle.tscn")
@export var shootSpeed = 5.0

@export var maxHealth = 3.0
var health = maxHealth

var currentMoney = 0

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
		area.get_parent().killEnemy()
		
		spawnDieParticle()
		receiveHit()

func receiveHit():
	health -= 1
	
	get_parent().updatePlayerLife()
	get_parent().shake()
	
	if health <= 0:
		get_parent().roundRunning = false
		queue_free()

func spawnDieParticle():
	var particle = dieParticle.instantiate()
	particle.global_position = global_position
	
	get_tree().current_scene.add_child(particle)

func setMoney(amount):
	#IntegrateUpdate Later
	currentMoney += amount

extends AnimatedSprite2D

@onready var projectileRef = preload("res://Nodes/projectile.tscn")
@onready var dieParticle = preload("res://Nodes/dieParticle.tscn")
var health = PlayerStats.defaultHealth

@onready var mouseCooldown = preload("res://Nodes/mouseCooldown.tscn")
var mouseCooldownInstance

func _ready() -> void:
	updateStats()
	PlayerStats.healthChanged.connect(updateHealth)
	PlayerStats.attackSpdChanged.connect(updateAttackSpeed)
	
	setMouseCooldown()

func setMouseCooldown():
	mouseCooldownInstance = mouseCooldown.instantiate()
	mouseCooldownInstance.setCooldownMaxTime($Speed.wait_time)
	
	get_tree().current_scene.add_child.call_deferred(mouseCooldownInstance)

func updateStats():
	updateHealth()
	updateAttackSpeed()

func updateHealth():
	health = PlayerStats.defaultHealth * (1.25 ** (PlayerStats.health - 1))

func updateAttackSpeed():
	$Speed.wait_time = PlayerStats.defaultAttackSpeed * (0.95 ** (PlayerStats.attackSpeed - 1))

func _process(delta: float) -> void:
	look_at(get_global_mouse_position())

	if Input.is_action_pressed("Shoot") and $Speed.is_stopped():
		shootBullet()
	
	if $Speed.is_stopped():
		mouseCooldownInstance.visible = false
	else:
		mouseCooldownInstance.visible = true
		mouseCooldownInstance.setCooldownCurTime($Speed.time_left)

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
		area.get_parent().queue_free()
		
		spawnDieParticle()
		receiveHit()

func receiveHit():
	health -= 1
	
	get_parent().updatePlayerLife()
	get_parent().shake()
	get_parent().enemiesSpawned -= 1
	
	if health <= 0:
		get_parent().roundRunning = false
		Music.isGameOver = true
		get_parent().gameOver = true
		queue_free()

func spawnDieParticle():
	var particle = dieParticle.instantiate()
	particle.global_position = global_position
	
	get_tree().current_scene.add_child(particle)

func setMoney(amount):
	var moneyWithLoot = amount * (1.25 ** (PlayerStats.loot - 1))
	PlayerStats.coinAmount += roundi(moneyWithLoot)

extends CharacterBody2D

@export var playerRef:AnimatedSprite2D
@onready var dieParticle = preload("res://Nodes/dieParticle.tscn")
var enemySpeed = 100.0

@export var moneyValue = 20

func _physics_process(delta: float) -> void:
	if playerRef:
		var targetPos = (playerRef.global_position - global_position).normalized()
		velocity = targetPos * enemySpeed
		move_and_slide()

func _on_hit_hurtbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("Projectile"):
		area.get_parent().queue_free()
		get_parent().updatePlayerMoney(moneyValue)
		killEnemy()

func killEnemy():
	spawnDieParticle()
	
	get_parent().enemyDead += 1
	get_parent().updateEnemiesLeft()
	
	queue_free()

func spawnDieParticle():
	var particle = dieParticle.instantiate()
	particle.global_position = global_position
	
	get_tree().current_scene.add_child(particle)

extends CharacterBody2D

@export var playerRef:AnimatedSprite2D
var enemySpeed = 100.0

func _physics_process(delta: float) -> void:
	if playerRef:
		var targetPos = (playerRef.global_position - global_position).normalized()
		velocity = targetPos * enemySpeed
		move_and_slide()

func _on_hit_hurtbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("Projectile"):
		queue_free()

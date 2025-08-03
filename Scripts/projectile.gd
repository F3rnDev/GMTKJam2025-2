extends CharacterBody2D

@export var bulletSpeed = 500.0
var direction: Vector2 = Vector2.ZERO
var spawnPos: Vector2 = Vector2.ZERO

func _ready() -> void:
	global_position = spawnPos
	rotation = direction.angle()
	$Shoot.play()

func _process(delta: float) -> void:
	velocity = direction * bulletSpeed
	rotation_degrees += 1
	move_and_slide()

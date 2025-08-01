extends CharacterBody2D

@export var bulletSpeed = 500.0
var direction:float = 0.0
var spawnPos:Vector2 = Vector2.ZERO


func _ready() -> void:
	global_position = spawnPos

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	velocity = Vector2(0, -bulletSpeed).rotated(direction)
	move_and_slide()

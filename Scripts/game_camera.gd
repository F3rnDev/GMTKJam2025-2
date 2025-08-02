extends Camera2D

#camera shake
@export var rngStr:float = 20.0
@export var shakeFade:float = 5.0

var rng = RandomNumberGenerator.new()
var shakeStr = 0.0

func _process(delta: float) -> void:
	if shakeStr > 0:
		shakeStr = lerpf(shakeStr, 0, shakeFade * delta)
		offset = randomOffset()

func shakeCamera():
	shakeStr = rngStr

func randomOffset() -> Vector2:
	return Vector2(rng.randf_range(-shakeStr, shakeStr), rng.randf_range(-shakeStr, shakeStr))

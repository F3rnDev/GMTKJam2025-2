extends ProgressBar

@export var yOffset = 45.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position = get_global_mouse_position() - Vector2(size.x/2, yOffset)

func setCooldownMaxTime(maxTime):
	max_value = maxTime

func setCooldownCurTime(time):
	value = time

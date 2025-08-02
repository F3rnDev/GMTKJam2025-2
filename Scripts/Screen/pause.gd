extends Control

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel") and visible == false:
		visible = true
		get_tree().paused = true
	elif Input.is_action_just_pressed("ui_cancel") and visible == true:
		get_tree().paused = false
		visible = false

func _on_resume_button_down() -> void:
	get_tree().paused = false
	visible = false

func _on_quit_button_down() -> void:
	get_tree().quit()

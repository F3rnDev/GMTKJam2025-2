extends Control

func _ready() -> void:
	if OS.has_feature("web"):
		$Content/Buttons/Quit.queue_free()

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("Cancel") and visible == false:
		visible = true
		get_tree().paused = true
		$Content/Buttons/Resume.grab_focus()
	elif Input.is_action_just_pressed("Cancel") and visible == true:
		get_tree().paused = false
		visible = false

func _on_resume_button_down() -> void:
	get_tree().paused = false
	visible = false

func _on_quit_button_down() -> void:
	get_tree().quit()

func _on_main_menu_button_down() -> void:
	Transition.transitionToScene("res://Scenes/main_menu.tscn")

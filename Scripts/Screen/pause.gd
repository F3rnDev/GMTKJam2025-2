extends Control

var gameOver = false

func _ready() -> void:
	if OS.has_feature("web"):
		$Content/Buttons/Quit.queue_free()

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("Cancel") and visible == false and !gameOver:
		visible = true
		get_tree().paused = true
		Music.setMusic(Music.MusicType.Menu)
	elif Input.is_action_just_pressed("Cancel") and visible == true:
		Music.setMusic(Music.MusicType.Game)
		get_tree().paused = false
		visible = false

func _on_resume_button_down() -> void:
	$Audio/Accept.play()
	Music.setMusic(Music.MusicType.Game)
	get_tree().paused = false
	visible = false

func _on_quit_button_down() -> void:
	$Audio/Accept.play()
	get_tree().quit()

func _on_main_menu_button_down() -> void:
	$Audio/Accept.play()
	Transition.transitionToScene("res://Scenes/main_menu.tscn")
	get_tree().paused = false

func _on_focus_entered() -> void:
	$Audio/Move.play()

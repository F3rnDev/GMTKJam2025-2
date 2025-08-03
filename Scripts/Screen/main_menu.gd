extends Control

func _ready() -> void:
	if OS.has_feature("web"):
		$Content/Buttons/Quit.queue_free()
	
	Music.setMusic(Music.MusicType.Menu)

func _on_start_button_down() -> void:
	$Audio/Accept.play()
	Transition.transitionToScene("res://Nodes/game.tscn")

func _on_options_button_down() -> void:
	$Audio/Accept.play()
	get_tree().change_scene_to_file("res://Scenes/options.tscn")

func _on_quit_button_down() -> void:
	$Audio/Accept.play()
	get_tree().quit()

func _on_focus_entered() -> void:
	$Audio/Move.play()

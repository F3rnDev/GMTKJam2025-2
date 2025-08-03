extends Control

func _on_apply_button_down() -> void:
	$Audio/Accept.play()
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")

func _on_fullscreen_toggled(toggled_on: bool) -> void:
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	
	$Audio/Accept.play()

func _on_master_value_changed(value: float) -> void:
	var audioID = AudioServer.get_bus_index("Master")
	AudioServer.set_bus_volume_db(audioID, linear_to_db(value))
	$Panel/Margin/Content/AudioSection/AudioOptions/Master/HBoxContainer/Percent.text = str(roundi(value*100))+"%"

func _on_music_value_changed(value: float) -> void:
	var audioID = AudioServer.get_bus_index("Music")
	AudioServer.set_bus_volume_db(audioID, linear_to_db(value))
	$Panel/Margin/Content/AudioSection/AudioOptions/Music/HBoxContainer/Percent.text = str(roundi(value*100))+"%"

func _on_sfx_value_changed(value: float) -> void:
	var audioID = AudioServer.get_bus_index("Sfx")
	AudioServer.set_bus_volume_db(audioID, linear_to_db(value))
	$Panel/Margin/Content/AudioSection/AudioOptions/SFX/HBoxContainer/Percent.text = str(roundi(value*100))+"%"
	$Audio/Move.play()

func _on_focus_entered() -> void:
	$Audio/Move.play()

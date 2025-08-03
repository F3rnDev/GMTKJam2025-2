extends Control

func _ready() -> void:
	setAudioBusValues()

func setAudioBusValues():
	var masterAudioID = AudioServer.get_bus_index("Master")
	var musicAudioID = AudioServer.get_bus_index("Music")
	var sfxAudioID = AudioServer.get_bus_index("Sfx")
	
	var masterAudio = db_to_linear(AudioServer.get_bus_volume_db(masterAudioID))
	var musicAudio = db_to_linear(AudioServer.get_bus_volume_db(musicAudioID))
	var sfxAudio = db_to_linear(AudioServer.get_bus_volume_db(sfxAudioID))
	
	$Panel/Margin/Content/AudioSection/AudioOptions/Master/HBoxContainer/Percent.text = str(roundi(masterAudio*100))+"%"
	$Panel/Margin/Content/AudioSection/AudioOptions/Music/HBoxContainer/Percent.text = str(roundi(musicAudio*100))+"%"
	$Panel/Margin/Content/AudioSection/AudioOptions/SFX/HBoxContainer/Percent.text = str(roundi(sfxAudio*100))+"%"
	
	$Panel/Margin/Content/AudioSection/AudioOptions/Master/HBoxContainer/HSlider.value = masterAudio
	$Panel/Margin/Content/AudioSection/AudioOptions/Music/HBoxContainer/HSlider.value = musicAudio
	$Panel/Margin/Content/AudioSection/AudioOptions/SFX/HBoxContainer/HSlider.value = sfxAudio

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

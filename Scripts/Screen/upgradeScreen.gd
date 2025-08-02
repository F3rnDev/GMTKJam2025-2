extends Control


func _on_life_gain_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("Shoot"):
		print("Selecionou")


func _on_attack_speed_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("Shoot"):
		print("Selecionou")


func _on_more_loot_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("Shoot"):
		print("Selecionou")

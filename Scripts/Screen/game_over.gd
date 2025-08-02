extends Control


func _on_restart_button_down() -> void:
	get_tree().change_scene_to_file("res://Nodes/game.tscn")


func _on_main_menu_button_down() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")

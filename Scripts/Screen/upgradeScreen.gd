extends Control

signal continueGame

func _on_button_button_down() -> void:
	visible = false
	continueGame.emit()

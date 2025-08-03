extends Control

signal continueGame

func _ready() -> void:
	Music.setMusic(Music.MusicType.Menu)

func _on_button_button_down() -> void:
	$Audio/Accept.play()
	visible = false
	continueGame.emit()

func _on_button_mouse_entered() -> void:
	$Audio/Move.play()

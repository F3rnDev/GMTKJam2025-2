extends Control

signal continueGame

func _ready() -> void:
	Music.setMusic(Music.MusicType.Menu)

func _on_button_button_down() -> void:
	$Audio/Accept.play()
	$AnimationPlayer.play("Disapear")
	

func _on_button_mouse_entered() -> void:
	$Audio/Move.play()


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Disapear":
		visible = false
		continueGame.emit()

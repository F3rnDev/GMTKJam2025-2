extends CanvasLayer

var sceneToChange = null

func transitionToScene(path):
	sceneToChange = path
	fadeIn()

func fadeIn():
	if $Animation.is_playing():
		return
	
	visible = true
	$Animation.play("fadeIn")

func fadeOut():
	get_tree().change_scene_to_file(sceneToChange)
	
	$Animation.play("fadeOut")

func _on_transition_animation_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fadeIn":
		fadeOut()
	elif anim_name == "fadeOut":
		sceneToChange = null
		visible = false

extends AudioStreamPlayer

enum MusicType{Menu, Game}

var curMusic = MusicType.Menu
var isGameOver = false

var audioID = AudioServer.get_bus_index("Music")
var pitch = AudioServer.get_bus_effect(audioID, 0)

func setMusic(music):
	get_stream_playback().switch_to_clip(music);

func _process(delta: float) -> void:
	if isGameOver:
		pitch.pitch_scale = max(pitch.pitch_scale - (0.5 * delta), 0.1)
	elif !isGameOver and pitch.pitch_scale < 1.0:
		pitch.pitch_scale = min(pitch.pitch_scale + (0.5 * delta), 1.0)

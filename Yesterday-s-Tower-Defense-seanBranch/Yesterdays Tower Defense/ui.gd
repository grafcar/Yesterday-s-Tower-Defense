extends CanvasLayer

var audio_muted = false

var music_bus = AudioServer.get_bus_index("Music")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Game.Health <= 0:
		get_tree().change_scene_to_file("res://GameMenu.tscn")


func _on_pause_play_pressed():
	if get_tree().is_paused():
		get_tree().paused = false
	else:
		get_tree().paused = true


func _on_speed_up_pressed():
	if Engine.get_time_scale() == 2.0:
		Engine.set_time_scale(1.0)
	else:
		Engine.set_time_scale(2.0)


func _on_mute_pressed():
	audio_muted = !audio_muted
	if audio_muted:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), true)
	else:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), false)

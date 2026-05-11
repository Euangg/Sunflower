extends Node

var auto_play:bool=false
var speed_auto_play=11
var auto_play_temp_pause:bool=false
func set_auto_play_temp_pause():
	auto_play_temp_pause=true
	%TimerTempPause.start()
func _on_timer_temp_pause_timeout() -> void:auto_play_temp_pause=false

const UI_THEME = ("uid://c2csk44knq8m4")
const UI_PLAY = ("uid://dyad0xw2m2dj6")
func switch_scene(path_scene:String):
	get_tree().call_deferred("change_scene_to_file",path_scene)

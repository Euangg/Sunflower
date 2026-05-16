extends Node

var auto_play:bool=false
var acc:bool=false
var speed_auto_play=20
var co_auto=1
var co_play=1
var auto_play_temp_pause:bool=false
func set_auto_play_temp_pause():
	auto_play_temp_pause=true
	%TimerTempPause.start()
func _on_timer_temp_pause_timeout() -> void:auto_play_temp_pause=false

const UI_THEME = ("uid://c2csk44knq8m4")
const UI_PLAY = ("uid://dyad0xw2m2dj6")
func switch_scene(path_scene:String):
	get_tree().call_deferred("change_scene_to_file",path_scene)

const SFX = preload("uid://du6350i6e62x4")
func play_sfx(stream:AudioStream):
	var sfx:AudioStreamPlayer=SFX.instantiate()
	sfx.stream=stream
	%Sfx.add_child(sfx)

func play_bgm(path_bgm:String):
	%Bgm.stream=load(path_bgm)
	%Bgm.play()
func stop_bgm():%Bgm.stop()
func _on_bgm_finished() -> void:%Bgm.play()

var dialogue_manager:DialogueManager=null

func setting_activate():
	%Setting.show()
	
func setting_inactivate():
	%Setting.hide()
	
var load_order:int
func save_activate(save_mode:bool,theme:bool):
	%Save.show()
	%Save.refresh_saves()
	%Save.is_save_mode=save_mode
	%Save.is_main_theme=theme

func save_inactivate():
	%Save.hide()
func is_save_exist(order:int):return FileAccess.file_exists("user://sav"+String.num_int64(order)+".sav")

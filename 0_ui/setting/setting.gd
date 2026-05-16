extends Control
@onready var h_slider_play: HSlider = $HBoxContainer2/VBoxContainer/Slide/HSlider
@onready var h_slider_auto: HSlider = $HBoxContainer2/VBoxContainer/Slide2/HSlider
@onready var h_slider_bgm: HSlider = $HBoxContainer2/VBoxContainer2/Slide/HSlider
@onready var h_slider_sfx: HSlider = $HBoxContainer2/VBoxContainer2/Slide2/HSlider

func _ready() -> void:
	match DisplayServer.window_get_mode():
		DisplayServer.WINDOW_MODE_WINDOWED:%View.select(0)
		DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN:%View.select(1)
	%Language.select(0)
	h_slider_play.value=Global.co_play
	h_slider_auto.value=Global.co_auto
	
	h_slider_bgm.value=AudioServer.get_bus_volume_linear(AudioServer.get_bus_index("Bgm"))
	h_slider_sfx.value=AudioServer.get_bus_volume_linear(AudioServer.get_bus_index("Sfx"))
	
func _on_texture_button_pressed() -> void:
	Global.setting_inactivate()

func _on_view_item_selected(index: int) -> void:
	print(index,",",DisplayServer.window_get_mode())
	match index:
		0:DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		1:DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)

func _on_play_changed(value: float) -> void:Global.co_play=value
func _on_auto_changed(value: float) -> void:Global.co_auto=value

func _on_bgm_changed(value: float) -> void:
	var index=AudioServer.get_bus_index("Bgm")
	AudioServer.set_bus_volume_linear(index,value)

func _on_sfx_changed(value: float) -> void:
	var index=AudioServer.get_bus_index("Sfx")
	AudioServer.set_bus_volume_linear(index,value)

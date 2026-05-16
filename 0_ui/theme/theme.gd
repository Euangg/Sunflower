extends Control

func _ready() -> void:
	%Label.text=ProjectSettings.get_setting("application/config/version","vx.xx")

func _on_button_pressed() -> void:
	Global.load_order=0
	Global.switch_scene(Global.UI_PLAY)

func _on_button_2_pressed() -> void:
	Global.save_activate(false,true)

func _on_button_4_pressed() -> void:
	Global.setting_activate()

func _on_button_5_pressed() -> void:
	get_tree().quit()

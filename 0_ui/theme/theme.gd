extends Control


func _on_button_pressed() -> void:
	Global.switch_scene(Global.UI_PLAY)


func _on_button_2_pressed() -> void:
	Global.save_activate()

func _on_button_4_pressed() -> void:
	Global.setting_activate()

func _on_button_5_pressed() -> void:
	get_tree().quit()

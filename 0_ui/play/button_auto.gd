extends TextureButton

const 自动播放 = preload("uid://u6ba8rf1bekt")
const 自动播放_HOVER = preload("uid://djk67i1jvyoan")

func _on_pressed() -> void:
	Global.auto_play=!Global.auto_play
	if Global.auto_play:
		%Label.text="自动中"
		texture_normal=自动播放_HOVER
	else:
		%Label.text="自动"
		texture_normal=自动播放
	

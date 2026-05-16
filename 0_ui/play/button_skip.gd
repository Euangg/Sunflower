extends TextureButton

const 快进 = preload("uid://bvrrsmhyo5kd5")
const 快进中 = preload("uid://b7j7kjxi74hm4")

func _on_pressed() -> void:
	Global.acc=!Global.acc
	if Global.acc:
		%Label.text="快进中"
		texture_normal=快进中
	else:
		%Label.text="快进"
		texture_normal=快进
	

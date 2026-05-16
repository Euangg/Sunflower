class_name SaveSlot
extends TextureButton

@onready var screenshot: TextureRect = $Screenshot
@onready var time: Label = $Time
func _physics_process(delta: float) -> void:
	#if (not %TextureButton.disabled) and (is_focus_big or is_focus_small)and %Screenshot.texture:%ButtonCross.show()
	#else:%ButtonCross.hide()
	pass

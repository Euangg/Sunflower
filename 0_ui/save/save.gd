extends Control

var is_save_mode:bool=false
var is_main_theme:bool=false
var page=1
func next_page():
	if page>=3:return
	page+=1
	%Page.text=String.num_int64(page)
	refresh_saves()
func last_page():
	if page<=1:return
	page-=1
	%Page.text=String.num_int64(page)
	refresh_saves()

func _on_texture_button_pressed() -> void:Global.save_inactivate()

func _physics_process(delta: float) -> void:pass

func _on_button_left_pressed() -> void:last_page()

func _on_button_right_pressed() -> void:next_page()

var arr_button_save:Array[SaveSlot]=[]
func _ready() -> void:
	arr_button_save.append($GridContainer/Slot1)
	arr_button_save.append($GridContainer/Slot2)
	arr_button_save.append($GridContainer/Slot3)
	arr_button_save.append($GridContainer/Slot4)
	arr_button_save.append($GridContainer/Slot5)
	arr_button_save.append($GridContainer/Slot6)

func refresh_saves():
	var order=0
	for i in range((page-1)*6+1,page*6+1):
		var file_name="user://sav"+String.num_int64(i)+".png"
		if FileAccess.file_exists(file_name):
			var p:Image=Image.load_from_file(file_name)
			var ppp=ImageTexture.create_from_image(p)
			arr_button_save[order].screenshot.texture=(ppp)
			var time_unix=FileAccess.get_modified_time(file_name)
			var time_zone_info=Time.get_time_zone_from_system()
			var utc_offset_seconds=time_zone_info.bias*60
			time_unix+=utc_offset_seconds
			var date:String=Time.get_date_string_from_unix_time(time_unix)
			var time:String=Time.get_time_string_from_unix_time(time_unix)
			arr_button_save[order].time.text=(date+" "+time.erase(5,3))
		else:
			arr_button_save[order].screenshot.texture=(null)
			arr_button_save[order].time.text=("")
		order+=1
		
func button_save_pressed(order):
	if is_save_mode:
		Global.dialogue_manager.save_game(order)
		refresh_saves()
		#var confirm=CONFIRM.instantiate()
		#confirm.content="确定保存吗？"
		#confirm.yes.connect(func():
			#Global.save_game(order)
			#refresh_saves())
		#add_child(confirm)
	else:
		if !Global.is_save_exist(order):return
		if is_main_theme:
			Global.switch_scene(Global.UI_PLAY)
			Global.load_order=order
			Global.save_inactivate()
		else:
			Global.dialogue_manager.load_game(order)
			Global.save_inactivate()

func _on_slot_1_pressed() -> void:button_save_pressed((page-1)*6+1)
func _on_slot_2_pressed() -> void:button_save_pressed((page-1)*6+2)
func _on_slot_3_pressed() -> void:button_save_pressed((page-1)*6+3)
func _on_slot_4_pressed() -> void:button_save_pressed((page-1)*6+4)
func _on_slot_5_pressed() -> void:button_save_pressed((page-1)*6+5)
func _on_slot_6_pressed() -> void:button_save_pressed((page-1)*6+6)

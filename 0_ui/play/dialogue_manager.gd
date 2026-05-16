extends Control

@onready var art_xing: Character = $Xing
@onready var art_cheng: Character = $cheng
@onready var art_kui: Character = $kui

const SFX_关门 = preload("uid://cuvwsf6qjrj5t")
const SFX_故障 = preload("uid://c7mi8pwnhu83m")
const SFX_敲门 = preload("uid://dvdum8kc3h0u0")
const SFX_水滴 = preload("uid://lxxdtl7ob4mg")
const SFX_门铃 = preload("uid://dy6ep2r4d4o1p")

const BGM_平稳 = ("uid://7ythp62spqfj")
const BGM_怅然 = ("uid://bka6gdu3uu0ik")
const BGM_急迫 = ("uid://b0s80ersukiyr")
const BGM_日常 = ("uid://b0d1liq8ar5cc")
const BGM_星空 = ("uid://brjbypvbwf4cb")
const BGM_环境音_夜 = ("uid://ixf7o28slin3")
const BGM_环境音_教室 = ("uid://cv3k63xb6d7si")
const BGM_环境音_梦魇 = ("uid://ln4yhsdnwp7d")
const BGM_环境音_电车 = ("uid://0ix3h45h0pya")
const BGM_环境音_葵田 = ("uid://b5cs6juaeum4p")
const BGM_环境音_雨声 = ("uid://sr21ytxttcew")
const BGM_终焉1 = ("uid://f3kebsl5nfem")


const SCENE_BLACK = preload("uid://dn34e3flleudc")
const SCENE_家白天 = preload("uid://ducxi0lqlssns")
const SCENE_家黑天 = preload("uid://dvpro1j6mkuhb")
const SCENE_教室白天 = preload("uid://sawmxdwgw2kg")
const SCENE_树下黄昏 = preload("uid://4apkllo7q2c6")
const SCENE_校园白天 = preload("uid://tckwrcuvkys8")
const SCENE_校廊白天 = preload("uid://beo6b0fcw6u6w")
const SCENE_海边街道 = preload("uid://debgfe1wlpkna")
const SCENE_海边黑天 = preload("uid://c6dem7bswldp7")
const SCENE_玄关白天 = preload("uid://b858t6m3inr4u")
const SCENE_玄关黑天 = preload("uid://qbymvyavqr6v")
const SCENE_街道白天 = preload("uid://bjb5w25gmq0jb")
const SCENE_街道黑天 = preload("uid://bcynouxusfpjt")
const SCENE_门口白天 = preload("uid://c7quoyhtiorf7")
const SCENE_葵田白天 = preload("uid://dh2t6xmtnemqn")
const SCENE_葵田黑天 = preload("uid://c322h820dyptf")
const SCENE_葵田梦魇 = preload("uid://bhu0me1b0wjtx")
const SCENE_街道黄昏 = preload("uid://bdpi27vm1vns")
const SCENE_电车内白天 = preload("uid://b3qt5j0ob8jlq")
const SCENE_电车内黄昏 = preload("uid://dxrjl58cfo5nj")
const SCENE_海边黄昏 = preload("uid://dtqj5mu1t1ixx")
const CG_吊死的葵 = preload("uid://dfgx3ogjxx3ua")
const CG_海与星空 = preload("uid://dsaix4is0phm5")
const CG_葵田画 = preload("uid://dlxggilpa5gk1")
const CG_赶地铁 = preload("uid://cv0o1icnyjbk1")

func switch_back_scene(new_scene:PackedScene):
	for s in %NodeScene.get_children():s.queue_free()
	%NodeScene.add_child(new_scene.instantiate())
func hide_all_characters():
	art_xing.hide()
	art_cheng.hide()
	art_kui.hide()
const ScriptMain = preload("uid://do7ugl8chy5er")
const ScriptTest = preload("uid://sbxarervnfc0")

var current_script=ScriptMain
var order_curtain:int=0
func clear_dialogue_box():for d in %NodeDbox.get_children():d.queue_free()
func load_current_curtain():line_to_curtain(current_script.content[order_curtain])
func load_next_curtain(offset:int=0):
	order_curtain+=1+offset
	if order_curtain>=current_script.content.size():return
	load_current_curtain()

const DBOX = preload("uid://b5wogb611tm0o")
const DBOX_CHA = preload("uid://dsjshujhur67r")

func pick_cmd(arr_str:PackedStringArray,flag:String)->String:
	var order_start=arr_str[0].find("【")
	if order_start==-1:return ""
	var order_end=arr_str[0].find("】")
	if order_end==-1:return ""
	var length=order_end-order_start
	var cmd=arr_str[0].substr(order_start+1,length-1)
	arr_str[0]=arr_str[0].erase(order_start,length+1)
	arr_str[0]=arr_str[0].insert(order_start,flag)
	return cmd

func line_to_curtain(line:String):
	var cmd_text:PackedStringArray=line.split("：")
	var cmds:PackedStringArray=cmd_text[0].split("，")
	var text:String=cmd_text[1]
	
	#立绘
	for c in cmds:
		if c=="":continue
		var control_character:Character=null
		match c[0]:
			"幸":control_character=art_xing
			"澄":control_character=art_cheng
			"葵":control_character=art_kui
		if control_character and c.length()>1:
			control_character.show()
			match c[1]:
				"左":control_character.ap_pos.play("l")
				"中":control_character.ap_pos.play("m")
				"右":control_character.ap_pos.play("r")
			control_character.ap_pos.seek(0,true)
				#
			var face:PackedStringArray=c.split("-")
			if face.size()>1:
				var face_2:PackedStringArray=face[1].split("》")
				var decoration:PackedStringArray=face_2[0].split("+")
				control_character.ap_face.play(decoration[0])
				control_character.ap_face.seek(0,true)
				if decoration.size()>1:control_character.show_dec(decoration[1])
					#
				##渐变
				#if face_2.size()>1:
					#var new_dec:PackedStringArray=face_2[1].split("+")
					#if new_dec.size()>1:change_art_fade(c[0],new_dec[0],new_dec[1])
					#else:change_art_fade(c[0],new_dec[0],"")
					#print(c[0],":",decoration[0],">>",new_dec[0])	

	#对话框
	var default_character=null
	var dia:DialogueBox=null
	var is_4_cha:bool=true
	var cmd_dia=cmds[0]
	if cmd_dia:
		match cmd_dia[0]:
			"幸":
				dia=DBOX_CHA.instantiate()
				dia.cha_name="幸"
				default_character=art_xing
			"澄":
				dia=DBOX_CHA.instantiate()
				dia.cha_name="澄"
				default_character=art_cheng
			"葵":
				dia=DBOX_CHA.instantiate()
				dia.cha_name="葵"
				default_character=art_kui
			#"主":
				#dia=DIA_PLAYER.instantiate()
				#var player_face=characters[0].split("-")
				#dia.face=player_face[1]
				#is_4_cha=false
			#"旁":
				#dia=DIA_NARRATAGE.instantiate()
				#is_4_cha=false
			_:dia=DBOX.instantiate()
		#"选":
			#selection=DIA_SELECTION.instantiate()
			#var content=character_dialogue[1].split("-")
			#content.erase("")
			#var s1:PackedStringArray=content[0].split("+")
			#var s2:PackedStringArray=content[1].split("+")
			#selection.str_selection_1=s1[0]
			#selection.str_selection_2=s2[0]
			#var offset_1=0
			#if s1.size()>1:offset_1=s1[1].to_int()
			#selection.select_1.connect(func():
				#clear_dialogue_box()
				#hide_all_characters()
				#load_next_curtain(offset_1)
				#)
			#var offset_2=0
			#if s2.size()>1:offset_2=s2[1].to_int()
			#selection.select_2.connect(func():
				#clear_dialogue_box()
				#hide_all_characters()
				#load_next_curtain(offset_2)
				#)				
			#%FrameBottom.add_child(selection)
	else:
		dia=DBOX.instantiate()

	if dia:
		#if is_4_cha:dia.pos=characters[0][1]
		var text_offset:PackedStringArray=text.split("+")
		var offset=0
		if text_offset.size()>1:offset=text_offset[1].to_int()
		#text_offset[0]=text_offset[0].replace("【主角】",Global.name_player)
		#找指令
		while(1):
			var full_cmd=pick_cmd(text_offset,"^")
			if full_cmd=="":break
			var cmd_parameter:PackedStringArray=full_cmd.split("-")
			match cmd_parameter[0]:
				"场景","CG":
					match cmd_parameter[1]:
						"黑屏幕":dia.process.push_back(func():switch_back_scene(SCENE_BLACK))
						"葵田白天":dia.process.push_back(func():switch_back_scene(SCENE_葵田白天))
						"葵田黑天":dia.process.push_back(func():switch_back_scene(SCENE_葵田黑天))
						"葵田梦魇":dia.process.push_back(func():switch_back_scene(SCENE_葵田梦魇))
						"家白天":dia.process.push_back(func():switch_back_scene(SCENE_家白天))
						"家黑天":dia.process.push_back(func():switch_back_scene(SCENE_家黑天))
						"玄关白天":dia.process.push_back(func():switch_back_scene(SCENE_玄关白天))
						"玄关黑天":dia.process.push_back(func():switch_back_scene(SCENE_玄关黑天))

						"街道白天":dia.process.push_back(func():switch_back_scene(SCENE_街道白天))
						"街道黄昏":dia.process.push_back(func():switch_back_scene(SCENE_街道黄昏))
						"街道黑天":dia.process.push_back(func():switch_back_scene(SCENE_街道黑天))

						"电车内白天":dia.process.push_back(func():switch_back_scene(SCENE_电车内白天))
						"电车内黄昏":dia.process.push_back(func():switch_back_scene(SCENE_电车内黄昏))

						"海边黄昏":dia.process.push_back(func():switch_back_scene(SCENE_海边黄昏))
						"海边黑天":dia.process.push_back(func():switch_back_scene(SCENE_海边黑天))

						"教室白天":dia.process.push_back(func():switch_back_scene(SCENE_教室白天))
						"门口白天":dia.process.push_back(func():switch_back_scene(SCENE_门口白天))
						"校廊白天":dia.process.push_back(func():switch_back_scene(SCENE_校廊白天))
						"校园白天":dia.process.push_back(func():switch_back_scene(SCENE_校园白天))
						"树下黄昏":dia.process.push_back(func():switch_back_scene(SCENE_树下黄昏))
						
						"吊死的葵":dia.process.push_back(func():switch_back_scene(CG_吊死的葵))
						"海与星空":dia.process.push_back(func():switch_back_scene(CG_海与星空))
						"葵田画":dia.process.push_back(func():switch_back_scene(CG_葵田画))
						"赶地铁":dia.process.push_back(func():switch_back_scene(CG_赶地铁))
						_:print("指令",cmd_parameter[0],"未知参数:",cmd_parameter[1])
				"SFX":
					match cmd_parameter[1]:
						"关门":dia.process.push_back(func():Global.play_sfx(SFX_关门))
						"故障":dia.process.push_back(func():Global.play_sfx(SFX_故障))
						"敲门":dia.process.push_back(func():Global.play_sfx(SFX_敲门))
						"水滴":dia.process.push_back(func():Global.play_sfx(SFX_水滴))
						"门铃":dia.process.push_back(func():Global.play_sfx(SFX_门铃))
						_:print("指令",cmd_parameter[0],"未知参数:",cmd_parameter[1])
				"BGM":
					match cmd_parameter[1]:
						"平稳":dia.process.push_back(func():Global.play_bgm(BGM_平稳))
						"怅然":dia.process.push_back(func():Global.play_bgm(BGM_怅然))
						"急迫":dia.process.push_back(func():Global.play_bgm(BGM_急迫))
						"日常":dia.process.push_back(func():Global.play_bgm(BGM_日常))
						"星空":dia.process.push_back(func():Global.play_bgm(BGM_星空))
						"环境音_夜":dia.process.push_back(func():Global.play_bgm(BGM_环境音_夜))
						"环境音_教室":dia.process.push_back(func():Global.play_bgm(BGM_环境音_教室))
						"环境音_梦魇":dia.process.push_back(func():Global.play_bgm(BGM_环境音_梦魇))
						"环境音_电车":dia.process.push_back(func():Global.play_bgm(BGM_环境音_电车))
						"环境音_葵田":dia.process.push_back(func():Global.play_bgm(BGM_环境音_葵田))
						"环境音_雨声":dia.process.push_back(func():Global.play_bgm(BGM_环境音_雨声))
						"终焉1","终焉":dia.process.push_back(func():Global.play_bgm(BGM_终焉1))
						"停":dia.process.push_back(func():Global.stop_bgm())
						_:print("指令",cmd_parameter[0],"未知参数:",cmd_parameter[1])
				"动画":
					match cmd_parameter[1]:
						"抖动上下":dia.process.push_back(func():default_character.ap_shake.play("v"))
						_:print("指令",cmd_parameter[0],"未知参数:",cmd_parameter[1])
				"文字":
					match cmd_parameter[1]:
						"抖动上下":dia.process.push_back(func():dia.ap.play("shake"))
						_:print("指令",cmd_parameter[0],"未知参数:",cmd_parameter[1])
				_:print("未知指令:",cmd_parameter[0])

		dia.arr_text=text_offset[0].split("//")
		dia.end.connect(func():
			clear_dialogue_box()
			hide_all_characters()
			load_next_curtain(offset)
			)
		%NodeDbox.add_child(dia)

func _ready() -> void:
	load_current_curtain()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("esc"):
		if %Pause.visible:%Pause.hide()
		else:%Pause.show()

func _on_button_esc_pressed() -> void:
	%Pause.show()

func _on_button_back_pressed() -> void:
	%Pause.hide()

func _on_button_save_pressed() -> void:
	Global.save_activate()

func _on_button_load_pressed() -> void:
	Global.save_activate()

func _on_button_setting_pressed() -> void:
	Global.setting_activate()

func _on_button_theme_pressed() -> void:
	Global.switch_scene(Global.UI_THEME)

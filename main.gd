extends Node2D

#region Variabel

# Node Other
@onready var object_monitor_panel: Panel = $MonitorCanvas/MonitorPanel
@onready var object_mask_panel: TextureButton = $CanvasGroup/TextureButton
@onready var vodka_step_5 : Sprite2D = $CanvasGroup/Raka_5
@onready var suzuka_step_5 : Sprite2D = $CanvasGroup/SuzukaStep5
@onready var timer_dadu : Timer = $TimeCharakterState
@onready var object_mask_on: TextureRect = $CanvasGroup/MaskOn

# sprite panel monitor
@onready var object_cam1_panel: Sprite2D = $"MonitorCanvas/MonitorPanel/SubViewportContainer/CameraViewport/RoomCam1"
@onready var object_cam2_panel: Sprite2D = $"MonitorCanvas/MonitorPanel/SubViewportContainer/CameraViewport/RoomCam2"
@onready var object_cam3_panel: Sprite2D = $"MonitorCanvas/MonitorPanel/SubViewportContainer/CameraViewport/RoomCam3"
@onready var object_cam4_panel: Sprite2D = $"MonitorCanvas/MonitorPanel/SubViewportContainer/CameraViewport/RoomCam4"
@onready var object_cam5_panel: Sprite2D = $"MonitorCanvas/MonitorPanel/SubViewportContainer/CameraViewport/RoomCam5"
@onready var object_cam6_panel: Sprite2D = $"MonitorCanvas/MonitorPanel/SubViewportContainer/CameraViewport/RoomCam6"

# map camera button
@onready var btn_cam1: TextureButton = $MonitorCanvas/MonitorPanel/MapRoom/BtnCam1
@onready var btn_cam2: TextureButton = $MonitorCanvas/MonitorPanel/MapRoom/BtnCam2
@onready var btn_cam3: TextureButton = $MonitorCanvas/MonitorPanel/MapRoom/BtnCam3
@onready var btn_cam4: TextureButton = $MonitorCanvas/MonitorPanel/MapRoom/BtnCam4
@onready var btn_cam5: TextureButton = $MonitorCanvas/MonitorPanel/MapRoom/BtnCam5
@onready var btn_cam6: TextureButton = $MonitorCanvas/MonitorPanel/MapRoom/BtnCam6

# Audio
@onready var audio_sound_mask : AudioStreamPlayer = $CanvasGroup/TextureButton/AudioMask
@onready var audio_camera : AudioStreamPlayer = $MonitorCanvas/AudioCamera

# Animasi 
@onready var anim_camera_monitor : AnimationPlayer = $MonitorCanvas/AnimCameraMonitor
@onready var anim_char_jump : AnimationPlayer = $AnimCharJump

var sound_open_camera  = preload("res://sounds/camera/camera_close.wav")
var sound_switch_camera  = preload("res://sounds/camera/camera_switch.wav")
var sound_close_camera = preload("res://sounds/camera/camera_open.wav")
var sound_fan_camera = preload("res://sounds/camera/fan.wav")
var sound_mask_off = preload("res://sounds/mask/mask_off.wav")
var sound_mask_on = preload("res://sounds/mask/mask_on.wav")
var cooldown_open_monitor : int = 0

enum Karakter { TIDAK_ADA, SUZUKA, SPECIAL_WEEK, VOLTAR }

var sisi_dadu : Array = [
	Karakter.TIDAK_ADA,
	Karakter.TIDAK_ADA,
	Karakter.SUZUKA,
	Karakter.SPECIAL_WEEK,
	Karakter.SPECIAL_WEEK,
	Karakter.SPECIAL_WEEK,
	Karakter.VOLTAR,
	Karakter.VOLTAR
]
var block_time : Array = [7.0, 5.0, 3.0]

#endregion

func _ready() -> void:
	Global.monitor_panel = false
	object_monitor_panel.visible = false
	
	anim_camera_monitor.reset_section()
	#anim_tachyon_jump.play("RESET")
	anim_char_jump.play("RESET") 
	
	Global.camera_room_id = 0 
	vodka_step_5.visible = false
	suzuka_step_5.visible = false
	
	Global.ship_state = 0		# 0 - 6 
	Global.voltar_state = 0  	# 0 - 3
	Global.suzuka_state = 0  	# 0 - 3 
	print("[INFO] Memulai Lemparan dadu")
	timer_dadu.timeout.connect(_on_lempar_dadu)
	_set_delay_acak()
	
func _process(delta: float) -> void:
	_cek_entity_()
		
	#if Global.tachyon_scurity_visible == true:
		#_on_close_monitor()
		#anim_tachyon_jump.play("jump_tachyon")
		#Global.tachyon_scurity_visible = false
	#
	#if Global.goldship_jump == true and Global.monitor_panel == true:
		#_on_close_monitor()
		#anim_char_jump.play("susto_jump")
		#Global.goldship_jump == false

	if Input.is_action_just_pressed("buka_monitor"):
		var timer_now = Time.get_ticks_msec()
		if timer_now - cooldown_open_monitor >= 500:
			cooldown_open_monitor = timer_now

			# KONDISI 1: TUTUP MONITOR
			if Global.monitor_panel == true and object_monitor_panel.visible == true:
				anim_camera_monitor.play("anim_camera_close")
				object_monitor_panel.visible = false
				await get_tree().create_timer(0.5).timeout
				Global.monitor_panel = false
			
			# KONDISI 2: BUKA MONITOR
			elif Global.monitor_panel == false:
				anim_camera_monitor.play("anim_camera_open")
				await get_tree().create_timer(0.5).timeout  
				object_monitor_panel.visible = true
				Global.monitor_panel = true
				anim_camera_monitor.play("anim_camera_effect")

			print("Cooldown masih aktif! Jangan di-spam!")
		print("Monitor status: " + str(Global.monitor_panel))

#region Function
func _on_lempar_dadu() -> void:
	var hasil : Karakter = sisi_dadu[randi() % sisi_dadu.size()]
	print("[Dadu] Hasil: ", Karakter.keys()[hasil])
	
	match hasil:
		Karakter.SUZUKA:
			Global.suzuka_state += 1
		Karakter.SPECIAL_WEEK:
			Global.ship_state += 1
		Karakter.VOLTAR:
			Global.voltar_state += 1
		Karakter.TIDAK_ADA:
			pass
	_set_delay_acak()

func _set_delay_acak() -> void:
	timer_dadu.wait_time = block_time[randi() % block_time.size()]
	timer_dadu.start()
	print("[Dadu] Lemparan berikutnya dalam ", timer_dadu.wait_time, " detik.")

func _on_close_monitor():
	anim_camera_monitor.play("anim_camera_close")
	object_monitor_panel.visible = false
	await get_tree().create_timer(0.1).timeout
	Global.monitor_panel = false

func _cek_entity_() -> void:
	if Global.voltar_state == 5:
		vodka_step_5.visible = true
	else:
		vodka_step_5.visible = false
		
	if Global.suzuka_state == 6:
		suzuka_step_5.visible = true
	else:
		suzuka_step_5.visible = false
	
	if Global.voltar_state == 6 and Global.is_mask_on == true:
		Global.voltar_state = 0
	elif Global.voltar_state == 6 and Global.is_mask_on == false:
		Global.GameOverId = 1
		get_tree().change_scene_to_file("res://screen/gameover_screen.tscn")
		print("gameover")
		
	if Global.suzuka_state >= 7 and Global.is_mask_on == true:
		Global.suzuka_state = 0
	elif Global.suzuka_state == 7 and  Global.is_mask_on == false:
		Global.GameOverId = 2
		get_tree().change_scene_to_file("res://screen/gameover_screen.tscn")
		print("gameover")
		
	if Global.ship_state >= 6 and Global.is_mask_on == true:
		Global.ship_state = 0
	elif Global.suzuka_state == 6 and  Global.is_mask_on == false:
		Global.GameOverId = 3
		get_tree().change_scene_to_file("res://screen/gameover_screen.tscn")
		print("gameover")
		
func open_camera(id_camera: int, description: String):
	anim_camera_monitor.play("anim_camera_effect")
	
	# 1. Matikan semua kamera dulu agar bersih
	audio_camera.stream = sound_switch_camera
	audio_camera.play()
	
	object_cam1_panel.visible = false 
	object_cam2_panel.visible = false
	object_cam3_panel.visible = false 
	object_cam4_panel.visible = false
	object_cam5_panel.visible = false
	object_cam6_panel.visible = false
	
	btn_cam1.disabled = false
	btn_cam2.disabled = false
	btn_cam3.disabled = false
	btn_cam4.disabled = false
	btn_cam5.disabled = false
	btn_cam6.disabled = false
	
	await get_tree().create_timer(0.4).timeout
	audio_camera.stream = sound_fan_camera
	audio_camera.play()

	if id_camera == 0:
		Global.camera_room_id = 0 
		object_cam1_panel.visible = true
	elif id_camera == 1:
		Global.camera_room_id = 1
		object_cam2_panel.visible = true
	elif id_camera == 2:
		Global.camera_room_id = 2 
		object_cam3_panel.visible = true
	elif id_camera == 3:
		Global.camera_room_id = 3 
		object_cam4_panel.visible = true
	elif id_camera == 4:
		Global.camera_room_id = 4 
		object_cam5_panel.visible = true
	elif id_camera == 5:
		Global.camera_room_id = 5
		object_cam6_panel.visible = true
		
	print("camera id: " + str(Global.camera_room_id))
	
func _on_cam_1_button_pressed() -> void:
	open_camera(0, "Camera 1")
	btn_cam1.disabled = true

func _on_cam_2_button_pressed() -> void:
	open_camera(1, "Camera 2")
	btn_cam2.disabled = true

func _on_cam_3_button_pressed() -> void:
	open_camera(2, "Camera 3")
	btn_cam3.disabled = true
	
func _on_cam_4_button_pressed() -> void:
	open_camera(3, "Camera 4")
	btn_cam4.disabled = true

func _on_cam_5_button_pressed() -> void:
	open_camera(4, "Camera 5")
	btn_cam5.disabled = true

func _on_cam_6_button_pressed() -> void:
	open_camera(5, "Camera 6")
	btn_cam6.disabled = true
	
func _on_mask_pressed() -> void:
#	Pakai Masker : true
	if Global.is_mask_on == false:
		Global.is_mask_on = true
		#object_mask_panel.visible = true
		object_mask_on.visible = true
		audio_sound_mask.stream = sound_mask_on
		audio_sound_mask.play()
		print("masker dipake : " + str(Global.is_mask_on))
#	Pakai Masker : false
	elif Global.is_mask_on == true:
		Global.is_mask_on = false
		#object_mask_panel.visible = false
		object_mask_on.visible = false
		audio_sound_mask.stream = sound_mask_off
		audio_sound_mask.play()
		print("masker dipake: ", Global.is_mask_on)
#endregion

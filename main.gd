extends Node2D

# 1. PANGGIL NODENYA KE KODE

# monitor camera
@onready var object_monitor_panel: Panel = $MonitorCanvas/MonitorPanel
@onready var object_mask_panel: TextureButton = $CanvasGroup/TextureButton

# sprite panel monitor
@onready var object_cam1_panel: Sprite2D = $"MonitorCanvas/MonitorPanel/SubViewportContainer/CameraViewport/room-cam-1"
@onready var object_cam2_panel: Sprite2D = $"MonitorCanvas/MonitorPanel/SubViewportContainer/CameraViewport/room-cam-2"
@onready var object_cam3_panel: Sprite2D = $"MonitorCanvas/MonitorPanel/SubViewportContainer/CameraViewport/room-cam-3"
@onready var object_cam4_panel: Sprite2D = $"MonitorCanvas/MonitorPanel/SubViewportContainer/CameraViewport/room-cam-4"
@onready var object_cam5_panel: Sprite2D = $"MonitorCanvas/MonitorPanel/SubViewportContainer/CameraViewport/room-cam-5"
#@onready var object_cam6_panel: Sprite2D = $"MonitorCanvas/MonitorPanel/SubViewportContainer/CameraViewport/room-cam-6"

# map camera button $MonitorCanvas/
@onready var btn_cam1: TextureButton = $MonitorCanvas/MonitorPanel/MapRoom/BtnCam1
@onready var btn_cam2: TextureButton = $MonitorCanvas/MonitorPanel/MapRoom/BtnCam2
@onready var btn_cam3: TextureButton = $MonitorCanvas/MonitorPanel/MapRoom/BtnCam3
@onready var btn_cam4: TextureButton = $MonitorCanvas/MonitorPanel/MapRoom/BtnCam4
@onready var btn_cam5: TextureButton = $MonitorCanvas/MonitorPanel/MapRoom/BtnCam5
#@onready var btn_cam6: TextureButton = $MonitorCanvas/MonitorPanel/MapRoom/BtnCam6

@onready var voltar_sprite : Sprite2D = $CanvasGroup/Voltar_splite

# Audio
@onready var audio_sound_mask : AudioStreamPlayer = $CanvasGroup/TextureButton/sound_mask
@onready var audio_AudioCamera : AudioStreamPlayer2D = $AudioCamera
@onready var anim_camera_monitor = $MonitorCanvas/anim_camera_monitor
@onready var anim_tachyon_jump = $anim_tachyon_jump
@onready var anim_char_jump = $anim_char_jump

var sound_open_camera  = preload("res://sounds/camera/camera_close.wav")
var sound_switch_camera  = preload("res://sounds/camera/camera_switch.wav")
var sound_close_camera = preload("res://sounds/camera/camera_open.wav")
var sound_fan_camera = preload("res://sounds/camera/fan.wav")
var sound_mask_off = preload("res://sounds/mask/mask_off.wav")
var sound_mask_on = preload("res://sounds/mask/mask_on.wav")
var cooldown_open_monitor : int = 0


func _ready() -> void:
	#	SETTING MONITOR TO FALSE
	Global.monitor_panel = false
	object_monitor_panel.visible = false
	
	# animasi 
	anim_camera_monitor.reset_section()
	anim_tachyon_jump.play("RESET")
	anim_char_jump.play("RESET")
	
	#	TAMPILKAN : CAM1
	Global.camera_room_id = 0 
	voltar_sprite.visible = false
	
func _process(delta: float) -> void:
	
	# Di dalam _process pada Main Script kamu:
	if Global.voltar_state == 2:
		voltar_sprite.visible = true
	if Global.voltar_state <= 1:
		voltar_sprite.visible = false
	
	if Global.tachyon_scurity_visible == true:
		_on_close_monitor()
		anim_tachyon_jump.play("jump_tachyon")
		Global.tachyon_scurity_visible = false
	
	if Global.goldship_jump == true and Global.monitor_panel == true:
		_on_close_monitor()
		anim_char_jump.play("susto_jump")
		Global.goldship_jump == false

	if Input.is_action_just_pressed("buka_monitor"):
		var timer_now = Time.get_ticks_msec()
		if timer_now - cooldown_open_monitor >= 500:
			cooldown_open_monitor = timer_now
					
			# KONDISI 1: TUTUP MONITOR
			if Global.monitor_panel == true and object_monitor_panel.visible == true:
				anim_camera_monitor.play("anim_close_monitor")
				audio_AudioCamera.stream = sound_close_camera
				audio_AudioCamera.play()
				object_monitor_panel.visible = false
				await get_tree().create_timer(0.5).timeout
				
				Global.monitor_panel = false
			
			# KONDISI 2: BUKA MONITOR
			elif Global.monitor_panel == false:
				audio_AudioCamera.stream = sound_open_camera
				audio_AudioCamera.play()
				anim_camera_monitor.play("anim_open_monitor")
				
				await get_tree().create_timer(0.5).timeout  
				object_monitor_panel.visible = true
				Global.monitor_panel = true
				anim_camera_monitor.play("anim_effect_monitor")
				
			print("Cooldown masih aktif! Jangan di-spam!")
		print("Monitor status: " + str(Global.monitor_panel))

	
	
func _on_close_monitor():
	anim_camera_monitor.play("anim_close_monitor")
	audio_AudioCamera.stream = sound_close_camera
	audio_AudioCamera.play()
	object_monitor_panel.visible = false
	await get_tree().create_timer(0.5).timeout
	Global.monitor_panel = false

# Membuat fungsi dengan parameter int dan String
func open_camera(id_camera: int, description: String):
	anim_camera_monitor.play("anim_effect_monitor")
	
	# 1. Matikan semua kamera dulu agar bersih
	audio_AudioCamera.stream = sound_switch_camera
	audio_AudioCamera.play()
	
	object_cam1_panel.visible = false 
	object_cam2_panel.visible = false
	object_cam3_panel.visible = false 
	object_cam4_panel.visible = false
	object_cam5_panel.visible = false
	#object_cam6_panel.visible = false
	
	btn_cam1.disabled = false
	btn_cam2.disabled = false
	btn_cam3.disabled = false
	btn_cam4.disabled = false
	btn_cam5.disabled = false
	#btn_cam6.disabled = false
	
	await get_tree().create_timer(0.5).timeout
	audio_AudioCamera.stream = sound_fan_camera
	audio_AudioCamera.play()

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
	#elif id_camera == 5:
		#Global.camera_room_id = 5
		#object_cam6_panel.visible = true
		
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


func _on_mask_pressed() -> void:
#	Pakai Masker : true
	if Global.is_mask_on == false:
		Global.is_mask_on = true
		object_mask_panel.visible = true
		audio_sound_mask.stream = sound_mask_on
		audio_sound_mask.play()
		print("masker dipake : " + str(Global.is_mask_on))
#	Pakai Masker : false
	elif Global.is_mask_on == true:
		Global.is_mask_on = false
		object_mask_panel.visible = false
		audio_sound_mask.stream = sound_mask_off
		audio_sound_mask.play()
		print("masker dipake: ", Global.is_mask_on)

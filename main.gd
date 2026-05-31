extends Node2D

# 1. PANGGIL NODENYA KE KODE

# Sesuaikan jalur ($...) ini dengan posisi tombol dan labelmu di panel Scene
@onready var MonitorPanel: Panel = $MonitorCanvas/MonitorPanel

@onready var cam1_panel: Sprite2D = $"MonitorCanvas/MonitorPanel/SubViewportContainer/CameraViewport/room-cam-1"
@onready var cam2_panel: Sprite2D = $"MonitorCanvas/MonitorPanel/SubViewportContainer/CameraViewport/room-cam-2"
@onready var cam3_panel: Sprite2D = $"MonitorCanvas/MonitorPanel/SubViewportContainer/CameraViewport/room-cam-3"
@onready var cam4_panel: Sprite2D = $"MonitorCanvas/MonitorPanel/SubViewportContainer/CameraViewport/room-cam-4"
@onready var cam5_panel: Sprite2D = $"MonitorCanvas/MonitorPanel/SubViewportContainer/CameraViewport/room-cam-5"
@onready var mask_panel: Sprite2D = $TextureButton/sound_mask/mask

@onready var btn_cam1: TextureButton = $MonitorCanvas/MonitorPanel/BtnCam1
@onready var btn_cam2: TextureButton = $MonitorCanvas/MonitorPanel/BtnCam2
@onready var btn_cam3: TextureButton = $MonitorCanvas/MonitorPanel/BtnCam3
@onready var btn_cam4: TextureButton = $MonitorCanvas/MonitorPanel/BtnCam4
@onready var btn_cam5: TextureButton = $MonitorCanvas/MonitorPanel/BtnCam5

@onready var sound_mask : AudioStreamPlayer = $TextureButton/sound_mask


@onready var panel_animess: Sprite2D = $animes
@onready var ardianTimer : Timer = $GameTimer
@onready var suryalabel : Label = $suryalabel

@onready var voltar_sprite : Sprite2D = $Voltar_splite

# Audio
@onready var AudioCamera : AudioStreamPlayer2D = $AudioCamera
var sound_camera_open  = preload("res://sounds/camera/camera_close.wav")
var sound_camera_switch  = preload("res://sounds/camera/camera_switch.wav")
var sound_camera_close = preload("res://sounds/camera/camera_open.wav")
var sound_camera_fan = preload("res://sounds/camera/fan.wav")
var sound_mask_off = preload("res://sounds/mask/mask_off.wav")
var sound_mask_on = preload("res://sounds/mask/mask_on.wav")
var monitor : int = 0

# 1. Panggil Node panel "animess" ke dalam kode


func _process(delta: float) -> void:
	
	# Kita cek: jika timer sedang berjalan, ambil nilai sisa waktunya!
	if ardianTimer.time_left > 0:
		var sisa_detik = snappedf(ardianTimer.time_left, 0.1)
		suryalabel.text = "Sisa Waktu: " + str(sisa_detik) + " detik"
	
	# Di dalam _process pada Main Script kamu:
	if Global.voltar_state == 2:
		voltar_sprite.visible = true
	if Global.voltar_state <= 1:
		voltar_sprite.visible = false
	
	if Global.tachyon_scurity_visible == true:
		MonitorPanel.visible = false
		Global.monitor_panel = false
		Global.tachyon_scurity_visible = false

	
	if Input.is_action_just_pressed("buka_monitor"):
		if (Global.monitor_panel == true):
			AudioCamera.stream = sound_camera_close
			AudioCamera.play()
			MonitorPanel.visible = false
			Global.monitor_panel = false

		elif (Global.monitor_panel == false):
			AudioCamera.stream = sound_camera_open
			AudioCamera.play()
			MonitorPanel.visible = true
			Global.monitor_panel = true
			
		print("Monitor status:" + str(Global.monitor_panel))

func _ready() -> void:
	panel_animess.visible = false
	voltar_sprite.visible = false
	ardianTimer.timeout.connect(munculkan_animess)
	open_camera(0, "camera 1")


# 2. Fungsi yang otomatis berjalan setelah 5 detik (Sinyal timeout dari GameTimer)
func _on_game_timer_timeout() -> void:
	print("Sudah lebih dari 5 detik!")
	
	# MEMUNCULKAN PANEL "animess"
	panel_animess.visible = true
	
	# Efek tambahan: kamu bisa menghentikan game atau memutar suara di sini
func munculkan_animess() -> void :
	suryalabel.text = "ada monster di depan mu"
	MonitorPanel.visible = false
	Global.monitor_panel = false
	suryalabel.visible = true
	

# Membuat fungsi dengan parameter int dan String
func open_camera(id_camera: int, description: String):
	# 1. Matikan semua kamera dulu agar bersih
	AudioCamera.stream = sound_camera_switch
	AudioCamera.play()
	
	cam1_panel.visible = false 
	cam2_panel.visible = false
	cam3_panel.visible = false 
	cam4_panel.visible = false
	cam5_panel.visible = false
	
	btn_cam1.disabled = false
	btn_cam2.disabled = false
	btn_cam3.disabled = false
	btn_cam4.disabled = false
	btn_cam5.disabled = false
	
	await get_tree().create_timer(0.5).timeout
	AudioCamera.stream = sound_camera_fan
	AudioCamera.play()

	if id_camera == 0:
		Global.camera_room_id = 0 
		cam1_panel.visible = true
	elif id_camera == 1:
		Global.camera_room_id = 1
		cam2_panel.visible = true
	elif id_camera == 2:
		Global.camera_room_id = 2 
		cam3_panel.visible = true
	elif id_camera == 3:
		Global.camera_room_id = 3 
		cam4_panel.visible = true
	elif id_camera == 4:
		Global.camera_room_id = 4 
		cam5_panel.visible = true
		
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



func _on_btn_reset_t_ime_pressed() -> void:
	print("Tombol Reset Ditekan! Waktu diulang ke 10 menit.")
	panel_animess.visible = false
	ardianTimer.start(10)
	pass # Replace with function body.


func _on_mask_pressed() -> void:
	if Global.is_mask_on == false:
		Global.is_mask_on = true
		mask_panel.visible = true
		sound_mask.stream = sound_mask_on
		sound_mask.play()
		print("masker : " + str(Global.is_mask_on))
		
	elif Global.is_mask_on == true:
		Global.is_mask_on = false
		mask_panel.visible = false
		sound_mask.stream = sound_mask_off
		sound_mask.play()
		print("masker dipake: ", Global.is_mask_on)

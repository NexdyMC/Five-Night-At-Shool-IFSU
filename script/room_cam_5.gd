extends Node2D

# ==========================================
# 1. NODE REFERENCES
# ==========================================
@onready var label  : Label    = $Label
@onready var room_5 : Sprite2D = $room_5

# ==========================================
# 2. KONFIGURASI PANNING KAMERA
# ==========================================
@export var kecepatan_geser : float = 50.0
@export var batas_kiri      : float = -200.0
@export var batas_kanan     : float = 0.0

var arah : int = -1

# ==========================================
# 3. TEKSTUR PER ESTADO
# ==========================================
var room_step_1 = preload("res://textures/room_5/local_5_0.png")
var room_step_2 = preload("res://textures/room_5/local_5_golshi_1_0.png")
var room_step_3 = preload("res://textures/room_5/local_5_golshi_2_0.png")
var room_step_4 = preload("res://textures/room_5/local_5_golshi_3_0.png")
var room_step_5 = preload("res://textures/room_5/local_5_golshi_4_0.png")

var game_over = load("res://sounds/jumpscare/GoldShip_susto.wav")
# ==========================================
# 4. TIMER NODES
# Tambahkan 3 Timer sebagai child node di scene:
#   TimerMaju     — wait_time: 60.0, one_shot: false
#   TimerMundur   — wait_time: 1.0,  one_shot: true
#   TimerTutorial — wait_time: 60.0, one_shot: true
# ==========================================
@onready var timer_maju     : Timer = $TimerMaju
@onready var timer_mundur   : Timer = $TimerMundur
@onready var timer_tutorial : Timer = $TimerTutorial

# ==========================================
# 5. READY
# ==========================================
func _ready() -> void:
	room_5.offset.x = 0
	Global.goldship_estado = 0

	timer_maju.timeout.connect(_on_timer_maju_timeout)
	timer_mundur.timeout.connect(_on_timer_mundur_timeout)
	timer_tutorial.timeout.connect(_on_timer_tutorial_timeout)

	# Night 1 = jam mulai 12 → tunda 1 menit dulu
	if Global.jam_sekarang == 12:
		timer_tutorial.start()
		print("[GoldShip] Night 1 — delay 1 menit sebelum mulai.")
	else:
		timer_maju.start()
		print("[GoldShip] Mulai bergerak.")

# ==========================================
# 6. PROCESS — panning + visual + cek player
# ==========================================
func _process(delta: float) -> void:
	room_5.offset.x += kecepatan_geser * arah * delta
	if room_5.offset.x <= batas_kiri:
		room_5.offset.x = batas_kiri
		arah = 1
	elif room_5.offset.x >= batas_kanan:
		room_5.offset.x = batas_kanan
		arah = -1

	_cek_player_lihat()
	_update_visual()

# ==========================================
# 7. CEK PLAYER LIHAT KAMERA 5
# Jika player buka monitor di camera_room_id 4
# dan estado > 1 → mulai delay mundur 1 detik
# Jika player berpaling → batalkan timer mundur
# ==========================================
func _cek_player_lihat() -> void:
	var player_lihat : bool = Global.monitor_panel and Global.camera_room_id == 4

	if player_lihat and Global.goldship_estado > 1:
		if timer_mundur.is_stopped():
			timer_mundur.start()
			print("[GoldShip] Player lihat cam 5 — delay mundur dimulai.")
	else:
		if not timer_mundur.is_stopped():
			timer_mundur.stop()
			print("[GoldShip] Player berpaling — timer mundur dibatalkan.")

# ==========================================
# 8. CALLBACKS TIMER
# ==========================================
func _on_timer_maju_timeout() -> void:
	Global.goldship_estado += 1
	print("[GoldShip] Maju! Estado: ", Global.goldship_estado)
	
	if Global.goldship_estado >= 5:
		_trigger_game_over() 


func _on_timer_mundur_timeout() -> void:
	if Global.goldship_estado > 1:
		Global.goldship_estado = 1
		print("[GoldShip] Mundur ke estado 1.")

func _on_timer_tutorial_timeout() -> void:
	timer_maju.start()
	print("[GoldShip] Tutorial selesai — Gold Ship mulai bergerak.")

# ==========================================
# 9. GAME OVER
# ==========================================
func _trigger_game_over() -> void: 
	Global.goldship_jump = true
	print("[GoldShip] GAME OVER! = 13")

# ==========================================
# 10. UPDATE VISUAL
# ==========================================
func _update_visual() -> void:
	match Global.goldship_estado:
		0:
			room_5.texture = room_step_1
			label.text = "Gold Ship — Aman (Estado %d)" % Global.goldship_estado
		1:
			room_5.texture = room_step_2
			label.text = "Gold Ship — Mengintip"
		2:
			room_5.texture = room_step_3
			label.text = "Gold Ship — Bersiap"
		3:
			room_5.texture = room_step_4
			label.text = "Gold Ship — siap untuk keluar!"
		4:
			room_5.texture = room_step_5
			label.text = "Gold Ship — KELUAR!"
		_:
			room_5.texture = room_step_1
			label.text = "Gold Ship — Aman"

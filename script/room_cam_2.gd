extends Sprite2D

# --- ONREADY VARIABLES ---
@onready var voltar_sprite_room : Sprite2D = $CanvasGroup/Voltar_splite_room
@onready var room_2 : CanvasGroup = $CanvasGroup
@onready var jumpscare  : AudioStreamPlayer = $jumpscare

# --- EXPORT VARIABLES ---
@export var kecepatan_geser : float = 50.0
@export var batas_kiri : float = 0.0
@export var batas_kanan : float = 240.0

# --- NORMAL VARIABLES ---
var value : int = 0
var waktu_sekarang : float = 0.0
var arah : int = 1

var voltar_jump = load("res://sounds/jumpscare/Vodkajump_susto.wav")

# 2. Status AI (0 = Ngumpet, 1 = Di Kamera/Nyerang, 2 = Selesai/Game Over)
var timer_aksi: float = 0.0

func _ready() -> void:
	voltar_sprite_room.visible = false
	Global.voltar_state = 0
	timer_aksi = randf_range(10.0, 20.0)

func _process(delta: float) -> void:
	# ==========================================
	# 1. LOGIKA PERGERAKAN KAMERA
	# ==========================================
	room_2.position.x += kecepatan_geser * arah * delta

	if room_2.position.x <= -260:
		room_2.position.x = -260
		arah = 1 
	elif room_2.position.x >= 0:
		room_2.position.x = 0
		arah = -1 
		
	# ==========================================
	# 2. LOGIKA AI & JUMPSCARE VODKA / VOLTAR
	# ==========================================
	if timer_aksi > 0:
		timer_aksi -= delta
	else:
		# Jika waktu habis, jalankan aksi berdasarkan statusnya saat ini
		if Global.voltar_state == 0:
			# Fase 0: Dari Ngumpet -> Muncul di Kamera
			Global.voltar_state = 1
			voltar_sprite_room.visible = true
			timer_aksi = randf_range(20.0, 30.0)

		elif Global.voltar_state == 1:
			# Fase 1: Waktu di kamera habis -> Waktunya mengeksekusi serangan
			if Global.is_mask_on == true:
				# Pemain pakai masker, Vodka tertipu dan pergi
				print("Pemain selamat! Vodka pergi.")
				Global.voltar_state = 0
				voltar_sprite_room.visible = false
				timer_aksi = randf_range(10.0, 20.0)
			else:
				# Pemain tidak pakai masker -> JUMPSCARE!
				Global.voltar_state = 2 # Ubah state jadi 2 agar kode berhenti di sini
				voltar_sprite_room.visible = false 
				
				jumpscare.stream = voltar_jump
				jumpscare.play()
				print("[Vodka] GAME OVER")
				
				# Beri timer sangat lama agar aman dan tidak memutar audio ulang
				timer_aksi = 999.0 
				
		elif Global.voltar_state == 2:
			# Fase 2: Game Over. 
			# Kita beri perintah 'pass' agar mesin Godot diam dan tidak melakukan apa-apa.
			# Ini yang mencegah terjadinya looping suara!
			pass

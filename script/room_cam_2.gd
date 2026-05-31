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

# 2. Status AI (0 = Ngumpet, 1 = Di Kamera, 2 = Di Depan)
var timer_aksi: float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	voltar_sprite_room.visible = false
	Global.voltar_state = 0
	voltar_sprite_room.visible = false
	timer_aksi = randf_range(10.0, 20.0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	room_2.position.x += kecepatan_geser * arah * delta

	if room_2.position.x <= -260:
		room_2.position.x = -260
		arah = 1  # Balik ke kanan
	elif room_2.position.x >= 0:
		room_2.position.x = 0
		arah = -1 # Balik ke kiri
		
	# Kurangi timer setiap frame
	if timer_aksi > 0:
		timer_aksi -= delta
	else:
		# Jika waktu habis, jalankan aksi berdasarkan statusnya saat ini
		if Global.voltar_state == 0:
			_muncul_di_kamera()
		elif Global.voltar_state == 1:
			_muncul_di_depan()
		elif Global.voltar_state == 2:
			if Global.is_mask_on == true:
				print("Pemain selamat! Vodka pergi.")
				Global.voltar_state = 0
				voltar_sprite_room.visible = false
				timer_aksi = randf_range(10.0, 20.0)
			else:
				jumpscare.stream = voltar_jump
				jumpscare.play()
				print("[Vodka] GAME OVER")
				pass

	
func _muncul_di_kamera() -> void:
	Global.voltar_state = 1
	voltar_sprite_room.visible = true
	timer_aksi = randf_range(20.0, 30.0)

func _muncul_di_depan() -> void:
	Global.voltar_state = 2
	voltar_sprite_room.visible = false 
	timer_aksi = 10.0

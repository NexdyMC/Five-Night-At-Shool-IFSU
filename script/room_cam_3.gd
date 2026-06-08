extends Sprite2D

# --- ONREADY VARIABLES ---
@onready var room_3 : Sprite2D = $"room_3"
@onready var room_karoke : AudioStreamPlayer = $sound_room_karoke
@onready var TachyonJump  : AudioStreamPlayer = $TachyonJump 
@onready var tachyon_sprite : Sprite2D = $TachyonEye 

# --- Exstabilizar ---
#@onready var bar_biru: Sprite2D = $BarBiru # Sesuaikan dengan node bar biru milikmu
#@onready var btn_estabilizar: TextureButton = $ButtonEstabilizar
#@onready var audio_error: AudioStreamPlayer = $AudioError
#@onready var panel_error: Panel = $PanelError

# --- EXPORT VARIABLES ---
@export var kecepatan_geser : float = 50.0
@export var batas_kiri : float = 0.0
@export var batas_kanan : float = 240.0

# --- NORMAL VARIABLES ---
var value : int = 0
var waktu_sekarang : float = 0.0
var arah : int = 1
var siap_dimainkan : bool = false 

# --- TACHYON VARIABLES ---
var tachyon_muncul : bool = false
var waktu_ditatap : float = 0.0
var timer_muncul : float = 0.0
var waktu_cooldown : float = 20.0



# --- ASSETS / RESOURCES ---
var room_step_1 = load("res://textures/room_3/local_2_teio_1_0.png")
var room_step_2 = load("res://textures/room_3/local_2_teio_2_0.png")
var room_step_3 = load("res://textures/room_3/local_2_teio_saiu_0.png")
var sound_karoke = load("res://sounds/room_karoke.wav")
var agnesjump_2 = load("res://sounds/jumpscare/agnesjump_2.wav")
var total_waktu : float = 0.0

func _ready() -> void:
	tachyon_sprite.visible = false
	
	await get_tree().create_timer(5.0).timeout
	room_3.texture = room_step_1
	room_karoke.stream = sound_karoke
	room_karoke.play()
	
	siap_dimainkan = true 
	
func _process(delta: float) -> void:
	total_waktu += delta
	
	# ==========================================
	# 1. LOGIKA PERGERAKAN KAMERA (PANNING)
	# ==========================================
	room_3.offset.x += kecepatan_geser * arah * delta
	
	if room_3.offset.x <= -200:
		room_3.offset.x = -200
		arah = 1  
	elif room_3.offset.x >= 0:
		room_3.offset.x = 0
		arah = -1 
	
	# ==========================================
	# 2. LOGIKA AUDIO KARAOKE
	# ==========================================
	if siap_dimainkan == true:
		if (Global.camera_room_id == 2) and (Global.monitor_panel == true):
			room_karoke.volume_db = linear_to_db(1.0) 
		else:
			room_karoke.volume_db = linear_to_db(0.0)

	# ==========================================
	# 3. LOGIKA JUMPSCARE TACHYON
	# ==========================================
	if tachyon_muncul == false:
		# Fase Sembunyi: Menghitung delta sampai 20 detik (Cooldown)
		timer_muncul += delta
		if timer_muncul >= waktu_cooldown:
			_munculkan_tachyon()

	elif tachyon_muncul == true:
		if (Global.camera_room_id == 2) and (Global.monitor_panel == true):
			waktu_ditatap += delta
			
			if waktu_ditatap >= 1.0:
				_picu_jumpscare()
		else:
			_tachyon_gagal()

# --- FUNGSI AKSI TACHYON ---

func _munculkan_tachyon() -> void:
	tachyon_muncul = true # <-- INI WAJIB ADA
	tachyon_sprite.visible = true
	timer_muncul = 0.0 # Reset waktu cooldown ke 0

func _tachyon_gagal() -> void:
	tachyon_muncul = false # <-- INI WAJIB ADA
	tachyon_sprite.visible = false
	waktu_ditatap = 0.0
	print("tachyon gagal ")

func _picu_jumpscare() -> void:
	tachyon_muncul = false # <-- INI WAJIB ADA (Agar tidak looping/mengulang error)
	Global.tachyon_scurity_visible = true
	tachyon_sprite.visible = true
	TachyonJump.play()
	
	await get_tree().create_timer(1.0).timeout
	Global.tachyon_scurity_visible = false
	tachyon_sprite.visible = false
	waktu_ditatap = 0.0 
	
	
	print("JUMPSCARE: Agnes Tachyon Menangkapmu!")

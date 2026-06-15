extends Sprite2D

# --- ONREADY VARIABLES ---
@onready var room_3 : CanvasGroup = $CanvasGroup
@onready var room_texture_3 : Sprite2D = $CanvasGroup/room_3
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
	room_texture_3.texture = room_step_1
	room_karoke.stream = sound_karoke
	room_karoke.play()
	
	siap_dimainkan = true 
	
func _process(delta: float) -> void:
	total_waktu += delta
	
	# ==========================================
	# 1. LOGIKA PERGERAKAN KAMERA (PANNING)
	# ==========================================
	Global.camera_position_bolak_balik(room_3, 50.0, delta, -260, 0)

	# ==========================================
	# 2. LOGIKA AUDIO KARAOKE
	# ==========================================
	if siap_dimainkan == true:
		if (Global.camera_room_id == 2) and (Global.monitor_panel == true):
			room_karoke.volume_db = linear_to_db(0.3) 
		else:
			room_karoke.volume_db = linear_to_db(0.0)

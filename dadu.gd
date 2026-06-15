extends Node2D

# ==========================================
# NODE REFERENCES — Sprite2D + Label tiap karakter
# ==========================================
@onready var suzuka_sprite  : Sprite2D = $Suzuka
@onready var suzuka_label   : Label    = $SuzukaLabel

@onready var specialw_sprite : Sprite2D = $SpecialWeek
@onready var specialw_label  : Label    = $SpecialWeekLabel

@onready var voltar_sprite  : Sprite2D = $Voltar
@onready var voltar_label   : Label    = $VoltarLabel
@onready var timer_dadu : Timer = $TimerDadu


enum Karakter { TIDAK_ADA, SUZUKA, SPECIAL_WEEK, VOLTAR }

var sisi_dadu : Array = [
	Karakter.TIDAK_ADA,
	Karakter.TIDAK_ADA,
	Karakter.TIDAK_ADA,
	Karakter.SUZUKA,
	Karakter.SPECIAL_WEEK,
	Karakter.VOLTAR,
	Karakter.VOLTAR
]
var block_time : Array = [7.0, 5.0, 3.0]

# ==========================================
# STATE KARAKTER
# ==========================================
var suzuka_maju    : int = 0
var specialw_maju  : int = 0
var voltar_maju    : int = 0

# suzuka   0 , 2 room_1 > room_2 > room_4 > room_you
# special  0 , 2 room_3 > room_2 > room_you

var room_1 : int = 0
var room_2 : int = 0
var room_3 : int = 0

# ==========================================
# READY
# ==========================================
func _ready() -> void:
	_sembunyikan_semua()
	timer_dadu.timeout.connect(_on_lempar_dadu)
	_set_delay_acak()

# ==========================================
# LEMPAR DADU
# ==========================================
func _on_lempar_dadu() -> void:
	var hasil : Karakter = sisi_dadu[randi() % sisi_dadu.size()]
	print("[Dadu] Hasil: ", Karakter.keys()[hasil])
	
	if suzuka_maju >= 4:
		suzuka_maju = 0 
		suzuka_sprite.visible  = false
	if specialw_maju >= 4:
		specialw_maju = 0
		specialw_sprite.visible = false
	if voltar_maju >= 4:
		voltar_maju = 0
		voltar_sprite.visible  = false
		
	match hasil:
		Karakter.SUZUKA:
			suzuka_maju += 1
			suzuka_sprite.visible = true
			suzuka_label.text = "Suzuka muncul! " + str(suzuka_maju)

		Karakter.SPECIAL_WEEK:
			specialw_maju += 1
			specialw_sprite.visible = true
			specialw_label.text = "Special Week muncul! " + str(specialw_maju)

		Karakter.VOLTAR:
			voltar_maju += 1
			voltar_sprite.visible = true
			voltar_label.text = "Voltar muncul! "  + str(voltar_maju)

		Karakter.TIDAK_ADA:
			pass

	# Lempar lagi dengan delay baru
	_set_delay_acak()

# ==========================================
# DELAY ACAK 10 / 20 / 30 DETIK
# ==========================================
func _set_delay_acak() -> void:
	timer_dadu.wait_time = block_time[randi() % block_time.size()]
	timer_dadu.start()
	print("[Dadu] Lemparan berikutnya dalam ", timer_dadu.wait_time, " detik.")

# ==========================================
# SEMBUNYIKAN SEMUA DI AWAL
# ==========================================
func _sembunyikan_semua() -> void:
	suzuka_sprite.visible  = false
	specialw_sprite.visible = false
	voltar_sprite.visible  = false
	
	suzuka_label.text  = "not Suzuka " 
	specialw_label.text = "not Special Week" 
	voltar_label.text  = "not Voltar"

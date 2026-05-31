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

# ==========================================
# DADU — daftar karakter
# Tambah atau kurangi nama di sini untuk expand
# ==========================================
enum Karakter { TIDAK_ADA, SUZUKA, SPECIAL_WEEK, VOLTAR }

# Sisi-sisi dadu — bisa duplikat untuk atur peluang
# Contoh: TIDAK_ADA muncul 3x = lebih sering tidak ada yang maju
var sisi_dadu : Array = [
	Karakter.TIDAK_ADA,
	Karakter.TIDAK_ADA,
	Karakter.TIDAK_ADA,
	Karakter.SUZUKA,
	Karakter.SPECIAL_WEEK,
	Karakter.VOLTAR,
]

# ==========================================
# STATE KARAKTER
# ==========================================
var suzuka_maju    : int = 0
var specialw_maju  : int = 0
var voltar_maju    : int = 0

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

	match hasil:
		Karakter.SUZUKA:
			if suzuka_maju == 0:
				suzuka_maju += 1
				suzuka_sprite.visible = true
				suzuka_label.text = "Suzuka muncul!" + str(suzuka_maju)
				print("[Dadu] Suzuka maju ke depan!")

		Karakter.SPECIAL_WEEK:
			if specialw_maju == 0:
				specialw_maju += 1
				specialw_sprite.visible = true
				specialw_label.text = "Special Week muncul!" + str(specialw_maju)
				print("[Dadu] Special Week maju ke depan!")

		Karakter.VOLTAR:
			if  voltar_maju == 0:
				voltar_maju += 1
				voltar_sprite.visible = true
				voltar_label.text = "Voltar muncul!"  + str(voltar_maju)
				print("[Dadu] Voltar maju ke depan!")

		Karakter.TIDAK_ADA:
			print("[Dadu] Tidak ada yang muncul kali ini.")

	# Lempar lagi dengan delay baru
	_set_delay_acak()

# ==========================================
# DELAY ACAK 10 / 20 / 30 DETIK
# ==========================================
func _set_delay_acak() -> void:
	timer_dadu.wait_time = [10.0, 20.0, 30.0].pick_random()
	timer_dadu.start()
	print("[Dadu] Lemparan berikutnya dalam ", timer_dadu.wait_time, " detik.")

# ==========================================
# USIR KARAKTER (dipanggil dari luar)
# misalnya saat masker dipakai atau lentera menyala
# ==========================================
func usir_suzuka() -> void:
	suzuka_maju = 0
	suzuka_sprite.visible = false
	suzuka_label.text = ""

func usir_specialw() -> void:
	specialw_maju = 0
	specialw_sprite.visible = false
	specialw_label.text = ""

func usir_voltar() -> void:
	voltar_maju = 0
	voltar_sprite.visible = false
	voltar_label.text = ""

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

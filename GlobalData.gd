extends Node

# Variabel yang bisa diakses dari scene mana pun
var camera_room_id : int = 0
var monitor_panel : bool = true
var is_camera_open : bool = false
var is_mask_on : bool = true
var sisa_baterai: int = 100
var jam_sekarang: int = 12
var light : int = 0
var stability : float = 100.0
var night : int = 1

#malam 1 - 6
# ==========================================
# LEVEL KARAKTER (NIGHT 1 DEFAULT)
# ==========================================
var SuzukaS_level : int = 1
var SpecialW_level : int = 1
var VodkaC_level : int = 1
var Cafe_level : int = 1
var GoldS_level : int = 1

var goldship_estado : int = 0	# 0 - 6 
var voltar_state : int = 0  	# 0 - 3
var suzuka_state : int = 0  	# 0 - 3 

var goldship_jump : bool = false
var voltar_jump : bool = false
var suzuka_jump : bool = false

var voltar_scurity_visible : bool = true
var suzuka_scurity_visible : bool = true
var special_scurity_visible : bool = true
var tachyon_scurity_visible : bool = false

var sound_jumpscare : String = "none"
# 0 = idle/aman
# 1 = mulai aktif (bisa naik/turun)
# 2 = mengintip
# 3 = bersiap keluar
# 4 = KELUAR — trigger serangan
# 5 = sedang countdown serangan
 
# ==========================================
# SIGNAL GLOBAL (untuk game over, jumpscare, dll)
# ==========================================
signal game_over(karakter_id: int)
signal jumpscare_triggered(karakter_id: int)

# ==========================================
# FUNCTION GLOBAL
# ==========================================

# Fungsi ini sekarang menerima objek apa saja (bisa CanvasGroup, Sprite2D, dll)
# Kita juga butuh kamus (Dictionary) atau referensi status agar 'arah' tidak reset.
# Cara termudah adalah meminta objek itu sendiri yang menyimpan variabel arahnya.

func camera_position_bolak_balik(objek: Node2D, kecepatan: float, delta: float, batas_kiri: float, batas_kanan: float) -> void:
	if not objek.has_meta("arah"):
		objek.set_meta("arah", 1)
	
	var arah_sekarang = objek.get_meta("arah")
	objek.position.x += kecepatan * arah_sekarang * delta
	
	if objek.position.x <= batas_kiri:
		objek.position.x = batas_kiri
		objek.set_meta("arah", 1)
	elif objek.position.x >= batas_kanan:
		objek.position.x = batas_kanan
		objek.set_meta("arah", -1)

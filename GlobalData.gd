extends Node

# Variabel yang bisa diakses dari scene mana pun
var camera_room_id : int = 0
var monitor_panel : bool = true
var is_camera_open : bool = false
var is_mask_on : bool = true
var sisa_baterai: int = 100
var jam_sekarang: int = 12
var light : int = 0
var stability : int = 100.0
var night : int = 1

# ==========================================
# LEVEL KARAKTER (NIGHT 1 DEFAULT)
# ==========================================
var SuzukaS_level : int = 1
var SpecialW_level : int = 1
var VodkaC_level : int = 1
var Cafe_level : int = 1
var GoldS_level : int = 1

var goldship_estado : int = 0
var voltar_state : int = 0 

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
#func on_camera(panel_camera: Panel):
	#panel_camera.visible = true
	#monitor_panel == true
	#
#func off_camera(panel_camera: Panel):
	#panel_camera.visible = false
	#monitor_panel == false	
	
#if (Global.monitor_panel == true):
	#AudioCamera.stream = sound_camera_close
	#AudioCamera.play()
	#MonitorPanel.visible = false
	#Global.monitor_panel = false
#
#elif (Global.monitor_panel == false):
	#AudioCamera.stream = sound_camera_open
	#AudioCamera.play()
	#MonitorPanel.visible = true
	#Global.monitor_panel = true

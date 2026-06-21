extends CanvasLayer

# Arahkan ke Node Label milikmu
@onready var label_debug : Label = $LabelDebug

func _ready() -> void:
	 #Menu F3 selalu disembunyikan saat game baru mulai
	#visible = false
	pass

# ==========================================
# 1. DETEKSI TOMBOL HARDCODE (TANPA INPUT MAP)
# ==========================================
func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and not event.echo:
		if event.keycode == KEY_F3:
			visible = not visible # Munculkan / Hilangkan


func _process(_delta: float) -> void:
	# ==========================================
	# 2. LOGIKA UPDATE TEKS (JIKA SEDANG DIBUKA)
	# ==========================================
	if visible == true:
		_update_layar_debug()


func _update_layar_debug() -> void:
	# Mengambil data internal sistem
	var fps = Engine.get_frames_per_second()
	
	# Mengambil data memori komputer (dibagi 1024 dua kali agar menjadi MegaByte)
	var memori_mb = OS.get_static_memory_usage() / 1024 / 1024
	
	# --- MENYUSUN TEKS ALIGNMENT KIRI ALA MINECRAFT ---
	var teks = "=== DEBUG F3 ===\n"
	teks += "FPS: " + str(fps) + "\n"
	teks += "Memory: " + str(memori_mb) + " MB\n"
		
	teks += "--------------- [Lobby] --------------- \n"
	teks += "Monitor : " + str(Global.monitor_panel) + "\n"
	teks += "Camera : " + str(Global.is_camera_open) + "\n"
	teks += "Mask : " + str(Global.is_mask_on) + "\n"
	teks += "Kamera ID Aktif: " + str(Global.camera_room_id) + "\n"
	teks += "Stability: " + str(Global.stability) + "\n"
	teks += "Night: " + str(Global.level_night) + "\n"
	
	teks += "--------------- [Entity] --------------- \n"
	teks += "State Voltar: " + str(Global.voltar_state) + "\n"
	teks += "State Gold: " + str(Global.ship_state) + "\n"
	teks += "State Suzuka: " + str(Global.suzuka_state) + "\n"
	teks += "Voltar : " + str(Global.voltar_scurity_visible) + "\n"
	teks += "Suzuka : " + str(Global.suzuka_scurity_visible) + "\n"
	teks += "SpecialW : " + str(Global.special_scurity_visible) + "\n"
	teks += "tachyon : " + str(Global.tachyon_scurity_visible) + "\n"

	teks += "--------------- [Sound] --------------- \n"
	#teks += "Jumpscare : " + str(Global.sound_jumpscare) + str(Global.jumpscare_triggered) +"\n"
	#teks += "Monitor : " + str(Global.jumpscare_triggered) + "\n"
	# Masukkan teks ke Label
	label_debug.text = teks

extends Node2D

var time_remaining: float = 10.0 
var is_frozen: bool = false       
var is_character_gone: bool = false

# Dua variabel baru untuk melacak status mouse
var is_mouse_inside: bool = false
var is_right_click_held: bool = false

@onready var player = $Player
@onready var time_label = $Time
@onready var player_area = $Player/Area2D 

func _ready():
	# Gunakan sinyal entered dan exited untuk melacak posisi kursor
	player_area.mouse_entered.connect(_on_player_mouse_entered)
	player_area.mouse_exited.connect(_on_player_mouse_exited)
	
	time_label.mouse_filter = Control.MOUSE_FILTER_IGNORE

func _process(delta: float):
	if is_character_gone:
		return 

	if not is_frozen:
		if time_remaining > 0:
			time_remaining -= delta
			time_label.text = "Sisa Waktu: " + str(snapped(time_remaining, 0.1)) + " s"
		else:
			karakter_hilang()
	else:
		time_label.text = "FREEZE: " + str(snapped(time_remaining, 0.1)) + " s (Ditahan)"

# --- FUNGSI UPDATE STATUS ---
# Fungsi ini dipanggil setiap kali ada perubahan posisi kursor atau klik
func cek_status_freeze():
	# Jika kursor di dalam area DAN klik kanan ditahan = FREEZE
	if is_mouse_inside and is_right_click_held:
		if not is_frozen: # Cegah print berulang-ulang
			is_frozen = true
			print("Waktu DI-FREEZE!")
			
	# Jika salah satu syarat tidak terpenuhi = LANJUTKAN
	else:
		if is_frozen:
			is_frozen = false
			print("Waktu DILANJUTKAN!")

# --- PELACAK POSISI KURSOR ---
func _on_player_mouse_entered():
	is_mouse_inside = true
	cek_status_freeze() # Cek apakah saat masuk, klik kanan kebetulan sedang ditahan

func _on_player_mouse_exited():
	is_mouse_inside = false
	cek_status_freeze() # Begitu keluar, otomatis syarat freeze batal

# --- PELACAK KLIK GLOBAL ---
func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT:
		# event.pressed akan true jika ditahan, false jika dilepas
		is_right_click_held = event.pressed 
		cek_status_freeze() # Cek status setiap kali mouse diklik/dilepas

func karakter_hilang():
	is_character_gone = true
	time_label.text = "Karakter Hilang!"
	
	if is_instance_valid(player):
		player.queue_free()

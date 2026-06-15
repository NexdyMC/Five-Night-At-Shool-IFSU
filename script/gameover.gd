extends Node2D

@onready var black : Sprite2D = $BackgroundBlack
@onready var gameover : Sprite2D = $Gameover
@onready var red : Sprite2D = $BackgroundRed

# Ubah menjadi float agar bisa dihitung halus oleh delta
var opacity_merah : float = 100.0 

# Kecepatan memudar (50 artinya butuh sekitar 2 detik untuk hilang dari 100 ke 0)
@export var kecepatan_pudar : float = 50.0 

func _ready() -> void:
	black.visible = true
	gameover.visible = true
	red.visible = true
	
	# Atur layar merah agar solid 100% saat pertama kali muncul
	atur_opacity_node(red, int(opacity_merah))


func _process(delta: float) -> void:
	# ==========================================
	# LOGIKA TRANSISI MEMUDAR (FADE OUT)
	# ==========================================
	
	# Selama opacity masih lebih dari 0, kurangi terus angkanya
	if opacity_merah > 0:
		opacity_merah -= kecepatan_pudar * delta
		atur_opacity_node(red, int(opacity_merah))
		
	elif opacity_merah <= 0 and red.visible == true:
		red.visible = false
		print("Efek transisi Game Over selesai!")
		get_tree().change_scene_to_file("res://main.tscn")
		
	


# --- FUNGSI KHUSUS OPACITY UNTUK TARGET NODE ---
func atur_opacity_node(target_node: Sprite2D, nilai_persen: int) -> void:
	var nilai_aman = clamp(nilai_persen, 0, 100)
	var nilai_alpha = nilai_aman / 100.0
	target_node.modulate.a = nilai_alpha

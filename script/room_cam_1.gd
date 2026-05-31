extends Sprite2D

# --- ONREADY VARIABLES ---
@onready var room_1 : Sprite2D = $"room_1"

# --- EXPORT VARIABLES ---
@export var kecepatan_geser : float = 50.0
@export var batas_kiri : float = 0.0
@export var batas_kanan : float = 240.0

# --- NORMAL VARIABLES ---
var value : int = 0
var waktu_sekarang : float = 0.0
var arah : int = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	room_1.offset.x += kecepatan_geser * arah * delta

	if room_1.offset.x <= -200:
		room_1.offset.x = -200
		arah = 1  # Balik ke kanan
	elif room_1.offset.x >= 0:
		room_1.offset.x = 0
		arah = -1 # Balik ke kiri

extends Sprite2D

# --- ONREADY VARIABLES ---
@onready var room_1 : CanvasGroup = $"CanvasGroup"

# --- EXPORT VARIABLES ---
#@export var batas_kiri : float = 0.0
#@export var batas_kanan : float = 240.0

# --- NORMAL VARIABLES ---
var value : int = 0
var waktu_sekarang : float = 0.0
var arah : int = 1

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	Global.camera_position_bolak_balik(room_1, 50.0, delta, -200, 0)

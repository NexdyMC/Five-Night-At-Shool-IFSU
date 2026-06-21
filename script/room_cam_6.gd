extends Sprite2D

# --- ONREADY VARIABLES ---
@onready var room_4 : CanvasGroup = $CanvasGroup

@onready var Raka_step_1 : TextureRect = $CanvasGroup/Raka_1

# --- EXPORT VARIABLES ---
@export var kecepatan_geser : float = 50.0
@export var batas_kiri : float = 0.0
@export var batas_kanan : float = 240.0


func _ready() -> void:
	Raka_step_1.visible = false

func _process(delta: float) -> void:
	Global.camera_position_bolak_balik(room_4, 50.0, delta, -200, -0)
	
	if Global.suzuka_state == 1:
		Raka_step_1.visible = true
	else:
		Raka_step_1.visible = false

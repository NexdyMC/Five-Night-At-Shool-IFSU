extends Sprite2D

# --- ONREADY VARIABLES ---
@onready var room_4 : CanvasGroup = $CanvasGroup

@onready var Momoi_step_4 : Sprite2D = $CanvasGroup/Momoi_4
@onready var Momoi_step_5 : Sprite2D = $CanvasGroup/Momoi_5

# --- EXPORT VARIABLES ---
@export var kecepatan_geser : float = 50.0
@export var batas_kiri : float = 0.0
@export var batas_kanan : float = 240.0


func _ready() -> void:
	Momoi_step_4.visible = false
	Momoi_step_5.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	Global.camera_position_bolak_balik(room_4, 50.0, delta, -200, -0)
	
	if Global.suzuka_state == 4:
		Momoi_step_4.visible = true
		Momoi_step_5.visible = false
	elif Global.suzuka_state == 5:
		Momoi_step_4.visible = false
		Momoi_step_5.visible = true
	else:
		Momoi_step_4.visible = false
		Momoi_step_5.visible = false

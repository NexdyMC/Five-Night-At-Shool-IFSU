extends Sprite2D

#region variabel
@onready var room_1 : CanvasGroup = $"CanvasGroup"
@onready var Midori_step_1 : Sprite2D = $CanvasGroup/Midori_1
@onready var Midori_step_2 : Sprite2D = $CanvasGroup/Midori_2

@export var batas_kiri : float = 0.0
@export var batas_kanan : float = 240.0

var value : int = 0
var waktu_sekarang : float = 0.0
var arah : int = 1
#endregion

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Global.voltar_state == 1:
		Midori_step_1.visible = true
		Midori_step_2.visible = false
	elif Global.voltar_state == 2:
		Midori_step_1.visible = false
		Midori_step_2.visible = true
	else:
		Midori_step_1.visible = false
		Midori_step_2.visible = false


	Global.camera_position_bolak_balik(room_1, 50.0, delta, batas_kiri, batas_kanan)

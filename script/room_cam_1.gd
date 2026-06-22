extends Control

#region variabel
@onready var room_1 : CanvasGroup = $"CanvasGroup"
@onready var aldian_step_1 : TextureRect = $CanvasGroup/Aldian1
@onready var aldian_step_2 : TextureRect = $CanvasGroup/Aldian2

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
		aldian_step_1.visible = true
		aldian_step_2.visible = false
	elif Global.voltar_state == 2:
		aldian_step_1.visible = false
		aldian_step_2.visible = true
	else:
		aldian_step_1.visible = false
		aldian_step_2.visible = false


	Global.camera_position_bolak_balik(room_1, 50.0, delta, batas_kiri, batas_kanan)

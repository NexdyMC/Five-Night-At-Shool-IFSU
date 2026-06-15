extends Sprite2D

@onready var room_1 : CanvasGroup = $"CanvasGroup"
@onready var object_1 : Sprite2D = $CanvasGroup/room_4

@onready var Midori_step_2 : Sprite2D = $CanvasGroup/Midori_3
@onready var Midori_step_3 : Sprite2D = $CanvasGroup/Midori_4
@onready var Momoi_step_3 : Sprite2D = $CanvasGroup/Momoi_3
@onready var Momoi_step_4 : Sprite2D = $CanvasGroup/Momoi_4

var value : int = 0
var waktu_sekarang : float = 0.0
var arah : int = 1

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	Global.camera_position_bolak_balik(room_1, 50.0, delta, -200, 0)
	
	if Global.voltar_state == 3:
		Midori_step_2.visible = true
		Midori_step_3.visible = false
	elif Global.voltar_state == 4: 
		Midori_step_2.visible = false
		Midori_step_3.visible = true
	else:
		Midori_step_2.visible = false
		Midori_step_3.visible = false
	
	if Global.suzuka_state == 2:
		Momoi_step_3.visible = true
		Momoi_step_4.visible = false
	elif Global.suzuka_state == 3:  
		Momoi_step_3.visible = false
		Momoi_step_4.visible = true
	else:
		Momoi_step_3.visible = false
		Momoi_step_4.visible = false

extends Control

@onready var room_1 : CanvasGroup = $"CanvasGroup"
#@onready var object_1 : Sprite2D = $CanvasGroup/room_4

@onready var raka_step_2  : TextureRect = $CanvasGroup/Raka3
@onready var raka_step_3  : TextureRect = $CanvasGroup/Raka4
@onready var aldian_step_3 : TextureRect = $CanvasGroup/Aldian3
@onready var aldian_step_4 : TextureRect = $CanvasGroup/Aldian4

var value : int = 0
var waktu_sekarang : float = 0.0
var arah : int = 1

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	Global.camera_position_bolak_balik(room_1, 50.0, delta, -200, 0)
	
	if Global.voltar_state == 3:
		raka_step_2.visible = true
		raka_step_3.visible = false
	elif Global.voltar_state == 4: 
		raka_step_2.visible = false
		raka_step_3.visible = true
	else:
		raka_step_2.visible = false
		raka_step_3.visible = false
	
	if Global.suzuka_state == 2:
		aldian_step_3.visible = true
		aldian_step_4.visible = false
	elif Global.suzuka_state == 3:  
		aldian_step_3.visible = false
		aldian_step_4.visible = true
	else:
		aldian_step_3.visible = false
		aldian_step_4.visible = false

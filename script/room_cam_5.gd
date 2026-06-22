extends Control

#region Variabel and Node

@onready var room_5 : CanvasGroup = $CanvasGroup
@onready var room_5_0 : TextureRect = $CanvasGroup/TextureRect

var room_step_0 = preload("res://textures/room_5/local_5_0.png")
var room_step_1 = preload("res://textures/room_5/local_5_golshi_1_0.png")
var room_step_2 = preload("res://textures/room_5/local_5_golshi_2_0.png")
var room_step_3 = preload("res://textures/room_5/local_5_golshi_3_0.png")
var room_step_4 = preload("res://textures/room_5/local_5_golshi_4_0.png")



#endregion

func _ready() -> void:
	Global.ship_state = 0

func _process(delta: float) -> void:
	Global.camera_position_bolak_balik(room_5, 50.0, delta, -200, 0)
	
	if Global.ship_state == 1:
			room_5_0.texture = room_step_1
	elif Global.ship_state == 2:
			room_5_0.texture = room_step_2
	elif Global.ship_state == 3:
			room_5_0.texture = room_step_3
	elif Global.ship_state == 4:
			room_5_0.texture = room_step_4
	else:
		room_5_0.texture = room_step_0
	
	if Global.monitor_panel == true and Global.camera_room_id == 4 and (Global.ship_state == 2 or Global.ship_state == 3):
		Global.ship_state = 1
		print("gold ship mundur")
	elif Global.ship_state == 4:
		Global.ship_state = 4

#region Function

#endregion

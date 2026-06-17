extends Control
@onready var Btn_back : TextureButton = $BtnBack
@onready var btn_tim1 : TextureRect = $VBoxContainer/Tim1
@onready var btn_tim2 : TextureRect = $VBoxContainer/Tim2
@onready var btn_tim3 : TextureRect = $VBoxContainer/Tim3
@onready var btn_tim4 : TextureRect = $VBoxContainer/Tim4
@onready var btn_tim5 : TextureRect = $VBoxContainer/Tim5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



#region function
func _on_btn_back_pressed() -> void:
	get_tree().change_scene_to_file("res://screen/start_screen.tscn")


func _btn_hover(btn_hover ):
	btn_hover.modulate = Color.from_string("aaaaaaaa", Color.WHITE)
func _btn_normal(btn_normal):
	btn_normal.modulate = Color.from_string("ffffffff", Color.WHITE)

# Btn Hover back
func _on_btn_back_mouse_entered() -> void:
	_btn_hover(Btn_back)
func _on_btn_back_mouse_exited() -> void:
	_btn_normal(Btn_back)

# btn Hover Tim 1
func _on_tim_1_mouse_entered() -> void:
	_btn_hover(btn_tim1)
func _on_tim_1_mouse_exited() -> void:
	_btn_normal(btn_tim1)

# Btn Hover Tim 2
func _on_tim_2_mouse_entered() -> void:
	_btn_hover(btn_tim2)
func _on_tim_2_mouse_exited() -> void:
	_btn_normal(btn_tim2)

# Btn Hover Tim 3
func _on_tim_3_mouse_entered() -> void:
	_btn_hover(btn_tim3)
func _on_tim_3_mouse_exited() -> void:
	_btn_normal(btn_tim3)

# Btn Hover Tim 4
func _on_tim_4_mouse_entered() -> void:
	_btn_hover(btn_tim4)
func _on_tim_4_mouse_exited() -> void:
	_btn_normal(btn_tim4)

# Btn Hover Tim 5	
func _on_tim_5_mouse_entered() -> void:
	_btn_hover(btn_tim5)
func _on_tim_5_mouse_exited() -> void:
	_btn_normal(btn_tim5)

#endregion

extends Control

# Menghubungkan node Tekstur ke dalam script
@onready var tekstur_horor = $Panel/Night
@onready var btn_new_game = $Panel/BtnNewGame
@onready var btn_continue = $Panel/BtnContinue
@onready var btn_exit = $Panel/BtnExit
@onready var btn_credit = $PanelInfo/BtnCredit

func _ready():
	tekstur_horor.visible = false



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#region Function Button

func _on_btn_new_game_pressed() -> void:
	get_tree().change_scene_to_file("res://main.tscn")
func _on_btn_continue_pressed() -> void:
	get_tree().change_scene_to_file("res://main.tscn")
func _on_btn_exit_pressed() -> void:
	get_tree().quit()
func _on_btn_credit_pressed() -> void:
	get_tree().change_scene_to_file("res://screen/credit_screen.tscn")

func _btn_hover(btn_hover : TextureButton):
	btn_hover.modulate = Color.from_string("aaaaaaaa", Color.WHITE)
func _btn_normal(btn_normal : TextureButton):
	btn_normal.modulate = Color.from_string("ffffffff", Color.WHITE)
	
# Btn New Game Hover
func _on_btn_new_game_mouse_entered() -> void:
	_btn_hover(btn_new_game)
func _on_btn_new_game_mouse_exited() -> void:
	_btn_normal(btn_new_game)

# Btn Continue Hover
func _on_btn_continue_mouse_entered() -> void:
	tekstur_horor.visible = true
	_btn_hover(btn_continue)
func _on_btn_continue_mouse_exited() -> void:
	tekstur_horor.visible = false
	_btn_normal(btn_continue)

# Btn Exit Hover
func _on_btn_exit_mouse_entered() -> void:
	_btn_hover(btn_exit)
func _on_btn_exit_mouse_exited() -> void:
	_btn_normal(btn_exit)

#Btn Credit Hover
func _on_btn_credit_mouse_entered() -> void:
	_btn_hover(btn_credit)
func _on_btn_credit_mouse_exited() -> void:
	_btn_normal(btn_credit)
#endregion

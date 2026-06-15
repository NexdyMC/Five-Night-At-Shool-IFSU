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
	get_tree().change_scene_to_file("res://screen/creadit.tscn")

# Btn New Game Hover
func _on_btn_new_game_mouse_entered() -> void:
	btn_new_game.modulate = Color.from_string("cccccccc", Color.WHITE)
func _on_btn_new_game_mouse_exited() -> void:
	btn_new_game.modulate = Color.from_string("ffffffff", Color.WHITE)

# Btn Continue Hover
func _on_btn_continue_mouse_entered() -> void:
	tekstur_horor.visible = true
	btn_continue.modulate = Color.from_string("cccccccc", Color.WHITE)
func _on_btn_continue_mouse_exited() -> void:
	tekstur_horor.visible = false
	btn_continue.modulate = Color.from_string("ffffffff", Color.WHITE)

# Btn Exit Hover
func _on_btn_exit_mouse_entered() -> void:
	btn_exit.modulate = Color.from_string("cccccccc", Color.WHITE)
func _on_btn_exit_mouse_exited() -> void:
	btn_exit.modulate = Color.from_string("ffffffff", Color.WHITE)

#Btn Credit Hover
func _on_btn_credit_mouse_entered() -> void:
	btn_credit.modulate = Color.from_string("cccccccc", Color.WHITE)
func _on_btn_credit_mouse_exited() -> void:
	btn_credit.modulate = Color.from_string("ffffffff", Color.WHITE)
#endregion

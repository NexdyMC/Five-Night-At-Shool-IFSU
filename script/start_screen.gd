extends Control

# Menghubungkan node Tekstur ke dalam script
@onready var tekstur_horor = $Night
@onready var btn_new_game = $BtnNewGame
@onready var btn_continue = $BtnContinue

func _ready():
	tekstur_horor.visible = false



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_btn_new_game_pressed() -> void:
	pass # Replace with function body.


func _on_btn_continue_pressed() -> void:
	pass # Replace with function body.


func _on_btn_exit_pressed() -> void:
	pass # Replace with function body.


func _on_btn_credit_pressed() -> void:
	pass # Replace with function body.

# Mouse Hover
func _on_btn_new_game_mouse_entered() -> void:
	pass
	
func _on_btn_new_game_mouse_exited() -> void:
	pass


func _on_btn_continue_mouse_entered() -> void:
	tekstur_horor.visible = true
	#btn_continue.modulate.a = 180


func _on_btn_continue_mouse_exited() -> void:
	tekstur_horor.visible = false
	#btn_continue.modulate.a = 255

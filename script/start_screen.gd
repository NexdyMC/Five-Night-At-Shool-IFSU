extends Control

# Panel Menu
@onready var level_night = $PanelMenu/BtnContinue/LevelNight
@onready var btn_new_game = $PanelMenu/BtnNewGame
@onready var btn_continue = $PanelMenu/BtnContinue
@onready var btn_exit   = $PanelMenu/BtnExit
@onready var btn_credit = $PanelInfo/BtnCredit
@onready var btn_fullscreen_off = $PanelSetting/BtnFullscreenOff
@onready var btn_fullscreen_on = $PanelSetting/BtnFullscreenOn
func _ready():
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	DisplayServer.window_set_size(Vector2i(1200, 720))
	_center_window() 

	btn_fullscreen_off.visible = false  # Diubah ke false karena tombol "Off" sudah ditekan
	btn_fullscreen_on.visible = true    # Diubah ke true agar tombol "On" muncul lagi

	level_night.visible = false 
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#region Function Button

func _on_btn_new_game_pressed() -> void:
	get_tree().change_scene_to_file("res://screen/loading_screen.tscn")
func _on_btn_continue_pressed() -> void:
	get_tree().change_scene_to_file("res://main.tscn")
	Global.level_night = 1
	
func _on_btn_exit_pressed() -> void:
	get_tree().quit()
func _on_btn_credit_pressed() -> void:
	get_tree().change_scene_to_file("res://screen/credit_screen.tscn")

# Func Btn Hover and Normal
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
	level_night.visible = true
	_btn_hover(btn_continue)
func _on_btn_continue_mouse_exited() -> void:
	level_night.visible = false
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

func _on_btn_fullscreen_off_pressed() -> void:
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	DisplayServer.window_set_size(Vector2i(1200, 720))
	_center_window() 

	btn_fullscreen_off.visible = false  # Diubah ke false karena tombol "Off" sudah ditekan
	btn_fullscreen_on.visible = true    # Diubah ke true agar tombol "On" muncul lagi

func _on_btn_fullscreen_on_pressed() -> void:
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	
	btn_fullscreen_off.visible = true   
	btn_fullscreen_on.visible = false  
	
func _center_window() -> void:
	var screen_id = DisplayServer.window_get_current_screen()
	var screen_size = DisplayServer.screen_get_size(screen_id)
	var window_size = DisplayServer.window_get_size()
	var target_pos = (screen_size - window_size) / 2
	DisplayServer.window_set_position(target_pos)

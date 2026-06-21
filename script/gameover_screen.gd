extends Control

@onready var anim_gameover : AnimationPlayer = $AnimGameOver
@onready var lbl_tips_trik : Label = $TxtGameover/lblTipsTrik


func _process(delta: float) -> void:
	anim_gameover.play("anim_gameover")
	lbl_tips_trik.text = "pastikan selalu melihat camera 5 sebelum keluar dari room 5"
	await get_tree().create_timer(10.0).timeout
	get_tree().change_scene_to_file("res://screen/start_screen.tscn")

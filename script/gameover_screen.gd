extends Control

@onready var anim_gameover : AnimationPlayer = $AnimGameOver
@onready var anim_char_jump : AnimationPlayer = $AnimCharJump
@onready var lbl_tips_trik : Label = $AnimGameOver/TxtGameover/lblTipsTrik
@onready var audio_char_jump : AudioStreamPlayer = $AudioCharJump

const AUDIO_RAKA_JUMP = preload("res://sounds/jumpscare/GoldShip_susto.wav")

func _ready() -> void:
	match Global.GameOverId:
		0: # RAKA
			audio_char_jump.stream = AUDIO_RAKA_JUMP
			anim_char_jump.play("Anim_Jump_Raka")
		1: # ALDIAN (Contoh implementasi musuh kedua)
			# audio_char_jump.stream = AUDIO_ALDIAN_JUMP
			# anim_char_jump.play("Anim_Jump_Aldian")
			pass
		_: # Default / Jaga-jaga jika ID tidak terdaftar
			pass
	audio_char_jump.play()
	
	var current_anim = anim_char_jump.get_animation(anim_char_jump.current_animation)
	if current_anim:
		current_anim.loop_mode = Animation.LOOP_NONE

	await get_tree().create_timer(2.0).timeout

	anim_gameover.play("anim_gameover")
	if Global.Gameover.size() > Global.GameOverId:
		lbl_tips_trik.text = Global.Gameover[Global.GameOverId]
	print("Animasi game over selesai. Menunggu 8 detik sebelum pindah scene...")
	await get_tree().create_timer(8.0).timeout
	
	print("Mencoba pindah ke start_screen.tscn...")
	#var error_code = get_tree().change_scene_to_file("res://screen/start_screen.tscn")
	#if error_code != OK:
		#print("Gagal pindah scene! Kode Error: ", error_code)

func _process(delta: float) -> void:
	pass

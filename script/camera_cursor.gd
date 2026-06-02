extends Node2D

@onready var anim_monitor = $animation_camera_monitor
var is_camera_open = false

func _process(delta):
	# 2. Mendeteksi tekanan tombol Spasi ("ui_accept" adalah bawaan Godot untuk Spasi/Enter)
	if Input.is_action_just_pressed("ui_accept"):
		
		# Logika Toggle: Buka dan Tutup Kamera
		if is_camera_open == false:
			anim_monitor.play("open_camera")
			is_camera_open = true
		else:
			anim_monitor.play("close_camera")
			is_camera_open = false

	# 3. Contoh tambahan: Memutar animasi glitch 
	# (Misalnya dipicu saat menekan tombol 'G' di keyboard)
	if Input.is_action_just_pressed("ui_text_submit") or Input.is_physical_key_pressed(KEY_G):
		anim_monitor.play("glitch_camera")

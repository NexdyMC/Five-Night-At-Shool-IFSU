extends CanvasLayer

@onready var animation_player = $AnimationPlayer

func change_scene(target_scene: String) -> void:
	# 1. Mainkan animasi menutup layar
	animation_player.play("fade_to_black")
	await animation_player.animation_finished
	
	# 2. Pindah scene di background
	get_tree().change_scene_to_file(target_scene)
	
	# 3. Mainkan animasi membuka layar
	animation_player.play("fade_to_normal")

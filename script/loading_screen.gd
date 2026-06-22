extends Control

# Tentukan path scene utama game kamu yang ingin dimuat
const MAIN_GAME_SCENE: String = "res://main.tscn"

#@onready var progress_bar: ProgressBar = $ProgressBar
@onready var progress_label: Label = $ProgressLabel
@onready var anim_tx_loading : AnimationPlayer = $AnimTxLoading
var progress: Array = []
var scene_load_status: int = 0

func _ready() -> void:
	# 1. Meminta Godot untuk mulai memuat scene game di background
	ResourceLoader.load_threaded_request(MAIN_GAME_SCENE)
	anim_tx_loading.play("anim_blink")
	
func _process(_delta: float) -> void:
	await get_tree().create_timer(10.0).timeout
	# 2. Memeriksa status proses pemuatan setiap frame
	scene_load_status = ResourceLoader.load_threaded_get_status(MAIN_GAME_SCENE, progress)
	
	# progress[0] berisi nilai rentang 0.0 sampai 1.0
	if progress.size() > 0:
		var progress_value = progress[0] * 100
		#progress_bar.value = progress_value
		progress_label.text = str(progress_value) + "%"
	
	# 3. Jika statusnya selesai (THREAD_LOAD_LOADED = 3)
	if scene_load_status == ResourceLoader.THREAD_LOAD_LOADED:
		# Ambil scene yang sudah selesai dimuat dari memori
		var new_scene = ResourceLoader.load_threaded_get(MAIN_GAME_SCENE)
		
		# Pindah ke scene utama game tersebut
		get_tree().change_scene_to_packed(new_scene)
		
	# 4. Jika terjadi error saat memuat
	elif scene_load_status == ResourceLoader.THREAD_LOAD_FAILED or scene_load_status == ResourceLoader.THREAD_LOAD_INVALID_RESOURCE:
		set_process(false)

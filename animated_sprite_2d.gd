extends AnimatedSprite2D

# Daftar nilai alpha (20%, 50%, 100%)
var alpha_levels = [0.1, 0.2, 0.5]

func _ready():
	# Memastikan animasi gambarnya berjalan
	play("default") 
	# Memulai efek kedap-kedip transparansi
	play_glitch_effect()

func play_glitch_effect():
	while is_inside_tree():
		# 1. Pilih nilai alpha secara acak
		modulate.a = alpha_levels.pick_random()
		
		# 2. Buat jeda kedipan acak antara 0.05 sampai 0.15 detik
		var random_delay = randf_range(0.05, 0.15)
		
		# 3. Tunggu sebelum mengganti alpha lagi
		await get_tree().create_timer(random_delay).timeout

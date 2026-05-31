extends Camera2D

# Kecepatan pergerakan layar
@export var camera_speed: float = 500.0

# Margin untuk mendeteksi kursor (berdasarkan resolusi window 1200x720)
@export var margin_left: float = 300.0
@export var margin_right: float = 1000.0
@export var margin_top: float = 200.0    # 0 - 200 untuk bagian atas
@export var margin_bottom: float = 520.0 # 520 - 720 untuk bagian bawah (720 - 200)

# Batas maksimal pergerakan kamera (World Boundaries)
@export var limit_min_x: float = 0.0
@export var limit_max_x: float = 1200.0
@export var limit_min_y: float = 0.0
@export var limit_max_y: float = 720.0

func _process(delta: float) -> void:
	# Mengambil posisi mouse relatif terhadap window/layar (bukan posisi di dalam game world)
	var mouse_pos = get_viewport().get_mouse_position()
	
	# Vektor untuk menentukan arah gerak
	var direction = Vector2.ZERO

	# --- LOGIKA HORIZONTAL ---
	# Jika kursor di kiri (0 - 300)
	if mouse_pos.x < margin_left:
		direction.x -= 1
	# Jika kursor di kanan (1000 - 1200)
	elif mouse_pos.x > margin_right:
		direction.x += 1

	# --- LOGIKA VERTIKAL ---
	# Jika kursor di atas (0 - 200)
	if mouse_pos.y < margin_top:
		direction.y -= 1
	# Jika kursor di bawah (520 - 720)
	elif mouse_pos.y > margin_bottom:
		direction.y += 1

	# Jika ada pergerakan (direction tidak nol)
	if direction != Vector2.ZERO:
		# Normalisasi agar kecepatan diagonal tidak lebih cepat dari lurus
		direction = direction.normalized()
		
		# Pindahkan posisi kamera
		global_position += direction * camera_speed * delta
		
		# Batasi posisi kamera (Clamp) agar tidak melewati batas max/min yang ditentukan
		global_position.x = clamp(global_position.x, limit_min_x, limit_max_x)
		global_position.y = clamp(global_position.y, limit_min_y, limit_max_y)

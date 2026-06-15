extends Node2D

# Variabel State
var char_a_estado: int = 0
var door_closed: bool = false
var time_accumulator: float = 0.0 # Penghitung waktu

@onready var label_status = $LabelStatus

func _process(delta):
	# Menambah akumulator waktu dengan delta (dalam detik)
	time_accumulator += delta
	
	# Jika sudah mencapai 5 detik, coba gerakkan karakter
	if time_accumulator >= 5.0:
		move_character_logic()
		time_accumulator = 0.0 # Reset timer ke 0 setelah 5 detik

func move_character_logic():
	# Cek apakah karakter sudah mencapai tahap akhir
	if char_a_estado >= 6:
		print("Game Over: Player terbunuh oleh Karakter A!")
		return

	# Logika pergerakan
	if not door_closed:
		char_a_estado += 1
		print("Karakter A maju ke tahap: " + str(char_a_estado))
		
		# Pengecekan status akhir
		if char_a_estado == 6:
			label_status.text = "STATUS: GAME OVER!"
		else:
			label_status.text = "Tahap: " + str(char_a_estado)
	else:
		print("Karakter A terblokir pintu!")

# Fungsi ini tetap bisa dipanggil manual oleh button
func _on_button_pintu_toggled(toggled_on):
	door_closed = toggled_on

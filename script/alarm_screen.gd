extends Control
@onready var audio_alarm : AudioStreamPlayer = $AudioAlarm
@onready var anim_alarm : AnimationPlayer = $AnimAlarm

var Audio_Alarm = preload("res://sounds/alarm.mp3")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	anim_alarm.play("Anim_Alarm")
	audio_alarm.stream = Audio_Alarm
	audio_alarm.play()
	await get_tree().create_timer(10.0).timeout  
	get_tree().change_scene_to_file("res://screen/loading_screen.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

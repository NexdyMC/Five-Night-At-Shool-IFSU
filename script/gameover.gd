extends Node2D

@onready var black : Sprite2D = $BackgroundBlack
@onready var gameover : Sprite2D = $Gameover
@onready var red : Sprite2D = $BackgroundRed
var opacity : int = 20
func _ready() -> void:
	black.visible = true
	gameover.visible = true
	red.visible = true


func _process(delta: float) -> void:
	pass

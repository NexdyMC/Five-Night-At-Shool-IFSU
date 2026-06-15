extends Node

	# level night 1
var SuzukaS_level:	int = 1
var SpecialW_level:	int = 1
var VodkaC_level:	int = 1
var Cafe_level:		int = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.SuzukaS_level = 1
	Global.SpecialW_level = 1
	Global.VodkaC_level = 1
	Global.GoldS_level = 1
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

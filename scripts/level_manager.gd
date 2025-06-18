extends Node2D
class_name LevelManager

signal life_lost

func _ready() -> void:
	if not GSB.all_balls_escaped.is_connected(Callable(self, "_no_more_balls")):
		GSB.all_balls_escaped.connect(Callable(self, "_no_more_balls"))

func _no_more_balls() -> void:
	print("All balls lost!")
	life_lost.emit()

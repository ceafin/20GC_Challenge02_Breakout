extends StaticBody2D
class_name Brick


func take_damage() -> void:
	GSB.brick_broken.emit()
	queue_free()

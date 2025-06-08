class_name LazarShot
extends Area2D

@export var speed : int = 400

func _process(delta: float) -> void:
	position.y -= speed * delta

func _on_body_entered(body: Node2D) -> void:
	if body is Brick and body.has_method("take_damage"):
		body.take_damage()
		queue_free()
	elif body is Mob and body.has_method("take_damage"):
		body.take_damage()
		queue_free()

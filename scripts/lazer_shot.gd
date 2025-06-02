class_name LazarShot
extends Area2D

@export var speed : int = 400

func _process(delta: float) -> void:
	position.y -= speed * delta

func _on_body_entered(body: Node2D) -> void:
	if body is Brick:
		body.take_damage()
		queue_free()
	elif body is Mob:
		body.take_damage()
		queue_free()

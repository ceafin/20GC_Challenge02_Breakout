class_name Ball
extends CharacterBody2D

@export var speed : float = 200.0

func _ready() -> void:
	velocity = Vector2( randf_range(-1,1), randf_range(-1,1) ).normalized()

func _physics_process(delta: float) -> void:
	var collision = move_and_collide( velocity * speed * delta )
	
	if collision:
		velocity = velocity.bounce( collision.get_normal() )

func bounce_off_paddle(paddle_position: Vector2) -> void:
#	var direction = (global_position - paddle_position).normalized()
#	direction.y = -abs(direction.y)
#	velocity = direction

	var offset = (global_position.x - paddle_position.x) / 8.0
	var direction = Vector2(offset, -1).normalized()
	velocity = direction

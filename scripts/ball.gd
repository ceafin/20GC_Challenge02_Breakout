extends CharacterBody2D
class_name Ball

@export var speed : float = 50.0

signal ball_escaped

func _ready() -> void:
	velocity = Vector2( randf_range(-1,1), randf_range(0.5,1) ).normalized()


func _physics_process(delta: float) -> void:
	
	var collision = move_and_collide( velocity * speed * delta )
	
	if collision:
		var collider = collision.get_collider()
		
		if collider is Paddle:
			velocity = bounce_off_paddle(collider.global_position)
		elif collider is Brick:
			collider.take_damage()
			velocity = velocity.bounce( collision.get_normal() )
			speed += 1.333333333
		else:
			velocity = velocity.bounce( collision.get_normal() )

func bounce_off_paddle(paddle_position: Vector2) -> Vector2:
	var offset = (global_position.x - paddle_position.x) / 8.0
	var direction = Vector2(offset, -1).normalized()
	return direction


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	ball_escaped.emit()
	queue_free()

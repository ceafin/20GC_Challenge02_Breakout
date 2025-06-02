class_name Ball
extends CharacterBody2D

@export var speed : float = 150.0

var is_stuck := false
var stuck_to_paddle : Vaus = null
var offset_from_paddle : Vector2
var release_vector : Vector2
var ball_count : int = 0
var balls_node : Node2D

func _ready() -> void:
	add_to_group("balls")
	velocity = Vector2( randf_range(-1,1), randf_range(-1,1) ).normalized()


func _physics_process(delta: float) -> void:
	
	# If stuck in place, abort!
	if is_stuck and stuck_to_paddle:
		velocity = Vector2.ZERO
		global_position = stuck_to_paddle.global_position + offset_from_paddle
		return
	
	var collision = move_and_collide( velocity * speed * delta )
	
	if collision:
		var collider = collision.get_collider()
		
		if collider is Vaus:
			if collider.vaus_state_machine.current_state.name.to_lower() == "catch":
				release_vector = bounce_off_paddle(collider.global_position)
				stick_to(collider)
			else:
				velocity = bounce_off_paddle(collider.global_position)

		elif collider is Brick:
			collider.take_damage()
			velocity = velocity.bounce( collision.get_normal() )
			speed += 0.5
		elif collider is Mob:
			pass
		else:
			velocity = velocity.bounce( collision.get_normal() )

func bounce_off_paddle(paddle_position: Vector2) -> Vector2:
	var offset = (global_position.x - paddle_position.x) / 8.0
	var direction = Vector2(offset, -1).normalized()
	return direction

func stick_to(vaus: Vaus) -> void:
	is_stuck = true
	stuck_to_paddle = vaus
	offset_from_paddle = global_position - vaus.global_position
	velocity = Vector2.ZERO
	await get_tree().process_frame
	

func release_from_paddle() -> void:
	is_stuck = false
	stuck_to_paddle = null
	velocity = release_vector
	


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	print( "I'm free!" )
	queue_free()

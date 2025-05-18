class_name VausCatch
extends VausState


func enter() -> void:
	print("VausCatch.enter()")
	vaus.velocity = Vector2.ZERO
	vaus.animated_sprite_2d.play( "catch_mode" )
	

func physics_update(_delta: float) -> void:
	var input_direction := Input.get_axis( "move_left", "move_right" )
	var target_speed : float = input_direction * vaus.max_speed
	
	if input_direction != 0.0:
		vaus.position.x += target_speed * _delta
		
	if Input.is_action_just_pressed("fire"):
		# Check if any ball is stuck and release it
		for ball in get_tree().get_nodes_in_group("balls"):
			if ball.is_stuck and ball.stuck_to_paddle == vaus:
				ball.release_from_paddle()


func exit() -> void:
	# On exit, release any stuck balls
	for ball in get_tree().get_nodes_in_group("balls"):
		if ball.is_stuck and ball.stuck_to_paddle == vaus:
			ball.release_from_paddle()

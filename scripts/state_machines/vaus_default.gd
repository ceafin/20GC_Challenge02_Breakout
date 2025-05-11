class_name VausDefault
extends VausState

func enter() -> void:
	vaus.velocity = Vector2.ZERO
	vaus.animated_sprite_2d.play( "default" )

func physics_update(_delta: float) -> void:
	var input_direction := Input.get_axis( "move_left", "move_right" )
	var target_speed : float = input_direction * vaus.max_speed

	if input_direction != 0.0:
		vaus.position.x += target_speed * _delta



func exit() -> void:
	pass

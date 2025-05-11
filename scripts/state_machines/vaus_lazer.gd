class_name VausLazer
extends VausState

func enter() -> void:
	vaus.velocity = Vector2.ZERO
	vaus.animated_sprite_2d.play( "fire_mode" )

func handle_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("fire"):
		print("pew! pew!")

func physics_update(_delta: float) -> void:
	var input_direction := Input.get_axis( "move_left", "move_right" )
	var target_speed : float = input_direction * vaus.max_speed

	if input_direction != 0.0:
		vaus.position.x += target_speed * _delta



func exit() -> void:
	pass

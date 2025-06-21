extends StaticBody2D
class_name Paddle

@export var speed : float = 100.0

@onready var animatable_body_2d: AnimatedSprite2D = $AnimatableBody2D

func _process(delta: float) -> void:
	var input_direction := Input.get_axis( "move_left", "move_right" )
	
	var target_speed : float = input_direction * speed
	
	if input_direction != 0.0:
		position.x = clamp( position.x + ( target_speed * delta ), 20.0, 100.0)
		

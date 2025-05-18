class_name VausEnterCatch
extends VausState

func enter() -> void:
	print("Entering EnterCatch")
	if not vaus.animated_sprite_2d.animation_finished.is_connected(_on_entercatch_animation_finished):
		vaus.animated_sprite_2d.animation_finished.connect(_on_entercatch_animation_finished)
	vaus.velocity = Vector2.ZERO
	vaus.animated_sprite_2d.play( "transform_catch" )

func physics_update(_delta: float) -> void:
	var input_direction := Input.get_axis( "move_left", "move_right" )
	var target_speed : float = input_direction * vaus.max_speed

	if input_direction != 0.0:
		vaus.position.x += target_speed * _delta


func exit() -> void:
	print("Exiting EnterCatch")
	if vaus.animated_sprite_2d.animation_finished.is_connected(_on_entercatch_animation_finished):
		vaus.animated_sprite_2d.animation_finished.disconnect(_on_entercatch_animation_finished)

func _on_entercatch_animation_finished():
	print("Animation finished callback fired!")
	transitioned.emit( self, "Catch" )

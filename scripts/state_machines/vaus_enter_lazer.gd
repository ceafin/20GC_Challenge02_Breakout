class_name VausEnterLazer
extends VausState

func enter() -> void:
	print("VausEnterLazer.enter()")
	if not vaus.animated_sprite_2d.animation_finished.is_connected(_on_enterlazer_animation_finished):
		vaus.animated_sprite_2d.animation_finished.connect(_on_enterlazer_animation_finished)
	vaus.velocity = Vector2.ZERO
	vaus.animated_sprite_2d.play( "tranform_fire" )

func physics_update(_delta: float) -> void:
	var input_direction := Input.get_axis( "move_left", "move_right" )
	var target_speed : float = input_direction * vaus.max_speed

	if input_direction != 0.0:
		vaus.position.x += target_speed * _delta


func exit() -> void:
	print("VausEnterLazer.exit()")
	if vaus.animated_sprite_2d.animation_finished.is_connected(_on_enterlazer_animation_finished):
		vaus.animated_sprite_2d.animation_finished.disconnect(_on_enterlazer_animation_finished)

func _on_enterlazer_animation_finished():
	print("Animation finished callback fired!")
	transitioned.emit( self, "Lazer" )

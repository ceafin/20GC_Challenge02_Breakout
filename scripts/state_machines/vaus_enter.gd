class_name VausEnter
extends VausState


func enter() -> void:
	if not vaus.animated_sprite_2d.animation_finished.is_connected(_on_enter_animation_finished):
		vaus.animated_sprite_2d.animation_finished.connect(_on_enter_animation_finished)
	vaus.velocity = Vector2.ZERO
	vaus.animated_sprite_2d.play( "enter" )

func exit() -> void:
	if vaus.animated_sprite_2d.animation_finished.is_connected(_on_enter_animation_finished):
		vaus.animated_sprite_2d.animation_finished.disconnect(_on_enter_animation_finished)

func _on_enter_animation_finished():
	print("Animation finished callback fired!")
	transitioned.emit( self, "Default" )

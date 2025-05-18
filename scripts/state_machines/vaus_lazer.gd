class_name VausLazer
extends VausState

const LAZER_SHOT = preload("res://scenes/lazer_shot.tscn")
const FIRE_RATE := 0.3  # seconds between shots

var fire_timer := 0.0


func enter() -> void:
	print("VausLazer.enter()")
	vaus.velocity = Vector2.ZERO
	vaus.animated_sprite_2d.play( "fire_mode" )
	

func physics_update(_delta: float) -> void:
	var input_direction := Input.get_axis( "move_left", "move_right" )
	var target_speed : float = input_direction * vaus.max_speed
	

	if input_direction != 0.0:
		vaus.position.x += target_speed * _delta
	
	fire_timer -= _delta
	if Input.is_action_pressed("fire") and fire_timer <= 0.0:
		fire_timer = FIRE_RATE
		fire_lazer()
	

func fire_lazer() -> void:
	var bullet = LAZER_SHOT.instantiate()
	bullet.global_position = vaus.global_position - Vector2(0, 4.5)
	get_tree().current_scene.add_child(bullet)
	

func exit() -> void:
	pass

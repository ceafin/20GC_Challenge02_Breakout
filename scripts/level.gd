class_name Level
extends Node2D

const POWER_UP = preload("res://scenes/powerups/power_up.tscn")
const BALL = preload("res://scenes/ball.tscn")


func _ready() -> void:
	GSB.powerup_spawn_requested.connect( _spawn_powerup )
	GSB.multi_ball_requested.connect( _release_the_balls )
	

func _process(delta: float) -> void:
	GSB.balls_counted.emit( count_the_balls() )
	

func _spawn_powerup( target_position: Vector2 ) -> void:
	if randi_range(15,20) == 20:
		var power_up = POWER_UP.instantiate()
		power_up.position = target_position
		var power_ups_node = find_child("PowerUps", true)
		power_ups_node.add_child( power_up )
	

func _release_the_balls() -> void:
	var balls_node = find_child("Balls", true)
	var the_one_ball : Ball = null
	
	var ball_children = balls_node.get_children()
	if ball_children.size() > 0:
		the_one_ball = ball_children[0]
		
		for iteration in range(3):
			var ball = BALL.instantiate()
			ball.position = the_one_ball.position
			balls_node.add_child( ball )
	

func count_the_balls() -> int:
	var ball_count = 0
	var balls_node = find_child("Balls", true)
	if balls_node == null:
		return 0
	
	for sibling in balls_node.get_children():
		if sibling is Ball:
			ball_count += 1
	
	return ball_count

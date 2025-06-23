extends Node2D
class_name MainGame

const BALL = preload("res://scenes/ball.tscn")
const PADDLE = preload("res://scenes/paddle.tscn")
const LEVELS = [
	preload("res://scenes/level_1.tscn"),
	preload("res://scenes/level_2.tscn"),
	preload("res://scenes/level_3.tscn")
]

var max_levels : int
var ball : Ball
var paddle : Paddle
var field : Node2D
var ball_speed : float = 60.0
var player_score : int = 0
var player_level : int = 1
var player_lives : int = 3
var bricks_group : Node2D

@onready var ui: ui = $UI
@onready var you_win: CanvasLayer = $YouWin
@onready var you_lose: CanvasLayer = $YouLose
@onready var get_ready: CanvasLayer = $GetReady
@onready var spawn_timer: Timer = $SpawnTimer

func _ready() -> void:
	max_levels = LEVELS.size()
	bricks_group = find_child("Bricks")
	GSB.brick_broken.connect( Callable( self, "_brick_broken") )
	start_game( player_level )
	

func start_game( level: int ) -> void:
	
	if level > max_levels:
		game_over_win()
		return
	
	field = LEVELS[ level-1 ].instantiate()
	bricks_group.add_child(field)
	
	paddle = PADDLE.instantiate() as Paddle
	add_child(paddle)
	paddle.global_position = Vector2(60, 130)
	
	get_ready.show()
	spawn_timer.start()

func game_over_win() -> void:
	print("YOU WIN!")
	if is_instance_valid(ball):
		ball.queue_free()
	if is_instance_valid(paddle):
		paddle.queue_free()
	if is_instance_valid(field):
		field.queue_free()
	if is_instance_valid(ui):
		ui.hide()
	
	you_win.show()

func game_over_lose() -> void:
	print("YOU LOSE!")
	
	if is_instance_valid(ball):
		ball.queue_free()
	if is_instance_valid(paddle):
		paddle.queue_free()
	if is_instance_valid(field):
		field.queue_free()
	if is_instance_valid(ui):
		ui.hide()
	
	you_lose.show()



func _brick_broken() -> void:
	player_score += 100
	GSB.score_updated.emit()
	if is_level_clear():
		player_level += 1
		GSB.level_cleared.emit()
		if is_instance_valid(ball):
			ball.queue_free()
		if is_instance_valid(paddle):
			paddle.queue_free()
		if is_instance_valid(field):
			field.queue_free()
		start_game( player_level )

func is_level_clear() -> bool:
	var bricks : Array = bricks_group.find_children("*", "Brick", true, false)
	get_tree().process_frame
	if bricks.size() > 1:
		return false
	else:
		return true

func _on_ball_escaped() -> void:
	player_lives -= 1
	GSB.player_died.emit()
	print(player_lives)
	get_tree().process_frame

	if player_lives <= 0:
		game_over_lose()
	else:
		get_ready.show()
		spawn_timer.start()
	

func _on_spawn_timer_timeout() -> void:
	get_ready.hide()
	if is_instance_valid(ball):
		ball.queue_free()
		ball = null
	
	ball = BALL.instantiate() as Ball
	add_child(ball)
	ball.global_position = Vector2(60, 88)
	ball.speed = ball_speed + ( player_level * 0.2 )
	ball.ball_escaped.connect( Callable( self, "_on_ball_escaped" ) )

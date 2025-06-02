class_name PowerUp
extends Area2D

signal spawn_more_balls

const POWERUP_TABLE = [
	{ name = "breakout", weight = 1 },
	{ name = "catch", weight = 5 },
	{ name = "disruption", weight = 1 },
	{ name = "enlarge", weight = 5 },
	{ name = "lazer", weight = 5 },
	{ name = "player", weight = 1 },
	{ name = "multiball", weight = 20 },
	{ name = "slow", weight = 1 },
]

@export var speed : float = 70

var power_name : String
var velocity := Vector2(0,1).normalized()

@onready var animated_sprites: AnimatedSprite2D = $"Animated Sprites"



func _ready() -> void:
	
	power_name = roll_powerup()
	
	match power_name:
		"breakout":
			animated_sprites.play("breakout")
		"catch":
			animated_sprites.play("catch")
		"disruption":
			animated_sprites.play("disruption")
		"enlarge":
			animated_sprites.play("enlarge")
		"lazer":
			animated_sprites.play("lazer")
		"player":
			animated_sprites.play("player")
		"slow":
			animated_sprites.play("slow")
		"multiball":
			animated_sprites.play("multiball")


func _physics_process(delta: float) -> void:
	global_position.y += speed * delta


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	self.queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body is Vaus:
		match power_name:
			"breakout":
				animated_sprites.play("breakout")
			"catch":
				body.on_powerup_collected("EnterCatch")
			"disruption":
				animated_sprites.play("disruption")
			"enlarge":
				animated_sprites.play("enlarge")
			"lazer":
				body.on_powerup_collected("EnterLazer")
			"player":
				animated_sprites.play("player")
			"multiball":
				GSB.multi_ball_requested.emit()
			"slow":
				animated_sprites.play("slow")
		
		queue_free()


func roll_powerup() -> String:
	var total_weight = 0
	for entry in POWERUP_TABLE:
		total_weight += entry.weight
	
	var roll = randi() % total_weight
	var cumulative = 0
	
	for entry in POWERUP_TABLE:
		cumulative += entry.weight
		if roll < cumulative:
			return entry.name
	
	return "nothing"
	

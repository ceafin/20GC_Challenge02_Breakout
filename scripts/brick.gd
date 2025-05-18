class_name Brick
extends StaticBody2D
enum Type {
	RED,
	ORANGE,
	YELLOW,
	GREEN,
	CYAN,
	BLUE,
	MAGENTA,
	WHITE,
	SILVER,
	GOLD,
}

const POWER_UP = preload("res://scenes/powerups/power_up.tscn")

@export var current_type : Type = Type.RED

var hit_points : int = 1

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


func _ready() -> void:
	
	match current_type:
		Type.RED:
			animated_sprite_2d.play("red")
		Type.ORANGE:
			animated_sprite_2d.play("orange")
		Type.YELLOW:
			animated_sprite_2d.play("yellow")
		Type.GREEN:
			animated_sprite_2d.play("green")
		Type.CYAN:
			animated_sprite_2d.play("cyan")
		Type.BLUE:
			animated_sprite_2d.play("blue")
		Type.MAGENTA:
			animated_sprite_2d.play("magenta")
		Type.WHITE:
			animated_sprite_2d.play("white")
		Type.SILVER:
			animated_sprite_2d.play("silver")
			hit_points = 3
		Type.GOLD:
			animated_sprite_2d.play("gold")
			hit_points = 999
	
func take_damage() -> void:
	hit_points -= 1
	if hit_points <= 0:
		spawn_powerup()
		queue_free()

func spawn_powerup() -> void:
	if randi_range(15,20) == 20:
		var power_up = POWER_UP.instantiate()
		power_up.global_position = global_position
		var power_ups_node = get_tree().current_scene.find_child("PowerUps", true)
		power_ups_node.add_child( power_up )
	

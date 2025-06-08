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
		GSB.powerup_spawn_requested.emit( position )
		queue_free()
	match current_type:
		Type.RED:
			GSB.brick_broken.emit( 10 )
		Type.ORANGE:
			GSB.brick_broken.emit( 20 )
		Type.YELLOW:
			GSB.brick_broken.emit( 30 )
		Type.GREEN:
			GSB.brick_broken.emit( 40 )
		Type.CYAN:
			GSB.brick_broken.emit( 50 )
		Type.BLUE:
			GSB.brick_broken.emit( 60 )
		Type.MAGENTA:
			GSB.brick_broken.emit( 70 )
		Type.WHITE:
			GSB.brick_broken.emit( 80 )
		Type.SILVER:
			GSB.brick_broken.emit( 500 )
		Type.GOLD:
			GSB.brick_broken.emit( 1000 )

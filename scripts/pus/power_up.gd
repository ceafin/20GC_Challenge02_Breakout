class_name PowerUp
extends Area2D

enum Powers {
	POWER_BREAKOUT,
	POWER_CATCH,
	POWER_DISRUPTION,
	POWER_ENLARGE,
	POWER_LAZER,
	POWER_PLAYER,
	POWER_SLOW
}

@export var power : Powers
@export var speed : float = 70

var velocity := Vector2(0,1).normalized()

@onready var animated_sprites: AnimatedSprite2D = $"Animated Sprites"



func _ready() -> void:
	
	if !power:
		power = Powers.values().pick_random()
	
	match power:
		Powers.POWER_BREAKOUT:
			animated_sprites.play("breakout")
		Powers.POWER_CATCH:
			animated_sprites.play("catch")
		Powers.POWER_DISRUPTION:
			animated_sprites.play("disruption")
		Powers.POWER_ENLARGE:
			animated_sprites.play("enlarge")
		Powers.POWER_LAZER:
			animated_sprites.play("lazer")
		Powers.POWER_PLAYER:
			animated_sprites.play("player")
		Powers.POWER_BREAKOUT:
			animated_sprites.play("breakout")
		Powers.POWER_SLOW:
			animated_sprites.play("slow")


func _physics_process(delta: float) -> void:
	global_position.y += speed * delta


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	self.queue_free()


func _on_area_entered(area: Area2D) -> void:
	if area is Vaus:
		area.on_powerup_collected("EnterLazer")
		queue_free()  # optional: remove the power-up

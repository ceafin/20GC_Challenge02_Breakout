class_name Vaus
extends StaticBody2D

@export var speed : float = 100.0
@export var max_speed : float = 200.0
@onready var state_label: Label = $StateLabel
@onready var vaus_state_machine: VausStateMachine = $VausStateMachine
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var y_pos = self.position.y

var velocity: Vector2 = Vector2.ZERO

func _process(delta: float) -> void:
	state_label.text = vaus_state_machine.current_state.name


func on_powerup_collected(state_name: String) -> void:
	vaus_state_machine.request_state( state_name )

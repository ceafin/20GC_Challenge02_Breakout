extends Control

@onready var game_area: CenterContainer = $GameArea

const SANDBOX_FIELD = preload("res://scenes/sandbox_field.tscn")

func _ready() -> void:
	var level = SANDBOX_FIELD.instantiate()
	game_area.add_child(level)

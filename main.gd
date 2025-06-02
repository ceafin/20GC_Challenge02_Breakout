extends Control

@onready var game_area: CenterContainer = $GameArea
@onready var label: Label = $RightUI/Label

const SANDBOX_FIELD = preload("res://scenes/sandbox_field.tscn")

var count = 0

func _ready() -> void:
	load_level( SANDBOX_FIELD )
	await get_tree().process_frame
	count = GSB.balls_counted.connect( _ball_count_update )
	

func load_level(level_scene: PackedScene) -> void:
	var level_instance = level_scene.instantiate()
	level_instance.name = "CurrentLevel"
	game_area.add_child(level_instance)
	

func _ball_count_update( count: int ) -> void:
	label.text = str(count)
	if count <= 0:
		print("GAME OVER!")

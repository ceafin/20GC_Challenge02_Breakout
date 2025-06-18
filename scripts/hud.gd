extends Control
class_name HUD

const VAUS_LIFE = preload("res://scenes/vaus_life.tscn")
@onready var score_value = $HBoxContainer/RightVBoxContainer/ScoreValue
@onready var level_value = $HBoxContainer/RightVBoxContainer/LevelValue
@onready var lives_box = $HBoxContainer/RightVBoxContainer/LivesBox

func _ready():
	GSB.lives_updated.connect( _update_lives )
	GSB.brick_broken.connect(Callable(func(value: int) -> void: score_value.text = str( int( score_value.text ) + value ) ))


func _update_lives( new_count: int ) -> void:
	print("Updating lives to: ", new_count)
	
	# Clear old life icons
	for child in lives_box.get_children():
		child.queue_free()

	# Add new life icons
	for i in range( new_count ):
		var life_icon = VAUS_LIFE.instantiate()
		lives_box.add_child( life_icon )

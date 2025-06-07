extends Control
class_name HUD

const VAUS_LIFE = preload("res://scenes/vaus_life.tscn")

@onready var lives_box = $HBoxContainer/RightVBoxContainer/LivesBox

func update_lives( new_count: int ) -> void:
	# Clear old life icons
	for child in lives_box.get_children():
		child.queue_free()

	# Add new life icons
	for i in range( new_count ):
		var life_icon = VAUS_LIFE.instantiate()
		lives_box.add_child( life_icon )

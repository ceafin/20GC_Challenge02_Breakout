extends Node
class_name GameManager

## Loads levels via LevelManager
## • Tracks & updates score and lives
## • Responds to level signals (ball_lost, brick_destroyed, etc.)
## • Calls HUD updates directly or via signal

@export var lives = 3
var score = 0
@onready var level_manager = get_parent().get_node("LevelManager")
@onready var hud = %UI.get_node("HUD")

func _ready():
	await get_tree().process_frame
	load_level( "res://scenes/levels/sandbox_field.tscn" )
	GSB.lives_updated.emit( lives )

func load_level( path ):
	if not is_instance_valid(level_manager):
		push_error("LevelManager not found!")
		return
	
	var scene_res := load( path )
	if scene_res == null or not scene_res is PackedScene:
		push_error("Failed to load level: %s" % path)
		return
	
	free_children( level_manager )
	var level = scene_res.instantiate()
	level_manager.add_child(level)

func update_hud():
	print( "Update HUD!" )
	hud.update_lives( lives )

func free_children( node: Node ):
	print( "Free the children!" )
	for child in node.get_children():
		child.queue_free()

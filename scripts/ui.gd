extends CanvasLayer
class_name ui

var main_game_root : Node2D

func _ready() -> void:
	GSB.score_updated.connect( Callable( self, "_on_score_updated" ) )
	GSB.level_cleared.connect( Callable( self, "_on_level_cleared" ) )
	GSB.player_died.connect( Callable( self, "_on_player_died" ) )
	
	main_game_root = owner as MainGame
	assert(
		main_game_root != null,
		"The UI must only be placed as a direct child of the MainGame scene. It needs the owner to be a MainGame node."
	)
	
	%ScoreText.text = str(main_game_root.player_score)
	%LevelText.text = str(main_game_root.player_level)
	%LivesText.text = str(main_game_root.player_lives)
	

func _on_score_updated() -> void:
	%ScoreText.text = str(main_game_root.player_score)
	
func _on_level_cleared() -> void:
	%LevelText.text = str(main_game_root.player_level)

func _on_player_died() -> void:
	get_tree().process_frame
	%LivesText.text = str(main_game_root.player_lives)

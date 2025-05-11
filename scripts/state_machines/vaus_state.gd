class_name VausState
extends Node

var vaus : Vaus

signal transitioned( acting_state: VausState, new_state: String )

func _ready() -> void:
	await owner.ready
	vaus = owner as Vaus
	assert(
		vaus != null,
		"The State state type must be used only in the Vaus scene. It needs the owner to be a Vaus node."
	)

# Called by the state machine when receiving unhandled input events
func handle_input(_event: InputEvent) -> void:
	pass

# Called by the state machine on the engine's main loop tick
func update(_delta: float) -> void:
	pass

# Called by the state machine on the engine's physics update tick
func physics_update(_delta: float) -> void:
	pass

# Called by the state machine upon changing the active state
func enter() -> void:
	pass

# Called by the state machine before changing the active state
# Use this function to clean up the state
func exit() -> void:
	pass

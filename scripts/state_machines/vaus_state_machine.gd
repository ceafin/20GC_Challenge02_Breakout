class_name VausStateMachine
extends Node

@export var initial_state : VausState = null

@onready var state : VausState = (
	func get_initial_state() -> VausState:
	return initial_state if initial_state != null else get_child(0)
	).call()
	
var current_state : VausState
var states : Dictionary = {}

func _ready() -> void:
	for child_state in get_children():
		if child_state is VausState:
			states[child_state.name.to_lower()] = child_state
			child_state.transitioned.connect( _transition_to_next_state )

	# Wait for owning parent node
	await owner.ready
	
	if initial_state:
		initial_state.enter()
		current_state = initial_state

func _unhandled_input(event: InputEvent) -> void:
	if current_state:
		current_state.handle_input(event)


func _process(delta: float) -> void:
	if current_state:
		current_state.update(delta)


func _physics_process(delta: float) -> void:
	if current_state:
		current_state.physics_update(delta)


func _transition_to_next_state(acting_state: VausState, new_state_name: String) -> void:
	print("Transitioning from %s to %s" % [acting_state.name, new_state_name])
	# Make sure we aren't transitioning into ourselves
	if acting_state != current_state:
		return
	
	# Grab the new state's State Node, make sure real
	var new_state : VausState = states.get(new_state_name.to_lower())
	if !new_state:
		return
	
	# If we have a current state, leave it
	if current_state:
		current_state.exit()
	
	# Enter the new state
	new_state.enter()
	
	# Update what is current state
	current_state = new_state

func request_state(requested_state: String) -> void:
	var new_state = states.get(requested_state.to_lower())
	if new_state and new_state != current_state:
		_transition_to_next_state(current_state, requested_state)

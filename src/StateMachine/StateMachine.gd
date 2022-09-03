class_name StateMachine
extends Node

export var initi_state: NodePath

var state : State

func _ready() -> void:
	yield(owner, "ready")
	
	state = get_node(initi_state)
	
	for child in get_children():
		child.state_machine = self
		
	state.enter()


func _process(delta: float) -> void:
	state.update(delta)


func _physics_process(delta: float) -> void:
	state.physics_update(delta)


func _unhandled_input(event: InputEvent) -> void:
	state.handled_input(event)


func transition_to(target_state : String, msg := {}) -> void:
	if not has_node(target_state):
		return
	state.exit()
	state = get_node(target_state)
	state.enter()

class_name NFB_StateMachineNode
extends NFB_BasicStateMachine



var current_node : NFB_StateNode = null



func _ready() -> void:
	if auto_start:
		start(start_state)



func _process(delta: float) -> void:
	if is_running:
		update()



func start(state : StringName = EMPTY_STATE) -> void:
	if not has_node(NodePath(state)):
		push_error("Unable to find node: \"", state, "\".")
		return
	
	super.start(state)
	current_node = get_node(NodePath(state))
	current_node.enable()



func stop() -> void:
	super.stop()
	current_node.disable()



func pause() -> void:
	super.pause()
	current_node.disable()



func resume() -> void:
	super.resume()
	current_node.enable()



func change_state(target_state : StringName) -> void:
	if not has_node(NodePath(target_state)):
		push_error("Unable to find node: \"", target_state, "\".")
		return
	
	super.change_state(target_state)
	current_node.disable()
	current_node = get_node(NodePath(target_state))
	current_node.enable()

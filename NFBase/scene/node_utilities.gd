class_name NFB_NodeUtilities
extends RefCounted



func in_exceptions(node : Node, exceptions : Array = []) -> bool:
	return (node.name in exceptions) or (node in exceptions)



func get_children(node : Node, exceptions : Array = [], include_internal: bool = false) -> Array[Node]:
	if not is_instance_valid(node):
		push_error("The node cannot be an null pointer.")
		return []
	
	var children : Array[Node] = []
	for child in node.get_children(include_internal):
		if not in_exceptions(child, exceptions):
			children.append(child)
	return children



func clear_children(node : Node, exceptions : Array = [], include_internal: bool = false) -> void:
	if not is_instance_valid(node):
		push_error("The node cannot be an null pointer.")
		return
	
	for child in get_children(node, exceptions, include_internal):
		child.queue_free()



func count_children(node : Node, exceptions : Array = [], include_internal: bool = false) -> int:
	if not is_instance_valid(node):
		push_error("The node cannot be an null pointer.")
		return 0
	
	if exceptions.is_empty():
		return node.get_child_count(include_internal)
	
	return get_children(node, exceptions, include_internal).size()

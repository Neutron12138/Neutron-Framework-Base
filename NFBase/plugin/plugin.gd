class_name NFB_Plugin
extends RefCounted



var name : StringName = &""



func initialize() -> void:
	pass

func finalize() -> void:
	pass



func _to_string() -> String:
	return str("NFB Plugin ", { "name" : name })

class_name NFB_GlobalRegistry
extends RefCounted



var global_data : Dictionary = {}
var global_events : NFB_GlobalEvents = null



func _init() -> void:
	global_events = NFB_GlobalEvents.new()

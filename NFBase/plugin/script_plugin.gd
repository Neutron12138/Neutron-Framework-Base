class_name NFB_ScriptPlugin
extends NFB_Plugin



var gdscript : GDScript = null
var object : Object = null



func initialize() -> void:
	if not is_instance_valid(gdscript):
		return
	
	if not gdscript.can_instantiate():
		return
	
	object = gdscript.new()



func finalize() -> void:
	if not is_instance_valid(object):
		return
	
	if object.get_class() == "Object":
		object.free.call_deferred()



func _to_string() -> String:
	return str("NFB Script Plugin ", {
		"name" : name,
		"gdscript" : gdscript,
		"object" : object
	})

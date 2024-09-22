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

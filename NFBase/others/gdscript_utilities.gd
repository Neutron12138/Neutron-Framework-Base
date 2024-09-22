class_name NFB_GDScriptUtilities
extends RefCounted



static func check_script(script : GDScript) -> Error:
	if not is_instance_valid(script):
		push_error("Cannot run an invalid GDScript (", script, ").")
		return ERR_INVALID_PARAMETER
	
	if not script.can_instantiate():
		push_error("Unable to instantiated script (", script, ").")
		return ERR_INVALID_PARAMETER
	
	return OK



static func load_script_from_string(source_code : String) -> GDScript:
	var script : GDScript = GDScript.new()
	
	script.source_code = source_code
	var err : Error = script.reload()
	if err != OK:
		return null
	
	return script

static func load_script_from_file(path : String, skip_cr : bool = false) -> GDScript:
	var text : String = NFB_FileUtilities.get_file_text(path, skip_cr)
	var script : GDScript = load_script_from_string(text)
	script.resource_name = path
	script.resource_path = path
	return script



static func _create_object(script : GDScript, arguments : Array = []) -> Object:
	var object : Object = script.new.callv(arguments)
	return object

static func create_object(script : GDScript, arguments : Array = []) -> Object:
	if check_script(script) != OK:
		return null
	
	return _create_object(script, arguments)

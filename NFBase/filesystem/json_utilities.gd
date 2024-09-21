class_name NFB_JSONUtilities
extends RefCounted



static func load_json_from_string(text : String, keep_text: bool = false) -> JSON:
	var json : JSON = JSON.new()
	var err : Error = json.parse(text, keep_text)
	
	if err == OK:
		return json
	
	push_error("Failed to parse JSON, error line: ",
	json.get_error_line(), ", error message: \"",
	json.get_error_message(), "\".")
	return null



static func load_json_from_file(path : String, skip_cr: bool = false) -> JSON:
	var text : String = NFB_FileUtilities.get_file_text(path, skip_cr)
	var json : JSON = load_json_from_string(text)
	
	if not is_instance_valid(json):
		push_error("Failed to parse JSON file :\"", path , "\".")
	
	return json



static func load_json_file_as_dictionary(path : String, skip_cr: bool = false) -> Dictionary:
	var data : Variant = load_json_from_file(path, skip_cr).data
	if data is Dictionary:
		return data
	
	push_error("The data in this JSON file (\"", path,
	"\") must be a Dictionary, current type: \"",
	type_string(typeof(data)), "\".")
	return {}

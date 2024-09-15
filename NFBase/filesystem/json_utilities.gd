class_name NFB_JSONUtilities
extends RefCounted

static func load_json_file(path : String, skip_cr: bool = false) -> Variant:
	var text : String = NFB_FileUtilities.get_file_text(path, skip_cr)
	
	var json : JSON = JSON.new()
	var err : Error = json.parse(text)
	if err == OK:
		return json.data
	
	NFB_Logger.loge("Failed to parse JSON file (\"%s\"), error line: %d, error message: \"%s\"." % [path, json.get_error_line(), json.get_error_message()])
	return null



static func load_json_dictionary(path : String, skip_cr: bool = false) -> Dictionary:
	var data : Variant = load_json_file(path, skip_cr)
	if data is Dictionary:
		return data
	
	NFB_Logger.loge("The data in this JSON file (\"%s\") must be a Dictionary, current type: \"%s\"." % [path, type_string(typeof(data))])
	return {}

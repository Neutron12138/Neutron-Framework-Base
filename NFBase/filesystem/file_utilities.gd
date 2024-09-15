class_name NFB_FileUtilities
extends RefCounted



static func open_readonly_file(path : String) -> FileAccess:
	var file : FileAccess = FileAccess.open(path, FileAccess.READ)
	if not is_instance_valid(file):
		push_error("Failed to open readonly file: \"", path,
		"\", reason: \"", error_string(FileAccess.get_open_error()), "\".")
	return file



static func open_writeonly_file(path : String) -> FileAccess:
	var file : FileAccess = FileAccess.open(path, FileAccess.WRITE)
	if not is_instance_valid(file):
		push_error("Failed to open writeonly file: \"", path,
		"\", reason: \"", error_string(FileAccess.get_open_error()), "\".")
	return file



static func open_readwrite_file(path : String, create_if_not_exist : bool = true) -> FileAccess:
	var file : FileAccess = null
	if create_if_not_exist:
		file = FileAccess.open(path, FileAccess.WRITE_READ)
	else:
		file = FileAccess.open(path, FileAccess.READ_WRITE)
	
	if not is_instance_valid(file):
		push_error("Failed to open readwrite file: \"", path,
		"\", reason: \"", error_string(FileAccess.get_open_error()), "\".")
	
	return file



static func get_file_text(path : String, skip_cr: bool = false) -> String:
	var file : FileAccess = open_readonly_file(path)
	if not is_instance_valid(file):
		return ""
	
	return file.get_as_text(skip_cr)

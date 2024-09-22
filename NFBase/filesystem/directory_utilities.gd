class_name NFB_DirectoryUtilities
extends RefCounted



static func open_directory(path : String) -> DirAccess:
	var dir : DirAccess = DirAccess.open(path)
	if not is_instance_valid(dir):
		push_error("Failed to open directory: \"", path,
		"\", reason: \"", error_string(DirAccess.get_open_error()), "\".")
	return dir



static func get_executable_directory() -> String:
	return OS.get_executable_path().get_base_dir() + "/"

static func open_executable_directory() -> DirAccess:
	return open_directory(get_executable_directory())

static func get_user_data_directory() -> String:
	return OS.get_user_data_dir() + "/"

static func open_user_data_directory() -> DirAccess:
	return open_directory(get_user_data_directory())



static func get_files_from_dir(path : String, full : bool = true) -> PackedStringArray:
	if not (path.ends_with("/") or path.ends_with("\\")):
		path += "/"
	
	var dir : DirAccess = open_directory(path)
	if not is_instance_valid(dir):
		return []
	
	var files : PackedStringArray = dir.get_files()
	
	if not full:
		return files
	
	for i in range(files.size()):
		files[i] = path + files[i]
	
	return files



static func get_dirs_from_dir(path : String, full : bool = true) -> PackedStringArray:
	if not path.ends_with("/") or path.ends_with("\\"):
		path += "/"
	
	var dir : DirAccess = open_directory(path)
	if not is_instance_valid(dir):
		return []
	
	var dirs : PackedStringArray = dir.get_directories()
	
	if not full:
		return dirs
	
	for i in range(dirs.size()):
		dirs[i] = path + dirs[i]
	
	return dirs



static func get_all_from_dir(path : String, dirs_first : bool = true, full : bool = true) -> PackedStringArray:
	var dirs : PackedStringArray = get_dirs_from_dir(path, full)
	var files : PackedStringArray = get_files_from_dir(path, full)
	
	return dirs + files if dirs_first else files + dirs

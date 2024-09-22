class_name NFB_FilesystemUtilities
extends RefCounted



const PREFIX_MOD : StringName = &"mod://"
const PREFIX_RES : StringName = &"res://"
const PREFIX_USER : StringName = &"user://"
const PREFIX_EXEC : StringName = &"exec://"



static func analyse_path(path : String, mod_path : String = "") -> String:
	if path.begins_with(PREFIX_MOD):
		return mod_path + path.substr(PREFIX_MOD.length())
	elif path.begins_with(PREFIX_EXEC):
		return NFB_DirectoryUtilities.get_executable_directory() + path.substr(PREFIX_EXEC.length())
	
	return path



static func file_extension_filter(filename : String, extensions : PackedStringArray) -> bool:
	for ext in extensions:
		if filename.ends_with(ext):
			return true
	return false

static func filter_file_by_extension(files : Array[String], extensions : PackedStringArray) -> PackedStringArray:
	return files.filter(func(filename : String) -> bool:
		return file_extension_filter(filename, extensions))

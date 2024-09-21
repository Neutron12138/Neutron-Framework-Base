class_name NFB_CFGUtilities
extends RefCounted



static func load_cfg_from_string(data : String) -> ConfigFile:
	var cfg : ConfigFile = ConfigFile.new()
	var err : Error = cfg.parse(data)
	
	if err == OK:
		return cfg
	
	push_error("Failed to parse CFG from string.")
	return null



static func load_cfg_from_file(path : String) -> ConfigFile:
	var cfg : ConfigFile = ConfigFile.new()
	var err : Error = cfg.load(path)
	
	if err == OK:
		return cfg
	
	push_error("Failed to load CFG from file: \"",
	path, "\", reason: \"", error_string(err), "\".")
	return null

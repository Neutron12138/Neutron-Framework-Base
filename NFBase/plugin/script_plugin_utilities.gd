class_name NFB_ScriptPluginUtilities
extends RefCounted



const INIT_SCRIPT_FILENAME : StringName = &"init.gd"



static func load_from_file(path : String) -> NFB_ScriptPlugin:
	var script : GDScript = NFB_GDScriptUtilities.load_script_from_file(path)
	if not is_instance_valid(script):
		return null
	
	var plugin : NFB_ScriptPlugin = NFB_ScriptPlugin.new()
	plugin.name = NFB_DirectoryUtilities.get_parent_dir_name(path)
	plugin.gdscript = script
	
	return plugin



static func load_from_dir(path : String) -> Array[NFB_ScriptPlugin]:
	var plugins : Array[NFB_ScriptPlugin] = []
	
	var dirs : PackedStringArray = NFB_DirectoryUtilities.get_dirs_from_dir(path)
	
	for dir in dirs:
		var file : String = dir + "/" + INIT_SCRIPT_FILENAME
		if not FileAccess.file_exists(file):
			continue
		
		var plugin : NFB_ScriptPlugin = load_from_file(file)
		if not is_instance_valid(plugin):
			continue
		
		plugins.append(plugin)
	
	return plugins



static func add_plugins(manager : NFB_PluginsManager, plugins : Array[NFB_ScriptPlugin]) -> void:
	if not is_instance_valid(manager):
		push_error("Unable to add plugins to a null instance plugin manager.")
		return
	
	for plugin in plugins:
		if is_instance_valid(plugin):
			manager.plugins[plugin.name] = plugin

class_name NFB_PluginsManager
extends RefCounted



var plugins : Dictionary = {}



func load_plugin(plugin : NFB_Plugin) -> void:
	if not is_instance_valid(plugin):
		push_error("Cannot add a null pointer as a plugin.")
		return
	
	plugins[plugin.name] = plugin
	plugin.initialize()



func unload_plugin(name : StringName) -> void:
	if not plugins.has(name):
		push_error("No plugin named \"", name,
		"\" was found in \"plugins\".")
		return
	
	var plugin : NFB_Plugin = plugins[name]
	if is_instance_valid(plugin):
		plugin.finalize()
	plugins.erase(name)



func initialize_all() -> void:
	for name : StringName in plugins:
		var plugin : NFB_Plugin = plugins[name]
		plugin.initialize()

func finalize_all() -> void:
	for name : StringName in plugins:
		var plugin : NFB_Plugin = plugins[name]
		plugin.finalize()

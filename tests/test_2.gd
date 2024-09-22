extends Node



const SOURCE_CODE : String = """
extends Object

func _notification(what : int) -> void:
	if what == NOTIFICATION_PREDELETE:
		print("PREDELETE")
"""



func _ready() -> void:
	var plugin : NFB_ScriptPlugin = NFB_ScriptPlugin.new()
	plugin.gdscript = NFB_GDScriptUtilities.load_script_from_string(SOURCE_CODE)
	plugin.initialize()
	plugin.finalize()
	
	var manager : NFB_PluginsManager = NFB_PluginsManager.new()
	var plugins : Array[NFB_ScriptPlugin] = NFB_ScriptPluginUtilities.load_from_dir("res://tests/")
	NFB_ScriptPluginUtilities.add_plugins(manager, plugins)
	print(manager.plugins)
	manager.initialize_all()
	manager.finalize_all()

extends Node



func _ready() -> void:
	var manager : NFB_PluginsManager = NFB_PluginsManager.new()
	var plugins : Array[NFB_ScriptPlugin] = NFB_ScriptPluginUtilities.load_from_dir("res://tests/")
	NFB_ScriptPluginUtilities.add_plugins(manager, plugins)
	print(manager.plugins)
	manager.initialize_all()
	print(manager.plugins)
	manager.finalize_all()
	print.call_deferred(manager.plugins)



func _on_nfb_event_dispatcher_mouse_moved(relative: Vector2, velocity: Vector2, position: Vector2) -> void:
	$Label.text = str(relative, "\n", velocity, "\n", position)

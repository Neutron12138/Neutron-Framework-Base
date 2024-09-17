class_name NFB_Main
extends SceneTree



signal crashed



#region

func _notification(what: int) -> void:
	match what:
		NOTIFICATION_CRASH:
			push_error("Game Crashed!")
			crashed.emit()



func _initialize() -> void:
	_add_resource_savers_and_loaders()

#endregion



#region

func _add_resource_savers_and_loaders() -> void:
	ResourceSaver.add_resource_format_saver(NFB_LogData.Saver.new())

#endregion

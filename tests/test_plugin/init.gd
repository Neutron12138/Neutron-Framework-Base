extends Object



func _init() -> void:
	print("test plugin")



func _notification(what : int) -> void:
	if what == NOTIFICATION_PREDELETE:
		print("PREDELETE")

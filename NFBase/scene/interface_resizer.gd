class_name NFB_InterfaceResizer
extends Node



@export var target : Control = null
@export var viewport : Viewport = null:
	set(value):
		if is_instance_valid(viewport):
			if viewport.is_connected("size_changed", resize):
				viewport.disconnect("size_changed", resize)
		
		viewport = value
		if not is_instance_valid(viewport):
			return
		
		if not viewport.is_connected("size_changed", resize):
			viewport.connect("size_changed", resize)



func _ready() -> void:
	if not is_instance_valid(viewport):
		viewport = get_window()
	
	resize()



func resize() -> void:
	if is_instance_valid(target) and is_instance_valid(viewport):
		target.set_size.call_deferred(viewport.size)

class_name NFB_SceneChanger
extends RefCounted



signal scene_changed(old_scene : Node, new_scene : Node)



const METHOD_SHOW : StringName = &"show"
const METHOD_HIDE : StringName = &"hide"



var scene_tree : SceneTree = null:
	set(value):
		scene_tree = value
		current_scene = value.current_scene

var current_scene : Node = null:
	set(value):
		if not value.is_inside_tree():
			push_error("The scene to be changed (", value, ") is not in the scene tree (", scene_tree, ").")
			return
		
		if value == self:
			return
		
		var old_scene : Node = current_scene
		current_scene = value
		scene_tree.current_scene = value
		
		scene_changed.emit(old_scene, current_scene)



func _init(st : SceneTree) -> void:
	scene_tree = st
	current_scene = scene_tree.current_scene



func _change_scene(scene : Node, remove_old_one : bool = true) -> Error:
	if current_scene == scene:
		if remove_old_one:
			push_error("Unable to change the scene to the current scene itself and delete it.")
			return ERR_INVALID_PARAMETER
		return OK
	
	if remove_old_one:
		current_scene.queue_free()
	
	current_scene = scene
	
	return OK

func change_scene(scene : Node, remove_old_one : bool = true) -> Error:
	if not is_instance_valid(scene):
		push_error("Unable to change scene to an invalid node.")
		return ERR_INVALID_PARAMETER
	
	return _change_scene(scene, remove_old_one)



func _change_to_new_scene(new_scene : Node, remove_old_one : bool = true) -> Error:
	if new_scene.is_inside_tree():
		push_warning("The new scene (", new_scene, ") is already in the scene tree, there is no need to add it again.")
	else:
		scene_tree.root.add_child(new_scene)
	
	return _change_scene(new_scene, remove_old_one)

func change_to_new_scene(new_scene : Node, remove_old_one : bool = true) -> Error:
	if not is_instance_valid(new_scene):
		push_error("Unable to change scene to an invalid node.")
		return ERR_INVALID_PARAMETER
	
	return _change_to_new_scene(new_scene, remove_old_one)

class_name NFB_LayeredSceneChanger
extends NFB_SceneChanger



func _forward(scene : Node) -> Error:
	scene.previous_scene = current_scene
	
	if current_scene.has_method(METHOD_HIDE):
		current_scene.call(METHOD_HIDE)
	
	var err : Error = _change_scene(scene, false)
	if err != OK:
		return err
	
	if current_scene.has_method(METHOD_SHOW):
		current_scene.call(METHOD_SHOW)
	
	return OK

func forward(scene : Node) -> Error:
	if not is_instance_valid(scene):
		push_error("Unable to change layered scene to an invalid node.")
		return ERR_INVALID_PARAMETER
	
	return _forward(scene)



func _forward_to_new(new_scene : Node) -> Error:
	new_scene.previous_scene = current_scene
	
	if current_scene.has_method(METHOD_HIDE):
		current_scene.call(METHOD_HIDE)
	
	var err : Error = _change_to_new_scene(new_scene, false)
	if err != OK:
		return err
	
	if current_scene.has_method(METHOD_SHOW):
		current_scene.call(METHOD_SHOW)
	
	return OK

func forward_to_new(new_scene : Node) -> Error:
	if not is_instance_valid(new_scene):
		push_error("Unable to change layered scene to an invalid node.")
		return ERR_INVALID_PARAMETER
	
	return _forward_to_new(new_scene)



func _backward(previous_scene : Node, remove_current : bool = true) -> Error:
	if current_scene.has_method(METHOD_HIDE):
		current_scene.call(METHOD_HIDE)
	
	if remove_current:
		current_scene.queue_free()
	
	var err : Error = _change_scene(previous_scene, false)
	if err != OK:
		return err
	
	if current_scene.has_method(METHOD_SHOW):
		current_scene.call(METHOD_SHOW)
	
	return OK

func backward(previous_scene : Node, remove_current : bool = true) -> Error:
	if not is_instance_valid(previous_scene):
		push_error("The previous scene is an invalid node.")
		return ERR_INVALID_PARAMETER
	
	return _backward(previous_scene, remove_current)

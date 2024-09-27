class_name NFB_EventDispatcher
extends Control



#region signals

signal mouse_button_pressed(button_index : MouseButton, position : Vector2)
signal mouse_button_released(button_index : MouseButton, position : Vector2)
signal mouse_wheel_rolled(factor : float, position : Vector2)
signal mouse_moved(relative : Vector2, velocity : Vector2, position : Vector2)

signal mouse_button_left_pressed(position : Vector2)
signal mouse_button_left_released(position : Vector2)
signal mouse_button_right_pressed(position : Vector2)
signal mouse_button_right_released(position : Vector2)
signal mouse_button_middle_pressed(position : Vector2)
signal mouse_button_middle_released(position : Vector2)

#endregion



enum Mode { INPUT, UNHANDLED_INPUT, GUI_INPUT }
@export var mode : Mode = Mode.UNHANDLED_INPUT



#region handle input event

func _handle_event(event : InputEvent) -> void:
	if event is InputEventMouseMotion:
		_handle_mouse_motion(event)
	elif event is InputEventMouseButton:
		_handle_mouse_button(event)



func _input(event: InputEvent) -> void:
	if mode == Mode.INPUT:
		_handle_event(event)

func _unhandled_input(event: InputEvent) -> void:
	if mode == Mode.UNHANDLED_INPUT:
		_handle_event(event)

func _gui_input(event: InputEvent) -> void:
	if mode == Mode.GUI_INPUT:
		_handle_event(event)

#endregion



#region handle events

func _handle_mouse_motion(event : InputEventMouseMotion) -> void:
	mouse_moved.emit(event.relative, event.velocity, event.position)



func _handle_mouse_button(event : InputEventMouseButton) -> void:
	if event.pressed:
		mouse_button_pressed.emit(event.button_index, event.position)
	else:
		mouse_button_released.emit(event.button_index, event.position)
	
	match event.button_index:
		MOUSE_BUTTON_LEFT:
			_handle_mouse_button_left(event)
		MOUSE_BUTTON_RIGHT:
			_handle_mouse_button_right(event)
		MOUSE_BUTTON_MIDDLE:
			_handle_mouse_button_middle(event)
		MOUSE_BUTTON_WHEEL_UP:
			mouse_wheel_rolled.emit(event.factor, event.position)
		MOUSE_BUTTON_WHEEL_DOWN:
			mouse_wheel_rolled.emit(-event.factor, event.position)



func _handle_mouse_button_left(event : InputEventMouseButton) -> void:
	if event.pressed:
		mouse_button_left_pressed.emit(event.position)
	else:
		mouse_button_left_released.emit(event.position)



func _handle_mouse_button_right(event : InputEventMouseButton) -> void:
	if event.pressed:
		mouse_button_right_pressed.emit(event.position)
	else:
		mouse_button_right_released.emit(event.position)



func _handle_mouse_button_middle(event : InputEventMouseButton) -> void:
	if event.pressed:
		mouse_button_middle_pressed.emit(event.position)
	else:
		mouse_button_middle_released.emit(event.position)

#endregion

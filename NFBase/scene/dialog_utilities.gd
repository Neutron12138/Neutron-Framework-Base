class_name NFB_DialogUtilities
extends RefCounted



static func _init_dialog(dialog : AcceptDialog, title : String, text : String,
	initial_position : Window.WindowInitialPosition = Window.WINDOW_INITIAL_POSITION_CENTER_MAIN_WINDOW_SCREEN) -> void:
	
	dialog.initial_position = initial_position
	dialog.title = title
	dialog.dialog_text = text
	dialog.ok_button_text = "TEXT_CONFIRM"
	if dialog is ConfirmationDialog:
		dialog.cancel_button_text = "TEXT_CANCEL"

static func init_dialog(dialog : AcceptDialog, title : String, text : String,
	initial_position : Window.WindowInitialPosition = Window.WINDOW_INITIAL_POSITION_CENTER_MAIN_WINDOW_SCREEN) -> void:
	if not is_instance_valid(dialog):
		push_error("The dialog object to be initialized cannot be a null pointer.")
		return
	
	_init_dialog(dialog, title, text, initial_position)



static func _set_dialog_response(dialog : AcceptDialog, on_confirmed : Callable = Callable(), on_canceled : Callable = Callable()) -> void:
	if on_confirmed.is_valid():
		dialog.confirmed.connect(on_confirmed)
	if on_canceled.is_valid():
		dialog.canceled.connect(on_canceled)

static func set_dialog_response(dialog : AcceptDialog, on_confirmed : Callable = Callable(), on_canceled : Callable = Callable()) -> void:
	if not is_instance_valid(dialog):
		push_error("The dialog object to be setted cannot be a null pointer.")
		return
	
	_set_dialog_response(dialog, on_confirmed, on_canceled)



static func make_accept_dialog(title : String, text : String, on_confirmed : Callable = Callable(), on_canceled : Callable = Callable()) -> AcceptDialog:
	var dialog : AcceptDialog = AcceptDialog.new()
	_init_dialog(dialog, title, text)
	_set_dialog_response(dialog, on_confirmed, on_canceled)
	return dialog

static func make_confirmation_dialog(title : String, text : String, on_confirmed : Callable = Callable(), on_canceled : Callable = Callable()) -> ConfirmationDialog:
	var dialog : ConfirmationDialog = ConfirmationDialog.new()
	_init_dialog(dialog, title, text)
	_set_dialog_response(dialog, on_confirmed, on_canceled)
	return dialog

static func make_error_dialog(text : String, on_confirmed : Callable = Callable()) -> AcceptDialog:
	return make_accept_dialog("TEXT_ERROR", text, on_confirmed)

static func make_warning_dialog(text : String, on_confirmed : Callable = Callable()) -> AcceptDialog:
	return make_accept_dialog("TEXT_WARNING", text, on_confirmed)



static func make_quit_confirmation(exit_code: int = 0) -> ConfirmationDialog:
	var dialog : ConfirmationDialog = make_confirmation_dialog(
		"TEXT_PLEASE_CONFIRM", "TEXT_QUIT_OR_NOT", func() : Engine.get_main_loop().quit(exit_code))
	dialog.process_mode = Node.PROCESS_MODE_ALWAYS
	return dialog

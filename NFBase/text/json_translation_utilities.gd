class_name NFB_JSONTranslationUtilities
extends RefCounted



const LANGUAGE : StringName = &"language"
const CONTEXT : StringName = &"context"
const MESSAGES : StringName = &"messages"



#region check

static func is_dict_valid(dict : Dictionary) -> bool:
	if dict.is_empty():
		push_error("Parameter \"dict\" cannot be empty.")
		return false
	
	return true

static func is_translation_valid(translation : Translation) -> bool:
	if is_instance_valid(translation):
		return true
	
	push_error("Parameter \"translation\" cannot be a null pointer.")
	return false

#endregion



#region info

static func _parse_info(dict : Dictionary, translation : Translation) -> Error:
	if not dict.has(LANGUAGE):
		push_error("JSON translation file must have a key: \"language\".")
		return ERR_PARSE_ERROR
	
	translation.locale = str(dict[LANGUAGE])
	return OK

static func parse_info(dict : Dictionary, translation : Translation) -> Error:
	if not is_dict_valid(dict):
		return ERR_INVALID_PARAMETER
	
	if not is_translation_valid(translation):
		return ERR_INVALID_PARAMETER
	
	return _parse_info(dict, translation)

#endregion



#region messages

static func _parse_messages(dict : Dictionary, translation : Translation) -> void:
	if not dict.has(MESSAGES):
		push_error("JSON translation file must have a key: \"messages\".")
		return
	
	var messages : Variant = dict.get(MESSAGES)
	if messages is not Dictionary:
		push_error("The value of the key \"messages\" must be of the Dictionary type, but now it is the \"",
		type_string(typeof(messages)), "\" type.")
		return
	
	var context : StringName = str(dict.get(CONTEXT, &""))
	
	for src : StringName in messages:
		var xlated : StringName = str(messages[src])
		translation.add_message(src, xlated, context)
	
	return

static func parse_messages(dict : Dictionary, translation : Translation) -> Error:
	if not is_dict_valid(dict):
		return ERR_INVALID_PARAMETER
	
	if not is_translation_valid(translation):
		return ERR_INVALID_PARAMETER
	
	_parse_messages(dict, translation)
	return OK

#endregion



#region parse

static func _parse(dict : Dictionary) -> Translation:
	var translation : Translation = Translation.new()
	if _parse_info(dict, translation) != OK:
		return null
	_parse_messages(dict, translation)
	return translation

static func parse(json : JSON) -> Translation:
	if not is_instance_valid(json):
		push_error("Unable to parse an null instance.")
		return null
	
	var data : Variant = json.data
	if data is not Dictionary:
		push_error("The data type of JSON (\"", json,
		"\") is incorrect. It should be of the Dictionary type, but the \"",
		type_string(typeof(data)), "\" type was given.")
		return null
	
	return _parse(data)

#endregion

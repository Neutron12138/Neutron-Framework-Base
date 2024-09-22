class_name NFB_CFGTranslationUtilities
extends RefCounted



const LANGUAGE : StringName = &"language"
const CONTEXT : StringName = &"context"
const INFO : StringName = &""
const MESSAGES : StringName = &"messages"



#region check

static func is_cfg_valid(cfg : ConfigFile) -> bool:
	if is_instance_valid(cfg):
		return true
	else:
		push_error("Parameter \"cfg\" cannot be a null pointer.")
		return false

static func is_translation_valid(translation : Translation) -> bool:
	if is_instance_valid(translation):
		return true
	else:
		push_error("Parameter \"translation\" cannot be a null pointer.")
		return false

#endregion



#region info

static func _parse_info(cfg : ConfigFile, translation : Translation) -> Error:
	if not cfg.has_section(INFO):
		push_error("CFG translation files must have a section: \"\".")
		return ERR_INVALID_PARAMETER
	
	if not cfg.has_section_key(INFO, LANGUAGE):
		push_error("CFG translation files must have a key: \"language\".")
		return ERR_PARSE_ERROR
	
	translation.locale = str(cfg.get_value(INFO, LANGUAGE))
	
	if not cfg.has_section_key(INFO, CONTEXT):
		return OK
	
	return OK

static func parse_info(cfg : ConfigFile, translation : Translation) -> Error:
	if not is_cfg_valid(cfg):
		return ERR_INVALID_PARAMETER
	
	if not is_translation_valid(translation):
		return ERR_INVALID_PARAMETER
	
	return _parse_info(cfg, translation)

#endregion



#region messages

static func _parse_messages(cfg : ConfigFile, translation : Translation) -> void:
	if not cfg.has_section(MESSAGES):
		push_error("CFG translation files must have a section: \"messages\".")
		return
	
	var context : StringName = cfg.get_value(INFO, CONTEXT, &"")
	
	for src in cfg.get_section_keys(MESSAGES):
		var xlated : String = str(cfg.get_value(MESSAGES, src))
		translation.add_message(src, xlated, context)

static func parse_messages(cfg : ConfigFile, translation : Translation) -> Error:
	if not is_cfg_valid(cfg):
		return ERR_INVALID_PARAMETER
	
	if not is_translation_valid(translation):
		return ERR_INVALID_PARAMETER
	
	_parse_messages(cfg, translation)
	return OK

#endregion



#region parse

static func _parse(cfg : ConfigFile) -> Translation:
	var translation : Translation = Translation.new()
	if _parse_info(cfg, translation) != OK:
		return null
	_parse_messages(cfg, translation)
	return translation

static func parse(cfg : ConfigFile) -> Translation:
	if not is_instance_valid(cfg):
		push_error("Unable to parse an null instance.")
		return null
	
	return _parse(cfg)

#endregion

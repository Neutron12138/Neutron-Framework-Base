class_name NFB_CFGTranslationUtilities
extends RefCounted



const LANGUAGE : StringName = &"language"
const CONTEXT : StringName = &"context"



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



static func _parse_section(section : String, cfg : ConfigFile, translation : Translation) -> Error:
	
	
	return OK

static func parse_section(section : String, cfg : ConfigFile, translation : Translation) -> Error:
	if not is_cfg_valid(cfg):
		return ERR_INVALID_PARAMETER
	
	if not cfg.has_section(section):
		push_error("Unable to find section \"", section,
		"\" in the ConfigFile (", cfg, ").")
		return ERR_INVALID_PARAMETER
	
	if not is_translation_valid(translation):
		return ERR_INVALID_PARAMETER
	
	return _parse_section(section, cfg, translation)



static func _parse_sections(cfg : ConfigFile, translation : Translation) -> Error:
	for section in cfg.get_sections():
		if section.is_empty():
			var language : Variant = cfg.get_value(section, LANGUAGE)
			if language == null:
				return ERR_PARSE_ERROR
			if not (language is String or language is StringName):
				push_error("The type of the \"language\" in ConfigFile (", cfg,
				") is incorrect, current type: \"", type_string(typeof(language)), "\".")
				return ERR_PARSE_ERROR
			translation.locale = language
		else:
			_parse_section(section, cfg, translation)
	return OK

static func parse_sections(cfg : ConfigFile, translation : Translation) -> Error:
	if not is_cfg_valid(cfg):
		return ERR_INVALID_PARAMETER
	
	if not is_translation_valid(translation):
		return ERR_INVALID_PARAMETER
	
	return _parse_sections(cfg, translation)



static func _load_translation(cfg : ConfigFile) -> Translation:
	var translation : Translation = Translation.new()
	_parse_sections(cfg, translation)
	return translation

static func load_translation(path : String) -> Translation:
	var cfg : ConfigFile = NFB_CFGUtilities.load_cfg_from_file(path)
	if not is_instance_valid(cfg):
		return null
	
	return _load_translation(cfg)

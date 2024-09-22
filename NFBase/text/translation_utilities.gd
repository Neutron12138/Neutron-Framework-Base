class_name NFB_TranslationUtilities
extends RefCounted



static func add_translations(translations : Array[Translation]) -> void:
	for translation in translations:
		if not is_instance_valid(translation):
			continue
		
		TranslationServer.add_translation(translation)



static func add_translations_from_dir(path : String) -> void:
	var translations : Array[Translation] = load_translations_from_dir(path)
	add_translations(translations)



#region load from dir

static func load_cfg_translations_from_dir(path : String) -> Array[Translation]:
	var files : PackedStringArray = NFB_DirectoryUtilities.get_files_from_dir(path)
	files = NFB_FilesystemUtilities.filter_file_by_extension(files, ["cfg"])
	
	var translations : Array[Translation] = []
	
	for file in files:
		var cfg : ConfigFile = NFB_CFGUtilities.load_cfg_from_file(file)
		if not is_instance_valid(cfg):
			continue
		
		var trans : Translation = NFB_CFGTranslationUtilities.parse(cfg)
		if not is_instance_valid(trans):
			continue
		
		translations.append(trans)
	
	return translations



static func load_json_translations_from_dir(path : String) -> Array[Translation]:
	var files : PackedStringArray = NFB_DirectoryUtilities.get_files_from_dir(path)
	files = NFB_FilesystemUtilities.filter_file_by_extension(files, ["json"])
	
	var translations : Array[Translation] = []
	
	for file in files:
		var json : JSON = NFB_JSONUtilities.load_json_from_file(file)
		if not is_instance_valid(json):
			continue
		
		var trans : Translation = NFB_JSONTranslationUtilities.parse(json)
		if not is_instance_valid(trans):
			continue
		
		translations.append(trans)
	
	return translations



static func load_translations_from_dir(path : String) -> Array[Translation]:
	var translations : Array[Translation] = load_cfg_translations_from_dir(path)
	var translations2 : Array[Translation] = load_json_translations_from_dir(path)
	translations.append_array(translations2)
	return translations

#endregion

class_name NFB_Constants
extends RefCounted



const VERSION_MAJOR : int = 0
const VERSION_MINOR : int = 0
const VERSION_REVISION : int = 0
const VERSION_HEX : int = VERSION_MAJOR << 16 | VERSION_MINOR << 8 | VERSION_REVISION << 0
const VERSION_STATUS : StringName = &""
const VERSION_STRING : StringName = &"0.0.0"



const VERSION_DICTIONARY : Dictionary = {
	"major" : VERSION_MAJOR,
	"minor" : VERSION_MINOR,
	"revision" : VERSION_REVISION,
	"hex" : VERSION_HEX,
	"status" : VERSION_STATUS,
	"string" : VERSION_STRING
}



const LICENSE_PATH : StringName = &"res://NFBase/LICENSE.txt"

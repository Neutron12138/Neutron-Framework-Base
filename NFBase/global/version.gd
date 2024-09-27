class_name NFB_Version
extends RefCounted



const MAJOR : int = 0
const MINOR : int = 3
const REVISION : int = 2
const HEX : int = MAJOR << 16 | MINOR << 8 | REVISION << 0
const STATUS : StringName = &""
const STRING : StringName = &"0.3.2"



const DICT : Dictionary = {
	"major" : MAJOR,
	"minor" : MINOR,
	"revision" : REVISION,
	"hex" : HEX,
	"status" : STATUS,
	"string" : STRING
}

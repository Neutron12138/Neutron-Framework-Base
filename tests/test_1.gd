extends Node



const SOURCE_CODE : String = """
extends RefCounted

func _init(a : int, b : int) -> void:
	print(a, b)

func good_job() -> void:
	print("good job!")

"""



func _ready() -> void:
	var script : GDScript = GDScriptUtilities.load_script_from_string(SOURCE_CODE)
	var object : Object = GDScriptUtilities.create_object(script, [114, 514])
	object.good_job()

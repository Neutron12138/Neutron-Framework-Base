extends Node



const SOURCE_CODE : String = """
extends RefCounted

func _init(a : int, b : int) -> void:
	print(a, b)

func good_job() -> void:
	print("good job!")

"""



class Damage extends RefCounted:
	enum Type { SLASH, PENETRATE, HIT }
	
	var number : float = 0.0
	var type : Type = Type.SLASH
	
	func _init(num : float, tp : Type) -> void:
		number = num
		type = tp
	
	func _to_string() -> String:
		return str(Type.find_key(type), " ", number)

class AttackerEffect extends NFB_NumberSolver.NumberEffect:
	func _effect(input : Damage) -> Damage:
		input.number += 10
		return input
	
	func effect(input : Variant) -> Variant:
		return _effect(input)

class InjuredEffect extends NFB_NumberSolver.NumberEffect:
	func _effect(input : Damage) -> Damage:
		match input.type:
			Damage.Type.SLASH:
				input.number *= 0.5
			Damage.Type.PENETRATE:
				input.number *= 1.5
			Damage.Type.HIT:
				input.number *= 1.0
		return input
	
	func effect(input : Variant) -> Variant:
		return _effect(input)



func _ready() -> void:
	var script : GDScript = GDScriptUtilities.load_script_from_string(SOURCE_CODE)
	var object : Object = GDScriptUtilities.create_object(script, [114, 514])
	object.good_job()
	
	var attacker : AttackerEffect = AttackerEffect.new()
	var injured : InjuredEffect = InjuredEffect.new()
	var effects : Array[NFB_NumberSolver.NumberEffect] = [attacker, injured]
	
	var damage1 : Damage = Damage.new(100.0, Damage.Type.SLASH)
	var damage2 : Damage = Damage.new(100.0, Damage.Type.PENETRATE)
	var damage3 : Damage = Damage.new(100.0, Damage.Type.HIT)
	
	var solver : NFB_NumberSolver = NFB_NumberSolver.new()
	print(solver.solve(damage1, effects))
	print(solver.solve(damage2, effects))
	print(solver.solve(damage3, effects))

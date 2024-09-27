class_name NFB_NumberSolver
extends NFB_BasicSolver



class NumberEffect extends BasicEffect:
	func effect(input : Variant) -> Variant:
		return input



func solve(input : Variant, effects : Array[NumberEffect]) -> Variant:
	var result : Variant = input
	for effect in effects:
		result = effect.effect(result)
	return result

extends Node

class_name DomeManager

# Properties
@export var domes: Array[Dome]


# Functions
func createDome(domeType: Enums.DomeTypeEnum, corp: Enums.DomeCorpsEnum, initPos: Vector2i) -> Dome:
	var newDome = Dome.new(domeType, corp, initPos)
	domes.append(newDome)
	# TODO: Hook up to grid system to create a Node that Dome attaches to (?)
	return newDome


func getTotalIncome() -> int:
	var res = 0
	for dome in domes:
		res += dome.getIncome()
	return res


func getTotalUpkeep() -> int:
	var res = 0
	for dome in domes:
		res += dome.getUpkeep()
	return res


func countDomesByType(domeType: Enums.DomeTypeEnum) -> int:
	return domes.filter(func(dome: Dome): return dome.type.type == domeType).size()

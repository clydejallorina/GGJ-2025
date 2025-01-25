extends Node

class_name DomeManager

# TODO: Strike logic

# Properties
@export var domes: Array[Dome] = []
@export var randomCollapseChance: float = 0  # TODO: Should be nonzero at Act 2

var rng: RandomNumberGenerator


# Functions
func _init():
	rng = RandomNumberGenerator.new()
	rng.randomize()


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


func countDomesByType(domeType: Enums.DomeTypeEnum, includeBuilding: bool = false) -> int:
	var filteredDomes = domes.filter(func(dome: Dome): return dome.type.type == domeType).size()

	if !includeBuilding:
		filteredDomes = filteredDomes.filter(func(dome: Dome): return dome.remainingBuildTime == 0)

	return filteredDomes.size()


func randomCollapseDomes(collapseChance: float):
	for dome in domes:
		if rng.randfn() < dome.getCollapseChance(collapseChance):
			dome.setCollapse(true)


func tick():
	# Run through everything that should happen during a tick
	# Random Collapse
	if randomCollapseChance != 0:
		randomCollapseDomes(randomCollapseChance)

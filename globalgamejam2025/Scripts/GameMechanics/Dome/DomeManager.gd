extends Node

# Properties
#@export var domes: Array[Dome] = [] # LET'S USE THE GRID AS THE ARRAY FOR NOW SINCE WE'RE LIMITED IN TIME
@export var random_collapse_chance: float = 0  # TODO: Should be nonzero at Act 2

var rng: RandomNumberGenerator

# Functions
func _init():
	rng = RandomNumberGenerator.new()
	rng.randomize()
	Signals.screen_shake.connect(marsquake)
	
func flatten_grid() -> Array:
	var domes = []
	for row in Globals.GRID:
		for cell in row:
			if cell:
				domes.append(cell)

	return domes

func get_total_income() -> int:
	var res = 0
	var domes = flatten_grid()
	for dome in domes:
		res += dome.getIncome()
	return res

func get_total_upkeep() -> int:
	var res = 0
	var domes = flatten_grid()
	for dome in domes:
		res += dome.getUpkeep()
	return res

func count_domes_by_type(domeType: Enums.DomeTypeEnum, includeBuilding: bool = false) -> int:
	var domes = flatten_grid()
	var filteredDomes = domes.filter(func(dome: Dome): return dome.type == domeType).size()

	if !includeBuilding:
		filteredDomes = filteredDomes.filter(func(dome: Dome): return dome.remainingBuildTime == 0)

	return filteredDomes.size()

func random_collapse_domes(collapseChance: float):
	var domes = flatten_grid()
	for dome in domes:
		if rng.randfn() < dome.getCollapseChance(collapseChance):
			dome.setStatus(Enums.DomeStatusEnum.COLLAPSED)

func marsquake(strength: float):
	var domes = flatten_grid()
	for _i in range(strength):
		var i = rng.randi_range(0, domes.size() - 1)
		if domes[i].type == Enums.DomeTypeEnum.CONTROL_CENTER:
			# Let's not hit the control center with quakes
			# That would be too annoying for the player lol
			continue
		domes[i].setStatus(Enums.DomeStatusEnum.COLLAPSED)


func tick():
	# Run through everything that should happen during a tick
	# Random Collapse
	if random_collapse_chance != 0:
		random_collapse_domes(random_collapse_chance)

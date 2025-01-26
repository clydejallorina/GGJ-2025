extends Node

# Properties
#@export var domes: Array[Dome] = [] # LET'S USE THE GRID AS THE ARRAY FOR NOW SINCE WE'RE LIMITED IN TIME
var rng: RandomNumberGenerator

# Functions
func _init():
	rng = RandomNumberGenerator.new()
	rng.randomize()
	Signals.screen_shake.connect(marsquake)
	Signals.post_tick.connect(get_total_income)
	Signals.post_tick.connect(get_total_upkeep)

func flatten_grid() -> Array:
	var domes = []
	for row in Globals.GRID:
		for cell in row:
			if cell:
				domes.append(cell)

	return domes

func update_global_resource(resources: Dictionary, operation: Enums.ResourceUpdateOperationEnum) -> void:
	for key in resources.keys():
		var value = resources[key]

		match operation:
			Enums.ResourceUpdateOperationEnum.SUBTRACT:
				value = -value

		match key:
			"funds": Globals.funds += value
			"life_support": Globals.life_support += value
			"fuel": Globals.fuel += value
			"minerals": Globals.minerals += value
			"alloys": Globals.alloys += value

func combine_resources(resources: Dictionary, incoming: Dictionary) -> void:
	for key in resources.keys():
		resources[key] += incoming[key]

func get_total_income(day: int) -> void:
	var resources = Constants.EMPTY_RESOURCE_BATCH.duplicate(true)
	var domes = flatten_grid()
	for dome:Dome in domes:
		if dome.shouldGetDomeResources(day):
			combine_resources(resources,dome.getIncome())
	
	update_global_resource(resources, Enums.ResourceUpdateOperationEnum.ADD)

func get_total_upkeep(day: int) -> void:
	var resources = Constants.EMPTY_RESOURCE_BATCH.duplicate(true)
	var domes = flatten_grid()
	for dome:Dome in domes:
		if dome.shouldGetDomeResources(day):
			combine_resources(resources,dome.getUpkeep())

	update_global_resource(resources, Enums.ResourceUpdateOperationEnum.SUBTRACT)

func count_domes_by_type(domeType: Enums.DomeTypeEnum, includeBuilding: bool = false) -> int:
	var domes = flatten_grid()
	var filteredDomes = domes.filter(func(dome: Dome): return dome.type == domeType).size()

	if !includeBuilding:
		filteredDomes = filteredDomes.filter(func(dome: Dome): return dome.remainingBuildTime == 0)

	return filteredDomes.size()
	
func get_domes_by_status(status: Enums.DomeStatusEnum) -> Array:
	var domes = flatten_grid()
	return domes.filter(func(dome): return dome.status == status)

func marsquake(strength: float):
	var domes = flatten_grid()
	var non_collapsed_domes = domes.filter(func(dome): return dome not in get_domes_by_status(Enums.DomeStatusEnum.COLLAPSED))
	
	if non_collapsed_domes.size() == 0:
		return

	# Minor bug, can pick the same dome
	var dome_count = clampi(
		randi_range(1,non_collapsed_domes.size()),
		1, Constants.MAX_COLLAPSED_DOME_PER_QUAKE
	)

	for i in range(dome_count):
		Signals.change_dome_state.emit(
			domes.pick_random().position,
			Enums.DomeStatusEnum.COLLAPSED,
		)

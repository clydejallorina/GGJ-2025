extends Node

class_name Dome

# Properties
@export var type: Enums.DomeTypeEnum
@export var corp: Enums.DomeCorpsEnum
@export var status: Enums.DomeStatusEnum
@export var position: Vector2i

@export var canClick: bool
@export var canCollapse: bool  # Used for cooldown

@export var remainingBuildTime: int

@export var isCollapsed: bool
@export var isStrike: bool

@export var domeStats: Dictionary
@export var corpStats: Dictionary

# Class Constructor
func _init(initType: Enums.DomeTypeEnum, initCorp: Enums.DomeCorpsEnum, initPos: Vector2i):
	type = initType
	corp = initCorp
	position = initPos
	domeStats = Constants.DOME_TYPE_STATS[initType].duplicate(true)
	corpStats = Constants.DOME_CORP_STATS[initCorp].duplicate(true)

	# Set defaults
	remainingBuildTime = getBuildTime()
	canClick = false
	canCollapse = true
	isCollapsed = false
	isStrike = false

# Methods
func getBuildTime() -> int:
	return floori(min(1, domeStats.baseBuildTime + corpStats.buildTimeMod) * Globals.dome_construction_time_multiplier)

func getCost() -> Dictionary:
	var cost = domeStats.baseCost
	for key in cost.keys():
		cost[key] *= corpStats.costMult
		cost[key] *= Globals.dome_construction_cost_multiplier
	return cost

func getIncome() -> Dictionary:
	if isCollapsed || isStrike || remainingBuildTime > 0:
		return Constants.EMPTY_RESOURCE_BATCH.duplicate(true)
	
	print(Globals.income_multipliers)
	var income = domeStats.baseIncome
	for key in income.keys():
		income[key] *= corpStats.incomeMult[key]
		income[key] *= Globals.income_multipliers[type]
		income[key] *= Globals.global_income_multiplier
	return income

func getUpkeep() -> Dictionary:
	if isCollapsed || remainingBuildTime > 0:
		return Constants.EMPTY_RESOURCE_BATCH.duplicate(true)

	var upkeep = domeStats.baseUpkeep
	for key in upkeep.keys():
		upkeep[key] *= corpStats.upkeepMult[key]
		upkeep[key] *= Globals.upkeep_multipliers[type]
		upkeep[key] *= Globals.global_upkeep_multiplier
	return upkeep.duplicate(true)

func setStrike(strikeState: bool):
	isStrike = strikeState

func setCollapse(collapseState: bool):
	isCollapsed = collapseState
	
func getbaseResourceDays() -> int:
	return domeStats.baseResourceCollectDays
	
func shouldGetDomeResources(day: int) -> bool:
	return (day % domeStats.baseResourceCollectDays) == 0

func buildTick():
	if remainingBuildTime == 0:
		return

	remainingBuildTime -= 1

func setStatus(newStatus: Enums.DomeStatusEnum):
	status = newStatus
	# Maybe add additional functionality based on status (e.g. on strikes, on collapse)
	match status:
		Enums.DomeStatusEnum.IDLE:
			setStrike(false)
			setCollapse(false)
		Enums.DomeStatusEnum.COLLAPSED:
			setStrike(false)
			setCollapse(true)
		Enums.DomeStatusEnum.STRIKE:
			setStrike(true)
			setCollapse(false)
	

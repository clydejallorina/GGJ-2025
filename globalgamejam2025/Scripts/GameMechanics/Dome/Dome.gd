extends Node

class_name Dome

# Properties
@export var type: DomeType
@export var corp: DomeCorporation
@export var position: Vector2i

@export var canClick: bool
@export var canCollapse: bool  # Used for cooldown

@export var remainingBuildTime: int

@export var isCollapsed: bool
@export var isStrike: bool


# Class Constructor
func _init(initType: Enums.DomeTypeEnum, initCorp: Enums.DomeCorpsEnum, initPos: Vector2i):
	type = DomeType.new(initType)
	corp = DomeCorporation.new(initCorp)
	position = initPos

	# Set defaults
	remainingBuildTime = getBuildTime()
	canClick = false
	canCollapse = true
	isCollapsed = false
	isStrike = false


# Methods
func getBuildTime() -> int:
	return min(1, type.baseBuildTime + corp.buildTimeMod) * Globals.dome_construction_time_multiplier


func getCost() -> Dictionary:
	var cost = type.baseCost
	for key in cost.keys():
		cost[key] *= corp.costMult
	return cost * Globals.dome_construction_cost_multiplier


func getIncome() -> Dictionary:
	if isCollapsed || isStrike || remainingBuildTime > 0:
		return Constants.EMPTY_RESOURCE_BATCH

	var income = type.baseIncome
	for key in income.keys():
		income[key] *= corp.incomeMult
		income[key] *= Globals.income_multipliers[type.type]
		income[key] *= Globals.global_income_multiplier
	return income


func getUpkeep() -> Dictionary:
	if isCollapsed || remainingBuildTime > 0:
		return Constants.EMPTY_RESOURCE_BATCH

	var upkeep = type.baseUpkeep
	for key in upkeep.keys():
		upkeep[key] *= corp.upkeepMult 
		upkeep[key] *= Globals.upkeep_multipliers[type.type]
		upkeep[key] *= Globals.global_upkeep_multiplier
	return upkeep


func getCollapseChance(baseCollapseChance) -> float:
	if isCollapsed || canCollapse || remainingBuildTime > 0:
		return 0

	return baseCollapseChance * corp.collapseMult


func setStrike(strikeState: bool):
	isStrike = strikeState


func setCollapse(collapseState: bool):
	isCollapsed = collapseState


func buildTick():
	if remainingBuildTime == 0:
		return

	remainingBuildTime -= 1

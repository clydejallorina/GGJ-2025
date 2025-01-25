extends Node

class_name Dome

# Enums
enum DomeStatus {PRODUCING, CLICKABLE, STRIKE, COLLAPSED, BUILDING}


# Properties
@export var type: Enums.DomeTypeEnum
@export var corp: Enums.DomeCorpsEnum
@export var currentStatus: DomeStatus
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
	domeStats = Constants.DOME_TYPE_STATS[initType]
	corpStats = Constants.DOME_CORP_STATS[initCorp]

	# Set defaults
	remainingBuildTime = getBuildTime()
	canClick = false
	canCollapse = true
	isCollapsed = false
	isStrike = false

func _init(initType: Enums.DomeTypeEnum, initCorp: Enums.DomeCorpsEnum):
	type = DomeType.new(initType)
	corp = DomeCorporation.new(initCorp)

# Methods
func getBuildTime() -> int:
	return domeStats.baseBuildTime + corpStats.buildTimeMod

func getCost() -> Dictionary:
	var cost = domeStats.baseCost
	for key in cost.keys():
		cost[key] *= corpStats.costMult
	return cost

func getIncome() -> Dictionary:
	if isCollapsed || isStrike || remainingBuildTime > 0:
		return Constants.EMPTY_RESOURCE_BATCH

	var income = domeStats.baseIncome
	for key in income.keys():
		income[key] *= corpStats.incomeMult
	return income

func getUpkeep() -> Dictionary:
	if isCollapsed || remainingBuildTime > 0:
		return Constants.EMPTY_RESOURCE_BATCH

	var upkeep = domeStats.baseUpkeep
	for key in upkeep.keys():
		upkeep[key] *= corpStats.upkeepMult
	return upkeep


func getCollapseChance(baseCollapseChance) -> float:
	if isCollapsed || canCollapse || remainingBuildTime > 0:
		return 0

	return baseCollapseChance * corpStats.collapseMult


func setStrike(strikeState: bool):
	isStrike = strikeState


func setCollapse(collapseState: bool):
	isCollapsed = collapseState


func buildTick():
	if remainingBuildTime == 0:
		return

	remainingBuildTime -= 1
# TODO: Compute based on type, corporation, and status
func getCollapseChance() -> float:
	# Chance to collapse randomly. Does not include Marsquake collapse
	return 0.05	# For now, 5% chance per tick?

func setStatus(newStatus: DomeStatus):
	currentStatus = newStatus
	# Maybe add additional functionality based on status (e.g. on strikes, on collapse)

extends Node

class_name Dome

# Enums
enum DomeStatus {PRODUCING, CLICKABLE, STRIKE, COLLAPSED, BUILDING}


# Properties
@export var type: DomeType
@export var corp: DomeCorporation
@export var currentStatus: DomeStatus
@export var position: Vector2i
@export var canClick: bool	# Might be changed later
@export var canCollapse: bool	# Might be changed later
@export var canStrike: bool	# Used for cooldown

# Class Constructor
func _init(initType: Enums.DomeTypeEnum, initCorp: Enums.DomeCorpsEnum):
	type = DomeType.new(initType)
	corp = DomeCorporation.new(initCorp)

# Methods
func getBuildTime() -> int:
	return type.baseBuildTime + corp.buildTimeMod

func getCost() -> Dictionary:
	var cost = type.baseCost
	for key in cost.keys():
		cost[key] *= corp.costMult
	return cost

func getIncome() -> Dictionary:
	# TODO: Take into account current status
	var income = type.baseIncome
	for key in income.keys():
		income[key] *= corp.incomeMult
	return income

func getUpkeep() -> Dictionary:
	var upkeep = type.baseUpkeep
	for key in upkeep.keys():
		upkeep[key] *= corp.upkeepMult
	return upkeep

# TODO: Compute based on type, corporation, and status
func getCollapseChance() -> float:
	# Chance to collapse randomly. Does not include Marsquake collapse
	return 0.05	# For now, 5% chance per tick?

func setStatus(newStatus: DomeStatus):
	currentStatus = newStatus
	# Maybe add additional functionality based on status (e.g. on strikes, on collapse)

extends Node

class_name Dome
# Properties
@export var type: DomeType
@export var corp: DomeCorporation
@export var position: Vector2i

@export var canClick: bool
@export var canCollapse: bool  # Used for cooldown

@export var isCollapsed: bool
@export var isStrike: bool


# Class Constructor
func _init(initType: Enums.DomeTypeEnum, initCorp: Enums.DomeCorpsEnum, initPos: Vector2i):
	type = DomeType.new(initType)
	corp = DomeCorporation.new(initCorp)
	position = initPos

	# Set defaults
	canClick = false
	canCollapse = true
	isCollapsed = false
	isStrike = false


# Methods
func getBuildTime() -> int:
	return type.baseBuildTime + corp.buildTimeMod


func getCost() -> Dictionary:
	var cost = type.baseCost
	for key in cost.keys():
		cost[key] *= corp.costMult
	return cost


func getIncome() -> Dictionary:
	if isCollapsed || isStrike:
		return Constants.EMPTY_RESOURCE_BATCH

	var income = type.baseIncome
	for key in income.keys():
		income[key] *= corp.incomeMult
	return income


func getUpkeep() -> Dictionary:
	if isCollapsed:
		return Constants.EMPTY_RESOURCE_BATCH

	var upkeep = type.baseUpkeep
	for key in upkeep.keys():
		upkeep[key] *= corp.upkeepMult
	return upkeep


func getCollapseChance() -> float:
	if isCollapsed || canCollapse:
		return 0

	var collapseChance = type.baseCollapseChance
	collapseChance *= corp.collapseMult
	return collapseChance


func setStrike(strikeState: bool):
	isStrike = strikeState


func setCollapse(collapseState: bool):
	isCollapsed = collapseState

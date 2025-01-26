extends Node

var GRID_SIZE = Vector2(8,8)
var GRID = []
var DAY: int = 0
# Starting date for the game in unix time (2036-01-26)
const STARTING_DATE: int = 2084889600

# Maybe we can make this a const if we don't plan on making this variable
const SECONDS_PER_TICK: int = 1

var act: int = 1
var resupply_time: int = 21

# Resources
var funds: int = 0
var life_support: int = 0
var fuel: int = 0
var minerals: int = 0
var alloys: int = 0

var audited_funds: int = 0
var audited_life_support: int = 0
var audited_fuel: int = 0
var audited_minerals: int = 0
var audited_alloys: int = 0
var audit_fudge_chance: float = 0.0
var audit_fudge_chance_increase: float = 0.025

# Resource Multipliers (typically manipulated by Laws)
var global_upkeep_multiplier: float = 1.0
var upkeep_multipliers: Dictionary = {
	Enums.DomeTypeEnum.HOUSING: 1.0,
	Enums.DomeTypeEnum.INDUSTRIAL: 1.0,
	Enums.DomeTypeEnum.MINING: 1.0,
	Enums.DomeTypeEnum.LIFE_SUPPORT: 1.0,
	Enums.DomeTypeEnum.LUXURY: 1.0,
	Enums.DomeTypeEnum.RESEARCH: 1.0,
	Enums.DomeTypeEnum.SPACE_ELEVATOR: 1.0,
	Enums.DomeTypeEnum.WORMHOLE: 1.0,
}
var dome_construction_cost_multiplier: float = 1.0
var dome_construction_time_multiplier: float = 1.0
var accident_chance_multiplier: float = 1.0
var global_income_multiplier: float = 1.0
var income_multipliers: Dictionary = {
	Enums.DomeTypeEnum.HOUSING: 1.0,
	Enums.DomeTypeEnum.INDUSTRIAL: 1.0,
	Enums.DomeTypeEnum.MINING: 1.0,
	Enums.DomeTypeEnum.LIFE_SUPPORT: 1.0,
	Enums.DomeTypeEnum.LUXURY: 1.0,
	Enums.DomeTypeEnum.RESEARCH: 1.0,
	Enums.DomeTypeEnum.SPACE_ELEVATOR: 1.0,
	Enums.DomeTypeEnum.WORMHOLE: 1.0,
}

# Use res://Scripts/GameMechanics/Messaging/Messaging.gd to interact with this
# There should already be a MessagingHandler node in the MainGame scene
# that deals with this, so try to use that if possible.
var message_queue: Array[Message] = []

# Laws
var active_laws: Array[Enums.LawsEnum] = []

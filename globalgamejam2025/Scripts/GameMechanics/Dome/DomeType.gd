extends Node	# Should this be a resource instead?

class_name DomeType

# Properties
@export var type: Enums.DomeTypeEnum
@export var domeName: String	# Might be redundant?
@export var baseCost: Dictionary
@export var baseUpkeep: Dictionary
@export var baseIncome: Dictionary
@export var baseBuildTime: int

# TODO: Might need to add a base collapse chance here as well if it's different per dome
var domeTypeStats = {
	Enums.DomeTypeEnum.HOUSING: {
		"domeName": "Housing",
		"baseCost": {
			"funds": 20,
			"life_support": 0,
			"fuel": 0,
			"minerals": 0,
			"alloys": 20
		},
		"baseUpkeep": {
			"funds": 20,
			"life_support": 0,
			"fuel": 0,
			"minerals": 0,
			"alloys": 20
		},
		"baseIncome": {
			"funds": 20,
			"life_support": 0,
			"fuel": 0,
			"minerals": 0,
			"alloys": 20
		},
		"baseBuildTime": 2
	},
	Enums.DomeTypeEnum.INDUSTRIAL: {
		"domeName": "Industrial",
		"baseCost": {
			"funds": 20,
			"life_support": 0,
			"fuel": 0,
			"minerals": 0,
			"alloys": 20
		},
		"baseUpkeep": {
			"funds": 20,
			"life_support": 0,
			"fuel": 0,
			"minerals": 0,
			"alloys": 20
		},
		"baseIncome": {
			"funds": 20,
			"life_support": 0,
			"fuel": 0,
			"minerals": 0,
			"alloys": 20
		},
		"baseBuildTime": 2
	},
	Enums.DomeTypeEnum.MINING: {
		"domeName": "Mining",
		"baseCost": {
			"funds": 20,
			"life_support": 0,
			"fuel": 0,
			"minerals": 0,
			"alloys": 20
		},
		"baseUpkeep": {
			"funds": 20,
			"life_support": 0,
			"fuel": 0,
			"minerals": 0,
			"alloys": 20
		},
		"baseIncome": {
			"funds": 20,
			"life_support": 0,
			"fuel": 0,
			"minerals": 0,
			"alloys": 20
		},
		"baseBuildTime": 2
	},
	Enums.DomeTypeEnum.LIFE_SUPPORT: {
		"domeName": "Life Support",
		"baseCost": {
			"funds": 20,
			"life_support": 0,
			"fuel": 0,
			"minerals": 0,
			"alloys": 20
		},
		"baseUpkeep": {
			"funds": 20,
			"life_support": 0,
			"fuel": 0,
			"minerals": 0,
			"alloys": 20
		},
		"baseIncome": {
			"funds": 20,
			"life_support": 0,
			"fuel": 0,
			"minerals": 0,
			"alloys": 20
		},
		"baseBuildTime": 2
	},
	Enums.DomeTypeEnum.LUXURY: {
		"domeName": "Luxury",
		"baseCost": {
			"funds": 20,
			"life_support": 0,
			"fuel": 0,
			"minerals": 0,
			"alloys": 20
		},
		"baseUpkeep": {
			"funds": 20,
			"life_support": 0,
			"fuel": 0,
			"minerals": 0,
			"alloys": 20
		},
		"baseIncome": {
			"funds": 20,
			"life_support": 0,
			"fuel": 0,
			"minerals": 0,
			"alloys": 20
		},
		"baseBuildTime": 2
	},
	Enums.DomeTypeEnum.RESEARCH: {
		"domeName": "Research",
		"baseCost": {
			"funds": 20,
			"life_support": 0,
			"fuel": 0,
			"minerals": 0,
			"alloys": 20
		},
		"baseUpkeep": {
			"funds": 20,
			"life_support": 0,
			"fuel": 0,
			"minerals": 0,
			"alloys": 20
		},
		"baseIncome": {
			"funds": 20,
			"life_support": 0,
			"fuel": 0,
			"minerals": 0,
			"alloys": 20
		},
		"baseBuildTime": 2
	},
	Enums.DomeTypeEnum.SPACE_ELEVATOR: {
		"domeName": "Space Elevator",
		"baseCost": {
			"funds": 20,
			"life_support": 0,
			"fuel": 0,
			"minerals": 0,
			"alloys": 20
		},
		"baseUpkeep": {
			"funds": 20,
			"life_support": 0,
			"fuel": 0,
			"minerals": 0,
			"alloys": 20
		},
		"baseIncome": {
			"funds": 20,
			"life_support": 0,
			"fuel": 0,
			"minerals": 0,
			"alloys": 20
		},
		"baseBuildTime": 2
	},
	Enums.DomeTypeEnum.WORMHOLE: {
		"domeName": "Wormhole",
		"baseCost": {
			"funds": 20,
			"life_support": 0,
			"fuel": 0,
			"minerals": 0,
			"alloys": 20
		},
		"baseUpkeep": {
			"funds": 20,
			"life_support": 0,
			"fuel": 0,
			"minerals": 0,
			"alloys": 20
		},
		"baseIncome": {
			"funds": 20,
			"life_support": 0,
			"fuel": 0,
			"minerals": 0,
			"alloys": 20
		},
		"baseBuildTime": 2
	},
}

# Class Constructor
func _init(initType: Enums.DomeTypeEnum):
	type = initType
	domeName = domeTypeStats[initType]["domeName"]
	baseCost = domeTypeStats[initType]["baseCost"]
	baseUpkeep = domeTypeStats[initType]["baseUpkeep"]
	baseIncome = domeTypeStats[initType]["baseIncome"]
	baseBuildTime = domeTypeStats[initType]["baseBuildTime"]

extends Node  # Should this be a resource instead?

class_name DomeType

# Properties
@export var type: Enums.DomeTypeEnum
@export var domeName: String  # Might be redundant?
@export var baseCollapseChance: float
@export var baseCost: Dictionary
@export var baseUpkeep: Dictionary
@export var baseIncome: Dictionary
@export var baseBuildTime: int

# Maps to { domeName, baseCollapseChance, baseCost, baseUpkeep, baseIncome, baseBuildtime }
var domeTypeStats = {
	Enums.DomeTypeEnum.HOUSING:
	{
		"domeName": "Housing",
		"baseCollapseChance": 0.05,
		"baseCost": {"funds": 20, "life_support": 0, "fuel": 0, "minerals": 0, "alloys": 20},
		"baseUpkeep": {"funds": 20, "life_support": 0, "fuel": 0, "minerals": 0, "alloys": 20},
		"baseIncome": {"funds": 20, "life_support": 0, "fuel": 0, "minerals": 0, "alloys": 20},
		"baseBuildTime": 2
	},
	Enums.DomeTypeEnum.INDUSTRIAL:
	{
		"domeName": "Industrial",
		"baseCollapseChance": 0.05,
		"baseCost": {"funds": 20, "life_support": 0, "fuel": 0, "minerals": 0, "alloys": 20},
		"baseUpkeep": {"funds": 20, "life_support": 0, "fuel": 0, "minerals": 0, "alloys": 20},
		"baseIncome": {"funds": 20, "life_support": 0, "fuel": 0, "minerals": 0, "alloys": 20},
		"baseBuildTime": 2
	},
	Enums.DomeTypeEnum.MINING:
	{
		"domeName": "Mining",
		"baseCollapseChance": 0.05,
		"baseCost": {"funds": 20, "life_support": 0, "fuel": 0, "minerals": 0, "alloys": 20},
		"baseUpkeep": {"funds": 20, "life_support": 0, "fuel": 0, "minerals": 0, "alloys": 20},
		"baseIncome": {"funds": 20, "life_support": 0, "fuel": 0, "minerals": 0, "alloys": 20},
		"baseBuildTime": 2
	},
	Enums.DomeTypeEnum.LIFE_SUPPORT:
	{
		"domeName": "Life Support",
		"baseCollapseChance": 0.05,
		"baseCost": {"funds": 20, "life_support": 0, "fuel": 0, "minerals": 0, "alloys": 20},
		"baseUpkeep": {"funds": 20, "life_support": 0, "fuel": 0, "minerals": 0, "alloys": 20},
		"baseIncome": {"funds": 20, "life_support": 0, "fuel": 0, "minerals": 0, "alloys": 20},
		"baseBuildTime": 2
	},
	Enums.DomeTypeEnum.LUXURY:
	{
		"domeName": "Luxury",
		"baseCollapseChance": 0.05,
		"baseCost": {"funds": 20, "life_support": 0, "fuel": 0, "minerals": 0, "alloys": 20},
		"baseUpkeep": {"funds": 20, "life_support": 0, "fuel": 0, "minerals": 0, "alloys": 20},
		"baseIncome": {"funds": 20, "life_support": 0, "fuel": 0, "minerals": 0, "alloys": 20},
		"baseBuildTime": 2
	},
	Enums.DomeTypeEnum.RESEARCH:
	{
		"domeName": "Research",
		"baseCollapseChance": 0.05,
		"baseCost": {"funds": 20, "life_support": 0, "fuel": 0, "minerals": 0, "alloys": 20},
		"baseUpkeep": {"funds": 20, "life_support": 0, "fuel": 0, "minerals": 0, "alloys": 20},
		"baseIncome": {"funds": 20, "life_support": 0, "fuel": 0, "minerals": 0, "alloys": 20},
		"baseBuildTime": 2
	},
	Enums.DomeTypeEnum.SPACE_ELEVATOR:
	{
		"domeName": "Space Elevator",
		"baseCollapseChance": 0.05,
		"baseCost": {"funds": 20, "life_support": 0, "fuel": 0, "minerals": 0, "alloys": 20},
		"baseUpkeep": {"funds": 20, "life_support": 0, "fuel": 0, "minerals": 0, "alloys": 20},
		"baseIncome": {"funds": 20, "life_support": 0, "fuel": 0, "minerals": 0, "alloys": 20},
		"baseBuildTime": 2
	},
	Enums.DomeTypeEnum.WORMHOLE:
	{
		"domeName": "Wormhole",
		"baseCollapseChance": 0.05,
		"baseCost": {"funds": 20, "life_support": 0, "fuel": 0, "minerals": 0, "alloys": 20},
		"baseUpkeep": {"funds": 20, "life_support": 0, "fuel": 0, "minerals": 0, "alloys": 20},
		"baseIncome": {"funds": 20, "life_support": 0, "fuel": 0, "minerals": 0, "alloys": 20},
		"baseBuildTime": 2
	},
}


# Class Constructor
func _init(initType: Enums.DomeTypeEnum):
	type = initType
	domeName = domeTypeStats[initType]["domeName"]
	baseCollapseChance = domeTypeStats[initType]["baseCollapseChance"]
	baseCost = domeTypeStats[initType]["baseCost"]
	baseUpkeep = domeTypeStats[initType]["baseUpkeep"]
	baseIncome = domeTypeStats[initType]["baseIncome"]
	baseBuildTime = domeTypeStats[initType]["baseBuildTime"]

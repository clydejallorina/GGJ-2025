extends Node

const EMPTY_RESOURCE_BATCH: Dictionary = {
	"funds": 0,
	"life_support": 0,
	"fuel": 0,
	"minerals": 0,
	"alloys": 0
}

const BUILDING_TO_TILESET_SOURCE_MAP: Dictionary = {
	Enums.DomeTypeEnum.CONTROL_CENTER: 0,
	Enums.DomeTypeEnum.HOUSING: 1,
	Enums.DomeTypeEnum.INDUSTRIAL: 3,
	Enums.DomeTypeEnum.MINING: 4,
	Enums.DomeTypeEnum.LIFE_SUPPORT: 2,
	Enums.DomeTypeEnum.LUXURY: 6,
	Enums.DomeTypeEnum.RESEARCH: 5,
	Enums.DomeTypeEnum.SPACE_ELEVATOR: null,
	Enums.DomeTypeEnum.WORMHOLE: null,
}

const STATE_OVERLAY_TO_TILESET_ATLAS_COORD: Dictionary = {
	Enums.DomeStatusEnum.IDLE: Vector2i(-1,-1),
	Enums.DomeStatusEnum.PRODUCING: Vector2i(0,5),
	Enums.DomeStatusEnum.STRIKE: Vector2i(6,0),
	Enums.DomeStatusEnum.COLLAPSED: Vector2i(6,1),
	Enums.DomeStatusEnum.BUILDING: Vector2i(7,2)
}

const TWO_BY_TWO_BUILDINGS: Array[Enums.DomeTypeEnum] = [
	Enums.DomeTypeEnum.CONTROL_CENTER,
]

var DOME_TYPE_STATS = {
	Enums.DomeTypeEnum.HOUSING:
	{
		"domeName": "Housing",
		"baseCost": {"funds": 20, "life_support": 0, "fuel": 0, "minerals": 0, "alloys": 20},
		"baseUpkeep": {"funds": 20, "life_support": 0, "fuel": 0, "minerals": 0, "alloys": 20},
		"baseIncome": {"funds": 20, "life_support": 0, "fuel": 0, "minerals": 0, "alloys": 20},
		"baseBuildTime": 2
	},
	Enums.DomeTypeEnum.INDUSTRIAL:
	{
		"domeName": "Industrial",
		"baseCost": {"funds": 20, "life_support": 0, "fuel": 0, "minerals": 0, "alloys": 20},
		"baseUpkeep": {"funds": 20, "life_support": 0, "fuel": 0, "minerals": 0, "alloys": 20},
		"baseIncome": {"funds": 20, "life_support": 0, "fuel": 0, "minerals": 0, "alloys": 20},
		"baseBuildTime": 2
	},
	Enums.DomeTypeEnum.MINING:
	{
		"domeName": "Mining",
		"baseCost": {"funds": 20, "life_support": 0, "fuel": 0, "minerals": 0, "alloys": 20},
		"baseUpkeep": {"funds": 20, "life_support": 0, "fuel": 0, "minerals": 0, "alloys": 20},
		"baseIncome": {"funds": 20, "life_support": 0, "fuel": 0, "minerals": 0, "alloys": 20},
		"baseBuildTime": 2
	},
	Enums.DomeTypeEnum.LIFE_SUPPORT:
	{
		"domeName": "Life Support",
		"baseCost": {"funds": 20, "life_support": 0, "fuel": 0, "minerals": 0, "alloys": 20},
		"baseUpkeep": {"funds": 20, "life_support": 0, "fuel": 0, "minerals": 0, "alloys": 20},
		"baseIncome": {"funds": 20, "life_support": 0, "fuel": 0, "minerals": 0, "alloys": 20},
		"baseBuildTime": 2
	},
	Enums.DomeTypeEnum.LUXURY:
	{
		"domeName": "Luxury",
		"baseCost": {"funds": 20, "life_support": 0, "fuel": 0, "minerals": 0, "alloys": 20},
		"baseUpkeep": {"funds": 20, "life_support": 0, "fuel": 0, "minerals": 0, "alloys": 20},
		"baseIncome": {"funds": 20, "life_support": 0, "fuel": 0, "minerals": 0, "alloys": 20},
		"baseBuildTime": 2
	},
	Enums.DomeTypeEnum.RESEARCH:
	{
		"domeName": "Research",
		"baseCost": {"funds": 20, "life_support": 0, "fuel": 0, "minerals": 0, "alloys": 20},
		"baseUpkeep": {"funds": 20, "life_support": 0, "fuel": 0, "minerals": 0, "alloys": 20},
		"baseIncome": {"funds": 20, "life_support": 0, "fuel": 0, "minerals": 0, "alloys": 20},
		"baseBuildTime": 2
	},
	Enums.DomeTypeEnum.SPACE_ELEVATOR:
	{
		"domeName": "Space Elevator",
		"baseCost": {"funds": 20, "life_support": 0, "fuel": 0, "minerals": 0, "alloys": 20},
		"baseUpkeep": {"funds": 20, "life_support": 0, "fuel": 0, "minerals": 0, "alloys": 20},
		"baseIncome": {"funds": 20, "life_support": 0, "fuel": 0, "minerals": 0, "alloys": 20},
		"baseBuildTime": 2
	},
	Enums.DomeTypeEnum.WORMHOLE:
	{
		"domeName": "Wormhole",
		"baseCost": {"funds": 20, "life_support": 0, "fuel": 0, "minerals": 0, "alloys": 20},
		"baseUpkeep": {"funds": 20, "life_support": 0, "fuel": 0, "minerals": 0, "alloys": 20},
		"baseIncome": {"funds": 20, "life_support": 0, "fuel": 0, "minerals": 0, "alloys": 20},
		"baseBuildTime": 2
	},
	Enums.DomeTypeEnum.CONTROL_CENTER:
	{
		"domeName": "Control Center",
		"baseCost": {"funds": 20, "life_support": 0, "fuel": 0, "minerals": 0, "alloys": 20},
		"baseUpkeep": {"funds": 20, "life_support": 0, "fuel": 0, "minerals": 0, "alloys": 20},
		"baseIncome": {"funds": 20, "life_support": 0, "fuel": 0, "minerals": 0, "alloys": 20},
		"baseBuildTime": 2
	},
}

var DOME_CORP_STATS = {
	Enums.DomeCorpsEnum.CORP1:
	{
		"name": "Xpace",
		"buildTimeMod": 0,
		"collapseMult": 1.0,
		"costMult": 1.0,
		"incomeMult": 1.0,
		"upkeepMult": 1.0,
		"strikeMult": 1.0,
	},
	Enums.DomeCorpsEnum.CORP2:
	{
		"name": "Qiancheng Macrotechnologies",
		"buildTimeMod": 0,
		"collapseMult": 1.0,
		"costMult": 1.0,
		"incomeMult": 1.0,
		"upkeepMult": 1.0,
		"strikeMult": 1.0,
	},
	Enums.DomeCorpsEnum.CORP3:
	{
		"name": "Sentinel Inc",
		"buildTimeMod": 0,
		"collapseMult": 1.0,
		"costMult": 1.0,
		"incomeMult": 1.0,
		"upkeepMult": 1.0,
		"strikeMult": 1.0,
	},
	Enums.DomeCorpsEnum.CORP4:
	{
		"name": "Sierra Initiative",
		"buildTimeMod": 0,
		"collapseMult": 1.0,
		"costMult": 1.0,
		"incomeMult": 1.0,
		"upkeepMult": 1.0,
		"strikeMult": 1.0,
	},
	Enums.DomeCorpsEnum.CORP5:
	{
		"name": "Horizon Collective",
		"buildTimeMod": 0,
		"collapseMult": 1.0,
		"costMult": 1.0,
		"incomeMult": 1.0,
		"upkeepMult": 1.0,
		"strikeMult": 1.0,
	},
}

const RESUPPLY_TIMES: Array[int] = [21, 30, 30]

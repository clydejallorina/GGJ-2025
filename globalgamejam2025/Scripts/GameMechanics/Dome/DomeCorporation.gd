extends Node  # Should this be a resource instead?

class_name DomeCorporation

# Redundant between DomeCorporation and Dome

# Properties
@export var corp: Enums.DomeCorpsEnum
@export var corpName: String
@export var buildTimeMod: int
@export var collapseMult: float
@export var costMult: float
@export var incomeMult: float
@export var upkeepMult: float
@export var strikeMult: float

# buildTimeMod will be added to the buildTime, which is the amount of ticks to finish building
# collapseMult will be multiplied to chance of collapse. Result should be between 0f and 1f
# incomeMult will be multiplied to income, which will then be floored
# strikeMult will be multiplied to chance of strike. Result should be between 0f and 1f
var domeCorpStats = {
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


# Class Constructor
func _init(initCorp: Enums.DomeCorpsEnum):
	corp = initCorp
	buildTimeMod = domeCorpStats[corp]["buildTimeMod"]
	collapseMult = domeCorpStats[corp]["collapseMult"]
	costMult = domeCorpStats[corp]["costMult"]
	incomeMult = domeCorpStats[corp]["incomeMult"]
	upkeepMult = domeCorpStats[corp]["upkeepMult"]
	strikeMult = domeCorpStats[corp]["strikeMult"]

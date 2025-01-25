extends Node

@onready var ticker_node = get_node("GameTicker")

func _ready() -> void:
	init_game()

func tick_game() -> void:
	# Call this function to advance the game by one day (tick)
	# This is called by the timer every timeout
	post_tick()
	Globals.DAY += 1
	pre_tick()

func pre_tick() -> void:
	# Handle all processes that need to be done before the day (tick) begins
	# Typically this would be the "effects", so setting whether certain tiles
	# are enabled or not would probably fall under here.
	print("Pre tick, day " + str(Globals.DAY))
	Globals.pre_tick.emit(Globals.DAY)

func post_tick() -> void:
	# Handle all processes that need to be done once the day (tick) ends
	# Typically this would be "causes", so stuff like determining whether or not
	# to start a dust storm would go here, or stuff like currency calculation.
	print("Post tick, day " + str(Globals.DAY))
	Globals.post_tick.emit(Globals.DAY)

func init_game() -> void:
	# Game initialization stuff here
	ticker_node.wait_time = Globals.SECONDS_PER_TICK
	ticker_node.start()
	
	# Multipliers Initialization
	Globals.global_upkeep_multiplier = 1.0
	Globals.upkeep_multipliers = {
		Enums.DomeTypeEnum.HOUSING: 1.0,
		Enums.DomeTypeEnum.INDUSTRIAL: 1.0,
		Enums.DomeTypeEnum.MINING: 1.0,
		Enums.DomeTypeEnum.LIFE_SUPPORT: 1.0,
		Enums.DomeTypeEnum.LUXURY: 1.0,
		Enums.DomeTypeEnum.RESEARCH: 1.0,
		Enums.DomeTypeEnum.SPACE_ELEVATOR: 1.0,
		Enums.DomeTypeEnum.WORMHOLE: 1.0,
	}
	Globals.dome_construction_cost_multiplier = 1.0
	Globals.dome_construction_time_multiplier = 1.0
	Globals.accident_chance_multiplier = 1.0
	Globals.global_income_multiplier = 1.0
	Globals.income_multipliers = {
		Enums.DomeTypeEnum.HOUSING: 1.0,
		Enums.DomeTypeEnum.INDUSTRIAL: 1.0,
		Enums.DomeTypeEnum.MINING: 1.0,
		Enums.DomeTypeEnum.LIFE_SUPPORT: 1.0,
		Enums.DomeTypeEnum.LUXURY: 1.0,
		Enums.DomeTypeEnum.RESEARCH: 1.0,
		Enums.DomeTypeEnum.SPACE_ELEVATOR: 1.0,
		Enums.DomeTypeEnum.WORMHOLE: 1.0,
	}
	Globals.funds = 100
	Globals.life_support = 100
	Globals.fuel = 100
	Globals.minerals = 0
	Globals.alloys = 100

func _on_game_ticker_timeout() -> void:
	# Tick the game every time the timer times out
	# Say that five times as fast
	tick_game()
	ticker_node.wait_time = Globals.SECONDS_PER_TICK

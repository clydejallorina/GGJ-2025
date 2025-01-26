extends Node

@onready var ticker_node = get_node("GameTicker")

func _ready() -> void:
	init_game()
	
func _input(event: InputEvent) -> void:
	## REMOVE THIS, JUST FOR TESTING
	if event is InputEventKey and event.is_pressed() and event.keycode == KEY_A:
		var valid_domes = Enums.DomeTypeEnum.values().filter(func(val): return Constants.BUILDING_TO_TILESET_SOURCE_MAP[val] != null and val != Enums.DomeTypeEnum.CONTROL_CENTER)
		Signals.build_dome.emit(valid_domes.pick_random(), Enums.DomeCorpsEnum.values().pick_random())
		
	if event is InputEventKey and event.is_pressed() and event.keycode == KEY_D:
		Signals.destroy_dome.emit()
		
	if event is InputEventKey and event.is_pressed() and event.keycode == KEY_S:
		Signals.screen_shake.emit(1)

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
	var random = RandomNumberGenerator.new()
	random.randomize()
	# Check if we need to resupply
	if Globals.resupply_time <= 0:
		print("Resupplying!")
		Globals.resupply_time = Constants.RESUPPLY_TIMES[Globals.act - 1]
		# TODO: Configurable resupplies
		Globals.funds += 100
		Globals.alloys += 100
	if Globals.DAY % 7 == 0:
		# Do an audit
		Globals.audited_funds = Globals.funds
		Globals.audited_life_support = Globals.life_support
		Globals.audited_fuel = Globals.fuel
		Globals.audited_minerals = Globals.minerals
		Globals.audited_alloys = Globals.alloys
		if Globals.audit_fudge_chance > 0:
			# Fudge the numbers a little depending on the chance
			Globals.audited_funds += random.randi_range(-100 * Globals.audit_fudge_chance, 100 * Globals.audit_fudge_chance)
			Globals.audited_life_support += random.randi_range(-100 * Globals.audit_fudge_chance, 100 * Globals.audit_fudge_chance)
			Globals.audited_fuel += random.randi_range(-100 * Globals.audit_fudge_chance, 100 * Globals.audit_fudge_chance)
			Globals.audited_minerals += random.randi_range(-100 * Globals.audit_fudge_chance, 100 * Globals.audit_fudge_chance)
			Globals.audited_alloys += random.randi_range(-100 * Globals.audit_fudge_chance, 100 * Globals.audit_fudge_chance)
			# Make sure that the user can never see a negative value
			Globals.audited_funds = maxi(0, Globals.audited_funds)
			Globals.audited_life_support = maxi(0, Globals.audited_life_support)
			Globals.audited_fuel = maxi(0, Globals.audited_fuel)
			Globals.audited_minerals = maxi(0, Globals.audited_minerals)
			Globals.audited_alloys = maxi(0, Globals.audited_alloys)
		Globals.audit_fudge_chance += Globals.audit_fudge_chance_increase
	Signals.pre_tick.emit(Globals.DAY)

func post_tick() -> void:
	# Handle all processes that need to be done once the day (tick) ends
	# Typically this would be "causes", so stuff like determining whether or not
	# to start a dust storm would go here, or stuff like currency calculation.
	print("Post tick, day " + str(Globals.DAY))
	var random = RandomNumberGenerator.new()
	random.randomize()
	Globals.resupply_time -= 1
	Globals.marsquake_chance += Globals.marsquake_chance_increase
	# Check if marsquake needs to happen
	if random.randf() <= Globals.marsquake_chance:
		# Send marsquake event
		Signals.screen_shake.emit(1)
		Globals.marsquake_chance = 0.0 # Reset chance
	Signals.post_tick.emit(Globals.DAY)

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
		Enums.DomeTypeEnum.CONTROL_CENTER: 1.0,
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
		Enums.DomeTypeEnum.CONTROL_CENTER: 1.0,
	}
	Globals.funds = 100
	Globals.life_support = 100
	Globals.fuel = 100
	Globals.minerals = 0
	Globals.alloys = 100
	Globals.audited_funds = Globals.funds
	Globals.audited_life_support = Globals.life_support
	Globals.audited_fuel = Globals.fuel
	Globals.audited_minerals = Globals.minerals
	Globals.audited_alloys = Globals.alloys
	
	Globals.act = 1
	Globals.resupply_time = Constants.RESUPPLY_TIMES[Globals.act - 1]

func _on_game_ticker_timeout() -> void:
	# Tick the game every time the timer times out
	# Say that five times as fast
	tick_game()
	ticker_node.wait_time = Globals.SECONDS_PER_TICK

extends Node

@onready var ticker_node = get_node("GameTicker")

func _ready() -> void:
	init_game()

func tick_game() -> void:
	# Call this function to advance the game by one day (tick)
	# This is called by the timer every timeout
	post_tick()
	pre_tick()

func pre_tick() -> void:
	# Handle all processes that need to be done before the day (tick) begins
	# Typically this would be the "effects", so setting whether certain tiles
	# are enabled or not would probably fall under here.
	print("Pre tick, day " + str(Globals.DAY))
	pass

func post_tick() -> void:
	# Handle all processes that need to be done once the day (tick) ends
	# Typically this would be "causes", so stuff like determining whether or not
	# to start a dust storm would go here, or stuff like currency calculation.
	print("Post tick, day " + str(Globals.DAY))
	Globals.DAY += 1
	pass

func init_game() -> void:
	# Game initialization stuff here
	ticker_node.wait_time = Globals.SECONDS_PER_TICK
	ticker_node.start()

func _on_game_ticker_timeout() -> void:
	# Tick the game every time the timer times out
	# Say that five times as fast
	tick_game()
	ticker_node.wait_time = Globals.SECONDS_PER_TICK

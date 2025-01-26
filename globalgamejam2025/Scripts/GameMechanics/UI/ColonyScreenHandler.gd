extends Node2D

@onready var bidder_screen = $BiddingScreen
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Signals.show_bidder.connect(show_bidder_screen)
	Signals.hide_bidder.connect(hide_bidder_screen)
	
func show_bidder_screen(building_type: Enums.DomeTypeEnum, corp_type: Enums.DomeCorpsEnum):
	bidder_screen.visible = true
	
func hide_bidder_screen():
	bidder_screen.visible = false

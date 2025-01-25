extends Node

@onready var day_label = $TopBarBasePanel/TopBarContainer/MarginContainer2/CenterContainer/DayLabel
@onready var funds_label = $TopBarBasePanel/TopBarContainer/ResourceMarginContainer/ResourceCenterContainer/VBoxContainer/ResourceTopRow/Funds/FundsLabel
@onready var alloys_label = $TopBarBasePanel/TopBarContainer/ResourceMarginContainer/ResourceCenterContainer/VBoxContainer/ResourceTopRow/Alloys/AlloysLabel
@onready var life_support_label = $"TopBarBasePanel/TopBarContainer/ResourceMarginContainer/ResourceCenterContainer/VBoxContainer/ResourceTopRow/Life Support/LifeSupLabel"
@onready var resources_label = $TopBarBasePanel/TopBarContainer/ResourceMarginContainer/ResourceCenterContainer/VBoxContainer/ResourceBottomRow/Minerals/ResLabel
@onready var fuel_label = $TopBarBasePanel/TopBarContainer/ResourceMarginContainer/ResourceCenterContainer/VBoxContainer/ResourceBottomRow/Fuel/FuelLabel

func _ready() -> void:
	pass

func _physics_process(_delta: float) -> void:
	day_label.text = "Day %d" % Globals.DAY
	# TODO: Fudge these numbers up for the audit!
	funds_label.text = str(Globals.funds)
	alloys_label.text = str(Globals.alloys)
	life_support_label.text = str(Globals.life_support)
	resources_label.text = str(Globals.minerals)
	fuel_label.text = str(Globals.fuel)

extends Node

@onready var day_label = $TopBarBasePanel/TopBarContainer/MarginContainer2/CenterContainer/DayLabel
@onready var funds_label = $TopBarBasePanel/TopBarContainer/ResourceMarginContainer/ResourceCenterContainer/VBoxContainer/ResourceTopRow/Funds/FundsLabel
@onready var alloys_label = $TopBarBasePanel/TopBarContainer/ResourceMarginContainer/ResourceCenterContainer/VBoxContainer/ResourceTopRow/Alloys/AlloysLabel
@onready var life_support_label = $"TopBarBasePanel/TopBarContainer/ResourceMarginContainer/ResourceCenterContainer/VBoxContainer/ResourceTopRow/Life Support/LifeSupLabel"
@onready var resources_label = $TopBarBasePanel/TopBarContainer/ResourceMarginContainer/ResourceCenterContainer/VBoxContainer/ResourceBottomRow/Minerals/ResLabel
@onready var fuel_label = $TopBarBasePanel/TopBarContainer/ResourceMarginContainer/ResourceCenterContainer/VBoxContainer/ResourceBottomRow/Fuel/FuelLabel
@onready var resupply_label = $TopBarBasePanel/TopBarContainer/MarginContainer3/CenterContainer/HBoxContainer/ResupplyCounterLabel

func _ready() -> void:
	pass

func _physics_process(_delta: float) -> void:
	day_label.text = "Day %d" % Globals.DAY
	funds_label.text = str(Globals.audited_funds)
	alloys_label.text = str(Globals.audited_alloys)
	life_support_label.text = str(Globals.audited_life_support)
	resources_label.text = str(Globals.audited_minerals)
	fuel_label.text = str(Globals.audited_fuel)
	resupply_label.text = str(Globals.resupply_time)

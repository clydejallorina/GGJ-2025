extends Control


@onready var cost_label = $MarginContainer/VBoxContainer/CenterContainer/HBoxContainer/CostLabel
@onready var corp_name = $CenterContainer/CorpName
@onready var description = $MarginContainer/VBoxContainer/Description
@onready var corp_logo_container = $CorpLogoContainer
@onready var hire_button = $HireButtonContainer/HireButton

var _building_type: Enums.DomeTypeEnum
var _corp_type: Enums.DomeCorpsEnum

func _ready():
	hire_button.button_down.connect(process_hire)
	
func set_everything(cost_label: String, name: String, description: String, logo: String):
	set_cost_label(cost_label)
	set_corp_name(name)
	set_description(description)
	set_logo(logo)

# TODO: decouple the build data from hiring
func set_build_data(building_type: Enums.DomeTypeEnum, corp_type: Enums.DomeCorpsEnum):
	_building_type = building_type
	_corp_type = corp_type
	
func set_cost_label(inp_label) -> void:
	cost_label.text = inp_label;

func set_description(inp_description: String) -> void:
	description.text = inp_description
	
func set_corp_name(inp_corp_name: String) -> void:
	corp_name.text = inp_corp_name

func set_logo(logo_id: String) -> void:
	make_logo_invisible()
	match (logo_id):
		"corp1":
			corp_logo_container.get_child(0).visible = true
		"corp2":
			corp_logo_container.get_child(1).visible = true
		"corp3":
			corp_logo_container.get_child(2).visible = true
		"corp4":
			corp_logo_container.get_child(3).visible = true
		"corp5":
			corp_logo_container.get_child(4).visible = true
		_: 
			pass

func make_logo_invisible():
	for child in corp_logo_container.get_children():
		child.visible = false

func process_hire():
	Signals.hide_bidder.emit()
	Signals.build_dome.emit(_building_type, _corp_type)

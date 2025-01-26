extends Control


@onready var cost_label = $MarginContainer/VBoxContainer/CenterContainer/HBoxContainer/CostLabel
@onready var corp_name = $CenterContainer/CorpName
@onready var description = $MarginContainer/VBoxContainer/Description
@onready var corp_logo_container = $CorpLogoContainer


func set_everything(cost_label: String, name: String, description: String, logo: String):
	set_cost_label(cost_label)
	set_corp_name(name)
	set_description(description)
	set_logo(logo)
	
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

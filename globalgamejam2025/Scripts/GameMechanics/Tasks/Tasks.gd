class_name Tasks
extends Node

const Task = preload("res://Scripts/GameMechanics/Tasks/Task.gd")
@onready var DomeHandler = get_parent().get_node("DomeHandler")

var tasks: Dictionary = {}

func _ready() -> void:
	tasks = {
		Enums.Task.E_STOCKPILE_500_LIFE_SUPPORT: Task.new(
			Enums.Task.E_STOCKPILE_500_LIFE_SUPPORT,
			Enums.TaskAffiliation.EARTH,
			func x(): Globals.audited_life_support >= 500,
		),
		Enums.Task.E_STOCKPILE_500_ALLOYS: Task.new(
			Enums.Task.E_STOCKPILE_500_ALLOYS,
			Enums.TaskAffiliation.EARTH,
			func x(): Globals.audited_alloys >= 500,
		),
		Enums.Task.E_INCOME_100_MINERALS: Task.new(
			Enums.Task.E_INCOME_100_MINERALS,
			Enums.TaskAffiliation.EARTH,
			func x(): false, # TODO: This
		),
		Enums.Task.E_INCOME_50_LIFE_SUPPORT_50_ALLOYS: Task.new(
			Enums.Task.E_INCOME_50_LIFE_SUPPORT_50_ALLOYS,
			Enums.TaskAffiliation.EARTH,
			func x(): false, # TODO: This
		),
		Enums.Task.E_BUILD_2_DOMES: Task.new(
			Enums.Task.E_BUILD_2_DOMES,
			Enums.TaskAffiliation.EARTH,
			func x(): DomeHandler.flatten_grid().size() >= 3,
		),
		Enums.Task.E_REPAIR_DOMES: Task.new(
			Enums.Task.E_REPAIR_DOMES,
			Enums.TaskAffiliation.EARTH,
			func x(): DomeHandler.flatten_grid().filter(func y(dome): dome.status == Enums.DomeStatusEnum.COLLAPSED).size() == 0,
		),
	}
	Signals.post_tick.connect(check_task_completion)

func check_task_completion() -> void:
	for task in Globals.active_tasks:
		var t = tasks[task]
		if t.check_completion():
			Signals.task_finished.emit(task)
			Globals.active_tasks.erase(task)
			Globals.finished_tasks.append(task)
			if t.next_task != Enums.Task.NONE:
				# Append new task to active tasks list
				Globals.active_tasks.append(t.next_task)

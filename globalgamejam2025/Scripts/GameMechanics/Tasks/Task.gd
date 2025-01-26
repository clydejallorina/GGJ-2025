class_name Task
extends Node

@export var task_name: Enums.Task
@export var affiliation: Enums.TaskAffiliation
@export var completion_check: Callable
@export var next_task: Enums.Task = Enums.Task.NONE

func _init(
	init_task_name: Enums.Task,
	init_affiliation: Enums.TaskAffiliation,
	init_completion_check: Callable,
	init_next_task: Enums.Task = Enums.Task.NONE,
):
	self.task_name = init_task_name
	self.affiliation = init_affiliation
	self.completion_check = init_completion_check
	self.next_task = init_next_task

func check_completion() -> bool:
	if not self.completion_check:
		printerr("Completion check failed: completion_check is Nil!")
		return false
	print("Completion Check: ", self.completion_check.call())
	return self.completion_check.call()

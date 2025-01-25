# Data class for holding messages/emails to be sent
extends Node
class_name Message

@export var from: String
@export var subject: String
@export var body: String
@export var action1: Callable = Callable()
@export var action2: Callable = Callable()
@export var post_read_action: Callable = Callable()

func get_email_string() -> String:
	var format = "From: %s\nSubject: %s\n---------------\n%s"
	return format % [self.from, self.subject, self.body]

func perform_action_1(args: Array) -> void:
	if args.size() != self.action1.get_argument_count():
		printerr("Could not run action1, mismatched arguments!")
		return
	self.action1.callv(args)

func perform_action_2(args: Array) -> void:
	if args.size() != self.action2.get_argument_count():
		printerr("Could not run action1, mismatched arguments!")
		return
	self.action2.callv(args)

func perform_post_read_action(args: Array) -> void:
	if args.size() != self.post_read_action.get_argument_count():
		printerr("Could not run action1, mismatched arguments!")
		return
	self.post_read_action.callv(args)

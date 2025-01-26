# Data class for holding messages/emails to be sent
extends Resource
class_name Message

@export var from: String
@export var from_email: String
@export var logo_id: String
@export var subject: String
@export var body: String
@export var action1: Callable = Callable()
@export var action2: Callable = Callable()
@export var post_read_action: Callable = Callable()

func _init(
	init_from: String,
	init_from_email: String,
	init_logo_id: String,
	init_subject: String,
	init_body: String,
	init_action1: Callable = Callable(),
	init_action2: Callable = Callable(),
	init_post_read_action: Callable = Callable(),
):
	from = init_from
	from_email = init_from_email
	logo_id = init_logo_id
	subject = init_subject
	body = init_body
	action1 = init_action1
	action2 = init_action2
	post_read_action = init_post_read_action

func get_email_content() -> Array[String]:
	# Do we need this function? These variables are visible already
	return [self.from, self.from_email, self.logo_id, self.subject, self.body]

func perform_action_1(args: Array) -> void:
	if args.size() != self.action1.get_argument_count():
		printerr("Could not run action1, mismatched arguments!")
		return
	self.action1.callv(args)

func perform_action_2(args: Array) -> void:
	if args.size() != self.action2.get_argument_count():
		printerr("Could not run action2, mismatched arguments!")
		return
	self.action2.callv(args)

func perform_post_read_action(args: Array) -> void:
	if args.size() != self.post_read_action.get_argument_count():
		printerr("Could not run post_read_action, mismatched arguments!")
		return
	self.post_read_action.callv(args)

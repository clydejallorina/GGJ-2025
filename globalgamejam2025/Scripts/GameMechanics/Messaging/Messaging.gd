extends Node

# Preload dataclasses
const Message = preload("res://Scripts/GameMechanics/Messaging/Message.gd")

func get_date() -> String:
	var current_timestamp = Globals.STARTING_DATE + (Globals.DAY * 86400)
	return Time.get_date_string_from_unix_time(current_timestamp)

func push_message_from_data(
	from: String,
	subject: String,
	body: String,
	action1: Callable = Callable(),
	action2: Callable = Callable(),
	post_read_action: Callable = Callable(),
) -> void:
	var msg = Message.new()
	msg.from = from
	msg.subject = subject
	msg.body = body
	msg.action1 = action1
	msg.action2 = action2
	msg.post_read_action = post_read_action
	Globals.message_queue.push_back(msg)
	print("Pushed ", msg.subject, " to message queue")

func push_message(msg: Message) -> void:
	Globals.message_queue.push_back(msg)
	print("Pushed ", msg.subject, " to message queue")

func pop_message_string() -> String:
	# Use this if you only want the string for said message
	var msg = Globals.message_queue.pop_front()
	if msg == null:
		printerr("No messages in queue!")
		return "--- ERROR ---\n--- No new emails ---"
	print("Popped ", msg.subject, " from message queue")
	return msg.get_email_string()

func pop_message() -> Message:
	# Use this if you want to use the entire message object
	# For example: You need to run actions from this message
	var msg = Globals.message_queue.pop_front()
	if msg == null:
		printerr("No messages in queue!")
		return null
	print("Popped ", msg.subject, " from message queue")
	return msg

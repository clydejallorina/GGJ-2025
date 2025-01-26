extends Node

func get_date() -> String:
	var current_timestamp = Globals.STARTING_DATE + (Globals.DAY * 86400)
	return Time.get_date_string_from_unix_time(current_timestamp)

func push_message_from_data(
	from: String,
	from_email: String,
	logo_id: String,
	subject: String,
	body: String,
	action1: Callable = Callable(),
	action2: Callable = Callable(),
	post_read_action: Callable = Callable(),
) -> void:
	var msg = Message.new(
		from,
		from_email,
		logo_id,
		subject,
		body,
		action1,
		action2,
		post_read_action,
	)
	push_message(msg)

func push_message(msg: Message) -> void:
	Globals.message_queue.push_front(msg)
	Globals.unread_messages += 1
	Signals.new_message.emit()
	print("Pushed ", msg.subject, " to message queue")

func read_messages() -> void:
	Globals.unread_messages = 0

# Data class for holding messages/emails to be sent
extends Node
class_name Message

@export var from: String
@export var subject: String
@export var body: String

func get_email_string() -> String:
	var format = "From: %s\nSubject: %s\n---------------\n%s"
	return format % [self.from, self.subject, self.body]

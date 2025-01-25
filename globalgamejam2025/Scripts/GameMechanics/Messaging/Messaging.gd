extends Node

# Preload dataclasses
const Message = preload("res://Scripts/GameMechanics/Messaging/Message.gd")

func get_date() -> String:
	var current_timestamp = Globals.STARTING_DATE + (Globals.DAY * 86400)
	return Time.get_date_string_from_unix_time(current_timestamp)

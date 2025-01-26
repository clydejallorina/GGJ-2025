extends Node

# Note: While we can grab the day number directly from this Globals script,
#       the GameLoop script should be the only one directly interfacing with
#       this value. The day number has been provided in these
#       signals for safety and everyone's convenience.
signal pre_tick(day_number: int)
signal post_tick(day_number: int)

# Dome related signals
signal build_dome(building_type: Enums.DomeTypeEnum, corp_type: Enums.DomeCorpsEnum)
signal destroy_dome(coordinate: Vector2i)

signal change_dome_state(coordinate: Vector2i, status: Enums.DomeStatusEnum)
signal collect_dome_income(coordinate: Vector2i)

# Camera related signals
signal screen_shake(trauma: float)

# Messaging-related signals
signal read_messages
signal read_message(message_id)
signal new_message

# Task-related signals
signal task_finished(task: Enums.Task)

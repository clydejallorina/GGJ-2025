extends Resource

@export var messages: Array[Message]

# Make sure that every parameter has a default value.
# Otherwise, there will be problems with creating and editing
# your resource via the inspector.
func _init(p_messages=[]):
	messages = p_messages

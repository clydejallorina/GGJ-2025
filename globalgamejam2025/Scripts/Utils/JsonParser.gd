extends Node

# NOTE: JSON Objects are converted into a Dictionary, but JSON data can be used
# to store Arrays, numbers, Strings and even just a boolean.
#
# Check and verify that the JSON dictionary/array
# is what you're actually expecting!

func parse_json_string(input: String) -> Variant:
	var json = JSON.new()
	var err = json.parse(input)
	if err == OK:
		return json.data
	printerr("Error parsing JSON string: ", json.get_error_message())
	return null

func parse_json_file(filepath: String) -> Variant:
	var file = FileAccess.open(filepath, FileAccess.READ)
	var content = file.get_as_text(true)
	return parse_json_string(content)

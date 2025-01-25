extends TileMapLayer

@onready var pop_sound = $PopOnClick

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		var click_global_position = get_global_mouse_position()
		var click_local_poistion = to_local(click_global_position)
		var cell_coordinates = local_to_map(click_local_poistion)
		if validate_coordinate(cell_coordinates):
			pop_sound.play()
		print(cell_coordinates)

func validate_coordinate(coordinate: Vector2i) -> bool:
	return coordinate.x in range(Globals.GRID_SIZE[0]) and \
	coordinate.y in range(Globals.GRID_SIZE[1])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

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
		if validate_location_by_coordinate(cell_coordinates):
			# EMIT EVENT OR CHECK OBJECT IN GRID: resource_collect
			pop_sound.play()
		print(cell_coordinates)

# CONNECT THIS TO AN EMITTER, PREFERRABLY ON BUILD EVENT
func create_building(building_type: Enums.DomeTypeEnum, corp_type: Enums.DomeCorpsEnum) -> void:
	var coordinate = choose_random_valid_location(building_type)

	if not validate_location_by_coordinate(coordinate):
		return

	set_cell(coordinate, building_type, Vector2i(0,0))
	Globals.GRID[coordinate.x][coordinate.y] = Dome.new(
		building_type,
		corp_type,
		coordinate,
	)

# CONNECT THIS TO AN EMITTER, PREFERRABLY ON DESTROY EVENT
func delete_building(coordinate: Vector2i) -> void:
	Globals.GRID[coordinate.x][coordinate.y] = null

func choose_random_valid_location(building_type: Enums.DomeTypeEnum) -> Vector2i:
	var coordinates = generate_coordinates_array()
	var valid_coordinates = coordinates.filter(func(coord): validate_location_by_building_type(coord, building_type))
	
	# Return an invalid coordinate
	if valid_coordinates.is_empty():
		return Vector2i(-1, -1)
	
	return valid_coordinates.pick_random()

func validate_location_by_coordinate(coordinate: Vector2i) -> bool:
	return coordinate.x in range(Globals.GRID_SIZE[0]) and \
	coordinate.y in range(Globals.GRID_SIZE[1])

func validate_location_by_building_type(coordinate: Vector2i, building_type: Enums.DomeTypeEnum) -> bool:
	# Something is already built there
	if Globals.GRID[coordinate.x][coordinate.y]:
		return false
	
	var two_by_two_buildings = [Enums.DomeTypeEnum.RESEARCH]
	# Can't place 2x2 dome: We only have research dome as a 2x2 dome
	if building_type in two_by_two_buildings and \
		(
			Globals.GRID[coordinate.x - 1][coordinate.y - 1] or \
			Globals.GRID[coordinate.x - 1][coordinate.y] or \
			Globals.GRID[coordinate.x][coordinate.y - 1]
		):
		return false

	return true
	
func generate_coordinates_array() -> Array[Vector2i]:
	var coordinates = []
	for x in range(Globals.GRID_SIZE[0]):
		for y in range(Globals.GRID_SIZE[1]):
			coordinates.append(Vector2i(x, y))
	return coordinates

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

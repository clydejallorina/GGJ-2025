extends TileMapLayer

@onready var states_overlay = $StateOverlay
var ding_sound = preload("res://Assets/Audio/pop-39222.mp3")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Signals.build_dome.connect(create_building)
	Signals.destroy_dome.connect(delete_building)
	Signals.change_dome_state.connect(change_building_state)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		var click_global_position = get_global_mouse_position()
		var click_local_poistion = to_local(click_global_position)
		var cell_coordinates = local_to_map(click_local_poistion)
		if validate_location_by_coordinate(cell_coordinates):
			var audio_utils = AudioUtils.duplicate()
			self.add_child(audio_utils)
			audio_utils.play_sound(ding_sound)
			
			# TEST CHANGE OF STATE
			var status = Enums.DomeStatusEnum.values().pick_random()
			Signals.change_dome_state.emit(cell_coordinates, status)
	
		print(cell_coordinates)

# CONNECT THIS TO AN EMITTER, PREFERRABLY ON BUILD EVENT
func create_building(building_type: Enums.DomeTypeEnum, corp_type: Enums.DomeCorpsEnum) -> void:
	var coordinate = choose_random_valid_location(building_type)

	if not validate_location_by_coordinate(coordinate):
		return

	set_cell(coordinate, Constants.BUILDING_TO_TILESET_SOURCE_MAP[building_type], Vector2i(0,0))
	Globals.GRID[coordinate.x][coordinate.y] = Dome.new(
		building_type,
		corp_type,
		coordinate,
	)

# CONNECT THIS TO AN EMITTER, PREFERRABLY ON DESTROY EVENT
func delete_building(coordinate: Vector2i = Vector2i(-1,-1)) -> void:
	var secondary_location = choose_location_with_buildings()
	
	if not validate_location_by_coordinate(secondary_location):
		return
	
	if not validate_location_by_coordinate(coordinate):
		coordinate = secondary_location
	
	erase_cell(coordinate)
	Globals.GRID[coordinate.x][coordinate.y] = null
	
func change_building_state(coordinate: Vector2i, status: Enums.DomeStatusEnum) -> void:
	if not Globals.GRID[coordinate.x][coordinate.y]:
		return
	
	Globals.GRID[coordinate.x][coordinate.y].setStatus(status)
	states_overlay.set_cell(coordinate, 0, Constants.STATE_OVERLAY_TO_TILESET_ATLAS_COORD[status])
	
func choose_location_with_buildings() -> Vector2i:
	var cells_with_buildings = []

	for x in range(Globals.GRID_SIZE[0]):
		for y in range(Globals.GRID_SIZE[1]):
			if Globals.GRID[x][y]:
				cells_with_buildings.append(Vector2i(x,y))
				
	if cells_with_buildings.is_empty():
		return Vector2i(-1, -1)
				
	return cells_with_buildings.pick_random()

func choose_random_valid_location(building_type: Enums.DomeTypeEnum) -> Vector2i:
	var coordinates = generate_coordinates_array()
	var valid_coordinates = coordinates.filter(func(coord): return validate_location_by_building_type(coord, building_type))

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

	if not validate_neighbors(coordinate, building_type):
		return false
	
	# Can't place 2x2 dome: We only have research dome as a 2x2 dome
	if Constants.TWO_BY_TWO_BUILDINGS.has(building_type) and (coordinate.x == 0 or coordinate.y == 0):
		return false

	return true
	
func validate_neighbors(coordinate: Vector2i, building_type: Enums.DomeTypeEnum) -> bool:
	if Constants.TWO_BY_TWO_BUILDINGS.has(building_type):
		return not (
			Globals.GRID[coordinate.x - 1][coordinate.y - 1] or
			Globals.GRID[coordinate.x - 1][coordinate.y] or
			Globals.GRID[coordinate.x][coordinate.y - 1]
		) and no_nearby_two_wide_domes(coordinate, true)
	else:
		return no_nearby_two_wide_domes(coordinate, false)
		
func no_nearby_two_wide_domes(coordinate: Vector2i, is_two_by_two: bool = false) -> bool:
	var valid_x_value = coordinate.x < Globals.GRID_SIZE[0] - 1
	var valid_y_value = coordinate.y < Globals.GRID_SIZE[1] - 1
	
	# At the end
	if not valid_x_value and not valid_y_value:
		return true
	
	# Has two-by-two building at right hand side
	if valid_x_value and Globals.GRID[coordinate.x + 1][coordinate.y] and Constants.TWO_BY_TWO_BUILDINGS.has(
		Globals.GRID[coordinate.x + 1][coordinate.y].type
	):
		return false
		
	# Has two-by-two building at left hand side
	if valid_y_value and Globals.GRID[coordinate.x][coordinate.y + 1] and Constants.TWO_BY_TWO_BUILDINGS.has(
		Globals.GRID[coordinate.x][coordinate.y + 1].type
	):
		return false
	
	# Has two-by-two building at the bottom
	if valid_x_value and valid_y_value and Globals.GRID[coordinate.x + 1][coordinate.y + 1] and Constants.TWO_BY_TWO_BUILDINGS.has(
		Globals.GRID[coordinate.x + 1][coordinate.y + 1].type
	):
		return false
	
	# if two by two, also check immediate sides
	if is_two_by_two:
		if valid_x_value and coordinate.y != 0 and Globals.GRID[coordinate.x + 1][coordinate.y - 1] and Constants.TWO_BY_TWO_BUILDINGS.has(
			Globals.GRID[coordinate.x + 1][coordinate.y - 1].type
		):
			return false
			
		if valid_y_value and coordinate.x != 0 and Globals.GRID[coordinate.x - 1][coordinate.y + 1] and Constants.TWO_BY_TWO_BUILDINGS.has(
			Globals.GRID[coordinate.x - 1][coordinate.y + 1].type
		):
			return false

	return true
	
func generate_coordinates_array() -> Array[Vector2i]:
	var coordinates: Array[Vector2i] = []
	for x in range(Globals.GRID_SIZE[0]):
		for y in range(Globals.GRID_SIZE[1]):
			coordinates.append(Vector2i(x, y))
	return coordinates

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

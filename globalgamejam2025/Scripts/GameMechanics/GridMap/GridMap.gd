extends Node2D

@onready var terrain = $Terrain
@onready var building = $Building

var terrain_base_mars_source_id = 0
var terrain_base_mars = Vector2i(0,0)

var building_to_tileset_source_map = {
	Enums.DomeTypeEnum.HOUSING: 1,
	Enums.DomeTypeEnum.INDUSTRIAL: null,
	Enums.DomeTypeEnum.MINING: null,
	Enums.DomeTypeEnum.LIFE_SUPPORT: 2,
	Enums.DomeTypeEnum.LUXURY: null,
	Enums.DomeTypeEnum.RESEARCH: 0,
	Enums.DomeTypeEnum.SPACE_ELEVATOR: null,
	Enums.DomeTypeEnum.WORMHOLE: null,
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	generate_terrain()
	generate_building()

func generate_terrain():
	# Build habitable area
	for x in range(Globals.GRID_SIZE[0]):
		for y in range(Globals.GRID_SIZE[1]):
			terrain.set_cell(Vector2(x,y), terrain_base_mars_source_id, terrain_base_mars)

# Can make this load from SAVE
func generate_building():
	# Randomly generate buildings for now
	var command_center_location = [Vector2i(Globals.GRID_SIZE[0] - 2, Globals.GRID_SIZE[1] - 2)]
	
	for location in command_center_location:
		building.set_cell(location, building_to_tileset_source_map[Enums.DomeTypeEnum.RESEARCH], Vector2i(0,0))

	for x in range(Globals.GRID_SIZE[0]):
		var row = []
		for y in range(Globals.GRID_SIZE[1]):
			if Vector2i(x,y) in command_center_location:
				row.append(Dome.new(Enums.DomeTypeEnum.RESEARCH, Enums.DomeCorpsEnum.CORP1, Vector2i(x,y)))
				continue
				
			if x == 1:
				if y < Globals.GRID_SIZE[1]/2:
					row.append(Dome.new(Enums.DomeTypeEnum.HOUSING, Enums.DomeCorpsEnum.CORP1, Vector2i(x,y)))
					building.set_cell(Vector2i(x,y), building_to_tileset_source_map[Enums.DomeTypeEnum.HOUSING], Vector2i(0,0))
					continue
				if y >= Globals.GRID_SIZE[1]/2:
					row.append(Dome.new(Enums.DomeTypeEnum.LIFE_SUPPORT, Enums.DomeCorpsEnum.CORP1, Vector2i(x,y)))
					building.set_cell(Vector2i(x,y), building_to_tileset_source_map[Enums.DomeTypeEnum.LIFE_SUPPORT], Vector2i(0,0))
					continue

			row.append(null)
		Globals.GRID.append(row)
	
	# CHANGE GRID CONTENT TO DOME ENTITIES
	print("GRID: ", Globals.GRID)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

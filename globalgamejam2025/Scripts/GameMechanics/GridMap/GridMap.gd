extends Node2D

var grid_size = Vector2(8,8)
@onready var terrain = $Terrain
@onready var building = $Building

var terrain_base_mars_source_id = 0
var terrain_base_mars = Vector2i(0,0)

var building_command_center_source_id = 0
var building_command_center = Vector2i(0,0)
var building_dome_source_id = 1
var building_dome = Vector2i(0,0)

# THESE ARE JUST FOR TESTS
var building_map2_source_id = 3
var building_map2_box = Vector2i(4,2)
var building_map2_half_slab = Vector2i(6,2)
var building_map2_pillar = Vector2i(7,1)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	generate_terrain()
	generate_building()

func generate_terrain():
	# Build habitable area
	for x in range(grid_size[0]):
		for y in range(grid_size[1]):
			terrain.set_cell(Vector2(x,y), terrain_base_mars_source_id, terrain_base_mars)
	
func generate_building():
	# Randomly generate buildings for now
	var command_center_location = [Vector2(0,0), Vector2(grid_size[0] - 1, grid_size[1] - 1)]
	for locaction in command_center_location:
		building.set_cell(locaction, building_command_center_source_id, building_command_center)
	for x in range(grid_size[0]):
		var row = []
		for y in range(grid_size[1]):
			if Vector2(x,y) in command_center_location:
				row.append(building_command_center_source_id)
				continue
			
			building.set_cell(Vector2(x,y), building_dome_source_id, building_dome)
			row.append(building_dome_source_id)
			
		Globals.GRID.append(row)
	
	# CHANGE GRID CONTENT TO DOME ENTITIES
	print("GRID: ", Globals.GRID)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

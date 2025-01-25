extends Node2D

var grid_size = Vector2(8,8)
@onready var terrain = $Terrain
@onready var building = $Building

var terrain_source_id = 0
var terrain_base_mars = Vector2i(5,0)
var terrain_base_habitable = Vector2i(4,1)

var building_source_id = 0
var building_box = Vector2i(4,2)
var building_half_slab = Vector2i(6,2)
var building_pillar = Vector2i(7,1)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	generate_terrain()
	generate_building()

func generate_terrain():
	# Build habitable area
	for x in range(grid_size[0]):
		for y in range(grid_size[1]):
			terrain.set_cell(Vector2(x,y), terrain_source_id, terrain_base_habitable)
	
func generate_building():
	# Randomly generate buildings for now
	for x in range(grid_size[0]):
		for y in range(grid_size[1]):
			var row = []
			
			# place pillar, so just we where x and y are defined
			if x == 0:
				row.append(building_pillar)
				building.set_cell(Vector2(x,y), building_source_id, building_pillar)
				continue
			
			var choices = [
				building_box, building_half_slab
			]
			
			var rng = RandomNumberGenerator.new()
			var choice = choices[rng.randi_range(0,choices.size() - 1)]
			row.append(choice)
			building.set_cell(Vector2(x,y), building_source_id, choice)
			
			Globals.GRID.append(row)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

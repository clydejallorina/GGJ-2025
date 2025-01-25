extends Node2D

@onready var terrain = $Terrain
@onready var building = $Building

var terrain_base_mars_source_id = 0
var terrain_base_mars = Vector2i(0,0)

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
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

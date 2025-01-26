extends Node2D

@onready var lower_terrain = $LowerTerrain
@onready var terrain = $Terrain
@onready var building = $Building
@onready var state_overlay = $"Building/StateOverlay"

var terrain_base_mars_source_ids: Dictionary = {
	"Terrain1": 0,
	"Terrain2": 1,
}

var lower_terrain_base_mars_source_id = 0
var lower_terrain_base_mars: Dictionary = {
	"Terrain1": Vector2i(4,0),
	"Terrain2": Vector2i(5,0),
	"Terrain3": Vector2i(5,1),
	"Terrain4": Vector2i(6,0),
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	generate_terrain()
	generate_building()

func generate_terrain() -> void:
	# Build habitable area
	for x in range(Globals.GRID_SIZE[0]):
		for y in range(Globals.GRID_SIZE[1]):
			terrain.set_cell(Vector2(x,y), terrain_base_mars_source_ids.values().pick_random(), Vector2i(0,0))
			
	var lower_terrain_size = 1
	for x in range(-lower_terrain_size + 1, Globals.GRID_SIZE[0] + lower_terrain_size + 1):
		for y in range(-lower_terrain_size + 1, Globals.GRID_SIZE[1] + lower_terrain_size + 1):
			if x in range(Globals.GRID_SIZE[0]) and y in range(Globals.GRID_SIZE[1]):
				continue
			lower_terrain.set_cell(Vector2(x, y), lower_terrain_base_mars_source_id, lower_terrain_base_mars.values().pick_random())

# Can make this load from SAVE
func generate_building() -> void:
	var command_center_location = Vector2i(1,1)
	var dome = Dome.new(
		Enums.DomeTypeEnum.CONTROL_CENTER,
		Enums.DomeCorpsEnum.CORP1,
		command_center_location
	)
	
	dome.setStatus(Enums.DomeStatusEnum.IDLE)
	Globals.GRID[command_center_location.x][command_center_location.y] = dome
	
	building.set_cell(command_center_location, Constants.BUILDING_TO_TILESET_SOURCE_MAP[Enums.DomeTypeEnum.CONTROL_CENTER], Vector2i(0,0))
	state_overlay.set_cell(command_center_location, 0, Constants.STATE_OVERLAY_TO_TILESET_ATLAS_COORD[
		Enums.DomeStatusEnum.IDLE
	])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

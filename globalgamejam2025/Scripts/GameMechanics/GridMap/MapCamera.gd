extends Camera2D

var dragging = false
var last_mouse_position = Vector2()
var cell_size_in_px = 32

# Define camera boundaries
var camera_bounds = Rect2(Vector2(0, 0), Vector2(
	cell_size_in_px * Globals.GRID_SIZE[0],
	cell_size_in_px * Globals.GRID_SIZE[1],
))  # (x, y, width, height)

var min_zoom = 0.5
var max_zoom = 2.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position = Vector2(
		cell_size_in_px * (Globals.GRID_SIZE[0] / 4),
		cell_size_in_px * (Globals.GRID_SIZE[1] / 4),
	)
	
	zoom = Vector2(
		min_zoom + (max_zoom - min_zoom) / (Globals.GRID_SIZE[0] / 8),
		min_zoom + (max_zoom - min_zoom) / (Globals.GRID_SIZE[1] / 8),
	)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_mouse_button_pressed(MouseButton.MOUSE_BUTTON_LEFT) and not dragging:
		dragging = true
		last_mouse_position = get_global_mouse_position()

	elif not Input.is_mouse_button_pressed(MouseButton.MOUSE_BUTTON_LEFT) and dragging:
		dragging = false

	if dragging:
		var delta_position = get_global_mouse_position() - last_mouse_position
		position -= delta_position

		# Constrain the camera position within the defined bounds
		position.x = clamp(position.x, -camera_bounds.size.x, camera_bounds.size.x)
		position.y = clamp(position.y, -camera_bounds.size.y, camera_bounds.size.y)

		last_mouse_position = get_global_mouse_position()

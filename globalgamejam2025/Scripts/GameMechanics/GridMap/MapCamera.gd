extends Camera2D

var dragging = false
var last_mouse_position = Vector2()
var cell_size_in_px = 32

var decay = 0.6 #How quickly shaking will stop [0,1].
var max_offset = Vector2(100,75) #Maximum displacement in pixels.
var max_roll = 0.0 #Maximum rotation in radians (use sparingly).
var noise = FastNoiseLite.new() #The source of random values.

var noise_y = 0 #Value used to move through the noise

var trauma = 0.0 #Current shake strength
var trauma_power = 3 #Trauma exponent. Use [2,3]

# Define camera boundaries
var camera_bounds = Rect2(Vector2(0, 0), Vector2(
	cell_size_in_px * Globals.GRID_SIZE[0],
	cell_size_in_px * Globals.GRID_SIZE[1],
))  # (x, y, width, height)


var zoom_speed = Vector2(0.25,0.25)
var min_zoom = 1
var max_zoom = 3.5

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
	
	randomize()
	noise.seed = randi()
	
	Signals.screen_shake.connect(add_trauma)
	
func add_trauma(amount : float):
	trauma = min(trauma + amount, 1.0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Deals with screen dragging
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

	# For zooming
	if Input.is_action_just_released("wheel_down"):
		zoom += zoom_speed
	if Input.is_action_just_released("wheel_up"):
		zoom -= zoom_speed

	zoom = Vector2(
		clampf(zoom.x, min_zoom, max_zoom),
		clampf(zoom.y, min_zoom, max_zoom),
	)
	
	# Deals with screen shake (for catastrophic events)
	if trauma:
		trauma = max(trauma - decay * delta, 0)
		shake()

	#optional
	elif offset.x != 0 or offset.y != 0 or rotation != 0:
		lerp(offset.x,0.0,1)
		lerp(offset.y,0.0,1)
		lerp(rotation,0.0,1)
				
func shake() -> void: 
	var amount = pow(trauma, trauma_power)
	noise_y += 1
	rotation = max_roll * amount * noise.get_noise_2d(0, noise_y)
	offset.x = max_offset.x * amount * noise.get_noise_2d(1000, noise_y)
	offset.y = max_offset.y * amount * noise.get_noise_2d(2000, noise_y)

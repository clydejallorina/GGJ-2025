extends TextureButton

@export var dome_type: Enums.DomeTypeEnum

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.button_down.connect(emit_build_dome)
	
func emit_build_dome():
	Signals.show_bidder.emit(dome_type, Enums.DomeCorpsEnum.CORP1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

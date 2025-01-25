extends Node

# Dome related signals
signal build_dome(building_type: Enums.DomeTypeEnum, corp_type: Enums.DomeCorpsEnum)
signal destroy_dome(coordinate: Vector2i)

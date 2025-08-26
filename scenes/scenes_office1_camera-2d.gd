extends Camera2D

@export var PLAYING_FIELD : TileMapLayer

func set_limits() -> void:
	var limits = PLAYING_FIELD.get_used_rect()
	limit_left = limits.position.x * 16
	limit_right = limits.end.x * 16
	limit_top = limits.position.y * 16
	limit_bottom = limits.end.y * 16

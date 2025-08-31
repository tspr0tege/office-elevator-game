extends Node

enum DIFFICULTY_SETTINGS {EASY, MEDIUM, HARD}
var DIFFICULTY = DIFFICULTY_SETTINGS.MEDIUM

const OFFICE1_TIME_LIMITS := [420, 300, 180]

func set_difficulty(level: int) -> void:
	DIFFICULTY = level

extends MarginContainer

signal time_expired

var time_left = Data.OFFICE1_TIME_LIMITS[Data.DIFFICULTY]

func _ready() -> void:
	update_time_display()

func _on_timer_timeout() -> void:
	time_left -= 1
	update_time_display()
	if time_left <= 0:
		time_expired.emit()
		$Timer.stop()


func update_time_display() -> void:
	var minutes = time_left / 60
	var seconds = time_left % 60
	$TimeRemaining.text = "%02d:%02d" % [minutes, seconds]

extends Panel

@onready var lblTime = $labelTime

var TS = GlobalSystems.time

func _process(delta: float) -> void:
	var curr_minute = TS.current_minute
	var curr_hour = TS.current_hour
	var ampm = TS.get_twelve_hour_formatted_time()
	
	# Convert 12 AM (midnight) to 0
	if ampm == "AM" and curr_hour == 12:
		curr_hour = 0
	# Convert PM times (except 12 PM) to 24-hour format
	elif ampm == "PM" and curr_hour != 12:
		curr_hour += 12
	
	# Ensure minutes always have two digits
	var formatted_minute = str(curr_minute).pad_zeros(2)
	
	lblTime.text = str(curr_hour) + ":" + formatted_minute + ampm

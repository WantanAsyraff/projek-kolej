extends Label

var calendar = time_system.new()

@onready var lbltmp = $"."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	date()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	date()
	if Input.is_action_just_pressed("debug_increments"):
		#calendar.update_day()
		calendar.update_time(10, 0)

func date():
	var diw = calendar.read_day_in_week()
	var ampm = calendar.get_twelve_hour_formatted_time()
	lbltmp.text = "DATE: " + str(diw, calendar.current_day, calendar.read_month()) + "\nTIME: "+ str(calendar.current_hour) + ":" + str(calendar.current_minute) + ampm

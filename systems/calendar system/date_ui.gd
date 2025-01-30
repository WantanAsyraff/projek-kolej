extends Panel

@onready var lblDate = $labelDate

var CS = GlobalSystems.time

var curr_day = CS.current_day
var curr_month = CS.current_month
var curr_year = CS.current_year

func _process(_delta: float) -> void:
	var diw = CS.read_day_in_week()
	lblDate.text = diw + ", " + str(curr_day) + " " + CS.read_month() + " " + str(curr_year)

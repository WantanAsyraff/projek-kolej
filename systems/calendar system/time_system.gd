extends Node

#Calendar system
var current_day: int = 1
var current_month: int = 1
var current_year: int = 2025

#Hour system
var minute: int = 0
var hour: int = 0
var ampm: String #AM is default

"""
func _ready() -> void:
	var t = read_day_in_week()
	print(current_day, t, read_month(), current_year)
	var am = get_twelve_hour_formatted_time()
	print(str(hour) + ":" + str(minute) + am)
"""

#Consider for leap year in february (28th and 29th)
func check_leap_year(year: int) -> bool:
	#If it's divisible by 4 or 400; Consider for years divisible by 100 because these years had too
	#Many leap years accumulating
	return (year % 4 == 0 and year % 100 !=0) or (year % 400 == 0)

#Update the days in month if there is a leap year
func days_in_months(year: int):
	var days_in_months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 ]
	if check_leap_year(current_year):
		days_in_months[1] = 29
	return days_in_months

#Update the time
func update_time(minute: int, hour: int):
	if minute > 60:
		minute = 0
		hour += 1
	
	if hour >= 12:
		hour = 0
		increment_day(current_day, current_month, current_year)

func get_twelve_hour_formatted_time() -> String:
	ampm = "AM" # Default
	var display_hour = hour
	
	if display_hour == 0:
		display_hour = 12
		ampm = "AM"
	elif display_hour == 12:
		ampm = "PM"
	elif display_hour > 12:
		display_hour -= 12
		ampm = "PM"
	return ampm

#Update to next day
func increment_day(day: int, month: int, year: int):
	var day_months = days_in_months(current_year)
	current_day += 1
	
	if current_day > day_months[current_month - 1]:
		current_day = 1
		current_month += 1
	
	if current_month > 12:
		current_month = 1
		current_year += 1

#Set the actual month with key value
func read_month():
	if current_month == 1:
		return "January"
	elif current_month == 2:
		return "February"
	elif current_month == 3:
		return "March"
	elif current_month == 4:
		return "April"
	elif current_month == 5:
		return "May"
	elif current_month == 6:
		return "June"
	elif current_month == 7:
		return "July"
	elif current_month == 8:
		return "August"
	elif current_month == 9:
		return "September"
	elif current_month == 10:
		return "October"
	elif current_month == 11:
		return "November"
	elif current_month == 12:
		return "December"
	else:
		return "Invalid month"

#Set the actual day with the key value
func read_day_in_week():
	var day_value: int = get_day_in_week(current_day, current_month, current_year)
	if day_value == 0:
		return "Saturday"
	elif day_value == 1:
		return "Sunday"
	elif day_value == 2:
		return "Monday"
	elif day_value == 3:
		return "Tuesday"
	elif day_value == 4:
		return "Wednesday"
	elif day_value == 5:
		return "Thrusday"
	elif day_value == 6:
		return "Friday"
	else:
		return "Invalid day!"

#Get the day of the week using Zeller's Congruence formula
func get_day_in_week(day: int, month: int, year: int) -> int:
	if month < 3:
		month += 12
		year -= 1
	var K = year % 100
	var J = year / 100
	var h = (day + int((13 * (month + 1)) / 5) + K + int(K / 4) + int(J / 4) - 2 * J) % 7
	return h #0 = Saturday, 1 = Sunday..., 6 = Friday

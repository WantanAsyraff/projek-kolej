class_name quiz_loader extends Node

"""
Row Examples:
	if rows.size() > 1:
		# Access a specific row
		var row_index = 1  # First data row
		if row_index < rows.size():
			print("Row", row_index, ":", rows[row_index])

Column Examples:
	Question Number,Question,A,B,C,D,Answer
	--- Get by index ---
	Num = get_column(0)
	Question = get_column(1)
	A = get_column(2)
	B = get_column(3)
	C = get_column(4)
	D = get_column(5)
	Answer = get_column(6)
	---------------------
"""

var path: String = "res://question sets/question_set.csv"
var rows: Array = []

func _ready() -> void:
	load_question_set()
	get_cell(1, 1)

# Acessing a single cell
func get_cell(row: int, column: int):
	if row < rows.size() and column < rows[row].size():
		print("Cell [Row", row, ", Column", column, "]:", rows[row][column])


# Load via lecturer set path
func load_question_set():
	rows = parse_question_set(path)

# parse the input 
func parse_question_set(filepath: String) -> Array:
	var file = FileAccess.open(filepath, FileAccess.READ)
	if file:
		var content = file.get_as_text()
		var lines = content.split("\n")
		var data = []
		for line in lines:
			if line.strip_edges() != "":
				data.append(line.split(","))
		return data
	else:
		print("Error opening file at " + filepath)
		return []

# Get the column from the row
func get_column(index: int) -> Array:
	var column_data = []
	for i in range(1, rows.size()):  # Skip headers at index 0
		column_data.append(rows[i][index])  # Add the column value to the array
	return column_data

# Get a column by its header
func get_column_by_name(column_name: String) -> Array:
	if rows.size() > 0:
		var headers = rows[0]
		var index = headers.find(column_name)
		if index != -1:
			return get_column(index)
		else:
			print("Error: Column name not found:", column_name)
			return []
	return []

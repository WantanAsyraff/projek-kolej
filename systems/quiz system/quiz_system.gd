class_name quiz_system extends Node

#Reference Labels
@onready var lblQuiz_dur = $panelQuiz_time/labelQuiz_duration
@onready var lblQuestions_ans = $panelQuestions_completed/labelQuestions_answered
@onready var lblQuestion_textbox = $panelQuestion/labelQuestion_textbox
@onready var lblQuiz_title = $panelQuestion/labelQuiz_title
#Reference Buttons
@onready var btnAns_A = $panelQuestion/containerQuestion_box/buttonA
@onready var btnAns_B = $panelQuestion/containerQuestion_box/buttonB
@onready var btnAns_C = $panelQuestion/containerQuestion_box/buttonC
@onready var btnAns_D = $panelQuestion/containerQuestion_box/buttonD
@onready var btn_done = $doneButton
#Load instances
var qsl = quiz_system_loader.new()
var baked_questions = qsl.load_question_set()

#We can determine the number of questions from the Question number column
var total_questions: int = qsl.rows.size() - 1
var questions_answered: int

var correct_questions: int = 0
var current_question_row: int = 1
var question_column: int = 1

#Answer processing
var question
var ans_A: String
var ans_B: String
var ans_C: String
var ans_D: String

func _ready() -> void:
	questions_answered = 0
	
	update_questions_completed()
	get_question()
	show_buttons()
	btn_done.visible = false
	
	btnAns_A.text = get_answer_A(current_question_row)
	btnAns_B.text = get_answer_B(current_question_row)
	btnAns_C.text = get_answer_C(current_question_row)
	btnAns_D.text = get_answer_D(current_question_row)

func hide_buttons():
	btnAns_A.visible = false
	btnAns_B.visible = false
	btnAns_C.visible = false
	btnAns_D.visible = false
	
func show_buttons():
	btnAns_A.visible = true
	btnAns_B.visible = true
	btnAns_C.visible = true
	btnAns_D.visible = true

func update_questions_completed():
	lblQuestions_ans.text = "Questions:" + str(questions_answered) + "/" + str(total_questions)

func next_question():
	current_question_row += 1
	questions_answered += 1
	
	get_question()
	get_answers()
	update_questions_completed()

func get_answers():
	get_answer_A(current_question_row)
	get_answer_B(current_question_row)
	get_answer_C(current_question_row)
	get_answer_D(current_question_row)

func get_question():
	if questions_answered < total_questions:
		question = qsl.get_cell(current_question_row, question_column)
		lblQuestion_textbox.text = str(question)
		
	else:
		quiz_ended()

func quiz_ended():
	hide_buttons()
	btn_done.visible = true
	lblQuestion_textbox.text = "CORRECT ANSWERS: " + str(correct_questions) + "/" + str(total_questions)

func get_answer_A(new_question: int) -> String:
	ans_A = qsl.get_cell(new_question, 2)
	btnAns_A.text = "A. " + ans_A
	return ans_A

func get_answer_B(new_question: int) -> String:
	ans_B = qsl.get_cell(new_question, 3)
	btnAns_B.text = "B. " + ans_B
	return ans_B

func get_answer_C(new_question: int) -> String:
	ans_C = qsl.get_cell(new_question, 4)
	btnAns_C.text = "C. " + ans_C
	return ans_C

func get_answer_D(new_question: int) -> String:
	ans_D = qsl.get_cell(new_question, 5)
	btnAns_D.text = "D. " + ans_D
	return ans_D

func get_correct_answer(new_question: int) -> String:
	var current_correct_answer = qsl.get_cell(new_question, 6)
	return current_correct_answer

func compare_answer(player_answer: String):
	var correct_answer = get_correct_answer(current_question_row)
	#Normalize the input
	player_answer = player_answer.strip_edges().to_upper()
	correct_answer = correct_answer.strip_edges().to_upper()
	
	print("Player answer: ", player_answer)
	print("Correct answer: ", correct_answer)
	
	if player_answer == correct_answer:
		correct_questions += 1
		print("Correct answer!", correct_answer)
	else:
		print("Incorrect answer! The answer was: ", correct_answer)

func _on_button_a_pressed() -> void:
	compare_answer("A")
	next_question()

func _on_button_b_pressed() -> void:
	compare_answer("B")
	next_question()

func _on_button_c_pressed() -> void:
	compare_answer("C")
	next_question()

func _on_button_d_pressed() -> void:
	compare_answer("D")
	next_question()


func _on_done_button_pressed() -> void:
	SceneManager.change_scene("res://temp/temp_world.tscn")
	#get_tree().change_scene_to_file("res://temp/temp_world.tscn") #Change this to an autolood previous room

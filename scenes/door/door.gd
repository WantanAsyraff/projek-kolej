extends Area2D

@export var room: PackedScene
@export var energy_cost: int
@export var minutes_taken: int
@export var hours_taken: int

var in_area: bool = false
var door_pos = position.x
var energy = GlobalSystems.energy


func _ready() -> void:
	if room:
		print("room loaded!")
	else:
		print("Room has not been initialized")

func _process(delta: float) -> void:
	check_player_in_area()

func check_player_in_area():
	if Input.is_action_just_pressed("Interact") and in_area == true:
		if energy_cost < energy.current_energy:
			
			Global_Player.current_energy -= energy_cost
			energy.take_energy(energy_cost)
			
			GlobalSystems.time.increment_time(minutes_taken, hours_taken)
			SceneManager.change_scene(room)
			#get_tree().change_scene_to_packed(room)
			print("Entered Room")
		else:
			print("Insufficient energy!")

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player_in_area"):
		print("Player entered: body called")
		in_area = true
	else:
		in_area = false

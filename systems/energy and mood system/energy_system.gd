class_name energy_system extends Node

var max_energy: int = Global_Player.max_energy
var current_energy: int = Global_Player.current_energy

func change_max_energy(energy_set: int):
	max_energy = energy_set
	return max_energy

func give_energy(energy_given: int):
	current_energy += energy_given
	if current_energy > max_energy:
		current_energy = max_energy
	return current_energy

func take_energy(energy_taken: int):
	current_energy -= energy_taken
	if current_energy < 0:
		current_energy = 0
		print("Energy depleted! Player needs rest")
	return current_energy

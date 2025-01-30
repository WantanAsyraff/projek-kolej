extends Panel

@onready var lblEnergy = $label_energy

var ES = GlobalSystems.energy
var max_energy = ES.max_energy
var current_energy = ES.current_energy


func _process(_delta: float) -> void:
	lblEnergy.text = "Energy: " + str(current_energy) + "/" + str(max_energy)

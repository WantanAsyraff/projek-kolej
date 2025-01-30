extends Node

var current_position: float
#World Positions

var quiz_tempworld: float = -800

var rooms = {
	"room_0": preload("res://temp/temp_world.tscn"),
	"room_1": preload("res://temp/RoomTemplate.tscn")
}

func get_scene(name: String) -> PackedScene:
	return rooms.get(name, null)

extends Area2D

@export var next_scene: String # Name of the scene in your room_position.gd script


func change_scene():
	var target_scene = Room_Positions.get_scene(next_scene)  # Use your autoload script
	if target_scene:
		SceneManager.change_scene(target_scene)
		print("Room loaded" + str(target_scene))
		print("Current Room: ", next_scene)
	else:
		print("Scene not found: " + next_scene)

func _on_body_entered(body):
	if body.is_in_group("player_in_area"):  # Ensure the player is in a "Player" group
		change_scene()

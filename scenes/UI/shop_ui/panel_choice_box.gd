extends Panel


@onready var btnExit = $buttonExit
var backScene = Room_Positions.get_scene("room_0")

func _on_button_exit_pressed() -> void:
	SceneManager.change_scene(backScene)

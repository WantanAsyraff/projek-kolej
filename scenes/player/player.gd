class_name player extends CharacterBody2D

@export var speed: float = 650


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	movement(Global_Player.player_moveable)


func movement(moveable: bool):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if moveable:
		var direction := Input.get_axis("ui_left", "ui_right")
		if direction:
			velocity.x = direction * speed
		else:
			velocity.x = move_toward(velocity.x, 0, speed)
	else:
		print("Player stopped")

	move_and_slide()

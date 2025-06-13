extends Node
class_name InputComponent
## Handles player directional input controls.

## This signal is emitted when the combination of inputs the player is pressing changes
## This direction is un-normalized and includes directional inputs.
signal changed_movement_direction(direction: Vector2)

var current_direction: Vector2

func _process(_delta: float):
	var new_direction = Vector2.ZERO
	if Input.is_action_pressed("move_up"):
		new_direction.y += -1

	if Input.is_action_pressed("move_down"):
		new_direction.y += 1

	if Input.is_action_pressed("move_left"):
		new_direction.x += -1

	if Input.is_action_pressed("move_right"):
		new_direction.x += 1

	if new_direction != current_direction:
		current_direction = new_direction
		changed_movement_direction.emit(current_direction)

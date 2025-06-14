extends Node
class_name MovementComponent
## This component allows objects to move around and be controlled.

## The speed to move the object
@export var max_velocity: float

var current_direction: Vector2
var moved_object: Node2D

func _ready():
	moved_object = owner as Node2D
	current_direction = Vector2.ZERO
	if not moved_object:
		push_error("MovementComponent was not a child of a Node2D")
		return

func _process(delta: float) -> void:
	# Move the object in the given direction
	var character_body := moved_object as CharacterBody2D
	# Special check to see if this is a character body, since we can just set the velocity that way.
	if character_body:
		character_body.velocity = current_direction * max_velocity
	else:
		moved_object.position += current_direction * max_velocity * delta

func move_in_direction(direction: Vector2) -> void:
	current_direction = direction.normalized()


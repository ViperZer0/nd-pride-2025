@tool
extends Node2D
class_name InteractableComponent
## An InteractableComponent adds the ability for the player to interact
## with this to any object.


## This signal is fired when the player hits the interact action while near this object.
signal interacted_with

## Whether or not the interactor is close enough to trigger an interaction or not.
var interacting_in_range: bool = false

func _ready() -> void:
	# Find all the area 2D belonging to this component and register them
	for child in find_children("*", "Area2D", false, true):
		var area := child as Area2D
		if area:
			# Set up area for detecting interactions.
			# 3 is interactable layer.
			area.set_collision_layer_value(3, true)
			# 2 is interactING layer.
			area.set_collision_mask_value(2, true)
			area.area_entered.connect(_on_area_2d_entered)
			area.area_exited.connect(_on_area_2d_exited)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and interacting_in_range:
		# Mark input as handled
		get_viewport().set_input_as_handled()
		# Fire signal
		interacted_with.emit()

func _on_area_2d_entered(_area: Area2D) -> void:
	interacting_in_range = true

func _on_area_2d_exited(_area: Area2D) -> void:
	interacting_in_range = false

## This signal runs when we modify the children of the component
func _on_children_modified(_child: Node) -> void:
	update_configuration_warnings()

## Generates warning in the editor if there are no Area2D children
func _get_configuration_warnings() -> PackedStringArray:
	var warnings = []

	if find_children("*", "Area2D", false, true).is_empty():
		warnings.append("Expected at least one Area2D child")

	return warnings

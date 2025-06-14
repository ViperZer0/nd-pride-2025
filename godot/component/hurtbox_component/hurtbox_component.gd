@tool
extends Node2D
class_name HurtboxComponent
## Used to detect when something is hurt by or has collided with a hitbox.

## Whether or not the hurtbox checks for hitboxes.
@export var monitoring: bool:
	get:
		return areas.any(func (x: Area2D): return x.monitoring)
	set(value):
		for area in areas:
			area.monitoring = value

## Whether or not other areas can check for this hurtbox.
@export var monitorable: bool:
	get:
		return areas.any(func (x: Area2D): return x.monitorable)
	set(value):
		for area in areas:
			area.monitorable = value

var areas: Array[Area2D]

## This signal fires when a hurtbox is hit by a hitbox.
## Contains the hitbox with which we collided.
signal hurtbox_hit(hitbox: HitboxComponent)

func _ready() -> void:
	child_entered_tree.connect(_on_children_modified)
	child_exiting_tree.connect(_on_children_modified)
	_find_area_children()
	for child in areas:
		var area := child as Area2D
		if area:
			area.area_entered.connect(_on_area_2d_entered)

func _find_area_children() -> void:
	var children = find_children("*", "Area2D", false, true)
	areas.assign(children)
	print(areas)

func _on_area_2d_entered(area: Area2D) -> void:
	# Do we need to do debounce here??
	# Get the hitbox to which the area belongs.
	var hitbox := area.get_parent() as HitboxComponent
	if hitbox:
		hurtbox_hit.emit(hitbox)

func _on_children_modified(_child: Node) -> void:
	_find_area_children.call_deferred()
	if Engine.is_editor_hint():
		update_configuration_warnings()

func _get_configuration_warnings() -> PackedStringArray:
	var warnings = []
	if find_children("*", "Area2D", false, true).is_empty():
		warnings.append("Expected at least one Area2D child")

	return warnings


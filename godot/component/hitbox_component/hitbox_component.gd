@tool
extends Node2D
class_name HitboxComponent
## This component is used to hit/deal damage/collide with hurtboxes.

## Stores information like how much damage the hitbox should deal and stuff.
@export var hitbox_data: HitboxData

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

signal hitbox_hit(hurtbox: HurtboxComponent)

func _ready() -> void:
	child_entered_tree.connect(_on_children_modified)
	child_exiting_tree.connect(_on_children_modified)
	_find_area_children()
	for child in areas:
		var area := child as Area2D
		if area:
			area.area_entered.connect(_on_area_2d_entered)

func _find_area_children() -> void:
	print("A")
	var children = find_children("*", "Area2D", false, true)
	areas.assign(children)
	print(areas)

func _on_area_2d_entered(area: Area2D) -> void:
	var hurtbox := area.get_parent() as HurtboxComponent
	if hurtbox:
		hitbox_hit.emit(hurtbox)

func _on_children_modified(_child: Node) -> void:
	_find_area_children.call_deferred()
	if Engine.is_editor_hint():
		update_configuration_warnings.call_deferred()

func _get_configuration_warnings() -> PackedStringArray:
	var warnings = []
	if find_children("*", "Area2D", false, true).is_empty():
		warnings.append("Expected at least one Area2D child")

	return warnings

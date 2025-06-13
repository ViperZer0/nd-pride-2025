extends Resource
class_name Dialogue

@export var dialogue_items: Array[DialogueItem]

func _init(p_dialogue_items: Array[DialogueItem] = []):
	dialogue_items = p_dialogue_items

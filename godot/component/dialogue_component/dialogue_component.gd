extends Node
class_name DialogueComponent
## This component sends dialogue boxes to the DialogueService which will handle rendering them and all that.

@export var dialogue: Dialogue

func show_dialogue():
	DialogueServiceInstance.display_dialogue(dialogue)

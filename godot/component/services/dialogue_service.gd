extends Control
class_name DialogueService

## This class is responsible for displaying dialogue!

var dialogue: Dialogue
var current_dialogue_index: int = 0

@onready var icon: TextureRect = %Icon
@onready var speaker_label: Label = %SpeakerLabel
@onready var message_label: Label = %MessageLabel
@onready var animation_player: AnimationPlayer = %AnimationPlayer

## Set up and display dialogue
func display_dialogue(p_dialogue: Dialogue) -> void:
	if p_dialogue.dialogue_items.is_empty():
		push_warning("Attempted to display a dialogue with no dialogue items!")
		return

	dialogue = p_dialogue
	current_dialogue_index = 0
	_display_dialogue_item(dialogue.dialogue_items[0])
	animation_player.play_animation("show_dialogue")

## Move to and display the next dialogue item
func move_to_next_dialogue_item() -> void:
	current_dialogue_index += 1
	if current_dialogue_index >= dialogue.dialogue_items.size():
		# Dialogue finished
		_hide_dialogue()
		dialogue = null
	else:
		# Continue to next line of dialogue
		_display_dialogue_item(dialogue.dialogue_items[current_dialogue_index])

## Hide the dialogue box when we finish it.
func _hide_dialogue() -> void:
	animation_player.play_animation("hide_dialogue")

## Display the provided dialogue item as a textbox.
func _display_dialogue_item(dialogue_item: DialogueItem) -> void:
	# Set the icon only if we have one.
	if dialogue_item.speaker_icon:
		icon.show()
		icon.texture = dialogue_item.speaker_icon
	else:
		icon.hide()

	speaker_label.text = dialogue_item.speaker_name
	message_label.text = dialogue_item.message




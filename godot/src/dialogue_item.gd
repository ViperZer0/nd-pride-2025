extends Resource
class_name DialogueItem
## Represents a single "textbox" of dialogue. An array of these make up a full dialogue!

@export var speaker_icon: Texture2D
@export var speaker_name: String
@export_multiline var message: String

func _init(p_speaker_icon = null, p_speaker_name = "", p_message = ""):
	speaker_icon = p_speaker_icon
	speaker_name = p_speaker_name
	message = p_message

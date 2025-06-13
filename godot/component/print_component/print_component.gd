extends Node
class_name PrintComponent
## This component is a debug component that prints a message to the console when invoked.

## The message to print when invoked
@export var message: String = ""

func print_message() -> void:
	print(message)


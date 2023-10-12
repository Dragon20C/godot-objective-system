extends Node

@onready var prompt_node = get_node("CanvasLayer/CenterContainer/Prompt_label")

func set_visibility_of_text(state : bool):
	prompt_node.visible = state

func set_text(text : String):
	prompt_node.text = text

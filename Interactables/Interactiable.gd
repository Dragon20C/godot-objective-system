class_name Interactable extends Node

var prompt : String = "Press E to interact"

func interacted_with():
	print("Player interacted with " + self.name)

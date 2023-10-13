extends Interactable


func _init() -> void:
	prompt = "Press E to collect the object"

func interacted_with():
	#print(self.name + " Collected.")
	queue_free()

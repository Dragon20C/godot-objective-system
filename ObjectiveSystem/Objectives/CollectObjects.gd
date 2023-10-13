class_name Objective_Collect extends Objective

signal collected_object

var total_collectable : int = 0
var collected_collectables : int = 0
var text_description = "Empty"
var total_objects : int
var objects : Node

func set_collectables(colletables : Node):
	# Get the objects
	objects = colletables
	total_objects = objects.get_children().size()
	total_collectable = total_objects
	text_description = "Collect " + str(total_collectable) + " objects, You have found " + str(collected_collectables)
	
func start_objective():
	print("Collecting objectes started!")
	system.emit_signal("update_title",Name)
	system.emit_signal("update_description",text_description)


func check_objective() -> States:
	if total_objects > objects.get_children().size():
		collected_collectables += 1
		total_objects -= 1
		print("Collected somethingw")
		text_description = "Collect " + str(total_collectable) + " objects, You have found " + str(collected_collectables)
		system.emit_signal("update_description",text_description)
	elif total_objects == 0:
		return States.Completed
		
	return States.Running

func completed_objective():
	print("Objective complete for collecting items")

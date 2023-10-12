class_name Objective_Collect extends Objective

signal collected_object

@export var total_collectable : int = 0
var collected_collectables : int = 0

func _init(_Name : String, _Discription : String) -> void:
	Name = _Name
	Discription = _Discription

func set_collectables(colletables : Node):
	var children = colletables.get_children()
	
	for i in children:
		print(i.name)

func start_objective():
	print("Collecting objectes started!")

func check_objective() -> States:
	# have logic for checking to see if the player has completed its objective
	# example for when the player has reached a location
	return States.Running

func completed_objective():
	# Have it run this when objective is done this can be used to give rewards
	# or to display some text for the player
	pass

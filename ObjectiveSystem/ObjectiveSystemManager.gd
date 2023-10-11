extends Node


@export var hud : CanvasLayer
# Holds objective nodes so we can connect them to the objective base class
# Holds the logic, its a simple state machine that checks if the objective is complete
# or not and based on the information it returns we decide what happens.
var system = Objective_System.new()

func _ready():
	# Have a setup function to config each objective
	setup()

func _process(delta):
	# does the state machine comparisions in a match statement
	system.update()

func setup():
	# Init the objectives here
	var objective_1 = Objective_Location.new("Find the pink area!","The pink area ooooh.")
	var objective_2 = Objective_Location.new("Find the green area!","green as grass.")
	var objective_3 = Objective_Location.new("Find the red area!","burn baby burn!.")
	# Set any variables to the objective
	for objective_node in get_tree().get_nodes_in_group('ObjectiveGroup'):	
		match objective_node.name:
			"PinkArea":
				objective_1.set_variables(objective_node)
			"GreenArea":
				objective_2.set_variables(objective_node)
			"RedArea":
				objective_3.set_variables(objective_node)
			_:
				print("Unset variable detected!")
	
	# Finally add the objective to the system with a specific order.
	system.add_objective(objective_1)
	system.add_objective(objective_2)
	system.add_objective(objective_3)


extends Node


@export var hud : CanvasLayer
# Holds objective nodes so we can connect them to the objective base class
# Holds the logic, its a simple state machine that checks if the objective is complete
# or not and based on the information it returns we decide what happens.
@export var ui_node : Node
var system = Objective_System.new()

func _ready():
	# Connect the system signal to the hud so we can receive the name and discription
	# of the objective.
	system.update_title.connect(hud.set_name_text)
	system.update_description.connect(hud.set_description_text)
	#system.objective_started.connect(hud.set_objective_info)
	# Have a setup function to config each objective
	setup()

func _process(delta):
	# does the state machine comparisions in a match statement
	system.update()

func _physics_process(delta: float) -> void:
	interaction_step()

func setup():
	# Init the objectives here
	var objective_1 = Objective_Location.new("Find the pink area!")
	var objective_2 = Objective_Location.new("Find the green area!")
	var objective_3 = Objective_Location.new("Find the red area!")
	var objective_4 = Objective_Collect.new("Collect paper")
	# Set any variables to the objective
	for objective_node in get_tree().get_nodes_in_group('ObjectiveGroup'):	
		match objective_node.name:
			"PinkArea":
				objective_1.set_area(objective_node)
			"GreenArea":
				objective_2.set_area(objective_node)
			"RedArea":
				objective_3.set_area(objective_node)
			"Collectables":
				objective_4.set_collectables(objective_node)
			_:
				print("Unset variable detected!")
	
	# Finally add the objective to the system with a specific order.
	#system.add_objective(objective_1)
	#system.add_objective(objective_2)
	#system.add_objective(objective_3)
	system.add_objective(objective_4)

func interaction_step():
	var ray_collider = SignalBus.player.raycast.get_collider()
	
	
	if ray_collider and ray_collider is Interactable:
		ui_node.set_visibility_of_text(true)
		ui_node.set_text(ray_collider.prompt)
		if Input.is_action_just_pressed("Interact"):
			ray_collider.interacted_with()
	else:
		ui_node.set_visibility_of_text(false)

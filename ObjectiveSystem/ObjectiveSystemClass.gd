class_name Objective_System extends Node

# Seperate signals to update the hud
signal update_description(text)
signal update_title(text)

# I havent found a use for these yet but might be useful
signal objective_started
signal objective_completed

enum States {Running,NotRunning,Completed,Done}
var objectives = []
var current_index : int = 0
var current_objective : Objective

func add_objective(obj : Objective):
	# might aswell set the system in the object here
	obj.system = self
	objectives.append(obj)

func update() -> void:
	# Inital set of the current_objective
	if current_objective == null:
		current_objective = objectives[current_index]
	
	match current_objective.Status:
		
		States.NotRunning:
			#emit_signal("objective_started",current_objective.Name,current_objective.Discription)
			emit_signal("objective_started")
			current_objective.start_objective()
			current_objective.Status = States.Running
			
		States.Running:
			current_objective.Status = current_objective.check_objective()
		
		States.Completed:
			emit_signal("objective_completed")
			current_objective.completed_objective()
			# Transitions to the done State so nothing happens when its at that state
			current_objective.Status = States.Done
			# Might need await here to display info to the player
			transition_to_next_objective()
		
	
func transition_to_next_objective():
	print("Transition to next objective")
	current_index += 1
	current_index = clamp(current_index,0,objectives.size() - 1) 
	current_objective = objectives[current_index]

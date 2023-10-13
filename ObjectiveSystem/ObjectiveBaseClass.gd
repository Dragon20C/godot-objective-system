class_name Objective extends Node

var system : Objective_System
enum States {Running,NotRunning,Completed,Done}
var Name: String
var Description: String
var Status : int = States.NotRunning
# Called when the node enters the scene tree for the first time.

func _init(_name) -> void:
	Name = _name

func start_objective():
	# Set inital variables like setting text to a objective ui element
	pass

func check_objective() -> States:
	# have logic for checking to see if the player has completed its objective
	# example for when the player has reached a location
	return States.NotRunning

func completed_objective():
	# Have it run this when objective is done this can be used to give rewards
	# or to display some text for the player
	pass

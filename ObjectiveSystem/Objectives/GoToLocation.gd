class_name Objective_Location extends Objective

var Area : Area3D
var in_area : bool = false

func set_area(_area : Area3D):
	Area = _area

func start_objective():
	Area.body_entered.connect(entered)
	system.emit_signal("update_description","This is a description text...")

func check_objective() -> States:
	if in_area:
		return States.Completed
	else:
		return States.Running

func completed_objective():
	print("Objective " + Name + " complete!")

func entered(body):
	if body is Player and Status != States.Done:
		in_area = true

extends CanvasLayer

@onready var name_node = get_node("Control/CenterContainer/VBoxContainer/Objective_Name")
@onready var discription_node = get_node("Control/CenterContainer/VBoxContainer/Objective_Discription")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("tab"):
		self.visible = true
	else:
		self.visible = false

func set_name_text(text):
	name_node.text = text

func set_description_text(text):
	discription_node.text = text

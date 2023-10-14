extends Node

var cursor_touch
var game_state:String = "world"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func battle():
	game_state = "battle"

func world():
	game_state = "world"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
#	if Input.is_action_just_pressed("1"):
#		world()
#	if Input.is_action_just_pressed("2"):
#		battle()
		pass

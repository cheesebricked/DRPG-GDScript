extends Node3D

@onready var cursor_detector := $MeshInstance3D/Area3D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if global.game_state == "world":
		if  global.cursor_touch == cursor_detector and Input.is_action_just_pressed("action"):
			global.battle()



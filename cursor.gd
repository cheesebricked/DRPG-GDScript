extends TextureRect


@onready var menu_parent_path : NodePath
@onready var menu_parent := get_node(menu_parent_path)
var adjust = 32

var menu_type = "main"

var index:int = 0
var index_min = 0
var index_max = 3
var atk_index_min = 0
var atk_index_max = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if global.game_state == "battle":
		if menu_type == "main":
			self.position.x = -11
			if index > index_max:
				index = index_min
			if index < index_min:
				index = index_max
			if index == 0:
				self.position.y = ($"../GridContainer/attack".position.y + adjust)
				$"../..".cursor_state = "attack"
			if index == 1:
				self.position.y = ($"../GridContainer/item".position.y + adjust)
				$"../..".cursor_state = "item"
			if index == 2:
				self.position.y = ($"../GridContainer/guard".position.y + adjust)
				$"../..".cursor_state = "guard"
			if index == 3:
				self.position.y = ($"../GridContainer/flee".position.y + adjust)
				$"../..".cursor_state = "flee"
		
		if menu_type == "attack_menu":
			self.position.x = 230
			if index > atk_index_max:
				index = atk_index_min
			if index < atk_index_min:
				index = atk_index_max
			if index == 0:
				self.position.y = ($"../GridContainer/attack/attack_menu/GridContainer/melee".position.y + adjust)
				$"../..".cursor_state = "melee"
			if index == 1:
				self.position.y = ($"../GridContainer/attack/attack_menu/GridContainer/magic".position.y + adjust)
				$"../..".cursor_state = "magic"

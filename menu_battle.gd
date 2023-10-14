extends Control

var cursor_state

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if global.game_state == "battle":
		self.visible = true
		
		if $menu/cursor.menu_type == "main":
			if Input.is_action_just_pressed("cancel"):
				global.game_state = "world"
			
		if cursor_state == "attack" and $menu/cursor.menu_type == "main":
			if Input.is_action_just_pressed("action"):
				$menu/cursor.menu_type = "attack_menu"
				
		if $menu/cursor.menu_type == "attack_menu":
			if Input.is_action_just_pressed("cancel"):
				$menu/cursor.menu_type = "main"
		
		if Input.is_action_just_pressed("dpad_up"):
			$menu/cursor.index -= 1
			print($menu/cursor.index)
		if Input.is_action_just_pressed("dpad_down"):
			$menu/cursor.index += 1
			
		
	else:
		self.visible = false

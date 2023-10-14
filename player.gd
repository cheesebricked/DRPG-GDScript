extends Node3D

@onready var raycast_front := $raycastFront
@onready var raycast_back := $raycastBack
@onready var raycast_left := $raycastLeft
@onready var raycast_right := $raycastRight

signal click(click)

var movespeed = 0.245
const turnspeed = 0.015

const tilesize = 2

var turning:bool = false
var can_move:bool = true
var strafing:bool = false
var walking:bool = false

var pressed = ['null']

var tween 
var sound_w

func _ready():
	init_movement()

func init_movement():
	walking = true
	tween = create_tween()
	tween.tween_property(self, "transform", transform.translated((Vector3.FORWARD).rotated(Vector3.UP, rotation.y) * 0), movespeed)
	if tween.finished:
		walking = false

func walk_sound():
#	$walk_1.play()
	pass

func forward():
	walking = true
	tween = create_tween()
	tween.tween_property(self, "transform", transform.translated((Vector3.FORWARD).rotated(Vector3.UP, rotation.y) * tilesize), movespeed)
	walk_sound()
	if tween.finished:
		walking = false
			
func backward():
	walking = true
	tween = create_tween()
	tween.tween_property(self, "transform", transform.translated((Vector3.BACK).rotated(Vector3.UP, rotation.y) * tilesize), movespeed)
	walk_sound()
	if tween.finished:
		walking = false
		
func left():
	strafing = true
	tween = create_tween()
	tween.tween_property(self, "transform", transform.translated((Vector3.LEFT).rotated(Vector3.UP, rotation.y) * tilesize), movespeed)
	walk_sound()
	if tween.finished:
		strafing = false
		
func right():
	strafing = true
	tween = create_tween()
	tween.tween_property(self, "transform", transform.translated((Vector3.RIGHT).rotated(Vector3.UP, rotation.y) * tilesize), movespeed)
	walk_sound()
	if tween.finished:
		strafing = false
	
func turn_left():
	tween.stop()
	turning = true
	can_move = false
	tween = create_tween()
	tween.tween_property(self, "transform:basis", transform.basis.rotated(Vector3.UP, PI / tilesize), movespeed - turnspeed)
	if tween.finished:
		turning = false
		can_move = true
		
func turn_right():
	tween.stop()
	turning = true
	can_move = false
	tween = create_tween()
	tween.tween_property(self, "transform:basis", transform.basis.rotated(Vector3.DOWN, PI / tilesize), movespeed - turnspeed)
	if tween.finished:
		turning = false
		can_move = true

func _physics_process(delta):
	if global.game_state == "world":
		if tween:
			if tween.is_running():
				return
		if Input.is_action_pressed('dpad_up') and !raycast_front.is_colliding():
			if !pressed[0] == 'rotate':
				forward()
		if Input.is_action_pressed('dpad_down') and !raycast_back.is_colliding():
			if !pressed[0] == 'rotate':
				backward()
		if Input.is_action_pressed('left1') and !raycast_left.is_colliding():
			if !pressed[0] == 'rotate':
				left()
		if Input.is_action_pressed('right1') and !raycast_right.is_colliding():
			if !pressed[0] == 'rotate':
				right()
		if pressed[0] == 'rotate':
			if Input.is_action_pressed('dpad_left'):
				turn_left()
			if Input.is_action_pressed('dpad_right'):
				turn_right()
		
		global.cursor_touch = raycast_front.get_collider()

func _input(event):
	if Input.is_action_just_pressed('dpad_left') or Input.is_action_just_pressed('dpad_right'):
		pressed.insert(0, 'rotate')
	if Input.is_action_just_released('dpad_left') or Input.is_action_just_released('dpad_right'):
		pressed.erase('rotate')

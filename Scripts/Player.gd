# var joy_guid = Input.get_joy_guid(0) - Pulls active device GUID as recognized by Godot
# var joy_name = Input.get_joy_name(0) - Pulls active device name as recognized by Godot
# print(joy_guid) - Prints active device GUID as recognized by Godot
# print(joy_name) - Prints active device name as recognized by Godot
# 030000004c050000e60c000000000000 - PS5 Controller (GUID)
# 0300000034120000adbe000000000000 - vJoy Device (GCC GUID)

extends CharacterBody2D

const GRAVITY = 40.0
const WALL_SLIDE_SPEED = 100.0
const MAX_JUMPS = 2
const DASH_SPEED = 80.0

var AXIS = Vector2.ZERO
@export var SPEED = 100.0
@export var JUMP_FORCE = -1000.0
@export var LEFT_WALL_JUMP_FORCE = 200.0
@export var RIGHT_WALL_JUMP_FORCE = -200.0
@export var JUMP_COUNT = 0
@export var IS_WALL_SLIDING = false
@export var MAX_DASHES = 1
@export var DASH_COUNT = 0
@export var DASHING = false



func _ready():
	set_physics_process(true)



func physics_process(delta):
	gravity()
	move()
	jump()
	wall_slide()
	dash()
	move_and_slide() # Tends to be the last thing under physics process > do after changes to velocity



func _process(delta):
	button_presses()
	reset_jump_count()



func set_deadzone(): # Sets analog stick deadzones
	InputMap.action_set_deadzone("left_stick_up", 0.275)
	InputMap.action_set_deadzone("left_stick_down", 0.275)
	InputMap.action_set_deadzone("left_stick_left", 0.275)
	InputMap.action_set_deadzone("left_stick_right", 0.275)
	InputMap.action_set_deadzone("right_stick_up", 0.275)
	InputMap.action_set_deadzone("right_stick_down", 0.275)
	InputMap.action_set_deadzone("right_stick_left", 0.275)
	InputMap.action_set_deadzone("right_stick_right", 0.275)



func move():
	var INPUT_DIR_X = Input.get_action_strength("left_stick_right") - Input.get_action_strength("left_stick_left")
	var INPUT_DIR_Y = Input.get_action_strength("left_stick_up") - Input.get_action_strength("left_stick_down")
	print(INPUT_DIR_X)
	print(INPUT_DIR_Y)
	velocity.x = (INPUT_DIR_X * SPEED)



func gravity():
	velocity.y += GRAVITY

 

func jump():
	if is_on_wall_only() and (Input.is_action_pressed("left_stick_left") and Input.is_action_just_pressed("press_a")):
		velocity.y = JUMP_FORCE
		velocity.x = LEFT_WALL_JUMP_FORCE
	elif is_on_wall_only() and (Input.is_action_pressed("left_stick_right") and Input.is_action_just_pressed("press_a")):
		velocity.y = JUMP_FORCE
		velocity.x = RIGHT_WALL_JUMP_FORCE
	elif (is_on_floor() or JUMP_COUNT < MAX_JUMPS) and Input.is_action_just_pressed("press_a"):
		velocity.y = JUMP_FORCE
		JUMP_COUNT += 1
	elif (not is_on_floor() and Input.is_action_just_released("press_a")):
		velocity.y = 0



func wall_slide():
	if is_on_wall_only() and (Input.is_action_pressed("left_stick_left") or Input.is_action_pressed("left_stick_right")):
		IS_WALL_SLIDING = true
	else:
		IS_WALL_SLIDING = false

	if IS_WALL_SLIDING and velocity.y >= 0:
		velocity.y += (WALL_SLIDE_SPEED) # Increments speed while wall sliding is true and player is falling
		velocity.y = min(velocity.y, WALL_SLIDE_SPEED) # Sets wall slide speed to the lower value of either velocity or wall slide speed



func dash():
	if DASH_COUNT < MAX_DASHES and (Input.is_action_pressed("left_stick_left") and Input.is_action_just_pressed("right_trigger")):
		velocity.x = -DASH_SPEED
	if DASH_COUNT < MAX_DASHES and (Input.is_action_pressed("left_stick_right") and Input.is_action_just_pressed("right_trigger")):
		velocity.x = DASH_SPEED



func reset_jump_count():
	if is_on_floor() and velocity.y == 0:
		JUMP_COUNT = 0
		#print("reset_jump_count")



func button_presses():
	var input_right_stick = Input.get_vector("right_stick_left", "right_stick_right", "right_stick_up", "right_stick_down")
	print(input_right_stick)
	if Input.is_action_just_pressed("dpad_up"):
		print("I am pressed")
	if Input.is_action_just_pressed("dpad_down"):
		print("I am pressed")
	if Input.is_action_just_pressed("dpad_left"):
		print("I am pressed")
	if Input.is_action_just_pressed("dpad_right"):
		print("I am pressed")
	if Input.is_action_just_pressed("left_trigger"):
		print("I am pressed")
	if Input.is_action_just_pressed("right_trigger"):
		print("I am pressed")
	if Input.is_action_just_pressed("left_bumper"):
		print("I am pressed")
	if Input.is_action_just_pressed("right_bumper"):
		print("I am pressed")
	if Input.is_action_just_pressed("press_start"):
		print("I am pressed")
	if Input.is_action_just_pressed("press_select"):
		print("I am pressed")
	if Input.is_action_just_pressed("press_a"):
		print("I am pressed")
	if Input.is_action_just_pressed("press_b"):
		print("I am pressed")
	if Input.is_action_just_pressed("press_x"):
		print("I am pressed")
	if Input.is_action_just_pressed("press_y"):
		print("I am pressed")

#func _unhandled_input(event):




































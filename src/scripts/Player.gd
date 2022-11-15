extends KinematicBody2D

const SPEED = 3000
const JUMP_POWER = 6500
const LOOSE = 40
const GRAVITY = 150
# if Double jump unlocked
const JUMPS = 2

var motion = Vector2()

# 1 = Droite; -1 = Gauche
var _facing : int = 1

func _physics_process(_delta):
	motion.y += GRAVITY
	if _facing == 1:
		if motion.x - LOOSE > 0:
			if is_on_floor():
				motion.x -= LOOSE * 4
			else:
				motion.x -= LOOSE
		else:
			motion.x = 0
	else:
		if motion.x + LOOSE < 0:
			if is_on_floor():
				motion.x += LOOSE * 4
			else:
				motion.x += LOOSE
		else:
			motion.x = 0
	
	if Input.is_action_pressed("ui_left"):
		motion.x = -SPEED
		_facing = -1
	if Input.is_action_pressed("ui_right"):
		motion.x = SPEED
		_facing = 1
	if Input.is_action_pressed("ui_up"):
		if is_on_floor():
			motion.y = -JUMP_POWER
	if Input.is_action_pressed("ui_down"):
		motion.y += round(GRAVITY / 1.5)
	motion = move_and_slide(motion, Vector2(0,-1))

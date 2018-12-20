# Simple K2D character for testing/demos
extends KinematicBody2D

signal collided

export var gravity = 2500
export var speed = 400
export var jump = -900

var jumping = false
var velocity = Vector2()

func get_input():
	velocity.x = 0
	jumping = false
	if Input.is_action_pressed('ui_right'):
		velocity.x += 1
	if Input.is_action_pressed('ui_left'):
		velocity.x -= 1
	velocity.x *= speed
	if Input.is_action_just_pressed('ui_select'):
		jumping = true
	
func _physics_process(delta):
	velocity.y += gravity * delta
	get_input()
	velocity = move_and_slide(velocity, Vector2(0, -1))
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if collision:
			emit_signal('collided', collision)

	if is_on_floor() and jumping:
		velocity.y = jump
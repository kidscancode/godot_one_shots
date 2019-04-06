extends KinematicBody2D

var speed = 250
var velocity = Vector2()
var can_shoot = true
export var beam_duration = 1.5
export var cooldown = 0.5
var hit = null
	
func _ready():
	$Line2D.remove_point(1)
	$Line2D/Particles2D.emitting = false
	
func get_input():
	velocity = Vector2()
	if Input.is_action_pressed("forward"):
		velocity += transform.x * speed
	if Input.is_action_pressed("backward"):
		velocity += -transform.x * speed
	if Input.is_action_pressed("strafe_right"):
		velocity += transform.y * speed/2
	if Input.is_action_pressed("strafe_left"):
		velocity += -transform.y * speed/2
	if Input.is_action_just_pressed("click") and can_shoot:
		shoot()
	
func shoot():
	can_shoot = false
	hit = cast_beam()
	yield(get_tree().create_timer(beam_duration), "timeout")
	$Line2D.remove_point(1)
	$Line2D/Particles2D.emitting = false
	hit = null
	yield(get_tree().create_timer(cooldown), "timeout")
	can_shoot = true
	
func cast_beam():
	var space_state = get_world_2d().direct_space_state
	var result = space_state.intersect_ray($Muzzle.global_position, $Muzzle.global_position + transform.x * 1000, [self])
	if result:
		if !hit:
			$Line2D.add_point(transform.xform_inv(result.position))
		else:
			$Line2D.set_point_position(1, transform.xform_inv(result.position))
		$Line2D/Particles2D.position = $Line2D.get_point_position(1)
		$Line2D/Particles2D.emitting = true
	return result
		
func _physics_process(delta):
	look_at(get_global_mouse_position())
	get_input()
	if position.distance_to(get_global_mouse_position()) > 25:
		velocity = move_and_slide(velocity)
	if hit:
		hit = cast_beam()

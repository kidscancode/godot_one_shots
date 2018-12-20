extends RigidBody2D

signal collided

func _integrate_forces(state):
	for i in state.get_contact_count():
		var collider = state.get_contact_collider_object(i)
		var cpos = state.get_contact_collider_position(i)
		var n = state.get_contact_local_normal(i)
		emit_signal('collided', collider, cpos, n)

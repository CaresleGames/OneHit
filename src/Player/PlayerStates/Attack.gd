class_name Attack
extends PlayerState

func enter(msg := {}) -> void:
	player.attack_collision.set_deferred("disabled", false)
	player.attack_duration.start()
	player.anim.play("Attack")
	print("Attack")


func physics_update(_delta: float) -> void:
	if not player.is_alive:
		state_machine.transition_to("Death")
	
	if player.attack_duration.is_stopped():
		if player.attack_animation_complete():
			state_machine.transition_to("Idle")
		
	player.get_input()
	
	if (
		is_equal_approx(player.velocity.x, 0)
		and
		player.attack_animation_complete()
	):
		print('transition')
		state_machine.transition_to("Idle")
	
	player.velocity = player.move_and_slide(player.velocity, player.ground)

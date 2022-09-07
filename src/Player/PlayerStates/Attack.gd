class_name Attack
extends PlayerState

func enter(msg := {}) -> void:
	player.attack_collision.set_deferred("disabled", false)
	player.attack_duration.start()

func physics_update(_delta: float) -> void:
	if player.attack_duration.is_stopped():
		state_machine.transition_to("Idle")
		
	player.get_input()
	
	if is_equal_approx(player.velocity.x, 0):
		state_machine.transition_to("Idle")
	
	player.velocity = player.move_and_slide(player.velocity, player.ground)

class_name Idle
extends PlayerState

func enter(msg := {}) -> void:
	print('Enter idle')


func physics_update(_delta: float) -> void:
	player.get_input()
	if player.velocity.x != 0:
		state_machine.transition_to("Run")
	
	player.velocity = player.move_and_slide(player.velocity, player.ground)

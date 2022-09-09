class_name Idle
extends PlayerState

func enter(msg := {}) -> void:
	player.anim.play("Idle")


func physics_update(_delta: float) -> void:
	if not player.is_alive:
		state_machine.transition_to("Death")
	
	player.get_input()
	if player.velocity.x != 0:
		state_machine.transition_to("Run")
	
	player.velocity = player.move_and_slide(player.velocity, player.ground)
	
	if Input.is_action_just_pressed("ui_attack"):
		state_machine.transition_to("Attack")

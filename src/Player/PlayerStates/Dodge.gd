class_name Dodge
extends PlayerState

export var collision_path : NodePath

# The hit box that detect the enemy atacks inside the player
var collision : CollisionShape2D

func _ready() -> void:
	collision = get_node(collision_path)


func enter(msg := {}) -> void:
	print("Dodge state")
	collision.set_deferred("disabled", true)
	player.dodge_movement()


func update(_delta : float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		state_machine.transition_to("Idle")


func exit() -> void:
	collision.set_deferred("disabled", false)

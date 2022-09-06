class_name Player
extends KinematicBody2D

export var speed := 0
export var speed_acc : float = 0
export var speed_fri : float = 0

var velocity := Vector2.ZERO
var direction := 1
var ground := Vector2.UP

onready var attack_area : Area2D = $AttackArea
onready var attack_collision : CollisionShape2D = $AttackArea/CollisionShape2D
onready var attack_duration : Timer = $AttackDuration

func _ready() -> void:
	add_to_group(Groups.player)
	attack_collision.set_deferred("disabled", true)


func _physics_process(_delta: float) -> void:
	attack_area.scale.x = direction
	

func get_input() -> void:
	if Input.is_action_pressed("ui_right"):
		velocity.x = min(velocity.x + speed_acc, speed)
		direction = 1
	elif Input.is_action_pressed("ui_left"):
		velocity.x = max(velocity.x - speed_acc, -speed)
		direction = -1
	else:
		velocity.x = lerp(velocity.x, 0, speed_fri)


func _on_AttackDuration_timeout() -> void:
	attack_collision.set_deferred("disabled", true)
	attack_duration.stop()

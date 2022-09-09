class_name Player
extends KinematicBody2D

signal death()
signal pause_player()

export var speed := 0
export var speed_acc : float = 0
export var speed_fri : float = 0

export var attack_time : float = .25

var velocity := Vector2.ZERO
var direction := 1
var ground := Vector2.UP

var is_alive := true

onready var attack_area : Area2D = $AttackArea
onready var attack_collision : CollisionShape2D = $AttackArea/CollisionShape2D
onready var attack_duration : Timer = $AttackDuration

onready var sprite : Sprite = $Sprite
onready var state_machine : StateMachine = $StateMachine

func _ready() -> void:
	add_to_group(Groups.player)
	attack_collision.set_deferred("disabled", true)
	attack_duration.wait_time = attack_time
	
	connect("death", self, "_on_player_death")
	connect("pause_player", self, "_on_pause_player")


func _physics_process(_delta: float) -> void:
	attack_area.scale.x = direction
	sprite.scale.x = direction

func get_input() -> void:
	if is_alive:
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


func _on_AttackArea_area_entered(area: Area2D) -> void:
	print('Hit the weak point of enemy')
	var parent : Enemy = area.get_parent()
	parent.emit_signal("death")


func _on_player_death() -> void:
	is_alive = false
	GameManager.emit_signal("round_end", "Lose")


func _on_pause_player() -> void:
	state_machine.transition_to("PauseState")

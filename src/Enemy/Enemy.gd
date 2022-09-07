class_name Enemy
extends KinematicBody2D

signal death()

export var attack_time : float = .15
export var check_player_time : float = .5

export var speed := 0
export var speed_acc : float = 0
export var speed_fri : float = 0

var direction := -1
var velocity = Vector2.ZERO
var is_alive := true

onready var attack_area : Area2D = $AttackArea
onready var attack_collision : CollisionShape2D = $AttackArea/CollisionShape2D
onready var attack_duration : Timer = $AttackDuration

onready var check_player : Timer = $CheckPlayer

func _ready() -> void:
	add_to_group(Groups.enemy)
	connect("death", self, "_on_enemy_death")
	
	attack_duration.wait_time = attack_time
	check_player.wait_time = check_player_time
	
	attack_collision.set_deferred("disabled", true)


func _physics_process(_delta: float) -> void:
	if is_alive:
		velocity = move_and_slide(velocity, Vector2.UP)


func _on_enemy_death() -> void:
	is_alive = false
	modulate = Color(125, 255, 255)


func _on_Timer_timeout() -> void:
	attack_collision.set_deferred("disabled", true)
	attack_duration.stop()


func _on_AttackArea_area_entered(area: Area2D) -> void:
	var parent = area.get_parent()
	parent.emit_signal("death")


func _on_Movement_body_entered(body: KinematicBody2D) -> void:
	check_player.start()


func _on_CheckPlayer_timeout() -> void:
	if not is_alive:
		return
	var players = get_tree().get_nodes_in_group(Groups.player)
	if players.size() > 0:
		var player : KinematicBody2D = players[0]
		direction = sign(player.global_position.x - global_position.x)
		
		if direction > 0:
			velocity.x = speed
			scale.x = 1
		else:
			velocity.x = -speed
			scale.x = -1


func _on_Movement_body_exited(body: Node) -> void:
	if body.is_in_group(Groups.player):
		check_player.stop()

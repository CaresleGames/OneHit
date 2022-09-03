class_name Player
extends KinematicBody2D

signal hit_wall()

export var speed := 0
export var speed_acc : float = 0
export var speed_fri : float = 0
export var dodge_time : float = 0
# The value that will be added to the position
export var dodge_increase : float = 0

var velocity := Vector2.ZERO
var direction := 1
var ground := Vector2.UP

var dodge_increase_init : float = 0
var raycast_length := 32
onready var tween : Tween = $Tween
onready var ray_dodge : RayCast2D = $DodgeChecker

func _ready() -> void:
	add_to_group(Groups.player)
	ray_dodge.cast_to = Vector2(raycast_length, 0)
	dodge_increase_init = dodge_increase
	connect("hit_wall", self, "_on_hit_wall")

func _physics_process(_delta: float) -> void:
	ray_dodge.force_raycast_update()
	ray_dodge.cast_to = Vector2(raycast_length * direction, 0)
	if ray_dodge.is_colliding():
		emit_signal("hit_wall")

func get_input() -> void:
	if Input.is_action_pressed("ui_right"):
		velocity.x = min(velocity.x + speed_acc, speed)
		direction = 1
	elif Input.is_action_pressed("ui_left"):
		velocity.x = max(velocity.x - speed_acc, -speed)
		direction = -1
	else:
		velocity.x = lerp(velocity.x, 0, speed_fri)
	

func dodge_interpolate() -> void:
	var d := 0
	if dodge_increase == dodge_increase_init:
		d = dodge_increase_init
		tween.interpolate_property(
			self, "position", position,
			Vector2(position.x + d * direction, position.y),
			dodge_time, Tween.TRANS_LINEAR, Tween.EASE_IN
		)
	else:
		d = dodge_increase
		tween.interpolate_property(
			self, "position", position,
			Vector2(position.x + d, position.y),
			dodge_time, Tween.TRANS_LINEAR, Tween.EASE_IN
		)
	
	tween.start()


func _on_hit_wall() -> void:
	var point: Vector2 = ray_dodge.get_collision_point()
	dodge_increase = point.x - position.x

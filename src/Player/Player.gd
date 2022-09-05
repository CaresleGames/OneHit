class_name Player
extends KinematicBody2D

export var speed := 0
export var speed_acc : float = 0
export var speed_fri : float = 0
export var dodge_time : float = 0
# The value that will be added to the position
export var dodge_increase : float = 0

var velocity := Vector2.ZERO
var direction := 1
var ground := Vector2.UP
var final_position := Vector2.ZERO

onready var ray_stop : RayCast2D = $RayStop
onready var tween : Tween = $Tween
onready var pos : Position2D = $RayStop/Pos

func _ready() -> void:
	add_to_group(Groups.player)


func get_input() -> void:
	if Input.is_action_pressed("ui_right"):
		velocity.x = min(velocity.x + speed_acc, speed)
		direction = 1
	elif Input.is_action_pressed("ui_left"):
		velocity.x = max(velocity.x - speed_acc, -speed)
		direction = -1
	else:
		velocity.x = lerp(velocity.x, 0, speed_fri)


func _physics_process(_delta: float) -> void:
	ray_stop.force_raycast_update()
	ray_stop.scale.x = direction
	

func dodge_movement() -> void:
	
	if ray_stop.is_colliding():
		var colliding_point : Vector2 = ray_stop.get_collision_point()
		final_position = Vector2(colliding_point.x - global_position.x, position.y)
#		print(colliding_point.x, "--", pos.global_position.x)
	else:
		final_position = Vector2(
			position.x + dodge_increase * direction,
			position.y
		)
	tween.interpolate_property(
		self, "position", global_position, final_position,
		.25, Tween.TRANS_LINEAR, Tween.EASE_IN
	)
	tween.start()


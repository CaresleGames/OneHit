class_name Enemy
extends KinematicBody2D

signal death()

func _ready() -> void:
	add_to_group(Groups.enemy)
	connect("death", self, "_on_death")


func _on_death() -> void:
	print('ENEMY DEATHHH')

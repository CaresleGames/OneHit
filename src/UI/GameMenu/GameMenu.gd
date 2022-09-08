class_name GameMenu
extends Control

signal show_menu()
signal hide_menu()

export var previous_scene: String

onready var anim : AnimationPlayer = $Anim

func _ready() -> void:
	add_to_group(Groups.game_menu)
	connect("show_menu", self, "_on_show_menu")
	connect("hide_menu", self, "_on_hide_menu")


func _on_show_menu() -> void:
	anim.play("Show")


func _on_hide_menu() -> void:
	anim.play("Hide")


func _on_Restart_pressed() -> void:
	get_tree().reload_current_scene()


func _on_Exit_pressed() -> void:
	get_tree().change_scene(previous_scene)

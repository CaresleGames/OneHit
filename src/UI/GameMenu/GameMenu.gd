class_name GameMenu
extends Control

signal show_menu()
signal hide_menu()
signal set_status(status)

export var previous_scene: String

onready var anim : AnimationPlayer = $Anim
onready var sound_select : AudioStreamPlayer = $SelectSound
onready var sound_fush : AudioStreamPlayer = $FushSound
onready var label : Label = $CenterContainer/VBoxContainer/Label

func _ready() -> void:
	add_to_group(Groups.game_menu)
	connect("show_menu", self, "_on_show_menu")
	connect("hide_menu", self, "_on_hide_menu")
	connect("set_status", self, "_on_set_status")


func _on_show_menu() -> void:
	anim.play("Show")


func _on_hide_menu() -> void:
	anim.play("Hide")


func _on_Restart_pressed() -> void:
	_play_sound()
	get_tree().reload_current_scene()


func _on_Exit_pressed() -> void:
	_play_sound()
	get_tree().change_scene(previous_scene)


func _play_sound() -> void:
	sound_select.play()
	yield(sound_select, "finished")


func _on_Restart_mouse_entered() -> void:
	sound_fush.play()


func _on_Exit_mouse_entered() -> void:
	sound_fush.play()


func _on_set_status(status : String) -> void:
	label.text = status

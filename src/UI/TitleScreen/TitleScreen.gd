class_name TitleScreen
extends Control

export var new_game : String

onready var anim : AnimationPlayer = $AnimationPlayer
onready var sound : AudioStreamPlayer = $SelectSound


func _on_NewGame_pressed() -> void:
	sound.play()
	anim.play("FadeIn")
	yield(anim, "animation_finished")
	get_tree().change_scene(new_game)


func _on_Exit_pressed() -> void:
	get_tree().exit()

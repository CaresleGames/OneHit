extends Node

signal round_end(status)

func _ready() -> void:
	connect("round_end", self, "_on_round_end")


func _on_round_end(status: String = "") -> void:
	var hurt_sound_list = get_tree().get_nodes_in_group(Groups.hurt_sound)
	if hurt_sound_list.size() > 0:
		var hurt_sound : AudioStreamPlayer = hurt_sound_list[0]
		hurt_sound.play()
	var menu_list = get_tree().get_nodes_in_group(Groups.game_menu)
	if menu_list.size() > 0:
		var menu: GameMenu = menu_list[0]
		menu.emit_signal("show_menu")
		menu.emit_signal("set_status", status)
	
	var player_list = get_tree().get_nodes_in_group(Groups.player)
	if player_list.size() > 0:
		var player: Player = player_list[0]
		player.emit_signal("pause_player")

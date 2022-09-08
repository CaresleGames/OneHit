extends Node

signal round_end()

func _ready() -> void:
	connect("round_end", self, "_on_round_end")


func _on_round_end() -> void:
	var menu_list = get_tree().get_nodes_in_group(Groups.game_menu)
	if menu_list.size() > 0:
		var menu: GameMenu = menu_list[0]
		menu.emit_signal("show_menu")
	
	var player_list = get_tree().get_nodes_in_group(Groups.player)
	if player_list.size() > 0:
		var player: Player = player_list[0]
		player.emit_signal("pause_player")

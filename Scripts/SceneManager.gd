extends Node2D

export (NodePath) var player_path
onready var player = get_node(player_path)

export (NodePath) var gameover_ui_path
var gameover_ui

export (NodePath) var gamewin_ui_path
var gamewin_ui

export (NodePath) var metrics_ui_path
var metrics

signal game_over

func _ready():
	
	if metrics_ui_path:
		metrics = get_node(metrics_ui_path)
	
	if gameover_ui_path:
		gameover_ui = get_node(gameover_ui_path)
	if gameover_ui:
		gameover_ui.visible = false
	
	if gamewin_ui_path:
		gamewin_ui = get_node(gamewin_ui_path)
	if gamewin_ui:
		gamewin_ui.visible = false

func _on_Item_item_collected(item_type):
	if item_type == 'apple':
		Global.item_count = Global.item_count + 1
		print('You have ', Global.item_count, 'apples')

	if item_type == 'life' and Global.player_lives < Global.total_lives:
		Global.player_lives = Global.player_lives + 1
		print('You have ', Global.player_lives, ' lives')
	
	if metrics:
		metrics.update_display()


func _on_Player_player_died():
	gameover_ui.visible = true


func _on_Player_player_hit():
	print(Global.player_lives)
	if Global.player_lives > 0:
		Global.player_lives = Global.player_lives - 1
	
	if Global.player_lives <= 0:
		player.dies()
		gameover_ui.visible = true
		emit_signal("game_over")
	
	if metrics:
		metrics.update_display()	


func _on_PortalEndGame_on_activate():
	gamewin_ui.visible = true


func _on_game_over():
	pass # Replace with function body.


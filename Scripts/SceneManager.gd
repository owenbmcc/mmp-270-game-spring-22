extends Node2D

export (NodePath) var player_path
onready var player = get_node(player_path)

export (NodePath) var gameover_ui_path
onready var gameover_ui = get_node(gameover_ui_path)

func _ready():
	if gameover_ui:
		gameover_ui.visible = false

func _on_Item_item_collected(item_type):
	if item_type == 'apple':
		Global.item_count = Global.item_count + 1
		print('You have ', Global.item_count, 'apples')

	if item_type == 'life' and Global.player_lives < Global.total_lives:
		Global.player_lives = Global.player_lives + 1
		print('You have ', Global.player_lives, ' lives')


func _on_Player_player_died():
	gameover_ui.visible = true


func _on_Player_player_hit():
	print(Global.player_lives)
	if Global.player_lives > 0:
		Global.player_lives = Global.player_lives - 1
	
	if Global.player_lives <= 0:
		player.dies()
		gameover_ui.visible = true
		
		
		
		
		
		
		
		

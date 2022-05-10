extends Control

export (String, FILE, '*.tscn') var default_scene

export (NodePath) var title_path
onready var title = get_node(title_path)

export (NodePath) var instructions_path
onready var instructions = get_node(instructions_path)

func _ready():
	if instructions:
		instructions.visible = false

func _on_Start_pressed():
	Global.player_lives = Global.total_lives
	get_tree().change_scene(default_scene)
	$ButtonPress.play()

func _on_Quit_pressed():
	get_tree().quit()

func _on_Instructions_pressed():
	instructions.visible = true
	title.visible = false
	$ButtonPress.play()


func _on_mouse_entered():
	$ButtonHover.play()

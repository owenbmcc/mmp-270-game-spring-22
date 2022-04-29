extends Area2D

export var dialog_name = "Jerry Dialog 1"
var player = null
var dialog = null
var player_entered = false
var dialog_started = false

func _ready():
	$Label.visible = false
	
func _process(_delta):
	if player_entered and not dialog_started:
		if Input.is_action_just_pressed("ui_accept"):
			dialog = Dialogic.start(dialog_name)
			add_child(dialog)
			dialog.connect('timeline_end', self, 'end_dialog')
			dialog.connect('dialogic_signal', self, 'switch_talker')
			dialog_started = true
			$Label.visible = false
			$AnimatedSprite.play('Talk')
			player.talk()

func end_dialog(_param):
	$AnimatedSprite.play('Idle')
	player.end_talk()
	
func switch_talker(talker):
	print('talker', talker)
	if talker == 'player':
		player.talk()
		$AnimatedSprite.play('Idle')
	else:
		$AnimatedSprite.play('Talk')
		player.end_talk()

func _on_NPC_body_entered(body):
	$Label.visible = true
	player_entered = true
	player = body


func _on_NPC_body_exited(body):
	$Label.visible = false
	player_entered = false
	dialog_started = false

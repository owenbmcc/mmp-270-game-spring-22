extends Node2D

export (PackedScene) var iceball
onready var player = get_node("../Player")

var interval = 2
var counter = 0

func _physics_process(delta):
	counter += delta
	if counter >= interval:
		counter = 0
		
		shoot_iceball(-200, -300)
		shoot_iceball(-100, -300)
		shoot_iceball(0, -300)
		shoot_iceball(100, -300)
		shoot_iceball(200, -300)

func shoot_iceball(x, y):
	var p = iceball.instance()
	p.position = player.position + Vector2(x, y)
	p.velocity = Vector2(-0.5, 1) * p.speed
	owner.add_child(p)

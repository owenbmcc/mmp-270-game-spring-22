extends Area2D

export var frame_number = 0
#var rng = RandomNumberGenerator.new()

func _ready():
	$Sprite.frame = frame_number
#	$Sprite.frame = rng.randi_range(0, 2)

func _on_ObstacleStatic_body_entered(body):
	body.enemy_collision()

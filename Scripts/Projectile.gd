extends Area2D

var speed = 25
var velocity = Vector2()
var is_flying = true
var use_gravity = false
var entered_screen = false

func _physics_process(delta):
	if is_flying:
		if use_gravity:
			velocity.y += gravity * delta / speed
		position += velocity * delta * speed
		rotation = velocity.angle()

	if not $VisibilityNotifier2D.is_on_screen() and not entered_screen:
		queue_free()
		
	if $VisibilityNotifier2D.is_on_screen():
		entered_screen = true

func _on_Fireball_area_entered(area):
	$AnimatedSprite.play("Hit")
	$Hit.play()
	area.get_parent().hit(25)
	is_flying = false


func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == 'Hit':
		queue_free()


func _on_Fireball_body_entered(body):
	$AnimatedSprite.play("Hit")
	$Hit.play()
	is_flying = false
	if body.name == "Player":
		body.enemy_collision()
	

		

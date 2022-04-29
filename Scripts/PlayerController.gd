extends KinematicBody2D

# controll our player movement
# set player animations

# variables that can be edited in godot
export var speed = 100
export var use_gravity = false

export var gravity = 800
export var jump_force = 400

export (PackedScene) var fireball


# member variables
var is_alive = true
var is_moving = true
var velocity = Vector2()
var is_jumping = false
var is_shooting = false

signal player_died
signal player_hit

func _physics_process(delta):
	# conditional statement
	if is_alive and is_moving:
		if use_gravity:
			update_movement_platformer(delta)
		else:
			update_movement(delta)
		
		if is_moving:
			update_animation()

func update_movement(delta):
	# reset the player velocity
	velocity.x = 0
	velocity.y = 0
	
	# capture user input
	if Input.is_action_pressed("move_right"):
		velocity.x = speed
	
	if Input.is_action_pressed("move_left"):
		velocity.x = -speed
		
	if Input.is_action_pressed("move_down"):
		velocity.y = speed
	
	if Input.is_action_pressed("move_up"):
		velocity.y = -speed
		
	move_and_slide(velocity, Vector2.UP)

func update_movement_platformer(delta):
	velocity.x = 0
	
	# capture user input
	if Input.is_action_pressed("move_right"):
		velocity.x += speed
	
	if Input.is_action_pressed("move_left"):
		velocity.x -= speed
		
	if Input.is_action_just_pressed("action"):
		shoot()
	
	move_and_slide(velocity, Vector2.UP)
	
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		velocity.y = 0
	
	if is_jumping:
		if is_on_floor() or is_on_wall():
			is_jumping = false
			$LandSound.play()
	
	var can_jump = is_on_floor() or is_on_wall()
	if Input.is_action_just_pressed("jump") and can_jump and not is_jumping:
		velocity.y -= jump_force
		is_jumping = true
		$AnimatedSprite.frame = 0
		$JumpSound.play()
	
	if is_alive and position.y > get_viewport().size.y * 2:
		is_alive = false
		emit_signal("player_died")
		dies()
	

func update_animation():
	if is_shooting:
		pass
	elif not is_on_floor() and use_gravity:
		$AnimatedSprite.play("Jump")
	elif abs(velocity.x) > 0 or (not use_gravity and velocity.length_squared() > 0):
		$AnimatedSprite.play("Walk")
	else:
		$AnimatedSprite.play("Idle")
	
	if velocity.x > 0:
		$AnimatedSprite.flip_h = false
		
	if velocity.x < 0:
		$AnimatedSprite.flip_h = true

func talk():
	is_moving = false
	$AnimatedSprite.play('Talk')

func end_talk():
	is_moving = true

func enemy_collision():
	is_moving = false
	$AnimatedSprite.play('Hit')
	$HitSound.play()

func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == 'Hit':
		is_moving = true
		emit_signal("player_hit")
	
	if $AnimatedSprite.animation == 'Shoot':
		is_shooting = false

func dies():
	$AnimatedSprite.play("Dies")
	is_alive = false
	$DeathSound.play()

func shoot():
	$AnimatedSprite.play("Shoot")
	is_shooting = true
	
	var p = fireball.instance()
	p.position = position
	p.position.y -= 32
	
	# shoot in direction of the player
	p.velocity.x = p.speed * (-1 if $AnimatedSprite.flip_h else 1)

	# shoot towards mouse
#	p.velocity = get_local_mouse_position().normalized() * p.speed
	p.use_gravity = true
	
	owner.add_child(p)
	








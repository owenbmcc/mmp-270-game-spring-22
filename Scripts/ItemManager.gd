extends Area2D

export var item_type = 'apple'
signal item_collected

var item_is_collected = false

func _on_Item_body_entered(body):
	if not item_is_collected:
		emit_signal("item_collected", item_type)
		item_is_collected = true
		$AnimatedSprite.play("Collected")
		$CollectedSound.play()

func _on_AnimatedSprite_animation_finished():
	if item_is_collected:
		queue_free()

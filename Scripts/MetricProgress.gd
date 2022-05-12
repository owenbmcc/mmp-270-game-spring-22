extends ProgressBar
# extends TextureProgress

# reference to Global value
export var item_name = "player_lives"

# display on ready, also when metrics update
func _ready():
	update_display()
	
# update value from Global
func update_display():
	value = Global[item_name]


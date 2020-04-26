extends StaticBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(int) var size = 5
export(bool) var broken = false

onready var texture = $TextureRect/decorative_dungeon

var soul_generator = preload("res://Soul.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	texture.frame = 5-size + 5*int(broken)
	pass # Replace with function body.

func hit(damage):
	if not broken:
		broken = true
		texture.frame = 5-size + 5
		spawn_time(size)

func spawn_time(time):
	var spawn_range = 200/8/4
	for i in range(time):
		var x = cos(2*i*PI/time) * spawn_range
		var y = sin(2*i*PI/time) * spawn_range
		var soul = soul_generator.instance()
		soul.position = Vector2(x,y) + position
		self.get_parent().add_child(soul)

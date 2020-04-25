extends StaticBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(int) var size = 5
export(bool) var broken = false

onready var texture = $TextureRect/decorative_dungeon

var soul_generator = preload("res://Soul.tscn")

var timer = 100
# Called when the node enters the scene tree for the first time.
func _ready():
	texture.frame = 5-size + 5*int(broken)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if timer <= 0:
		hit(0)
	else:
		timer -=1

func hit(damage):
	if not broken:
		broken = true
		texture.frame = 5-size + 5
		spawn_time(size)

func spawn_time(time):
	for i in range(time):
		var x = rand_range(-1,1)*100
		var y = rand_range(-1,1)*100
		var soul = soul_generator.instance()
		soul.position = Vector2(x,y) + position
		self.get_parent().add_child(soul)

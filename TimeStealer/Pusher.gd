extends KinematicBody2D

enum {
	LEFT, 
	RIGHT
}

export var side = LEFT
var toughness = 10
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var outs = [5, 7, 20, 32, 32, 32, 32, 29, 22, 12, 5]
var diffs = [0, 2, 13, 12, 0, 0, 0, -3, -7, -10, -7]
var progress = 0

onready var texture = $TextureRect/side_trap
onready var box = $CollisionPolygon2D

# Called when the node enters the scene tree for the first time.
func _ready():
	if side == RIGHT:
		box.translate(Vector2.RIGHT*(27*2))


func _physics_process(delta):
	texture.flip_h = side == RIGHT
	progress = (progress + 1) % 22
	texture.frame = (progress / 2 ) % 11
	var direction = Vector2.RIGHT if side == LEFT else Vector2.LEFT
	box.translate(direction*diffs[texture.frame]/2)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

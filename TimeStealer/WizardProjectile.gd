extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var velocity = Vector2.ZERO*200
var timeOut = 30
var wizard = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

onready var collisionBox = $CollisionShape2D
onready var texture = $TextureRect/projectile

func _physics_process(delta):
	var angle = -velocity.angle_to(Vector2.LEFT)
	collisionBox.rotation = angle
	texture.rotation = angle
	
	if timeOut > 0:
		timeOut-=1
	else:
		self.get_parent().remove_child(self)

	var newVelocity = move_and_slide(velocity)
	if newVelocity != velocity:
		timeOut = 0

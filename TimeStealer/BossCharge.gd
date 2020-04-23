extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var isDestructing = false
var velocity = Vector2.ZERO
var wizard = null
var timeOut = 0

onready var animationPlayer = $AnimationPlayer
var previousTextureId = 0
onready var textures = [$TextureRect/projectile, $TextureRect/projectile_destruction]
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var destructionTime = 20

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	if len(textures) > previousTextureId:
		textures[previousTextureId].flip_h = velocity.x	<= 0
		
	if timeOut > 0:
		timeOut-=1
	else:
		isDestructing = true
	if isDestructing:
		showTexture(1)
		animationPlayer.play("destruction")
		if destructionTime > 0:
			destructionTime -=1
		else:
			self.get_parent().remove_child(self)
	else:
		animationPlayer.play("idle")
		var newVelocity = move_and_slide(velocity)
		if newVelocity != velocity:
			isDestructing = true


func _on_Player_body_entered(body):
	if  body.get_name() == "Player":
		if not isDestructing:
			body.hit(30)
			isDestructing = true


func showTexture(textureId):
	if textureId != previousTextureId:
		if textures[previousTextureId] != null:
			textures[previousTextureId].hide()
		if textures[textureId] != null:
			textures[textureId].show()
		previousTextureId = textureId

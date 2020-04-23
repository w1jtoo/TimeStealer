extends StaticBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var opened = false
var opening = false
var openingTime = 16
export var key = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	if opened:
		wideCollider.disabled = true
	else:
		smallCollider.disabled = true
		smallCollider2.disabled = true

onready var animationPlayer = $AnimationPlayer
onready var wideCollider = $CollisionShape2D
onready var smallCollider = $CollisionPolygon2D
onready var smallCollider2 = $CollisionPolygon2D2
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	if opening:
		animationPlayer.play()
		if openingTime > 0:
			openingTime -= 1
		else:
			openingTime = 16
			opening = false
			opened = not opened
			animationPlayer.play("close" if opened else "open")
			if opened:
				wideCollider.disabled = true
				smallCollider.disabled = false
				smallCollider2.disabled = false
			else:
				wideCollider.disabled = false
				smallCollider.disabled = true
				smallCollider2.disabled = true
	else:
		animationPlayer.stop()
		animationPlayer.play("close" if opened else "open")
	
func _on_Area2D_body_entered(body):
	if body.get_name() == "Player" and not opened:
		var item_key = null
		for item in body.items:
			print(item.get_name())
			if item.get_name().begins_with("ItemKey"):
				if item.id == key:
					item_key = item
					break
		if item_key != null:
			body.items.remove(body.items.find(item_key))
			opening = true

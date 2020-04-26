extends StaticBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export(int, 0,2) var type

onready var textureRect = $TextureRect
# Called when the node enters the scene tree for the first time.
func _ready():
	var children = textureRect.get_children()
	for i in range(len(children)):
		if i != type:
			children[i].visible = false

func hit(damage):
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	if body.get_name().begins_with("Player"):
		body.currentSpell = type + 1

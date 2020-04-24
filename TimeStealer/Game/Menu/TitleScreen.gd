extends Control

var scene_path_to_load

func _ready():
	$Menu/CenterRaw/Buttons/StartButton.grab_focus()
	for button in $Menu/CenterRaw/Buttons.get_children():
		if button.scene_to_load != null:
			button.connect("pressed", self, "_on_Button_pressed", [button.scene_to_load])

func _on_Button_pressed(scene_to_load):
	# get_tree().change_scene(scene_to_load)
	scene_path_to_load = scene_to_load
	$FadeIn.show()
	$FadeIn.fade_in()

func _on_ExitButton_pressed():
	get_tree().quit() 


func _on_FadeIn_fade_finish():
	get_tree().change_scene(scene_path_to_load)

extends Control


var scene_path_to_load

func _ready():
	pass
	
func _on_Button_pressed(scene_to_load):
	# get_tree().change_scene(scene_to_load)
	scene_path_to_load = scene_to_load
	$FadeIn.show()
	$FadeIn.fade_in()


func _on_FadeIn_fade_finish():
	get_tree().change_scene(scene_path_to_load)


func _on_ExitButton_pressed():
	_on_Button_pressed($Buttons/ExitButton.scene_to_load)


func _on_OptionsButton_pressed():
	_on_Button_pressed($Buttons/OptionsButton.scene_to_load)

func _on_RestartButton_button_up() -> void:
	# get_tree().paused = false
	get_tree().reload_current_scene()

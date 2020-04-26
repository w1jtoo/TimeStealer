extends Control


func _on_Button_pressed():
	$FadeIn.show()
	$FadeIn.fade_in()


func _on_FadeIn_fade_finish():
	get_tree().change_scene("res://Game/Menu/TitleScreen.tscn")

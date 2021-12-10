extends CanvasLayer

var main_menu_scene = preload("res://Levels/Level2.tscn")
#TODO make this dynamic
export(PackedScene) var next_scene

onready var control = $Control



func _on_MainMenu_button_up():
	get_tree().change_scene_to(main_menu_scene)


func _on_NextLevel_button_up():
	get_tree().change_scene_to(next_scene)
	
	
func hide():
	control.visible = false
	
func show():
	control.visible = true


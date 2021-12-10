extends Node2D


onready var results_screen = $ResultsScreen

func _ready():
	results_screen.hide()

func _physics_process(delta):
	for node in get_tree().get_nodes_in_group('coin'):
		if node.is_inside_tree():
			print("Phew, it's still alive!")
		else:
			win()

func win():
	results_screen.show()

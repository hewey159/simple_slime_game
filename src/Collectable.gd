extends Node2D




func _on_Area2D_area_entered(area):
	print("I've been collected")
	queue_free()

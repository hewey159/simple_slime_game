extends KinematicBody2D


var height = 0


var speed = 100

var velocity: = Vector2.ZERO

export var gravity = Vector2.DOWN * 500
export var up_speed = Vector2.UP * 500
export var direction_speed = 800

var falling = true
var move_direction = gravity

var touch_controls = false

onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")

func _ready():
	touch_controls = OS.has_touchscreen_ui_hint()

func _physics_process(delta):
	move(delta)

func move(delta):
	if not falling:
		var input_vector = Vector2.ZERO
		if Input.is_action_pressed("left") or Input.is_action_pressed("right"):
			move_direction = up_speed
		elif Input.is_action_just_released("left"):
			falling = true
			print("left released")
			move_direction = Vector2.LEFT * direction_speed
		elif Input.is_action_just_released("right"):
			falling = true
			print("right released")
			move_direction = Vector2.RIGHT * direction_speed
			
	print(move_direction)
	if move_direction != Vector2.ZERO:
		animationTree.set("parameters/Move/blend_position", move_direction)
		animationTree.set("parameters/Idle/blend_position", move_direction)
		animationState.travel("Move")
	else:
		animationState.travel("Idle")
		

	var collision_object = self.move_and_collide(move_direction*delta)
	
	if (collision_object):
		var tile_pos = collision_object.collider.world_to_map(position)
		# Find the colliding tile position

		tile_pos -= collision_object.normal
		# Get the tile id

		var tile_id = collision_object.collider.get_cellv(tile_pos)
		print(tile_id)
		#TODO make this more modular
		if tile_id == 2:
			die()
		if collision_object.normal == Vector2.UP:
			falling = false
			move_direction = Vector2.ZERO
		elif collision_object.normal == Vector2.DOWN:
			print("hit roof")
		else:
			move_direction = gravity
	
func _on_CollectItem_area_entered(area):
	print("item collected")
	
	
func die():
	queue_free()


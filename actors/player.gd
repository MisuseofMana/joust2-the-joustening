extends CharacterBody2D
class_name Player
@onready var sprite_2d: Sprite2D = $Sprite2D
var left =  preload("res://assets/Lance1.png")
var right = preload("res://assets/Lance2.png")
const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var owner_id = 1

func _ready() -> void:
	owner_id = name.to_int()
	set_multiplayer_authority(owner_id)
	
#	this will eventually move the camera to the players location when brought into multiplayer
	#if owner_id == multiplayer.get_unique_id():
		#setup_camera()

func _process(delta):
	# squash error on client close
	if multiplayer.multiplayer_peer == null:
		return
	# prevent controlling of a player that isn't your own
	if owner_id != multiplayer.get_unique_id():
		return
	
#	update_camera_position()
	
func _physics_process(delta: float) -> void:
	if owner_id != multiplayer.get_unique_id():
		return
		
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
	if Input.is_action_just_pressed("ui_accept"):
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if Input.is_action_pressed("ui_left"):
		sprite_2d.texture = left
	elif Input.is_action_pressed("ui_right"):
		sprite_2d.texture = right
		
	move_and_slide()


func _input(event: InputEvent) -> void:
	if owner_id != multiplayer.get_unique_id():
		return
		
	if event.as_text() == "Left":
		sprite_2d.texture = left
	elif event.as_text() == "Right": 
		sprite_2d.texture = preload("res://assets/Lance2.png")


func _on_east_collision_area_entered(area: Area2D) -> void:
	if area.name.contains('East'):
		position.x = -1153
		

func _on_west_collision_area_entered(area: Area2D) -> void:
	if area.name.contains('West'):
		position.x = 1153

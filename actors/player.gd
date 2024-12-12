extends CharacterBody2D
class_name Player

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

func _enter_tree():
	set_multiplayer_authority(str(name).to_int())

#func _ready() -> void:
	#if not is_multiplayer_authority(): return

func _physics_process(delta: float) -> void:
	#if not is_multiplayer_authority(): return
	
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

	move_and_slide()




func _on_east_collision_area_entered(area: Area2D) -> void:
	if area.name.contains('East'):
		position.x = -1153
		

func _on_west_collision_area_entered(area: Area2D) -> void:
	if area.name.contains('West'):
		position.x = 1153

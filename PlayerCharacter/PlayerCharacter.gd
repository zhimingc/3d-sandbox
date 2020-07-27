extends KinematicBody

export var moveSpeed = 150

var viewPitchLimit = 40

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update_movement(delta)

func _input(event):
	if event is InputEventMouseMotion:
		update_camera(event.relative)

func update_movement(delta):
	var accel = Vector3()
	if Input.is_action_pressed("ui_left"):
		accel.x -= 1
	if Input.is_action_pressed("ui_right"):
		accel.x += 1
	if Input.is_action_pressed("ui_up"):
		accel.z -= 1
	if Input.is_action_pressed("ui_down"):
		accel.z += 1
	accel = accel.rotated(Vector3.UP, $Camera.rotation.y)
	move_and_slide(accel * moveSpeed * delta)

func update_camera(mouseRelative):
	var degreeScalar = .25
	
	$Camera.global_rotate(Vector3.UP, deg2rad(-mouseRelative.x * degreeScalar))
	$Camera.rotate_object_local(Vector3.RIGHT, deg2rad(-mouseRelative.y * degreeScalar))
	$Camera.rotation.x = clamp($Camera.rotation.x, deg2rad(-viewPitchLimit), deg2rad(viewPitchLimit))


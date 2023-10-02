extends KinematicBody2D

export (int) var speed = 90
export (int) var jump_speed = -215
export (int) var gravity = 600
export (int) var face = 0
export (float) var jump_time = 0.1
export (float) var jump_press_time = 0.1
export (bool) var flip = false
export (float, 0, 1.0) var friction = 0.15
export (float, 0, 1.0) var acceleration = 0.25

var can_jump = true
var jump_pressed = false

var velocity = Vector2.ZERO

var displace_vector = Vector2(16, 0)

func _ready():
	$Sprite.frame = face

func get_input():
	var dir = 0
	if Input.is_action_pressed("W_Right") and !Globals.tween_active:
		if flip:
			$Sprite.flip_h = true
			dir -= 1
		else:
			$Sprite.flip_h = false
			dir += 1
	if Input.is_action_pressed("W_Left") and !Globals.tween_active:
		if flip:
			$Sprite.flip_h = false
			dir += 1
		else:
			$Sprite.flip_h = true
			dir -= 1
	if dir != 0:
		velocity.x = lerp(velocity.x, dir * speed, acceleration)
	else:
		velocity.x = lerp(velocity.x, 0, friction)

func _physics_process(delta):
	get_input()
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	
	if is_on_floor():
		can_jump = true
		if jump_pressed:
			velocity.y = jump_speed
	
	if !is_on_floor():
		coyote_time()
	
	if Input.is_action_just_pressed("W_Jump") and !Globals.tween_active:
		jump_pressed = true
		jump_press_time()
		if can_jump:
			velocity.y = jump_speed

func jump_press_time():
	yield(get_tree().create_timer(jump_press_time), "timeout")
	jump_pressed = false

func coyote_time():
	yield(get_tree().create_timer(jump_time), "timeout")
	can_jump = false

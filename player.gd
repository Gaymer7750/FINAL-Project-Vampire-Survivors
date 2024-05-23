extends CharacterBody2D

signal health_depleted
var health := 100.0
@onready var progress_bar = %ProgressBar

var regen_amount: float = 3.0

func _ready():
	regen_amount = 3

func regen(delta):
		progress_bar.value += delta * regen_amount

func _physics_process(delta):
	regen(delta)
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * 600
	move_and_slide()
	
	if velocity.length() > 0.0:
		%HappyBoo.play_walk_animation()
	else:
		%HappyBoo.play_idle_animation()
		

	const DAMAGE_RATE = 10.0
	var overlapping_mobs = %HurtBox.get_overlapping_bodies()
	if overlapping_mobs.size() > 0:
		health -= DAMAGE_RATE * overlapping_mobs.size() * delta
		%ProgressBar.value = health
		if health <= 0.0:
			health_depleted.emit()
			


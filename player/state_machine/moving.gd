extends PlayerState

@export var speed := 3.0
@export var head_bob_ampl := 0.0
@export var head_bob_freq := 0.0
var movement := Vector2.ZERO


func on_enter() -> void:
    player.camera.start_head_bob(head_bob_freq, head_bob_ampl)


func on_physics_process(delta: float) -> void:
    look_around(delta)
    if !player.is_on_floor():
        change_state("fall")

    movement = Input.get_vector("left", "right", "forward", "backwards")
    player.velocity = player.global_transform.basis *\
        Vector3(movement.x, 0, movement.y) * speed
    player.move_and_slide()

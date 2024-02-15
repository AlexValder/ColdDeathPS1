extends "res://player/state_machine/moving.gd"

@export var jump := 2.0


func on_enter() -> void:
    player.camera.stop_head_bob()

    movement = Input.get_vector("left", "right", "forward", "backwards")
    player.velocity = player.global_transform.basis *\
        Vector3(movement.x, jump, movement.y) * speed
    player.move_and_slide()
    change_state("fall")


func on_physics_process(delta: float) -> void:
    look_around(delta)

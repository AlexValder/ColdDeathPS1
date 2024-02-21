extends "./moving.gd"

@export var jump := 2.0
@export var stamina_tax := 1.0


func on_enter() -> void:
    player.camera.stop_head_bob()
    player.stamina.stop_recover()

    if player.stamina.try_retract(stamina_tax):
        movement = Input.get_vector("left", "right", "forward", "backwards")
        player.velocity = player.global_transform.basis *\
            Vector3(movement.x, jump, movement.y) * speed
        player.move_and_slide()
        player.stamina.start_recover()
    change_state("fall")


func on_physics_process(delta: float) -> void:
    look_around(delta)

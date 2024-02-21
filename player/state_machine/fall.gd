extends PlayerState
const GRAVITY := 98.0 / 4


func on_entry() -> void:
    player.camera.stop_head_bob()


func on_physics_process(delta: float) -> void:
    look_around(delta)
    if player.is_on_floor():
        change_state("idle")

    player.velocity.y -= GRAVITY * delta
    player.move_and_slide()

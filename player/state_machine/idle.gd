extends PlayerState


func on_enter() -> void:
    player.camera.stop_head_bob()


func on_physics_process(delta: float) -> void:
    look_around(delta)
    if !player.is_on_floor():
        change_state("fall")

    if Input.is_action_pressed("left") or Input.is_action_pressed("right") or\
        Input.is_action_pressed("forward") or Input.is_action_pressed("backwards"):
        change_state("run" if Input.is_action_pressed("run") else "walk")


func on_input(event: InputEvent) -> void:
    super.on_input(event)
    if event.is_action_pressed("crouch"):
        change_state("crouch")
    elif event.is_action_pressed("jump"):
        change_state("jump")

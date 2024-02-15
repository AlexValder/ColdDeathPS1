extends "./moving.gd"


func on_physics_process(delta: float) -> void:
    super.on_physics_process(delta)
    if is_zero_approx(movement.length()) && !Input.is_action_pressed("crouch"):
        change_state("idle")


func on_input(event: InputEvent) -> void:
    super.on_input(event)
    if event.is_action_pressed("crouch"):
        change_state("crouch")
    elif event.is_action_pressed("run"):
        change_state("run")
    elif event.is_action_pressed("jump"):
        change_state("jump")

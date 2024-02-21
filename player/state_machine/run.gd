extends "./moving.gd"

@export var fov := 80.0
@export var stamina_drop := 2.0
var _def_fov := 0.0


func on_enter() -> void:
    _def_fov = player.camera.fov
    player.camera.change_fov(fov)
    player.stamina.stop_recover()


func on_physics_process(delta: float) -> void:
    super.on_physics_process(delta)
    if is_zero_approx(movement.length()) && !Input.is_action_pressed("crouch"):
        change_state("idle")

    if !player.stamina.try_retract(stamina_drop * delta):
        change_state("walk")


func on_input(event: InputEvent) -> void:
    super.on_input(event)
    if event.is_action_pressed("crouch"):
        change_state("crouch")
    elif event.is_action_released("run"):
        change_state("walk")
    elif event.is_action_pressed("jump"):
        change_state("jump")


func on_exit() -> void:
    player.camera.change_fov(_def_fov)
    player.stamina.start_recover()

extends "./moving.gd"


func on_enter() -> void:
    super.on_enter()
    player.change_height(0.9)


func on_input(event: InputEvent) -> void:
    super.on_input(event)
    if event.is_action_released("crouch"):
        change_state("idle")


func on_exit() -> void:
    super.on_exit()
    player.change_height(2.0)

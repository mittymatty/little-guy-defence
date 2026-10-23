extends Node

signal enter_placement_mode
signal enter_shoot_mode

func emit_enter_placement_mode () -> void:
	enter_placement_mode.emit()

func emit_enter_shoot_mode () -> void:
	enter_shoot_mode.emit()

extends Node

signal enter_placement_mode
signal enter_shoot_mode
signal begin_wave

func emit_enter_placement_mode () -> void:
	enter_placement_mode.emit()

func emit_enter_shoot_mode () -> void:
	enter_shoot_mode.emit()

func emit_begin_wave () -> void:
	begin_wave.emit()

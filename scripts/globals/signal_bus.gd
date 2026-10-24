extends Node

signal enter_placement_mode
signal enter_shoot_mode
signal begin_wave
signal wave_ended
signal blocks_changed

func emit_enter_placement_mode () -> void:
	enter_placement_mode.emit()

func emit_enter_shoot_mode () -> void:
	enter_shoot_mode.emit()

func emit_begin_wave () -> void:
	begin_wave.emit()

func emit_wave_ended () -> void:
	wave_ended.emit()

func emit_blocks_changed() -> void:
	blocks_changed.emit()

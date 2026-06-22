@tool
extends EditorPlugin

func _enable_plugin() -> void:
	add_autoload_singleton("ComboSystem", "res://addons/combo_system_lite/combo_system.gd")

func _disable_plugin() -> void:
	remove_autoload_singleton("ComboSystem")

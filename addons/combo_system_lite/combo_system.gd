extends Node

const MAX_COMBOS := 3
const MAX_STEPS := 4

signal combo_completed(combo_id: String)
signal combo_failed(combo_id: String)

# _combos[id] = {steps: Array[String], window: float}
var _combos: Dictionary = {}
# _progress[id] = {index: int, timer: float}
var _progress: Dictionary = {}

func _process(delta: float) -> void:
	for id in _progress.keys():
		_progress[id]["timer"] -= delta
		if _progress[id]["timer"] <= 0.0:
			_progress.erase(id)
			emit_signal("combo_failed", id)

func register_combo(id: String, steps: Array, window: float = 0.5) -> bool:
	if not _combos.has(id) and _combos.size() >= MAX_COMBOS:
		return false
	if steps.size() > MAX_STEPS:
		return false
	_combos[id] = {"steps": steps.duplicate(), "window": window}
	return true

func unregister_combo(id: String) -> void:
	_combos.erase(id)
	_progress.erase(id)

func input_action(action: String) -> void:
	for id in _combos.keys():
		var combo: Dictionary = _combos[id]
		var steps: Array = combo["steps"]
		var prog: Dictionary = _progress.get(id, {"index": 0, "timer": 0.0})
		var expected: String = steps[prog["index"]]
		if action == expected:
			prog["index"] += 1
			prog["timer"] = combo["window"]
			_progress[id] = prog
			if prog["index"] >= steps.size():
				_progress.erase(id)
				emit_signal("combo_completed", id)
		elif prog["index"] > 0:
			# wrong input — reset
			_progress.erase(id)
			emit_signal("combo_failed", id)

func get_progress(id: String) -> int:
	return _progress.get(id, {"index": 0})["index"]

func combo_ids() -> Array:
	return _combos.keys()

func reset_progress(id: String) -> void:
	_progress.erase(id)

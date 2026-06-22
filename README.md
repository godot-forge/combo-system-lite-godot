# Combo System Lite — Godot 4

Free Godot 4 addon for detecting input combo sequences — up to 3 combos, 4 steps each.

## Features (Lite — Free)

- `register_combo(id, steps, window)` — define a combo with time window
- `unregister_combo(id)` — remove a combo
- `input_action(action)` — feed an action string to all combos
- `get_progress(id)` — how many steps completed so far
- `combo_ids()` — list all registered combos
- `reset_progress(id)` — cancel in-progress combo
- Auto-expire via `_process` when window expires
- Signals: `combo_completed(id)`, `combo_failed(id)`

## Quick Start

```gdscript
# Autoload: ComboSystem
ComboSystem.register_combo("hadouken", ["down", "down-right", "right", "punch"], 0.5)
ComboSystem.combo_completed.connect(func(id): print("Combo: ", id))

func _input(event):
    if event.is_action_pressed("down"):
        ComboSystem.input_action("down")
```

## Upgrade to PRO

[Combo System PRO](https://godot-forge.itch.io/combo-system-pro-godot) adds:
- Unlimited combos
- **Priority ordering** — higher priority combos consume input first
- **allow_extra** — skip unrelated inputs mid-combo
- `on_complete` Callable callback per combo
- Tag-based grouping (`combos_with_tag`)
- `combo_progress(id, step, total)` signal
- `combo_partial(id, step)` signal on timeout mid-combo
- `set_window()` at runtime, `reset_all_progress()`

---
Made with ♥ by [GodotForge](https://itch.io/profile/godot-forge)

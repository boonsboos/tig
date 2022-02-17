module game

// main draw call
pub fn draw() {

	state.tui.clear()

	draw_money()

	draw_upgrades()

	draw_machines()

	state.tui.reset()
	state.tui.flush()
}

fn draw_money() {
	draw_default_ascii_rectangle(2, 2, 25, 5)

	draw_named_value('credits', format_number_string(state.credits), 3, 3)
	draw_named_value('income', format_number_string(state.income), 3, 4)
}

fn draw_upgrades() {
	if state.focused == .upgrades {
		state.tui.set_bg_color(focused_color)
	}
	draw_default_ascii_rectangle(2, 6, 25, 29)

	state.tui.reset_bg_color() // we have to handle selection
	// 23 chars wide
	// 27 chars tall
	for i := 7; i < 29; i +=2 {
		if i-7 >= state.avail_ups.len || i-8 >= state.avail_ups.len {
			break
		}

		if i-1 % 2 == 0 {
			draw_upgrade(3, i, state.avail_ups[i-8])
		} else {
			draw_upgrade(3, i, state.avail_ups[i-7])
		}
	}
}

fn draw_machines() {
	if state.focused == .machines {
		state.tui.set_bg_color(focused_color)
	}
	draw_default_ascii_rectangle(30, 2, 55, 29)

	state.tui.reset_bg_color()
}
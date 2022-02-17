module game

import term.ui

const focused_color = ui.Color{50, 50, 50}

enum Focus {
	upgrades = 0
	machines
}

fn draw_named_value(name string, value string, x int, y int) {
	mut name_ := name
	for name_.len < 7 {
		name_ += ' '
	}

	mut value_ := value
	for value_.len < 6 {
		value_ += ' '
	}

	state.tui.draw_text(x, y, '[$name_] $value_')
}

fn draw_upgrade(x int, y int, u Upgrade) {
	state.tui.draw_text(x, y,   u.describe)
	state.tui.draw_text(x, y+1, /*'price: ${format_number_string(u.price)}'*/ '$state.avail_ups')
}

fn draw_default_ascii_rectangle(x int, y int, x2 int, y2 int) {
	// draw horizontal
	for j in [y, y2] {
		for i in x..x2+1 {
			state.tui.draw_text(i, j, '=')
		}
	}

	// draw vertical 
	for i in y..y2 {
		state.tui.draw_text(x,  i, '=')
		state.tui.draw_text(x2, i, '=')
	}
}

fn draw_ascii_rectangle(x int, y int, x2 int, y2 int, ch string) {
	// draw horizontal
	for j in [y, y2] {
		for i in x..x2+1 {
			state.tui.draw_text(i, j, ch)
		}
	}

	// draw vertical 
	for i in y..y2 {
		state.tui.draw_text(x,  i, ch)
		state.tui.draw_text(x2, i, ch)
	}
}
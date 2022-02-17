module game

import term.ui

// main draw call
pub fn draw() {

	state.tui.clear()

	draw_money()

	draw_upgrades()

	state.tui.reset()
	state.tui.flush()
}

fn draw_money() {
	draw_default_ascii_rectangle(2, 2, 19, 5)

	draw_named_value('credits', format_number_string(state.credits), 3, 3)
	draw_named_value('income', format_number_string(state.income), 3, 4)
}

fn draw_upgrades() {
	draw_default_ascii_rectangle(2, 7, 19, 15)
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

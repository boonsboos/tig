module graphics

import term.ui

const screen = state.tui

// main draw call
pub fn draw() {
	
	screen.clear()

	screen.set_bg_color(ui.Color{100, 100, 100})
	screen.draw_rect(2, 2, 9, 5)
	screen.draw_text(3, 3, format_number_string(state.credits))
	screen.draw_text(3, 4, format_number_string(state.income))

	screen.reset()
	screen.flush()
}

fn draw_money() {

}
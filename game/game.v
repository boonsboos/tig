module game

import math.big
import term
import term.ui

import util

__global state GameState

fn init() {
	state = GameState{}
}

pub struct GameState {
mut:
	tui			ui.Context
pub mut:
	credits		big.Integer
	income		big.Integer = big.two_int
}

pub fn game() {

	util.load_save()

	state.tui = ui.init(ui.Config{
		event_fn: handle_input
		frame_fn: tick
		frame_rate: 2
		hide_cursor: true
	})

	// start main game loop
	//state.tui.run() or { panic(err) }
	//state.tui.set_window_title('vig')

	// clear terminal after exiting
	//term.clear()
}

fn tick(v voidptr) {

	// note to self: the x is the horizontal axis

	mut screen := state.tui

	// clear the screen
	//screen.clear()

	// update values
	state.credits = state.credits + (state.income)
	state.income.inc() 

	// draw info
	screen.set_bg_color(ui.Color{100, 100, 100})
	screen.draw_rect(2, 2, 8, 5)
	screen.draw_text(3, 3, format_number_string(state.credits))
	screen.draw_text(3, 4, format_number_string(state.income))

	// screen.reset()
	// screen.flush()
}
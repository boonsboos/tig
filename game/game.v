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
	state.tui.run() or { panic(err) }
	state.tui.set_window_title('vig')

	// clear terminal after exiting
	term.clear()
}

fn tick(v voidptr) {

	// note to self: the x is the horizontal axis

	// update values
	state.credits = state.credits + (state.income)
	state.income.inc() 

	// draw info
	draw()
}
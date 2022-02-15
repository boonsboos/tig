module game

import math.big
import term
import time

import util

__global state GameState

fn init() {
	state = GameState{}
}

pub struct GameState {
pub mut:
	credits		big.Integer
	income		big.Integer = big.one_int
}

pub fn game() {
	// on startup, load info from save file
	// still gotta decide on formatting of that file (prob smth proprietary)
	util.load_save()

	// start main game loop
	for {
		go tick()
		time.sleep(time.second)
	}
}

fn tick() {

	// clear the screen
	//term.clear()
	// update values
	state.credits = state.credits + state.income
	if state.credits % big.integer_from_int(25) == big.zero_int {
		state.income.inc()
	}

	// draw info
	println(state.credits.str())
	println(state.income.str())

	// await input (MAYBE THREAD THIS INTO A QUEUE)
	handle_input()
}
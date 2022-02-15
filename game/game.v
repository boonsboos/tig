module game

import math.big
import term
import time

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
	
	// 
	for {
		go tick()
		time.sleep(time.second)
	}
}

fn tick() {

	// clear the screen
	term.clear()
	// update values
	state.credits = state.credits + state.income
	// draw info
	println(state.credits.str())
	println(state.income.str())
	println(state.credits.bytes())
	// await input (MAYBE THREAD THIS INTO A QUEUE)
	handle_input()
}
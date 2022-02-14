module game

import math.big

pub struct GameState {
pub mut:
	credits		big.Integer
	income		big.Integer

}

pub fn game() {
	// on startup, load info from save file
	// still gotta decide on formatting of that file (prob smth proprietary)
	// 
	// call tick function every second or so? maybe 0.5, 2?
	// 
	// autosave should read from a global GameState instance
}

fn tick() {
	// clear the screen
	// update values
	// draw info
	// await input (MAYBE THREAD THIS INTO A QUEUE)
}
module main

import game
import util

fn main() {
	util.file_structure()

	// // autosave thread
	go util.autosave_thread()

	// game thread
	game.game()
}
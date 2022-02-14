module main

import time

import util

fn main() {
	println(options)

	// autosave thread
	go util.autosave_thread()

	// game thread
	for {
		println('game')
		util.file_structure()
		time.sleep(options.autosave_interval * time.second)
	}
}
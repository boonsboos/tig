module util

import time

pub const a_second = 1000000000

fn autosave_worker() {

	println('autosaving...')

	// do autosave stuff

	println('saved!')

}

pub fn autosave_thread() {
	for {
		autosave_worker()
		time.sleep(options.autosave_interval * a_second)
	}
}
module util

import time

fn autosave_worker() {

	println('autosaving...')

	// do autosave stuff

	println('saved!')

}

pub fn autosave_thread() {
	for {
		autosave_worker()
		time.sleep(options.autosave_interval * time.second)
	}
}
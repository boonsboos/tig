module util

import time

fn autosave_worker() {

	println('autosaving...')

	save_file()

	println('saved!')

}

pub fn autosave_thread() {

	time.sleep(30 * time.second)

	for {
		autosave_worker()
		time.sleep(options.autosave_interval * time.second)
	}
}
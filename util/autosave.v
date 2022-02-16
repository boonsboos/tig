module util

import time

pub fn autosave_thread() {

	time.sleep(30 * time.second)

	for {
		save_file()
		time.sleep(options.autosave_interval * time.second)
	}
}
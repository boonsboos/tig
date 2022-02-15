module util

import os
import time

fn save_file() {

	time_now := time.now().get_fmt_date_str(.hyphen, .ddmmyyyy)
	save_file_name := '${time_now}.vigsave'
	save_path := '$saves_folder$save_file_name'

	if os.exists(save_path) {
		backup_file(save_path)
		println('backed up previous file')
		os.create(save_path) or { failed_to_write(save_file_name) }
	} 

	mut save_file := os.open_append(save_path) or { failed_to_open(save_file_name) }

	credit_bytes, _ := state.credits.bytes()
	save_file.write(credit_bytes) or { failed_to_write(save_file_name) }

	save_file.write_string('\n\n') or { failed_to_write(save_file_name) }

	income_bytes, _ := state.income.bytes()
	save_file.write(income_bytes) or { failed_to_write(save_file_name) }

	save_file.close()

}


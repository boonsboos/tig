module util

import os
import time

const lastsave = '${saves_folder}lastsave'

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
	save_file.write_string('\'\'$credit_bytes\'\'') or { failed_to_write(save_file_name) }

	// chance of 6 newlines next to each other should be small enough to not matter
	save_file.write_string('\n') or { failed_to_write(save_file_name) }

	income_bytes, _ := state.income.bytes()
	save_file.write_string('\'\'$income_bytes\'\'') or { failed_to_write(save_file_name) }

	save_file.close()

	if !os.exists(lastsave) {
		os.create(lastsave) or { failed_to_write('lastsave') }
	}

	os.write_file(lastsave, save_file_name) or { failed_to_write('lastsave') }
}

pub fn load_save() {

	save_file_name := os.read_lines(lastsave) or { 
		return
	}

	save_file := os.read_lines('$saves_folder${save_file_name[0]}') or { failed_to_open(save_file_name[0]) }

}
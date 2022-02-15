module util

import os 

pub const (
	root_folder = os.executable().all_before_last('vig')
	saves_folder = '${root_folder}saves/'
	settings = '${root_folder}settings.toml'
)

const settings_content = '# main settings file for vig
# time between saves in seconds
autosave-interval=30
# should the game run in the background as a daemon?
daemonize=true'

pub fn backup_file(file string) {
	if os.exists('${file}.old') {
		os.rm('${file}.old') or { failed_to_write('${file}.old') }
	}
	os.cp(file, '${file}.old') or { failed_to_backup(file) }
}

pub fn file_structure() {

	// create saves folder if it doesn't already exist
	if !os.exists(saves_folder) {
		os.mkdir(saves_folder) or { failed_to_write(saves_folder) }
	}

	// write settings file, which takes less priority than commandline arguments
	if !os.exists(settings) {
		os.create(settings)                       or { failed_to_write(settings) }
		os.write_file(settings, settings_content) or { failed_to_write(settings) }
	}

}

[noreturn]
fn failed_to_write(file string) {
	eprintln('failed to write (to) `$file`')
	exit(1)
}

[noreturn]
fn failed_to_backup(file string) {
	eprintln('failed to back up `$file`')
	exit(1)
}

[noreturn]
fn failed_to_open(file string) {
	eprintln('failed to open `$file`')
	exit(1)
}
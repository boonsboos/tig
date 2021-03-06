module util

import os
import toml

__global options VigOptions

const help = '
VIG [option](=value)

	comprehensive, the documentation goes into more detail.
	you can find those at https://github.com/mrsherobrine/vig/wiki

	-h(elp)                  | shows this message
	-a(utosave-interval)=int | set autosave interval in seconds - default: 30
'

pub struct VigOptions {
pub mut:
	autosave_interval	int = 30
}

fn init() {
	options = parse_settings()
	options = parse_args() // commandline args have higher priority
}


fn parse_args() VigOptions {

	mut options := VigOptions{}

	if os.args.len > 1 {
		for arg in os.args[1..os.args.len] {
			parse_arg(arg, mut options)
		}
	}

	return options
}

fn parse_arg(arg string, mut options VigOptions) {
	
	mut value := ''

	if arg.contains('=') {
		value = arg.all_after('=')
		println(value)
	}

	parse_arg := arg.trim_string_left('-').all_before('=')

	match parse_arg {
		'h' { usage() }

		'a' { 
			if value == '' { no_value_where_required('-a') }
			else { options.autosave_interval = value.int() }
		}

		'r' { reset_saves() }

		else { 
			match parse_arg.trim_left('-') {
				'help' { usage() }

				'autosave-interval' { 
					if value == '' { no_value_where_required('--autosave-interval') }
					else {
						if value.int() <= 0 { options.autosave_interval = 30 }
						else { options.autosave_interval = value.int() }
					}
				}
				'reset' {
					reset_saves()
				}
				else {
					eprintln('unrecognized option `-$parse_arg`')
					exit(1)
				}
			}
		}
	}
}

fn usage() {
	println(help)
	exit(0)
}

[noreturn]
fn no_value_where_required(option string) {
	eprintln('no value found where one is required!')
	eprintln('need to specify a value at option `$option`')
	exit(1)
}

[noreturn]
fn malformatted_settings() {
	eprintln('could not load the settings file!')
	eprintln('please check for typos')
	exit(1)
}

fn parse_settings() VigOptions {

	mut option := VigOptions{}

	// only run if we have a settings file
	if os.exists(settings) {
		setting := toml.parse_file(settings) or { malformatted_settings() }

		// check if lower
		if setting.value('autosave-interval').int() <= 30 {
			option.autosave_interval = 30
		} else {
			option.autosave_interval = setting.value('autosave-interval').int()
		}
	}

	return option

}
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
	-d(aemonize)=bool        | should the game daemonize? - default: true
'

pub struct VigOptions {
pub mut:
	autosave_interval	int = 30
	daemonize           bool = true
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

		'd' { 
			if value != '' { options.daemonize = value.bool() }
		}

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

				'daemonize' { 
					if value != '' { options.daemonize = value.bool() } 
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
}

[noreturn]
fn no_value_where_required(option string) {
	eprintln('no value found where one is required!')
	eprintln('need to specify a value at option `$option`')
	exit(1)
}

fn parse_settings() VigOptions {

	mut option := VigOptions{}
	setting := toml.parse(settings)

	// check if lower
	if setting.value('autosave-interval') <= 0 {
		option.autosave_interval = 30
	} else {
		option.autosave_interval = setting.value('autosave-interval')
	}

	option.daemonize = setting.value('daemonize')

	return option

}
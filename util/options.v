module util

import os

const help = '
VIG	[option](=value)
	-h(elp)					 | shows this message
	-a(utosave-interval)=int | sets the autosave interval in seconds - default: 30
	-d(aemonize)=bool		 | should the game daemonize? - default: true
'

pub struct VigOptions {
pub mut:
	autosave_interval	int = 30
	daemonize			bool = true
}

pub fn parse_args() VigOptions {

	mut options := VigOptions{}

	if os.args.len > 1 {
		for arg in os.args[1..os.args.len] {
			parse_arg(arg, mut options)
		}
	}

	return options
}

fn parse_arg(arg string, mut options VigOptions) {

	value := arg.all_after('=')
	
	parse_arg := arg.trim_left('-').all_before('=')
	match parse_arg {
		'h' { usage() }
		'help' { usage() }
		'a' { options.autosave_interval = value.int() }
		'autosave-interval' { options.autosave_interval = value.int() }
		'd' { options.daemonize = value.bool() }
		'daemonize' { options.daemonize = value.bool() }
		else { 
			eprintln('unrecognized option `$parse_arg`')
			exit(1)
		}
	}
}

fn usage() {
	println(help)
}
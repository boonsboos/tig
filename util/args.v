module util

import os

struct VigOptions {
pub mut:
	autosave_interval	int = 30
	daemonize			bool = true

}

fn parse_args() {
	if os.args.len > 1 {
		for arg in os.args {
			parse_arg(arg)
		}
	}
}

fn parse_arg(arg string) {
	
}
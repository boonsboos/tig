module game

import term
import time
import readline
import math.big

import util

__global state GameState

fn init() {
	state = GameState{}
}

pub struct GameState {
pub mut:
	credits		big.Integer
	income		big.Integer = big.one_int
	applied_ups []int // ids of applied upgrades
	avail_ups	[]Upgrade
	machines 	Machines
}

pub fn game() {
	util.load_save()

	splash()

	mut reader := readline.Readline{}

	if _ := reader.read_line('press enter to continue') {
		term.clear()
	}
	
	go ticker()
	
	for {
		command := reader.read_line('>|'+term.bright_yellow(' ')) or { exit(0) }
		process_input(command)
	}
	
}

fn ticker() {
	for {
		time.sleep(time.second/2)
		tick()
	}
}

fn tick() {
	// update values
	state.credits = state.credits + (state.income)
	state.avail_ups << get_available_upgrades()
	term.set_terminal_title('tig | ${format_number_string(state.credits)}')

}

fn splash() {
println(' _   _      _
| |_(_)__ _| |
|  _| / _` |_|
 \\__|_\\__, (_)
      |___/
')
}

fn process_input(command string) {
	mut args := command.all_before('\n').split(' ')
	
	match args[0] {
		'help', 'h' {
			usage(.help)
		}
		'exit', 'stop', 'quit' {
			exit(0)
		}
		'bal', 'balance', 'b' {
			print_balance()
		}
		'clear', 'cls' {
			term.clear()
		}
		'machine', 'm' {
			if args.len > 2 {
				process_buy(args[1], args[2].int())
			} else if args.len == 2 {
				display_info(args[1])
			} else {
				display_machines()
			}
		}
		'list', 'l' {
			if args.len < 2 {
				usage(.list)
			} else {
				list(args[1])
			}
		}
		else {
			println(term.bright_red('unknown command: `${args[0]}`'))
		}
	}
}

fn print_balance() {
	println('credits| ' + term.bright_green(
			format_number_string(state.credits)
		)
	)
	term.reset('')
	println('income | ' + term.bright_green(
		format_number_string(state.income)
	) + term.reset('/t') )
}

enum Usage {
	help
	list
}

fn usage(typ Usage) {
	match typ { 
		.help {
			println('there will be a builtin tutorial in the future
for now, refer to the wiki
https://github.com/mrsherobrine/tig/wiki/Tutorial')
			return
		}
		.list {
			println('the list command accepts many arguments')
			println('use it as such: `ls [arg]` or `list [arg]`')
			println('a list of accepted arguments:')
			println('- machine (m)')
			println('- upgrade (u)')
		}
	}
}
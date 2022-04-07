module game

import math.big

fn display_info(machine string) {
	match machine {
		'ls', 'lightswitch' {
			display_ls()
		}
		else { println('not implemented yet') }
	}
}

fn display_ls() {
	mult := state.machines.ls.mult
	amount := state.machines.ls.amount
	income_t := big.integer_from_int(mult) * big.integer_from_int(amount) * ls_income
	println('lightswitches (ls)')
	println('amount | ${amount}')
	println('mult   | ${mult}')
	println('generating $income_t/tick')
}
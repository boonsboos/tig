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
	println('- the click has asmr fans crowding at the door!')
	println('amount | ${amount}')
	println('mult   | ${mult}')
	println('generating $income_t/tick')
}

fn display_pc() {
	mult := state.machines.pc.mult
	amount := state.machines.pc.amount
	income_t := big.integer_from_int(mult) * big.integer_from_int(amount) * pc_income
	println('paperclips (pc)')
	println('- this has to be a reference to something...')
	println('amount | $amount')
	println('mult   | $mult')
	println('generating $income_t/tick')
}
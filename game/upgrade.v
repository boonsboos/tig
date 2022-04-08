module game

import math
import math.big
// NOTE: an upgrade is always at least 10x the base price of the machine

fn upgrade(machine string, amount int) {
	match machine {
		'lightswitch', 'ls' {
			upgrade_ls(amount)
		}
		else { }
	}
}

fn calc_ls_up(amount int) big.Integer {
	return big.integer_from_i64(math.powi(i64(250), i64(state.machines.ls.mult + amount)))
}

fn upgrade_ls(amount int) {
	price := calc_ls_up(amount)
	if (state.credits - price).signum >= 0 {
		state.credits = state.credits - price
		state.machines.ls.mult += amount
		println('paid ${format_number_string(price)}!')
		println('lightswitch multiplier now $state.machines.ls.mult')
	} else {
		println('not enough credits! price: ${format_number_string(price)}')
	}
	
}
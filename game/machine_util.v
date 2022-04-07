module game

import math.big
import term

fn process_buy(machine string, amount int) {
	if amount < 0 { println(term.bright_red('you can not buy 0 machines')) }
	match machine {
		'lightswitch', 'ls' {
			buy_lightswitch(amount)
		}
		else { println(term.bright_red('machine not found!')) }
	}
}

fn buy_lightswitch(amount int) {
	eamount := state.machines.ls.amount
	mult := state.machines.ls.mult

	price := ls_price * big.integer_from_int(((eamount + amount) * 4) / 5)

	if (state.credits - price).signum == 1 {
		println('paid ${format_number_string(price)}')
		state.credits = state.credits - price
		state.income = state.income + (ls_income * big.integer_from_int(mult))
		println(mult)
		println('income: +${ls_income * big.integer_from_int(mult)}')
		state.machines.ls.amount++
	} else {
		println('not enough credits: price is ${format_number_string(price)}')
	}
}
module game

import math.big
import term

// pre = pre-existing amount
// amount = amount that's new
fn calc_lightswitch(pre int, amount int) big.Integer {
	return ls_price +
	(ls_price * big.integer_from_int((pre + amount) * 4 / 5) *
	big.integer_from_int(amount))
}

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

	price := calc_lightswitch(eamount, amount)

	if (state.credits - price).signum == 1 {
		income := ls_income * big.integer_from_int(mult * amount)
		state.credits = state.credits - price
		state.income = state.income + income
		state.machines.ls.amount = eamount + amount
		println('paid $price!')
		println('income increased by $income')
	} else {
		println('not enough credits! price: ${format_number_string(price)}')
	}
}
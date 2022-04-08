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

fn calc_paperclip(pre int, amount int) big.Integer {
	return pc_price +
	(pc_price * big.integer_from_int((pre + amount) * 4 / 5) *
	big.integer_from_int(amount))
}

fn process_buy(machine string, amount int) {
	if amount < 0 { println(term.bright_red('you can not buy 0 machines')) }
	match machine {
		'lightswitch', 'ls' {
			buy_lightswitch(amount)
		}
		'paperclip', 'pc' {
			buy_paperclip(amount)
		}
		else { println(term.bright_red('machine not found!')) }
	}
}

fn buy_lightswitch(amount int) {
	eamount := state.machines.ls.amount
	mult := state.machines.ls.mult

	price := calc_lightswitch(eamount, amount)

	if (state.credits - price).signum >= 0 {
		income := ls_income * big.integer_from_int(mult * amount)
		state.credits = state.credits - price
		state.machines.ls.amount = eamount + amount
		println('paid ${format_number_string(price)}!')
		println('income increased by ${format_number_string(income)}')
	} else {
		println('not enough credits! price: ${format_number_string(price)}')
	}
}

fn buy_paperclip(amount int) {
	eamount := state.machines.pc.amount
	mult := state.machines.pc.mult

	price := calc_paperclip(eamount, amount)

	if (state.credits - price).signum >= 0 {
		income := pc_income * big.integer_from_int(mult * amount)
		state.credits = state.credits - price
		state.machines.pc.amount = eamount + amount
		println('paid ${format_number_string(price)}!')
		println('income increased by ${format_number_string(income)}')
	} else {
		println('not enough credits! price: ${format_number_string(price)}')
	}
}
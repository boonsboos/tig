module game

fn list(arg string) {
	match arg {
		'm', 'machine' {
			list_machines()
		}
		'u', 'upgrade' {
			list_upgrades()
		}
		else { 
			println('no list for `$arg`')
		}
	}
}

fn list_machines() {
	mut ls := ls_price
	if state.machines.ls.amount > 0 {
		ls = calc_lightswitch(state.machines.ls.amount, 1)
	}
	println('lightswitch (ls) | price: ${format_number_string(ls)}')
}

fn list_upgrades() {
	price := calc_ls_up(1)
	println('lightwswitch (ls) | upgrade: ${format_number_string(price)}')
}
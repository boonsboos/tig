module game

import math.big

const all_upgrades = [
	Upgrade(Click_100x{}), Upgrade(Income_10x{})
]

pub fn apply_upgrade(mut up Upgrade) {
	match up.up_type {
		.income { state.income     = state.income     * up.multiplier }
		.click  { state.click_mult = state.click_mult * up.multiplier }
	}

	if (state.credits - up.price).signum != -1 && !state.applied_ups.contains(up.up_id) {
		state.credits = state.credits - up.price
		state.applied_ups << up.up_id // add to applied upgrade
	}
	// else should signal to the UI to show red

}

pub enum UpgradeType {
	income
	click
}

pub interface Upgrade {
	up_id       int
	price	    big.Integer
	multiplier	big.Integer
	up_type     UpgradeType
}

pub struct Click_100x{
	up_id		int = 1
	price		big.Integer = big.integer_from_int(1000)
	multiplier	big.Integer = big.integer_from_int(100)
	up_type		UpgradeType = .click
}

pub struct Income_10x{
	up_id		int = 2
	price		big.Integer = big.integer_from_int(1_000_000)
	multiplier	big.Integer = big.integer_from_int(10)
	up_type		UpgradeType = .income
}
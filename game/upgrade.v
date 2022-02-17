module game

import math.big

const all_upgrades = [ Upgrade(No{}),
	Upgrade(Click_100x{}), Upgrade(Income_10x{})
]

fn is_valid_upgrade(upgrade_id int) bool {
	return all_upgrades[upgrade_id].id == upgrade_id
}

fn is_applied(upgrade_id int) bool {
	return state.applied_ups.contains(upgrade_id)
}

fn apply_upgrade(mut up Upgrade) bool {
	if (state.credits - up.price).signum == 1  && !is_applied(up.id) {
		match up.up_type {
			.income { state.income     = state.income     * up.multiplier }
			.click  { state.click_mult = state.click_mult * up.multiplier }
			else    { /*no op*/ }
		}
		state.credits = state.credits - up.price
		state.applied_ups << up.id // add to applied upgrades
		return true
	} 

	return false
}

pub enum UpgradeType {
	income
	click
	no
}

pub interface Upgrade {
	id          int
	price	    big.Integer
	multiplier	big.Integer
	up_type     UpgradeType
}

pub struct No {
	id          int
	price       big.Integer = big.zero_int
	multiplier  big.Integer = big.one_int
	up_type     UpgradeType = .no
}

pub struct Click_100x {
	id          int = 1
	price		big.Integer = big.integer_from_int(1000)
	multiplier	big.Integer = big.integer_from_int(100)
	up_type		UpgradeType = .click
}

pub struct Income_10x {
	id          int = 2
	price		big.Integer = big.integer_from_int(1_000_000)
	multiplier	big.Integer = big.integer_from_int(10)
	up_type		UpgradeType = .income
}
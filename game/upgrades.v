module game

import math.big

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
	describe    string
}

pub struct No {
	id          int
	price       big.Integer = big.zero_int
	multiplier  big.Integer = big.one_int
	up_type     UpgradeType = .no
	describe    string = 'no'
}

pub struct Click_100x {
	id          int = 1
	price		big.Integer = big.integer_from_int(100)
	multiplier	big.Integer = big.integer_from_int(10)
	up_type		UpgradeType = .click
	describe    string = 'Click Powa x10'
}

pub struct Income_10x {
	id          int = 2
	price		big.Integer = big.integer_from_int(250)
	multiplier	big.Integer = big.integer_from_int(10)
	up_type		UpgradeType = .income
	describe    string = 'Income x10'
}
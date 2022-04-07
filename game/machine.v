module game

import math.big

const (
	ls_price  = big.integer_from_int(25)
	ls_income = big.integer_from_int(1)
)

struct Machines {
pub mut:
	ls Lightswitch
}

interface Machine {
	id     int
	name   string
}

struct Lightswitch {
	id         int = 1
pub mut:
	mult       int = 1
	amount     int
}
module game 

import math.big

fn increment_credits() {
	state.credits.inc()
}

fn format_number_string(number big.Integer) string {

	nr := number.str()
	first_char := nr[0].str()
	first_second := nr[0..2]
	first_third := nr[0..3]

	three_decimals := nr[1..4]
	two_decimals := nr[2..4]
	one_decimal := nr[3].str()

	match nr.len {
		// thousands
		4 { return "${first_char}.${three_decimals}K"}
		5 { return "${first_second}.${two_decimals}K"}
		6 { return "${first_third}.${one_decimal}K" }
		// millions
		7 { return "${first_char}.${three_decimals}M"}
		8 { return "${first_second}.${two_decimals}M"}
		9 { return "${first_third}.${one_decimal}M"}

		else { return nr }
	}
}
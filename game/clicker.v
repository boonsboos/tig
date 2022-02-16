module game 

import math.big

fn increment_credits() {
	state.credits.inc()
}

pub fn format_number_string(number big.Integer) string {

	nr := number.str()

	match nr.len {
		// thousands
		4 { return "${nr[0].ascii_str()}.${nr[1..4]}K"}
		5 { return "${nr[0..2]}.${nr[2..4]}K"}
		6 { return "${nr[0..3]}.${nr[3].ascii_str()}K" }
		// millions
		7 { return "${nr[0].ascii_str()}.${nr[1..4]}M"}
		8 { return "${nr[0..2]}.${nr[2..4]}M"}
		9 { return "${nr[0..3]}.${nr[3].ascii_str()}M"}

		else { return nr }
	}
}